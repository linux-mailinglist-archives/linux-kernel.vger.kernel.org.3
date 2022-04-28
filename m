Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65BD8513403
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 14:43:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346408AbiD1Mpz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 08:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346478AbiD1Mps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 08:45:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C811AB0D0E
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 05:42:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 58918B82CEB
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 12:42:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FFB2C385A0;
        Thu, 28 Apr 2022 12:42:24 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="hZmprpak"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1651149742;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2K05YkZhpOuMhgr/oncdSXk/GQQMhwmWcgULc5ceX9k=;
        b=hZmprpak9Ywzz2wdBB6rNoLcdPOidG7yeoMlWxICXLsXO1SjNXFzJDPB8cawTsGS7t+V68
        1NQ+l/BryRStpTiKym34Y3Xh6DP6sdoiDwE5n4I/sTftqrLWXDAdUGI/gd30LxXeIk+bV4
        I0RzJy/xurTIn7WcuHcad4veUIXwh9k=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id d25154e0 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Thu, 28 Apr 2022 12:42:21 +0000 (UTC)
Date:   Thu, 28 Apr 2022 14:42:20 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Stafford Horne <shorne@gmail.com>
Cc:     openrisc@lists.librecores.org, linux-kernel@vger.kernel.org,
        Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] openrisc: define nop command for simulator reboot
Message-ID: <YmqLrDfbEGP659EO@zx2c4.com>
References: <20220428111139.1330966-1-Jason@zx2c4.com>
 <YmqAx31dtXCaNn7R@antec>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YmqAx31dtXCaNn7R@antec>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2022 at 08:55:51PM +0900, Stafford Horne wrote:
> On Thu, Apr 28, 2022 at 01:11:39PM +0200, Jason A. Donenfeld wrote:
> > The simulator defines `l.nop 1` for shutdown, but doesn't have anything
> > for reboot. Use 13 for this, which is currently unused, dubbed
> > `NOP_REBOOT`.
> > 
> > Cc: Stafford Horne <shorne@gmail.com>
> > Cc: Peter Maydell <peter.maydell@linaro.org>
> > Link: https://lore.kernel.org/all/YmnaDUpVI5ihgvg6@zx2c4.com/
> > Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> > ---
> >  arch/openrisc/kernel/process.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/arch/openrisc/kernel/process.c b/arch/openrisc/kernel/process.c
> > index 3c0c91bcdcba..4cce95fa6eb5 100644
> > --- a/arch/openrisc/kernel/process.c
> > +++ b/arch/openrisc/kernel/process.c
> > @@ -52,6 +52,8 @@ void machine_restart(char *cmd)
> >  {
> >  	do_kernel_restart(cmd);
> >  
> > +	__asm__("l.nop 13");
> > +
> >  	/* Give a grace period for failure to restart of 1s */
> >  	mdelay(1000);
> >  
> > -- 
> > 2.35.1
> 
> This seems fair, probably it would be good to have a comment mentioninmg what
> the nop is for, fyi for context these are the nop numbers used to control
> simulations.
> 
>     #define NOP_NOP          0x0000      /* Normal nop instruction */
>     #define NOP_EXIT         0x0001      /* End of simulation */
>     #define NOP_REPORT       0x0002      /* Simple report */
>     /*#define NOP_PRINTF       0x0003       Simprintf instruction (obsolete)*/
>     #define NOP_PUTC         0x0004      /* JPB: Simputc instruction */
>     #define NOP_CNT_RESET    0x0005      /* Reset statistics counters */
>     #define NOP_GET_TICKS    0x0006      /* JPB: Get # ticks running */
>     #define NOP_GET_PS       0x0007      /* JPB: Get picosecs/cycle */
>     #define NOP_TRACE_ON     0x0008      /* Turn on tracing */
>     #define NOP_TRACE_OFF    0x0009      /* Turn off tracing */
>     #define NOP_RANDOM       0x000a      /* Return 4 random bytes */
>     #define NOP_OR1KSIM      0x000b      /* Return non-zero if this is Or1ksim */
>     #define NOP_EXIT_SILENT  0x000c      /* End of simulation, quiet version */
>     /* New! */
>     #define NOP_RESET        0x000d      /* Reset the cpu */

Right, that's where I got 13 from. By the way, the .tex file only
mentions ones up to 11, so at first I chose 12, and then saw this file.

> 
> I will queue this once we update the spec to define some of these, I am thinking
> if qemu should allow for the shutdown to work in user mode.
> 
> BTW, are you working specifically on openrisc? Or just setting up test
> environments for all architectures?

Trying to get OpenRISC up on https://build.wireguard.com/ . The other
architectures were simple, but OpenRISC is requiring some work...

Jason
