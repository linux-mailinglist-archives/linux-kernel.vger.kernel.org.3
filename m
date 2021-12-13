Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9949F4732BD
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 18:12:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240831AbhLMRMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 12:12:45 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:55436 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237154AbhLMRMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 12:12:43 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 298C561197;
        Mon, 13 Dec 2021 17:12:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E121EC34602;
        Mon, 13 Dec 2021 17:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639415562;
        bh=0TirORvX6GJYnw6fK6AeEPLUnTxj0+PAqKmWHCHAtG0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y+lOPxri0aTH0rk3N4uF2UK9iW3F2Mx8HIiAz3sLSgauy6fCM0lNtN60jWvp9IysG
         99IiIGdm2/QoTdJMwKUHEBCYXonyWxg+wSmJaoFGKB0IrOq+9jNlJ76tcuG6G1EDgA
         qecpvEnEVXZNmcGZvv7ij634SXp7uO89YhcI/xD4C4eHgAwrLsbmZtOL8YuKFxYoxv
         s4TxoZPXMUzyY0h5cWnZCGvR/KiXJRcTs0EZlyf77CdlL0rq3lK93PVrvT487YBmCZ
         DsQ2V89NUwlurgcox/BKEYwtE51sK2JOEj9MxLzv8oh6NPAcrCskR0vskZk1IRQwRV
         lGQm5VFceB7lw==
Date:   Mon, 13 Dec 2021 10:12:38 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Jason Self <jason@bluehome.net>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Ryutaroh Matsumoto <ryutaroh@ict.e.titech.ac.jp>,
        Xuefeng Li <lixuefeng@loongson.cn>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] MIPS: SGI-IP22: Remove unnecessary check of GCC
 option
Message-ID: <Ybd/BuxbaeOpzyTU@archlinux-ax161>
References: <1639389477-17586-1-git-send-email-yangtiezhu@loongson.cn>
 <1639389477-17586-2-git-send-email-yangtiezhu@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1639389477-17586-2-git-send-email-yangtiezhu@loongson.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2021 at 05:57:56PM +0800, Tiezhu Yang wrote:
> According to the document "Minimal requirements to compile the Kernel [1],
> the minimal version of GCC is 5.1, -mr10k-cache-barrier=store is supported
> with GCC 5.1 [2], so just remove the unnecessary check to fix the build
> error [3]:
> 
>   arch/mips/sgi-ip22/Platform:28: *** gcc doesn't support needed option -mr10k-cache-barrier=store.  Stop.
> 
> [1] https://www.kernel.org/doc/html/latest/process/changes.html
> [2] https://gcc.gnu.org/onlinedocs/gcc-5.1.0/gcc/MIPS-Options.html
> [3] https://github.com/ClangBuiltLinux/linux/issues/1543
> 
> Reported-by: Ryutaroh Matsumoto <ryutaroh@ict.e.titech.ac.jp>
> Suggested-by: Nathan Chancellor <nathan@kernel.org>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>

Thanks for sending this!

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
>  arch/mips/sgi-ip22/Platform | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/arch/mips/sgi-ip22/Platform b/arch/mips/sgi-ip22/Platform
> index 62fa30b..a4c46e3 100644
> --- a/arch/mips/sgi-ip22/Platform
> +++ b/arch/mips/sgi-ip22/Platform
> @@ -23,10 +23,5 @@ endif
>  # be 16kb aligned or the handling of the current variable will break.
>  # Simplified: what IP22 does at 128MB+ in ksegN, IP28 does at 512MB+ in xkphys
>  #
> -ifdef CONFIG_SGI_IP28
> -  ifeq ($(call cc-option-yn,-march=r10000 -mr10k-cache-barrier=store), n)
> -      $(error gcc doesn't support needed option -mr10k-cache-barrier=store)
> -  endif
> -endif
>  cflags-$(CONFIG_SGI_IP28)	+= -mr10k-cache-barrier=store -I$(srctree)/arch/mips/include/asm/mach-ip28
>  load-$(CONFIG_SGI_IP28)		+= 0xa800000020004000
> -- 
> 2.1.0
> 
