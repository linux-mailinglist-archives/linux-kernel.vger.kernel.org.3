Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A5CC5A9044
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 09:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234122AbiIAH1b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 03:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234009AbiIAH0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 03:26:06 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 804833F1D5;
        Thu,  1 Sep 2022 00:25:05 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id u17so1836803wrp.3;
        Thu, 01 Sep 2022 00:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=6VaWfIMqQwWIuH48wiOxaFvCdMYIP4kQOJiPuxxadM0=;
        b=OvNo35JDbauqpe3x9P30vcfSSWjPy+fWJ89Jp87PYKrFjQ8boMGXr8SAcZAzIRAebG
         gs8GhdSk1whQyVnb3Mo5YP4xuYDu3xibPXrSR14ovgnS+u5/8mjM2MUdGr8MBs/8iNt8
         JVQXECy/YYWbG4J+Mz9bhmLaYrCCc91xSWYOT4Q17BSsVOIweqbKcTFmpbO9sKONBXCv
         qdu/gKWknhVLv3J2+2BalvyiXi6KXLjoxbx9IlsUJi8n7a4O4PibF2vCSLM+HNsnx06P
         VLnnmW4Z6b3KPWWYIOEO+WirJAWS4WKVPwEMmVb1X/eiCroMEqDWxj19qZ8Na7lCEYYx
         PGoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=6VaWfIMqQwWIuH48wiOxaFvCdMYIP4kQOJiPuxxadM0=;
        b=xp8SFr7Q6r++eDOA0we4ZxVdi8ErRvXXi5rHDaiByPE4CbQkzUDMxSkuUOi/nSCErw
         ynELNbCCr+DSqKGnryA7bBfQSgBoO70A7gabT81KUvVZ85+Vi7sS8Mmh95VKmnRzmot7
         m6AUziTZESiCgGeweclo48N8L6VgHNUtXeMwOeGFtl96wtKoCcTUz/jII2DT9Zzp8PYO
         sXlxcZS6jIN2Gdd9Oj3GrLzFhcsoIIquGgQ/wAgSnmFyG0A/6APNp1FQO5XnQosb+LUc
         cUbzf4fPq5Hr94sFbac/LoDnIjIGP/1OKk1RhvzK2ddxtvYTNGaeuJSbZmVL7SR3WQFm
         PLxQ==
X-Gm-Message-State: ACgBeo0csv3rLMxEEH2KVa+G5gkisebqsuVe1ab8Ft5vwrz5IDnKb0sg
        RIbynEExgsyf6GI4IxBt1nw=
X-Google-Smtp-Source: AA6agR52gXzUQSFvEIvbGObr1bidRkmMGaq7HFEyiC3HcjgEoPt7GTbsou6ii3QSCLAMOhrlpssdKQ==
X-Received: by 2002:a5d:6c6b:0:b0:225:dde:ab40 with SMTP id r11-20020a5d6c6b000000b002250ddeab40mr13860932wrz.690.1662017104138;
        Thu, 01 Sep 2022 00:25:04 -0700 (PDT)
Received: from localhost (87-126-55-15.ip.btc-net.bg. [87.126.55.15])
        by smtp.gmail.com with ESMTPSA id o21-20020a05600c4fd500b003a32297598csm4740010wmq.43.2022.09.01.00.25.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Sep 2022 00:25:03 -0700 (PDT)
From:   Iskren Chernev <iskren.chernev@gmail.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Iskren Chernev <iskren.chernev@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 13/14] dt-bindings: arm: qcom: Add compatible for oneplus,billie2 phone
Date:   Thu,  1 Sep 2022 10:24:12 +0300
Message-Id: <20220901072414.1923075-14-iskren.chernev@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220901072414.1923075-1-iskren.chernev@gmail.com>
References: <20220901072414.1923075-1-iskren.chernev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

oneplus,billie2 (OnePlus Nord N100) is based on QualComm Snapdragon
SM4250 SoC.

Add support for the same in dt-bindings.

Signed-off-by: Iskren Chernev <iskren.chernev@gmail.com>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 19c2f4314741..63cc41cd0119 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -54,6 +54,8 @@ description: |
         sdm845
         sdx55
         sdx65
+        sm4250
+        sm6115
         sm6125
         sm6350
         sm7225
@@ -670,6 +672,11 @@ properties:
               - xiaomi,polaris
           - const: qcom,sdm845
 
+      - items:
+          - enum:
+              - oneplus,billie2
+          - const: qcom,sm4250
+
       - items:
           - enum:
               - sony,pdx201
-- 
2.37.2

