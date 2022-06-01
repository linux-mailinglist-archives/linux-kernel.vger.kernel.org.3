Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C62653A484
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 14:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351742AbiFAMDL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 08:03:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbiFAMDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 08:03:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2A3948391;
        Wed,  1 Jun 2022 05:03:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 59C9DB8182A;
        Wed,  1 Jun 2022 12:03:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C777CC3411D;
        Wed,  1 Jun 2022 12:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654084984;
        bh=k96TRxFWoTI0+pe4xgkBtX3CcQGxEIISgLgYiWg5ftQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pw4iQw9RujggxeHvT5jW3uGEvNt9BOQZ2qziHxDVfhUh8yR4Z/ha3a4e+EoAf4A2U
         9amncn8T+lMyu9yqE1KXS3K5A+nmENjLaVdi267pfZ0rkqlFpIVaUZYGlmJJczO+rR
         yJ3DF8tSJPMEbhCU1Xfpq9VktMpbn9q4r8ouKZ1nMAIfzlUr95x8NWCZMyTxMkONHn
         ZMoUksK0vThirBwazgBeHQKGWQRErzeNXgC2nk99JSIt98WiVf/qq7RGyMAUhwqwrL
         GwHpHjjQMfU13fBkuEOWVExjJC7lxEHDCASYjiejwMsnFmnIpdZ768CIquRefqfFmr
         IRbLvGWBBUNDQ==
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-e93bbb54f9so2353985fac.12;
        Wed, 01 Jun 2022 05:03:04 -0700 (PDT)
X-Gm-Message-State: AOAM5325d1B3D2FLpe+Gr6Tv2YZWympFGwvXQZW6EomXKsR8FKNFpAYo
        lg0/KrIwezyuI4D2KgNNQrylZQMfEWe8LZpRQiA=
X-Google-Smtp-Source: ABdhPJxsDEm4Kj8i+6O9VszubDDfztWwsZConIjwAKEe0j82b8SG4QP9QcviGwe12IHPwBVkSz/yM0OAE+oKR0M2qco=
X-Received: by 2002:a05:6871:5c8:b0:f3:3c1c:126f with SMTP id
 v8-20020a05687105c800b000f33c1c126fmr8157003oan.126.1654084983910; Wed, 01
 Jun 2022 05:03:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220601115043.7678-1-lukas.bulwahn@gmail.com>
In-Reply-To: <20220601115043.7678-1-lukas.bulwahn@gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 1 Jun 2022 14:02:52 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFkU=FvP2rN0sD6+YMg6Dep_HBSG6WDiGvhci13AA6kkw@mail.gmail.com>
Message-ID: <CAMj1kXFkU=FvP2rN0sD6+YMg6Dep_HBSG6WDiGvhci13AA6kkw@mail.gmail.com>
Subject: Re: [PATCH] efi: x86: Fix config name for setting the
 NX-compatibility flag in the PE header
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Peter Jones <pjones@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        X86 ML <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
        kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Jun 2022 at 13:51, Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
>
> Commit 21b68da7bf4a ("efi: x86: Set the NX-compatibility flag in the PE
> header") intends to set the compatibility flag, i.e.,
> IMAGE_DLL_CHARACTERISTICS_NX_COMPAT, but this ifdef is actually dead as the
> CONFIG_DXE_MEM_ATTRIBUTES does not exist.
>
> The config is actually called EFI_DXE_MEM_ATTRIBUTES. Adjust the ifdef to
> use the intended config name.
>
> The issue was identified with ./scripts/checkkconfigsymbols.py.
>
> Fixes: 21b68da7bf4a ("efi: x86: Set the NX-compatibility flag in the PE header")
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
> Peter, please review and ack.
> Ard, please pick this fix-up patch.
>

Thanks, Lukas, I'll queue this up.

>  arch/x86/boot/header.S | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
> index 0352e4589efa..f912d7770130 100644
> --- a/arch/x86/boot/header.S
> +++ b/arch/x86/boot/header.S
> @@ -163,7 +163,7 @@ extra_header_fields:
>         .long   0x200                           # SizeOfHeaders
>         .long   0                               # CheckSum
>         .word   IMAGE_SUBSYSTEM_EFI_APPLICATION # Subsystem (EFI application)
> -#ifdef CONFIG_DXE_MEM_ATTRIBUTES
> +#ifdef CONFIG_EFI_DXE_MEM_ATTRIBUTES
>         .word   IMAGE_DLL_CHARACTERISTICS_NX_COMPAT     # DllCharacteristics
>  #else
>         .word   0                               # DllCharacteristics
> --
> 2.17.1
>
