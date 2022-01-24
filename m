Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F8AA497CB4
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 11:05:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237038AbiAXKEx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 05:04:53 -0500
Received: from foss.arm.com ([217.140.110.172]:56080 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236988AbiAXKEU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 05:04:20 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 92CA56D;
        Mon, 24 Jan 2022 02:04:19 -0800 (PST)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 085F53F73B;
        Mon, 24 Jan 2022 02:04:16 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, peter.hilber@opensynergy.com,
        igor.skalkin@opensynergy.com, cristian.marussi@arm.com,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org
Subject: [PATCH 6/6] [RFC] clk: scmi: Support atomic clock enable/disable API
Date:   Mon, 24 Jan 2022 10:03:41 +0000
Message-Id: <20220124100341.41191-7-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220124100341.41191-1-cristian.marussi@arm.com>
References: <20220124100341.41191-1-cristian.marussi@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support also atomic enable/disable clk_ops beside the bare non-atomic one
(prepare/unprepare) when the underlying SCMI transport is configured to
support atomic transactions for synchronous commands.

Compare the SCMI system-wide configured atomic threshold latency time and
the per-clock advertised enable latency (if any) to choose whether to
provide sleeping prepare/unprepare vs atomic enable/disable.

Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org
Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
Tagged as RFC since dependent on a previous RFC patch
---
 drivers/clk/clk-scmi.c | 71 +++++++++++++++++++++++++++++++++++-------
 1 file changed, 60 insertions(+), 11 deletions(-)

diff --git a/drivers/clk/clk-scmi.c b/drivers/clk/clk-scmi.c
index 1e357d364ca2..2c7a830ce308 100644
--- a/drivers/clk/clk-scmi.c
+++ b/drivers/clk/clk-scmi.c
@@ -2,7 +2,7 @@
 /*
  * System Control and Power Interface (SCMI) Protocol based clock driver
  *
- * Copyright (C) 2018-2021 ARM Ltd.
+ * Copyright (C) 2018-2022 ARM Ltd.
  */
 
 #include <linux/clk-provider.h>
@@ -88,21 +88,51 @@ static void scmi_clk_disable(struct clk_hw *hw)
 	scmi_proto_clk_ops->disable(clk->ph, clk->id);
 }
 
+static int scmi_clk_atomic_enable(struct clk_hw *hw)
+{
+	struct scmi_clk *clk = to_scmi_clk(hw);
+
+	return scmi_proto_clk_ops->enable_atomic(clk->ph, clk->id);
+}
+
+static void scmi_clk_atomic_disable(struct clk_hw *hw)
+{
+	struct scmi_clk *clk = to_scmi_clk(hw);
+
+	scmi_proto_clk_ops->disable_atomic(clk->ph, clk->id);
+}
+
+/*
+ * We can provide enable/disable atomic callbacks only if the underlying SCMI
+ * transport for an SCMI instance is configured to handle SCMI commands in an
+ * atomic manner.
+ *
+ * When no SCMI atomic transport support is available we instead provide only
+ * the prepare/unprepare API, as allowed by the clock framework when atomic
+ * calls are not available.
+ *
+ * Two distinct sets of clk_ops are provided since we could have multiple SCMI
+ * instances with different underlying transport quality, so they cannot be
+ * shared.
+ */
 static const struct clk_ops scmi_clk_ops = {
 	.recalc_rate = scmi_clk_recalc_rate,
 	.round_rate = scmi_clk_round_rate,
 	.set_rate = scmi_clk_set_rate,
-	/*
-	 * We can't provide enable/disable callback as we can't perform the same
-	 * in atomic context. Since the clock framework provides standard API
-	 * clk_prepare_enable that helps cases using clk_enable in non-atomic
-	 * context, it should be fine providing prepare/unprepare.
-	 */
 	.prepare = scmi_clk_enable,
 	.unprepare = scmi_clk_disable,
 };
 
-static int scmi_clk_ops_init(struct device *dev, struct scmi_clk *sclk)
+static const struct clk_ops scmi_atomic_clk_ops = {
+	.recalc_rate = scmi_clk_recalc_rate,
+	.round_rate = scmi_clk_round_rate,
+	.set_rate = scmi_clk_set_rate,
+	.enable = scmi_clk_atomic_enable,
+	.disable = scmi_clk_atomic_disable,
+};
+
+static int scmi_clk_ops_init(struct device *dev, struct scmi_clk *sclk,
+			     const struct clk_ops *scmi_ops)
 {
 	int ret;
 	unsigned long min_rate, max_rate;
@@ -110,7 +140,7 @@ static int scmi_clk_ops_init(struct device *dev, struct scmi_clk *sclk)
 	struct clk_init_data init = {
 		.flags = CLK_GET_RATE_NOCACHE,
 		.num_parents = 0,
-		.ops = &scmi_clk_ops,
+		.ops = scmi_ops,
 		.name = sclk->info->name,
 	};
 
@@ -139,6 +169,8 @@ static int scmi_clk_ops_init(struct device *dev, struct scmi_clk *sclk)
 static int scmi_clocks_probe(struct scmi_device *sdev)
 {
 	int idx, count, err;
+	unsigned int atomic_threshold;
+	bool is_atomic;
 	struct clk_hw **hws;
 	struct clk_hw_onecell_data *clk_data;
 	struct device *dev = &sdev->dev;
@@ -168,8 +200,11 @@ static int scmi_clocks_probe(struct scmi_device *sdev)
 	clk_data->num = count;
 	hws = clk_data->hws;
 
+	is_atomic = handle->is_transport_atomic(handle, &atomic_threshold);
+
 	for (idx = 0; idx < count; idx++) {
 		struct scmi_clk *sclk;
+		const struct clk_ops *scmi_ops;
 
 		sclk = devm_kzalloc(dev, sizeof(*sclk), GFP_KERNEL);
 		if (!sclk)
@@ -184,13 +219,27 @@ static int scmi_clocks_probe(struct scmi_device *sdev)
 		sclk->id = idx;
 		sclk->ph = ph;
 
-		err = scmi_clk_ops_init(dev, sclk);
+		/*
+		 * Note that when transport is atomic but SCMI protocol did not
+		 * specify (or support) an enable_latency associated with a
+		 * clock, we default to use atomic operations mode.
+		 */
+		if (is_atomic &&
+		    sclk->info->enable_latency <= atomic_threshold)
+			scmi_ops = &scmi_atomic_clk_ops;
+		else
+			scmi_ops = &scmi_clk_ops;
+
+		err = scmi_clk_ops_init(dev, sclk, scmi_ops);
 		if (err) {
 			dev_err(dev, "failed to register clock %d\n", idx);
 			devm_kfree(dev, sclk);
 			hws[idx] = NULL;
 		} else {
-			dev_dbg(dev, "Registered clock:%s\n", sclk->info->name);
+			dev_dbg(dev, "Registered clock:%s%s\n",
+				sclk->info->name,
+				scmi_ops == &scmi_atomic_clk_ops ?
+				" (atomic ops)" : "");
 			hws[idx] = &sclk->hw;
 		}
 	}
-- 
2.17.1

