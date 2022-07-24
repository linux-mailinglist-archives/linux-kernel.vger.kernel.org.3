Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41B2C57F5AB
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 17:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231493AbiGXPNo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 11:13:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiGXPNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 11:13:42 -0400
Received: from conssluserg-01.nifty.com (conssluserg-01.nifty.com [210.131.2.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 557FF10FC4
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 08:13:41 -0700 (PDT)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id 26OFD4CH025264
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 00:13:05 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 26OFD4CH025264
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1658675585;
        bh=gCeL/uC8vrvOiVMkkC5A2/Ic1HwmATb3tbQQCUc2eSg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YIkntAExRNM6S82g83iRwfAyhj2L3qH9hse0Yub/NgsYc7OQqWVfaBiYsBlhudPEz
         NJ2xKn+mEBnqRUPrYd/YZguAWc41aVVG8Jkz5+L1LNdNcGg/RVjlSqQRldEeljNcNP
         9XjxXbIpPakAoDj18/pbjleZjNHjVZtLs3/64MXz0xyigSdG53celW1CdwyT9kQntj
         6sQE8pA8SdcMcpeUAnjd7sa+xS2e180Ce/m3OgmQKKLlltkdHj7tS1FTDuhkV+EoxM
         2JGN2yVikDY2HZIniiNIzabuaEcJmPRoXbSDMkXzYAqUdzatiYYgketwna12/b+bC1
         a5L9WO7kFhvZg==
X-Nifty-SrcIP: [209.85.221.53]
Received: by mail-wr1-f53.google.com with SMTP id g2so4606787wru.3
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 08:13:05 -0700 (PDT)
X-Gm-Message-State: AJIora/qqs4Sbu/Ih1fUJt8M2pDDp1HkYPAksixHrCXXtl3t1+muNGbN
        n2UE7sEN/aUOZyRZF9kF9iooySRjw3o/ihXTCQs=
X-Google-Smtp-Source: AGRyM1s+1JhXE5SR/EfF1htAo7ZviLuhLExVfpb+C1O+hsP1zTq9QSDpHWT8egWeeEGndtvuQaIJMyA9LLF78rUonj4=
X-Received: by 2002:a5d:50c4:0:b0:21e:8776:bb95 with SMTP id
 f4-20020a5d50c4000000b0021e8776bb95mr1396769wrt.461.1658675583903; Sun, 24
 Jul 2022 08:13:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220625224037.836581-1-masahiroy@kernel.org>
In-Reply-To: <20220625224037.836581-1-masahiroy@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 25 Jul 2022 00:12:05 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQChsc0uC_ZkxPz5qQ1bZOiK5g_uPhE8K859Ki9LAB=iw@mail.gmail.com>
Message-ID: <CAK7LNAQChsc0uC_ZkxPz5qQ1bZOiK5g_uPhE8K859Ki9LAB=iw@mail.gmail.com>
Subject: Re: [PATCH] powerpc/purgatory: Omit use of bin2c
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 26, 2022 at 7:42 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> The .incbin assembler directive is much faster than bin2c + $(CC).
>
> Do similar refactoring as in commit 4c0f032d4963 ("s390/purgatory:
> Omit use of bin2c").
>
> Please note the .quad directive matches to size_t in C (both 8 byte)
> because the purgatory is compiled only for the 64-bit kernel.
> (KEXEC_FILE depends on PPC64).
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---


Ping?


>  arch/powerpc/Kconfig                     |  1 -
>  arch/powerpc/purgatory/.gitignore        |  1 -
>  arch/powerpc/purgatory/Makefile          |  8 ++------
>  arch/powerpc/purgatory/kexec-purgatory.S | 14 ++++++++++++++
>  scripts/remove-stale-files               |  2 ++
>  5 files changed, 18 insertions(+), 8 deletions(-)
>  create mode 100644 arch/powerpc/purgatory/kexec-purgatory.S
>
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index c2ce2e60c8f0..1cb684ee3519 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -547,7 +547,6 @@ config KEXEC_FILE
>         bool "kexec file based system call"
>         select KEXEC_CORE
>         select HAVE_IMA_KEXEC if IMA
> -       select BUILD_BIN2C
>         select KEXEC_ELF
>         depends on PPC64
>         depends on CRYPTO=y
> diff --git a/arch/powerpc/purgatory/.gitignore b/arch/powerpc/purgatory/.gitignore
> index b8dc6ff34254..5e40575c1f2b 100644
> --- a/arch/powerpc/purgatory/.gitignore
> +++ b/arch/powerpc/purgatory/.gitignore
> @@ -1,3 +1,2 @@
>  # SPDX-License-Identifier: GPL-2.0-only
> -kexec-purgatory.c
>  purgatory.ro
> diff --git a/arch/powerpc/purgatory/Makefile b/arch/powerpc/purgatory/Makefile
> index 348f59581052..a81d155b89ae 100644
> --- a/arch/powerpc/purgatory/Makefile
> +++ b/arch/powerpc/purgatory/Makefile
> @@ -2,17 +2,13 @@
>
>  KASAN_SANITIZE := n
>
> -targets += trampoline_$(BITS).o purgatory.ro kexec-purgatory.c
> +targets += trampoline_$(BITS).o purgatory.ro
>
>  LDFLAGS_purgatory.ro := -e purgatory_start -r --no-undefined
>
>  $(obj)/purgatory.ro: $(obj)/trampoline_$(BITS).o FORCE
>                 $(call if_changed,ld)
>
> -quiet_cmd_bin2c = BIN2C   $@
> -      cmd_bin2c = $(objtree)/scripts/bin2c kexec_purgatory < $< > $@
> -
> -$(obj)/kexec-purgatory.c: $(obj)/purgatory.ro FORCE
> -       $(call if_changed,bin2c)
> +$(obj)/kexec-purgatory.o: $(obj)/purgatory.ro
>
>  obj-y  += kexec-purgatory.o
> diff --git a/arch/powerpc/purgatory/kexec-purgatory.S b/arch/powerpc/purgatory/kexec-purgatory.S
> new file mode 100644
> index 000000000000..4e5f64a0bf4a
> --- /dev/null
> +++ b/arch/powerpc/purgatory/kexec-purgatory.S
> @@ -0,0 +1,14 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +       .section .rodata, "a"
> +
> +       .align  8
> +kexec_purgatory:
> +       .globl  kexec_purgatory
> +       .incbin "arch/powerpc/purgatory/purgatory.ro"
> +.Lkexec_purgatroy_end:
> +
> +       .align  8
> +kexec_purgatory_size:
> +       .globl  kexec_purgatory_size
> +       .quad   .Lkexec_purgatroy_end - kexec_purgatory
> diff --git a/scripts/remove-stale-files b/scripts/remove-stale-files
> index 7adab4618035..5a7543469698 100755
> --- a/scripts/remove-stale-files
> +++ b/scripts/remove-stale-files
> @@ -20,6 +20,8 @@ set -e
>  # yard. Stale files stay in this file for a while (for some release cycles?),
>  # then will be really dead and removed from the code base entirely.
>
> +rm -f arch/powerpc/purgatory/kexec-purgatory.c
> +
>  # These were previously generated source files. When you are building the kernel
>  # with O=, make sure to remove the stale files in the output tree. Otherwise,
>  # the build system wrongly compiles the stale ones.
> --
> 2.32.0
>


-- 
Best Regards
Masahiro Yamada
