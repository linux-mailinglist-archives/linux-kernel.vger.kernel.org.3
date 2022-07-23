Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32C4957EFE3
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 16:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238028AbiGWO4M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 10:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236191AbiGWO4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 10:56:06 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCA21101DA;
        Sat, 23 Jul 2022 07:56:04 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id tk8so13140132ejc.7;
        Sat, 23 Jul 2022 07:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TYMK3ln+pSNgbS7KOrXcaQql59e3lfO5o9Vh/Disa6M=;
        b=IWTtt2ngyBcGG/5CAnF4n7K/4H5wmjxVFDsP+5b2f9FxGZ3uaiEaxDksAazRtynZiG
         HrA+VZZtXSicN4WovL6uTfUc5YGnimXnNXO3waCHc4S7d8Fne90NEB5ZjwPlQ0yzSlMz
         UZ4Ji3CNSFnxfRozRV7fZX5GfBpoKswUQjtcORSzvIjAStQgLdbgEsv0ATkfZzfhcFpq
         kEzzNx95Y7JrMgtvzvCwaJ3//y+rktDRWj8qZlIywCcCcaSQIWCx358FLpOgovdUuX8e
         nSF54S3HkmudGREQP+tmVcvqgY7YR6lFdJzqlwg9i5CDFRj1AYK7yIc4vCQMRWFHeMjQ
         HlZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TYMK3ln+pSNgbS7KOrXcaQql59e3lfO5o9Vh/Disa6M=;
        b=aUNBLAetlkUhcTtfhl9098helRy5uSyNz2vEzhi4TcPIntko7UGydBHoIKow+Ue02x
         qlpY/8YlkQJ2bk8Onr4Z63ZQnyLWWOgnQK3Sk/TVffC21c/MR4rW3hnAVi7EOa/eFH6R
         Qi5cqPLduqO3u5hQL/5oodshra4UrNhkQ55SsjUwFm53vkm/xAQZUjBGxku0fQv1M6N3
         XTnu4S51O9jkJB3+tC7uSx5InWcE/vb4F6OCiUlR+Yxs6sRzvCcQM6x0D0nl1DWPOasB
         L1j3EslcdCCdWvs+k/leLaB98vevnUCIXPkwQ8wG2efRL7eAYj5ceODQGRUBbaDWQ2Pk
         70MA==
X-Gm-Message-State: AJIora80KeoQDVviwkzApQRg236txSF6keq0TWKBXu7jlm72BVOOsXsY
        SX8Wbj0yedCdPl/gdEyS3sGpCdUwQ3U=
X-Google-Smtp-Source: AGRyM1uJOSRbEs9FMeIIof8y6QSVSs3G/IJBSDg5ZCvC0xUq2NHaIIDR3Qd5xj5tMuIZ1pG6Ww8O9g==
X-Received: by 2002:a17:906:478b:b0:72b:5cd6:3f50 with SMTP id cw11-20020a170906478b00b0072b5cd63f50mr3712733ejc.514.1658588163186;
        Sat, 23 Jul 2022 07:56:03 -0700 (PDT)
Received: from localhost.localdomain (host-87-7-207-127.retail.telecomitalia.it. [87.7.207.127])
        by smtp.googlemail.com with ESMTPSA id cy24-20020a0564021c9800b0043ba1ecb0dfsm4143781edb.75.2022.07.23.07.56.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Jul 2022 07:56:02 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH v6 2/4] clk: qcom: lcc-ipq806x: add reset definition
Date:   Sat, 23 Jul 2022 16:55:56 +0200
Message-Id: <20220723145558.25210-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220723145558.25210-1-ansuelsmth@gmail.com>
References: <20220723145558.25210-1-ansuelsmth@gmail.com>
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

Add reset definition for lcc-ipq806x.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
v3:
 - Added review tag
v2:
 - Fix Sob tag

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

