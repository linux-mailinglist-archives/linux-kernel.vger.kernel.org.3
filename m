Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C037F598079
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 11:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243575AbiHRJDK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 05:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230514AbiHRJDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 05:03:08 -0400
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACB6FB07E5;
        Thu, 18 Aug 2022 02:03:07 -0700 (PDT)
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-f2a4c51c45so1074518fac.9;
        Thu, 18 Aug 2022 02:03:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=ZmOw2Ye6D3rDsXvEq+Hj2UxFw02iY07PBYlER+Z5IJs=;
        b=Q3Fre+R1RjpfZX4kxBErGHtKC6H8E2ckTe1z2CBeIKwJZL3S5BsLtiQPbQtN3RDCS4
         TsvoqB23mlWY6TOlC/ypJChNVQI/GcbJ2ejwD7rHYUb7jgZREbfFHHyd2by9RJ3HQwJV
         bBCL+/0wBSFROazXYBbb/JHVI4cpF9DGH3AcgMEOlyV4cYFtHuLGcPdCzLnmcerwWfxv
         +AavissL6J8FWnRPFOQ1x5Jb2xCA6S8T5kL+P4p1tt2UtiMsNOd9VNl/2soFZ6hkJpAO
         mJWvoHpLItsfSX+2ygcAEWHw0t48zsQn4J+zXtgIql3+nrrVMwWCznzGx/zn9B4kUsd1
         b8ww==
X-Gm-Message-State: ACgBeo2/oqlHcHSwY2BhG8/5Z0x7RKijJBYPQofDag3AiVTJJQeW89/c
        giDKD3yzrlZa4p5pgcIZhjFZ5g5neDwvtQ==
X-Google-Smtp-Source: AA6agR7snnj50rO52+s+YlU9cl70Q6phrgmPr4knQPg5NNXja5M/hr3ABAgrLrkFzslQaNGliwqm3g==
X-Received: by 2002:a05:6870:5a9:b0:11c:43b:5810 with SMTP id m41-20020a05687005a900b0011c043b5810mr3774158oap.159.1660813386760;
        Thu, 18 Aug 2022 02:03:06 -0700 (PDT)
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com. [209.85.210.50])
        by smtp.gmail.com with ESMTPSA id el3-20020a056870f68300b00101bc3380a5sm283490oab.12.2022.08.18.02.03.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Aug 2022 02:03:06 -0700 (PDT)
Received: by mail-ot1-f50.google.com with SMTP id v12-20020a9d7d0c000000b00638e210c995so770987otn.13;
        Thu, 18 Aug 2022 02:03:06 -0700 (PDT)
X-Received: by 2002:a81:f47:0:b0:31f:434b:5ee with SMTP id 68-20020a810f47000000b0031f434b05eemr1877711ywp.383.1660812973568;
 Thu, 18 Aug 2022 01:56:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220801214718.16943-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20220801214718.16943-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220801214718.16943-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 18 Aug 2022 10:56:01 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXKnve1-KE+GF5YVe3k8w0oQA96P9VAfB9XxVMbuKiN7g@mail.gmail.com>
Message-ID: <CAMuHMdXKnve1-KE+GF5YVe3k8w0oQA96P9VAfB9XxVMbuKiN7g@mail.gmail.com>
Subject: Re: [PATCH 1/4] media: dt-bindings: media: Document RZ/G2L CSI-2 block
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prabhakar,

On Mon, Aug 1, 2022 at 11:47 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> Document the CSI-2 block which is part of CRU found in Renesas
> RZ/G2L SoC.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> RFC v2 -> v1
> * Fixed review comments pointed by Rob and Jacopo.

Thanks for the update!

> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/renesas,rzg2l-csi2.yaml
> @@ -0,0 +1,149 @@

> +  resets:
> +    items:
> +      - description: CRU_CMN_RSTB reset terminal
> +
> +  reset-names:
> +    const: cmn-rstb

While it doesn't hurt to always have reset-names, you may want to drop
it, as there is only a single reset.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
