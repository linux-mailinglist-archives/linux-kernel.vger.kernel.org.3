Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B53964D77CC
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 20:06:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235434AbiCMTGz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 15:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235305AbiCMTGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 15:06:33 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A98D5006C;
        Sun, 13 Mar 2022 12:05:14 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id p15so29580790ejc.7;
        Sun, 13 Mar 2022 12:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Q3b6ElFuNAjEzox0VnbXAUoCVQRKSTTTamOGAckJEC4=;
        b=K022jRyjFjm8Ok5yoeqDM32OVXzRct5OUuieKyISOdxr22+ycrTGo5K3KHX+6LU6wT
         6IVQtnRAKscm9CPZyPaRnH81Wydx/ChpEJ0MHpXoZpXgk69qAM+hrXcci9rhvFdedQHq
         tIEbaUyZXsgHvEWVETGT1VLUgDzHddjzcYudS1O22621dEb/IJuJHMSMAOD4Dt/drlmK
         JcSpPvyc/ZkADj1zIWDUwYyHkYWbMd1vA7l6jYNBgs872GP7CLPPxHvMsaKERm1xo08D
         vkj3v6h0L5d7D7OsdZgrcOi/gIURKDHZ39DE8ZjR2lk3NXP0kiJabI0+nJM9ckbrzW2c
         1Tjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q3b6ElFuNAjEzox0VnbXAUoCVQRKSTTTamOGAckJEC4=;
        b=pKSGf743lqWvpi19uSoqaEQLVtQA4UnwYhgi9Sa1te8oqLHUtAWRJZ0OHPCrbzd4Hr
         49NRjfgd+Nks4nGUuQNvOdRSBH00ajZbhE0y7CTSGq7qZ+/UTxwyug/eBX3TwWDqNpxU
         sKJAj29W05QG5D8LI1I8vtId1Y85OaLG5ULbwgufS3mcvozcIDRrXBlyGKotu5+9pM3t
         wr1GH81Mdoh2iahiI0QuCnX+vfWofnOgVth25/MixwWN6cS9/pZmVOUGziHZrbjmrm0D
         BaAHJzDXOB5V1XUtwI5WJs6qMiYKpoe381RWniPXaKTBcFxP1ldfrVmv1HLAT3FbSImO
         XymA==
X-Gm-Message-State: AOAM533MSwA5qWHmkj5nXb6Wv28KRggVSKamiCPg/cKIE6Yy8Lb3D9qf
        whMfuNwTgkyaJbamJOHK6fw=
X-Google-Smtp-Source: ABdhPJy9z9Eor0s/HxJ4petV2/EuaBbA89rk6mQ7GAunlGLTlMHPvl9J1+ArysqMKsvzzVwT0deoQw==
X-Received: by 2002:a17:906:7706:b0:6d6:e521:5471 with SMTP id q6-20020a170906770600b006d6e5215471mr16050002ejm.387.1647198312484;
        Sun, 13 Mar 2022 12:05:12 -0700 (PDT)
Received: from Ansuel-xps.localdomain (93-42-71-246.ip85.fastwebnet.it. [93.42.71.246])
        by smtp.googlemail.com with ESMTPSA id n13-20020a170906724d00b006cedd6d7e24sm5856697ejk.119.2022.03.13.12.05.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Mar 2022 12:05:12 -0700 (PDT)
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
Subject: [PATCH 10/16] clk: qcom: krait-cc: drop hardcoded safe_sel
Date:   Sun, 13 Mar 2022 20:04:13 +0100
Message-Id: <20220313190419.2207-11-ansuelsmth@gmail.com>
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

Drop hardcoded safe_sel definition and use helper to correctly calculate
it. We assume qsb clk is always present as it should be declared in DTS
per Documentation and in the absence of that, it's declared as a fixed
clk.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 drivers/clk/qcom/krait-cc.c | 36 +++++++++++++++++++++++-------------
 1 file changed, 23 insertions(+), 13 deletions(-)

diff --git a/drivers/clk/qcom/krait-cc.c b/drivers/clk/qcom/krait-cc.c
index 50352ff0ac67..6530f10a546f 100644
--- a/drivers/clk/qcom/krait-cc.c
+++ b/drivers/clk/qcom/krait-cc.c
@@ -26,6 +26,13 @@ static unsigned int pri_mux_map[] = {
 	0,
 };
 
+static u8 krait_get_mux_sel(struct krait_mux_clk *mux, struct clk *safe_clk)
+{
+	struct clk_hw *safe_hw = __clk_get_hw(safe_clk);
+
+	return clk_hw_get_parent_index(&mux->hw, safe_hw);
+}
+
 /*
  * Notifier function for switching the muxes to safe parent
  * while the hfpll is getting reprogrammed.
@@ -117,8 +124,8 @@ krait_add_div(struct device *dev, int id, const char *s, unsigned int offset)
 }
 
 static struct clk *
-krait_add_sec_mux(struct device *dev, int id, const char *s,
-		  unsigned int offset, bool unique_aux)
+krait_add_sec_mux(struct device *dev, struct clk *qsb, int id,
+		  const char *s, unsigned int offset, bool unique_aux)
 {
 	static struct clk_parent_data sec_mux_list[2] = {
 		{ .name = "qsb", .fw_name = "qsb" },
@@ -145,7 +152,6 @@ krait_add_sec_mux(struct device *dev, int id, const char *s,
 	mux->shift = 2;
 	mux->parent_map = sec_mux_map;
 	mux->hw.init = &init;
-	mux->safe_sel = 0;
 
 	init.name = kasprintf(GFP_KERNEL, "krait%s_sec_mux", s);
 	if (!init.name)
@@ -167,6 +173,7 @@ krait_add_sec_mux(struct device *dev, int id, const char *s,
 	if (IS_ERR(clk))
 		goto err_clk;
 
+	mux->safe_sel = krait_get_mux_sel(mux, qsb);
 	ret = krait_notifier_register(dev, clk, mux);
 	if (ret)
 		clk = ERR_PTR(ret);
@@ -205,7 +212,6 @@ krait_add_pri_mux(struct device *dev, struct clk *hfpll_div, struct clk *sec_mux
 	mux->lpl = id >= 0;
 	mux->parent_map = pri_mux_map;
 	mux->hw.init = &init;
-	mux->safe_sel = 2;
 
 	init.name = kasprintf(GFP_KERNEL, "krait%s_pri_mux", s);
 	if (!init.name)
@@ -227,6 +233,7 @@ krait_add_pri_mux(struct device *dev, struct clk *hfpll_div, struct clk *sec_mux
 	if (IS_ERR(clk))
 		goto err_clk;
 
+	mux->safe_sel = krait_get_mux_sel(mux, sec_mux);
 	ret = krait_notifier_register(dev, clk, mux);
 	if (ret)
 		clk = ERR_PTR(ret);
@@ -239,7 +246,9 @@ krait_add_pri_mux(struct device *dev, struct clk *hfpll_div, struct clk *sec_mux
 }
 
 /* id < 0 for L2, otherwise id == physical CPU number */
-static struct clk *krait_add_clks(struct device *dev, int id, bool unique_aux)
+static struct clk *
+krait_add_clks(struct device *dev, struct clk *qsb, int id,
+	       bool unique_aux)
 {
 	struct clk *hfpll_div, *sec_mux, *clk;
 	unsigned int offset;
@@ -262,7 +271,7 @@ static struct clk *krait_add_clks(struct device *dev, int id, bool unique_aux)
 		goto err;
 	}
 
-	sec_mux = krait_add_sec_mux(dev, id, s, offset, unique_aux);
+	sec_mux = krait_add_sec_mux(dev, qsb, id, s, offset, unique_aux);
 	if (IS_ERR(sec_mux)) {
 		clk = sec_mux;
 		goto err;
@@ -296,8 +305,8 @@ MODULE_DEVICE_TABLE(of, krait_cc_match_table);
 
 static int krait_cc_probe(struct platform_device *pdev)
 {
+	struct clk *l2_pri_mux_clk, *qsb, *clk;
 	unsigned long cur_rate, aux_rate;
-	struct clk *l2_pri_mux_clk, *clk;
 	struct device *dev = &pdev->dev;
 	const struct of_device_id *id;
 	struct clk **clks;
@@ -308,11 +317,12 @@ static int krait_cc_probe(struct platform_device *pdev)
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
@@ -327,13 +337,13 @@ static int krait_cc_probe(struct platform_device *pdev)
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

