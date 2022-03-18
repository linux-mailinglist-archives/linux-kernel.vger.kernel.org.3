Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9982D4DDDF8
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 17:10:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238671AbiCRQK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 12:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238538AbiCRQJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 12:09:58 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 091758CCEE;
        Fri, 18 Mar 2022 09:08:39 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id r13so17938695ejd.5;
        Fri, 18 Mar 2022 09:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=1tacB+H58ZcVKBVcWE3u+TMM2y65iIDEoWk8hI94hWs=;
        b=S8VdB15TP2RZH8tklMdLLDLT4qys66EcWGO5AmvsBftJ+w6pcQF9OUhn4Oh/hRGEmg
         BCj/QTuVAP5L1XRHEWuWGRvWIufvGdd1deyJ1I9ca7e1sHrlzeXnGkJHdEddDYk4k41w
         Ifr5YcZKThHCIIxECO1JmkRjlF9RfdNIEbZcuTtaYczOeBkq+Q22692xRXHsCVYoNBEb
         Tybm8gpiZky6HTx8qDALaqIhRF7/XP3m6jRh4g3GPYqnReJOD0kAwXY8+2KGCQeWi6H3
         L+egDM9XLA84hfoom43IPG9FmhJ7Ci+Vo9GK10dQV8dEJS07DvEbg+hDYG43aJcxYCGp
         dddg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1tacB+H58ZcVKBVcWE3u+TMM2y65iIDEoWk8hI94hWs=;
        b=yVeKQ2s+V/QuAjsIsu+WX2Ho9TJkGTeyUO+qWU7v48z+WRbQkY6XKxR2bqXrxXju0q
         NUkX07XqI96+XerJSqkZwOYeETMMpLRxPtjaT8Ib2M9unAHUcoE7OFHsMEv0DhMRfbsY
         4JW+LkL8G1sdbZ6ymgdRHTNN5Unc4owvxA6a/IIo7h9I6lO3r7jDCwFtEiADJHG1n9Co
         hF6a2ocdB0ROHpy9Z/Wxl2xFofJ03QpFgBEKjhIDA+zq6heSfhrNtTd8DuE6YyhduveV
         Y5WiAR4Sxy88qZfrrh9UpBS3O40lLYRHO3Z6MQmMZmnYT0MGfwJPGumVj3yJ5MdlewQc
         bT1Q==
X-Gm-Message-State: AOAM531SeMzgk+I4jQKUDRGjApJMK1TjWOuZoxWwBKo7SnJm3qquyh1+
        tifRBDzVk+J2km+pUulhUHA=
X-Google-Smtp-Source: ABdhPJyjbdYbskM3iuqrC1qVTEmng+sR1PNqK/RxD1xOs583/qnFJu8+Fw2FSUNGFBDghEMh77ws+g==
X-Received: by 2002:a17:907:8a04:b0:6cd:2902:8db3 with SMTP id sc4-20020a1709078a0400b006cd29028db3mr9442670ejc.530.1647619717321;
        Fri, 18 Mar 2022 09:08:37 -0700 (PDT)
Received: from Ansuel-xps.localdomain (93-42-69-170.ip85.fastwebnet.it. [93.42.69.170])
        by smtp.googlemail.com with ESMTPSA id e9-20020a170906c00900b006d4a45869basm3754118ejz.199.2022.03.18.09.08.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Mar 2022 09:08:37 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH v2 08/16] clk: qcom: krait-cc: convert to parent_data API
Date:   Fri, 18 Mar 2022 17:08:19 +0100
Message-Id: <20220318160827.8860-9-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220318160827.8860-1-ansuelsmth@gmail.com>
References: <20220318160827.8860-1-ansuelsmth@gmail.com>
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

