Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3CF55448C6
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 12:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242527AbiFIKZi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 06:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233741AbiFIKZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 06:25:33 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 672C8C3644;
        Thu,  9 Jun 2022 03:25:32 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id c2so30543394edf.5;
        Thu, 09 Jun 2022 03:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=BF6ToR34rwIt5IS191pj4nLe5IsCsROznE05uP/+Uqs=;
        b=gtqh7qJZ0+9U+7O4nUcZEdHelSNVMDaG0OEAYUkiVxz31j1tif25vJdCXhsog2i0F0
         hLQcvE1btMskuHBWmmxwD7JNZTdliKE3mEB5Yu5B+S93BmPfX9us4+BhAJXWGi8Lgap+
         9ajET1/btAhBqayca1UWvEfr+u01ytkVQYZel7e58Vo984RfsnG/A7vyiU+tS3tld8gx
         whuUXyob9HsaA4MgQB0MI4BhuZXRGC0KL3CzS/l2YEj3sP3OcNsE8LpeeqNvquV5CdAm
         ryEHdAvZOn+2XKTx0jHkDEHCnMq050n8TZLxjxQldP5KFQSpGsbnSOtfP1YSNjOTXnP8
         R0Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=BF6ToR34rwIt5IS191pj4nLe5IsCsROznE05uP/+Uqs=;
        b=l/XKr4VCPdoRtzE3V8zHf2P95bhUvBAUnWcI+KCFSe3QSEy+6eF9asC1hQ2D/uVNc8
         rgiOvBjLDPUf3laDpSRjId25nKOuNdOeWoS1QBtw7N4lj9JlIO+RfcCB3IBSAdpiHsod
         YTqA5lFURFY7YeXtFbFVZx16gPnawXsMn21CsExfaXGKqULV3QkpYq3OVlWDRc/Jqfn6
         wYkZ/cA53etj4UNzFsmvsKg4DIHuoBwbkRaz10ERMp5hEzzvJt3DdpmH6X2KpDTowzu3
         TzkzlfA71rEt2G+ZSD3u6+2vgque+XtMs6RpP/keYGNuEbir5gbW26AIwWn08KOONqke
         GdOw==
X-Gm-Message-State: AOAM531zfX1gzZwkhWA14C+oY0KZsIHWh+Fw6yyvFxQROqds+zZPhgBp
        GWsyVc5z7m5omxPTkA2ztKo=
X-Google-Smtp-Source: ABdhPJyeeDg7TxdkBdqiyTzlSIIZTnDroZskZzCgvxigfPZd5Wfw12Qot2iob0xzzEXxgfwEAGuVCg==
X-Received: by 2002:a05:6402:3318:b0:42d:f04b:f50a with SMTP id e24-20020a056402331800b0042df04bf50amr44005739eda.210.1654770330865;
        Thu, 09 Jun 2022 03:25:30 -0700 (PDT)
Received: from Ansuel-xps. (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.gmail.com with ESMTPSA id en22-20020a056402529600b0043120d5f3dcsm9146510edb.14.2022.06.09.03.25.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 03:25:30 -0700 (PDT)
Message-ID: <62a1ca9a.1c69fb81.3b355.0b02@mx.google.com>
X-Google-Original-Message-ID: <YqHKlxUo/0OnIGwD@Ansuel-xps.>
Date:   Thu, 9 Jun 2022 12:25:27 +0200
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Manivannan Sadhasivam <mani@kernel.org>
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
References: <20220608001030.18813-1-ansuelsmth@gmail.com>
 <20220608001030.18813-3-ansuelsmth@gmail.com>
 <20220609072029.GA2758@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220609072029.GA2758@thinkpad>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 09, 2022 at 12:50:29PM +0530, Manivannan Sadhasivam wrote:
> On Wed, Jun 08, 2022 at 02:10:29AM +0200, Ansuel Smith wrote:
> > Document new qcom,boot-partition binding used to apply special
> > read/write layout to boot partitions.
> > 
> > QCOM apply a special layout where spare data is not protected
> > by ECC for some special pages (used for boot partition). Add
> > Documentation on how to declare these special pages.
> > 
> > Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> > ---
> >  .../devicetree/bindings/mtd/qcom,nandc.yaml   | 26 +++++++++++++++++++
> >  1 file changed, 26 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/mtd/qcom,nandc.yaml b/Documentation/devicetree/bindings/mtd/qcom,nandc.yaml
> > index 84ad7ff30121..a0914ccb95b0 100644
> > --- a/Documentation/devicetree/bindings/mtd/qcom,nandc.yaml
> > +++ b/Documentation/devicetree/bindings/mtd/qcom,nandc.yaml
> > @@ -102,6 +102,30 @@ allOf:
> >              - const: rx
> >              - const: cmd
> >  
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - qcom,ipq806x-nand
> > +
> > +    then:
> > +      properties:
> > +        qcom,boot-partitions:
> > +          $ref: /schemas/types.yaml#/definitions/uint32-matrix
> 
> Wondering if u32 is enough for covering all ranges? Other than this,
> 
> Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
> 
> Thanks,
> Mani
>

I mean they are offset and sizes... Considering it's an old SoC and max
nand mounted is 1g we should be safe with u32.

> > +          items:
> > +            items:
> > +              - description: offset
> > +              - description: size
> > +          description:
> > +            Boot partition use a different layout where the 4 bytes of spare
> > +            data are not protected by ECC. Use this to declare these special
> > +            partitions by defining first the offset and then the size.
> > +
> > +            It's in the form of <offset1 size1 offset2 size2 offset3 ...>
> > +
> > +            Refer to the ipq8064 example on how to use this special binding.
> > +
> >  required:
> >    - compatible
> >    - reg
> > @@ -135,6 +159,8 @@ examples:
> >          nand-ecc-strength = <4>;
> >          nand-bus-width = <8>;
> >  
> > +        qcom,boot-partitions = <0x0 0x58a0000>;
> > +
> >          partitions {
> >            compatible = "fixed-partitions";
> >            #address-cells = <1>;
> > -- 
> > 2.36.1
> > 
> 
> -- 
> மணிவண்ணன் சதாசிவம்

-- 
	Ansuel
