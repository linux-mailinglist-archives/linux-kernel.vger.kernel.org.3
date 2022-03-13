Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4AA74D77D9
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 20:06:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235292AbiCMTHD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 15:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231828AbiCMTGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 15:06:36 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B6365046A;
        Sun, 13 Mar 2022 12:05:15 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id p15so29580829ejc.7;
        Sun, 13 Mar 2022 12:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=R2fOLGJy54v/l8o8t90lry+jkIkH1FCiYeOZyRDynbg=;
        b=HJljWlHBCKVH/TmR5iHLP9OzViczF/GUVvexZ/Kda8869jV/EzPq/TfNHXTNUr0Ih9
         +3xzp7v2i1JlUGKFs69kKOMnxzTmtsKc9LsQb7X6Ldo7bzvc+kuuJL2+hVxQWJewQ+9h
         2fDknuZ4sGm76rlK+1esp8khStQJcTj0s7M3AVJx7DW+2o3cG9Y2QrUug4EVM0H3fg4s
         +VVsSljih/hUv9zPL26rpgVgMeshBxWE7ieCyldU1loP4vMbn8ln8wcddnQXh4BBlFoz
         yqJUGt5C0RZvC2SK1zuWWWUwgEQDtf/xhRTjcY0U297WVSgHi2gSwIpqvlTm+bGj2kth
         Wyzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R2fOLGJy54v/l8o8t90lry+jkIkH1FCiYeOZyRDynbg=;
        b=Nh09kG9ignyEpliqCRDney2sp+HDOrQogjDxSUeq23P5Qk/rBgwZKqDr55XAuj8MTX
         9CkLO5j63D0nGMoJ0vTt9r3WLXiEJtUacV9DndJzsm8mjspisN+MaziqpHsR/YSNjPg9
         JqD0UZ2qV5tbGEGMsC2Z2C+zxt7299ghHuQEt8poHWrY2D+UXZi7g178473Y3jtFmfmc
         bO+6sVvHv9X+hD7v5ndB7gAjJTBa4YdMwUB3JiHn9XmuQa1zN6JLDn3xyDkAEC1n/a82
         kSl1OV3hf1DdcV+2PdBj/jERbDwJybIorDGqG9xD80gNAMgiXxBT9Vf8lh26kpYjpV+L
         FzvA==
X-Gm-Message-State: AOAM533OAU5/1KrkDSCFPmZGXDKrIOQMU/JqYMxjva1WkENtmkiWTrKG
        FrryIsQRwvBC3dxL5+VNr6U=
X-Google-Smtp-Source: ABdhPJzvI7DgVwAOqW+xsXzrTfiec88NrdouKuOnUuB+vKBdoNs9RaryvElzZYoFnITBSgrD8IRdGg==
X-Received: by 2002:a17:906:3a55:b0:6ce:c2ee:3e10 with SMTP id a21-20020a1709063a5500b006cec2ee3e10mr15185399ejf.210.1647198313618;
        Sun, 13 Mar 2022 12:05:13 -0700 (PDT)
Received: from Ansuel-xps.localdomain (93-42-71-246.ip85.fastwebnet.it. [93.42.71.246])
        by smtp.googlemail.com with ESMTPSA id n13-20020a170906724d00b006cedd6d7e24sm5856697ejk.119.2022.03.13.12.05.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Mar 2022 12:05:13 -0700 (PDT)
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
Subject: [PATCH 11/16] clk: qcom: krait-cc: force sec_mux to QSB
Date:   Sun, 13 Mar 2022 20:04:14 +0100
Message-Id: <20220313190419.2207-12-ansuelsmth@gmail.com>
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

Now that we have converted every driver to parent_data, it was
notice that the bootloader can't really leave the system in a
strange state where l2 or the cpu0/1 can be sourced in a number of ways
for example cpu1 sourcing out of qsb, l2 sourcing out of pxo.
To correctly reset the mux and the HFPLL force the sec_mux to QSB.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 drivers/clk/qcom/krait-cc.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/qcom/krait-cc.c b/drivers/clk/qcom/krait-cc.c
index 6530f10a546f..1bdc89c097e6 100644
--- a/drivers/clk/qcom/krait-cc.c
+++ b/drivers/clk/qcom/krait-cc.c
@@ -15,6 +15,8 @@
 
 #include "clk-krait.h"
 
+#define QSB_RATE	1
+
 static unsigned int sec_mux_map[] = {
 	2,
 	0,
@@ -178,6 +180,12 @@ krait_add_sec_mux(struct device *dev, struct clk *qsb, int id,
 	if (ret)
 		clk = ERR_PTR(ret);
 
+	/* Force the sec_mux to be set to QSB rate.
+	 * This is needed to correctly set the parents and
+	 * to later reset mux and HFPLL to a known freq.
+	 */
+	clk_set_rate(clk, QSB_RATE);
+
 err_clk:
 	if (unique_aux)
 		kfree(parent_name);
@@ -374,7 +382,7 @@ static int krait_cc_probe(struct platform_device *pdev)
 	 */
 	cur_rate = clk_get_rate(l2_pri_mux_clk);
 	aux_rate = 384000000;
-	if (cur_rate == 1) {
+	if (cur_rate == QSB_RATE) {
 		dev_info(dev, "L2 @ QSB rate. Forcing new rate.\n");
 		cur_rate = aux_rate;
 	}
@@ -385,7 +393,7 @@ static int krait_cc_probe(struct platform_device *pdev)
 	for_each_possible_cpu(cpu) {
 		clk = clks[cpu];
 		cur_rate = clk_get_rate(clk);
-		if (cur_rate == 1) {
+		if (cur_rate == QSB_RATE) {
 			dev_info(dev, "CPU%d @ QSB rate. Forcing new rate.\n", cpu);
 			cur_rate = aux_rate;
 		}
-- 
2.34.1

