Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C15B3474C32
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 20:43:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237492AbhLNTnm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 14:43:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232335AbhLNTnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 14:43:42 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A220C061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 11:43:41 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id c32so38961445lfv.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 11:43:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/WNtdOExba0UareLlKons7fVsJWCyGRdBiOkJewabLU=;
        b=qP9k2WtsLwhadv7Z98sXBcbuVgdLVZLF1yEoSBINi3s2x/zcZdiBiWTBshsR0ZCvHp
         sWf3vM7oxiubP1xPpjtywPgHffA5ufiabkRBoqEB8MAQHzYqxCuCSg2zOvnsFrvPQqaY
         yz1bSnDT9cBMlgT4wqhZ0CwoWxu1C11xIoXk1/KmX8xHN6hKV9RJ7i7VI2b3Of6PneW9
         5FiwZmfjQZvJ5aX2o/r1fV9SMdFFFBAZqJB/c7pk1yBSC85m69rttz0tbIgeCM9rGen4
         gwWRLYlf4F5c+AGEuxRNnNT5HNgHtZ3Mnjxz9JzmwtxrzR9PrNH8d7XMvIkvpIZJKWyB
         F/iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/WNtdOExba0UareLlKons7fVsJWCyGRdBiOkJewabLU=;
        b=bC+RI1iUnbMEsk857ifYxOKqMu8CzgfWjlSdA2gj5PiyEOx4iSrFUu4D087UCuQ3pp
         MPCGkO3HZ9BVdJpKGdy50SardtmrXSu2fjedqNAUYLqAgoYIzY3a+ODRAiLEi5FJADn3
         VSTfMG8XD4ewcYgzB3njp7ORKCz4CRLie4rTiw8xS5RCsLgopMEzxMYfeUFzU6Hi3awT
         tknZt2Ek8UPne/x0sf6lmxq0jbIXAQ7BHNAqhv9AXQQvUsbsgVXNfmsr8o//xabH4WLF
         QbyXESX/DxAvVgeTp+im1mhZVcvhL2iL8eIy19jgFHiCGHZmmi5gdzSaU4KCPI785rKq
         gfnA==
X-Gm-Message-State: AOAM533U8iPXsqr8dNflGYhihyGitLIz4XynLB1ci80Nm71GgHRG9wO4
        JkxO/+P2VXs1BSFo5hkHmnWwc45kNOErh2fH9BGEdw==
X-Google-Smtp-Source: ABdhPJynoNYKno0o5Fc6TQq4M/7CoCk7fH7s/cK99AIXq3P6Mr1V2cvRGwyXL+wfaPmWTd+SLmaQp7RNHm0IJSN51FY=
X-Received: by 2002:a05:6512:b1f:: with SMTP id w31mr6648969lfu.240.1639511019704;
 Tue, 14 Dec 2021 11:43:39 -0800 (PST)
MIME-Version: 1.0
References: <20211213224914.1501303-1-paul@crapouillou.net> <20211213224914.1501303-3-paul@crapouillou.net>
In-Reply-To: <20211213224914.1501303-3-paul@crapouillou.net>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 14 Dec 2021 11:43:28 -0800
Message-ID: <CAKwvOdm3x7pot9+DgujUrO795ip_nxd_LGtoAuePRzc=td90jQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] MIPS: boot/compressed: Build without LTO
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Nathan Chancellor <nathan@kernel.org>, list@opendingux.net,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2021 at 2:49 PM Paul Cercueil <paul@crapouillou.net> wrote:
>
> We need a valid ELF object for dummy.o, so that objcopy can insert the
> vmlinuz payload.
>
> Therefore, we must build the decompresser program without LTO, otherwise
> dummy.o will be LLVM bytecode instead of a ELF object file.

While the below may work and follows the pattern observed in
drivers/firmware/efi/libstub/Makefile
43:KBUILD_CFLAGS := $(filter-out $(CC_FLAGS_LTO), $(KBUILD_CFLAGS))

I can't help but wonder whether we should instead be doing something like:
arch/x86/power/Makefile
9:CFLAGS_REMOVE_cpu.o := $(CC_FLAGS_LTO)
scripts/mod/Makefile
3:CFLAGS_REMOVE_empty.o += $(CC_FLAGS_LTO)
drivers/misc/lkdtm/Makefile
19:CFLAGS_REMOVE_rodata.o               += $(CC_FLAGS_LTO)

but for dummy.o?  ie.
CFLAGS_REMOVE_dummy.o += $(CC_FLAGS_LTO)

Can you please try that rather than disabling LTO for a large subset of files?

>
> Building the decompresser with LTO wouldn't make much sense anyway,
> unlike building the vmlinuz itself with LTO.

Why not? We do it for x86 and arm64 AFAICT.

>
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  arch/mips/boot/compressed/Makefile | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/arch/mips/boot/compressed/Makefile b/arch/mips/boot/compressed/Makefile
> index 4c9ecfbb0ef4..2d01c50fb0b1 100644
> --- a/arch/mips/boot/compressed/Makefile
> +++ b/arch/mips/boot/compressed/Makefile
> @@ -27,6 +27,9 @@ ifdef CONFIG_CPU_LOONGSON64
>  KBUILD_CFLAGS := $(filter-out -march=loongson3a, $(KBUILD_CFLAGS)) -march=mips64r2
>  endif
>
> +# Disable LTO
> +KBUILD_CFLAGS := $(filter-out $(CC_FLAGS_LTO), $(KBUILD_CFLAGS))
> +
>  KBUILD_CFLAGS := $(KBUILD_CFLAGS) -mno-abicalls -D__KERNEL__ -D__DISABLE_EXPORTS \
>         -DBOOT_HEAP_SIZE=$(BOOT_HEAP_SIZE) -D"VMLINUX_LOAD_ADDRESS_ULL=$(VMLINUX_LOAD_ADDRESS)ull"
>
> --
> 2.33.0
>


-- 
Thanks,
~Nick Desaulniers
