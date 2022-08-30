Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A1195A5C49
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 08:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbiH3G6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 02:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230309AbiH3G5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 02:57:54 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BE6C564F6
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 23:57:53 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id s15so5186043ljp.5
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 23:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=MW1YzegDLarSYjOyZFmSWtQsOdOkkipTn6NsA3/awlM=;
        b=WQrkEPrveKwgi1zwLcyvWQg9IfEC9AiIZ7vmhFjQwiooHoNHNIuJLE1mKIyYZDYd2n
         uzrswmGVf8+a11ipEdX30cZKFMX+3r3t7I1Z2bX2daOtjq4XS2hevQi1iYCzyRQzdCVY
         WyGPk5ZYBg5nJLEvsJZkfx8IsAekA2e3KH8FIJMnwplCP2iOwWu9m9LivShCKVkVrkL6
         TlCuaTNF8KOa1ex27YCUdICRqP0hQM4VQ5xQHKE3vtwXY/RUEcmft+zSmE4QTSk0MWTC
         gHcfYf/LO3kLk30VzN9AtFGeO3gxWT+efWatVDW255FHX5o/erN163Z2CNCW50Jl4Z8Q
         bI5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=MW1YzegDLarSYjOyZFmSWtQsOdOkkipTn6NsA3/awlM=;
        b=g2z7CdLH4dHyin/UJ7HkIfb7VQ12mfHz8hJj8kiuPVYgH7DOQrhNJYW7byrPsXRnJO
         v3uwG+fUJLicLMbVUJd75jei1dkHi0m55jmctQbUXFdecElFnWZQm80osR10/O4xibiC
         pPU+lsX/+IjtPV0EogAcF/fFeLkQNvVFst02d3Z+w7PqjwRbJyZR2woF+1vzTuGzc/ch
         wdDr9aik2emQQUV0/s7uYPIfcOMc27cz3OH4HFVjnFk+0Y6mR0aqMz7YqjPlAwtLxG1C
         /bUU7V9pV4xNJnyiLwxMWCemqBbOTMZqjHVt7YrKkc3RBPee25Fur6gNV+Gb3QUom5+y
         oVTA==
X-Gm-Message-State: ACgBeo1/xuTH34pEbMVBLl6JK8QtNTUzwguKmaVCjeqVUIxEy4qP40Ft
        XpzIjUeHnQz0LSybbYcTgS9OVg==
X-Google-Smtp-Source: AA6agR6u7YjqH6u9sV/UwghO80J9vA0yT2hqA/KYJyVY6yz3/59CqJc+A1gVGLeiBTvFaLzqUFQbPQ==
X-Received: by 2002:a05:651c:381:b0:264:4fc0:611c with SMTP id e1-20020a05651c038100b002644fc0611cmr2898951ljp.129.1661842671398;
        Mon, 29 Aug 2022 23:57:51 -0700 (PDT)
Received: from krzk-bin.. (balticom-73-99-134.balticom.lv. [109.73.99.134])
        by smtp.gmail.com with ESMTPSA id c1-20020a056512074100b00492cdba2903sm1515420lfs.97.2022.08.29.23.57.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 23:57:50 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH v7 3/3] arm64: dts: qcom: msm8992-xiaomi-libra: split qcom,msm-id into tuples
Date:   Tue, 30 Aug 2022 09:57:44 +0300
Message-Id: <20220830065744.161163-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220830065744.161163-1-krzysztof.kozlowski@linaro.org>
References: <20220830065744.161163-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The qcom,msm-id is an uint32 matrix, so a list of tuples.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8992-xiaomi-libra.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8992-xiaomi-libra.dts b/arch/arm64/boot/dts/qcom/msm8992-xiaomi-libra.dts
index cbe11c060df9..c4e87d0aec42 100644
--- a/arch/arm64/boot/dts/qcom/msm8992-xiaomi-libra.dts
+++ b/arch/arm64/boot/dts/qcom/msm8992-xiaomi-libra.dts
@@ -17,7 +17,7 @@ / {
 	chassis-type = "handset";
 
 	/* required for bootloader to select correct board */
-	qcom,msm-id = <251 0 252 0>;
+	qcom,msm-id = <251 0>, <252 0>;
 	qcom,pmic-id = <65545 65546 0 0>;
 	qcom,board-id = <12 0>;
 
-- 
2.34.1

