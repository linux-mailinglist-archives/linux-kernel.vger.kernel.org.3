Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94A7547C60C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 19:13:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241038AbhLUSNO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 13:13:14 -0500
Received: from mail-qk1-f175.google.com ([209.85.222.175]:37543 "EHLO
        mail-qk1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240915AbhLUSNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 13:13:13 -0500
Received: by mail-qk1-f175.google.com with SMTP id m186so13393544qkb.4;
        Tue, 21 Dec 2021 10:13:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FgGg2+AitqaP56Vm5YjQbOGniqdnRT3Htjx11pTGsHI=;
        b=Da7tFk/6tYiRshAfP61sYreV1E/+BbSJNkMnGtPtKU0wNFw11NXZ/igXaqyqSWFFBK
         sWb3NsVAj7Qifkyte18rLu5++QAMRKpOZ667Usam2zDrBTWXT/GwxP8FISB7qW/rHjD/
         zut5GLlaFGAzU0fxSxIZnfljHVzqGpzyIJvub5/F0BskLp7cRMrWDPfLWAyMBMmx92P2
         uazpVdsg2CIZbFiSD2vlUpegax2WQeUOKP84oD2L8V+ikIW9aRgq2/4b0PKuMafxkaiT
         NxdOXEWVzUbXzbx7i7dJ0FmnQtdO0BtYV2nTgjYBlR6wcpQRjzmRePizn5gDSRBn6ZDf
         e8gA==
X-Gm-Message-State: AOAM532EFPldzYsAxAgaudZJSkq3BZ3b7wcF9+6NCGk7VEAaSB9TAonI
        X4VDKVZTBXWJDi967GM9Hw==
X-Google-Smtp-Source: ABdhPJzQOQFLlDsziLyuvLEMaPbhJnT/tO8cXDb76gkkArdTN7ToTzKDvDS0PliXy7FOIxJcAUWOrg==
X-Received: by 2002:a05:620a:f12:: with SMTP id v18mr3010095qkl.720.1640110392914;
        Tue, 21 Dec 2021 10:13:12 -0800 (PST)
Received: from robh.at.kernel.org ([24.55.105.145])
        by smtp.gmail.com with ESMTPSA id t18sm18368027qtw.64.2021.12.21.10.13.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 10:13:12 -0800 (PST)
Received: (nullmailer pid 1519162 invoked by uid 1000);
        Tue, 21 Dec 2021 18:13:09 -0000
Date:   Tue, 21 Dec 2021 14:13:09 -0400
From:   Rob Herring <robh@kernel.org>
To:     Tony Lindgren <tony@atomide.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-omap@vger.kernel.org,
        Tero Kristo <kristo@kernel.org>
Subject: Re: [PATCH] dt-bindings: clock: Add binding for TI clksel
Message-ID: <YcIZNfTn37uNbj0F@robh.at.kernel.org>
References: <20211217113640.59840-1-tony@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211217113640.59840-1-tony@atomide.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 17, 2021 at 01:36:40PM +0200, Tony Lindgren wrote:
> In order to prepare for fixing lots of devicetree unique_unit_address
> warnings for the TI clock nodes, let's add a binding for the clksel
> clocks. This allows us to move the overlapping devicetree clocks to be
> children of the related clksel nodes. And then we need the reg property
> only for the parent clksel node.
> 
> We want to set #clock-cells = <1> in case we ever start parsing the clkcsel
> clocks directly using a clksel driver rather than using the existing
> component clock drivers and child nodes. We also need to update the clock
> drivers to get the IO address from the parent clksel node before updating
> the dts files. These will be posted as separate patches.
> 
> Cc: Tero Kristo <kristo@kernel.org>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  .../bindings/clock/ti/ti,clksel.yaml          | 41 +++++++++++++++++++
>  1 file changed, 41 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/ti/ti,clksel.yaml
> 
> diff --git a/Documentation/devicetree/bindings/clock/ti/ti,clksel.yaml b/Documentation/devicetree/bindings/clock/ti/ti,clksel.yaml
> new file mode 100644
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/ti/ti,clksel.yaml
> @@ -0,0 +1,41 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/ti/ti,clksel.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Binding for TI clksel clock
> +
> +maintainers:
> +  - Tony Lindgren <tony@atomide.com>
> +
> +description: |
> +  The TI CLKSEL clocks consist of consist of a mux, divider, multiplier and
> +  gate bits.
> +
> +properties:
> +  compatible:
> +    const: ti,clksel
> +
> +  reg:
> +    maxItems: 1
> +    description: The CLKSEL register
> +
> +  "#clock-cells":
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - "#clock-cells"
> +
> +additionalProperties: true

Like what properties?

true is only used for common, incomplete schemas referenced by device 
schemas.

> +
> +examples:
> +  - |
> +    clksel_gfx_fclk: clock@52c {
> +      compatible = "ti,clksel";
> +      reg = <0x25c 0x4>;
> +      #clock-cells = <1>;
> +    };
> +...
> -- 
> 2.34.1
> 
