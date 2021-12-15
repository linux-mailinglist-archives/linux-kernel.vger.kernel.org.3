Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFDE34764A2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 22:35:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbhLOVfU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 16:35:20 -0500
Received: from mail-ot1-f42.google.com ([209.85.210.42]:37560 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbhLOVfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 16:35:19 -0500
Received: by mail-ot1-f42.google.com with SMTP id h19-20020a9d3e53000000b0056547b797b2so26507340otg.4;
        Wed, 15 Dec 2021 13:35:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Z+q7c1SY7BtuKP5J3/jz8SZvfLkzNTnGUuY7j/mzAHc=;
        b=nCzwAqGls8MjCQiPAP64M00V1nn5sRy2vla3XlZ4gTFIpcqtL1Bo1/UzkTQ2M8Z6Hk
         I8lrdsZT9uVbc6wXgX3hyysmy1vtpR9XTNKdnnUR715T8IR6x46gIflHSIUPOnaOCGgv
         99ILDPkxmDTKNqcshJH+rfZaTFvXsBx0QFhI6J1vGMuLgRe93y8TfE4jRn22CSgYrEqk
         Zr5PiiFqctVcaIoETqNV6LgX+pgJLSD3Y7h52jEkDnf5RvCNbl68ciyC4vIWWcjqE+Eo
         AuMtrQmxkwiQo2LLjHN0CvYuTlBuPmPQWs2UQEIi0dxIzdri3cnTlw5Wv23F68ioB1Id
         Isdw==
X-Gm-Message-State: AOAM531vjlsfeEpxqm/zZDomVV+LmZUWmLcZxMlJxChkbUo3kZ2CbSRi
        ibdrZccvp7K8JYeTZBCDng==
X-Google-Smtp-Source: ABdhPJyxJk251z35S8Jgh8xmkk0PNxS6+ErkCImJCh4gEyMmYR6BAMyQtiw/YYMx64IPyqYDivd+8Q==
X-Received: by 2002:a05:6830:1b64:: with SMTP id d4mr10561743ote.310.1639604118473;
        Wed, 15 Dec 2021 13:35:18 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id x4sm545522oiv.35.2021.12.15.13.35.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 13:35:17 -0800 (PST)
Received: (nullmailer pid 1880044 invoked by uid 1000);
        Wed, 15 Dec 2021 21:35:16 -0000
Date:   Wed, 15 Dec 2021 15:35:16 -0600
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
Subject: Re: [PATCH v3 03/10] dt-bindings: apple,aic: Add affinity
 description for per-cpu pseudo-interrupts
Message-ID: <YbpflHyduDzZb3vx@robh.at.kernel.org>
References: <20211214182634.727330-1-maz@kernel.org>
 <20211214182634.727330-4-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211214182634.727330-4-maz@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2021 at 06:26:27PM +0000, Marc Zyngier wrote:
> Some of the FIQ per-cpu pseudo-interrupts are better described with
> a specific affinity, the most obvious candidate being the CPU PMUs.
> 
> Augment the AIC binding to be able to specify that affinity in the
> interrupt controller node.
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  .../interrupt-controller/apple,aic.yaml       | 26 +++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/apple,aic.yaml b/Documentation/devicetree/bindings/interrupt-controller/apple,aic.yaml
> index b95e41816953..ac1c82cffa0a 100644
> --- a/Documentation/devicetree/bindings/interrupt-controller/apple,aic.yaml
> +++ b/Documentation/devicetree/bindings/interrupt-controller/apple,aic.yaml
> @@ -67,6 +67,32 @@ properties:
>        Specifies base physical address and size of the AIC registers.
>      maxItems: 1
>  
> +  affinities:
> +    type: object
> +    description:
> +      FIQ affinity can be expressed as a single "affinities" node,
> +      containing a set of sub-nodes, one per FIQ with a non-default
> +      affinity.
> +    patternProperties:
> +      "^.+-affinity$":
> +        type: object
> +        properties:
> +          fiq-index:
> +            description:
> +              The interrupt number specified as a FIQ, and for which
> +              the affinity is not the default.
> +            $ref: /schemas/types.yaml#/definitions/uint32
> +            maximum: 5

blank line between each prop.

> +          affinity:

'cpus' is already somewhat established for list of phandles to cpu 
nodes.

> +            $ref: /schemas/types.yaml#/definitions/phandle-array
> +            description:
> +              Should be a list of phandles to CPU nodes (as described in
> +              Documentation/devicetree/bindings/arm/cpus.yaml).
> +
> +        required:
> +          - fiq-index
> +          - affinity
> +
>  required:
>    - compatible
>    - '#interrupt-cells'
> -- 
> 2.30.2
> 
> 
