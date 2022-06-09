Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D47A05444AD
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 09:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239872AbiFIHUw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 03:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239859AbiFIHUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 03:20:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2DF4243BBD;
        Thu,  9 Jun 2022 00:20:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8CB78B82C44;
        Thu,  9 Jun 2022 07:20:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE514C34114;
        Thu,  9 Jun 2022 07:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654759242;
        bh=GkGBXoZ0lI7pgry3fH1/hlxhfCuW2nQ9dPWKJZmlobA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QIu5f75c01gsq7A3FlZhFl61flEc+x3EMTgwC3K9Z5wVWV94lT1v9XT19H3pE4XmY
         zkJHzPb7PIiuOttMo612C0vDIMMjAAbc6Q3Jg2bUt0SsxfX7IBMmknuc5Tc1Bk/Y7c
         G6goJu3RbUBQTTnbMsPvEpmDQDtd8+7i9Zqk12nf4TQqUzi0EMjCY2orDkBzO6lDET
         y5yUWSI4potzwd+KzBBvaG5KvVPnaHO8t0hi1PiDnJ95BPnanexYgWuoUkF/l+Vijy
         vW7j8YWSvCN8HByxNRwN9RnSVX94VJYvpiKKyIg9aNvK5qayjrVykTAEMJhmzs017W
         EhbY9yKtGZaBQ==
Date:   Thu, 9 Jun 2022 12:50:29 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-mtd@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/3] dt-bindings: mtd: qcom_nandc: document
 qcom,boot-partitions binding
Message-ID: <20220609072029.GA2758@thinkpad>
References: <20220608001030.18813-1-ansuelsmth@gmail.com>
 <20220608001030.18813-3-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220608001030.18813-3-ansuelsmth@gmail.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 08, 2022 at 02:10:29AM +0200, Ansuel Smith wrote:
> Document new qcom,boot-partition binding used to apply special
> read/write layout to boot partitions.
> 
> QCOM apply a special layout where spare data is not protected
> by ECC for some special pages (used for boot partition). Add
> Documentation on how to declare these special pages.
> 
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> ---
>  .../devicetree/bindings/mtd/qcom,nandc.yaml   | 26 +++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mtd/qcom,nandc.yaml b/Documentation/devicetree/bindings/mtd/qcom,nandc.yaml
> index 84ad7ff30121..a0914ccb95b0 100644
> --- a/Documentation/devicetree/bindings/mtd/qcom,nandc.yaml
> +++ b/Documentation/devicetree/bindings/mtd/qcom,nandc.yaml
> @@ -102,6 +102,30 @@ allOf:
>              - const: rx
>              - const: cmd
>  
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,ipq806x-nand
> +
> +    then:
> +      properties:
> +        qcom,boot-partitions:
> +          $ref: /schemas/types.yaml#/definitions/uint32-matrix

Wondering if u32 is enough for covering all ranges? Other than this,

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

Thanks,
Mani

> +          items:
> +            items:
> +              - description: offset
> +              - description: size
> +          description:
> +            Boot partition use a different layout where the 4 bytes of spare
> +            data are not protected by ECC. Use this to declare these special
> +            partitions by defining first the offset and then the size.
> +
> +            It's in the form of <offset1 size1 offset2 size2 offset3 ...>
> +
> +            Refer to the ipq8064 example on how to use this special binding.
> +
>  required:
>    - compatible
>    - reg
> @@ -135,6 +159,8 @@ examples:
>          nand-ecc-strength = <4>;
>          nand-bus-width = <8>;
>  
> +        qcom,boot-partitions = <0x0 0x58a0000>;
> +
>          partitions {
>            compatible = "fixed-partitions";
>            #address-cells = <1>;
> -- 
> 2.36.1
> 

-- 
மணிவண்ணன் சதாசிவம்
