Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B670951AC18
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 20:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359551AbiEDSGR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 14:06:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352143AbiEDSGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 14:06:09 -0400
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C8174FC7A
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 10:21:21 -0700 (PDT)
Received: by mail-oo1-xc32.google.com with SMTP id o10-20020a4abe8a000000b0035eac0a004aso298050oop.11
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 10:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ORNPzRgYv7YnV5Fde8tTKS8ROVdrDUKlmliJj1FHZuo=;
        b=g8IyPtmt4/LHdH3ytClVEo0NkSuL5GdZYSYGabLd3MJIiBFuxruqO1CfgPHDBvuFhR
         4qPpFhLcuq/s3U7p8JgycBU7NCO2wWwJGn23mtqfHOJUyPyNKSQQ8JHsxq4cu+ar+Qqe
         wSv++IE/PdQ9B0P5xRMd9142XGt7Xyz62AIR7UjqGnVq0ZIQNQgm/4ePP6I5lkZBRRTR
         yj1XZK2PobPThZE1SqOgZJkhN/KLs/rjMNAd6BIU+p9+j6dZk+jVthzJvuEMPPuN+z9U
         LdXKS0jdmpOq62JXBtAdyXn9falbeznu5Pk0/PQXit1sPl1DJyV33DO6XuWtk6MyNjTk
         3Jag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ORNPzRgYv7YnV5Fde8tTKS8ROVdrDUKlmliJj1FHZuo=;
        b=L7PBGEwGbb6nRn4qpSyariPHwL9uFefz7gQosaWfG9G+NH9cTyKOXT93Mbu9YH5b7N
         YW6PZk8kUIUl0kgPZPfbFJ2Ia+jwH3yOU/cU1H8gTg3pXHlNKWdSFJNG5K75EQaZFwC7
         j/91EpTfr0AUzsI3E/ySXYQKkmU/OEYBRHKAfgL+ViEemxyWAlAGjNVMMam4camJU4FP
         ZAOzLaUk1g1NpJBD8YvbtxR7vkiHT0CmF5j0EF9eUxeGrdFnQwytK7Ha6l5EKdWJblMt
         9K/mhySm1RP9RTSoAf5qYdPr5FmSw8WbudZE+IEu0nfQVbuZdbOmTH24RgWyVVMANgc+
         6KVQ==
X-Gm-Message-State: AOAM5327rts8Ik530oGQnLNzFiRqenczZGHd56/3UVHXzeWyMGtGwmrG
        dzxQAt6SDIBTFsv5yIKYkpkHVg==
X-Google-Smtp-Source: ABdhPJwMqSVDuAvnYy73jmRdQoEIfgo5fv1st0dqy1v9VMmqrrghT+nr0jbtij52v7QbgZqqgS+nsw==
X-Received: by 2002:a4a:d047:0:b0:321:1ab0:e461 with SMTP id x7-20020a4ad047000000b003211ab0e461mr7583384oor.20.1651684880902;
        Wed, 04 May 2022 10:21:20 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id a7-20020a056870b14700b000ead8b89484sm5785452oal.5.2022.05.04.10.21.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 10:21:20 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 0/2] soc: qcom: llcc: Add sc8180x and sc8280xp support
Date:   Wed,  4 May 2022 12:21:06 -0500
Message-Id: <165168485227.3730817.14981788668130390818.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220502215406.612967-1-bjorn.andersson@linaro.org>
References: <20220502215406.612967-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 May 2022 14:54:04 -0700, Bjorn Andersson wrote:
> These patches adds support for the LLCC instance found in the sc8180x and sc8280xp.
> 
> Bjorn Andersson (2):
>   dt-bindings: arm: msm: Add sc8180x and sc8280xp LLCC compatibles
>   soc: qcom: llcc: Add sc8180x and sc8280xp configurations
> 
> .../bindings/arm/msm/qcom,llcc.yaml           |  2 +
>  drivers/soc/qcom/llcc-qcom.c                  | 60 +++++++++++++++++++
>  include/linux/soc/qcom/llcc-qcom.h            |  2 +
>  3 files changed, 64 insertions(+)
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: arm: msm: Add sc8180x and sc8280xp LLCC compatibles
      commit: d0d8cb7b94b8d23e9721cbbec5c7b00c04ae6514
[2/2] soc: qcom: llcc: Add sc8180x and sc8280xp configurations
      commit: ec69dfbdc426f22a9557e5c5408d7902fe0e0144

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
