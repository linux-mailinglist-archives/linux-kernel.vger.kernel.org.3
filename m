Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1A6256951D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 00:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234161AbiGFWOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 18:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231529AbiGFWOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 18:14:33 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BAA22AC61;
        Wed,  6 Jul 2022 15:14:32 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id ay16so29396645ejb.6;
        Wed, 06 Jul 2022 15:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TYMK3ln+pSNgbS7KOrXcaQql59e3lfO5o9Vh/Disa6M=;
        b=dkK2PS7nhz4EujhfD9DEEsNzKaIRjlO2x3xVl4LpoxH/NxfOj5O1FlFUab9wbVVPuN
         RtCsejv88cUcmBQW5VGGM1jP3Zs4cKLFQLub5wPwft8npAM6lLiC/NZs/PI+avgrlnKU
         4k0M8elby461geQv6iH0QONQ86waMZ+gCcvIOOyYSQwFXvaP1B1QG69xvuQl5ZAABFCm
         gnoSwzgXaryr9e8J4IPV/dRPwdOMovJxy+pniEoYi7X94eG1mAzR7ZgDiaPla+6B+Voe
         Q2fXr8ArtmNB7vWIKsiMQFsmyW0aDtgc0sXLjeN44ohw/q/zRkAck0Xpl+NRE2KaV9AT
         yH+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TYMK3ln+pSNgbS7KOrXcaQql59e3lfO5o9Vh/Disa6M=;
        b=PusxpXMqE3LnOWElLqqdQ3oB3Wahd66enVomA9mGcyXNrWZKdL8olvm+J6aFEEPYav
         2cbqU3grSw4J4iErE2b3oLSOib9duz1e63E08CsV0xNQ01gVwPGTNdVVmaooeULRdADI
         WRD1b/kZiFoXQ/O2P0EmTIEKatpdxLAoiDc0rivy2fsTTiPZS8IkJJ+9cKQG2ZTaRg2t
         Y/y0h8/LBMtu4ZyEzeRgZVYLNzoeKOIA0Yn/A6zjXA6HlRR9cWqfW9AonpX6rg4w99XW
         kIfeWmLNwk4tgS3X0bH4rGfdcJZ02NCa4tVE+Ej037wF/n87+SC4euSzpx4WDUurtJkZ
         /eAw==
X-Gm-Message-State: AJIora96NOT0z8kvr+6g6s7g6c1vH5hd3RzXG3AGT0FtUjgV/WESlGst
        r16wbQcnGvzzqdcdUJx8n+A=
X-Google-Smtp-Source: AGRyM1v2JamViWRyTXzG8NmqwF8WYnnH0qBvOl33Ie7zrjpg9RqbfRsxXKjQjILqY+1eXmgrVgTjFw==
X-Received: by 2002:a17:907:8a14:b0:72a:facd:c058 with SMTP id sc20-20020a1709078a1400b0072afacdc058mr5095096ejc.666.1657145670954;
        Wed, 06 Jul 2022 15:14:30 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.googlemail.com with ESMTPSA id h18-20020aa7c952000000b0043a6fde6e7bsm6509469edt.19.2022.07.06.15.14.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 15:14:30 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH v3 2/3] clk: qcom: lcc-ipq806x: add reset definition
Date:   Thu,  7 Jul 2022 00:13:26 +0200
Message-Id: <20220706221327.14169-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220706221327.14169-1-ansuelsmth@gmail.com>
References: <20220706221327.14169-1-ansuelsmth@gmail.com>
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

