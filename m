Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF46746F1DF
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 18:28:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242961AbhLIRcJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 12:32:09 -0500
Received: from mail-oo1-f47.google.com ([209.85.161.47]:45585 "EHLO
        mail-oo1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242183AbhLIRcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 12:32:07 -0500
Received: by mail-oo1-f47.google.com with SMTP id v30-20020a4a315e000000b002c52d555875so1817155oog.12;
        Thu, 09 Dec 2021 09:28:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4ubzH3jkwzjaGIZ4RG2gMof6ACEIEMc2PbVJkLmbVDg=;
        b=gtT3WfcssVL7oqpKJmJnD1rjpQt6Qa0Y1bVjZzz3GBxfXHbSGaiJ+WEdSBQmSdeSOI
         WoNy9MHbz80SDRyX9FAvtwmLpr1R4ivejFRvTUIOVuCHzpBbE50fdd4us7OrLALp7vlN
         mGFzj/gSoVGPeSsfCZjti6eUWePLI7IvOLh8B1BtxhuhUhZwRfUo5bWQcbir/R0cfuad
         Jcg5stcT9Q9UZ+iiQGh/RVYkw0/76TX0zz4EN7qHWxY1Y8Ns+P0NUm8l84G0Xd0drBCk
         E6abPaCtsNyvNWeLBIhCOaW8E9N+Fc6Vw2ejdy7vQ+szitPyGtOLoHm6FrJURwno3ROf
         JZtw==
X-Gm-Message-State: AOAM5307JB3fVbuOju6QXCk/N8bRJdwEcCli0a7QMaDURNWaxcuYzIhm
        rOuj8GGdfn4tsAFUlO8NXA==
X-Google-Smtp-Source: ABdhPJwznFMRD0lxiiF3HKrO8u5NejX61aItrFvQrVv6yIgajaJEnmyt01r7siGHjamcPyBkBghTcg==
X-Received: by 2002:a4a:e9a1:: with SMTP id t1mr4813723ood.50.1639070913875;
        Thu, 09 Dec 2021 09:28:33 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id n22sm69965oop.29.2021.12.09.09.28.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 09:28:33 -0800 (PST)
Received: (nullmailer pid 3215128 invoked by uid 1000);
        Thu, 09 Dec 2021 17:28:32 -0000
Date:   Thu, 9 Dec 2021 11:28:32 -0600
From:   Rob Herring <robh@kernel.org>
To:     Hector Martin <marcan@marcan.st>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/6] dt-bindings: interrupt-controller: apple,aic: Add
 apple,aic2 support
Message-ID: <YbI8wBS2mrETiTfw@robh.at.kernel.org>
References: <20211209043249.65474-1-marcan@marcan.st>
 <20211209043249.65474-2-marcan@marcan.st>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211209043249.65474-2-marcan@marcan.st>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 09, 2021 at 01:32:44PM +0900, Hector Martin wrote:
> This new incompatible revision of the AIC peripheral introduces
> multi-die support. To handle that, we introduce an optional
> 4-argument interrupt-cells form.
> 
> Also add an apple,event-reg property to specify the offset of the event
> register. Inexplicably, the capability registers allow us to compute
> other register offsets, but not this one. This allows us to keep
> forward-compatibility with future SoCs that will likely implement
> different die counts, thus shifting the event register. Apple do the
> same thing in their device tree...
> 
> Signed-off-by: Hector Martin <marcan@marcan.st>
> ---
>  .../interrupt-controller/apple,aic.yaml       | 62 +++++++++++++++----
>  1 file changed, 49 insertions(+), 13 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/apple,aic.yaml b/Documentation/devicetree/bindings/interrupt-controller/apple,aic.yaml
> index 97359024709a..6a8dd213e59a 100644
> --- a/Documentation/devicetree/bindings/interrupt-controller/apple,aic.yaml
> +++ b/Documentation/devicetree/bindings/interrupt-controller/apple,aic.yaml
> @@ -18,38 +18,44 @@ description: |
>  
>    - Level-triggered hardware IRQs wired to SoC blocks
>      - Single mask bit per IRQ
> -    - Per-IRQ affinity setting
> +    - Per-IRQ affinity setting (AICv1 only)
>      - Automatic masking on event delivery (auto-ack)
>      - Software triggering (ORed with hw line)
>    - 2 per-CPU IPIs (meant as "self" and "other", but they are interchangeable
> -    if not symmetric)
> +    if not symmetric) (AICv1 only)
>    - Automatic prioritization (single event/ack register per CPU, lower IRQs =
>      higher priority)
>    - Automatic masking on ack
> -  - Default "this CPU" register view and explicit per-CPU views
> +  - Default "this CPU" register view and explicit per-CPU views (AICv1 only)
>  
>    This device also represents the FIQ interrupt sources on platforms using AIC,
> -  which do not go through a discrete interrupt controller.
> -
> -allOf:
> -  - $ref: /schemas/interrupt-controller.yaml#
> +  which do not go through a discrete interrupt controller. It also handles
> +  FIQ-based Fast IPIs on supported chips.
>  
>  properties:
>    compatible:
> -    items:
> -      - const: apple,t8103-aic
> -      - const: apple,aic
> +    oneOf:
> +      - items:
> +          - const: apple,t8103-aic
> +          - const: apple,aic
> +      - items:
> +          - const: apple,t6000-aic
> +          - const: apple,aic2
>  
>    interrupt-controller: true
>  
>    '#interrupt-cells':
> -    const: 3
> +    minimum: 3
> +    maximum: 4
>      description: |
>        The 1st cell contains the interrupt type:
>          - 0: Hardware IRQ
>          - 1: FIQ
>  
> -      The 2nd cell contains the interrupt number.
> +      The optional 2nd cell contains the die ID (apple,aic2 only).
> +      If not present, it defaults to 0.
> +
> +      The next cell contains the interrupt number.
>          - HW IRQs: interrupt number
>          - FIQs:
>            - 0: physical HV timer
> @@ -57,7 +63,7 @@ properties:
>            - 2: physical guest timer
>            - 3: virtual guest timer
>  
> -      The 3rd cell contains the interrupt flags. This is normally
> +      The last cell contains the interrupt flags. This is normally
>        IRQ_TYPE_LEVEL_HIGH (4).
>  
>    reg:
> @@ -68,6 +74,13 @@ properties:
>    power-domains:
>      maxItems: 1
>  
> +  apple,event-reg:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      Specifies the offset of the event register, which lies after all the
> +      implemented die register sets, page aligned. This is not computable from
> +      capability register values, so we have to specify it explicitly.
> +
>  required:
>    - compatible
>    - '#interrupt-cells'
> @@ -76,6 +89,29 @@ required:
>  
>  additionalProperties: false
>  
> +allOf:
> +  - $ref: /schemas/interrupt-controller.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - apple,aic
> +    then:
> +      properties:
> +        '#interrupt-cells':
> +          const: 3
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - apple,aic2
> +    then:
> +      required:
> +        - apple,event-reg

Is this property valid for aic1? If not, you need:

else:
  not:
    required:
      - apple,event-reg


I tend to think you should just make this a separate document. There's 
not a whole lot of sharing (compared to any other interrupt controller).

> +
>  examples:
>    - |
>      soc {
> -- 
> 2.33.0
> 
> 
