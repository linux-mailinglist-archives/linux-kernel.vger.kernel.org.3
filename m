Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83AA257DF05
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 12:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234530AbiGVJnv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 22 Jul 2022 05:43:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235321AbiGVJne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 05:43:34 -0400
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97D532B1AA;
        Fri, 22 Jul 2022 02:37:21 -0700 (PDT)
Received: by mail-qt1-f169.google.com with SMTP id r21so3097634qtn.11;
        Fri, 22 Jul 2022 02:37:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Ipd0OV9VFSCgqhes77c1Z/Sacso48JrJfoSgIwk6SdY=;
        b=4ts5okaMyNaZOgI3VCIuo1fWr+MlyYEw2rPkzRYG4XwpLXo1TesfIF3Kvz00VnOG7w
         jeZJm7NkGtOQ50yiMqY8FbBuqt+vqDQhR7JTMhOVFo3oIcY6iaMOi2SlLqZ8HHrQO7iy
         smctAElwR4aE6EPVJ4e1+Ri7Xv9JRCFD6nDB/zUS/V2gwXe7TXtA558T2GLojFQdWmpr
         ehoAFfkhfYfmckmebkTzelua7x1A6LgtrP6w5sHTj/O6OLIfO1U0eMhd1Fu/bxP7pBBR
         +MtmR4WwpQhClGXso3e3ajsyuttVi99PcMIl5y9/oHcfH3cgVBB6/KbcbofVcYAem3Ko
         ocXQ==
X-Gm-Message-State: AJIora+aISgwz9CWYhMLvcoouo24wYzbG9y19mlrgUcR+CxbJQam5p3O
        Gixip2wr9XKzWXHbP7CsOq3GORy+Y6Lm5A==
X-Google-Smtp-Source: AGRyM1u2J7dQOfIR4xqmiMZg8u8xlZdDUqGppv2e5bsCuGNrHdmxOZkfC3a+ZY5anm5e/7ytLESu/g==
X-Received: by 2002:ac8:5a50:0:b0:31e:f587:f891 with SMTP id o16-20020ac85a50000000b0031ef587f891mr2231097qta.10.1658482640229;
        Fri, 22 Jul 2022 02:37:20 -0700 (PDT)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com. [209.85.128.174])
        by smtp.gmail.com with ESMTPSA id do23-20020a05620a2b1700b006a758ce2ae1sm3351616qkb.104.2022.07.22.02.37.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jul 2022 02:37:20 -0700 (PDT)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-31e7ca45091so41862617b3.3;
        Fri, 22 Jul 2022 02:37:19 -0700 (PDT)
X-Received: by 2002:a81:84c1:0:b0:31e:4e05:e4f4 with SMTP id
 u184-20020a8184c1000000b0031e4e05e4f4mr2273395ywf.384.1658482639502; Fri, 22
 Jul 2022 02:37:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220721221212.18491-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20220721221212.18491-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220721221212.18491-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 22 Jul 2022 11:37:08 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWDZVoxW5RUb0HjR7ZABo2Hj0waX+soqTDsxtxQa2N1MA@mail.gmail.com>
Message-ID: <CAMuHMdWDZVoxW5RUb0HjR7ZABo2Hj0waX+soqTDsxtxQa2N1MA@mail.gmail.com>
Subject: Re: [PATCH 2/2] soc: renesas: Identify RZ/Five SoC
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prabhakar,

On Fri, Jul 22, 2022 at 12:12 AM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> Add support for identifying the (R9A07G043) RZ/Five SoC.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Thanks for your patch!

> --- a/drivers/soc/renesas/Kconfig
> +++ b/drivers/soc/renesas/Kconfig
> @@ -333,6 +333,16 @@ config ARCH_R9A09G011
>
>  endif # ARM64
>
> +if RISCV
> +
> +config ARCH_R9A07G043
> +       bool "RISCV Platform support for RZ/Five"

RISC-V

> +       select ARCH_RZG2L
> +       help
> +         This enables support for the Renesas RZ/Five SoC.
> +
> +endif # RISCV
> +
>  config RST_RCAR
>         bool "Reset Controller support for R-Car" if COMPILE_TEST
>

> @@ -102,6 +106,11 @@ static const struct renesas_soc soc_rmobile_a1 __initconst __maybe_unused = {
>         .id     = 0x40,
>  };
>
> +static const struct renesas_soc soc_rz_five __initconst __maybe_unused = {
> +       .family = &fam_rzfive,
> +       .id     = 0x847c447,

The Hardware User's Manual Rev.1.00 says H’x841_C447?

> @@ -398,6 +411,7 @@ static const struct renesas_id id_prr __initconst = {
>
>  static const struct of_device_id renesas_ids[] __initconst = {
>         { .compatible = "renesas,bsid",                 .data = &id_bsid },
> +       { .compatible = "renesas,r9a07g043-rzfive-sysc", .data = &id_rzg2l },
>         { .compatible = "renesas,r9a07g043-sysc",       .data = &id_rzg2l },
>         { .compatible = "renesas,r9a07g044-sysc",       .data = &id_rzg2l },
>         { .compatible = "renesas,r9a07g054-sysc",       .data = &id_rzg2l },

This change might not be needed (cfr. my comments on patch 1/2).

The rest LGTM.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
