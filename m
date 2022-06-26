Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A72AB55AE72
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 05:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233767AbiFZDUD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 23:20:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233788AbiFZDUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 23:20:02 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E9A413D33
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 20:20:00 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id t26-20020a9d775a000000b006168f7563daso4932923otl.2
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 20:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=w/mYeMPmd0Fk8nQabOaGxE7uHrcY17tT/p63c/0m/K8=;
        b=y4TkfpoCC1kczoEYXJb+AciMyXrERHIx7++CgsHxTlOA/OI+ST+BTCmIH1CpjVAG35
         YTtbNUjvO0QbvJrexaeD3eA/1t3Meb/Ify9txPu1IgrYdCYKgoNHiSrfxEKX6BtbmKUS
         9jUeqlnMe15Rnp9aWAOrn5hCbeCVl0ZTUoq46r4iENpKoy8kazmApT91Rmmf/90X/857
         h5uB6h3HeYkWicLpluc0eoBNulVXrYyK1rwlWqTISEHu6YDZBsZ3N4d55cOZD4Zjigg/
         hSRAmRltMtv4sEt4NZDS31dxJzC0qYQdEaSVCyGeKf6SWgHIm6fA2Ufr1K1Cgo2SWclC
         2ZSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=w/mYeMPmd0Fk8nQabOaGxE7uHrcY17tT/p63c/0m/K8=;
        b=j8qjG32qt0A03BYH6Lxrb7CERG+CZUmbCMxCnRcifpi8JNQJOUvY51jcCxkqdu1jH/
         Aj73oKKMwR4g0Ni8gDAIUFcumADQrfQzMKUOszY29TYJLU/xV+/T8pmhMeB7b7jyjQhy
         tkO3TPEyYKjeoSh32WVlsn4PhoG6u7rFPXz0WLxFloe0iW0hzCUWJUbRvbYjgvgjOSdc
         2yBtK5lOzrhc/kTvZvd2QURJapsA008WiWNExr+wBM5TCQLosM91ZTlkB2lo8n7pjBjB
         QITfCZPlWTWPcero9gYwSOxZdhcj+CWg2So8wgUazDeS+udCze34TN3piQfpB6t7GTSb
         1Zxg==
X-Gm-Message-State: AJIora+6aCHF29nKUCAThWHPa8dnNkkqfOH+B/kzQviqKcSShU4nDq0d
        CQv0FYzv9wbB2RrnfsvfEdkUdQ==
X-Google-Smtp-Source: AGRyM1ueYuHJYGTGsRDe7GO1mvPAOg2cTr58tcPwudtIXoIbwJopBM7c20rw5dd4IUzHo/kBe21jmA==
X-Received: by 2002:a05:6830:1f26:b0:60c:2662:ef9a with SMTP id e6-20020a0568301f2600b0060c2662ef9amr3133660oth.37.1656213599397;
        Sat, 25 Jun 2022 20:19:59 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id 4-20020a544184000000b0032f75714af1sm3422554oiy.18.2022.06.25.20.19.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jun 2022 20:19:58 -0700 (PDT)
Date:   Sat, 25 Jun 2022 22:19:56 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rajendra Nayak <quic_rjendra@quicinc.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v4 1/4] dt-bindings: interconnect: qcom,sdm845-cpu-bwmon:
 add BWMON device
Message-ID: <YrfQXM7N/dn9odKL@builder.lan>
References: <20220601101140.170504-1-krzysztof.kozlowski@linaro.org>
 <20220601101140.170504-2-krzysztof.kozlowski@linaro.org>
 <Yp5tjUICIEUptKSx@ripper>
 <3e4e504c-5a38-43cd-ea8d-afbbb72eacad@linaro.org>
 <dbfe1e7c-19dc-2d20-700a-c26f0bf721e5@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dbfe1e7c-19dc-2d20-700a-c26f0bf721e5@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 22 Jun 06:58 CDT 2022, Rajendra Nayak wrote:

> 
> 
> On 6/7/2022 12:20 PM, Krzysztof Kozlowski wrote:
> > On 06/06/2022 23:11, Bjorn Andersson wrote:
> > > On Wed 01 Jun 03:11 PDT 2022, Krzysztof Kozlowski wrote:
> > > 
> > > > Add bindings for the Qualcomm Bandwidth Monitor device providing
> > > > performance data on interconnects.  The bindings describe only BWMON
> > > > version 4, e.g. the instance on SDM845 between CPU and Last Level Cache
> > > > Controller.
> > > > 
> > > > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > > > Reviewed-by: Rob Herring <robh@kernel.org>
> > > > Acked-by: Georgi Djakov <djakov@kernel.org>
> > > > ---
> > > >   .../interconnect/qcom,sdm845-cpu-bwmon.yaml   | 97 +++++++++++++++++++
> > > >   1 file changed, 97 insertions(+)
> > > >   create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,sdm845-cpu-bwmon.yaml
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/interconnect/qcom,sdm845-cpu-bwmon.yaml b/Documentation/devicetree/bindings/interconnect/qcom,sdm845-cpu-bwmon.yaml
> > > > new file mode 100644
> > > > index 000000000000..8c82e06ee432
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/interconnect/qcom,sdm845-cpu-bwmon.yaml
> > > > @@ -0,0 +1,97 @@
> > > > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > > > +%YAML 1.2
> > > > +---
> > > > +$id: http://devicetree.org/schemas/interconnect/qcom,sdm845-cpu-bwmon.yaml#
> > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > +
> > > > +title: Qualcomm Interconnect Bandwidth Monitor
> > > > +
> > > > +maintainers:
> > > > +  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > > > +
> > > > +description:
> > > > +  Bandwidth Monitor measures current throughput on buses between various NoC
> > > > +  fabrics and provides information when it crosses configured thresholds.
> > > > +
> > > > +properties:
> > > > +  compatible:
> > > > +    enum:
> > > > +      - qcom,sdm845-cpu-bwmon       # BWMON v4
> > > 
> > > It seems the thing that's called bwmon v4 is compatible with a number of
> > > different platforms, should we add a generic compatible to the binding
> > > as well, to avoid having to update the implementation for each SoC?
> > > 
> > > (I.e. "qcom,sdm845-cpu-bwmon", "qcom,bwmon-v4")
> 
> it seems pretty useful to have the "qcom,bwmon-v4" and "qcom,bwmon-v5"
> compatibles, I tried these patches on a sc7280 device which has a bwmon4
> between the cpu and caches (and also has a bwmon5 between the caches and DDR)
> and the driver works with zero changes.
> 

But does the '4' and '5' has a relation to the hardware? Or is just the
4th and 5th register layout supported by the downstream driver?

Regards,
Bjorn
