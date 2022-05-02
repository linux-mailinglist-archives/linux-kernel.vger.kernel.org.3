Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D37BC517977
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 23:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387773AbiEBV4P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 17:56:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234218AbiEBVzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 17:55:51 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 998CB38BF
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 14:52:21 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id l203so16585018oif.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 14:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m7cFEgSG093ymIwJOUazHZ2tzJugEpErbHWE8WXYuz8=;
        b=D+e6zSMU/lo2ulKiC5s6i8eyAliSd+WLo/190SJbLKVH/F/nZJhxsSN/HieZA4aDQ+
         uJkEFkJ8pqxTzyW80fPGmJu0b3MpFmlmY9e59KtNXx1lomYvRKlHzVIky8vaeeVXMW+N
         ++/5Xt5vQUeDV76zYzDWRzy5Z5Rso4xdAnkp6+cfW795M/nbDR2ZNujrLdzzws9Pzjtc
         c0iAl+Ya6zL1o7HMJpWfo836T8n0RrmdA7hAT4Cy3jpr5PiQGbzEPCp4mE01jLYPnVzJ
         BiUHfoaHmqJmVZro0eBKS6cOilbZSd28X9YfjZuwMsv1d2GZsqc68DXvkJ9cGYK2SRk8
         QR9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m7cFEgSG093ymIwJOUazHZ2tzJugEpErbHWE8WXYuz8=;
        b=wxhEm5JN4ZTOq/sK45rvbM6X+NHABVixk6S/KpEbrrHqfyea0WC0RAXC7/Wf/mQ9f7
         73T85NZnvondBjkKn9fM0yR5Of0tMjnQ6E0wg8lNOhrVVelrWFt8gaHtyJ7tnZ++TBJZ
         3O48J1otDa5OzKY7oRC0cmfwwk8jiW2ERKzMu6mBAgkQu+WbYzz7yTPRuEKwxkv6JMJ4
         JHh63ycNGfub29TEJJXy/4n+kKr/qUT7ANHvrh9xp1KU8sAhae2rIl1voc6FIEn1owxr
         E/Ih7fGq2XCPMAIWeRemxni3Fmhq6TIKYD9XakBo6/gUtAi/uQzRU/5Vq7HLlvYrvKbI
         cVbg==
X-Gm-Message-State: AOAM5309yi87uKxO7GB1yieDjb1+rhCkx2ji5Gnvqpdqzgz5EIJZaWSz
        yrRL2X2vn+xuqiRbnHYDOeuf8g==
X-Google-Smtp-Source: ABdhPJxgluWPoCVRCyVACraXiPxfGEtFANGj5JdQZtfNBmkUMZbAXHgiKECl6IaE5DGpzz74JlFmyg==
X-Received: by 2002:a05:6808:124a:b0:2da:3588:6d35 with SMTP id o10-20020a056808124a00b002da35886d35mr550709oiv.269.1651528341028;
        Mon, 02 May 2022 14:52:21 -0700 (PDT)
Received: from ripper.. (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id k16-20020a544710000000b00325cda1ff8asm2720406oik.9.2022.05.02.14.52.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 14:52:20 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/2] dt-bindings: arm: msm: Add sc8180x and sc8280xp LLCC compatibles
Date:   Mon,  2 May 2022 14:54:05 -0700
Message-Id: <20220502215406.612967-2-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220502215406.612967-1-bjorn.andersson@linaro.org>
References: <20220502215406.612967-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
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

Add compatibles for the SC8180X and SC8280XP platforms to the existing
LLCC binding.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v1:
- Picked up Krzysztof's ack

 Documentation/devicetree/bindings/arm/msm/qcom,llcc.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/msm/qcom,llcc.yaml b/Documentation/devicetree/bindings/arm/msm/qcom,llcc.yaml
index 30fcbe2ad8a3..5ea506412b4e 100644
--- a/Documentation/devicetree/bindings/arm/msm/qcom,llcc.yaml
+++ b/Documentation/devicetree/bindings/arm/msm/qcom,llcc.yaml
@@ -23,6 +23,8 @@ properties:
     enum:
       - qcom,sc7180-llcc
       - qcom,sc7280-llcc
+      - qcom,sc8180x-llcc
+      - qcom,sc8280xp-llcc
       - qcom,sdm845-llcc
       - qcom,sm6350-llcc
       - qcom,sm8150-llcc
-- 
2.35.1

