Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0187B58E4DE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 04:32:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbiHJCcK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 22:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbiHJCcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 22:32:07 -0400
Received: from conssluserg-03.nifty.com (conssluserg-03.nifty.com [210.131.2.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F40180527;
        Tue,  9 Aug 2022 19:32:05 -0700 (PDT)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 27A2Veod011231;
        Wed, 10 Aug 2022 11:31:41 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 27A2Veod011231
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1660098701;
        bh=yrbM3fqdLcdvVoRNsOshCKuu2cmcDKYRxpKKmK+Zsn8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=p97mxZw3YH8GA3MWjuhmnOUgNd96ux7nAGxiuBuyqhxR2lcacH1vdmQnYuMDfUZO6
         YvWN9z3KZxVi2LaPRAfVGeayZJaQxRlkBSJYvv9CD88gXEvB5UGVAO/8zGhNO/LmUB
         WCpwCI6TKe8JN+AguVr/fVa8njIDlm6ilnXXkiaQLxY93oi89A9noSxisZcYySamU4
         lyLphdCaLWBX4GiIfrwGmu+WSjIwAQgkDw5JnSPKVTSR7p3ukp6Wvt34H0Mu7q0uWw
         wlJU397OrTOyCs9KRU9elHD70mmCP2SSZfEOQNhSSruhhboZlHd9Pqsg4+jj5W696H
         +tGD4tjh7fjnA==
X-Nifty-SrcIP: [209.85.221.41]
Received: by mail-wr1-f41.google.com with SMTP id z12so16198632wrs.9;
        Tue, 09 Aug 2022 19:31:41 -0700 (PDT)
X-Gm-Message-State: ACgBeo2upSqk+No+6HmAcorlfMa0DdgEUbfnIzIuknFV7SoGEpf6fhyx
        wU/Lbg+jYIFiI3671Sx1qT7ulaKmIHRMo3j/tNc=
X-Google-Smtp-Source: AA6agR4UxFVhh6aOe1R+WXs04HYtWBTtC0yGWyS7IDywfOX+Ril/cin6OVxNJu31cubloXVv8Pogry7z2pWPplNLNxs=
X-Received: by 2002:a05:6000:1f83:b0:223:60ee:6c08 with SMTP id
 bw3-20020a0560001f8300b0022360ee6c08mr5161760wrb.682.1660098699802; Tue, 09
 Aug 2022 19:31:39 -0700 (PDT)
MIME-Version: 1.0
References: <YvLmPl8sgR2q3WgE@ZenIV>
In-Reply-To: <YvLmPl8sgR2q3WgE@ZenIV>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 10 Aug 2022 11:31:00 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS7R2JzD52s0MW2SWb0gwALYoy_ngqrLdnBAOwCB-txrg@mail.gmail.com>
Message-ID: <CAK7LNAS7R2JzD52s0MW2SWb0gwALYoy_ngqrLdnBAOwCB-txrg@mail.gmail.com>
Subject: Re: [kconfig][RFC] getting things like CONFIG_ARCH_HAS_SYSCALL_WRAPPER
 without bothering with selects
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 10, 2022 at 7:57 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
>         Sometimes we have situations when we want linux/foo.h
> include asm/bar.h if the latter exists; one example is
> includes of asm/syscall_wrapper.h.  Right now there are two
> ways to do that:
>         1) ARCH_HAS_BAR_H, explicitly selected by architectures
> that have asm/bar.h and include guarded by #ifdef CONFIG_ARCH_HAS_BAR_H
>         2) include/asm-default/bar.h, either empty or with
> something like #define __ARCH_HAS_NO_BAR_H, with mandatory-y += bar.h
> in include/asm-generic/Kbuild and unconditional includes of asm/bar.h,
> possibly followed by #ifdef __ARCH_HAS_NO_BAR_H ... #endif
>
> However, kconfig could do (1) without selects - something like
> bool ARCH_HAS_BAR_H
>         def_bool $(header-exists,bar.h)
>
> Does anybody see problems with the patch below?




A problem is that Kconfig does not react to addition/removal
of asm/syscall_wrapper.h


For example, with the patch applied,
touch or rm arch/arm/include/asm/syscall_wrapper.h
and rebuild the arm kernel.


$ touch   arch/arm/include/asm/syscall_wrapper.h
$ make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf-  -j8
  CALL    scripts/atomic/check-atomics.sh
  CALL    scripts/checksyscalls.sh
  CHK     include/generated/compile.h
  Kernel: arch/arm/boot/Image is ready
  Kernel: arch/arm/boot/zImage is ready
$ rm     arch/arm/include/asm/syscall_wrapper.h
$ make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf-  -j8
  CALL    scripts/atomic/check-atomics.sh
  CALL    scripts/checksyscalls.sh
  CHK     include/generated/compile.h
  Kernel: arch/arm/boot/Image is ready
  Kernel: arch/arm/boot/zImage is ready


When the header is added or removed, the kernel must be
rebuilt with CONFIG_ARCH_HAS_SYSCALL_WRAPPER updated,
but Kconfig is actually not invoked at all.


The condition for triggering Kconfig is
generated in include/config/auto.conf.cmd
but I do not know how to handle this case correctly.




I think it is better to not have Kconfig think too much.
We do several compiler tests in Kconfig, but
that is because otherwise we cannot know
users' build environments.

We know everything in the source tree.
"test -e arch/$(ARCH)/include/asm/syscall_wrapper.h"
does not seem sensible to me.



Masahiro Yamada








>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 1652a9800ebe..277437f329ce 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -42,7 +42,6 @@ config ARM64
>         select ARCH_HAS_STRICT_MODULE_RWX
>         select ARCH_HAS_SYNC_DMA_FOR_DEVICE
>         select ARCH_HAS_SYNC_DMA_FOR_CPU
> -       select ARCH_HAS_SYSCALL_WRAPPER
>         select ARCH_HAS_TEARDOWN_DMA_OPS if IOMMU_SUPPORT
>         select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
>         select ARCH_HAS_VM_GET_PAGE_PROT
> diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
> index 91c0b80a8bf0..86e905b8462c 100644
> --- a/arch/s390/Kconfig
> +++ b/arch/s390/Kconfig
> @@ -78,7 +78,6 @@ config S390
>         select ARCH_HAS_SET_MEMORY
>         select ARCH_HAS_STRICT_KERNEL_RWX
>         select ARCH_HAS_STRICT_MODULE_RWX
> -       select ARCH_HAS_SYSCALL_WRAPPER
>         select ARCH_HAS_UBSAN_SANITIZE_ALL
>         select ARCH_HAS_VDSO_DATA
>         select ARCH_HAVE_NMI_SAFE_CMPXCHG
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index be0b95e51df6..64592d027a0d 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -92,7 +92,6 @@ config X86
>         select ARCH_HAS_STRICT_KERNEL_RWX
>         select ARCH_HAS_STRICT_MODULE_RWX
>         select ARCH_HAS_SYNC_CORE_BEFORE_USERMODE
> -       select ARCH_HAS_SYSCALL_WRAPPER
>         select ARCH_HAS_UBSAN_SANITIZE_ALL
>         select ARCH_HAS_VM_GET_PAGE_PROT
>         select ARCH_HAS_DEBUG_WX
> diff --git a/init/Kconfig b/init/Kconfig
> index c7900e8975f1..ce88397c4e46 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -2257,4 +2257,4 @@ config ARCH_HAS_SYNC_CORE_BEFORE_USERMODE
>  # kernel/time/posix-stubs.c. All these overrides need to be available in
>  # <asm/syscall_wrapper.h>.
>  config ARCH_HAS_SYSCALL_WRAPPER
> -       def_bool n
> +       def_bool $(header-exists,syscall_wrapper.h)
> diff --git a/scripts/Kconfig.include b/scripts/Kconfig.include
> index 0496efd6e117..465bb836f82a 100644
> --- a/scripts/Kconfig.include
> +++ b/scripts/Kconfig.include
> @@ -23,6 +23,10 @@ success = $(if-success,$(1),y,n)
>  # Return n if <command> exits with 0, y otherwise
>  failure = $(if-success,$(1),n,y)
>
> +# $(header-exists,<header>)
> +# Return y if arch/$(ARCH)/include/asm/<header> exists, n otherwise
> +header-exists = $(success,test -e $(srctree)/arch/$(ARCH)/include/asm/$(1))
> +
>  # $(cc-option,<flag>)
>  # Return y if the compiler supports <flag>, n otherwise
>  cc-option = $(success,mkdir .tmp_$$$$; trap "rm -rf .tmp_$$$$" EXIT; $(CC) -Werror $(CLANG_FLAGS) $(1) -c -x c /dev/null -o .tmp_$$$$/tmp.o)



-- 
Best Regards
Masahiro Yamada
