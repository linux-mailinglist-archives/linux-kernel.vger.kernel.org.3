Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D400473A36
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 02:31:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244627AbhLNBb1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 20:31:27 -0500
Received: from conssluserg-01.nifty.com ([210.131.2.80]:52685 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244584AbhLNBbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 20:31:25 -0500
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id 1BE1V1gt014402;
        Tue, 14 Dec 2021 10:31:02 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 1BE1V1gt014402
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1639445462;
        bh=BA+hozWttsM8tsnUju1/2aEcOIMvETD7LE+T7t2SPXY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=esuUTVNJ0kuNEHzHV7y66IIkJbBbECElmaJn0f023zUONCcYao2NCh2Eg5jSMfM9Y
         g2NbFmMVzHSVviDWX9X+FI0FjR8bC2L2bjAyZutcPtesePHXRwetoshyj+aLjOHABj
         C7twxawcmXXl9Y8uCKSXHcK7miTWlM3E7k8T6z+azptsqib4O9gOzy+clfDYlkRnPs
         Eu40os33/FiBh1HKOvi+JiUlLrQMqnxSqbss69h3cwCvwqjXRpkk7HzndbFw5x5oom
         OxNUGunWI5vcs29MPuXSl4MwSF00yqWeMC3rcjeAYpekaCwnYy9xtmF9gp36FVOv+m
         spO7prbn0z/ZA==
X-Nifty-SrcIP: [209.85.214.169]
Received: by mail-pl1-f169.google.com with SMTP id n8so12458441plf.4;
        Mon, 13 Dec 2021 17:31:01 -0800 (PST)
X-Gm-Message-State: AOAM533eM99X43q6UwYsPhxjj33JgmZYJdURodl7KSD0gsekbL6zg5Qa
        3U87THXVYHmio4ZIsLmrM/BNIsmf3d9J5Tuvo18=
X-Google-Smtp-Source: ABdhPJzObfb+Px/FBK5aGrleXwTMeRdIa96UEfxA+A+1m3hQp08NvBGYOjUnfFAQZNBM8149HzTlO/mtqbMWsuorYZc=
X-Received: by 2002:a17:90a:3942:: with SMTP id n2mr2013829pjf.77.1639445460963;
 Mon, 13 Dec 2021 17:31:00 -0800 (PST)
MIME-Version: 1.0
References: <1639389477-17586-1-git-send-email-yangtiezhu@loongson.cn> <1639389477-17586-2-git-send-email-yangtiezhu@loongson.cn>
In-Reply-To: <1639389477-17586-2-git-send-email-yangtiezhu@loongson.cn>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 14 Dec 2021 10:30:24 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQNJv3Z7iM1vjc4vL=JbzBzT7GHq-p+DAkGVV+_bdvNBQ@mail.gmail.com>
Message-ID: <CAK7LNAQNJv3Z7iM1vjc4vL=JbzBzT7GHq-p+DAkGVV+_bdvNBQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] MIPS: SGI-IP22: Remove unnecessary check of GCC option
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Jason Self <jason@bluehome.net>,
        Ryutaroh Matsumoto <ryutaroh@ict.e.titech.ac.jp>,
        Nathan Chancellor <nathan@kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2021 at 6:58 PM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>
> According to the document "Minimal requirements to compile the Kernel [1],


[1] is the kernel document, so you do not need to refer to the URL.

You can say:

 According to Documentation/process/changes.rst, ...



https://www.kernel.org/doc/html/latest is the moving target.
If you get access to this URL some years later, the min GCC
version may not be 5.1



Other than the nit,

Reviewed-by: Masahiro Yamada <masahiroy@kernel.org>




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
>  cflags-$(CONFIG_SGI_IP28)      += -mr10k-cache-barrier=store -I$(srctree)/arch/mips/include/asm/mach-ip28
>  load-$(CONFIG_SGI_IP28)                += 0xa800000020004000
> --
> 2.1.0
>


-- 
Best Regards
Masahiro Yamada
