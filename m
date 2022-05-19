Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33B3C52D1F6
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 14:02:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237593AbiESMBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 08:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbiESMBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 08:01:48 -0400
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A45EDB41CA;
        Thu, 19 May 2022 05:01:46 -0700 (PDT)
Received: by mail-qk1-f170.google.com with SMTP id b20so4531148qkc.6;
        Thu, 19 May 2022 05:01:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=32e726iWwMNC0xRIbGojngVmwOTaI+USQV4X78pDi0k=;
        b=TKKqX8UB1dkKMujJjE60CMD0GPbt+ecSObdbVO8u+uj+Lvl4wpI4k+C8IehJi90Dc1
         AEpqGnmA3bFHkpUWoPdKbQSRrHxBz574SlPQYEOFrco+j/J6BRVeNuZXQoJpbq/2LMdI
         bqm+sx4wrAX3yeLF9Yxq+tycpg4NfyqplkKJo1+mCroczlli4bmsmAJuORd8KlkuytGm
         W6nfUhdTogs4kyqjzEisvyFQ+7afTCMzEsOm0NiwgoSLymFXgnpUy4BNGo60TBkBeZZ1
         VBzaqgSKTtiQZ0UfR9pv99r+Uf1n468xUuVlNF5ERyOuWVdIMVTUDm/x/cdoQjKUTJ62
         Y9aA==
X-Gm-Message-State: AOAM532w23kb6U0KVMcJW7cFTeJPGSK6Y70HYBitZi3zyt3/jmW4MvAb
        AiW8DkXhZuk6Y3oYlrTB72a7d8ffx7hV9Q==
X-Google-Smtp-Source: ABdhPJxq0tN9iWpWh5IGAus3fAeZAP4zCMY2KjZ59jWDLFegdyv6SWNAXqnoEVSEmNFsXCsNTgdrZg==
X-Received: by 2002:ae9:ef85:0:b0:6a3:2a1c:fe65 with SMTP id d127-20020ae9ef85000000b006a32a1cfe65mr2730537qkg.300.1652961705565;
        Thu, 19 May 2022 05:01:45 -0700 (PDT)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com. [209.85.219.170])
        by smtp.gmail.com with ESMTPSA id g206-20020a379dd7000000b0069fcf0da629sm1102111qke.134.2022.05.19.05.01.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 May 2022 05:01:41 -0700 (PDT)
Received: by mail-yb1-f170.google.com with SMTP id p139so8588149ybc.11;
        Thu, 19 May 2022 05:01:40 -0700 (PDT)
X-Received: by 2002:a25:4289:0:b0:64d:746f:5311 with SMTP id
 p131-20020a254289000000b0064d746f5311mr3785817yba.89.1652961700211; Thu, 19
 May 2022 05:01:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220518192924.20948-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20220518192924.20948-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220518192924.20948-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 19 May 2022 14:01:28 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXz7ZtC_63hUckrEeB3uocNG0iKbA4i3xDsuyL48m_7qQ@mail.gmail.com>
Message-ID: <CAMuHMdXz7ZtC_63hUckrEeB3uocNG0iKbA4i3xDsuyL48m_7qQ@mail.gmail.com>
Subject: Re: [PATCH v4 6/7] dt-bindings: pinctrl: renesas,rzg2l-pinctrl:
 Document the properties to handle GPIO IRQ
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Marc Zyngier <maz@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prabhakar,

On Wed, May 18, 2022 at 9:30 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> Document the required properties to handle GPIO IRQ.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Thanks for your patch!

> --- a/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml
> @@ -126,6 +139,9 @@ examples:
>              gpio-controller;
>              #gpio-cells = <2>;
>              gpio-ranges = <&pinctrl 0 0 392>;
> +            interrupt-controller;
> +            #interrupt-cells = <2>;
> +            interrupt-parent = <&irqc>;

I think the "interrupt-parent" property can be dropped from the example.

>              clocks = <&cpg CPG_MOD R9A07G044_GPIO_HCLK>;
>              resets = <&cpg R9A07G044_GPIO_RSTN>,
>                       <&cpg R9A07G044_GPIO_PORT_RESETN>,

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
