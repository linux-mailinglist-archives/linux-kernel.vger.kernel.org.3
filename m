Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4212D4AA3E5
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 00:02:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377806AbiBDXCf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 18:02:35 -0500
Received: from mail-oi1-f171.google.com ([209.85.167.171]:40827 "EHLO
        mail-oi1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242439AbiBDXCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 18:02:34 -0500
Received: by mail-oi1-f171.google.com with SMTP id q8so10255475oiw.7;
        Fri, 04 Feb 2022 15:02:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=so7WBDjA3xCDjc/S+xxRptDS0jNCba5tDsjIbD3vNJs=;
        b=XjiOBDvzYDcMrJZDmgNOc7q10fOmDWj5d9rr3UF8ZPuMY5pIWwwPhKkaRy31z6UUQ6
         f1D6bGt7I/uHTzob4TBLpb/5InEvK/zuOhtugKcgQ3OMfny9YKUMAdHqVzJKpG/Edszq
         ZRVcDau8efR14b1S4e3hk2QTdmevYGljt9jLHWc+8wY37QK3MsknMWelktp7utFh1kc0
         +r0EI6S2L9Wyr86lHUqNZuwajpMtwHGyqWIiOyk8lhaGnpibjAaDgl+CqfAQdGzcUhhP
         DmjQBAU/jDQ9PuiFyR93cPWhWx8q1d60zy0W+7UxuBQ5v8fqqSqSShFE8u0aambh8751
         gHhw==
X-Gm-Message-State: AOAM530FwVMCsMIAJeWw3iKgnSm44he5MgxRdnL379Lw2atkzNNhekho
        6SbYYa8Hi0KPW9OHZWttCQ==
X-Google-Smtp-Source: ABdhPJw4Mo+JilQCIGEVwlEMmR/R7KpCERHXyFXB8K0h/yrIireDfpOeZwMkC+s/O+oo1VT77exLRw==
X-Received: by 2002:a05:6808:aa5:: with SMTP id r5mr622455oij.115.1644015754037;
        Fri, 04 Feb 2022 15:02:34 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id x1sm1277327oto.38.2022.02.04.15.02.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 15:02:33 -0800 (PST)
Received: (nullmailer pid 3346874 invoked by uid 1000);
        Fri, 04 Feb 2022 23:02:32 -0000
Date:   Fri, 4 Feb 2022 17:02:32 -0600
From:   Rob Herring <robh@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dougall <dougallj@gmail.com>, kernel-team@android.com
Subject: Re: [PATCH v4 03/10] dt-bindings: apple,aic: Add affinity
 description for per-cpu pseudo-interrupts
Message-ID: <Yf2wiMTUV6XUqWh0@robh.at.kernel.org>
References: <20220124201231.298961-1-maz@kernel.org>
 <20220124201231.298961-4-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220124201231.298961-4-maz@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2022 at 08:12:24PM +0000, Marc Zyngier wrote:
> Some of the FIQ per-cpu pseudo-interrupts are better described with
> a specific affinity, the most obvious candidate being the CPU PMUs.
> 
> Augment the AIC binding to be able to specify that affinity in the
> interrupt controller node.
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  .../interrupt-controller/apple,aic.yaml       | 27 +++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/apple,aic.yaml b/Documentation/devicetree/bindings/interrupt-controller/apple,aic.yaml
> index c7577d401786..d97683eb2c54 100644
> --- a/Documentation/devicetree/bindings/interrupt-controller/apple,aic.yaml
> +++ b/Documentation/devicetree/bindings/interrupt-controller/apple,aic.yaml
> @@ -70,6 +70,33 @@ properties:
>    power-domains:
>      maxItems: 1
>  
> +  affinities:
> +    type: object

       additionalProperties: false

> +    description:
> +      FIQ affinity can be expressed as a single "affinities" node,
> +      containing a set of sub-nodes, one per FIQ with a non-default
> +      affinity.
> +    patternProperties:
> +      "^.+-affinity$":
> +        type: object

           additionalProperties: false

> +        properties:
> +          fiq-index:

apple,fiq-index

With that,

Reviewed-by: Rob Herring <robh@kernel.org>

> +            description:
> +              The interrupt number specified as a FIQ, and for which
> +              the affinity is not the default.
> +            $ref: /schemas/types.yaml#/definitions/uint32
> +            maximum: 5
> +
> +          cpus:
> +            $ref: /schemas/types.yaml#/definitions/phandle-array
> +            description:
> +              Should be a list of phandles to CPU nodes (as described in
> +              Documentation/devicetree/bindings/arm/cpus.yaml).
> +
> +        required:
> +          - fiq-index
> +          - cpus
> +
>  required:
>    - compatible
>    - '#interrupt-cells'
> -- 
> 2.30.2
> 
> 
