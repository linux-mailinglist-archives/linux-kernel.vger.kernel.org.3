Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F20354D3E3
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 23:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347588AbiFOVle (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 17:41:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347019AbiFOVlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 17:41:31 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37F6F56232
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 14:41:30 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id y6so524637plg.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 14:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=8dWcLR0ZrLQZSCDJIe8I8UTiInH8Z6m2etiHt74njk8=;
        b=YkaIP98uxenoicHUsjN7i3rddkaSiJYUoir0wuhlIOLfhbCB5o5JCguB9u8wExDAUI
         r/iNkw1JmG/9doPE4C/ncdgKQ6IE/ty0fUdcSv0h872JAgdtgyV8mO3zTKTfwoPkSmNQ
         eBbPhoQ1uziWgxh4xiM+1aGSPGtYRMwJPr9/R30sJarOA3Uu+0sFCd3NJ6EnnDGGRZo/
         Zo1aDvkMxggrG4reqjA0LdFcFWq9DlX5YEas4On9WWe71azwDkXpM17O4Z30d+pIfynE
         ln6AGiQUMyYdjUxki30H7/Dcz59y+LtVnQAMGxuM9zgKubw+DzynGFj2nkcnYPG74te1
         X2Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=8dWcLR0ZrLQZSCDJIe8I8UTiInH8Z6m2etiHt74njk8=;
        b=qVXWeP1zHdZfJlts5igUnezTUdd0hymrTjylJL5ICWB9KsPNkjUkfGJLxmSMsPiVPE
         d3WJlH8fbYEHYtaDUYfqQg/1hvZ/P/6Wk4iimY/LDbtNVy+q8EmDMSRd3aJS/w4AVlTV
         uQ3DO68mVHkMWCs+f6tRuURDFpjySCCoLT4vu35g7ptkfW184R/frguENtADdk6N9beo
         /1VrMgNP8//oWogs8a/P7lVLFEPelsyqLg1Ox0xr6tS0gLbIVJlaXZabbD75cq2gM6do
         Ekb6iQ4aU2YsY6Z4165tg35a/FfNhdxhp6/Lgs450EKJwR8DnxuRq5KWohMBybEtF63k
         kOzA==
X-Gm-Message-State: AJIora8nzcK37DacLtwPviLeoSUFq26fkgLX8Hj6IzEHnDgC2jPkWbFD
        VKa2avU8JePe0ikV7UH3FdnJ1Q==
X-Google-Smtp-Source: AGRyM1v0KviAP1PW8KgEExGBe/JU7mf7xksWuzLnniQbv1H/38sCXHAxs6RJQgRmFDHTaD+Lrxr/iw==
X-Received: by 2002:a17:90b:4a4c:b0:1e4:dcfc:e688 with SMTP id lb12-20020a17090b4a4c00b001e4dcfce688mr12391105pjb.38.1655329289707;
        Wed, 15 Jun 2022 14:41:29 -0700 (PDT)
Received: from google.com ([192.77.111.2])
        by smtp.gmail.com with ESMTPSA id x13-20020a17090300cd00b00161455d8029sm117844plc.12.2022.06.15.14.41.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 14:41:29 -0700 (PDT)
Date:   Wed, 15 Jun 2022 22:41:26 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Caleb Connolly <caleb.connolly@linaro.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH v14 02/10] mfd: qcom-spmi-pmic: expose the PMIC revid
 information to clients
Message-ID: <YqpSBrfLz5mnM0kW@google.com>
References: <20220429220904.137297-1-caleb.connolly@linaro.org>
 <20220429220904.137297-3-caleb.connolly@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220429220904.137297-3-caleb.connolly@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Apr 2022, Caleb Connolly wrote:

> Some PMIC functions such as the RRADC need to be aware of the PMIC
> chip revision information to implement errata or otherwise adjust
> behaviour, export the PMIC information to enable this.
> 
> This is specifically required to enable the RRADC to adjust
> coefficients based on which chip fab the PMIC was produced in,
> this can vary per unique device and therefore has to be read at
> runtime.
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Tested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  drivers/mfd/qcom-spmi-pmic.c      | 265 ++++++++++++++++++++----------
>  include/soc/qcom/qcom-spmi-pmic.h |  60 +++++++
>  2 files changed, 235 insertions(+), 90 deletions(-)
>  create mode 100644 include/soc/qcom/qcom-spmi-pmic.h

Once Jonathan's comments have been resolved:

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
