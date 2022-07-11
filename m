Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A377570043
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 13:22:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231192AbiGKLWx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 07:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230525AbiGKLWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 07:22:13 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F8BC296;
        Mon, 11 Jul 2022 03:47:27 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id v16so6413262wrd.13;
        Mon, 11 Jul 2022 03:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UP31sMO9ev0YI1wu9H4pD9/GKwcBABggRKQQahs3BhI=;
        b=DoWFecGol1OUhOEfouROsGiN2gcYd41iWsx0RHh5C9D4L7hMKk9bztfyX2fGRflx2r
         t9Xrr3Q7AnnK2PbOD4QMmxz8dVM3pS66gGlpUoBPDFyiYry0Y9z/oidKkpL2prNsyflU
         MUZRZJeiyrxEvNMY8CiASaqu9svlbECeJC0QVaE/vknjzTmf4cZgE7uv3KLGzLManUkv
         GxM77gS/py2ZNtiF1/xBD18Tv0lZrP0NaR1XgQ2Hd3aswDIEsgRb9LDUG1YUiM/ejyCM
         ug1m05uOl9Vsw0lx3HiTjU0RuSqbXFYUdu1yC8hwCrx5t+kptUtZKPcJWQ9rJCSI/kVQ
         cVkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UP31sMO9ev0YI1wu9H4pD9/GKwcBABggRKQQahs3BhI=;
        b=r+llqCUniD9CdRR/NMwCvFxbb1djjBegKlOYhAgoLtkmuBOwcAvwchK1RIzc08N853
         WpXLshnWYMujv499QI+f5TU7YYJn1fNQQjJqgUZ1wG6Y3RH6/wO+OLq8mbgqHeqjr4a7
         6xNZ7Pf9Wtav8IC0qwb6ab6sU0xUKIbHm+RxwmH0PIOT8Bnfq68qMMOzupXclNViTiSt
         RpdHYcTxQSxU4501EK5Bcuqpr3IPzb0LHBjG0iEwRnUbP8Rm8cWDZ3PXRshu4TUnaEy9
         u4C2oHH+71JHa8IQbT5YYZMmfdHYbz4BoqyIcISlXFLwgQU8Q6ZvOxYfQ9P0aL2IAoAR
         jNUA==
X-Gm-Message-State: AJIora+3v2bhkAa5wVwxju9q7Sk3Q5jXD1ZAuZNCzWObaUngv/K8fNBs
        pBQ09iNInLmnDKNEbgDM/Ws=
X-Google-Smtp-Source: AGRyM1vQHPKrDAjCiX+pf+69oiSKb4f4bNkB/VrKO0yLsbXfEAeX6V09s9j0r+8M0+ZpqGwBc3fnrQ==
X-Received: by 2002:a5d:64a3:0:b0:21d:ad9e:afd7 with SMTP id m3-20020a5d64a3000000b0021dad9eafd7mr20320wrp.524.1657536445957;
        Mon, 11 Jul 2022 03:47:25 -0700 (PDT)
Received: from fedora.robimarko.hr (cpezg-94-253-144-242-cbl.xnet.hr. [94.253.144.242])
        by smtp.googlemail.com with ESMTPSA id n3-20020a7bcbc3000000b003a05621dc53sm6338716wmi.29.2022.07.11.03.47.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 03:47:25 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     bjorn.andersson@linaro.org, agross@kernel.org,
        konrad.dybcio@somainline.org, mturquette@baylibre.com,
        sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, sivaprak@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH 2/6] clk: qcom: apss-ipq6018: fix apcs_alias0_clk_src
Date:   Mon, 11 Jul 2022 12:47:15 +0200
Message-Id: <20220711104719.40939-2-robimarko@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220711104719.40939-1-robimarko@gmail.com>
References: <20220711104719.40939-1-robimarko@gmail.com>
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

While working on IPQ8074 APSS driver it was discovered that IPQ6018 and
IPQ8074 use almost the same PLL and APSS clocks, however APSS driver is
currently broken.

More precisely apcs_alias0_clk_src is broken, it was added as regmap_mux
clock.
However after debugging why it was always stuck at 800Mhz, it was figured
out that its not regmap_mux compatible at all.
It is a simple mux but it uses RCG2 register layout and control bits, so
utilize the new clk_rcg2_mux_closest_ops to correctly drive it while not
having to provide a dummy frequency table.

While we are here, use ARRAY_SIZE for number of parents.

Tested on IPQ6018-CP01-C1 reference board and multiple IPQ8074 boards.

Fixes: 5e77b4ef1b19 ("clk: qcom: Add ipq6018 apss clock controller")
Signed-off-by: Robert Marko <robimarko@gmail.com>
---
 drivers/clk/qcom/apss-ipq6018.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/qcom/apss-ipq6018.c b/drivers/clk/qcom/apss-ipq6018.c
index d78ff2f310bf..be952d417ded 100644
--- a/drivers/clk/qcom/apss-ipq6018.c
+++ b/drivers/clk/qcom/apss-ipq6018.c
@@ -16,7 +16,7 @@
 #include "clk-regmap.h"
 #include "clk-branch.h"
 #include "clk-alpha-pll.h"
-#include "clk-regmap-mux.h"
+#include "clk-rcg.h"
 
 enum {
 	P_XO,
@@ -33,16 +33,15 @@ static const struct parent_map parents_apcs_alias0_clk_src_map[] = {
 	{ P_APSS_PLL_EARLY, 5 },
 };
 
-static struct clk_regmap_mux apcs_alias0_clk_src = {
-	.reg = 0x0050,
-	.width = 3,
-	.shift = 7,
+static struct clk_rcg2 apcs_alias0_clk_src = {
+	.cmd_rcgr = 0x0050,
+	.hid_width = 5,
 	.parent_map = parents_apcs_alias0_clk_src_map,
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "apcs_alias0_clk_src",
 		.parent_data = parents_apcs_alias0_clk_src,
-		.num_parents = 2,
-		.ops = &clk_regmap_mux_closest_ops,
+		.num_parents = ARRAY_SIZE(parents_apcs_alias0_clk_src),
+		.ops = &clk_rcg2_mux_closest_ops,
 		.flags = CLK_SET_RATE_PARENT,
 	},
 };
-- 
2.36.1

