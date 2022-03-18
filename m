Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8D574DDDE6
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 17:10:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235281AbiCRQKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 12:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238607AbiCRQKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 12:10:14 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 436398CCFD;
        Fri, 18 Mar 2022 09:08:41 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id j15so3838706eje.9;
        Fri, 18 Mar 2022 09:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=HxwJ/rmGXQIKgHQmjTVr7v/2TGpe+xuVVbkVjt0eYLU=;
        b=PbpFHnlhHwJ1PrE15oOIJDeMBczuvBHO8xJQcgpSliVes/4h26WJHDNrxkDPBbqsig
         9uz/pPofF6Gc7vkP6XONfbmZuTa4m1stb7RGw+pgP5qaEvSXhvQYqxFt2rj7Fw/999nk
         Cu03MaNqW8mx8c/zsj2BZuMq8buYeksMlRKi6fumhgIGOkWkAIXKMOgDUh7h0AWaiiox
         mMM/DQQtGZieHep9VuXUDkIHv6VeRUIFFqJU0hjdItW0lSLnY8kIOaFdfjDohsvyeowK
         ZDR+65MeoL89FC160Sb4nrxLipMx9ctNwiCfo4t5+4P9B6PALxiLhacFpaaKiiNKqc37
         vbeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HxwJ/rmGXQIKgHQmjTVr7v/2TGpe+xuVVbkVjt0eYLU=;
        b=N45GvyCX/gmmqigv3PAz/Y5pdvxob6KZFkVJZiN9VM/5mn+tEvtmNdvSL3zdqHMwat
         CX5PM/qccKM2hmOLjMJN2bEWgyCq0hX8joicp1i+wbaGyS5yemHxZZnoziJdCzjA7mmP
         ASiHya80N1ZPINlZfMAFNAGClRnBXEFDPicggv63xoCG5/bHVT9dV2kdx+x101w9dxeJ
         SPtVPDBMmbWbjmHRxEXdY+aZwhfO9+KWNUzA2ugtsUUbcGCAUIay6ljaLrEl4RrclQPd
         q8nRdi104P12ER2J/eQtbd1JUTkoZ5hTeGxpYcx76h/R1OZHosgUbh4KEM87nbDz3qwK
         4Jyw==
X-Gm-Message-State: AOAM531UcNpBSclsQ6/8X9q2iRolc8Xs4T4b1b20sMSD0K5N1sjolGkP
        e3IBODc+Pf4rJD5qcGmwjkA=
X-Google-Smtp-Source: ABdhPJydW1ocXPo0I+XrzjEOy220muUYxXLLxTR/Xh2npTCUP0z9NSimx0XN1JvEzwmvNnN7/SX1Mg==
X-Received: by 2002:a17:907:72ce:b0:6db:aed5:833e with SMTP id du14-20020a17090772ce00b006dbaed5833emr9510378ejc.420.1647619719430;
        Fri, 18 Mar 2022 09:08:39 -0700 (PDT)
Received: from Ansuel-xps.localdomain (93-42-69-170.ip85.fastwebnet.it. [93.42.69.170])
        by smtp.googlemail.com with ESMTPSA id e9-20020a170906c00900b006d4a45869basm3754118ejz.199.2022.03.18.09.08.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Mar 2022 09:08:39 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH v2 10/16] clk: qcom: krait-cc: drop hardcoded safe_sel
Date:   Fri, 18 Mar 2022 17:08:21 +0100
Message-Id: <20220318160827.8860-11-ansuelsmth@gmail.com>
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

