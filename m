Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B83E53FD10
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 13:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242629AbiFGLLr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 07:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242756AbiFGLKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 07:10:05 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 235478721C;
        Tue,  7 Jun 2022 04:06:17 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id q1so34459151ejz.9;
        Tue, 07 Jun 2022 04:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=JYTw8qBceECAtQp7A1kdanNQp5jRY5QBdh0dwqqC9RU=;
        b=Nw5HmIulmE1vH1fMJ8FcWCnuJQHQiHH/x26C400Hk5Bf9PGo6Hw3r8UEWG1iplpkO3
         bn2h1/zeXA+zFIZm1mDr53CRhOeZBRmwk6l3fWcutnWVOBQX8QXyqimHHXhXCV5SW1D9
         xneNpq0uZNxhavrDzIyjaOlg3cRi/GIRrnD6ph4c9sc+7OaVG22cBe4ciXUj1oSePQ8H
         dTk9dRNW6OXOx83c+AUB10I/nvHOjLk6/U8Qxj2b5caJczVcORF4L2HCpp0ebje4/wKs
         EN8zGeT/km2CULPG1J7Sa/caGJwt7KFGxSaItC782x1KKRszWhdDADTmktx1IH/qarM9
         N3bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=JYTw8qBceECAtQp7A1kdanNQp5jRY5QBdh0dwqqC9RU=;
        b=UBNjL3NrXNDVHoom9pNMDHtTdP8dJr4AUoBKoHqGPIKDQwFbP0hS1rWPkyeCK5UzAz
         vobp5UfQJiuJOtQeYkVXwlF3qmWyyU2QDssPgVWAK1Scs+4PRo5pmhHvdfvEMgnI5q1j
         1RA/VlbTLqxaVklYZXPCL8K2r3uwYQI6/KgBVTYpeGht17ESHhUs7QU4XTLePmYCk3lu
         hJYSmcm5AKNTin3RtusZZfar43RnJ2yYXJqVtlvZadAkuxesm4aYOupPlIfUqcBHACL5
         8HwBEQp7evtbxijTmPWKHIwmK9L0mUAcW+IqVpHe2rJJEpSVgVPNfxSrjicTj5Em11Bm
         2Kuw==
X-Gm-Message-State: AOAM533xbJXsTCxAlMpQoS5ElN9Blc22nNQbl07CWmPrnfqFucLUubof
        Cfeoh1qSbKNgwy9nfoFgbsfhoaQGCYc=
X-Google-Smtp-Source: ABdhPJy8xYlbSp5BuzRvztb2RbXiyhlVE5XzRRPnbXnxapSzqknqjm/tCBViCfgB25Q9EmDSXjGvQg==
X-Received: by 2002:a17:907:da3:b0:6fe:f08b:776 with SMTP id go35-20020a1709070da300b006fef08b0776mr26382420ejc.558.1654599976053;
        Tue, 07 Jun 2022 04:06:16 -0700 (PDT)
Received: from Ansuel-xps. (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.gmail.com with ESMTPSA id w21-20020aa7d295000000b0042dd482d0c4sm10115552edq.80.2022.06.07.04.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 04:06:15 -0700 (PDT)
Message-ID: <629f3127.1c69fb81.2590d.39ac@mx.google.com>
X-Google-Original-Message-ID: <Yp74rG6DVmeU+QCQ@Ansuel-xps.>
Date:   Tue, 7 Jun 2022 09:05:16 +0200
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
Subject: Re: [PATCH v4 2/2] dt-bindings: mtd: qcom_nandc: document
 qcom,boot-pages binding
References: <20220519190112.6344-1-ansuelsmth@gmail.com>
 <20220519190112.6344-3-ansuelsmth@gmail.com>
 <20220607091522.GB5410@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220607091522.GB5410@thinkpad>
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 07, 2022 at 02:45:22PM +0530, Manivannan Sadhasivam wrote:
> On Thu, May 19, 2022 at 09:01:12PM +0200, Ansuel Smith wrote:
> > Document new qcom,boot-pages binding used to apply special
> > read/write configuration to boot pages.
> > 
> > QCOM apply a special configuration where spare data is not protected
> > by ECC for some special pages (used for boot partition). Add
> > Documentation on how to declare these special pages.
> > 
> > Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> > ---
> >  .../devicetree/bindings/mtd/qcom,nandc.yaml   | 26 +++++++++++++++++++
> >  1 file changed, 26 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/mtd/qcom,nandc.yaml b/Documentation/devicetree/bindings/mtd/qcom,nandc.yaml
> > index 84ad7ff30121..a59ae9525f4e 100644
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
> > +        qcom,boot-pages:
> 
> Eventhough the page layout is what making the difference, here the boot
> partition offset and size are getting specified. So how about, changing it
> to "qcom,boot-partitions"?
> 
> Thanks,
> Mani
>

Yep, you are correct and the naming is confusing. Will do the change.
Did you check the code if you notice something to improve / an idea of a
better implementation or better naming?
Just to skip sending multiple revision with small changes.

> > +          $ref: /schemas/types.yaml#/definitions/uint32-matrix
> > +          items:
> > +            items:
> > +              - description: offset
> > +              - description: size
> > +          description:
> > +            Some special page used by boot partition have spare data
> > +            not protected by ECC. Use this to declare these special page
> > +            by defining first the offset and then the size.
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
> > +        qcom,boot-pages = <0x0 0x58a0000>;
> > +
> >          partitions {
> >            compatible = "fixed-partitions";
> >            #address-cells = <1>;
> > -- 
> > 2.34.1
> > 
> 
> -- 
> மணிவண்ணன் சதாசிவம்

-- 
	Ansuel
