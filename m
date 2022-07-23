Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AAC957EFE6
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 16:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238419AbiGWO4P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 10:56:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237274AbiGWO4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 10:56:07 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C6D112A96;
        Sat, 23 Jul 2022 07:56:06 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id g1so8874374edb.12;
        Sat, 23 Jul 2022 07:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dCntW+N4qFqJP1njW6qSw/U6Vf1iTyFtCTiRKA2t2aE=;
        b=VyKK6R4d30UkLENldCcfiTaiaoYpWNZ5FFG+13E1fK6IQDtRYqmg2sMK3EWV9H50kS
         xq8wdS3t5hfLyosERiSyVEgM2HaM3eUnQ3IxNgU+D5gQvH1kgQbn7GLNR5KV7vkURUE4
         +3En4F3ek9/0aJVNn9gAnCUGfSQleYFs7mkXENfapOkA3k/6Ro8qO29zd8+82R/vGqvR
         sKWkQ3wwTYyqVa4bQgRkl4RmI7IOcOZnh1qlJm3E7IClIRFUjO4xJDvwhLfTxDJMiFiq
         edKO6LQxYm89cMhIxCpDrEXZB4PlEKpiu858K2+/e9zXrE6z5HTH30P4KEP7dCjZNY3H
         WZQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dCntW+N4qFqJP1njW6qSw/U6Vf1iTyFtCTiRKA2t2aE=;
        b=BiJD4HI/0IATb3eKhXJPzlhwk21enV26OA0v+h7gek6Uu7PTsXqgeRrDbHnQekYq3Q
         Q593FpwvLJXmK3smIh7f6iox8GDpYqAgS8xdIBI8LMuYCeqC6++g7uwLDt1VtCMwv7ll
         byhDZKmuLAiNPryB7UjodYlER72XxViQlHeqgpvs46adJ0OfX5G5k+3ao2gTU0bPA/mc
         b0qviTUM/TLHBqfMgB2j3AJTsB4+58VQdWslxn47vhQ1tC2dVWAZtpnqtEelKRHr62+P
         1f/9qf4/IVEzK6Aym6JTu8SUwBv5LiNQiVz2MQ6ZKshFU/YzjsQBlrIQUA/uuJRktbyO
         qqfg==
X-Gm-Message-State: AJIora9QIQnThEBIgQE15o1UfaYLPI1yCOk5apeCCWgVg9FIuvmvj3b1
        zaq8vNWW85eGMdEoyq0dfWE=
X-Google-Smtp-Source: AGRyM1tbbIAfKL2bPbXr8tRU/rHmChn91fpKl2CxQjsJf3FCTVGQyhYSKIvMsAcVWmdx8ta6EU9hSQ==
X-Received: by 2002:a05:6402:1c97:b0:43b:b984:f817 with SMTP id cy23-20020a0564021c9700b0043bb984f817mr4815344edb.196.1658588165647;
        Sat, 23 Jul 2022 07:56:05 -0700 (PDT)
Received: from localhost.localdomain (host-87-7-207-127.retail.telecomitalia.it. [87.7.207.127])
        by smtp.googlemail.com with ESMTPSA id cy24-20020a0564021c9800b0043ba1ecb0dfsm4143781edb.75.2022.07.23.07.56.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Jul 2022 07:56:05 -0700 (PDT)
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
Cc:     Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH v6 4/4] clk: qcom: lcc-ipq806x: use ARRAY_SIZE for num_parents
Date:   Sat, 23 Jul 2022 16:55:58 +0200
Message-Id: <20220723145558.25210-4-ansuelsmth@gmail.com>
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

Use ARRAY_SIZE for num_parents instead of raw number to prevent any
confusion/mistake.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/clk/qcom/lcc-ipq806x.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/qcom/lcc-ipq806x.c b/drivers/clk/qcom/lcc-ipq806x.c
index 1833e59a6434..81a44a9a9abc 100644
--- a/drivers/clk/qcom/lcc-ipq806x.c
+++ b/drivers/clk/qcom/lcc-ipq806x.c
@@ -134,7 +134,7 @@ static struct clk_rcg mi2s_osr_src = {
 		.hw.init = &(struct clk_init_data){
 			.name = "mi2s_osr_src",
 			.parent_data = lcc_pxo_pll4,
-			.num_parents = 2,
+			.num_parents = ARRAY_SIZE(lcc_pxo_pll4),
 			.ops = &clk_rcg_ops,
 			.flags = CLK_SET_RATE_GATE,
 		},
@@ -251,7 +251,7 @@ static struct clk_rcg pcm_src = {
 		.hw.init = &(struct clk_init_data){
 			.name = "pcm_src",
 			.parent_data = lcc_pxo_pll4,
-			.num_parents = 2,
+			.num_parents = ARRAY_SIZE(lcc_pxo_pll4),
 			.ops = &clk_rcg_ops,
 			.flags = CLK_SET_RATE_GATE,
 		},
@@ -335,7 +335,7 @@ static struct clk_rcg spdif_src = {
 		.hw.init = &(struct clk_init_data){
 			.name = "spdif_src",
 			.parent_data = lcc_pxo_pll4,
-			.num_parents = 2,
+			.num_parents = ARRAY_SIZE(lcc_pxo_pll4),
 			.ops = &clk_rcg_ops,
 			.flags = CLK_SET_RATE_GATE,
 		},
@@ -392,7 +392,7 @@ static struct clk_rcg ahbix_clk = {
 		.hw.init = &(struct clk_init_data){
 			.name = "ahbix",
 			.parent_data = lcc_pxo_pll4,
-			.num_parents = 2,
+			.num_parents = ARRAY_SIZE(lcc_pxo_pll4),
 			.ops = &clk_rcg_lcc_ops,
 		},
 	},
-- 
2.36.1

