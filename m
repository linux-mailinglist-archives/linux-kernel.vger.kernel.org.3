Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91EE44E1CD1
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 17:29:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245581AbiCTQaV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 12:30:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245503AbiCTQ3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 12:29:47 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D29C234641;
        Sun, 20 Mar 2022 09:28:23 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id r7so7310266wmq.2;
        Sun, 20 Mar 2022 09:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=HxwJ/rmGXQIKgHQmjTVr7v/2TGpe+xuVVbkVjt0eYLU=;
        b=Fw76zuB6gLSIMCVwLdXOTwyVXT9jJ2qiMHKBNtsDigG8z0+gUas5O8myeSTbQkgIi0
         TqytG10ca64z6CO6GF/jb0MDjGsXIyGs+uFZJ5inlFDWUkz/GesxTrZVCKiD+13cZ8rQ
         w0bvfSUllN/tFLFPwmQdQOXH20cjS/ZNGOwr8cK+tpcs9ne3cYlc6JQblWZ/yzrHIn6F
         P8h08WqVTSPPrw5IuE4gle5A3vxEsyK+e2K4Uf4apu/aPkc4luiMaPK8SmK26Nvx0i9g
         P9YVWNaO0ztQDk/U4p9/JbIAMMJ6tXpGhx+xJkaDwK7lhpqJPNHBXtYOeQOtAHAv8MGh
         Va2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HxwJ/rmGXQIKgHQmjTVr7v/2TGpe+xuVVbkVjt0eYLU=;
        b=fLxeQhucs/1Km/U5i7WfQ6Ri8yEB1+pc2PJKJAkC7JUEhLec8dNWGBBNj4+w1OB5tB
         1J8ENjaArpePLk6eXoQ2uhvp4kFThNK0ixbHj7dLs6kASIdvY5gZEHndUWLOqFcmPfjz
         1PXmYOlAUAr06GwAGDkCdFnhUpVaG28cLgCNTPwp5+oJHxbzUgo7KgWE++0QGoymv9Pc
         bWuCipcKy+KtZlCn6nGih2Ndmu1xx/C05uAcfb8spJap8rAKEC+3aB4704kwIkVwxTAD
         S3D4nr7nHzsNPBwDLSoCCjMglsGSv4/kfVON4oBEWRJbPQw3eZTGZVMM1vXVVUaEMdiX
         JBVA==
X-Gm-Message-State: AOAM531R6dfWvOa4m421bXwcbGl87AcadMyFUO8nDFEdUJwugSfJAyg3
        toR4NGvEaIifx+xjSVRUinTxxLYg6fE=
X-Google-Smtp-Source: ABdhPJwKyCiufu6SXTgIc4tA9sWhCl9JCxr5qnw4T6gbPmSp5K13LJbFcCCRwRGZVrsm6tBsDfjh0w==
X-Received: by 2002:a05:600c:3c8a:b0:389:cf43:eaf6 with SMTP id bg10-20020a05600c3c8a00b00389cf43eaf6mr15983930wmb.199.1647793702258;
        Sun, 20 Mar 2022 09:28:22 -0700 (PDT)
Received: from Ansuel-xps.localdomain (93-42-69-170.ip85.fastwebnet.it. [93.42.69.170])
        by smtp.googlemail.com with ESMTPSA id y6-20020a05600015c600b00203fa70b4ebsm6760085wry.53.2022.03.20.09.28.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Mar 2022 09:28:21 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH v3 10/18] clk: qcom: krait-cc: drop hardcoded safe_sel
Date:   Sun, 20 Mar 2022 12:34:22 +0100
Message-Id: <20220320113430.26076-11-ansuelsmth@gmail.com>
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

Drop hardcoded safe_sel definition and use helper to correctly calculate
it. We assume qsb clk is always present as it should be declared in DTS
per Documentation and in the absence of that, it's declared as a fixed
clk.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 drivers/clk/qcom/krait-cc.c | 40 +++++++++++++++++++++++++------------
 1 file changed, 27 insertions(+), 13 deletions(-)

diff --git a/drivers/clk/qcom/krait-cc.c b/drivers/clk/qcom/krait-cc.c
index e9508e3104ea..5f98ee1c3681 100644
--- a/drivers/clk/qcom/krait-cc.c
+++ b/drivers/clk/qcom/krait-cc.c
@@ -26,6 +26,17 @@ static unsigned int pri_mux_map[] = {
 	0,
 };
 
+static u8 krait_get_mux_sel(struct krait_mux_clk *mux, struct clk *safe_clk)
+{
+	struct clk_hw *safe_hw = __clk_get_hw(safe_clk);
+
+	/*
+	 * We can ignore errors from clk_hw_get_index_of_parent()
+	 * as we create these parents in this driver.
+	 */
+	return clk_hw_get_index_of_parent(&mux->hw, safe_hw);
+}
+
 /*
  * Notifier function for switching the muxes to safe parent
  * while the hfpll is getting reprogrammed.
@@ -116,8 +127,8 @@ krait_add_div(struct device *dev, int id, const char *s, unsigned int offset)
 }
 
 static struct clk *
-krait_add_sec_mux(struct device *dev, int id, const char *s,
-		  unsigned int offset, bool unique_aux)
+krait_add_sec_mux(struct device *dev, struct clk *qsb, int id,
+		  const char *s, unsigned int offset, bool unique_aux)
 {
 	int ret;
 	struct krait_mux_clk *mux;
@@ -144,7 +155,6 @@ krait_add_sec_mux(struct device *dev, int id, const char *s,
 	mux->shift = 2;
 	mux->parent_map = sec_mux_map;
 	mux->hw.init = &init;
-	mux->safe_sel = 0;
 
 	init.name = kasprintf(GFP_KERNEL, "krait%s_sec_mux", s);
 	if (!init.name)
@@ -166,6 +176,7 @@ krait_add_sec_mux(struct device *dev, int id, const char *s,
 	if (IS_ERR(clk))
 		goto err_clk;
 
+	mux->safe_sel = krait_get_mux_sel(mux, qsb);
 	ret = krait_notifier_register(dev, clk, mux);
 	if (ret)
 		clk = ERR_PTR(ret);
@@ -204,7 +215,6 @@ krait_add_pri_mux(struct device *dev, struct clk *hfpll_div, struct clk *sec_mux
 	mux->lpl = id >= 0;
 	mux->parent_map = pri_mux_map;
 	mux->hw.init = &init;
-	mux->safe_sel = 2;
 
 	init.name = kasprintf(GFP_KERNEL, "krait%s_pri_mux", s);
 	if (!init.name)
@@ -226,6 +236,7 @@ krait_add_pri_mux(struct device *dev, struct clk *hfpll_div, struct clk *sec_mux
 	if (IS_ERR(clk))
 		goto err_clk;
 
+	mux->safe_sel = krait_get_mux_sel(mux, sec_mux);
 	ret = krait_notifier_register(dev, clk, mux);
 	if (ret)
 		clk = ERR_PTR(ret);
@@ -238,7 +249,9 @@ krait_add_pri_mux(struct device *dev, struct clk *hfpll_div, struct clk *sec_mux
 }
 
 /* id < 0 for L2, otherwise id == physical CPU number */
-static struct clk *krait_add_clks(struct device *dev, int id, bool unique_aux)
+static struct clk *
+krait_add_clks(struct device *dev, struct clk *qsb, int id,
+	       bool unique_aux)
 {
 	unsigned int offset;
 	void *p = NULL;
@@ -261,7 +274,7 @@ static struct clk *krait_add_clks(struct device *dev, int id, bool unique_aux)
 		goto err;
 	}
 
-	sec_mux = krait_add_sec_mux(dev, id, s, offset, unique_aux);
+	sec_mux = krait_add_sec_mux(dev, qsb, id, s, offset, unique_aux);
 	if (IS_ERR(sec_mux)) {
 		clk = sec_mux;
 		goto err;
@@ -301,18 +314,19 @@ static int krait_cc_probe(struct platform_device *pdev)
 	int cpu;
 	struct clk *clk;
 	struct clk **clks;
-	struct clk *l2_pri_mux_clk;
+	struct clk *l2_pri_mux_clk, *qsb;
 
 	id = of_match_device(krait_cc_match_table, dev);
 	if (!id)
 		return -ENODEV;
 
 	/* Rate is 1 because 0 causes problems for __clk_mux_determine_rate */
-	if (IS_ERR(clk_get(dev, "qsb")))
-		clk = clk_register_fixed_rate(dev, "qsb", NULL, 0, 1);
+	qsb = clk_get(dev, "qsb");
+	if (IS_ERR(qsb))
+		qsb = clk_register_fixed_rate(dev, "qsb", NULL, 0, 1);
 
-	if (IS_ERR(clk))
-		return PTR_ERR(clk);
+	if (IS_ERR(qsb))
+		return PTR_ERR(qsb);
 
 	if (!id->data) {
 		clk = clk_register_fixed_factor(dev, "acpu_aux",
@@ -327,13 +341,13 @@ static int krait_cc_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	for_each_possible_cpu(cpu) {
-		clk = krait_add_clks(dev, cpu, id->data);
+		clk = krait_add_clks(dev, qsb, cpu, id->data);
 		if (IS_ERR(clk))
 			return PTR_ERR(clk);
 		clks[cpu] = clk;
 	}
 
-	l2_pri_mux_clk = krait_add_clks(dev, -1, id->data);
+	l2_pri_mux_clk = krait_add_clks(dev, qsb, -1, id->data);
 	if (IS_ERR(l2_pri_mux_clk))
 		return PTR_ERR(l2_pri_mux_clk);
 	clks[4] = l2_pri_mux_clk;
-- 
2.34.1

