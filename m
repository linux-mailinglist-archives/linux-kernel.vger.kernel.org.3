Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F0AF47D5BF
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 18:20:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344253AbhLVRUe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 12:20:34 -0500
Received: from mail-qv1-f53.google.com ([209.85.219.53]:42613 "EHLO
        mail-qv1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbhLVRUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 12:20:33 -0500
Received: by mail-qv1-f53.google.com with SMTP id q4so2903181qvh.9;
        Wed, 22 Dec 2021 09:20:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=a0nsqOSUC19qSjY8cD/nHB7fi0tQEVn7WPyxI3iDGdE=;
        b=pTRermqo0hTO10KrLEeFmEpzyjFZYp6ZOQxqxuYRMBNDOVujYddmx069qiAWxCAJ6i
         PqDBE10YjICm6rOjNXvaPLY6x16RuQXKZrsfbQbNA+yF01wZWdenVriSluNk/CZnr46V
         Y3Bc2FSeG23rtG+abynjparBbC1ReRinMLH9pVBB1zy1XQNPglw1FJvQ1eOW/jZPgs3X
         DmRkEizZMhiDXBCHO0kFV2Uo2v2CZX/GwifPMQPhBwnMtLAvEUlOO/RYDyZEdnEkCXWY
         tLxabXgF/5fdx+3EhbcM8VzQcFFVUk/KIxr/Jlj/PcBhNpfqoDJogd2+f/iQlDLxo0PX
         sDRA==
X-Gm-Message-State: AOAM530BuxkKYbSUSRzVt4EXyCnzgSre/J6yvxyw2469SLhxAeflIos8
        +8AUlXSjr/P0EBPTOT1Z1w==
X-Google-Smtp-Source: ABdhPJzE/OH+L8kidyFrzZMckxaEXTWuD4w5ageV1YGENdTSThNnLhLCIv7WIwxTBr2rs+e6UQAb6Q==
X-Received: by 2002:a05:6214:c42:: with SMTP id r2mr3273655qvj.53.1640193632837;
        Wed, 22 Dec 2021 09:20:32 -0800 (PST)
Received: from robh.at.kernel.org ([24.55.105.145])
        by smtp.gmail.com with ESMTPSA id r187sm2124946qke.11.2021.12.22.09.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 09:20:32 -0800 (PST)
Received: (nullmailer pid 2351409 invoked by uid 1000);
        Wed, 22 Dec 2021 17:20:30 -0000
Date:   Wed, 22 Dec 2021 13:20:30 -0400
From:   Rob Herring <robh@kernel.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Jon Hunter <jonathanh@nvidia.com>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] dt-bindings: memory: tegra210: Mark EMC as cooling
 device
Message-ID: <YcNeXgRyxvIkcgiD@robh.at.kernel.org>
References: <20211217165919.2700920-1-thierry.reding@gmail.com>
 <20211217165919.2700920-5-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211217165919.2700920-5-thierry.reding@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 17, 2021 at 05:59:19PM +0100, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> The external memory controller found on Tegra210 can use throttling of
> the EMC frequency in order to reduce the memory chip temperature. Mark
> the memory controller as a cooling device to take advantage of this
> functionality.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  .../bindings/memory-controllers/nvidia,tegra210-emc.yaml  | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra210-emc.yaml b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra210-emc.yaml
> index bc8477e7ab19..95c14deb8941 100644
> --- a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra210-emc.yaml
> +++ b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra210-emc.yaml
> @@ -44,6 +44,11 @@ properties:
>      description:
>        phandle of the memory controller node
>  
> +allOf:
> +  - $ref: ../thermal/thermal-cooling-devices.yaml

/schemas/thermal/...

With that,

Reviewed-by: Rob Herring <robh@kernel.org>

> +
> +unevaluatedProperties: false
> +
>  required:
>    - compatible
>    - reg
> @@ -51,8 +56,6 @@ required:
>    - clock-names
>    - nvidia,memory-controller
>  
> -additionalProperties: false
> -
>  examples:
>    - |
>      #include <dt-bindings/clock/tegra210-car.h>
> @@ -79,4 +82,5 @@ examples:
>          interrupts = <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>;
>          memory-region = <&emc_table>;
>          nvidia,memory-controller = <&mc>;
> +        #cooling-cells = <2>;
>      };
> -- 
> 2.34.1
> 
> 
