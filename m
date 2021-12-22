Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1590247D6EB
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 19:35:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344750AbhLVSfc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 13:35:32 -0500
Received: from mail-qv1-f44.google.com ([209.85.219.44]:45917 "EHLO
        mail-qv1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233997AbhLVSfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 13:35:31 -0500
Received: by mail-qv1-f44.google.com with SMTP id a9so3071473qvd.12;
        Wed, 22 Dec 2021 10:35:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wddvJKAjEcziM4JqMrIWh39VyvuNvYrlg87KqL78R3k=;
        b=tifJlH84BhxhIY7lq/s52QZzvuk1xHcyi4wKhW3aprARQ4Vr8mqO1TjE0z2xhb5qnQ
         gdek0F8+wd/bwkSs2/Mb2kjqP9oNA8ZF2DGrM/n0yKeJyHW7e/Sts7w02aXyECfbVFhG
         L13JFiSj2LNPSeCdotwgATO0vHYHlp6r2/FBPPXiXB+ELp9Ea029dLO1226VW/jJrATU
         8svw5ZSqdQJHPW0DDUIKtzoXfl3Fu+OPuoETFy/xphBoawQy5SnRI3y2l1uYZYwGaugL
         B25TjfoREDpYFKAwqQ1UgT8k7jB2Fn+D37PBo17kbOwUBlgSYmokJ2SnsKpGcofPZEyF
         V7Tw==
X-Gm-Message-State: AOAM530rRBLIWu9tcpkHjpdTnWEx2NVQvDWd6PSPua1B7PmpyfZVsAkx
        itvX87xZZ6621PEkYmpCNRXRdXIJcrXd
X-Google-Smtp-Source: ABdhPJxhIH2nLhxHUmJ9ealzrumRvQGjwfnGIcUS/n07yDQLdGrm95e8KglsOX+17uY9I9UC3ku9CA==
X-Received: by 2002:ad4:5be5:: with SMTP id k5mr3545749qvc.124.1640198130421;
        Wed, 22 Dec 2021 10:35:30 -0800 (PST)
Received: from robh.at.kernel.org ([24.55.105.145])
        by smtp.gmail.com with ESMTPSA id d27sm2157772qko.132.2021.12.22.10.35.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 10:35:29 -0800 (PST)
Received: (nullmailer pid 2475434 invoked by uid 1000);
        Wed, 22 Dec 2021 18:35:27 -0000
Date:   Wed, 22 Dec 2021 14:35:27 -0400
From:   Rob Herring <robh@kernel.org>
To:     Sumit Gupta <sumitg@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, thierry.reding@gmail.com,
        jonathanh@nvidia.com, kbuild-all@lists.01.org, bbasu@nvidia.com,
        vsethi@nvidia.com, jsequeira@nvidia.com,
        Thierry Reding <treding@nvidia.com>
Subject: Re: [Patch v3 3/9] dt-bindings: arm: tegra: Add NVIDIA Tegra194
 axi2apb binding
Message-ID: <YcNv7xm19sFTlfjW@robh.at.kernel.org>
References: <20211221125117.6545-1-sumitg@nvidia.com>
 <20211221125117.6545-4-sumitg@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211221125117.6545-4-sumitg@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 21, 2021 at 06:21:11PM +0530, Sumit Gupta wrote:
> Add device-tree binding documentation to represent the axi2apb bridges
> used by Control Backbone (CBB) 1.0 in Tegra194 SOC. All errors for APB
> slaves are reported as slave error because APB bas single bit to report
> error. So, CBB driver needs to further check error status registers of
> all the axi2apb bridges to find error type.
> 
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  .../arm/tegra/nvidia,tegra194-axi2apb.yaml    | 40 +++++++++++++++++++
>  1 file changed, 40 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/tegra/nvidia,tegra194-axi2apb.yaml
> 
> diff --git a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra194-axi2apb.yaml b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra194-axi2apb.yaml
> new file mode 100644
> index 000000000000..788a13f8aa93
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra194-axi2apb.yaml
> @@ -0,0 +1,40 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/arm/tegra/nvidia,tegra194-axi2apb.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: NVIDIA Tegra194 AXI2APB bridge
> +
> +maintainers:
> +  - Sumit Gupta <sumitg@nvidia.com>
> +
> +properties:
> +  $nodename:
> +    pattern: "^axi2apb@([0-9a-f]+)$"
> +
> +  compatible:
> +    enum:
> +      - nvidia,tegra194-axi2apb
> +
> +  reg:
> +    maxItems: 6
> +    description: Physical base address and length of registers for all bridges
> +
> +additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +
> +examples:
> +  - |
> +    axi2apb: axi2apb@2390000 {

As axi2apb appears to be a bus, then all the child nodes (APB devices) 
should be under this node.

Is NVidia still putting all the devices at the root level rather than 
under a bus node which is preferred?

> +      compatible = "nvidia,tegra194-axi2apb";
> +      reg = <0x02390000 0x1000>,
> +            <0x023a0000 0x1000>,
> +            <0x023b0000 0x1000>,
> +            <0x023c0000 0x1000>,
> +            <0x023d0000 0x1000>,
> +            <0x023e0000 0x1000>;
> +    };
> -- 
> 2.17.1
> 
> 
