Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5943D4E2BF3
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 16:19:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350136AbiCUPUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 11:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349965AbiCUPTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 11:19:22 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CAEA2636;
        Mon, 21 Mar 2022 08:17:56 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id v2-20020a7bcb42000000b0037b9d960079so10554567wmj.0;
        Mon, 21 Mar 2022 08:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=YuacHx0JsXxYcT0I9GUMkZ9rOmfUJZlRqGllxjL2g6w=;
        b=kDH4ohLxIr9oQWBuC02rB34PDBWIg8ZUVISPJlaoY2usdDQfuV8PNVkQyotSgPgUGs
         kYhMm+cP9sF8J/vYqGmgFC9Y4xJbbXgVzhqWgFCRYPwEd7yaz0rwsFSr741/bTcq4IAr
         5ZjEa2iXutCTMX6zuxK89N0Okgw7EFigIzwyEh3I3YPpoo4OeKNgs4cJ8+vcOUlORIIx
         b++a7roZU4n7574D5nBYoHiQXTD/T7vC5XZRMGoCsSVa6sfej99s2WKLBchd39gRSZf7
         1Zpei0U7kQu9m3kMxLiGe0PFWp3MPTf1NZhDuTJdqSRSESWgVbh9Yn2zjq9qf4Jbr+yr
         TGZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YuacHx0JsXxYcT0I9GUMkZ9rOmfUJZlRqGllxjL2g6w=;
        b=g9i3+uAqTn7a0CtBTflNtiuL01pt0TURJ3uw+htCtl3orFbnNcsjW52Sj01I7cjOqx
         A7sDoOVdwdK/GmG51L77kmL5f8rNXzwcuifoNfjMKOXuPCPC5P/wLuuzn8owMmN/pOLC
         x3N4gf1g8vUPZCcyBaOjXtEPttdqFJWWcOU65S6fXP4TQxaNLrv+qaFs1jX8remNobLa
         28JA1LZOT5DQs1hh4U+jYTxpr+ghI08DTPg/7jtueZjimAK9YeFC5dcZkCkO5z4sSUzl
         zk3q3lhzaJDsYvo7E0GkL2Tj2rBMdEMNyKZ3O/hYgnVHf6sygNuinI7Fl0DfBoydmTaV
         eExQ==
X-Gm-Message-State: AOAM532ZUAgTcxQqGAu9IDFzboKKrCAtVTeFFbCVtTYNvV+ptDs7rzW2
        /Zy0SkcgpDlGiJx0TfTGZiM=
X-Google-Smtp-Source: ABdhPJxGzbtPuL03UvM8JYpUnesIsNna4S9XFHtUqyw7k6xudwVxpEEyBEJI/ir6mORh032gHWPI3A==
X-Received: by 2002:a05:600c:35d4:b0:38c:9933:41c0 with SMTP id r20-20020a05600c35d400b0038c993341c0mr9303352wmq.149.1647875874957;
        Mon, 21 Mar 2022 08:17:54 -0700 (PDT)
Received: from Ansuel-xps.localdomain (93-42-69-170.ip85.fastwebnet.it. [93.42.69.170])
        by smtp.googlemail.com with ESMTPSA id 10-20020a5d47aa000000b00204012e4373sm7239729wrb.101.2022.03.21.08.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 08:17:54 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH v4 09/18] clk: qcom: krait-cc: drop pr_info and register qsb only if needed
Date:   Mon, 21 Mar 2022 15:48:16 +0100
Message-Id: <20220321144825.11736-10-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220321144825.11736-1-ansuelsmth@gmail.com>
References: <20220321144825.11736-1-ansuelsmth@gmail.com>
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

Replace pr_info() with dev_info() to provide better diagnostics.
Register qsb fixed clk only if it's not declared in DTS.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 drivers/clk/qcom/krait-cc.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/qcom/krait-cc.c b/drivers/clk/qcom/krait-cc.c
index 645ad9e8dd73..e9508e3104ea 100644
--- a/drivers/clk/qcom/krait-cc.c
+++ b/drivers/clk/qcom/krait-cc.c
@@ -308,7 +308,9 @@ static int krait_cc_probe(struct platform_device *pdev)
 		return -ENODEV;
 
 	/* Rate is 1 because 0 causes problems for __clk_mux_determine_rate */
-	clk = clk_register_fixed_rate(dev, "qsb", NULL, 0, 1);
+	if (IS_ERR(clk_get(dev, "qsb")))
+		clk = clk_register_fixed_rate(dev, "qsb", NULL, 0, 1);
+
 	if (IS_ERR(clk))
 		return PTR_ERR(clk);
 
@@ -363,25 +365,25 @@ static int krait_cc_probe(struct platform_device *pdev)
 	cur_rate = clk_get_rate(l2_pri_mux_clk);
 	aux_rate = 384000000;
 	if (cur_rate == 1) {
-		pr_info("L2 @ QSB rate. Forcing new rate.\n");
+		dev_info(dev, "L2 @ QSB rate. Forcing new rate.\n");
 		cur_rate = aux_rate;
 	}
 	clk_set_rate(l2_pri_mux_clk, aux_rate);
 	clk_set_rate(l2_pri_mux_clk, 2);
 	clk_set_rate(l2_pri_mux_clk, cur_rate);
-	pr_info("L2 @ %lu KHz\n", clk_get_rate(l2_pri_mux_clk) / 1000);
+	dev_info(dev, "L2 @ %lu KHz\n", clk_get_rate(l2_pri_mux_clk) / 1000);
 	for_each_possible_cpu(cpu) {
 		clk = clks[cpu];
 		cur_rate = clk_get_rate(clk);
 		if (cur_rate == 1) {
-			pr_info("CPU%d @ QSB rate. Forcing new rate.\n", cpu);
+			dev_info(dev, "CPU%d @ QSB rate. Forcing new rate.\n", cpu);
 			cur_rate = aux_rate;
 		}
 
 		clk_set_rate(clk, aux_rate);
 		clk_set_rate(clk, 2);
 		clk_set_rate(clk, cur_rate);
-		pr_info("CPU%d @ %lu KHz\n", cpu, clk_get_rate(clk) / 1000);
+		dev_info(dev, "CPU%d @ %lu KHz\n", cpu, clk_get_rate(clk) / 1000);
 	}
 
 	of_clk_add_provider(dev->of_node, krait_of_get, clks);
-- 
2.34.1

