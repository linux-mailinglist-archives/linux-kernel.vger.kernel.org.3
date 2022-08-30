Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DFA95A6296
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 13:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbiH3L47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 07:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbiH3L4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 07:56:54 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3214D8B0B
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 04:56:50 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id fa2so3208636pjb.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 04:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc;
        bh=7yXaKsnP0ODtMHSK3xa0NyjfxvosTqnSzBxIBWoTewg=;
        b=Bt82UCf8F8+6IR0fSl9Hq+ekNNU8enCID21or2aO9jzWwCCLyHWPiKl2F8Lo9k3q6R
         pOC7miXL4WE7RsektcI0XwP5ucZquiXsdY+0H2ykinufOxw2XMT10ahC5XJj++nL0WkF
         y7eBCgXgxukSrJzEHSDBGw34wmTl3TlYen8l1eQVNb3IUOJnMXGXaeAmJx4IIy1EAqmu
         TFC/WO+mTVhDoe+d9Sh4no1DXfk/xL72BRC79Y8c8fgHJN+iSak8YZRp7hbjnqJlI/gx
         K6xDjD7VnGHZqGU5SGRnoWuYzLAiXUeGfbsj68WktG1IVuA+aKId0fkufV2A6jsgkTsA
         hVeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=7yXaKsnP0ODtMHSK3xa0NyjfxvosTqnSzBxIBWoTewg=;
        b=S9mObOnWn2btlf7AWi6Da41oDKYH1Bvt+iX6qLB0Umf7yAs+PDpxksDXHSc4K0xtQG
         AlswC5E1jrJBa6x7zM1lcLmwgdWrr6uT43U9bAudIYZwVMhjr58sR9hn/Ld6vUZHMI2D
         TXDlCX39Bnhbs5+mNgtlY5cpjbhybvDNTcEuCJO1EVFTepQ0sfDkVk4bFm/TW10IfMWU
         04//7QO95j2ppRqUCmkDiMUbNZSfBcSLmWgpD9B4YUZ+8m31MjD/gxMW6ggsvqIbEbR9
         Fd/5EBlp68OWNVGSXk9J3SxuQ8l0hESHLoXd7shzgP679jMVTtRZ/sidD/UPr5cSLydK
         buew==
X-Gm-Message-State: ACgBeo1u4qFAcGVqaerbZWPzDnZv6AVrNn92la/yWQ5vSycauYYwOPiP
        dEjAbAqEewfs6pCqLR6qLsjr
X-Google-Smtp-Source: AA6agR53rvKvchcIFuOoaSkHx7i/ftfAYGl03OXOxdaMHuD2/IxrisPpudtStL0yM7Ioz6h++XbVYQ==
X-Received: by 2002:a17:902:c651:b0:174:36ce:49ce with SMTP id s17-20020a170902c65100b0017436ce49cemr20733934pls.87.1661860609266;
        Tue, 30 Aug 2022 04:56:49 -0700 (PDT)
Received: from thinkpad ([117.217.182.234])
        by smtp.gmail.com with ESMTPSA id z124-20020a626582000000b00537e328bc11sm7313942pfb.31.2022.08.30.04.56.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 04:56:48 -0700 (PDT)
Date:   Tue, 30 Aug 2022 17:26:42 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     lpieralisi@kernel.org, robh@kernel.org, andersson@kernel.org,
        kw@linux.com, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        konrad.dybcio@somainline.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        dmitry.baryshkov@linaro.org
Subject: Re: [PATCH 09/11] dt-bindings: PCI: qcom-ep: Define clocks per
 platform
Message-ID: <20220830115642.GE135982@thinkpad>
References: <20220826181923.251564-1-manivannan.sadhasivam@linaro.org>
 <20220826181923.251564-10-manivannan.sadhasivam@linaro.org>
 <b188b3fe-cc35-f902-b316-0c1632893e9d@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b188b3fe-cc35-f902-b316-0c1632893e9d@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 28, 2022 at 06:20:21PM +0300, Krzysztof Kozlowski wrote:
> On 26/08/2022 21:19, Manivannan Sadhasivam wrote:
> > In preparation of adding the bindings for future SoCs, let's define the
> > clocks per platform.
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  .../devicetree/bindings/pci/qcom,pcie-ep.yaml | 46 +++++++++++--------
> >  1 file changed, 27 insertions(+), 19 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
> > index b728ede3f09f..83a2cfc63bc1 100644
> > --- a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
> > +++ b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
> > @@ -9,9 +9,6 @@ title: Qualcomm PCIe Endpoint Controller binding
> >  maintainers:
> >    - Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> >  
> > -allOf:
> > -  - $ref: "pci-ep.yaml#"
> > -
> >  properties:
> >    compatible:
> >      const: qcom,sdx55-pcie-ep
> > @@ -35,24 +32,12 @@ properties:
> >        - const: mmio
> >  
> >    clocks:
> > -    items:
> > -      - description: PCIe Auxiliary clock
> > -      - description: PCIe CFG AHB clock
> > -      - description: PCIe Master AXI clock
> > -      - description: PCIe Slave AXI clock
> > -      - description: PCIe Slave Q2A AXI clock
> > -      - description: PCIe Sleep clock
> > -      - description: PCIe Reference clock
> > +    minItems: 7
> > +    maxItems: 7
> >  
> >    clock-names:
> > -    items:
> > -      - const: aux
> > -      - const: cfg
> > -      - const: bus_master
> > -      - const: bus_slave
> > -      - const: slave_q2a
> > -      - const: sleep
> > -      - const: ref
> > +    minItems: 7
> > +    maxItems: 7
> >  
> >    qcom,perst-regs:
> >      description: Reference to a syscon representing TCSR followed by the two
> > @@ -112,6 +97,29 @@ required:
> >    - reset-names
> >    - power-domains
> >  
> > +allOf:
> > +  - $ref: "pci-ep.yaml#"
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - qcom,sdx55-pcie-ep
> > +    then:
> > +      properties:
> > +        clocks:
> > +          minItems: 7
> > +          maxItems: 7
> 
> One more thing - the previous way of describing items is more readable
> instead of names followed by a comment, so I propose to keep it. This
> applies also to patch 10.
> 

Okay.

Thanks,
Mani

> Best regards,
> Krzysztof

-- 
மணிவண்ணன் சதாசிவம்
