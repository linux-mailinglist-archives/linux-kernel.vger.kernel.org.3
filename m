Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05DE74C3508
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 19:50:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233040AbiBXSvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 13:51:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbiBXSvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 13:51:10 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4631418FAE8;
        Thu, 24 Feb 2022 10:50:39 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id d14-20020a05600c34ce00b0037bf4d14dc7so343719wmq.3;
        Thu, 24 Feb 2022 10:50:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kcsRaaBaK/3NnHlqWyM90LHKzQI805DRatL3fjAzAmA=;
        b=i5HOI0QxeN1+i5+46Of1picYM5ycjCQJhcPWz8QwvEiOSLu1QET3duA8EfS1eo8Og0
         7ekLRxkNZ2rt/zME0buD71eIUm6tsYitLz1CfgpMFPwFM1bdGoayiNgdppRcZ2pw6nXT
         zGJmiq0iC1gj1vcCV2YubF0VoLhuDi96suno1xvzPBdvG5SK2UtKvy4brpbMH75Si6Mv
         wbxz5K0hogP4VfVhoNrQicP2v1fImhRsJYfaTQnkmi0yQasFeuF2lN7suZrbmhKcpmw8
         wtG9Jzi88++gjXslUzVArri9mMyeD9uVUA2+dFsKbguZ11BX8YjyheCFyPpjCJ6IEYgn
         MG0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kcsRaaBaK/3NnHlqWyM90LHKzQI805DRatL3fjAzAmA=;
        b=53MIkXt5on/HRdQMxVOc0Z39V7MWATex/2vzilog2NY6s5M/TrhcqSc4WOo1y6bQk7
         VyUVbKyYwesaQ2x6fibfkI9e447pEb/WTH4D8MRj7ZIRiaYbHHAEBfZH2tiIQOeRaLcn
         Rsb6XUGCENa++4gII+vHno37gdau1wKsR3YITlKoITuD/C/qmnXml+tgc30qlLjcSssG
         9u4L+45oOJ6fH+ud+D94xaghJ8rBL+4MNp1S53G2/oC9R+Av7MlP5o2NpMq3AQoldip3
         Ro83GMsHOrNx7q9PQQAibcfjH2zhAyh4mhXBcC16NOpqyuDk2p1EmqJNrImQ9lfXi+uc
         x5BQ==
X-Gm-Message-State: AOAM531LqoLv4HL297n45cxZgvpqm9JGrMWP59EC+vEIjuowS0dbo66c
        OjU5uAmQDxi9ZSpEOOSfiJQ=
X-Google-Smtp-Source: ABdhPJzyv3nECbfuCA03OMwDjZibSfc8JTwKLF5tCSmAP6yezzjCFYAwDL5JUI3+OTb7DBZ+/wnQmw==
X-Received: by 2002:a7b:c92a:0:b0:380:fd1f:5d7e with SMTP id h10-20020a7bc92a000000b00380fd1f5d7emr3571908wml.170.1645728637599;
        Thu, 24 Feb 2022 10:50:37 -0800 (PST)
Received: from Ansuel-xps.localdomain ([5.170.140.187])
        by smtp.gmail.com with ESMTPSA id b15-20020adfe64f000000b001e60965a5d4sm157532wrn.44.2022.02.24.10.50.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 10:50:37 -0800 (PST)
Date:   Thu, 24 Feb 2022 19:50:35 +0100
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Taniya Das <tdas@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 02/15] dt-bindings: clock: simplify qcom,gcc-apq8064
 Documentation
Message-ID: <YhfTe6itAilSaQpd@Ansuel-xps.localdomain>
References: <20220224164831.21475-1-ansuelsmth@gmail.com>
 <20220224164831.21475-3-ansuelsmth@gmail.com>
 <YhfSaQEM4ZalLGyD@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YhfSaQEM4ZalLGyD@robh.at.kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2022 at 12:46:01PM -0600, Rob Herring wrote:
> On Thu, Feb 24, 2022 at 05:48:18PM +0100, Ansuel Smith wrote:
> > Simplify qcon,gcc-apq8064 Documentation by using qcom,gcc.yaml as a
> > template and remove the compatible from qcom,gcc.yaml
> > 
> > Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> > ---
> >  .../bindings/clock/qcom,gcc-apq8064.yaml      | 29 +++++--------------
> >  .../bindings/clock/qcom,gcc-other.yaml        |  3 --
> >  2 files changed, 7 insertions(+), 25 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-apq8064.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-apq8064.yaml
> > index 8e2eac6cbfb9..97936411b6b4 100644
> > --- a/Documentation/devicetree/bindings/clock/qcom,gcc-apq8064.yaml
> > +++ b/Documentation/devicetree/bindings/clock/qcom,gcc-apq8064.yaml
> > @@ -6,6 +6,9 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
> >  
> >  title: Qualcomm Global Clock & Reset Controller Binding for APQ8064
> >  
> > +allOf:
> > +  - $ref: qcom,gcc.yaml#
> > +
> >  maintainers:
> >    - Stephen Boyd <sboyd@kernel.org>
> >    - Taniya Das <tdas@codeaurora.org>
> > @@ -17,22 +20,12 @@ description: |
> >    See also:
> >    - dt-bindings/clock/qcom,gcc-msm8960.h
> >    - dt-bindings/reset/qcom,gcc-msm8960.h
> > +  - dt-bindings/clock/qcom,gcc-apq8084.h
> > +  - dt-bindings/reset/qcom,gcc-apq8084.h
> >  
> >  properties:
> >    compatible:
> > -    const: qcom,gcc-apq8064
> 
> I assume you didn't mean to remove this?
>

Think you got confused by the patch?

> > -
> > -  '#clock-cells':
> > -    const: 1
> > -
> > -  '#reset-cells':
> > -    const: 1
> > -
> > -  '#power-domain-cells':
> > -    const: 1
> > -
> > -  reg:
> > -    maxItems: 1
> > +    const: qcom,gcc-apq8084

The compatible is here. Or I'm missing something?

> >  
> >    nvmem-cells:
> >      minItems: 1
> > @@ -53,21 +46,13 @@ properties:
> >    '#thermal-sensor-cells':
> >      const: 1
> >  
> > -  protected-clocks:
> > -    description:
> > -      Protected clock specifier list as per common clock binding.
> > -
> >  required:
> >    - compatible
> > -  - reg
> > -  - '#clock-cells'
> > -  - '#reset-cells'
> > -  - '#power-domain-cells'
> >    - nvmem-cells
> >    - nvmem-cell-names
> >    - '#thermal-sensor-cells'
> >  
> > -additionalProperties: false
> > +unevaluatedProperties: false
> >  
> >  examples:
> >    - |
> > diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-other.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-other.yaml
> > index 4e5903bcd70d..47e1c5332d76 100644
> > --- a/Documentation/devicetree/bindings/clock/qcom,gcc-other.yaml
> > +++ b/Documentation/devicetree/bindings/clock/qcom,gcc-other.yaml
> > @@ -15,8 +15,6 @@ description:
> >    power domains.
> >  
> >    See also:
> > -  - dt-bindings/clock/qcom,gcc-apq8084.h
> > -  - dt-bindings/reset/qcom,gcc-apq8084.h
> >    - dt-bindings/clock/qcom,gcc-ipq4019.h
> >    - dt-bindings/clock/qcom,gcc-ipq6018.h
> >    - dt-bindings/reset/qcom,gcc-ipq6018.h
> > @@ -40,7 +38,6 @@ allOf:
> >  properties:
> >    compatible:
> >      enum:
> > -      - qcom,gcc-apq8084
> >        - qcom,gcc-ipq4019
> >        - qcom,gcc-ipq6018
> >        - qcom,gcc-ipq8064
> > -- 
> > 2.34.1
> > 
> > 

-- 
	Ansuel
