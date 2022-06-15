Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68D0854D4A1
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 00:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350179AbiFOWgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 18:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349081AbiFOWgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 18:36:23 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9677554B3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 15:36:22 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id t2so11602093pld.4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 15:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=mV7iuGUs7Sd/EB7Y6IVDAes2u13Cf7xlNc9ZNwwInH8=;
        b=l1vqRhqJpsnPX9adoCyvZMhxiUUjd7Ueb+/3PJLRf7TL5d79Yyh3174drC0uOTCmY8
         +H60mhgJ9Nui98dSrZtr3UT0xELEzJJp7i5px5nR62LbqJ54x3vKGHRtxCMC0toddiUK
         NB4gyX+qNJsr5b9A1vEFnvtqliTMnmX1oZLl8inbURAi1fht92bxIE7PfrFp8oEK7VY1
         FLtZX0ElS69VxnZnJ68z+0106vRZ7jAenVO5MiZ1cwRwi0kGGgk1I5/cG6A/W2GfXGGW
         iFt7vqRDVLY2y3JCxEMrDIJV/Q+Wnstsl2HdNx6CpIUJTzWiWe2xI33cV47MOu9cwRGA
         aySA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=mV7iuGUs7Sd/EB7Y6IVDAes2u13Cf7xlNc9ZNwwInH8=;
        b=6qeBmfs+xvadjaD6xywc8lXLfBDCYxN+IAM3iYR5k88NjekUFT9tC58lEVwvXaXikd
         cn+9xQF6k3kp+fv1Di7NoH9nitBqAA0rTVjt+AD88kNMtm/OK1X3dMSJxDkACzIH09tD
         4v4HiGPt8DD8Pr/RZBlbXwzAUnqxY8aUIQ+7CrqtU2ca+H+LkPf1YrThcn3CelLXsmTX
         9YQW0ptAXsuD2UJ+RXNeCjO5Rma//+gG6CthpnFB7/DkCMC6JZI8yvqPaHbK09u5uNTM
         YGIQmAZIgRyQqPH6pNTO8147EALKuKYXIxWpnRL+wSEjXNxZpI/Y+nWwBe7H2CU+4yrW
         sW0w==
X-Gm-Message-State: AJIora+B5J6gaCSv9XnDKmU4rlbqyb5ecMuWy/6ZrPDyHhMt42PIxnG4
        VFQ1/xs1AkPHn5sfH4g3iExxkQ==
X-Google-Smtp-Source: AGRyM1twssaYQfVWyMrshZxeSWZ9mwJyA7gkNlEydiGHiNrG9KJ0HMdkIjzpZ/ZbD9PxDuj+ED5jWA==
X-Received: by 2002:a17:903:2341:b0:167:4b11:a8e with SMTP id c1-20020a170903234100b001674b110a8emr1943077plh.10.1655332582397;
        Wed, 15 Jun 2022 15:36:22 -0700 (PDT)
Received: from google.com ([192.77.111.2])
        by smtp.gmail.com with ESMTPSA id w9-20020a17090a780900b001ead46e77e2sm107763pjk.13.2022.06.15.15.36.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 15:36:21 -0700 (PDT)
Date:   Wed, 15 Jun 2022 23:36:20 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: mfd: qcom,tcsr: Convert to dtschema
Message-ID: <Yqpe5EkBHCT6e12v@google.com>
References: <20220607133443.182468-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220607133443.182468-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 07 Jun 2022, Krzysztof Kozlowski wrote:

> Convert the Qualcomm Top Control and Status Register to DT Schema.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/mfd/qcom,tcsr.txt     | 24 ---------
>  .../devicetree/bindings/mfd/qcom,tcsr.yaml    | 49 +++++++++++++++++++
>  2 files changed, 49 insertions(+), 24 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/mfd/qcom,tcsr.txt
>  create mode 100644 Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml

Applied, thanks.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
