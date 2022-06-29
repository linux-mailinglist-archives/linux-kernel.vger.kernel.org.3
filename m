Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C9DB560CAB
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 00:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbiF2Wxr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 18:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbiF2Wxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 18:53:38 -0400
Received: from relay06.th.seeweb.it (relay06.th.seeweb.it [5.144.164.167])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6499323174;
        Wed, 29 Jun 2022 15:53:37 -0700 (PDT)
Received: from Marijn-Arch-PC.localdomain (94-209-165-62.cable.dynamic.v4.ziggo.nl [94.209.165.62])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 45C5E3F809;
        Thu, 30 Jun 2022 00:53:35 +0200 (CEST)
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     phone-devel@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rajeev Nandan <quic_rajeevny@quicinc.com>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        Jonathan Marek <jonathan@marek.ca>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org
Subject: [PATCH v3 03/11] clk: fixed-factor: Introduce *clk_hw_register_fixed_factor_parent_hw()
Date:   Thu, 30 Jun 2022 00:53:23 +0200
Message-Id: <20220629225331.357308-4-marijn.suijten@somainline.org>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220629225331.357308-1-marijn.suijten@somainline.org>
References: <20220629225331.357308-1-marijn.suijten@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the devres and non-devres variant of
clk_hw_register_fixed_factor_parent_hw() for registering a fixed factor
clock with clk_hw parent pointer instead of parent name.

Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
---
 drivers/clk/clk-fixed-factor.c | 45 ++++++++++++++++++++++++++++++----
 include/linux/clk-provider.h   |  8 ++++++
 2 files changed, 48 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/clk-fixed-factor.c b/drivers/clk/clk-fixed-factor.c
index e6b36247c16b..f734e34735a9 100644
--- a/drivers/clk/clk-fixed-factor.c
+++ b/drivers/clk/clk-fixed-factor.c
@@ -78,7 +78,8 @@ static void devm_clk_hw_register_fixed_factor_release(struct device *dev, void *
 
 static struct clk_hw *
 __clk_hw_register_fixed_factor(struct device *dev, struct device_node *np,
-		const char *name, const char *parent_name, int index,
+		const char *name, const char *parent_name,
+		const struct clk_hw *parent_hw, int index,
 		unsigned long flags, unsigned int mult, unsigned int div,
 		bool devm)
 {
@@ -110,6 +111,8 @@ __clk_hw_register_fixed_factor(struct device *dev, struct device_node *np,
 	init.flags = flags;
 	if (parent_name)
 		init.parent_names = &parent_name;
+	else if (parent_hw)
+		init.parent_hws = &parent_hw;
 	else
 		init.parent_data = &pdata;
 	init.num_parents = 1;
@@ -148,16 +151,48 @@ struct clk_hw *devm_clk_hw_register_fixed_factor_index(struct device *dev,
 		const char *name, unsigned int index, unsigned long flags,
 		unsigned int mult, unsigned int div)
 {
-	return __clk_hw_register_fixed_factor(dev, NULL, name, NULL, index,
+	return __clk_hw_register_fixed_factor(dev, NULL, name, NULL, NULL, index,
 					      flags, mult, div, true);
 }
 EXPORT_SYMBOL_GPL(devm_clk_hw_register_fixed_factor_index);
 
+/**
+ * devm_clk_hw_register_fixed_factor_parent_hw - Register a fixed factor clock with
+ * pointer to parent clock
+ * @dev: device that is registering this clock
+ * @name: name of this clock
+ * @parent_hw: pointer to parent clk
+ * @flags: fixed factor flags
+ * @mult: multiplier
+ * @div: divider
+ *
+ * Return: Pointer to fixed factor clk_hw structure that was registered or
+ * an error pointer.
+ */
+struct clk_hw *devm_clk_hw_register_fixed_factor_parent_hw(struct device *dev,
+		const char *name, const struct clk_hw *parent_hw,
+		unsigned long flags, unsigned int mult, unsigned int div)
+{
+	return __clk_hw_register_fixed_factor(dev, NULL, name, NULL, parent_hw,
+					      -1, flags, mult, div, true);
+}
+EXPORT_SYMBOL_GPL(devm_clk_hw_register_fixed_factor_parent_hw);
+
+struct clk_hw *clk_hw_register_fixed_factor_parent_hw(struct device *dev,
+		const char *name, const struct clk_hw *parent_hw,
+		unsigned long flags, unsigned int mult, unsigned int div)
+{
+	return __clk_hw_register_fixed_factor(dev, NULL, name, NULL,
+					      parent_hw, -1, flags, mult, div,
+					      false);
+}
+EXPORT_SYMBOL_GPL(clk_hw_register_fixed_factor_parent_hw);
+
 struct clk_hw *clk_hw_register_fixed_factor(struct device *dev,
 		const char *name, const char *parent_name, unsigned long flags,
 		unsigned int mult, unsigned int div)
 {
-	return __clk_hw_register_fixed_factor(dev, NULL, name, parent_name, -1,
+	return __clk_hw_register_fixed_factor(dev, NULL, name, parent_name, NULL, -1,
 					      flags, mult, div, false);
 }
 EXPORT_SYMBOL_GPL(clk_hw_register_fixed_factor);
@@ -204,7 +239,7 @@ struct clk_hw *devm_clk_hw_register_fixed_factor(struct device *dev,
 		const char *name, const char *parent_name, unsigned long flags,
 		unsigned int mult, unsigned int div)
 {
-	return __clk_hw_register_fixed_factor(dev, NULL, name, parent_name, -1,
+	return __clk_hw_register_fixed_factor(dev, NULL, name, parent_name, NULL, -1,
 			flags, mult, div, true);
 }
 EXPORT_SYMBOL_GPL(devm_clk_hw_register_fixed_factor);
@@ -231,7 +266,7 @@ static struct clk_hw *_of_fixed_factor_clk_setup(struct device_node *node)
 
 	of_property_read_string(node, "clock-output-names", &clk_name);
 
-	hw = __clk_hw_register_fixed_factor(NULL, node, clk_name, NULL, 0,
+	hw = __clk_hw_register_fixed_factor(NULL, node, clk_name, NULL, NULL, 0,
 					    0, mult, div, false);
 	if (IS_ERR(hw)) {
 		/*
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 3a76a67241e8..1615010aa0ec 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -1032,6 +1032,14 @@ struct clk_hw *devm_clk_hw_register_fixed_factor(struct device *dev,
 struct clk_hw *devm_clk_hw_register_fixed_factor_index(struct device *dev,
 		const char *name, unsigned int index, unsigned long flags,
 		unsigned int mult, unsigned int div);
+
+struct clk_hw *devm_clk_hw_register_fixed_factor_parent_hw(struct device *dev,
+		const char *name, const struct clk_hw *parent_hw,
+		unsigned long flags, unsigned int mult, unsigned int div);
+
+struct clk_hw *clk_hw_register_fixed_factor_parent_hw(struct device *dev,
+		const char *name, const struct clk_hw *parent_hw,
+		unsigned long flags, unsigned int mult, unsigned int div);
 /**
  * struct clk_fractional_divider - adjustable fractional divider clock
  *
-- 
2.37.0

