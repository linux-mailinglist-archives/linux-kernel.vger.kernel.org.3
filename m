Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23BD9493B8B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 14:59:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354980AbiASN7H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 08:59:07 -0500
Received: from mail-oo1-f44.google.com ([209.85.161.44]:43878 "EHLO
        mail-oo1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354967AbiASN7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 08:59:05 -0500
Received: by mail-oo1-f44.google.com with SMTP id l7-20020a4a2707000000b002dde197c749so739449oof.10;
        Wed, 19 Jan 2022 05:59:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uCDu8gGqnGOyopdxrK3qiBfxcFbMys/niWD98hfVaD0=;
        b=FpPndhbEuTKKl7frtTcFQjk+tWNKlV8GcDA/I6HBzRfeg4uine1QFgBLEFFeZUVRYL
         iLtCIJ0pqGAxa0ktgBCGi5nOmgQqrL65DLYglK5C6u0bB9LIZj+C+WIb1mjmJq6qM56I
         0jFunZ1DjK8UiBPjGeEpEixOpPAynDMp41GPbYqHBJRrDyt/IxJaqkKdY2EldjjycTV+
         kJTuUaUfwEEx+O31ORAQSAkR2i+8Zma3i+IPAJNj4P+C1uQWfMjMVXiC8pc2e7UYDZ1S
         mzMA1mcnteQlGwNvhF0FjhERModTCkWrpHEAGP0/kLyre+SOUu2G6KmsT6sI2QosbqzD
         pLdA==
X-Gm-Message-State: AOAM533NEd6MO2J983UVIYfyefem+oTxukRrgOCA5kGTvDqYIyTPkfBG
        7qVcvQsyBa2yiYZVSRczjZ54phgazQ==
X-Google-Smtp-Source: ABdhPJx0epZEPyzAogUKD4aR4quBy/ZKIJ9ZjAMR3zdMKxmVAMj2tHoDljG76kkBHOh4W73aUH30pQ==
X-Received: by 2002:a4a:db96:: with SMTP id s22mr19972002oou.66.1642600745068;
        Wed, 19 Jan 2022 05:59:05 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id w7sm6948270ott.4.2022.01.19.05.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 05:59:04 -0800 (PST)
Received: (nullmailer pid 3467736 invoked by uid 1000);
        Wed, 19 Jan 2022 13:59:03 -0000
Date:   Wed, 19 Jan 2022 07:59:03 -0600
From:   Rob Herring <robh@kernel.org>
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/14] dt-bindings: clock: Document qcom,gcc-ipq8064
 binding
Message-ID: <YegZJyIredPbQUKv@robh.at.kernel.org>
References: <20220118004434.17095-1-ansuelsmth@gmail.com>
 <20220118004434.17095-2-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220118004434.17095-2-ansuelsmth@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 18, 2022 at 01:44:21AM +0100, Ansuel Smith wrote:
> Document qcom,gcc-ipq8064 binding needed to declare pxo and cxo source
> clocks. The gcc node is also used by the tsens driver, already Documented,
> to get the calib nvmem cells and the base reg from gcc.
> 
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> ---
>  .../bindings/clock/qcom,gcc-ipq8064.yaml      | 67 +++++++++++++++++++
>  1 file changed, 67 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/qcom,gcc-ipq8064.yaml
> 
> diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-ipq8064.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-ipq8064.yaml
> new file mode 100644
> index 000000000000..2dc254fdf161
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/qcom,gcc-ipq8064.yaml
> @@ -0,0 +1,67 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/qcom,gcc-ipq8064.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm Global Clock & Reset Controller Binding for IPQ8064
> +
> +maintainers:
> +  - Ansuel Smith <ansuelsmth@gmail.com>
> +
> +description: |
> +  Qualcomm global clock control module which supports the clocks, resets and
> +  power domains on IPQ8064.
> +
> +properties:
> +  compatible:
> +    const: qcom,gcc-ipq8064
> +
> +  '#clock-cells':
> +    const: 1
> +
> +  '#reset-cells':
> +    const: 1
> +
> +  '#power-domain-cells':
> +    const: 1
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: PXO source
> +      - description: CX0 source
> +
> +  clock-names:
> +    items:
> +      - const: pxo
> +      - const: cxo
> +
> +required:
> +  - compatible
> +  - reg
> +  - '#clock-cells'
> +  - '#reset-cells'
> +  - '#power-domain-cells'
> +  - clocks
> +  - clock-names
> +
> +additionalProperties: true

Must be 'false'. True is only for incomplete schemas included by other 
schemas.

> +
> +examples:
> +  - |
> +    gcc: clock-controller@900000 {
> +      compatible = "qcom,gcc-ipq8064", "syscon";
> +      reg = <0x00900000 0x4000>;
> +      clocks = <&pxo_board>, <&cxo_board>;
> +      clock-names = "pxo", "cxo";
> +      #clock-cells = <1>;
> +      #reset-cells = <1>;
> +      #power-domain-cells = <1>;
> +
> +      /* Tsens node definition */

You need to define child nodes.

> +
> +    };
> +...
> -- 
> 2.33.1
> 
> 
