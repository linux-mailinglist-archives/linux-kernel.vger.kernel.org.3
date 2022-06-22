Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3940A5548EF
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236577AbiFVLXA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 07:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357718AbiFVLWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 07:22:47 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DC283EF16
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 04:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=3PSaIfRzJISZsO0VEI6XQXwgCB4DT0qytDuqsciBimk=; b=uAnOZLdQ0Y1vfpR1o2AfyrXmnS
        Hy6+YWGSkQPXZeiiqK0yHniTAFTDEDImcVW2mAbAVbNoVaX1lDBHZkRG7YGB+l7FaiITvdM5WCEMR
        o5BQRTMk8eEXAqqxJtIcF4sCfyBYFCiqXJwfRXv/ujdtqKw+EsPGfaTkFCgh0ibtDBVHb+Ww+TDC6
        gdmOwZW/CeWkfulvlMEa2XOOHXx22zMaju+XEM+ZP1bAjlVMzTo36P+X8iaiHzCgquFJkJKFvuLld
        /sNs/83k6Ph3VkyvgYfBBinzTCuoQR5r+IjxEAMlLqP9SDO3nfXwpErD81bmvXA7I/r+4MN/sKxW8
        y1iFl7Fw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:32978)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1o3yQB-0003So-Na; Wed, 22 Jun 2022 12:21:19 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1o3yQ8-0007Nl-NU; Wed, 22 Jun 2022 12:21:16 +0100
Date:   Wed, 22 Jun 2022 12:21:16 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Tony Lindgren <tony@atomide.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] ARM: spectre-v2: fix smp_processor_id() warning
Message-ID: <YrL7LIfOqtEJMoTX@shell.armlinux.org.uk>
References: <795c9463-452e-bf64-1cc0-c318ccecb1da@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <795c9463-452e-bf64-1cc0-c318ccecb1da@I-love.SAKURA.ne.jp>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2022 at 03:49:21PM +0900, Tetsuo Handa wrote:
> syzbot complains smp_processor_id() from harden_branch_predictor()
>  from page fault path [1]. Explicitly disable preemption and use
> raw_smp_processor_id().
> 
> Link: https://syzkaller.appspot.com/bug?extid=a7ee43e564223f195c84 [1]
> Reported-by: syzbot <syzbot+a7ee43e564223f195c84@syzkaller.appspotmail.com>
> Fixes: f5fe12b1eaee220c ("ARM: spectre-v2: harden user aborts in kernel space")
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

This may "fix" the warning, but...

> ---
> This patch is completely untested.
> 
>  arch/arm/include/asm/system_misc.h | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/include/asm/system_misc.h b/arch/arm/include/asm/system_misc.h
> index 98b37340376b..a92446769acd 100644
> --- a/arch/arm/include/asm/system_misc.h
> +++ b/arch/arm/include/asm/system_misc.h
> @@ -20,8 +20,11 @@ typedef void (*harden_branch_predictor_fn_t)(void);
>  DECLARE_PER_CPU(harden_branch_predictor_fn_t, harden_branch_predictor_fn);
>  static inline void harden_branch_predictor(void)
>  {
> -	harden_branch_predictor_fn_t fn = per_cpu(harden_branch_predictor_fn,
> -						  smp_processor_id());
> +	harden_branch_predictor_fn_t fn;
> +
> +	preempt_disable_notrace();
> +	fn = per_cpu(harden_branch_predictor_fn, raw_smp_processor_id());
> +	preempt_enable_no_resched_notrace();
>  	if (fn)
>  		fn();

The idea is to get the function for the specific CPU, and then to run it
_on_ that CPU, and in theory the CPU that took the fault. However, I
seem to remember there are issues trying to achieve that, and I don't
have a solution for it.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
