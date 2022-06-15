Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 908F554CFD5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 19:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346942AbiFOR2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 13:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349688AbiFOR2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 13:28:15 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A293511170;
        Wed, 15 Jun 2022 10:28:14 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id o8so16311010wro.3;
        Wed, 15 Jun 2022 10:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5p+/GSuDH7DU+haokwep++BzNF1uaX8KwEE3l/bKixQ=;
        b=aoeX2dNtldafqudyp1FrCTKKgQbkpuQlpIhYY13LI6ik7SdeEddlaVFDny6FaC+TyH
         uZhCQVUxV2HSzdWJDGMl5JQhG2vksAl3aBKTPqbYen3Bs6qSA6LkGEhbvuxAHTyT8Drj
         h674Qf5J/BHZMU/lSlE90CR61vmSBEC988o/Cq0is7coTfhVzJrr1QiOKnzFTdRO64wW
         9J8ows5yx0JZJ2JHEXwU1Uu7agBjQ+BS6RORhRgGdHPEWuqgtvkBJNJQmKVzi1ykXxR0
         9rW53ODeXV/rRSgFBNMLS+DZWbU9Zgns5L6HjWpVGkyhyddOrb/+OIaGsB+fP4BqTos5
         5kOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5p+/GSuDH7DU+haokwep++BzNF1uaX8KwEE3l/bKixQ=;
        b=YFhI5ulgWJ6RR0eQvN0ylIkowXkqO35K7ViAJSaUwAAlE2JpsE/TfNo04yR9zLQ8VC
         B038R/VSDzvoBZue8xE5nBg+jwP4jrww7Le9YIqkyXPh+kqODpB1qd1tc9H60KoTVWDm
         5p2FmmUj7tY/cuBBzH2UbRErKYwhbNu9popj1IxB7n+xBePccsFMp4nu/XsyPp+YoTQZ
         nhduNFXYqOM7Q7bplKTTAwr0PdPtXTBE8qcm1clFP1RwXyMl6tXaU93Wa+i3BZjoCKpJ
         He2nMopm+yTxxp7/sBUe/EVkYJFEy6jUuMiFfexHe4z7mhn/uR6Cg41Ig4B5KRTJ/R2V
         vcPQ==
X-Gm-Message-State: AJIora9uGRJBkI5FDN4PAUYrWC/GcmJYB407Oo+LO6HA9MqGi2tYm+74
        txEMqJ5WbdwA+13qv/okb2k=
X-Google-Smtp-Source: AGRyM1sZY/XiigSVJpzOXfqHHCYA+5h9Sh028/tS//A8GVFGo2Q+rjcAV9XvIX+FLKzGZ/CGvKsgBw==
X-Received: by 2002:a05:6000:1a87:b0:218:52c5:a59a with SMTP id f7-20020a0560001a8700b0021852c5a59amr825550wry.686.1655314093027;
        Wed, 15 Jun 2022 10:28:13 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.googlemail.com with ESMTPSA id w3-20020a7bc103000000b003976fbfbf00sm3023792wmi.30.2022.06.15.10.28.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 10:28:12 -0700 (PDT)
From:   Christian 'Ansuel' Marangi <ansuelsmth@gmail.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Christian 'Ansuel' Marangi <ansuelsmth@gmail.com>
Subject: [PATCH 2/3] clk: qcom: lcc-ipq806x: add reset definition
Date:   Wed, 15 Jun 2022 18:34:07 +0200
Message-Id: <20220615163408.30154-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220615163408.30154-1-ansuelsmth@gmail.com>
References: <20220615163408.30154-1-ansuelsmth@gmail.com>
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

Add reset definition for lcc-ipq806x.

Signed-off-by: Christian 'Ansuel' Marangi <ansuelsmth@gmail.com>
---
 drivers/clk/qcom/lcc-ipq806x.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/clk/qcom/lcc-ipq806x.c b/drivers/clk/qcom/lcc-ipq806x.c
index 1a2be4aeb31d..ba90bebba597 100644
--- a/drivers/clk/qcom/lcc-ipq806x.c
+++ b/drivers/clk/qcom/lcc-ipq806x.c
@@ -22,6 +22,7 @@
 #include "clk-branch.h"
 #include "clk-regmap-divider.h"
 #include "clk-regmap-mux.h"
+#include "reset.h"
 
 static struct clk_pll pll4 = {
 	.l_reg = 0x4,
@@ -405,6 +406,10 @@ static struct clk_regmap *lcc_ipq806x_clks[] = {
 	[AHBIX_CLK] = &ahbix_clk.clkr,
 };
 
+static const struct qcom_reset_map lcc_ipq806x_resets[] = {
+	[LCC_PCM_RESET] = { 0x54, 13 },
+};
+
 static const struct regmap_config lcc_ipq806x_regmap_config = {
 	.reg_bits	= 32,
 	.reg_stride	= 4,
@@ -417,6 +422,8 @@ static const struct qcom_cc_desc lcc_ipq806x_desc = {
 	.config = &lcc_ipq806x_regmap_config,
 	.clks = lcc_ipq806x_clks,
 	.num_clks = ARRAY_SIZE(lcc_ipq806x_clks),
+	.resets = lcc_ipq806x_resets,
+	.num_resets = ARRAY_SIZE(lcc_ipq806x_resets),
 };
 
 static const struct of_device_id lcc_ipq806x_match_table[] = {
-- 
2.36.1

