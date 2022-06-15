Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CD9D54D28F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 22:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346608AbiFOUaW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 16:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346524AbiFOUaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 16:30:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9C60532EF;
        Wed, 15 Jun 2022 13:30:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 96684B82178;
        Wed, 15 Jun 2022 20:30:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31C55C3411B;
        Wed, 15 Jun 2022 20:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655325016;
        bh=AnXLp71TuqYK0g6z67fHoakYP3DmxNW4jxisvBDGrhY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=t/UqTHYSQXiQ3eZVd0rez2HL00OtT4f5LEJN6z0aag0h64JYXRj1s6oHM0B1BaYCU
         isMQjs7OEvm8r5KXDsBen/8CsWNrl+PyHGkPyyhdHDinGnMcaoIywlnEjAReYKsLvu
         N3LbF7J6n0DGQlt6zBEuMmRsWz1Snc/6rmWam1dp+SEm86seFWiZBVmeZX7N6WqZLG
         A5ul0nfXV5zDqLz+Wbv5MrGcoxjpS6IP7X3iE7uz+ScZRAsdEKndwyX1iaZc3hhb2j
         /AlhWuL5F+v8heMr7bFVEqT77u8GFVYbD18TGvvIldDzxESWzEC1uF4FhbJebQweu3
         deDJ4QEhh06xQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id D5B7F5C027A; Wed, 15 Jun 2022 13:30:15 -0700 (PDT)
Date:   Wed, 15 Jun 2022 13:30:15 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Frederic Weisbecker <frederic@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Kees Cook <keescook@chromium.org>, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-next@vger.kernel.org
Subject: Re: Contextual conflict between kspp and rcu trees
Message-ID: <20220615203015.GF1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <Yqo5SequJuC2qX6S@dev-arch.thelio-3990X>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yqo5SequJuC2qX6S@dev-arch.thelio-3990X>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 15, 2022 at 12:55:53PM -0700, Nathan Chancellor wrote:
> Hi Stephen et al.,
> 
> There is a contextual conflict between commit e1d337335207 ("cfi: Fix
> __cfi_slowpath_diag RCU usage with cpuidle") in the kspp tree and commit
> dcc0c11aa87b ("rcu/context-tracking: Remove rcu_irq_enter/exit()") in
> the rcu tree, which is visible when building ARCH=arm64 defconfig +
> CONFIG_LTO_CLANG_THIN=y + CONFIG_CFI_CLANG=y with clang:
> 
>   kernel/cfi.c:298:3: error: call to undeclared function 'rcu_irq_enter'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
>                   rcu_irq_enter();
>                   ^
>   kernel/cfi.c:298:3: note: did you mean 'ct_irq_enter'?
>   ./include/linux/context_tracking_irq.h:6:6: note: 'ct_irq_enter' declared here
>   void ct_irq_enter(void);
>        ^
>   kernel/cfi.c:307:3: error: call to undeclared function 'rcu_irq_exit'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
>                   rcu_irq_exit();
>                   ^
>   kernel/cfi.c:307:3: note: did you mean 'ct_irq_exit'?
>   ./include/linux/context_tracking_irq.h:7:6: note: 'ct_irq_exit' declared here
>   void ct_irq_exit(void);
>        ^
>   2 errors generated.
> 
> 
> Per the above RCU commit and commit 6c5218715286 ("context_tracking:
> Take IRQ eqs entrypoints over RCU"), it appears that the following diff
> is the proper fix up. Would you mind applying it to the merge of
> whichever tree comes second if possible? I did build and boot test it
> but it would not be a bad idea for Sami and Frederic to verify that it
> is correct so that Kees/Paul can mention it to Linus :)

Agreed on Frederic verifying it, but in the meantime, it looks good to
me as well.

							Thanx, Paul

> Cheers,
> Nathan
> 
> diff --git a/kernel/cfi.c b/kernel/cfi.c
> index 08102d19ec15..2046276ee234 100644
> --- a/kernel/cfi.c
> +++ b/kernel/cfi.c
> @@ -295,7 +295,7 @@ static inline cfi_check_fn find_check_fn(unsigned long ptr)
>  	rcu_idle = !rcu_is_watching();
>  	if (rcu_idle) {
>  		local_irq_save(flags);
> -		rcu_irq_enter();
> +		ct_irq_enter();
>  	}
>  
>  	if (IS_ENABLED(CONFIG_CFI_CLANG_SHADOW))
> @@ -304,7 +304,7 @@ static inline cfi_check_fn find_check_fn(unsigned long ptr)
>  		fn = find_module_check_fn(ptr);
>  
>  	if (rcu_idle) {
> -		rcu_irq_exit();
> +		ct_irq_exit();
>  		local_irq_restore(flags);
>  	}
>  
