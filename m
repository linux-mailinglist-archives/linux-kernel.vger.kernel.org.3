Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 196CE4E34E7
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 00:49:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233303AbiCUXrW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 19:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233288AbiCUXqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 19:46:50 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44F81985B7;
        Mon, 21 Mar 2022 16:45:23 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id t11so22783856wrm.5;
        Mon, 21 Mar 2022 16:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=YuacHx0JsXxYcT0I9GUMkZ9rOmfUJZlRqGllxjL2g6w=;
        b=osru7FFXR43epZK4c2QW3QaucXPFQ5eFB9J8cxEdjKErs+bVgDMp0luFxr5I0JIatT
         iu2Kj9az+J1MOvAcCa2CGyNdqU0ypWaIaFkMdHfqwbX/ZM9HqFfczrsABoU4auCCHAc0
         mwEekFfczOFFtOqG2fr+Zd1yVNAscjL0l8LeQO5dRVi2Uf+NtXDBsyB6N7Z31tX/hN0R
         SEQgP602r2zum/PW9geCPsbsorc72/oWJqVIgwZ0GIJZoUMq3YgiAcovOmU8wf/q14j9
         QQYUon7eDtebGhgpCqQhOkbzjQCYPKkS//TepvZm+FfO0sriwbhG6ldaQHGDnH9yLikB
         i72Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YuacHx0JsXxYcT0I9GUMkZ9rOmfUJZlRqGllxjL2g6w=;
        b=FFVPOfQZxTJnbuIoKlv9jPo/9hNoyWmRnKXZiV0EwBlrZrPVmj6AV8dVVrQ3uF79/h
         K1RCBE/Yo5fhlDCgYxPSAJhj9Az8zGGkaylpI+eAJ+JT9vs9HAKz1V3j0klPRqiwh0Rd
         AwTXWjGOLImyRE53+2g1j3mVB8jHUXymJPuH/SonJ9JvyXFdx/IyYzLYoA6NqyPKt7Ck
         4qc+hL7pBmVOOPCrpyrCoFGgNpGeZScT9+P5iB8FrZ6GXgwVkfoBg5TMfRAKGDzFTGyM
         iDMu5w6B+zXmUZsKMuloM7jQ6VKvwJTJLqWgne+3lTNabIzSaFzHvxQa08/njeZyMhqB
         hh0A==
X-Gm-Message-State: AOAM532RRh8R/uACuMj8/PjfCsLOGUDceJUaV3s7DDKaUftdI/YaYzww
        hB/SPFznTerPC8xUqEJaI2c=
X-Google-Smtp-Source: ABdhPJzHFtbV2R4F7mL5thcV/AiiTdas9T7vnBA0wMMKaPyuA22iynkUSHyS5hd1YA8o28g2wJR+Pw==
X-Received: by 2002:a05:6000:1ac7:b0:1f1:f9ee:7c57 with SMTP id i7-20020a0560001ac700b001f1f9ee7c57mr19420906wry.52.1647906321760;
        Mon, 21 Mar 2022 16:45:21 -0700 (PDT)
Received: from Ansuel-xps.localdomain (93-42-69-170.ip85.fastwebnet.it. [93.42.69.170])
        by smtp.googlemail.com with ESMTPSA id n10-20020a5d588a000000b002052e4aaf89sm105497wrf.80.2022.03.21.16.45.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 16:45:21 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH v6 09/18] clk: qcom: krait-cc: drop pr_info and register qsb only if needed
Date:   Tue, 22 Mar 2022 00:15:39 +0100
Message-Id: <20220321231548.14276-10-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220321231548.14276-1-ansuelsmth@gmail.com>
References: <20220321231548.14276-1-ansuelsmth@gmail.com>
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

