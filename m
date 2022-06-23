Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0275C5575D9
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 10:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230525AbiFWIrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 04:47:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230472AbiFWIrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 04:47:02 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BD9C49263
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 01:46:57 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id q9so26895249wrd.8
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 01:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=yuZRIg16hgWgvyLgcyb1djhvkqhq6ELp3GvATbp3wU4=;
        b=IPyFvhxKXms2uxVdYCFhGSLzGeNTDdVbl+GzCUpzlIZFsGOviclFqParLyBgfEmkdL
         OHX4LmbzNiWDaTcxZ9ep55ys3WBCfqmrOUXzuHfFwYUL+j0fWVL+zjbfB6mNONbtlCBZ
         2ORGkqIw+I33Hq8xn4209LpHnwaSxhuxJDf2fTY4xG55A1qkUTte5yT7uMKH1PoQCPoi
         EaypG3LSqBwMUyUmnnHfl2jry+4ElfViEW+vkj8XYqG9KU5r9pVcO+4sfuyQqzWcRRmj
         3Zjopzmjq4O2EIKiKaormwRF5J1rIfO8CbQRarWzvpbTR8t1QxxQEqm2kZA9K2EWcM+t
         Xs/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=yuZRIg16hgWgvyLgcyb1djhvkqhq6ELp3GvATbp3wU4=;
        b=SIy7UmFDOoaydCO5HSgRNXo36oin3+E8H1KhzAgN2b7RqAgvYJ7qFAD5xQj0VjL6Gd
         PUSEhVl9EbAT2pTxvHCbqWs8RRRJmi6S8GcNGThbdUJP8M1N4Cnz18XGcR3hER0X/6Kj
         YSG0ojxZI6fawFHks/vlt/ftHzlW8tc7MJbkGOwOETL3JucByI2d5CpRhXwPr6I0DR8L
         Qm7ievIM1KAJGH0r4GwRWpgxFd2w+eyGY16umZOrgz/vYptUW3DjOTlXcNiq/PceLVly
         pcnGxKWgf9J55BuX3vGLmStWubTlmV862N/LSvler3PQG5CS52EHTgFTZyvq6qHrO3vd
         F22w==
X-Gm-Message-State: AJIora8G92IuIxF0D7gGBLyZnGDO9/NvLEl9ZgbF7a7eY8JV1uCTIslS
        jeIeVIKHWIWLvUgWkaiQE3vMMQ==
X-Google-Smtp-Source: AGRyM1tAO9KV+qTetpje4rU4OMUWuh4fswkS5Bu3Wxjp7FLiryhsmjKpmvyh00en80vqsC7j8F/tIQ==
X-Received: by 2002:a05:6000:1447:b0:21a:278a:181c with SMTP id v7-20020a056000144700b0021a278a181cmr7396898wrx.161.1655974015758;
        Thu, 23 Jun 2022 01:46:55 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id v6-20020adfa1c6000000b0021b8905e797sm15391550wrv.69.2022.06.23.01.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 01:46:55 -0700 (PDT)
Date:   Thu, 23 Jun 2022 09:46:53 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Satya Priya <quic_c_skakit@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
        quic_tsoni@quicinc.com
Subject: Re: [PATCH 1/2] dt-bindings: mfd: qcom-pm8xxx: Update the
 maintainers section
Message-ID: <YrQofT4lvwO/K/2k@google.com>
References: <1655874639-11273-1-git-send-email-quic_c_skakit@quicinc.com>
 <1655874639-11273-2-git-send-email-quic_c_skakit@quicinc.com>
 <c54b9423-10cb-e174-44e6-61468efd333f@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c54b9423-10cb-e174-44e6-61468efd333f@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Jun 2022, Krzysztof Kozlowski wrote:

> On 22/06/2022 07:10, Satya Priya wrote:
> > Update the maintainers section with latest mail ID.
> > 
> > Signed-off-by: Satya Priya <quic_c_skakit@quicinc.com>
> > ---
> >  Documentation/devicetree/bindings/mfd/qcom-pm8xxx.yaml | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/mfd/qcom-pm8xxx.yaml b/Documentation/devicetree/bindings/mfd/qcom-pm8xxx.yaml
> > index 2568736..61bd0b3 100644
> > --- a/Documentation/devicetree/bindings/mfd/qcom-pm8xxx.yaml
> > +++ b/Documentation/devicetree/bindings/mfd/qcom-pm8xxx.yaml
> > @@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
> >  title: Qualcomm PM8xxx PMIC multi-function devices
> >  
> 
> Both patches can be squashed and then applied by Rob.

Nope. :)

> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Thanks.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
