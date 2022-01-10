Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF3F4890A1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 08:20:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239193AbiAJHTy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 02:19:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239183AbiAJHTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 02:19:52 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 457F2C06173F
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jan 2022 23:19:52 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1n6oy1-0003iZ-RM; Mon, 10 Jan 2022 08:19:45 +0100
Received: from ore by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1n6oy1-00022Z-Ab; Mon, 10 Jan 2022 08:19:45 +0100
Date:   Mon, 10 Jan 2022 08:19:45 +0100
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     devicetree@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org,
        Robin van der Gracht <robin@protonic.nl>,
        linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>
Subject: Re: [PATCH v1 1/1] iio: adc: tsc2046: fix memory corruption by
 preventing array overflow
Message-ID: <20220110071945.GB3326@pengutronix.de>
References: <20220107081401.2816357-1-o.rempel@pengutronix.de>
 <20220109152557.74f06d2d@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220109152557.74f06d2d@jic23-huawei>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 08:05:41 up 30 days, 15:51, 44 users,  load average: 0.25, 0.45,
 0.31
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

On Sun, Jan 09, 2022 at 03:25:57PM +0000, Jonathan Cameron wrote:
> On Fri,  7 Jan 2022 09:14:01 +0100
> Oleksij Rempel <o.rempel@pengutronix.de> wrote:
> 
> > On one side we have indio_dev->num_channels includes all physical channels +
> > timestamp channel. On other side we have an array allocated only for
> > physical channels. So, fix memory corruption by ARRAY_SIZE() instead of
> > num_channels variable.
> > 
> > Fixes: 9374e8f5a38d ("iio: adc: add ADC driver for the TI TSC2046 controller")
> > Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> Hi Olesij,
> 
> Have you managed to make this occur, or is it inspection only?

Yes, this bug has eaten my rx_one and tx_one pointers on probe. I wonted
to use this buffers for read_raw and noticed that they do not exist.

> I 'think' (it's been a while since I looked at the particular code) that the timestamp
> bit in active_scan_mask will never actually be set because we handle that as a
> separate flag.

I didn't tested if active_scan_mask will trigger this issue as well, but
It it looked safer to me, to avoid this issue in both places. Even if on
of it is only theoretical.

> So it is indeed an efficiency improvement to not check that bit but I don't think
> it's a bug to do so.  More than possible I'm missing something though!
> 
> This one had me quite worried when I first read it because this is a very common
> pattern to see in IIO drivers.

I was thinking about this as well, because big part of this code was
inspired by other drivers. But i didn't reviewed other places so far.

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
