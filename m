Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6386F57BE80
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 21:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235734AbiGTT2s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 15:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234304AbiGTT2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 15:28:24 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0575C5C35B
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 12:28:23 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id u19so23122781lfs.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 12:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CI9tZWQPBfkok+pmOWGw9Q0/0A+A7VWYn0kM+rL1BwQ=;
        b=qZ+g1VeOb3V2rBOf9aZSGFvrxf/rzeYRaV254p07dPAGSS24ll9QmG0RwSqMpghKyh
         2b1voKVtGWBlgx8s7ArJCCS/K770jtE5pPvmJQ97GZoLTMLK6TX+YUNyJtewm/yAX6lZ
         2K47bDsEcZqRz/JbaviJFTUFO3DMqCnFU0xjK1h57mMRjbkxeJPz9p0RuGZYDuZsV0sc
         ZYS8sD406Wt/OADMH6YN4WLV5/fgA3nVS/v6ZGa2aIlr+qsYanym3qOfgtJAsznZKE5B
         0/MyTa+BNb38sJzEnXrEqxLGDyoT822GanOKvENHopxu+bF8M0e0MokZzJCmP917uQq1
         lTvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CI9tZWQPBfkok+pmOWGw9Q0/0A+A7VWYn0kM+rL1BwQ=;
        b=e9j9eCNSvZxZ91EBhMIrVoF353LQNKHa8pdJkzf4O5KFVnCYntw3qaykZSlya+ApoP
         Gz+Wkx9CEO0rGQfECy8qvOri7EA30A/fPrhb7CP6iYI6OPyviOvk7GZYW5v2X97KeASi
         9xbymwaYB71LVXWVAMr2BDxr1LKz0mMpleYeh48SJaIeHY1/tXOmld4akQQPslz5trQu
         gY0QJyCGhVxxSlx9oD95x/k3KQpTCvQ0BKbQGrGQ0PlUiANohzULB2NBf7ScP9x4pko6
         6BFLf/A365VDeN+cT6QWre0ZTXULEOdbg2b2vZwfyVbg05S1yABThWqcb/LWqW/cHb2+
         PL7w==
X-Gm-Message-State: AJIora+DRYkRvlNCD+SoT2oHtZ5ucvp5jI3oxW7UEZk0LTIcLo7ByiSK
        ScrIA2OrLqZy9KhohAOJueLb7A==
X-Google-Smtp-Source: AGRyM1vbfbR8YL2UKsxFIwmppcrPQbs2nYwolWU/Q1NxPKQcqz9KUXOQ2jXkRWGUcu20uOyp2a1rdA==
X-Received: by 2002:a05:6512:c29:b0:489:e65c:4632 with SMTP id z41-20020a0565120c2900b00489e65c4632mr22444978lfu.511.1658345302554;
        Wed, 20 Jul 2022 12:28:22 -0700 (PDT)
Received: from krzk-bin.. (89-162-31-138.fiber.signal.no. [89.162.31.138])
        by smtp.gmail.com with ESMTPSA id h32-20020a0565123ca000b0047fac0f34absm3985771lfv.196.2022.07.20.12.28.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 12:28:22 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Rajendra Nayak <quic_rjendra@quicinc.com>
Subject: [PATCH 08/10] soc: qcom: icc-bwmon: add per-variant quirks
Date:   Wed, 20 Jul 2022 21:28:05 +0200
Message-Id: <20220720192807.130098-9-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220720192807.130098-1-krzysztof.kozlowski@linaro.org>
References: <20220720192807.130098-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BWMON v5 lacks global interrupt registers.  Other BWMON versions differ
as well, so add quirks for easier customization of code flow.

Cc: Rajendra Nayak <quic_rjendra@quicinc.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/soc/qcom/icc-bwmon.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/soc/qcom/icc-bwmon.c b/drivers/soc/qcom/icc-bwmon.c
index a3bebd4f0c95..63c0aea14c34 100644
--- a/drivers/soc/qcom/icc-bwmon.c
+++ b/drivers/soc/qcom/icc-bwmon.c
@@ -101,6 +101,9 @@
 
 #define BWMON_V4_ZONE_MAX(zone)			(0x2e0 + 4 * (zone))
 
+/* Quirks for specific BWMON types */
+#define BWMON_HAS_GLOBAL_IRQ			BIT(0)
+
 enum bwmon_fields {
 	F_GLOBAL_IRQ_STATUS,
 	F_GLOBAL_IRQ_CLEAR,
@@ -138,6 +141,7 @@ struct icc_bwmon_data {
 	unsigned int default_lowbw_kbps;
 	u8 zone1_thres_count;
 	u8 zone3_thres_count;
+	unsigned int quirks;
 
 	const struct regmap_config *regmap_cfg;
 	const struct reg_field *regmap_fields;
@@ -274,14 +278,16 @@ static void bwmon_clear_irq(struct icc_bwmon *bwmon)
 	 * interrupt is cleared.
 	 */
 	regmap_field_force_write(bwmon->regs[F_IRQ_CLEAR], BWMON_IRQ_ENABLE_MASK);
-	regmap_field_force_write(bwmon->regs[F_GLOBAL_IRQ_CLEAR],
-				 BWMON_V4_GLOBAL_IRQ_ENABLE_ENABLE);
+	if (bwmon->data->quirks & BWMON_HAS_GLOBAL_IRQ)
+		regmap_field_force_write(bwmon->regs[F_GLOBAL_IRQ_CLEAR],
+					 BWMON_V4_GLOBAL_IRQ_ENABLE_ENABLE);
 }
 
 static void bwmon_disable(struct icc_bwmon *bwmon)
 {
 	/* Disable interrupts. Strict ordering, see bwmon_clear_irq(). */
-	regmap_field_write(bwmon->regs[F_GLOBAL_IRQ_ENABLE], 0x0);
+	if (bwmon->data->quirks & BWMON_HAS_GLOBAL_IRQ)
+		regmap_field_write(bwmon->regs[F_GLOBAL_IRQ_ENABLE], 0x0);
 	regmap_field_write(bwmon->regs[F_IRQ_ENABLE], 0x0);
 
 	/*
@@ -294,8 +300,9 @@ static void bwmon_disable(struct icc_bwmon *bwmon)
 static void bwmon_enable(struct icc_bwmon *bwmon, unsigned int irq_enable)
 {
 	/* Enable interrupts */
-	regmap_field_write(bwmon->regs[F_GLOBAL_IRQ_ENABLE],
-			   BWMON_V4_GLOBAL_IRQ_ENABLE_ENABLE);
+	if (bwmon->data->quirks & BWMON_HAS_GLOBAL_IRQ)
+		regmap_field_write(bwmon->regs[F_GLOBAL_IRQ_ENABLE],
+				   BWMON_V4_GLOBAL_IRQ_ENABLE_ENABLE);
 	regmap_field_write(bwmon->regs[F_IRQ_ENABLE], irq_enable);
 
 	/* Enable bwmon */
@@ -547,6 +554,7 @@ static const struct icc_bwmon_data msm8998_bwmon_data = {
 	.default_lowbw_kbps = 0,
 	.zone1_thres_count = 16,
 	.zone3_thres_count = 1,
+	.quirks = BWMON_HAS_GLOBAL_IRQ,
 	.regmap_fields = msm8998_bwmon_reg_fields,
 	.regmap_cfg = &msm8998_bwmon_regmap_cfg,
 };
-- 
2.34.1

