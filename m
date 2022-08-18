Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27532599013
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 00:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344953AbiHRWGh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 18:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239768AbiHRWGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 18:06:34 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 587FCD21FD;
        Thu, 18 Aug 2022 15:06:33 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id t5so3525900edc.11;
        Thu, 18 Aug 2022 15:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=G2AMVsOrIUOLF7qOXeTIv39jlg5CAbzNTt2ny2QTgn4=;
        b=TxXiPRhsg+uZrhV4DrN+n8u/s0qBbirzhKotirjIiSAQ5s5Imopy5k0PaAY9sy+KNT
         GAY4uuZrsEqfNgBFZq6LH4uJrNW+WpkuhuyPXqXTMXpSaVjv9KqXK0/DrYctXLwHOryT
         UOjwGWTGtsElS6VDkq0oe2VV3NPWTrz9+RCoR/zD3dhQQzWdHP3cCA54tAc8xmxmwzZ4
         ff3whgF/Iz8p3PNomMO54Dwv7YXO0VHnuINyAqiCbZXBdW+Nw83hR2Ac9dK1oiMa7PxV
         esw679Y8Px8Cl3zTP3O0VTjBz4q5IOxOUygZcUa/UhU89vQD5+0jNLBeiQjVkzf+V4iK
         r/Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=G2AMVsOrIUOLF7qOXeTIv39jlg5CAbzNTt2ny2QTgn4=;
        b=A/S3u0o78lLrf2YZm+coKLLIHmAqtrxNNK66ZpEimm5tc0szNLzixZv10+4Cwf5xy5
         od4lAKUMtQMkTfJXjW3seP7l/gIdEw/nIjxg9KQNZXu7efkBKWFhAlmcuIpGJHva+xU2
         aXxmvQOst2Vmsk9g0tY0a2RFjT4MO7lYoPX2TBGP9kaczv8Q+oMERvGpHcjMBvVo/Ed6
         TnwNT1Wnv30ne4kiz560NNBew32qiYhPoU3I9/vigSmRSNk55KiLTGZBjNb8I6GpW6dK
         IDsKfCqQ3gTRtUsxlECisy/mdRXPdfSQVUJQssTPhIO8kBEkCo4HWjK2KxN1Et8YzHHQ
         EN+Q==
X-Gm-Message-State: ACgBeo3fYERqa/m+kHcvjOFEN1E3NIg+MLCslnYFwim2Zwy8wVinVQRA
        ooMmm4k0fZxRcFJ2nQTvBnF5YyyXTRY=
X-Google-Smtp-Source: AA6agR7MLYAGrhAAe5zzSzARCBj2p8fb63sVh+4ikZ0b8qjDY0GDsMle/rmdFYj4rhi65iqOsJMQtA==
X-Received: by 2002:a05:6402:e86:b0:440:d1be:20c7 with SMTP id h6-20020a0564020e8600b00440d1be20c7mr3732546eda.349.1660860391880;
        Thu, 18 Aug 2022 15:06:31 -0700 (PDT)
Received: from fedora.robimarko.hr (cpe-94-253-165-74.zg.cable.xnet.hr. [94.253.165.74])
        by smtp.googlemail.com with ESMTPSA id dk5-20020a0564021d8500b00442d5054a51sm1851584edb.87.2022.08.18.15.06.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 15:06:31 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        konrad.dybcio@somainline.org, mturquette@baylibre.com,
        sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, sivaprak@codeaurora.org,
        dmitry.baryshkov@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH v3 2/9] clk: qcom: apss-ipq6018: fix apcs_alias0_clk_src
Date:   Fri, 19 Aug 2022 00:06:21 +0200
Message-Id: <20220818220628.339366-2-robimarko@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220818220628.339366-1-robimarko@gmail.com>
References: <20220818220628.339366-1-robimarko@gmail.com>
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
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
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
2.37.2

