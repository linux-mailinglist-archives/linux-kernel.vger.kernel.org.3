Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D07D534A3C
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 07:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345848AbiEZFrC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 01:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231845AbiEZFqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 01:46:54 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CAE68A308;
        Wed, 25 May 2022 22:46:49 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 24Q5kiBm083160;
        Thu, 26 May 2022 00:46:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1653544004;
        bh=I/YTCXZm5E9ZxaZWf6oiSo905eleVQs4JTl/yNkbmJg=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=kF+i1PmagY0+lsFH5BDXzF756K4I00IT5698UAUkjOzco5ria6XwAtZNAQGCZry8n
         Mf2E8D65fwfGBllOPm/G3NlcrEk5NMxxn5esAtxPA7B7SuzkL145I7sdwxXYvNzX7F
         nX+tFKnEmd+/fiY5N6hhseAFCYRJb14TyEnZ1PP0=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 24Q5kiCF079732
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 26 May 2022 00:46:44 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 26
 May 2022 00:46:44 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 26 May 2022 00:46:44 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 24Q5khKn055572;
        Thu, 26 May 2022 00:46:43 -0500
Date:   Thu, 26 May 2022 11:16:42 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Rob Herring <robh@kernel.org>
CC:     Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] spi: dt-bindings: Move 'rx-sample-delay-ns' to
 spi-peripheral-props.yaml
Message-ID: <20220526054642.zw44mgw2bd2u5v76@ti.com>
References: <20220525210053.2488756-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220525210053.2488756-1-robh@kernel.org>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 25/05/22 04:00PM, Rob Herring wrote:
> SPI bus per device properties must be defined in spi-peripheral-props.yaml
> for unevaluatedProperties checks to work correctly on device nodes.
> 
> This has the side effect of promoting 'rx-sample-delay-ns' to be a
> common property, but functionally it's no different if it was defined in
> a Synopsys specific schema file.

Functionally it is no different, but does this property make sense for 
other controllers? If not then I don't see why we should pollute the 
common list with controller-specific ones. For one, this now no longer 
makes it obvious that this property should only be used with the 
Synopsys controller. And if you keep making small exceptions for other 
controllers too, soon the common list will be full of controller 
properties and it will be a mess finding out what belongs to who.

> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../bindings/spi/snps,dw-apb-ssi.yaml          | 18 +++++++++---------
>  .../bindings/spi/spi-peripheral-props.yaml     |  5 +++++
>  2 files changed, 14 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> index d7e08b03e204..e25d44c218f2 100644
> --- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> +++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> @@ -124,9 +124,16 @@ properties:
>  
>    rx-sample-delay-ns:
>      default: 0
> -    description: Default value of the rx-sample-delay-ns property.
> +    description: |
> +      Default value of the rx-sample-delay-ns property.
>        This value will be used if the property is not explicitly defined
> -      for a SPI slave device. See below.
> +      for a SPI slave device.
> +
> +      SPI Rx sample delay offset, unit is nanoseconds.
> +      The delay from the default sample time before the actual sample of the
> +      rxd input signal occurs. The "rx_sample_delay" is an optional feature
> +      of the designware controller, and the upper limit is also subject to
> +      controller configuration.
>  
>  patternProperties:
>    "^.*@[0-9a-f]+$":
> @@ -142,13 +149,6 @@ patternProperties:
>        spi-tx-bus-width:
>          const: 1
>  
> -      rx-sample-delay-ns:
> -        description: SPI Rx sample delay offset, unit is nanoseconds.
> -          The delay from the default sample time before the actual
> -          sample of the rxd input signal occurs. The "rx_sample_delay"
> -          is an optional feature of the designware controller, and the
> -          upper limit is also subject to controller configuration.
> -
>  unevaluatedProperties: false
>  
>  required:
> diff --git a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
> index 5e32928c4fc3..6ffb74352bef 100644
> --- a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
> +++ b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
> @@ -71,6 +71,11 @@ properties:
>      description:
>        Delay, in microseconds, after a read transfer.
>  
> +  rx-sample-delay-ns:
> +    description: SPI Rx sample delay offset, unit is nanoseconds.
> +      The delay from the default sample time before the actual
> +      sample of the rxd input signal occurs.
> +
>    spi-tx-bus-width:
>      description:
>        Bus width to the SPI bus used for write transfers.
> -- 
> 2.34.1
> 

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
