Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8F40499F16
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 00:15:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1839913AbiAXWwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 17:52:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1572945AbiAXVmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 16:42:52 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14DB7C0419EC
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 12:31:45 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id x7so52373676lfu.8
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 12:31:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+d4eE8vTSmnTfcsF06A9ijaErxq3MGUA0JFQlf6Ufdo=;
        b=iGTTMnQUe6uCwdHf5Y3Mp1+38vh4KuCC/+c8hZNfhXimk0D0Ayh2BU70jO35jFEpcK
         cOCeEvEQ/Iraq9AGogYQpDBg9mbz93t+A86PMxJjW/CWDucXsgesD2+Tv37M9X6yB42r
         oPQ/Wbltm6WTxGzZ4T8pnqtIReASplBaKYxk/kaH4hF4UeEYZN0/G79oE7sRD7//rrfd
         ixrXNgbKQmnOKvkmf+amiE4RxQeQY1LgUmnSGznOHsOKgzquLg03V1MyNBpe0Z1F4JSV
         m1ayHjlKDHflrMB6jVZ4FApQ7CpB0So9LjO8/+TwRhvQMe0SPR61YdGgKWXFBpXOWlrD
         hkJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+d4eE8vTSmnTfcsF06A9ijaErxq3MGUA0JFQlf6Ufdo=;
        b=g8FfolFxTY2CBjecFIyIaCVT65X73JnJj2N2ZXXfqiB+Q1rC0hx+PqbDa4NtvNpTA6
         2Hb87aAFC2y2XLsmf1QhNxRVrMJuaHgJGRwZTa/iPxMyH5DS+CA/r188ixcH4YcZ7TAk
         GiR7SAvWaHKHrX1OSCD4UEBnxEt1BzgvP/pE5+SVaJBwETPwJ5s6CmXPFStphVXKQKDK
         dwD/Sbt7RSL8iv7I0/LSekG56h7yieGOtscZ1OVGRnXg1NdVQCvtCceszuHfX0Bi90wf
         ZZOpVFbOha/UgMEng4Ubq7AP2mzatN0GgyVrjZHBY/503D8AZbrxoBYzv9Fk07LWawK7
         KLuw==
X-Gm-Message-State: AOAM531giIXlS+6VybW+W8T3lO9PmcGkZnoykqhdVX8ZI8rUeb57AEuD
        Wfwe913mS+MmrukXQ8vuxkjudjMGVE/xSTFZYdKvxw==
X-Google-Smtp-Source: ABdhPJwKfa6Ns5aNibD/NX7BlH7zp+cXMKbhPhjC0LcBq64TG0tqzj8/gnpWVJ+3dgyOXXYYuTSKDsNwY9wFloSu3bk=
X-Received: by 2002:a05:6512:308d:: with SMTP id z13mr13958467lfd.523.1643056303222;
 Mon, 24 Jan 2022 12:31:43 -0800 (PST)
MIME-Version: 1.0
References: <20220120214001.1879469-1-nathan@kernel.org>
In-Reply-To: <20220120214001.1879469-1-nathan@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 24 Jan 2022 12:31:31 -0800
Message-ID: <CAKwvOd=4QBW5uFLM7zbHfG+5499tT_zqBTaZQgzqegmuq_5+MQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] MIPS: Loongson64: Clean up use of cc-ifversion
To:     Nathan Chancellor <nathan@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Huacai Chen <chenhuacai@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2022 at 1:40 PM Nathan Chancellor <nathan@kernel.org> wrote:
>
> This Makefile checks that GCC is 4.9 or newer, which is redundant after
> commit 76ae847497bc ("Documentation: raise minimum supported version of
> GCC to 5.1"), so cc-option can be removed.
>
> Clang does not support -march=loongson3a so it needs to continue to use
> -march=mips64r2, along with binutils less than 2.25, so check that both
> GCC and binutils 2.25 or newer are being used before using
> -march=loongson3a. These flags do not need to be checked with cc-option
> anymore because all GCC versions support -march=loongson3a and
> -march=mips64r2 and all clang versions support -march=mips64r2.
>
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Thanks for the patch. I wonder why `_MIPS_ISA` only seems to be set at
all for `-march=loongson3a` AFAICT, though that question is orthogonal
to this patch. Perhaps the Loongson or MIPS maintainers know more?
Otherwise seems like most uses of _MIPS_ISA can either be deleted or
simplified now.

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  arch/mips/loongson64/Platform | 13 +++----------
>  1 file changed, 3 insertions(+), 10 deletions(-)
>
> diff --git a/arch/mips/loongson64/Platform b/arch/mips/loongson64/Platform
> index 3e660d6d3c2b..981d3abc150e 100644
> --- a/arch/mips/loongson64/Platform
> +++ b/arch/mips/loongson64/Platform
> @@ -12,17 +12,10 @@ cflags-$(CONFIG_CPU_LOONGSON64)     += -Wa,--trap
>  # by GAS.  The cc-option can't probe for this behaviour so -march=loongson3a
>  # can't easily be used safely within the kbuild framework.
>  #
> -ifeq ($(call cc-ifversion, -ge, 0409, y), y)
> -  ifeq ($(call ld-ifversion, -ge, 22500, y), y)
> -    cflags-$(CONFIG_CPU_LOONGSON64)  += \
> -      $(call cc-option,-march=loongson3a -U_MIPS_ISA -D_MIPS_ISA=_MIPS_ISA_MIPS64)
> -  else
> -    cflags-$(CONFIG_CPU_LOONGSON64)  += \
> -      $(call cc-option,-march=mips64r2,-mips64r2 -U_MIPS_ISA -D_MIPS_ISA=_MIPS_ISA_MIPS64)
> -  endif
> +ifeq ($(CONFIG_CC_IS_GCC)$(call ld-ifversion, -ge, 22500, y), yy)
> +  cflags-$(CONFIG_CPU_LOONGSON64) += -march=loongson3a -U_MIPS_ISA -D_MIPS_ISA=_MIPS_ISA_MIPS64
>  else
> -    cflags-$(CONFIG_CPU_LOONGSON64)  += \
> -      $(call cc-option,-march=mips64r2,-mips64r2 -U_MIPS_ISA -D_MIPS_ISA=_MIPS_ISA_MIPS64)
> +  cflags-$(CONFIG_CPU_LOONGSON64) += -march=mips64r2
>  endif
>
>  # Some -march= flags enable MMI instructions, and GCC complains about that
>
> base-commit: 2c271fe77d52a0555161926c232cd5bc07178b39
> --
> 2.34.1
>


-- 
Thanks,
~Nick Desaulniers
