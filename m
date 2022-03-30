Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA5ED4EBFA6
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 13:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343556AbiC3LQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 07:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343553AbiC3LQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 07:16:00 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 925CEDF9B;
        Wed, 30 Mar 2022 04:14:14 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id e5so20168020pls.4;
        Wed, 30 Mar 2022 04:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=22f31UDp1UVUDsv1k+0Goozxl/zCGPew/x8b337ojQ8=;
        b=WtrcA8KpykmVc1ZfjqTAm039LeHU6t1MJtcNLTmBtxRraS4GqqA+jKbtFZxeI3y/8r
         jxu4D8/kcBJ6UOEJhQ7u9IF6VmT3eS/ANozDoeW6n3UBp111S4CA86Co+hrIDFWFa+D4
         3iWY5RuVZlqNdkq13ji8X+ZBj6INjuU3ErZuQP8Emn0wZh9IfCbuA6sT25FGR+2mm2zF
         62G7HU536GdLhpcXFGuIirh0kjzXSC02A6H6CHlLlMn7Yq1iDjOQ3FE56ih73EIYmfee
         eoNFT6p7+fBed7ZtxTc1WTJ3m95vTrJO0hMFUcLdjaaBSEC/NuCWmgWDooPWH4hfNuwn
         LF0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=22f31UDp1UVUDsv1k+0Goozxl/zCGPew/x8b337ojQ8=;
        b=ucX8sw9d93xWi3qkhbykRSrJ5K6W1ZUTh473QZlY/WTs+m8RnyE/+Jr6pB6N1OmE62
         mEGaUD5ZjTg0DntrqpRqLhq+9vVd1lp5Jnzele2C/+aVN6guhrKvTrAvI5zML/0pknL+
         TKR7zM21+CEYQvuMoEXOEz+IhBRgwmH9r8wQEUJQSYx+tzyRciBCrXr8oUEr0YUuez8Z
         u4QBfDczReSDKCg+MMCAC8pQZYCxFfy+RgFU9f4q7LJni+D21MPYvVQ20dISiV40S/T6
         KmZ9vVJD3Offqh17AKqsX3nrq6862PTDsNQFZyBDBuQuDuNzZGo1jOfjPDfiNk6Z8jHG
         JItA==
X-Gm-Message-State: AOAM532fL1W4Zt9/YYk58aBflQEanrI6qAjsebtd+3jThIx/50RAA7AR
        dcx7wdVG//gUwzrzO7Uk+pO4sNCkIrw=
X-Google-Smtp-Source: ABdhPJwD3DndapDHCHa1GaQhheLH9WN1jpG5fTtJg0rhgywC7GKmLUW6dESK+fpmBVKykC7HYIgkVA==
X-Received: by 2002:a17:902:c949:b0:154:5215:1db1 with SMTP id i9-20020a170902c94900b0015452151db1mr34742584pla.163.1648638853697;
        Wed, 30 Mar 2022 04:14:13 -0700 (PDT)
Received: from 9a2d8922b8f1 ([122.161.51.18])
        by smtp.gmail.com with ESMTPSA id ip1-20020a17090b314100b001c7b10fe359sm6498048pjb.5.2022.03.30.04.14.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 04:14:13 -0700 (PDT)
Date:   Wed, 30 Mar 2022 16:44:07 +0530
From:   Kuldeep Singh <singh.kuldeep87k@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] spi: dt-bindings: qcom,spi-geni-qcom: convert to
 dtschema
Message-ID: <20220330111407.GA51399@9a2d8922b8f1>
References: <20220329112717.252647-1-krzysztof.kozlowski@linaro.org>
 <20220330062313.GA51331@9a2d8922b8f1>
 <ac686e08-008f-be08-db5e-b6d4d08df315@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac686e08-008f-be08-db5e-b6d4d08df315@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 30, 2022 at 08:48:38AM +0200, Krzysztof Kozlowski wrote:
> On 30/03/2022 08:23, Kuldeep Singh wrote:
> > On Tue, Mar 29, 2022 at 01:27:16PM +0200, Krzysztof Kozlowski wrote:
> >> Convert the GENI based Qualcomm Universal Peripheral (QUP) Serial
> >> Peripheral Interface (SPI) bindings to DT Schema.
> >>
> >> The original bindings in TXT were not complete, so add during conversion
> >> properties already used in DTS and/or in the driver: reg-names, dmas,
> >> interconnects, operating points and power-domains.
> >>
> >> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >> ---
> >>  .../bindings/spi/qcom,spi-geni-qcom.txt       |  39 ------
> >>  .../bindings/spi/qcom,spi-geni-qcom.yaml      | 131 ++++++++++++++++++
> >>  2 files changed, 131 insertions(+), 39 deletions(-)
> >>  delete mode 100644 Documentation/devicetree/bindings/spi/qcom,spi-geni-qcom.txt
> >>  create mode 100644 Documentation/devicetree/bindings/spi/qcom,spi-geni-qcom.yaml
> >>
> >> diff --git a/Documentation/devicetree/bindings/spi/qcom,spi-geni-qcom.txt b/Documentation/devicetree/bindings/spi/qcom,spi-geni-qcom.txt
> >> deleted file mode 100644
> >> index c8c1e913f4e7..000000000000
> >> --- a/Documentation/devicetree/bindings/spi/qcom,spi-geni-qcom.txt
> >> +++ /dev/null
> >> @@ -1,39 +0,0 @@
> >> -GENI based Qualcomm Universal Peripheral (QUP) Serial Peripheral Interface (SPI)
> >> -
> >> -The QUP v3 core is a GENI based AHB slave that provides a common data path
> >> -(an output FIFO and an input FIFO) for serial peripheral interface (SPI)
> >> -mini-core.
> >> -
> >> -SPI in master mode supports up to 50MHz, up to four chip selects, programmable
> >> -data path from 4 bits to 32 bits and numerous protocol variants.
> >> -
> >> -Required properties:
> >> -- compatible:		Must contain "qcom,geni-spi".
> >> -- reg:			Must contain SPI register location and length.
> >> -- interrupts:		Must contain SPI controller interrupts.
> >> -- clock-names:		Must contain "se".
> >> -- clocks:		Serial engine core clock needed by the device.
> >> -- #address-cells:	Must be <1> to define a chip select address on
> >> -			the SPI bus.
> >> -- #size-cells:		Must be <0>.
> >> -
> >> -SPI Controller nodes must be child of GENI based Qualcomm Universal
> >> -Peripharal. Please refer GENI based QUP wrapper controller node bindings
> >> -described in Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.yaml.
> >> -
> >> -SPI slave nodes must be children of the SPI master node and conform to SPI bus
> >> -binding as described in Documentation/devicetree/bindings/spi/spi-bus.txt.
> >> -
> >> -Example:
> >> -	spi0: spi@a84000 {
> >> -		compatible = "qcom,geni-spi";
> >> -		reg = <0xa84000 0x4000>;
> >> -		interrupts = <GIC_SPI 354 IRQ_TYPE_LEVEL_HIGH>;
> >> -		clock-names = "se";
> >> -		clocks = <&clock_gcc GCC_QUPV3_WRAP0_S0_CLK>;
> >> -		pinctrl-names = "default", "sleep";
> >> -		pinctrl-0 = <&qup_1_spi_2_active>;
> >> -		pinctrl-1 = <&qup_1_spi_2_sleep>;
> >> -		#address-cells = <1>;
> >> -		#size-cells = <0>;
> >> -	};
> >> diff --git a/Documentation/devicetree/bindings/spi/qcom,spi-geni-qcom.yaml b/Documentation/devicetree/bindings/spi/qcom,spi-geni-qcom.yaml
> >> new file mode 100644
> >> index 000000000000..a85ff02ba1db
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/spi/qcom,spi-geni-qcom.yaml
> >> @@ -0,0 +1,131 @@
> >> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> >> +%YAML 1.2
> >> +---
> >> +$id: http://devicetree.org/schemas/spi/qcom,spi-geni-qcom.yaml#
> >> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >> +
> >> +title: GENI based Qualcomm Universal Peripheral (QUP) Serial Peripheral Interface (SPI)
> >> +
> >> +maintainers:
> >> +  - Andy Gross <agross@kernel.org>
> >> +  - Bjorn Andersson <bjorn.andersson@linaro.org>
> >> +  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >> +
> >> +description:
> >> +  The QUP v3 core is a GENI based AHB slave that provides a common data path
> >> +  (an output FIFO and an input FIFO) for serial peripheral interface (SPI)
> >> +  mini-core.
> >> +
> >> +  SPI in master mode supports up to 50MHz, up to four chip selects,
> >> +  programmable data path from 4 bits to 32 bits and numerous protocol variants.
> >> +
> >> +  SPI Controller nodes must be child of GENI based Qualcomm Universal
> >> +  Peripharal. Please refer GENI based QUP wrapper controller node bindings
> >> +  described in Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.yaml.
> >> +
> >> +allOf:
> >> +  - $ref: /spi/spi-controller.yaml#
> > 
> > Rob sometime back sent an update on how to refer absolute paths.
> > Please see below:
> > https://lore.kernel.org/linux-spi/20220325215652.525383-1-robh@kernel.org/
> 
> Yes, this is wrong. I copied other existing schema without checking. :(

No issues.

> 
> > 
> >> +
> >> +properties:
> >> +  compatible:
> >> +    const: qcom,geni-spi
> >> +
> >> +  clocks:
> >> +    maxItems: 1
> >> +
> >> +  clock-names:
> >> +    const: se
> >> +
> >> +  dmas:
> >> +    maxItems: 2
> >> +
> >> +  dma-names:
> >> +    items:
> >> +      - const: tx
> >> +      - const: rx
> >> +
> >> +  interconnects:
> >> +    minItems: 2
> > 
> > We can skip minItems here.
> > As minimim value defaults to maximum if not defined.
> 
> True.
> 
> > 
> >> +    maxItems: 2
> >> +
> >> +  interconnect-names:
> >> +    items:
> >> +      - const: qup-core
> >> +      - const: qup-config
> > 
> > Some properties like clocks, dmas, dma-names, interconnect etc. are
> > defined as common child properties of geni based qup.
> > Please see Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.yaml
> > 
> > Shouldn't we skip these entities here? as spi reference will anyway be
> > used in geni-se.yaml.
> 
> We could have them there, just like we could store all of this schema
> there. Having something half-here-half-there will not work, because this
> schema won't validate.
> 
> Therefore all of child properties from qcom,geni-se.yaml should be
> rather moved to child schema (which is included directly in my patch #2).

Sure, this looks good.
Probably we can remove common properties from geni-se.yaml once all
child nodes have their respective schemas.

-Kuldeep
