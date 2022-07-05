Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD4045679CE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 00:00:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbiGEV7z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 17:59:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiGEV7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 17:59:54 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CDA718B21
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 14:59:53 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1o8qaE-0000UQ-EE; Tue, 05 Jul 2022 23:59:50 +0200
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1o8qaC-0006a6-Qd; Tue, 05 Jul 2022 23:59:48 +0200
Date:   Tue, 5 Jul 2022 23:59:48 +0200
From:   Sascha Hauer <sha@pengutronix.de>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Ingo Molnar <mingo@redhat.com>, kernel@pengutronix.de
Subject: Re: Performance impact of CONFIG_FUNCTION_TRACER
Message-ID: <20220705215948.GK5208@pengutronix.de>
References: <20220705105416.GE5208@pengutronix.de>
 <20220705103901.41a70cf0@rorschach.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220705103901.41a70cf0@rorschach.local.home>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
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

On Tue, Jul 05, 2022 at 10:39:01AM -0400, Steven Rostedt wrote:
> On Tue, 5 Jul 2022 12:54:16 +0200
> Sascha Hauer <sha@pengutronix.de> wrote:
> 
> > Hi,
> > 
> > I ran some lmbench subtests on a ARMv7 machine (NXP i.MX6q) with and
> > without CONFIG_FUNCTION_TRACER enabled (with CONFIG_DYNAMIC_FTRACE
> > enabled and no tracing active), see below. The Kconfig help text of this
> > option reads as:
> > 
> > > If it's runtime disabled (the bootup default), then the overhead of
> > > the instructions is very small and not measurable even in
> > > micro-benchmarks.  
> 
> Well, this is true for x86 ;-)

That was my assumption ;)

> 
> > 
> > In my tests the overhead is small, but it surely exists and is
> > measurable at least on ARMv7 machines. Is this expected? Should the help
> > text be rephrased a little less optimistic?
> 
> You mean "(but may vary by architecture)"

Something like that, yes.

> 
> As I believe due to using a link register for function calls, ARM
> requires adding two 4 byte nops to every function where as x86 only
> adds a single 5 byte nop.
> 
> Although nops are very fast (they should not be processed in the CPU's
> pipe line, but I don't know if that's true for every arch). It also
> affects instruction cache misses, as adding 8 bytes around the code
> will cause more cache misses than when they do not exist.

Just digged around a bit and saw that on ARM it's not even a real nop.
The compiler emits:

	push    {lr}
	bl      8010e7c0 <__gnu_mcount_nc>

Which is then turned into a nop by replacing the second instruction with

	add   sp, sp, #4

to bring the stack pointer back to its original value. This indeed must
be processed by the CPU pipeline. I wonder if that could be optimized by
replacing both instructions with a nop. I have no idea though if that's
feasible at all or if the overhead would even get smaller by that.

> 
> Also, there's some configurations that use the old mcount that does add
> some more code to handle the mcount case.
> 
> So if this is just to have us change the kconfig, I'm happy to do that.

Yes, would be good to make the kconfig text clear. The overhead itself
is fine when people know that's the price to pay for getting the
function tracer.

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
