Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82EC5479A73
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 11:59:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232801AbhLRK7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 05:59:30 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:57008
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232760AbhLRK73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 05:59:29 -0500
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com [209.85.167.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id E54023F044
        for <linux-kernel@vger.kernel.org>; Sat, 18 Dec 2021 10:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1639825167;
        bh=iKwmiQLDuY8LAE9jHuz/0Vr7mjQTQyKIClva1cDuOYA=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=FHByJwmDrBFEUkCTPOQXmSLU9kCGXKlB2Zcyce9yun5zAmkpYnRdJVF80y0kr/lID
         /YgWcbfi45gSQ7/JSI2gIG9J4KkHsPCJzhddeuqqM8tyMu/DSaeEfO/YqbngHQ5IlT
         xxek49Rj+u4wsKpM/Q5XRDJbaWTEob0lIL5X+q/8wnjJ4RyO2w0zvh8OYf18Or7hW5
         y98xzbT+WV3vS5eBupWqDsJFz5Q6nfndGQ4u5qoF+/loaVPfQyumYiAjCSLhJGM1+E
         c6VsK2pHElTV1ETN6bMBQEx0BW+QES37r8y9886jd5CegFPPGT4BK/GAVpM6RG8Jzl
         8CdSk/0dYzLoQ==
Received: by mail-lf1-f69.google.com with SMTP id q26-20020ac2515a000000b0040adfeb8132so2149240lfd.9
        for <linux-kernel@vger.kernel.org>; Sat, 18 Dec 2021 02:59:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=iKwmiQLDuY8LAE9jHuz/0Vr7mjQTQyKIClva1cDuOYA=;
        b=WMh484oejGwwg09gaIh+ZV7drY7JScRlTFfonyTVupC7UZJmNMAcjqi/ME4tqbYxaK
         w5f5odttg++vnWCOsaukwCmdJ81z6tmy7uVpNOoSDy8MS/i0TrbA+vVDgZGXFj2wWnub
         5xUhJPP+jl5xZ1s3HJUvzCEYfVrPfV1Ym6A4M0Rgx92ebvZYGioaldKMAKl6KIB6nKlL
         If0rgWyXFc8yEO6J0vvU5of4pKn9iZQlKRHx6nz79iTkeciX0I3d4JdzMY4pFd34GIhC
         qb0+tPmTW+Otfk2f2IFK4qley7vRW24I0z64yITejKB8dipoIwZxxVFpD1mLyk3RwmGM
         V3gA==
X-Gm-Message-State: AOAM533YVZ0+Wj6WCfACNP+zqghv3p9XRB3rW+ammEbhfUq0r7JhWC9i
        5SduMJPuQTRPXnBr5Mni0nDalpsh532i/bOYsBSutujQWZIH6Hb5Mf9+syi+NMKjFg0haBFcYPy
        14kbbQRb9y/xFoROD5k+RkDKomCmG+qgeiom6hX41vQ==
X-Received: by 2002:ac2:4142:: with SMTP id c2mr6806189lfi.608.1639825167353;
        Sat, 18 Dec 2021 02:59:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx2EVD6v55ZbjvTY15Qiz1fXJ3yFxwDBZMbkwGZYLQ9xoefSrFNyVjgHsqQXhV4QAt8jp/v1g==
X-Received: by 2002:ac2:4142:: with SMTP id c2mr6806172lfi.608.1639825167152;
        Sat, 18 Dec 2021 02:59:27 -0800 (PST)
Received: from [192.168.3.67] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id x11sm142447lfr.171.2021.12.18.02.59.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Dec 2021 02:59:26 -0800 (PST)
Message-ID: <d64330da-3ced-b37e-4bc9-ba7556822f7d@canonical.com>
Date:   Sat, 18 Dec 2021 11:59:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH 2/5] dt-bindings: memory: Add Tegra210 memory controller
 bindings
Content-Language: en-US
To:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Jon Hunter <jonathanh@nvidia.com>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211217165919.2700920-1-thierry.reding@gmail.com>
 <20211217165919.2700920-2-thierry.reding@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20211217165919.2700920-2-thierry.reding@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/12/2021 17:59, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> Document the bindings for the memory controller found on Tegra210 SoCs.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  .../nvidia,tegra210-mc.yaml                   | 77 +++++++++++++++++++
>  1 file changed, 77 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/nvidia,tegra210-mc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra210-mc.yaml b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra210-mc.yaml
> new file mode 100644
> index 000000000000..ef21c11052e3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra210-mc.yaml
> @@ -0,0 +1,77 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/memory-controllers/nvidia,tegra210-mc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NVIDIA Tegra210 SoC Memory Controller
> +
> +maintainers:
> +  - Thierry Reding <thierry.reding@gmail.com>
> +  - Jon Hunter <jonathanh@nvidia.com>
> +
> +description: |
> +  The NVIDIA Tegra210 SoC features a 64 bit memory controller that is split into two 32 bit
> +  channels to support LPDDR3 and LPDDR4 with x16 subpartitions. The MC handles memory requests for
> +  34-bit virtual addresses from internal clients and arbitrates among them to allocate memory
> +  bandwidth.
> +
> +  Up to 8 GiB of physical memory can be supported. Security features such as encryption of traffic
> +  to and from DRAM via general security apertures are available for video and other secure
> +  applications.
> +
> +properties:
> +  $nodename:
> +    pattern: "^memory-controller@[0-9a-f]+$"
> +
> +  compatible:
> +    items:
> +      - enum:
> +          - nvidia,tegra210-mc
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: module clock
> +
> +  clock-names:
> +    items:
> +      - const: mc
> +
> +  "#iommu-cells":
> +    const: 1
> +
> +  "#reset-cells":
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +  - "#iommu-cells"
> +  - "#reset-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/tegra210-car.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    mc: memory-controller@70019000 {

If there is going to be resubmit, please skip the alias. It just adds
noise. Without resubmit, I can fix it when applying.


Best regards,
Krzysztof
