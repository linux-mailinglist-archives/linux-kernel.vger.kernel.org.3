Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A9CA4D77C7
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 20:05:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235432AbiCMTGs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 15:06:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235374AbiCMTG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 15:06:28 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12A144F44E;
        Sun, 13 Mar 2022 12:05:13 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id p15so29580737ejc.7;
        Sun, 13 Mar 2022 12:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=IoxWFtuJ3nVT2cUX5svXBvONnaH4G2IpueNu8SNnBC4=;
        b=BiGAZe1hOHEPX7XfUXG/4DfXbS6Vuc5pOYn44VqxH2XJ2oebLgFR94zL+DOduoe2Ez
         YuJ9cKgvLoEJX9q533WT8PdFQpyuKzoD87zcKT2EGjl4X/C9UpWS81dn3BsRSPou9Jsf
         W94IKo+IIr9Hg6HQiHD8xtmMZ+GQJPCmTat2TISajd+2pZ+DzcC7Tm1DWZNlZeoQXzt9
         /qBfW1/vX2LumyjVLSCIblTGUjneMmRmMKLOfI2ZOI8PtP6GlI/oZkGswcr1be8y1Rdr
         ERuj5MHR3J3juNUFrrIJWB2ISIJh9PKdejtlAKuIW4eKTsDk/cFh8PbAcT87tFB6xb7g
         nuEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IoxWFtuJ3nVT2cUX5svXBvONnaH4G2IpueNu8SNnBC4=;
        b=ar5lwzwK4qKfO1V8L8g4mr1YYrrZYKLi82QCnYs/4ADULjgs6yk9r+adlySCp6gtle
         ZabOmYuk+DVr+J4ETPm9MR74WGsJGwEYAyeM42DvzZO4KRCvY10Ne9qWDnx8mBYLnJPZ
         yzqMnHw+CWRtL4FkgmDppUrytq6ywaNEhd6ofQQYh3fdzu2SM6MXaVMaQiUSZ8ZbbNQl
         5QNPCJ8JDYfeBHAtZCvj8byWFDGbL689tz5Lb1iPRSVrxdSYZrISAaGlUUwNUKjx9GDj
         +ZNJ3/OFP6Tmi/+SrcnPNSprIkDhpivnlAMtUL3gwga/ZZUy4kIDpfNOfpnWxEAJHdmF
         rS3Q==
X-Gm-Message-State: AOAM531uNzQYO9RyNVDCVQKnV1GN4F/x8afZPns0NgHsZvUs/CiI0KEk
        vFEnkN7CryxBRg0pidToeC0=
X-Google-Smtp-Source: ABdhPJzTYcC1+jpKFWl/CYsAgivivxMFORCMPruEdwREu/30BE2L/JwIHpvDUPpSjQkQ/gLcGdrxyw==
X-Received: by 2002:a17:907:7d8a:b0:6db:3261:d8de with SMTP id oz10-20020a1709077d8a00b006db3261d8demr17156424ejc.239.1647198311397;
        Sun, 13 Mar 2022 12:05:11 -0700 (PDT)
Received: from Ansuel-xps.localdomain (93-42-71-246.ip85.fastwebnet.it. [93.42.71.246])
        by smtp.googlemail.com with ESMTPSA id n13-20020a170906724d00b006cedd6d7e24sm5856697ejk.119.2022.03.13.12.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Mar 2022 12:05:11 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: [PATCH 09/16] clk: qcom: krait-cc: drop pr_info and register qsb only if needed
Date:   Sun, 13 Mar 2022 20:04:12 +0100
Message-Id: <20220313190419.2207-10-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220313190419.2207-1-ansuelsmth@gmail.com>
References: <20220313190419.2207-1-ansuelsmth@gmail.com>
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

Drop pr_info and change them to dev_info.
Register qsb fixed clk only if it's not declared in DTS.
Also reorganize variable order.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 drivers/clk/qcom/krait-cc.c | 42 +++++++++++++++++++------------------
 1 file changed, 22 insertions(+), 20 deletions(-)

diff --git a/drivers/clk/qcom/krait-cc.c b/drivers/clk/qcom/krait-cc.c
index 645ad9e8dd73..50352ff0ac67 100644
--- a/drivers/clk/qcom/krait-cc.c
+++ b/drivers/clk/qcom/krait-cc.c
@@ -34,9 +34,10 @@ static int krait_notifier_cb(struct notifier_block *nb,
 			     unsigned long event,
 			     void *data)
 {
-	int ret = 0;
 	struct krait_mux_clk *mux = container_of(nb, struct krait_mux_clk,
 						 clk_nb);
+	int ret = 0;
+
 	/* Switch to safe parent */
 	if (event == PRE_RATE_CHANGE) {
 		mux->old_index = krait_mux_clk_ops.get_parent(&mux->hw);
@@ -59,7 +60,7 @@ static int krait_notifier_cb(struct notifier_block *nb,
 static int krait_notifier_register(struct device *dev, struct clk *clk,
 				   struct krait_mux_clk *mux)
 {
-	int ret = 0;
+	int ret;
 
 	mux->clk_nb.notifier_call = krait_notifier_cb;
 	ret = clk_notifier_register(clk, &mux->clk_nb);
@@ -72,15 +73,15 @@ static int krait_notifier_register(struct device *dev, struct clk *clk,
 static struct clk *
 krait_add_div(struct device *dev, int id, const char *s, unsigned int offset)
 {
-	struct krait_div2_clk *div;
 	static struct clk_parent_data p_data[1];
 	struct clk_init_data init = {
 		.num_parents = ARRAY_SIZE(p_data),
 		.ops = &krait_div2_clk_ops,
 		.flags = CLK_SET_RATE_PARENT,
 	};
-	struct clk *clk;
+	struct krait_div2_clk *div;
 	char *parent_name;
+	struct clk *clk;
 
 	div = devm_kzalloc(dev, sizeof(*div), GFP_KERNEL);
 	if (!div)
@@ -119,8 +120,6 @@ static struct clk *
 krait_add_sec_mux(struct device *dev, int id, const char *s,
 		  unsigned int offset, bool unique_aux)
 {
-	int ret;
-	struct krait_mux_clk *mux;
 	static struct clk_parent_data sec_mux_list[2] = {
 		{ .name = "qsb", .fw_name = "qsb" },
 		{},
@@ -131,8 +130,10 @@ krait_add_sec_mux(struct device *dev, int id, const char *s,
 		.ops = &krait_mux_clk_ops,
 		.flags = CLK_SET_RATE_PARENT,
 	};
-	struct clk *clk;
+	struct krait_mux_clk *mux;
 	char *parent_name;
+	struct clk *clk;
+	int ret;
 
 	mux = devm_kzalloc(dev, sizeof(*mux), GFP_KERNEL);
 	if (!mux)
@@ -182,8 +183,6 @@ static struct clk *
 krait_add_pri_mux(struct device *dev, struct clk *hfpll_div, struct clk *sec_mux,
 		  int id, const char *s, unsigned int offset)
 {
-	int ret;
-	struct krait_mux_clk *mux;
 	static struct clk_parent_data p_data[3];
 	struct clk_init_data init = {
 		.parent_data = p_data,
@@ -191,8 +190,10 @@ krait_add_pri_mux(struct device *dev, struct clk *hfpll_div, struct clk *sec_mux
 		.ops = &krait_mux_clk_ops,
 		.flags = CLK_SET_RATE_PARENT,
 	};
-	struct clk *clk;
+	struct krait_mux_clk *mux;
 	char *hfpll_name;
+	struct clk *clk;
+	int ret;
 
 	mux = devm_kzalloc(dev, sizeof(*mux), GFP_KERNEL);
 	if (!mux)
@@ -240,10 +241,10 @@ krait_add_pri_mux(struct device *dev, struct clk *hfpll_div, struct clk *sec_mux
 /* id < 0 for L2, otherwise id == physical CPU number */
 static struct clk *krait_add_clks(struct device *dev, int id, bool unique_aux)
 {
+	struct clk *hfpll_div, *sec_mux, *clk;
 	unsigned int offset;
 	void *p = NULL;
 	const char *s;
-	struct clk *hfpll_div, *sec_mux, *clk;
 
 	if (id >= 0) {
 		offset = 0x4501 + (0x1000 * id);
@@ -295,20 +296,21 @@ MODULE_DEVICE_TABLE(of, krait_cc_match_table);
 
 static int krait_cc_probe(struct platform_device *pdev)
 {
+	unsigned long cur_rate, aux_rate;
+	struct clk *l2_pri_mux_clk, *clk;
 	struct device *dev = &pdev->dev;
 	const struct of_device_id *id;
-	unsigned long cur_rate, aux_rate;
-	int cpu;
-	struct clk *clk;
 	struct clk **clks;
-	struct clk *l2_pri_mux_clk;
+	int cpu;
 
 	id = of_match_device(krait_cc_match_table, dev);
 	if (!id)
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

