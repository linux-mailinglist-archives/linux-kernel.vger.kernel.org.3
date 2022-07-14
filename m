Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 668015747DB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 11:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232087AbiGNJKd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 05:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbiGNJKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 05:10:31 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 241321EEC4
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 02:10:30 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1oBurc-00017G-F1; Thu, 14 Jul 2022 11:10:28 +0200
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1oBura-0007zV-O5; Thu, 14 Jul 2022 11:10:26 +0200
Date:   Thu, 14 Jul 2022 11:10:26 +0200
From:   Sascha Hauer <sha@pengutronix.de>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Ingo Molnar <mingo@redhat.com>, kernel@pengutronix.de
Subject: Re: Performance impact of CONFIG_FUNCTION_TRACER
Message-ID: <20220714091026.GM2387@pengutronix.de>
References: <20220705105416.GE5208@pengutronix.de>
 <20220705103901.41a70cf0@rorschach.local.home>
 <20220705215948.GK5208@pengutronix.de>
 <20220705182746.4ce53681@rorschach.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220705182746.4ce53681@rorschach.local.home>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 11:06:53 up 105 days, 21:36, 81 users,  load average: 0.15, 0.38,
 0.40
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 05, 2022 at 06:27:46PM -0400, Steven Rostedt wrote:
> On Tue, 5 Jul 2022 23:59:48 +0200
> Sascha Hauer <sha@pengutronix.de> wrote:
> 
> > > 
> > > As I believe due to using a link register for function calls, ARM
> > > requires adding two 4 byte nops to every function where as x86 only
> > > adds a single 5 byte nop.
> > > 
> > > Although nops are very fast (they should not be processed in the CPU's
> > > pipe line, but I don't know if that's true for every arch). It also
> > > affects instruction cache misses, as adding 8 bytes around the code
> > > will cause more cache misses than when they do not exist.  
> > 
> > Just digged around a bit and saw that on ARM it's not even a real nop.
> > The compiler emits:
> > 
> > 	push    {lr}
> > 	bl      8010e7c0 <__gnu_mcount_nc>
> > 
> > Which is then turned into a nop by replacing the second instruction with
> > 
> > 	add   sp, sp, #4
> > 
> > to bring the stack pointer back to its original value. This indeed must
> > be processed by the CPU pipeline. I wonder if that could be optimized by
> > replacing both instructions with a nop. I have no idea though if that's
> > feasible at all or if the overhead would even get smaller by that.
> 
> The problem is that there's no easy way to do that, because a task
> could have been preempted after doing the 'push {lr}' and before the
> 'bl'. Thus, you create a race by changing either one to a nop first.
> 
> I wonder if it would have been better to change the first one to a jump
> passed the second :-/

I gave this a try, but the performance was not better compared to the
stack push/pop operations we have now. I also tried to replace both
instructions with nops (mov r0, r0), still no better performance. I
guess we have to live with it then.

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
