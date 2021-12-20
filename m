Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C307247B418
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 20:58:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233850AbhLTT6X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 14:58:23 -0500
Received: from foss.arm.com ([217.140.110.172]:34698 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233569AbhLTT5u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 14:57:50 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BD8FA1FB;
        Mon, 20 Dec 2021 11:57:49 -0800 (PST)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 679883F718;
        Mon, 20 Dec 2021 11:57:47 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, cristian.marussi@arm.com,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org
Subject: [PATCH v8 11/11] clk: scmi: Support atomic clock enable/disable API
Date:   Mon, 20 Dec 2021 19:56:46 +0000
Message-Id: <20211220195646.44498-12-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211220195646.44498-1-cristian.marussi@arm.com>
References: <20211220195646.44498-1-cristian.marussi@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support also atomic enable/disable clk_ops beside the bare non-atomic one
(prepare/unprepare) when the underlying SCMI transport is configured to
support atomic transactions for synchronous commands.

Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org
Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
NOTE THAT STILL THERE'S NO FINE GRAIN CONTROL OVER SELECTION
OF WHICH CLOCK DEVICES CAN SUPPORT ATOMIC AND WHICH SHOULD NOT
BASED ON CLOCK DEVICES ENABLE LATENCY.
THIS HAS STILL TO BE ADDED IN SCMI PROTOCOL SPEC.

v7 --> v8
- provide prepare/unprepare only on non-atomic transports
V5 --> V6
- add concurrent availability of atomic and non atomic reqs
---
 drivers/clk/clk-scmi.c | 54 +++++++++++++++++++++++++++++++++++-------
 1 file changed, 45 insertions(+), 9 deletions(-)

diff --git a/drivers/clk/clk-scmi.c b/drivers/clk/clk-scmi.c
index 1e357d364ca2..3da99f81ead9 100644
--- a/drivers/clk/clk-scmi.c
+++ b/drivers/clk/clk-scmi.c
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
 
@@ -145,6 +175,7 @@ static int scmi_clocks_probe(struct scmi_device *sdev)
 	struct device_node *np = dev->of_node;
 	const struct scmi_handle *handle = sdev->handle;
 	struct scmi_protocol_handle *ph;
+	const struct clk_ops *scmi_ops;
 
 	if (!handle)
 		return -ENODEV;
@@ -168,6 +199,11 @@ static int scmi_clocks_probe(struct scmi_device *sdev)
 	clk_data->num = count;
 	hws = clk_data->hws;
 
+	if (handle->is_transport_atomic(handle))
+		scmi_ops = &scmi_atomic_clk_ops;
+	else
+		scmi_ops = &scmi_clk_ops;
+
 	for (idx = 0; idx < count; idx++) {
 		struct scmi_clk *sclk;
 
@@ -184,7 +220,7 @@ static int scmi_clocks_probe(struct scmi_device *sdev)
 		sclk->id = idx;
 		sclk->ph = ph;
 
-		err = scmi_clk_ops_init(dev, sclk);
+		err = scmi_clk_ops_init(dev, sclk, scmi_ops);
 		if (err) {
 			dev_err(dev, "failed to register clock %d\n", idx);
 			devm_kfree(dev, sclk);
-- 
2.17.1

