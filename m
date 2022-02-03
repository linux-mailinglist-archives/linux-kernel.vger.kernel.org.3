Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52F0E4A82AA
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 11:48:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232480AbiBCKsC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 05:48:02 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:43501 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233621AbiBCKr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 05:47:59 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1nFZXa-0005RQ-Au; Thu, 03 Feb 2022 11:40:38 +0100
Received: from ore by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1nFZXY-0001jE-BJ; Thu, 03 Feb 2022 11:40:36 +0100
Date:   Thu, 3 Feb 2022 11:40:36 +0100
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     David Lechner <david@lechnology.com>, linux-iio@vger.kernel.org,
        Robin van der Gracht <robin@protonic.nl>,
        David Jander <david@protonic.nl>, linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v1] counter: interrupt-cnt: add counter_push_event()
Message-ID: <20220203104036.GB12695@pengutronix.de>
References: <20211207081602.45b1423c@erd992>
 <20211208135902.7j3aawytt3jlqgwr@pengutronix.de>
 <20211208171035.6ad117af@erd992>
 <Ybmr2kCLScuGZ41h@shinobu>
 <20211215100853.11f9262d@erd992>
 <YcaZEKbzRbX982YW@shinobu>
 <Yfp56WznEMh7rp2O@pengutronix.de>
 <7a22b7c7-e5ac-7574-9d65-179ab605e4ca@lechnology.com>
 <20220203072411.GA12695@pengutronix.de>
 <YfuJXrxpas1ufzp2@shinobu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YfuJXrxpas1ufzp2@shinobu>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 08:54:14 up 54 days, 16:39, 66 users,  load average: 0.15, 0.10,
 0.09
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi William,

On Thu, Feb 03, 2022 at 04:50:54PM +0900, William Breathitt Gray wrote:
> > Hm...
> > 
> > To detect pulse frequency, I need a burst of sequential time-stamps
> > without drops. In case the pulse frequency is higher then the use space
> > is able to get it out of FIFO, we will get high number of drops. 
> > So, we do not need all time stamps. Only bunch of them without drops in
> > the middle.
> > 
> > I know, at some frequency we wont be able to collect all pulses any way.
> > Internal FIFO is just increasing the max detectable frequency. So, it is
> > sort of optimization.
> > 
> > My current driver version has own FIFO which is filled directly by the
> > IRQ handler and user space trigger flush_cb to push all collected
> > time stamps. The main question is: how the flush procedure should be
> > controlled. We have following options:
> > 
> > - Attach it to the read(). The disadvantage: at high frequencies, we
> >   wont be able to get a burst with time stamps without drops in the
> >   middle
> > - Trigger flush from user space. In this case, we make user space a bit
> >   more complicated and cant really get all advantages of poll().
> > - kernel driver is using own timer to trigger flush. The timer can be
> >   configured from user space. The advantage of it, the user space is
> >   simple and has full advantage of using poll()
> > 
> > Regards,
> > Oleksij
> 
> Hi Oleksij,
> 
> Earlier in this thread, Jonathan Cameron suggested using the RCU macros
> to protect access to the events. Taking an RCU approach would eliminate
> the need for spinlocks because the memory barriers are built-in to the
> macros, so I assume flushing would no longer be necessary. Would RCU be
> a viable solution for your needs?

IMO, RCU is the wrong word in this context. It provide an advantage
where we need to reuse/read less frequently changed data. In this use
case we need to move data ASAP, so KFIFO seems to work just fine here.

In any case, after implementi double FIFO and more testing I would
prefer to stay with my initial patch. On a single core system, with have
no waiting time at all. No concurrent access. And on the SMP system
(iMX6Q), currently I can measure higher frequency with initial not
optimized driver:
- with counter_push_event() directly from IRQ: max freq 30-35kHz
- with double FIFO, i have max freq of ~25kHz

Your suggestion was to add COUNTER_EVENT_CHANGE_OF_STATE and use it for
my use case. Correct?

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
