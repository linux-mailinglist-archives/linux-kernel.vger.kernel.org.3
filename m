Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87FC8476297
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 21:05:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232516AbhLOUFU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 15:05:20 -0500
Received: from mail-oi1-f169.google.com ([209.85.167.169]:37569 "EHLO
        mail-oi1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbhLOUFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 15:05:19 -0500
Received: by mail-oi1-f169.google.com with SMTP id bj13so33240989oib.4;
        Wed, 15 Dec 2021 12:05:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=P7RLmrfkhZVAMV4g2mcECWBH8Xjmd8dDijHOmpxejv0=;
        b=IJyOeV3NNJJmqi7tJeszQfIBJASb36DYp5SISzkfQIeMHR+Wm8iYeKd8uxaSkUWGdd
         RgtVYh9yVJo5Mb1WK22TRV56EkgCIY2v9INH5vidlwabb48lLnaP9Y3VEVG/12pqgZpD
         iD9F255vE5ObCYipeeZt8atU5qppcaTiuZRsya7GRQBIq7SDw2EF6+4Dp3bYC+6l7ryd
         d/f/sLesAXW0Q+fGmKESLULBU56rY2bMgQOcF1TS9CUeOTmd6jv6KUoEPIprYdohZHyA
         Lm6EhXqZ1bnsBk+s03nCj/m2tBWzirEmOsWt1/GUILh1ayLnPbShyjSnxnX92LbJ8PVl
         JOdg==
X-Gm-Message-State: AOAM531lkkFiaWcrn8WMsG5xO3VtAm1QtiTyruaZpodDITsXp28Byqxg
        wyWyNjkwY29bEtI6Z8cArw==
X-Google-Smtp-Source: ABdhPJzr1nV8l3e7r6mWTVwY9sxeQwRfRrc3AiGmQ0FqmUJLAFAZkO1d2XXsQr1ITI0tl2noywGOig==
X-Received: by 2002:a05:6808:20a5:: with SMTP id s37mr1299679oiw.127.1639598719122;
        Wed, 15 Dec 2021 12:05:19 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id p23sm623662otf.37.2021.12.15.12.05.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 12:05:18 -0800 (PST)
Received: (nullmailer pid 1746720 invoked by uid 1000);
        Wed, 15 Dec 2021 20:05:17 -0000
Date:   Wed, 15 Dec 2021 14:05:17 -0600
From:   Rob Herring <robh@kernel.org>
To:     Hector Martin <marcan@marcan.st>
Cc:     Sven Peter <sven@svenpeter.dev>, Mark Brown <broonie@kernel.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: spi: apple,spi: Add binding for Apple
 SPI controllers
Message-ID: <YbpKfWfavRtLmMne@robh.at.kernel.org>
References: <20211212034726.26306-1-marcan@marcan.st>
 <20211212034726.26306-3-marcan@marcan.st>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211212034726.26306-3-marcan@marcan.st>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 12, 2021 at 12:47:25PM +0900, Hector Martin wrote:
> The Apple SPI controller is present in SoCs such as the M1 (t8103) and
> M1 Pro/Max (t600x). This controller uses one IRQ and one clock, and
> doesn't need any special properties, so the binding is trivial.
> 
> Signed-off-by: Hector Martin <marcan@marcan.st>
> ---
>  .../devicetree/bindings/spi/apple,spi.yaml    | 63 +++++++++++++++++++
>  1 file changed, 63 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/apple,spi.yaml
> 
> diff --git a/Documentation/devicetree/bindings/spi/apple,spi.yaml b/Documentation/devicetree/bindings/spi/apple,spi.yaml
> new file mode 100644
> index 000000000000..bcbdc8943e92
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/apple,spi.yaml
> @@ -0,0 +1,63 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/spi/apple,spi.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Apple ARM SoC SPI controller
> +
> +allOf:
> +  - $ref: "spi-controller.yaml#"
> +
> +maintainers:
> +  - Hector Martin <marcan@marcan.st>
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - apple,t8103-spi
> +          - apple,t6000-spi
> +      - const: apple,spi
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  power-domains:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - interrupts

> +  - '#address-cells'
> +  - '#size-cells'

Already required by spi-controller.yaml. Otherwise,

Reviewed-by: Rob Herring <robh@kernel.org>

> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/apple-aic.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    soc {
> +      #address-cells = <2>;
> +      #size-cells = <2>;
> +
> +      spi: spi@39b104000 {
> +        compatible = "apple,t6000-spi", "apple,spi";
> +        reg = <0x3 0x9b104000 0x0 0x4000>;
> +        interrupt-parent = <&aic>;
> +        interrupts = <AIC_IRQ 0 1107 IRQ_TYPE_LEVEL_HIGH>;
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        clocks = <&clk>;
> +      };
> +    };
> -- 
> 2.33.0
> 
> 
