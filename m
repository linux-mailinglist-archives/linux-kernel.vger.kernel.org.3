Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25AE552C2FB
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 21:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241774AbiERTCC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 15:02:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241745AbiERTBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 15:01:55 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23AFB3526C;
        Wed, 18 May 2022 12:01:54 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id r188-20020a1c44c5000000b003946c466c17so3699459wma.4;
        Wed, 18 May 2022 12:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:subject:references:mime-version
         :content-disposition:in-reply-to;
        bh=rBZnRO68NWo3V5gqiqABKmLdz8NjuPd3CbKCN2Cz/cM=;
        b=gKUIj8Ge35wSfOVwEdHduPahXbAzwGd8SskUVAoHshrofyjcZoeby0X7wFdYx7u1q8
         MnbWe7PLjcF5/CnGMS41f9DC53DH+5qoAeYYlIkqoytoWRxweNxNTiGES5owVyfgnGie
         YGyCANJ7NxqfnedK2/FbZJJA8f7z83WKsux1pm01qs71XM2H3r4LnuBhTmcDUYP574qX
         DRuaxngNaxTLeBEnEQfIf6fnYRfNWn0LzBXBugzHN6JXFO578ctmVEH1QFd4iL3GVvp1
         8Ocn4Ab8dpl4tfiIKOf+dt9ZFVFi87cX/21EU4X2wVXZ2eZhJoCLJ9emamYoWlfOHgr/
         7YtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=rBZnRO68NWo3V5gqiqABKmLdz8NjuPd3CbKCN2Cz/cM=;
        b=OSQUdR76ItnigVy+EurODJLDQ2yNsd7FJN35UzXo04Dhz1HGws8woOctDabjQ6AV+f
         vlhtussuScpY8ahnBdDoSahQ/VIbBRCYnP3gwBg1sASb8q67C4nmkh6vhmYFAWSoASEx
         uu+hK39e6cJvMTNVoOuzsQO8iB/BT0ycmdz8vdiHoC8KHTu/GqyDzLO/NU0tHEKvRtjc
         Z2tmLaC/nNz34r5BQZN5Aeq+fWSVzKQx8eZh8uU+FT16VLYSyiZeHYQy8l+8zCqekoCi
         AYjKcTFgtjkXM8vC433UYb493vdtMCZnStltfZmFk6+OYSxCjTsVF9JnTUqFermlZneT
         R0lg==
X-Gm-Message-State: AOAM532vO52rROScO6qffjUD+MPMV6uvkMaoddjJr/yCkDoZb+loGo0z
        GUXtQMyvvJHO1XtJGOn9NL0=
X-Google-Smtp-Source: ABdhPJwFABL9st5eY1kCZPAqEZTG5BH2l111z7uQRFbd2WAbEua6u8ho/o92KmJ7E6hl6JcXlsiVqg==
X-Received: by 2002:a05:600c:354a:b0:394:8fa4:73bc with SMTP id i10-20020a05600c354a00b003948fa473bcmr1186452wmq.37.1652900512510;
        Wed, 18 May 2022 12:01:52 -0700 (PDT)
Received: from Ansuel-xps. (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.gmail.com with ESMTPSA id c14-20020a05600c0a4e00b003942a244ec4sm2527846wmq.9.2022.05.18.12.01.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 12:01:52 -0700 (PDT)
Message-ID: <628542a0.1c69fb81.8800.d06a@mx.google.com>
X-Google-Original-Message-ID: <YoVCnbKs3xgDNnzT@Ansuel-xps.>
Date:   Wed, 18 May 2022 21:01:49 +0200
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Manivannan Sadhasivam <mani@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-mtd@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] dt-bindings: mtd: qcom_nandc: document
 qcom,boot-pages binding
References: <20220518184256.21238-1-ansuelsmth@gmail.com>
 <20220518184256.21238-3-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220518184256.21238-3-ansuelsmth@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2022 at 08:42:56PM +0200, Ansuel Smith wrote:
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
> index 84ad7ff30121..3b8244db2ae8 100644
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
> +              - qcom,ipq8074-nand

Ignore this revision, this is wrong since this should be ipq8064...
Will resend tomorrow v4 with this fixed. 

> +
> +    then:
> +      properties:
> +        qcom,boot-pages:
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
	Ansuel
