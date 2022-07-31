Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 895E65861BC
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 00:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238661AbiGaWh7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 18:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238604AbiGaWhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 18:37:54 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5BA711C01;
        Sun, 31 Jul 2022 15:37:52 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id f5so4483228eje.3;
        Sun, 31 Jul 2022 15:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=E78vVMtc7f/kJp9kiC1cKaHhJet4qcz61infxNVXd+Q=;
        b=kcg09dPpTYJWP2WLOcLiCIr10CGJN6PYpVWdNFqHZOJQ7Xufn4xR+QKF34mi1phH3K
         CEmSLBantE5XLr0hSXeepDCOGZFqayvfn+vxH1nFiKeWFcNfh4l3COhujn72GM7Uctro
         ORmC5+ATZf7OocUohZ4dYTumkixNJS5NGMUQpCI4EGmNrc6XdLil3WiUcvA4cltAVYoX
         DEnsrC63IpmnzGCSB25Q3G/QjFooacNz52uWaHpZcHe94dIsAnCIBoOSKhLJa9jEwPv+
         nb27HZDw8BRztrvU/iFzAVCdpyvs5Hd9CtQZnX7tFVEGz3IDcuim1H7t7PNJikf1WXxX
         Wmjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=E78vVMtc7f/kJp9kiC1cKaHhJet4qcz61infxNVXd+Q=;
        b=S9hnQPP6G63dhpLpoCTnUZqvc9pK26C060bu6BPpjPRu8BC93uFGAaiuob6Ykk+F2k
         hx6Ij6G7AwLa9p/yPwIXp3rEi6Np5lVSvZbE8xkhPfWLuS7LVgNY1F+8/igBFrwTsb4O
         RmPJHdlZ9SlCtJSCAhYxVkylgcme8r0Llr6Ztek1+/hRDQJc2MZevw8aDp7V7RwFTZR2
         53BxboK+iLL/+yiw7z1teudiEaQBoBROWRNDSRuGbWraCoaEjvGYwwT0hXtQ9Y+9X5mM
         H6u1McBwZJKGaPJ4hZOu2g7w9X5HY8LVEqR4Vnz7Y5V0YusG8YSMvxWTYG9KnrLPDu0K
         DABA==
X-Gm-Message-State: AJIora9mnwMu6anc37GbWk2QwneKMLTci9x8uHxqQ0cmVrWDgB26knTz
        W+Ij6impCH6uBWstIvTVKwM=
X-Google-Smtp-Source: AGRyM1syCLMD4Es3S7kxU3Pt+wVKZo/ApN8hbpMqUSeev+fmyW9spzaUZjMcGzFGJJkb2CSM6GRvxQ==
X-Received: by 2002:a17:907:2815:b0:72b:70f6:4ced with SMTP id eb21-20020a170907281500b0072b70f64cedmr10138359ejc.353.1659307071342;
        Sun, 31 Jul 2022 15:37:51 -0700 (PDT)
Received: from localhost ([77.78.38.236])
        by smtp.gmail.com with ESMTPSA id u2-20020a1709061da200b006fec4ee28d0sm4479538ejh.189.2022.07.31.15.37.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Jul 2022 15:37:50 -0700 (PDT)
From:   Iskren Chernev <iskren.chernev@gmail.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Brown <broonie@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Robert Marko <robimarko@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Iskren Chernev <iskren.chernev@gmail.com>
Subject: [PATCH v3 03/13] dt-bindings: regulator: qcom_smd: Sort compatibles alphabetically
Date:   Mon,  1 Aug 2022 01:37:26 +0300
Message-Id: <20220731223736.1036286-4-iskren.chernev@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220731223736.1036286-1-iskren.chernev@gmail.com>
References: <20220731223736.1036286-1-iskren.chernev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sort compatible strings and their descriptions by PMIC-name in alphabetical
order.

Signed-off-by: Iskren Chernev <iskren.chernev@gmail.com>
---
 .../regulator/qcom,smd-rpm-regulator.yaml     | 22 +++++++++----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/Documentation/devicetree/bindings/regulator/qcom,smd-rpm-regulator.yaml b/Documentation/devicetree/bindings/regulator/qcom,smd-rpm-regulator.yaml
index c233461cc980..39802c1223c6 100644
--- a/Documentation/devicetree/bindings/regulator/qcom,smd-rpm-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/qcom,smd-rpm-regulator.yaml
@@ -24,6 +24,14 @@ description:
 
   For mp5496, s2
 
+  For pm2250, s1, s2, s3, s4, l1, l2, l3, l4, l5, l6, l7, l8, l9, l10, l11,
+  l12, l13, l14, l15, l16, l17, l18, l19, l20, l21, l22
+
+  For pm660, s1, s2, s3, s4, s5, s6, l1, l2, l3, l5, l6, l7, l8, l9, l10, l22,
+  l12, l13, l14, l15, l16, l17, l18, l19
+
+  For pm660l s1, s2, s3, s5, l1, l2, l3, l4, l5, l6, l7, l8, l9, l10, bob
+
   For pm8226, s1, s2, s3, s4, s5, l1, l2, l3, l4, l5, l6, l7, l8, l9, l10,
   l11, l12, l13, l14, l15, l16, l17, l18, l19, l20, l21, l22, l23, l24, l25,
   l26, l27, l28, lvs1
@@ -52,11 +60,6 @@ description:
   l3, l4, l5, l6, l7, l8, l9, l10, l11, l12, l13, l14, l15, l16, l17, l18, l19,
   l20, l21, l22, l23, l24, l25, l26, l27, l28, lvs1, lvs2
 
-  For pm660, s1, s2, s3, s4, s5, s6, l1, l2, l3, l5, l6, l7, l8, l9, l10, l22,
-  l12, l13, l14, l15, l16, l17, l18, l19
-
-  For pm660l s1, s2, s3, s5, l1, l2, l3, l4, l5, l6, l7, l8, l9, l10, bob
-
   For pma8084, s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s11, s12, l1, l2, l3,
   l4, l5, l6, l7, l8, l9, l10, l11, l12, l13, l14, l15, l16, l17, l18, l19,
   l20, l21, l22, l23, l24, l25, l26, l27, lvs1, lvs2, lvs3, lvs4, 5vs1
@@ -68,9 +71,6 @@ description:
   For pms405, s1, s2, s3, s4, s5, l1, l2, l3, l4, l5, l6, l7, l8, l9, l10, l11,
   l12, l13
 
-  For pm2250, s1, s2, s3, s4, l1, l2, l3, l4, l5, l6, l7, l8, l9, l10, l11,
-  l12, l13, l14, l15, l16, l17, l18, l19, l20, l21, l22
-
 maintainers:
   - Andy Gross <agross@kernel.org>
   - Bjorn Andersson <bjorn.andersson@linaro.org>
@@ -79,6 +79,9 @@ properties:
   compatible:
     enum:
       - qcom,rpm-mp5496-regulators
+      - qcom,rpm-pm2250-regulators
+      - qcom,rpm-pm660-regulators
+      - qcom,rpm-pm660l-regulators
       - qcom,rpm-pm8226-regulators
       - qcom,rpm-pm8841-regulators
       - qcom,rpm-pm8909-regulators
@@ -88,13 +91,10 @@ properties:
       - qcom,rpm-pm8953-regulators
       - qcom,rpm-pm8994-regulators
       - qcom,rpm-pm8998-regulators
-      - qcom,rpm-pm660-regulators
-      - qcom,rpm-pm660l-regulators
       - qcom,rpm-pma8084-regulators
       - qcom,rpm-pmi8994-regulators
       - qcom,rpm-pmi8998-regulators
       - qcom,rpm-pms405-regulators
-      - qcom,rpm-pm2250-regulators
 
 patternProperties:
   ".*-supply$":
-- 
2.37.1

