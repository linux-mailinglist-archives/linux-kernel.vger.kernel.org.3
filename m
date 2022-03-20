Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 167C84E1CCC
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 17:28:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245578AbiCTQaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 12:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245490AbiCTQ3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 12:29:45 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FECC344DC;
        Sun, 20 Mar 2022 09:28:21 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id h23so17241625wrb.8;
        Sun, 20 Mar 2022 09:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=1tacB+H58ZcVKBVcWE3u+TMM2y65iIDEoWk8hI94hWs=;
        b=AoJChIRauwDPPpAs6BiYi9HrDAQ2laxo9Eb3ZRwqREkTz5ve1GJkKXg22/V/FVnu+4
         yww94l2l7NSUS2FKRaFvQLvzN+T1Hedi7gkxwZE6k3saj4dDyieHQgF5Rsl4f/ZVCJes
         3xXJHCSDQrF4owvkF/PPDjyQNwbRkMia3diLAKXI6OfgAiRTxiZ5KttN6+2jKNuCHTnW
         Iv/jomO74aw7OEPAiOqEkcx2WffHU5Uw2FwN5DKxWb6a+MWmFWO8OIZew7O0L7CNA8MA
         E8UXqS6pubEtsiAOTmF3mxZhsx/PncrWvuacjqxqBuCjurFKqcgtFSdKdhgZP8qg/93x
         8bQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1tacB+H58ZcVKBVcWE3u+TMM2y65iIDEoWk8hI94hWs=;
        b=r7+mOkEvhCnnnh1Pb4l1BHZUcPUy0dMkXAYBSuR6/PjfMbCNEBR+D+34r36UDHpahX
         WU8RGbqfPh0Y2hHj6wMcNbaOoWqLtAGJLezAy1l8XtcQESAXVv9vjaGMtkIuhxIAEuXT
         nOcPKpBPmFHxtq84ep0q/QyXRxWcBI/Dwcpix4mxT9XH2CFRP8tbemQbklmSIqSCSiV/
         QnrcftLd9DEsPqQCc+6b7jQ3mrbQKvwtZXF/RTt5uQZJ0yKuQBUZGlCWhP7Vzw2QcmJ6
         cZzBFcF3pc4pecfbE6kLe6mdGxK4BJ+UGFdzcgYwqU/MuumraqIEsjFedWDMQ6fHO5Qz
         8JQw==
X-Gm-Message-State: AOAM5338aBeuBtnLeD9EmgaJoC93z0hLnqbhOj3xjC8KwZwsY9Ceb8Hs
        OKpqZAT3LNFEvx4EhtZs0RM=
X-Google-Smtp-Source: ABdhPJyXnW1/YJCbKhn+tUEsw5gMm2PXKKFkecZeM9xTxn+kIAu2b2zkJ1X2aN49tKfwqoLhH6WKRw==
X-Received: by 2002:a05:6000:18ae:b0:204:62a:20f4 with SMTP id b14-20020a05600018ae00b00204062a20f4mr4477530wri.640.1647793699956;
        Sun, 20 Mar 2022 09:28:19 -0700 (PDT)
Received: from Ansuel-xps.localdomain (93-42-69-170.ip85.fastwebnet.it. [93.42.69.170])
        by smtp.googlemail.com with ESMTPSA id y6-20020a05600015c600b00203fa70b4ebsm6760085wry.53.2022.03.20.09.28.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Mar 2022 09:28:19 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH v3 08/18] clk: qcom: krait-cc: convert to parent_data API
Date:   Sun, 20 Mar 2022 12:34:20 +0100
Message-Id: <20220320113430.26076-9-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220320113430.26076-1-ansuelsmth@gmail.com>
References: <20220320113430.26076-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modernize the krait-cc driver to parent-data API and refactor to drop
any use of clk_names. From Documentation all the required clocks should
be declared in DTS so fw_name can be correctly used to get the parents
for all the muxes. Name is also declared to save compatibility with old
implementation. Also fix the parent order of the sec_mux that was wrong
and incorrectly report the wrong safe parent if it's not hardcoded.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 drivers/clk/qcom/krait-cc.c | 126 +++++++++++++++++++-----------------
 1 file changed, 66 insertions(+), 60 deletions(-)

diff --git a/drivers/clk/qcom/krait-cc.c b/drivers/clk/qcom/krait-cc.c
index 4d4b657d33c3..645ad9e8dd73 100644
--- a/drivers/clk/qcom/krait-cc.c
+++ b/drivers/clk/qcom/krait-cc.c
@@ -69,21 +69,22 @@ static int krait_notifier_register(struct device *dev, struct clk *clk,
 	return ret;
 }
 
-static int
+static struct clk *
 krait_add_div(struct device *dev, int id, const char *s, unsigned int offset)
 {
 	struct krait_div2_clk *div;
+	static struct clk_parent_data p_data[1];
 	struct clk_init_data init = {
-		.num_parents = 1,
+		.num_parents = ARRAY_SIZE(p_data),
 		.ops = &krait_div2_clk_ops,
 		.flags = CLK_SET_RATE_PARENT,
 	};
-	const char *p_names[1];
 	struct clk *clk;
+	char *parent_name;
 
 	div = devm_kzalloc(dev, sizeof(*div), GFP_KERNEL);
 	if (!div)
-		return -ENOMEM;
+		return ERR_PTR(-ENOMEM);
 
 	div->width = 2;
 	div->shift = 6;
@@ -93,43 +94,49 @@ krait_add_div(struct device *dev, int id, const char *s, unsigned int offset)
 
 	init.name = kasprintf(GFP_KERNEL, "hfpll%s_div", s);
 	if (!init.name)
-		return -ENOMEM;
+		return ERR_PTR(-ENOMEM);
 
-	init.parent_names = p_names;
-	p_names[0] = kasprintf(GFP_KERNEL, "hfpll%s", s);
-	if (!p_names[0]) {
-		kfree(init.name);
-		return -ENOMEM;
+	init.parent_data = p_data;
+	parent_name = kasprintf(GFP_KERNEL, "hfpll%s", s);
+	if (!parent_name) {
+		clk = ERR_PTR(-ENOMEM);
+		goto err_parent_name;
 	}
 
+	p_data[0].fw_name = parent_name;
+	p_data[0].name = parent_name;
+
 	clk = devm_clk_register(dev, &div->hw);
-	kfree(p_names[0]);
+
+	kfree(parent_name);
+err_parent_name:
 	kfree(init.name);
 
-	return PTR_ERR_OR_ZERO(clk);
+	return clk;
 }
 
-static int
+static struct clk *
 krait_add_sec_mux(struct device *dev, int id, const char *s,
 		  unsigned int offset, bool unique_aux)
 {
 	int ret;
 	struct krait_mux_clk *mux;
-	static const char *sec_mux_list[] = {
-		"acpu_aux",
-		"qsb",
+	static struct clk_parent_data sec_mux_list[2] = {
+		{ .name = "qsb", .fw_name = "qsb" },
+		{},
 	};
 	struct clk_init_data init = {
-		.parent_names = sec_mux_list,
+		.parent_data = sec_mux_list,
 		.num_parents = ARRAY_SIZE(sec_mux_list),
 		.ops = &krait_mux_clk_ops,
 		.flags = CLK_SET_RATE_PARENT,
 	};
 	struct clk *clk;
+	char *parent_name;
 
 	mux = devm_kzalloc(dev, sizeof(*mux), GFP_KERNEL);
 	if (!mux)
-		return -ENOMEM;
+		return ERR_PTR(-ENOMEM);
 
 	mux->offset = offset;
 	mux->lpl = id >= 0;
@@ -141,44 +148,51 @@ krait_add_sec_mux(struct device *dev, int id, const char *s,
 
 	init.name = kasprintf(GFP_KERNEL, "krait%s_sec_mux", s);
 	if (!init.name)
-		return -ENOMEM;
+		return ERR_PTR(-ENOMEM);
 
 	if (unique_aux) {
-		sec_mux_list[0] = kasprintf(GFP_KERNEL, "acpu%s_aux", s);
-		if (!sec_mux_list[0]) {
+		parent_name = kasprintf(GFP_KERNEL, "acpu%s_aux", s);
+		if (!parent_name) {
 			clk = ERR_PTR(-ENOMEM);
 			goto err_aux;
 		}
+		sec_mux_list[1].fw_name = parent_name;
+		sec_mux_list[1].name = parent_name;
+	} else {
+		sec_mux_list[1].name = "apu_aux";
 	}
 
 	clk = devm_clk_register(dev, &mux->hw);
+	if (IS_ERR(clk))
+		goto err_clk;
 
 	ret = krait_notifier_register(dev, clk, mux);
 	if (ret)
-		goto unique_aux;
+		clk = ERR_PTR(ret);
 
-unique_aux:
+err_clk:
 	if (unique_aux)
-		kfree(sec_mux_list[0]);
+		kfree(parent_name);
 err_aux:
 	kfree(init.name);
-	return PTR_ERR_OR_ZERO(clk);
+	return clk;
 }
 
 static struct clk *
-krait_add_pri_mux(struct device *dev, int id, const char *s,
-		  unsigned int offset)
+krait_add_pri_mux(struct device *dev, struct clk *hfpll_div, struct clk *sec_mux,
+		  int id, const char *s, unsigned int offset)
 {
 	int ret;
 	struct krait_mux_clk *mux;
-	const char *p_names[3];
+	static struct clk_parent_data p_data[3];
 	struct clk_init_data init = {
-		.parent_names = p_names,
-		.num_parents = ARRAY_SIZE(p_names),
+		.parent_data = p_data,
+		.num_parents = ARRAY_SIZE(p_data),
 		.ops = &krait_mux_clk_ops,
 		.flags = CLK_SET_RATE_PARENT,
 	};
 	struct clk *clk;
+	char *hfpll_name;
 
 	mux = devm_kzalloc(dev, sizeof(*mux), GFP_KERNEL);
 	if (!mux)
@@ -196,36 +210,29 @@ krait_add_pri_mux(struct device *dev, int id, const char *s,
 	if (!init.name)
 		return ERR_PTR(-ENOMEM);
 
-	p_names[0] = kasprintf(GFP_KERNEL, "hfpll%s", s);
-	if (!p_names[0]) {
+	hfpll_name = kasprintf(GFP_KERNEL, "hfpll%s", s);
+	if (!hfpll_name) {
 		clk = ERR_PTR(-ENOMEM);
-		goto err_p0;
+		goto err_hfpll;
 	}
 
-	p_names[1] = kasprintf(GFP_KERNEL, "hfpll%s_div", s);
-	if (!p_names[1]) {
-		clk = ERR_PTR(-ENOMEM);
-		goto err_p1;
-	}
+	p_data[0].fw_name = hfpll_name;
+	p_data[0].name = hfpll_name;
 
-	p_names[2] = kasprintf(GFP_KERNEL, "krait%s_sec_mux", s);
-	if (!p_names[2]) {
-		clk = ERR_PTR(-ENOMEM);
-		goto err_p2;
-	}
+	p_data[1].hw = __clk_get_hw(hfpll_div);
+	p_data[2].hw = __clk_get_hw(sec_mux);
 
 	clk = devm_clk_register(dev, &mux->hw);
+	if (IS_ERR(clk))
+		goto err_clk;
 
 	ret = krait_notifier_register(dev, clk, mux);
 	if (ret)
-		goto err_p3;
-err_p3:
-	kfree(p_names[2]);
-err_p2:
-	kfree(p_names[1]);
-err_p1:
-	kfree(p_names[0]);
-err_p0:
+		clk = ERR_PTR(ret);
+
+err_clk:
+	kfree(hfpll_name);
+err_hfpll:
 	kfree(init.name);
 	return clk;
 }
@@ -233,11 +240,10 @@ krait_add_pri_mux(struct device *dev, int id, const char *s,
 /* id < 0 for L2, otherwise id == physical CPU number */
 static struct clk *krait_add_clks(struct device *dev, int id, bool unique_aux)
 {
-	int ret;
 	unsigned int offset;
 	void *p = NULL;
 	const char *s;
-	struct clk *clk;
+	struct clk *hfpll_div, *sec_mux, *clk;
 
 	if (id >= 0) {
 		offset = 0x4501 + (0x1000 * id);
@@ -249,19 +255,19 @@ static struct clk *krait_add_clks(struct device *dev, int id, bool unique_aux)
 		s = "_l2";
 	}
 
-	ret = krait_add_div(dev, id, s, offset);
-	if (ret) {
-		clk = ERR_PTR(ret);
+	hfpll_div = krait_add_div(dev, id, s, offset);
+	if (IS_ERR(hfpll_div)) {
+		clk = hfpll_div;
 		goto err;
 	}
 
-	ret = krait_add_sec_mux(dev, id, s, offset, unique_aux);
-	if (ret) {
-		clk = ERR_PTR(ret);
+	sec_mux = krait_add_sec_mux(dev, id, s, offset, unique_aux);
+	if (IS_ERR(sec_mux)) {
+		clk = sec_mux;
 		goto err;
 	}
 
-	clk = krait_add_pri_mux(dev, id, s, offset);
+	clk = krait_add_pri_mux(dev, hfpll_div, sec_mux, id, s, offset);
 err:
 	kfree(p);
 	return clk;
-- 
2.34.1

