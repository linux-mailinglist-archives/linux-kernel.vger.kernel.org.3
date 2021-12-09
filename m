Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3946346E9E8
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 15:25:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238563AbhLIO2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 09:28:52 -0500
Received: from sibelius.xs4all.nl ([83.163.83.176]:58772 "EHLO
        sibelius.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232122AbhLIO2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 09:28:51 -0500
Received: from localhost (bloch.sibelius.xs4all.nl [local])
        by bloch.sibelius.xs4all.nl (OpenSMTPD) with ESMTPA id 93b16357;
        Thu, 9 Dec 2021 15:25:16 +0100 (CET)
Date:   Thu, 9 Dec 2021 15:25:16 +0100 (CET)
From:   Mark Kettenis <mark.kettenis@xs4all.nl>
To:     Hector Martin <marcan@marcan.st>
Cc:     sven@svenpeter.dev, robh+dt@kernel.org, marcan@marcan.st,
        alyssa@rosenzweig.io, kettenis@openbsd.org, maz@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211209051001.70235-4-marcan@marcan.st> (message from Hector
        Martin on Thu, 9 Dec 2021 14:10:00 +0900)
Subject: Re: [PATCH 3/4] dt-bindings: pci: apple,pcie: Add t6000 support
References: <20211209051001.70235-1-marcan@marcan.st> <20211209051001.70235-4-marcan@marcan.st>
Message-ID: <d3cb39fce38bc298@bloch.sibelius.xs4all.nl>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Hector Martin <marcan@marcan.st>
> Date: Thu,  9 Dec 2021 14:10:00 +0900
> 
> This new SoC is compatible with the existing driver, but the block
> supports 4 downstream ports, so we need to adjust the binding to
> allow that.
> 
> Signed-off-by: Hector Martin <marcan@marcan.st>
> ---
>  .../devicetree/bindings/pci/apple,pcie.yaml   | 28 ++++++++++++++-----
>  1 file changed, 21 insertions(+), 7 deletions(-)

Not 100% certain if we really want to constrain things on a per-SoC
basis this way.  But it matches my understanding of the hardware.

Reviewed-by: Mark Kettenis <kettenis@openbsd.org>

> diff --git a/Documentation/devicetree/bindings/pci/apple,pcie.yaml b/Documentation/devicetree/bindings/pci/apple,pcie.yaml
> index ef1d424ec299..7f01e15fc81c 100644
> --- a/Documentation/devicetree/bindings/pci/apple,pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/apple,pcie.yaml
> @@ -28,19 +28,17 @@ description: |
>    distributed over the root ports as the OS sees fit by programming
>    the PCIe controller's port registers.
>  
> -allOf:
> -  - $ref: /schemas/pci/pci-bus.yaml#
> -  - $ref: /schemas/interrupt-controller/msi-controller.yaml#
> -
>  properties:
>    compatible:
>      items:
> -      - const: apple,t8103-pcie
> +      - enum:
> +          - apple,t8103-pcie
> +          - apple,t6000-pcie
>        - const: apple,pcie
>  
>    reg:
>      minItems: 3
> -    maxItems: 5
> +    maxItems: 6
>  
>    reg-names:
>      minItems: 3
> @@ -50,6 +48,7 @@ properties:
>        - const: port0
>        - const: port1
>        - const: port2
> +      - const: port3
>  
>    ranges:
>      minItems: 2
> @@ -59,7 +58,7 @@ properties:
>      description:
>        Interrupt specifiers, one for each root port.
>      minItems: 1
> -    maxItems: 3
> +    maxItems: 4
>  
>    msi-parent: true
>  
> @@ -81,6 +80,21 @@ required:
>  
>  unevaluatedProperties: false
>  
> +allOf:
> +  - $ref: /schemas/pci/pci-bus.yaml#
> +  - $ref: /schemas/interrupt-controller/msi-controller.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: apple,t8103-pcie
> +    then:
> +      properties:
> +        reg:
> +          maxItems: 5
> +        interrupts:
> +          maxItems: 3
> +
>  examples:
>    - |
>      #include <dt-bindings/interrupt-controller/apple-aic.h>
> -- 
> 2.33.0
