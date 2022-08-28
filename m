Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E776A5A3FC1
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Aug 2022 22:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbiH1U54 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 16:57:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbiH1U5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 16:57:37 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0E4430F50;
        Sun, 28 Aug 2022 13:57:35 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id h8so3544788ili.11;
        Sun, 28 Aug 2022 13:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=j+raLVGUjjyQVAbArzurzxwHN4OUaZx2fr+/eun+qZg=;
        b=jbuyR5Kj8361+pC4UkyPfdfg0YhTaZQb4XqO4gTbl3zNIFvn1UG1Duk7Tl3G+9juO2
         bwgrk8ioCQ+INGU0p0XaMxRi/eFLr7U04GcZ3Gyvq7y30ISGKulojgNGDdoRKJ3A5FCW
         y7mTMJZ97nl/SALLQZUd+N4FNRemgjja+G4NeVUrXvqhuXQ2b1z/kHZmMeDz6jsy/k0o
         cTWi20rcsAr6esgKfvjf2faAgUHrnFVOFOjy3z6XwoPNA+RLnGqhFSKG3bWd6mSP4711
         zbobn+DT4IObIZJgWc4mlqUIpI9KQ9LUJjB3Qz8d/lCfjWAmBuQT0Q6oBe/8F1paI88f
         ZYTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=j+raLVGUjjyQVAbArzurzxwHN4OUaZx2fr+/eun+qZg=;
        b=aPBMx/fDLPsJjshCREfes0udjP12q8Sq2yjqycF93kQNSRUHwLwcmpxUdfMfFXsMqH
         beeXlvDesc5QSib0b+5MNBfG4XBdP4vNJMpjVCnMcciSZjQINR3Tbb01nMXobO4i59rR
         oG8KR2vJaagBqQDQjTTk27JeDlXz9alBh3Cn8RqsnW0yj0CaaFTbfPXij0otss4O/yL3
         Xtj3vCwKpZ4ktTdI+71NbYv5Dtr41ULA13/CV2UtUNbtI7gihIFBem+o7QH8BWaIKY3X
         5aKjn3bOjf7g8jTFHaPPq3rKNTdOhJgjI2KM6VpKStGovPO6fwtWsjZ9vG26SjyDghMG
         NnzA==
X-Gm-Message-State: ACgBeo2del8pPknCHarGriKEEEfDhcPmv/25Bl5jBXod52x1aww6PjFs
        BI/zLUUjK0crAGqDTlkqgoWl5HK+9z4=
X-Google-Smtp-Source: AA6agR7tz/opQwcSYBVP8BD2l5x0zcXbmqlTBMxk4DKpHtV0LeW49cgY1N3H6020G3gSxBMEOU8soA==
X-Received: by 2002:a05:6e02:1a88:b0:2e9:773b:f21c with SMTP id k8-20020a056e021a8800b002e9773bf21cmr8503939ilv.152.1661720255411;
        Sun, 28 Aug 2022 13:57:35 -0700 (PDT)
Received: from fedora.. ([2604:2d80:4d8e:a000:6063:7cd5:2f24:16a6])
        by smtp.gmail.com with ESMTPSA id k7-20020a02c767000000b00349be1ef390sm3572404jao.121.2022.08.28.13.57.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Aug 2022 13:57:35 -0700 (PDT)
From:   Joel Selvaraj <joelselvaraj.oss@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Joel Selvaraj <joelselvaraj.oss@gmail.com>
Subject: [PATCH v4 3/4] dt-bindings: arm: qcom: Add Xiaomi Poco F1 EBBG variant bindings
Date:   Sun, 28 Aug 2022 15:57:22 -0500
Message-Id: <20220828205723.20834-4-joelselvaraj.oss@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220828205723.20834-1-joelselvaraj.oss@gmail.com>
References: <20220828205723.20834-1-joelselvaraj.oss@gmail.com>
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

Add documentation for "xiaomi,beryllium-ebbg" device.

Signed-off-by: Joel Selvaraj <joelselvaraj.oss@gmail.com>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index e465ca45c07f..4515151e3104 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -666,6 +666,7 @@ properties:
               - sony,akatsuki-row
               - sony,apollo-row
               - thundercomm,db845c
+              - xiaomi,beryllium-ebbg
               - xiaomi,beryllium-tianma
               - xiaomi,polaris
           - const: qcom,sdm845
-- 
2.37.2

