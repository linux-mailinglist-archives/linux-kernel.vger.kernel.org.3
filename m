Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53BA3496806
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 23:57:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232889AbiAUW45 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 17:56:57 -0500
Received: from mail-oi1-f170.google.com ([209.85.167.170]:38464 "EHLO
        mail-oi1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbiAUW4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 17:56:55 -0500
Received: by mail-oi1-f170.google.com with SMTP id g205so15680337oif.5;
        Fri, 21 Jan 2022 14:56:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=v1ho46uTpKxUiYQBezGA0skkaF0vZIVCnFgPgClD3p4=;
        b=XznlCf39JLEGSLJeYQIqry9UXf+lHR3KaviVcy+kQ3rChveoOhTYGuGfM/50IV9KTh
         2xntNCMZFR7kDE1uSZ9u9y6zdp9UEQjozzRb+8bPuZWINYr+aQFuIzUIA25XDjHzx5y+
         bIU2xyPbAfD4Z9RqVcKOH3P43e3fU/ZKyUi6+Jt0w2O60K0T7b40J7vBDZArqwMK+pMf
         J8atEsDSdfYFToFAe46oKlzq6/6CumqEIAFshdFXrFiyrQc06Smg2w0eaDgEoIqGV0i7
         E9MxOxw0RDHnI676b/ckC8AwN73QwKrKkgTxe7+I4YUVbh7ecuO4vB7izqMM50yKrPOo
         i7Kw==
X-Gm-Message-State: AOAM5312IG2Obc9xPewlaSaTD3q7yJfQu/OYce8YD8tNC7D+9Fbg8gHd
        4AEQBYPueRNL9GlyrJiQpg==
X-Google-Smtp-Source: ABdhPJzPoZJ9d53Uow3j/Mph5gz2hM6lLzF8kFrRt1JkFzh1Hz3MnwqlPrdsp1fKWh34HPYgKNZJ0Q==
X-Received: by 2002:aca:1e0b:: with SMTP id m11mr2404247oic.79.1642805814717;
        Fri, 21 Jan 2022 14:56:54 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id g2sm1716518oic.40.2022.01.21.14.56.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 14:56:53 -0800 (PST)
Received: (nullmailer pid 1761473 invoked by uid 1000);
        Fri, 21 Jan 2022 22:56:52 -0000
Date:   Fri, 21 Jan 2022 16:56:52 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sander Vanheule <sander@svanheule.net>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Birger Koblitz <mail@birger-koblitz.de>,
        Bert Vermeulen <bert@biot.com>, John Crispin <john@phrozen.org>
Subject: Re: [PATCH v3 4/6] dt-bindings: interrupt-controller:
 realtek,rtl-intc: require parents
Message-ID: <Yes6NFgUmcIcc5mm@robh.at.kernel.org>
References: <cover.1641739718.git.sander@svanheule.net>
 <e043a9faa4a8f71efdf8b7849ec7911f16207fb0.1641739718.git.sander@svanheule.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e043a9faa4a8f71efdf8b7849ec7911f16207fb0.1641739718.git.sander@svanheule.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 09, 2022 at 03:54:35PM +0100, Sander Vanheule wrote:
> The interrupt router has 32 inputs and up to 15 outputs, and the way
> these are mapped to each other is runtime configurable. The outputs of
> this interrupt router on the other hand, are connected to a fixed set of
> parent interrupts. This means that "interrupt-map" is inappropriate, and
> rather a list of parent interrupts should be specified.

I'm not sure why interrupt-map is not appropriate. It is not appropriate 
if you have to touch the interrupt router h/w in servicing the 
interrupts. If you just need one time configuration of the mapping, then 
it should be fine to use I think.

> Two-part compatibles are introduced to be able to require "interrupts"
> for new devicetrees. The relevant descriptions are extended or added to
> more clearly describe the inputs and outputs of this router.  The old
> compatible, "interrupt-map" and "#address-cells", is deprecated.
> Interrupt specifiers for new compatibles will require two cells, to
> indicate the output selection.
> 
> To prevent spurious changes when more SoCs are added, "allOf" is used
> with one "if", and the compatible enum only has one item.
> 
> The example is updated to provide a correct example for RTL8380 SoCs.
> 
> Signed-off-by: Sander Vanheule <sander@svanheule.net>
> ---
>  .../realtek,rtl-intc.yaml                     | 78 ++++++++++++++-----
>  1 file changed, 58 insertions(+), 20 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/realtek,rtl-intc.yaml b/Documentation/devicetree/bindings/interrupt-controller/realtek,rtl-intc.yaml
> index 9e76fff20323..aab8d44010af 100644
> --- a/Documentation/devicetree/bindings/interrupt-controller/realtek,rtl-intc.yaml
> +++ b/Documentation/devicetree/bindings/interrupt-controller/realtek,rtl-intc.yaml
> @@ -6,6 +6,10 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>  
>  title: Realtek RTL SoC interrupt controller devicetree bindings
>  
> +description:
> +  Interrupt router for Realtek MIPS SoCs, allowing each SoC interrupt to be
> +  routed to one parent interrupt, or left disconnected.
> +
>  maintainers:
>    - Birger Koblitz <mail@birger-koblitz.de>
>    - Bert Vermeulen <bert@biot.com>
> @@ -13,45 +17,79 @@ maintainers:
>  
>  properties:
>    compatible:
> -    const: realtek,rtl-intc
> +    oneOf:
> +      - items:
> +          - enum:
> +              - realtek,rtl8380-intc
> +          - const: realtek,rtl-intc
> +      - const: realtek,rtl-intc
> +        deprecated: true
>  
> -  "#interrupt-cells":
> -    const: 1
> +  "#interrupt-cells": true
>  
>    reg:
>      maxItems: 1
>  
>    interrupts:
> -    maxItems: 1
> +    minItems: 1
> +    maxItems: 15
> +    description:
> +      List of parent interrupts, in the order that they are connected to this
> +      interrupt router's outputs.
>  
>    interrupt-controller: true
>  
> -  "#address-cells":
> -    const: 0
> -
> -  interrupt-map:
> -    description: Describes mapping from SoC interrupts to CPU interrupts
> -
>  required:
>    - compatible
>    - reg
>    - "#interrupt-cells"
>    - interrupt-controller
> -  - "#address-cells"
> -  - interrupt-map
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          const: realtek,rtl-intc
> +    then:
> +      properties:
> +        "#interrupt-cells":
> +          const: 1
> +
> +        "#address-cells":
> +          const: 0
> +
> +        interrupt-map: true
> +      required:
> +        - "#address-cells"
> +        - interrupt-map
> +    else:
> +      properties:
> +        "#interrupt-cells":
> +          description:
> +            Two cells to specify which line to connect to, and which output it should
> +            be routed to. Both cells use a zero-based index.

Picking the index picks the priority? Which is higher priority?


> +          const: 2
> +      required:
> +        - interrupts
>  
>  additionalProperties: false
>  
>  examples:
>    - |
>      intc: interrupt-controller@3000 {
> -      compatible = "realtek,rtl-intc";
> -      #interrupt-cells = <1>;
> +      compatible = "realtek,rtl8380-intc", "realtek,rtl-intc";
> +      #interrupt-cells = <2>;
>        interrupt-controller;
> -      reg = <0x3000 0x20>;
> -      #address-cells = <0>;
> -      interrupt-map =
> -              <31 &cpuintc 2>,
> -              <30 &cpuintc 1>,
> -              <29 &cpuintc 5>;
> +      reg = <0x3000 0x18>;
> +
> +      interrupt-parent = <&cpuintc>;
> +      interrupts = <2>, <3>, <4>, <5>, <6>;
> +    };
> +
> +    irq-consumer@0 {
> +      reg = <0 4>;
> +      interrupt-parent = <&intc>;
> +      interrupts =
> +        <19 3>, /* IRQ 19, routed to output 3 (cpuintc 5) */
> +        <18 4>; /* IRQ 18, routed to output 4 (cpuintc 6) */
>      };
> -- 
> 2.33.1
> 
> 
