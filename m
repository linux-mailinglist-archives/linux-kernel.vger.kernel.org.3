Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38270554BC3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 15:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357543AbiFVNuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 09:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357456AbiFVNuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 09:50:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04D591F623
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 06:50:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B0FB8B81EF0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 13:50:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6588CC34114;
        Wed, 22 Jun 2022 13:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655905818;
        bh=ya9bqHBDJvc1AcWbARdp9qu/ISmbWxRfpR+xvLAIZLs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Zk0iqeknSgIo6vL+FZoYBf3foeVOgFqPWHcUK+jo8KELqfsFT/V1RYIDYaVjMUILe
         QCXkdx5C49M8TRxA+EFJu9Xf3upzGlYRuI07ibHd9nSuP5Q2+vjBHWCOxQ61Pr1x2M
         CohAIgEHJTCz5xKzkoJwacpMOPdvyDPmC6+8GMpVB80c2iqzlDXfk5UV94QVH9l2y0
         muFQrqcC6rIepNuGy3KANVqGdjQ9DEcg9mNovUcytRdKk8GFWonqN4qWdiMfsOXlok
         Cat6tUdy1exaqz7NuJyIx9o35xS87HEV1A6I7HZHxhJ2uRdETmswPv3Xx2ajuBMt9A
         bF8dq8xRVln5A==
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <maz@kernel.org>)
        id 1o40kK-002Jtk-4F;
        Wed, 22 Jun 2022 14:50:16 +0100
MIME-Version: 1.0
Date:   Wed, 22 Jun 2022 14:50:15 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Russell King <linux@armlinux.org.uk>,
        Tony Lindgren <tony@atomide.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] ARM: spectre-v2: fix smp_processor_id() warning
In-Reply-To: <795c9463-452e-bf64-1cc0-c318ccecb1da@I-love.SAKURA.ne.jp>
References: <795c9463-452e-bf64-1cc0-c318ccecb1da@I-love.SAKURA.ne.jp>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <e5bdea6c767d3a8260360afaddab5f7c@kernel.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: penguin-kernel@i-love.sakura.ne.jp, linux@armlinux.org.uk, tony@atomide.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-06-22 07:49, Tetsuo Handa wrote:
> syzbot complains smp_processor_id() from harden_branch_predictor()
>  from page fault path [1]. Explicitly disable preemption and use
> raw_smp_processor_id().
> 
> Link: https://syzkaller.appspot.com/bug?extid=a7ee43e564223f195c84 [1]
> Reported-by: syzbot 
> <syzbot+a7ee43e564223f195c84@syzkaller.appspotmail.com>
> Fixes: f5fe12b1eaee220c ("ARM: spectre-v2: harden user aborts in kernel 
> space")
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> ---
> This patch is completely untested.
> 
>  arch/arm/include/asm/system_misc.h | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/include/asm/system_misc.h
> b/arch/arm/include/asm/system_misc.h
> index 98b37340376b..a92446769acd 100644
> --- a/arch/arm/include/asm/system_misc.h
> +++ b/arch/arm/include/asm/system_misc.h
> @@ -20,8 +20,11 @@ typedef void (*harden_branch_predictor_fn_t)(void);
>  DECLARE_PER_CPU(harden_branch_predictor_fn_t, 
> harden_branch_predictor_fn);
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
>  }

I don't think that's required.

harden_branch_predictor() is always called on the fault path,
from __do_user_fault(), and that's always non-preemptible.

My hunch is that we're missing some tracking that indicates
to the kernel that we're already non-preemptible by virtue
of being in an exception handler.

Russell, what do you think?

         M.
-- 
Jazz is not dead. It just smells funny...
