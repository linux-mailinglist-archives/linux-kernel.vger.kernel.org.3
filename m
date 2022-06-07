Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0802953F946
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 11:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239153AbiFGJPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 05:15:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239098AbiFGJPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 05:15:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C61DDA7E04;
        Tue,  7 Jun 2022 02:15:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 16DE4B81DCB;
        Tue,  7 Jun 2022 09:15:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 501F7C34115;
        Tue,  7 Jun 2022 09:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654593329;
        bh=5h8hqwagvhF3XfyBKoQeu2Il4wlCPDFuCIODPfv0Rjk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=keXiQNyO22UOTWAvRO4hpVtbzMvgrub7KUhhq6jRV+SzUW2FG7HNG2yUd+UI9sMWz
         +MDWt5s62Fx8rygVKylIOYNQ401Qh2dDU4diH3LvpAkRxgWvCbhucPINTB8C4A7Sf2
         4H60pD3XXW37tSeHT/2R9pwcf/xuTAh7eGac8BqCKVg5d+K5X4TkXoWfr1diAXp39q
         gtI+vfERdLYIZ3DGgnCm5bw8BEpc1vYALmSSBkMg86eiXSdQ+a7WKMLk92gI9MZTOc
         jzvVoRsqrRB2Dpn4baLtB6vuuyOQ/8HAHUBd9FaRZ3HvYIiYqsODU12Vk6UlFaCWsB
         qq8iWCOPdoltg==
Date:   Tue, 7 Jun 2022 14:45:22 +0530
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
Subject: Re: [PATCH v4 2/2] dt-bindings: mtd: qcom_nandc: document
 qcom,boot-pages binding
Message-ID: <20220607091522.GB5410@thinkpad>
References: <20220519190112.6344-1-ansuelsmth@gmail.com>
 <20220519190112.6344-3-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220519190112.6344-3-ansuelsmth@gmail.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 19, 2022 at 09:01:12PM +0200, Ansuel Smith wrote:
> Document new qcom,boot-pages binding used to apply special
> read/write configuration to boot pages.
> 
> QCOM apply a special configuration where spare data is not protected
> by ECC for some special pages (used for boot partition). Add
> Documentation on how to declare these special pages.
> 
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> ---
>  .../devicetree/bindings/mtd/qcom,nandc.yaml   | 26 +++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mtd/qcom,nandc.yaml b/Documentation/devicetree/bindings/mtd/qcom,nandc.yaml
> index 84ad7ff30121..a59ae9525f4e 100644
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
> +        qcom,boot-pages:

Eventhough the page layout is what making the difference, here the boot
partition offset and size are getting specified. So how about, changing it
to "qcom,boot-partitions"?

Thanks,
Mani

> +          $ref: /schemas/types.yaml#/definitions/uint32-matrix
> +          items:
> +            items:
> +              - description: offset
> +              - description: size
> +          description:
> +            Some special page used by boot partition have spare data
> +            not protected by ECC. Use this to declare these special page
> +            by defining first the offset and then the size.
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
> +        qcom,boot-pages = <0x0 0x58a0000>;
> +
>          partitions {
>            compatible = "fixed-partitions";
>            #address-cells = <1>;
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்
