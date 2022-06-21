Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6A325537E0
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 18:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352784AbiFUQdz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 12:33:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352822AbiFUQdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 12:33:50 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FD05140A1;
        Tue, 21 Jun 2022 09:33:49 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id kq6so28613577ejb.11;
        Tue, 21 Jun 2022 09:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TMot/xekbMLoSetb5C/KpO7AbnsR7HF/KXErfGdxKtA=;
        b=kKvdixKuSH09T9ojHlWs5P8s6ZFYSQiF+EkDI5PW9D1wsZRKhF04fplB24kfglnUaF
         Blfbi9kk0kctPb5kAx0wx5YswlflzMTTeBnNK5yEOuPkJ/vCeXl+lVAfeJTpiq66AUTE
         wmmkRQ3KeUEoHOvrNnjgc1I8bHfUPcxLp2q7WD/CkWDeR9lBTlC7Id5Pz1buM+G8NCQf
         wDvTYJTb5MSIOvQwZ7bqnd6T8eWhN94B37YKhBcZjNRTjHwCijCyq31p0o6/ImAXwM25
         UMwViWoeYxlrfLQ6dzE3CoYkTGjPz5CFKQfD3P3D9IxzyO6ceT9ibgxeu/nlruzaAjZX
         yBng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TMot/xekbMLoSetb5C/KpO7AbnsR7HF/KXErfGdxKtA=;
        b=bq2y4ME/n2tzRDBsyw6GmngDtJkLsLIQxP9302lKkt1gcGhmwd2kX49F25BYbzRfG3
         jUeCo9f3S+J0zHiGehNuv6nWXMD9BRGGkOdYuKoVGpg8Vr5DsAxdCuzsHf56mLoPduXO
         3Bs+nxfLAvTP+2ardbk30zM/spYTBoZoFSQCAJdyrEJ6Sq2nxQqyJwUmGmU/tzAxigV8
         bIjkvIBb84w9NBLpLe9jllRwgxSX06urb3Wi40LDcth53Q73EZOxsTuXIRzG2hb9f0EJ
         kyi+fKQDl7FWi5TYd8ViTnw52qkdR1TV4nOcbh+VcDvqNsHy1mYw3euom/oNz+d5AlQl
         NkLg==
X-Gm-Message-State: AJIora/abAsi5pOU9MzsTplE0Ir4ss47QQe2LlA8fGIqKkE7z0KPBF05
        l/MM5w3M0UueKFc8jUh09MY=
X-Google-Smtp-Source: AGRyM1uOOMzFmUVzpViVCXKpRq0eC0pGB3ZVYU1xLuKOdbmkIHox7he1uiWKcYg4PbEMpfqQaLNBjw==
X-Received: by 2002:a17:906:434f:b0:711:eb76:c320 with SMTP id z15-20020a170906434f00b00711eb76c320mr26566422ejm.636.1655829228106;
        Tue, 21 Jun 2022 09:33:48 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.googlemail.com with ESMTPSA id g5-20020a50d5c5000000b004356c0d7436sm9557663edj.42.2022.06.21.09.33.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 09:33:47 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH v2 2/3] clk: qcom: lcc-ipq806x: add reset definition
Date:   Tue, 21 Jun 2022 18:33:25 +0200
Message-Id: <20220621163326.16858-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220621163326.16858-1-ansuelsmth@gmail.com>
References: <20220621163326.16858-1-ansuelsmth@gmail.com>
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
---
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

