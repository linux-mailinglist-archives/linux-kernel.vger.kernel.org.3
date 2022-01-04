Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4716248481A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 19:53:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235913AbiADSx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 13:53:28 -0500
Received: from mail-ot1-f52.google.com ([209.85.210.52]:34537 "EHLO
        mail-ot1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232178AbiADSx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 13:53:27 -0500
Received: by mail-ot1-f52.google.com with SMTP id o3-20020a9d4043000000b0058f31f4312fso46217280oti.1;
        Tue, 04 Jan 2022 10:53:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cP0qBxJ5Vrhnegy+Z7Kue7h74Z5oi44JiMxAVZ0A8YU=;
        b=ngTmVTCT42cBC3aZcxrYZdNL0QFj6FegIRNUjSegr6yg3cOEvwzzOrsh0pwTLlLmZJ
         fDQyzUSkiOc0n/N9Xtb1Uswgc3/7PpvbXpVvNJd++iTPf98qXril9zh9BWTCu/FbO/RF
         RZrnu88MnZxAZ/jOQDX8M2cRngGhMzxzw7J694I34LAnedOMs/oDYrAaV+2Ka0CyYPZt
         4sx1inZ6JidoINtXa1XvOgX74gkqSWSUo3r/hCAw7C2xAUyB6/TVfaweqEzgiMBbjm12
         5wMDwjXiaDu3UX+EW/KrgdOGh0pq7LB+m39n0VRcpXxO1g4KMe5xUi1n1a/KfYiEGLpc
         Pwgg==
X-Gm-Message-State: AOAM530J0prC3m1t4Apv3oaXRQLg4Pwk3rLzb7cDLMNLWjnP8RTbK/1X
        Hu2MyJuNDxPnc8biFKUo/g==
X-Google-Smtp-Source: ABdhPJxR++JeZ9ZNDjbgZORmhCw55Ev7taZPH4EpgyVFkYJG/XJ7oA9Dhs1DIEICgAEJxJpI/o3ZTw==
X-Received: by 2002:a9d:7d99:: with SMTP id j25mr36610015otn.252.1641322407006;
        Tue, 04 Jan 2022 10:53:27 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id k19sm7951342oot.32.2022.01.04.10.53.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 10:53:26 -0800 (PST)
Received: (nullmailer pid 1202720 invoked by uid 1000);
        Tue, 04 Jan 2022 18:53:25 -0000
Date:   Tue, 4 Jan 2022 12:53:25 -0600
From:   Rob Herring <robh@kernel.org>
To:     David Heidelberg <david@ixit.cz>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <treding@nvidia.com>,
        ~okias/devicetree@lists.sr.ht, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: mmc: PL18x stop relying on order of
 dma-names
Message-ID: <YdSXpXI72sjrULVM@robh.at.kernel.org>
References: <20211224192545.74528-1-david@ixit.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211224192545.74528-1-david@ixit.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 24, 2021 at 08:25:45PM +0100, David Heidelberg wrote:
> We don't care in which order are "rx" and "tx" DMA names supplied.
> 

I do. Other than avoiding dts changes, why do we need undefined order 
here?

> Fixes: 4df297aaeb9c ("dt-bindings: mmc: Add missing properties used in examples")
> 

Drop the blank line.

> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  Documentation/devicetree/bindings/mmc/arm,pl18x.yaml | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/arm,pl18x.yaml b/Documentation/devicetree/bindings/mmc/arm,pl18x.yaml
> index f0a44b2cfa79..a4f74bec68a3 100644
> --- a/Documentation/devicetree/bindings/mmc/arm,pl18x.yaml
> +++ b/Documentation/devicetree/bindings/mmc/arm,pl18x.yaml
> @@ -70,9 +70,13 @@ properties:
>      maxItems: 2
>  
>    dma-names:
> -    items:
> -      - const: rx
> -      - const: tx
> +    oneOf:
> +      - items:
> +          - const: tx
> +          - const: rx
> +      - items:
> +          - const: rx
> +          - const: tx

For future reference, the concise way to express this is:

maxItems: 2
items:
  enum: [ rx, tx ]

>  
>    power-domains: true
>  
> -- 
> 2.34.1
> 
> 
