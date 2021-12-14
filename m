Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDE1B474A6A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 19:07:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236835AbhLNSHG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 13:07:06 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:58382 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbhLNSHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 13:07:04 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 87BF4B81C1D;
        Tue, 14 Dec 2021 18:07:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA269C34600;
        Tue, 14 Dec 2021 18:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639505222;
        bh=snNZ5pvPEda5tFxSouYZVnEaCsqOGiTLHoqkbWDbHoM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UPwdcSIvb+tbW2yjr2HxlxXZphPHU7vJrgigYJHCznVVtc/edMZB5cDk1IahTI5CG
         jVrwdsKkYZ+O05tmiXg5dgdfQXqIE7y07l1HxTfBA2tzQJOdFPsB7W+BSeL1L0JmWk
         AdUSwRABkptmESSmqOYaA9nwH/Fac0oPXUMYVQTLjrNbQl9sskhyqTdOBYo/Q6vXmZ
         HceHa/VSOozj9CLOyBHQ9dIKM9ToTnFhSbTgBKgPf+QHKg6so3MKR7Ldq9rEU84/GJ
         nlK9n8WFvJpeIK3U/yMxrm6RLiSwqk0KhOvR4G29Od4ICajP4/dJiXKXoX6VxnJfcN
         kzI05BRWP2Nnw==
Date:   Tue, 14 Dec 2021 11:06:57 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        list@opendingux.net, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH 1/3] MIPS: boot/compressed: Disable abicalls
Message-ID: <YbjdQfrC+EjeJjRV@archlinux-ax161>
References: <20211213224914.1501303-1-paul@crapouillou.net>
 <20211213224914.1501303-2-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211213224914.1501303-2-paul@crapouillou.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2021 at 10:49:12PM +0000, Paul Cercueil wrote:
> Avoid complaints from Clang/LLVM by building the decompress program with
> -mno-abicalls.

What is the message?

> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  arch/mips/boot/compressed/Makefile | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/mips/boot/compressed/Makefile b/arch/mips/boot/compressed/Makefile
> index f27cf31b4140..4c9ecfbb0ef4 100644
> --- a/arch/mips/boot/compressed/Makefile
> +++ b/arch/mips/boot/compressed/Makefile
> @@ -27,10 +27,10 @@ ifdef CONFIG_CPU_LOONGSON64
>  KBUILD_CFLAGS := $(filter-out -march=loongson3a, $(KBUILD_CFLAGS)) -march=mips64r2
>  endif
>  
> -KBUILD_CFLAGS := $(KBUILD_CFLAGS) -D__KERNEL__ -D__DISABLE_EXPORTS \
> +KBUILD_CFLAGS := $(KBUILD_CFLAGS) -mno-abicalls -D__KERNEL__ -D__DISABLE_EXPORTS \
>  	-DBOOT_HEAP_SIZE=$(BOOT_HEAP_SIZE) -D"VMLINUX_LOAD_ADDRESS_ULL=$(VMLINUX_LOAD_ADDRESS)ull"
>  
> -KBUILD_AFLAGS := $(KBUILD_AFLAGS) -D__ASSEMBLY__ \
> +KBUILD_AFLAGS := $(KBUILD_AFLAGS) -mno-abicalls -D__ASSEMBLY__ \
>  	-DBOOT_HEAP_SIZE=$(BOOT_HEAP_SIZE) \
>  	-DKERNEL_ENTRY=$(VMLINUX_ENTRY_ADDRESS)
>  
> -- 
> 2.33.0
> 
> 
