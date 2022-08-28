Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 494525A3DF9
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Aug 2022 16:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbiH1OQZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 10:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbiH1OQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 10:16:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0EC713F70
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 07:16:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B186461032
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 14:16:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2688BC4347C
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 14:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661696168;
        bh=kkPmcOGGsxCCHFReaCtdObyszK/ELS4wEedQBkUVZ4I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jw8fk7eFoIBPjIacZtx3OYLYFkp+s3Cn1IYi5N+i6hzuxuj2p7vsj9t/tpbnk/ofV
         gkxoF1IXJHltRPzBI0AH3N4DGJhBh4JT1tEeas8cshUA4C+eF+BbdoOyNePfk6jPXK
         eM2DwVyhn8lseW5Wf4/mZ/SrRM8jlvk8M8YaCncNMl3mtZe1mW1PMM1j5cSGHimsT1
         8lhWM6WxxbiG2YCgszuSmSRjgkPiIWrSevJq0fItNSBvgNbtxVke11lCllqd1AkC7J
         SamO5kyjmHL5zkQzdlgrBzmysgrjy+E8XsvLISnSebK7A27/JDeKk6gqSyq/NuPCG8
         HAFBCbgRfFTnw==
Received: by mail-vk1-f176.google.com with SMTP id b81so2706905vkf.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 07:16:08 -0700 (PDT)
X-Gm-Message-State: ACgBeo3WsFQKxXj2exY9AbpOI3bu2Xzm9unF+xEW7ol7YbNYmHHsXd3X
        ANZk1wtkCH965w0Kjl9Pjb1LNRuVcYZ9/suzZlg=
X-Google-Smtp-Source: AA6agR5h2iG2ixSMVSyapvLRPSHfm146j5ZVosXd1SvXe97qVJ2OyiFXNcZFh8J615F3WMKVM9LNR2xKZ33tCDlxMqs=
X-Received: by 2002:a1f:9b90:0:b0:374:f09c:876f with SMTP id
 d138-20020a1f9b90000000b00374f09c876fmr2167421vke.12.1661696167088; Sun, 28
 Aug 2022 07:16:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220827175436.156464-1-xry111@xry111.site> <20220827175436.156464-7-xry111@xry111.site>
In-Reply-To: <20220827175436.156464-7-xry111@xry111.site>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Sun, 28 Aug 2022 22:15:54 +0800
X-Gmail-Original-Message-ID: <CAAhV-H76ty7nkMffbgTgH-ByBdVc-HsST87ghubTDEWZUhmLuQ@mail.gmail.com>
Message-ID: <CAAhV-H76ty7nkMffbgTgH-ByBdVc-HsST87ghubTDEWZUhmLuQ@mail.gmail.com>
Subject: Re: [PATCH 6/8] LoongArch: Use model("extreme") attribute for per-CPU
 variables in module if CONFIG_CC_HAS_EXPLICIT_RELOCS
To:     Xi Ruoyao <xry111@xry111.site>
Cc:     loongarch@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Youling Tang <tangyouling@loongson.cn>,
        Jinyang He <hejinyang@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Ruoyao,

On Sun, Aug 28, 2022 at 1:56 AM Xi Ruoyao <xry111@xry111.site> wrote:
>
> On LoongArch, The "address" of a per-CPU variable symbol is actually an
> offset from $r21.  The value is nearing the loading address of main
> kernel image, but far from the address of modules.  We need to tell the
> compiler that a PC-relative addressing with 32-bit offset is not
> sufficient for local per-CPU variables.
>
> After some discussion with GCC maintainers, we implemented this
> attribute to indicate that a PC-relative addressing with 64-bit offset
> should be used.
>
> This attribute should be available in GCC 13 release.  Some early GCC 13
> snapshots may support -mexplicit-relocs but lack this attribute, we
> simply reject them.
>
> Link: https://gcc.gnu.org/r13-2199
> Signed-off-by: Xi Ruoyao <xry111@xry111.site>
> ---
>  arch/loongarch/include/asm/percpu.h | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/arch/loongarch/include/asm/percpu.h b/arch/loongarch/include/asm/percpu.h
> index 0bd6b0110198..91d4026b074e 100644
> --- a/arch/loongarch/include/asm/percpu.h
> +++ b/arch/loongarch/include/asm/percpu.h
> @@ -8,6 +8,19 @@
>  #include <asm/cmpxchg.h>
>  #include <asm/loongarch.h>
>
> +#if defined(MODULE) && defined(CONFIG_CC_HAS_EXPLICIT_RELOCS)
> +# if __has_attribute(model)
> +/* The "address" (in fact, offset from $r21) of a per-CPU variable is close
> + * to the load address of main kernel image, but far from where the modules are
> + * loaded.  Tell the compiler this fact.
> + */
> +#  define PER_CPU_ATTRIBUTES __attribute__((model("extreme")))
> +# else /* __has_attribute(model) */
> +/* This should only happen with early GCC 13 snapshots. */
Can we judge this case in Makefile to quit earlier and make code simpler here?


Huacai

> +#  error "Compiler with explicit relocs but no model attribute is not supported"
> +# endif /* __has_attribute(model) */
> +#endif
> +
>  /* Use r21 for fast access */
>  register unsigned long __my_cpu_offset __asm__("$r21");
>
> --
> 2.37.0
>
