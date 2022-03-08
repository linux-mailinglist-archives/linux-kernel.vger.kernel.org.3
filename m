Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7223B4D22C4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 21:40:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350049AbiCHUk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 15:40:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232840AbiCHUkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 15:40:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BDBF2DD6C
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 12:39:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 43713B81D86
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 20:39:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ED9DC340EB;
        Tue,  8 Mar 2022 20:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646771963;
        bh=RqP5liVnk/qWzaL7Wv4CE8VKRAtghFN6Lq59XHgbRfk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Wcfn9QffotMhYtEgr9sBJpL61ggHFSnJ/WEDaOlDN2+5LEQvOM8MT+gfXz/9hSv9n
         G//n8jLCfg0btjbHrK2BkyR4IohsaLfu27kpW88+1xkEQyxhrgzAzf1tqZ6NlDGE8d
         wcTIPE+3EUfZR+aIUm9UCIJwperEPRGt2guPYxK9xx183cu5WQK8wsmZJmTU2CIVDE
         NxB7mq9NyoI2WzC8r+auQg/5k2IeLemR007xrQnsuKPYcpzffKRm8qYCYv+A2KLptZ
         aFz+77b93e9T8G8Bp9cOilPm6HcGP//PPCPi6+KSzqRm3WwufGl4Ut3AMbMKGyzetP
         yd/DJKVLNxioQ==
Date:   Tue, 8 Mar 2022 13:39:16 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Russell King <rmk+kernel@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: fix compilation error when BPF_SYSCALL is disabled
Message-ID: <Yie+9J0hyA6k2KvD@dev-arch.thelio-3990X>
References: <20220308191820.18270-1-linkmauve@linkmauve.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220308191820.18270-1-linkmauve@linkmauve.fr>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 08, 2022 at 08:18:20PM +0100, Emmanuel Gil Peyrot wrote:
> It was missing a semicolon.
> 
> Fixes build error introduced in
> 25875aa71dfefd1959f07e626c4d285b88b27ac2.
> 
> Signed-off-by: Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>

Our CI just went red from this as well:

https://github.com/ClangBuiltLinux/continuous-integration2/actions/runs/1953090927
https://github.com/ClangBuiltLinux/continuous-integration2/actions/runs/1953124502
https://github.com/ClangBuiltLinux/continuous-integration2/actions/runs/1953090534
https://github.com/ClangBuiltLinux/continuous-integration2/actions/runs/1953086304
https://github.com/ClangBuiltLinux/continuous-integration2/actions/runs/1953050829

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

Linus, would it be possible for you apply this directly?

> ---
>  arch/arm/kernel/spectre.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/kernel/spectre.c b/arch/arm/kernel/spectre.c
> index e7fea962d632..0dcefc36fb7a 100644
> --- a/arch/arm/kernel/spectre.c
> +++ b/arch/arm/kernel/spectre.c
> @@ -10,7 +10,7 @@ static bool _unprivileged_ebpf_enabled(void)
>  #ifdef CONFIG_BPF_SYSCALL
>  	return !sysctl_unprivileged_bpf_disabled;
>  #else
> -	return false
> +	return false;
>  #endif
>  }
>  
> -- 
> 2.35.1
> 
> 
