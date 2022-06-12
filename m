Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08332547AA1
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 17:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237353AbiFLPFd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 11:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231658AbiFLPFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 11:05:31 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63F1C5A168;
        Sun, 12 Jun 2022 08:05:28 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id y19so6632428ejq.6;
        Sun, 12 Jun 2022 08:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=htFjsSXu7ZGxTjaP5i3din+9CWxv94Bctr84QoNiliY=;
        b=APsLw00dy2F55yoY3iXIMcnELsihcXP/p6SNiyRSf5oZEwPYW3D+p0hDD/fhfBGpLe
         213n/Vi5KHjD4mMgEBXf2SHm9ZkNEaPVqBySbH1z3UhGpTHYFKFPNey4vj/pQ1X6HLEG
         CwJlDpgpTCvyl7Jilb5g9EBt7kK4A5jHct8fJEqfqx1dGEYyx4yqxwH5Hci+eZ5+6a1/
         mwPrbmd2GM57MA2FANPMcQZRrQ+t0+ZzePfDQ0ZscrO4pnZjGmDSRDbNGdr3E+hjTEc+
         vjADJaLYSq1uDbnUJWHDibDyKWaovFiZ9vlJy+aEvP/Vs+lyavPcbmcBUjdLyOjwTAEb
         xhFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=htFjsSXu7ZGxTjaP5i3din+9CWxv94Bctr84QoNiliY=;
        b=O7tAG04umYANXFlsSIj9HYYWKh7UDtY1+oaOHFA05rUSNjw6DTIY/3D19ZrMmIxxtm
         HtYFLmZAtFJxRi69vKAco96gLIpCJu/+w+3zahqvwQB4ieaZ7MOW5WdMqgh56p2N8txS
         NdnO0wJNsBbwqpsWHCZC8QS8DHENAjUTZfiCS7tGM6OBQHMN18jpUlfCInFC+8IT94Yc
         VFrw8HVN26qoIZjYZ3IgPgHCUSR6+kZGMEaXtgOvWqFIjGBgQIwtTBZsfcE8qxHeFGAM
         vUnCOXC5DtngVxNm/EATzSmhBWdxe9szasFMMUrH15+NLOWjHkzehVLvJiI98jTR0nZx
         U6Tw==
X-Gm-Message-State: AOAM533sJnvD2MxxCcQEmw1mdwXfWoLl7HpKz3q4gz32LgxLB7z4W5sj
        +7oRwth9EJEmzxsivYuI7Fw=
X-Google-Smtp-Source: ABdhPJyi9sxjMamNlGeaPrfv21rrYPCrriGAL73CCnuOlTCxSIfRQCJRmSiN3kIcksZEs7Yydc4tvg==
X-Received: by 2002:a17:906:8301:b0:6e4:896d:59b1 with SMTP id j1-20020a170906830100b006e4896d59b1mr47420520ejx.396.1655046326879;
        Sun, 12 Jun 2022 08:05:26 -0700 (PDT)
Received: from archbook.localnet (84-72-105-84.dclient.hispeed.ch. [84.72.105.84])
        by smtp.gmail.com with ESMTPSA id gv17-20020a170906f11100b006febc1e9fc8sm2553325ejb.47.2022.06.12.08.05.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jun 2022 08:05:26 -0700 (PDT)
From:   Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/3] media: dt-binding: media: Add rockchip-vepu binding
Date:   Sun, 12 Jun 2022 17:05:25 +0200
Message-ID: <1885873.U9Vi27CkfU@archbook>
In-Reply-To: <440a7dc6-7ec4-d7a9-0c56-3b3dc15b79d0@linaro.org>
References: <20220514133604.174905-1-frattaroli.nicolas@gmail.com> <20220514133604.174905-2-frattaroli.nicolas@gmail.com> <440a7dc6-7ec4-d7a9-0c56-3b3dc15b79d0@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

On Samstag, 14. Mai 2022 22:41:29 CEST Krzysztof Kozlowski wrote:
> On 14/05/2022 15:36, Nicolas Frattaroli wrote:
> > The RK3568 and RK3566 have a Hantro VPU node solely dedicated to
> > encoding. This patch adds a new binding to describe it, as it
> > does not really fit the rockchip-vpu binding, since there is no
> > decoder.
> > 
> > Signed-off-by: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
> > ---
> >  .../bindings/media/rockchip-vepu.yaml         | 64 +++++++++++++++++++
> >  MAINTAINERS                                   |  1 +
> >  2 files changed, 65 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/media/rockchip-vepu.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/media/rockchip-vepu.yaml b/Documentation/devicetree/bindings/media/rockchip-vepu.yaml
> > new file mode 100644
> > index 000000000000..b7ba5bf3517a
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/media/rockchip-vepu.yaml
> 
> Filename: vendor,device (not hyphen)
> It would be actually better if it followed the first compatible, so
> "rockchip,rk3568-vepu.yaml"

Thanks, will do.

> 
> > @@ -0,0 +1,64 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +
> > +%YAML 1.2
> > +---
> > +$id: "http://devicetree.org/schemas/media/rockchip-vepu.yaml#"
> > +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> > +
> > +title: Hantro G1 VPU encoders implemented on Rockchip SoCs
> > +
> > +maintainers:
> > +  - Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
> > +
> > +description:
> > +  Hantro G1 video encode-only accelerators present on Rockchip SoCs.
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - rockchip,rk3568-vepu
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    maxItems: 2
> > +
> > +  clock-names:
> > +    items:
> > +      - const: aclk
> > +      - const: hclk
> 
> Since these are new bindings, it would be good to follow DT convention
> and not add common "clk" prefix to clocks. Just like DMA is "tx" not
> "txdma". However clock names "a" and "h" are also not good and maybe
> this is already shared implementation?

This is indeed a shared implementation. Theoretically I could change
the driver for this one case but that seems pointless, especially
since "aclk" and "hclk" are the usual clk names for AXI and AHB on
ARM as far as I understand. I think I've been told before that those
two clocks should always be called aclk and hclk.

> 
> > + 
> > +  power-domains:
> > +    maxItems: 1
> > +
> > +  iommus:
> > +    maxItems: 1
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +  - clocks
> > +  - clock-names
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +        #include <dt-bindings/clock/rk3568-cru.h>
> 
> Indentation starts at "|" (so four spaces)
> 
> > +        #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +        #include <dt-bindings/power/rk3568-power.h>
> > +
> > +        vepu: video-codec@fdee0000 {
> 
> four spaces.
> 
> > +                compatible = "rockchip,rk3568-vepu";
> > +                reg = <0x0 0xfdee0000 0x0 0x800>;
> > +                interrupts = <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>;
> > +                clocks = <&cru ACLK_JENC>, <&cru HCLK_JENC>;
> > +                clock-names = "aclk", "hclk";
> > +                iommus = <&vepu_mmu>;
> > +                power-domains = <&power RK3568_PD_RGA>;
> > +        };
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 9ce78f2275dc..f901a42e5d0f 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -8637,6 +8637,7 @@ L:	linux-media@vger.kernel.org
> >  L:	linux-rockchip@lists.infradead.org
> >  S:	Maintained
> >  F:	Documentation/devicetree/bindings/media/nxp,imx8mq-vpu.yaml
> > +F:	Documentation/devicetree/bindings/media/rockchip-vepu.yaml
> >  F:	Documentation/devicetree/bindings/media/rockchip-vpu.yaml
> >  F:	drivers/staging/media/hantro/
> >  
> 
> 
> Best regards,
> Krzysztof
> 

Thank you for your feedback,
Nicolas Frattaroli



