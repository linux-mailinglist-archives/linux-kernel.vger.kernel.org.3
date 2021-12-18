Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A28CC479A7A
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 12:02:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232868AbhLRLCN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 06:02:13 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:41448
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232848AbhLRLCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 06:02:12 -0500
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com [209.85.167.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 20BA03FFD9
        for <linux-kernel@vger.kernel.org>; Sat, 18 Dec 2021 11:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1639825331;
        bh=GUzaeCFYuvmlfIXasOI8CPD5nT7udP18GRuhsPnN/O4=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=X8GoVqhA+D2c9qr8fmhtOh6aGpsbgcuh/vzqYq35FVkFb+qLztZ5L619nhCUK8UEU
         vWnsBgaj4p1y7FAplT/UvUsnpjMxmEppqeMtMmoKGmz2EO1wiLsdm/V/o34KAqBMZf
         Oxr9IxcRAMq6ZWZLRflcyVXlMsnIlYDkDM9+JoouZ03Yj88Bzb3MKL8Jv1dO6u9hhf
         k4Aqd3QBr1oTYe2bXdcWgYonhrR9ZdRkHiYO0toLxLkSiHpTddiL8mO7DqOCgZ5sG7
         T5k8GIdXKO5G/T2qd8Lg8DvcR753zd5pR+0TxFT34yfcHnpT5U1fg9StweldeRd9XJ
         2/xdN6WOTR9sg==
Received: by mail-lf1-f70.google.com with SMTP id q13-20020a19f20d000000b0041fcb65b6c7so2166033lfh.8
        for <linux-kernel@vger.kernel.org>; Sat, 18 Dec 2021 03:02:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=GUzaeCFYuvmlfIXasOI8CPD5nT7udP18GRuhsPnN/O4=;
        b=e/G1C8ry4TrivWy+TY4gxPmw8dchuvvqoIyLhwpsB9I2MImYbh+bRoRYThWDRamPNN
         35vGYJVMBa4G6RjiYnCn7rFzDAAsWmuz4z6XizRQuZflaFBD4uebLBXzTaFAQZauj4sG
         7gLj3qmvM6ZvEGSDtUy6RhyWs5jzY9z1Jee/aTTskht/vr/RAhJW2WXQNyhZrr9fzoR3
         Kp9AAQZMtfrBnRr9xYN80VPrEQA+pZy+h+E0+1CsO8oCgtRZY38MQQbbyt5zWCcJrkO7
         PVNK+Qd4g272Gs4+SmvDA7IRmO5QWgtWKAIryMMBYfA9zc/1FJSSw9m8QJOCsZjsa5C3
         3Bjg==
X-Gm-Message-State: AOAM532OcmGGYWYWNsT9a2MChdW2nn7ADrJ8l+L2ejylYefpSqfu4jE+
        sKWlHr4hEaATj6PsVpvINxM1iai2KxGe0imSjcCO8korHeOjkLkb7LD5dYm0bkNLIqUGQOwaWak
        8J8uDw/qDoCNl/kIdcill2anTvtwvVb5d9BX+6yRbug==
X-Received: by 2002:a05:6512:1506:: with SMTP id bq6mr6899791lfb.118.1639825330065;
        Sat, 18 Dec 2021 03:02:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz76BRek5xxaxXK0gykfSceKpej+lAJ/MUNQimyMdvDsGknqATVKSV4qiXP216Y6DblSZl2Kw==
X-Received: by 2002:a05:6512:1506:: with SMTP id bq6mr6899780lfb.118.1639825329889;
        Sat, 18 Dec 2021 03:02:09 -0800 (PST)
Received: from [192.168.3.67] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id bu11sm917201lfb.15.2021.12.18.03.02.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Dec 2021 03:02:09 -0800 (PST)
Message-ID: <0778edf1-25c3-e375-9806-46c35c18e233@canonical.com>
Date:   Sat, 18 Dec 2021 12:02:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH 3/5] dt-bindings: memory: Add Tegra114 memory controller
 bindings
Content-Language: en-US
To:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Jon Hunter <jonathanh@nvidia.com>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211217165919.2700920-1-thierry.reding@gmail.com>
 <20211217165919.2700920-3-thierry.reding@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20211217165919.2700920-3-thierry.reding@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/12/2021 17:59, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> Document the bindings for the memory controller found on Tegra114 SoCs.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  .../nvidia,tegra114-mc.yaml                   | 85 +++++++++++++++++++
>  1 file changed, 85 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/nvidia,tegra114-mc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra114-mc.yaml b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra114-mc.yaml
> new file mode 100644
> index 000000000000..2fa50eb3aadb
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra114-mc.yaml
> @@ -0,0 +1,85 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/memory-controllers/nvidia,tegra114-mc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NVIDIA Tegra114 SoC Memory Controller
> +
> +maintainers:
> +  - Thierry Reding <thierry.reding@gmail.com>
> +  - Jon Hunter <jonathanh@nvidia.com>
> +
> +description: |
> +  The Tegra114 Memory Controller architecturally consists of the following parts:
> +
> +    Arbitration Domains, which can handle a single request or response per
> +    clock from a group of clients. Typically, a system has a single Arbitration
> +    Domain, but an implementation may divide the client space into multiple
> +    Arbitration Domains to increase the effective system bandwidth.
> +
> +    Protocol Arbiter, which manage a related pool of memory devices. A system
> +    may have a single Protocol Arbiter or multiple Protocol Arbiters.
> +
> +    Memory Crossbar, which routes request and responses between Arbitration
> +    Domains and Protocol Arbiters. In the simplest version of the system, the
> +    Memory Crossbar is just a pass through between a single Arbitration Domain
> +    and a single Protocol Arbiter.
> +
> +    Global Resources, which include things like configuration registers which
> +    are shared across the Memory Subsystem.
> +
> +  The Tegra114 Memory Controller handles memory requests from internal clients
> +  and arbitrates among them to allocate memory bandwidth for DDR3L and LPDDR2
> +  SDRAMs.
> +
> +properties:
> +  compatible:
> +    const: nvidia,tegra114-mc
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    items:
> +      - const: mc
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  "#reset-cells":
> +    const: 1
> +
> +  "#iommu-cells":
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +  - "#reset-cells"
> +  - "#iommu-cells"
> +
> +additionalProperties: false

The binding looks the same as Tegra210, Tegra 20 MC. What is the point
of having three separate binding documents which are exactly the same?


Best regards,
Krzysztof
