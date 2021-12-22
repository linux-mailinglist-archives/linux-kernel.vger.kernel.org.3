Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 552CA47CD02
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 07:31:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242765AbhLVGb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 01:31:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233175AbhLVGb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 01:31:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D6B1C061574;
        Tue, 21 Dec 2021 22:31:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2D24E6189F;
        Wed, 22 Dec 2021 06:31:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3A8AC36AE8;
        Wed, 22 Dec 2021 06:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640154685;
        bh=7NmdHcwB+/nylAMW4yN/VuHS9DzrX/FmHd8am4UiMOk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YfTI1iL0xhlOZc43ftoVaYHxzagg0aC/+9ABfisPvSFbJQfiRjuzHjBjmLrpWWyh2
         dp4NEr7mV86a1/NSFOzfMZ/zgWTKPZvgvDBNnjsy37THaxGD1VjmO4A95erKu9wGN0
         uG8XSqNSyNHWz3zdPx+vU7S964D/thEisKaLo+1RXvnQyf5KTLL0eRoXv26h3og8cc
         B7KtJJKWaOj7wa1RgNoClgpN2QyVDt2FuC52ZanUJ5rTrE7aH9GlSz8lX3aDKvi6Xn
         VU5czq5lSTIHg0C17dyZUsAjy79J8RIYBYWvoIVj/pbnFpz39dXmK62pJ/jUMFaO6p
         14QxKWboY+obw==
Date:   Wed, 22 Dec 2021 12:01:21 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     David Heidelberg <david@ixit.cz>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        ~okias/devicetree@lists.sr.ht, linux-arm-msm@vger.kernel.org,
        linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: crypto: convert Qualcomm PRNG to yaml
Message-ID: <YcLGOWSnIDFpNcW6@matsya>
References: <20211220184355.86582-1-david@ixit.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211220184355.86582-1-david@ixit.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-12-21, 19:43, David Heidelberg wrote:
> Convert Qualcomm PRNG documentation to yaml format.


Acked-By: Vinod Koul <vkoul@kernel.org>

> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  .../devicetree/bindings/crypto/qcom,prng.txt  | 19 --------
>  .../devicetree/bindings/crypto/qcom,prng.yaml | 43 +++++++++++++++++++
>  2 files changed, 43 insertions(+), 19 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/crypto/qcom,prng.txt
>  create mode 100644 Documentation/devicetree/bindings/crypto/qcom,prng.yaml
> 
> diff --git a/Documentation/devicetree/bindings/crypto/qcom,prng.txt b/Documentation/devicetree/bindings/crypto/qcom,prng.txt
> deleted file mode 100644
> index 7ee0e9eac973..000000000000
> --- a/Documentation/devicetree/bindings/crypto/qcom,prng.txt
> +++ /dev/null
> @@ -1,19 +0,0 @@
> -Qualcomm MSM pseudo random number generator.
> -
> -Required properties:
> -
> -- compatible  : should be "qcom,prng" for 8916 etc
> -              : should be "qcom,prng-ee" for 8996 and later using EE
> -		(Execution Environment) slice of prng
> -- reg         : specifies base physical address and size of the registers map
> -- clocks      : phandle to clock-controller plus clock-specifier pair
> -- clock-names : "core" clocks all registers, FIFO and circuits in PRNG IP block
> -
> -Example:
> -
> -	rng@f9bff000 {
> -		compatible = "qcom,prng";
> -		reg = <0xf9bff000 0x200>;
> -		clocks = <&clock GCC_PRNG_AHB_CLK>;
> -		clock-names = "core";
> -	};
> diff --git a/Documentation/devicetree/bindings/crypto/qcom,prng.yaml b/Documentation/devicetree/bindings/crypto/qcom,prng.yaml
> new file mode 100644
> index 000000000000..bb42f4588b40
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/crypto/qcom,prng.yaml
> @@ -0,0 +1,43 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/crypto/qcom,prng.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm Pseudo Random Number Generator
> +
> +maintainers:
> +  - Vinod Koul <vkoul@kernel.org>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - qcom,prng  # 8916 etc.
> +      - qcom,prng-ee  # 8996 and later using EE
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    items:
> +      - const: core
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    rng@f9bff000 {
> +        compatible = "qcom,prng";
> +        reg = <0xf9bff000 0x200>;
> +        clocks = <&clk 125>;
> +        clock-names = "core";
> +    };
> -- 
> 2.34.1

-- 
~Vinod
