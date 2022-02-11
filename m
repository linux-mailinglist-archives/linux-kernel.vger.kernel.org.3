Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9C324B2B4F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 18:07:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351911AbiBKRGU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 12:06:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351913AbiBKRGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 12:06:18 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65BE4CD4
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 09:06:17 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id v47so26763661ybi.4
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 09:06:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0Z3bngRVpSYddmrGzDDpv2HxNMMx8dlz3kElrpqm5dM=;
        b=lCaF4tj6nXscUtFc5IanPU7VTu+QKImSWuY+0oXyviHFgbD+hRZ1OZCLm1bA2zWVJr
         J6fCilegEUaefDH3Scxc9aMG5+5tt0GspjZiuDIaIZJ8lc5ZNLUdysYCILq9GxZoOCGl
         bD6WDLiy8B6Fb96SyStX7rSqyhWJiH2olMVltooYNBTXcZvNYXUlGqBnyGFpPU+vX7F3
         9/c9Y8Ui5AF7R4PNjnLLqXCRWw8R4ty6dyPtSUyWurbofQFCTaUeSmF/44PMl3s7lfX4
         KGYMCDMVw54o1e5/W4ET4iglu3D90i1pQ273zXuUknIAavbigwOV113gwlRtCMz0dFg8
         91Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0Z3bngRVpSYddmrGzDDpv2HxNMMx8dlz3kElrpqm5dM=;
        b=w2/sy2PmClKn/NmdQujjjGRdj3uayt0qjCc1cfZ+9QD1ySzgRiXLL3WKfbP9c5zZpP
         EOYndU840xEJfHy7VZRj5gI5s5apYoVzjBFHZpvWOSu/bEDXYJnH6bZWWDkRBCPjyqVR
         muCfQo99DJj+7ZK3mcYevQXoIaWPvwAIKjCSnjB/mckGWXkuGksqUOJyqZWuT1TtX9YD
         C4gZWsdn/2mt864RsWQ3R0ocDdlXTd839VvwQLp5EEvC0Tf9hJ2ivuw8RME7+vtH7X6A
         5L1Z86mLlbGhIHIJAMSHF9yB9m7VBtpqkgoOYNMTV4m4T5uq0TSpjZOHXg8Y1+b3A2bm
         pikQ==
X-Gm-Message-State: AOAM530lLCkggY1JmYIgr28g4r/Ao+wks+wSywWNdbHT8q4xf6qGuxWP
        WeDr+7PsWAf43a5bCQbty7/McoArP38mtlHP072eY5Cpcq1drQ==
X-Google-Smtp-Source: ABdhPJzPoWWwLXuhJfR0h166cxSyXJ3e68O8oHKO7Rp1zqL31r13bPIEHaxb10K/V6SEXVxnmNVWKMS4/nvWcJYxL7c=
X-Received: by 2002:a05:6902:110d:: with SMTP id o13mr2391298ybu.728.1644599176171;
 Fri, 11 Feb 2022 09:06:16 -0800 (PST)
MIME-Version: 1.0
References: <20220211162142.2402-1-nemanja.rakovic@syrmia.com>
In-Reply-To: <20220211162142.2402-1-nemanja.rakovic@syrmia.com>
From:   Marco Elver <elver@google.com>
Date:   Fri, 11 Feb 2022 18:06:04 +0100
Message-ID: <CANpmjNO75cTC24vHUNrfR5VSv9jsgqcJ14RyyQos+1mpx599Cw@mail.gmail.com>
Subject: Re: [PATCH V2] mips: Enable KCSAN
To:     Nemanja Rakovic <nemanja.rakovic@syrmia.com>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-kernel@vger.kernel.org, dragan.mladjenovic@syrmia.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Feb 2022 at 17:22, Nemanja Rakovic
<nemanja.rakovic@syrmia.com> wrote:
>
> This patch enables KCSAN for the 64-bit version. Updated rules
> for the incompatible compilation units (vdso, boot/compressed).
>
> Signed-off-by: Nemanja Rakovic <nemanja.rakovic@syrmia.com>

Acked-by: Marco Elver <elver@google.com>


> ---
>  arch/mips/Kconfig                  | 1 +
>  arch/mips/boot/compressed/Makefile | 1 +
>  arch/mips/vdso/Makefile            | 3 +++
>  3 files changed, 5 insertions(+)
>
> Changes were tested on qemu (qemu-system-mips64el) with the
> 64r6el_defconfig configuration and KCSAN enabled.
>
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index 058446f01487..651d4fe355da 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -101,6 +101,7 @@ config MIPS
>         select TRACE_IRQFLAGS_SUPPORT
>         select VIRT_TO_BUS
>         select ARCH_HAS_ELFCORE_COMPAT
> +       select HAVE_ARCH_KCSAN if 64BIT
>
>  config MIPS_FIXUP_BIGPHYS_ADDR
>         bool
> diff --git a/arch/mips/boot/compressed/Makefile b/arch/mips/boot/compressed/Makefile
> index 5a15d51e8884..6cc28173bee8 100644
> --- a/arch/mips/boot/compressed/Makefile
> +++ b/arch/mips/boot/compressed/Makefile
> @@ -38,6 +38,7 @@ KBUILD_AFLAGS := $(KBUILD_AFLAGS) -D__ASSEMBLY__ \
>  KCOV_INSTRUMENT                := n
>  GCOV_PROFILE := n
>  UBSAN_SANITIZE := n
> +KCSAN_SANITIZE                 := n
>
>  # decompressor objects (linked with vmlinuz)
>  vmlinuzobjs-y := $(obj)/head.o $(obj)/decompress.o $(obj)/string.o $(obj)/bswapsi.o
> diff --git a/arch/mips/vdso/Makefile b/arch/mips/vdso/Makefile
> index d65f55f67e19..f72658b3a53f 100644
> --- a/arch/mips/vdso/Makefile
> +++ b/arch/mips/vdso/Makefile
> @@ -1,6 +1,9 @@
>  # SPDX-License-Identifier: GPL-2.0
>  # Objects to go into the VDSO.
>
> +# Sanitizer runtimes are unavailable and cannot be linked here.
> + KCSAN_SANITIZE                        := n
> +
>  # Absolute relocation type $(ARCH_REL_TYPE_ABS) needs to be defined before
>  # the inclusion of generic Makefile.
>  ARCH_REL_TYPE_ABS := R_MIPS_JUMP_SLOT|R_MIPS_GLOB_DAT
> --
> 2.17.1
>
