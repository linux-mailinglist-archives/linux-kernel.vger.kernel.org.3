Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1DBC4E4FC6
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 10:51:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243335AbiCWJxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 05:53:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiCWJxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 05:53:21 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 333B141310
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 02:51:50 -0700 (PDT)
Received: (Authenticated sender: clement.leger@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id AD23A1C000F;
        Wed, 23 Mar 2022 09:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1648029109;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HvflhV383HAbfw2gM+Fly4yDunR+NxERRhU6kf/8npo=;
        b=JO9uGtBzN+5S/FlMWzKAX5WmicEztGs40YBS0zkrQ3AWPNNp8O9dDsgQ9D/CI2Eed77b/X
        BNrdl2gtedMHI83x12hMzbtnwUVqeHjXryRrtMqpF9halSsgsG5Q3WQiLOydIQy74EnBzh
        +hjEzrWpQGr7BRLjH3kmfz82u5EGAC4eO7mLOK4vQCT4BjgUG3klgMKi9/lbSxqeddUEaE
        RqY5DLKxblDWqvIlPsF0x6J09Bgouej/qXSt7JQ2F4msa0QEDwO7QLv77X7XD8UEb8NNdm
        jmIeZf3Nm1U2Td6DSkH/aaOtpZXYP1v2miTIaYO1wNvsWeTRcaPZW5H+FzUblw==
From:   =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Allan Nielsen <allan.nielsen@microchip.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>
Subject: [PATCH 2/2] reset: add support for fwnode
Date:   Wed, 23 Mar 2022 10:50:22 +0100
Message-Id: <20220323095022.453708-3-clement.leger@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220323095022.453708-1-clement.leger@bootlin.com>
References: <20220323095022.453708-1-clement.leger@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to abstract the firmware node used by the reset subsystem,
switch to fwnode API. This will allow the subsystem to work with
all nodes that are supported by the fwnode API. ACPI node is for the
moment excluded from this support until the reset device description
is specified.

Existing device-tree support is kept and a fwnode_of_reset_xlate()
function has been added to translate fwnode reference args to a
device-tree spec for xlate function.

Signed-off-by: Clément Léger <clement.leger@bootlin.com>
---
 drivers/reset/core.c             | 91 ++++++++++++++++++++++++--------
 include/linux/reset-controller.h | 14 ++++-
 include/linux/reset.h            | 14 +++++
 3 files changed, 96 insertions(+), 23 deletions(-)

diff --git a/drivers/reset/core.c b/drivers/reset/core.c
index 61e688882643..f014da03b7c1 100644
--- a/drivers/reset/core.c
+++ b/drivers/reset/core.c
@@ -4,6 +4,7 @@
  *
  * Copyright 2013 Philipp Zabel, Pengutronix
  */
+#include <linux/acpi.h>
 #include <linux/atomic.h>
 #include <linux/device.h>
 #include <linux/err.h>
@@ -70,26 +71,49 @@ static const char *rcdev_name(struct reset_controller_dev *rcdev)
 	if (rcdev->of_node)
 		return rcdev->of_node->full_name;
 
+	if (rcdev->fwnode)
+		return fwnode_get_name(rcdev->fwnode);
+
 	return NULL;
 }
 
 /**
- * of_reset_simple_xlate - translate reset_spec to the reset line number
+ * fwnode_reset_simple_xlate - translate reset_spec to the reset line number
  * @rcdev: a pointer to the reset controller device
- * @reset_spec: reset line specifier as found in the device tree
+ * @rargs: fwnode reset line specifier
  *
- * This static translation function is used by default if of_xlate in
+ * This static translation function is used by default if fwnode_xlate in
  * :c:type:`reset_controller_dev` is not set. It is useful for all reset
  * controllers with 1:1 mapping, where reset lines can be indexed by number
  * without gaps.
  */
-static int of_reset_simple_xlate(struct reset_controller_dev *rcdev,
-				 const struct of_phandle_args *reset_spec)
+static int fwnode_reset_simple_xlate(struct reset_controller_dev *rcdev,
+				     const struct fwnode_reference_args *rargs)
 {
-	if (reset_spec->args[0] >= rcdev->nr_resets)
+	if (rargs->args[0] >= rcdev->nr_resets)
 		return -EINVAL;
 
-	return reset_spec->args[0];
+	return rargs->args[0];
+}
+
+/**
+ * fwnode_of_reset_xlate - convert fwnode reference args for of_xlate call
+ * @rcdev: a pointer to the reset controller device
+ * @rargs: fwnode reset line specifier
+ *
+ * This static translation function is used by default for fwnode_xlate if
+ * of_xlate in * :c:type:`reset_controller_dev` is set. It allows to keep
+ * compatibility with device-tree compatible reset drivers by converting the
+ * fwnode_reference_args to of_phandle_args and calling of_xlate.
+ */
+static int fwnode_of_reset_xlate(struct reset_controller_dev *rcdev,
+				 const struct fwnode_reference_args *rargs)
+{
+	struct of_phandle_args of_args;
+
+	of_phandle_args_from_fwnode_reference_args(&of_args, rargs);
+
+	return rcdev->of_xlate(rcdev, &of_args);
 }
 
 /**
@@ -98,9 +122,21 @@ static int of_reset_simple_xlate(struct reset_controller_dev *rcdev,
  */
 int reset_controller_register(struct reset_controller_dev *rcdev)
 {
-	if (!rcdev->of_xlate) {
-		rcdev->of_reset_n_cells = 1;
-		rcdev->of_xlate = of_reset_simple_xlate;
+	if (!rcdev->fwnode) {
+		rcdev->fwnode = of_fwnode_handle(rcdev->of_node);
+	} else {
+		if (is_acpi_node(rcdev->fwnode))
+			return -EINVAL;
+	}
+
+	if (rcdev->of_xlate) {
+		rcdev->fwnode_xlate = fwnode_of_reset_xlate;
+		rcdev->fwnode_reset_n_cells = rcdev->of_reset_n_cells;
+	}
+
+	if (!rcdev->fwnode_xlate) {
+		rcdev->fwnode_reset_n_cells = 1;
+		rcdev->fwnode_xlate = fwnode_reset_simple_xlate;
 	}
 
 	INIT_LIST_HEAD(&rcdev->reset_control_head);
@@ -810,29 +846,28 @@ static void __reset_control_put_internal(struct reset_control *rstc)
 }
 
 struct reset_control *
-__of_reset_control_get(struct device_node *node, const char *id, int index,
-		       bool shared, bool optional, bool acquired)
+__fwnode_reset_control_get(struct fwnode_handle *fwnode, const char *id,
+			   int index, bool shared, bool optional, bool acquired)
 {
 	struct reset_control *rstc;
 	struct reset_controller_dev *r, *rcdev;
-	struct of_phandle_args args;
+	struct fwnode_reference_args args;
 	int rstc_id;
 	int ret;
 
-	if (!node)
+	if (!fwnode || is_acpi_node(fwnode))
 		return ERR_PTR(-EINVAL);
 
 	if (id) {
-		index = of_property_match_string(node,
-						 "reset-names", id);
+		index = fwnode_property_match_string(fwnode, "reset-names", id);
 		if (index == -EILSEQ)
 			return ERR_PTR(index);
 		if (index < 0)
 			return optional ? NULL : ERR_PTR(-ENOENT);
 	}
 
-	ret = of_parse_phandle_with_args(node, "resets", "#reset-cells",
-					 index, &args);
+	ret = fwnode_property_get_reference_args(fwnode, "resets", "#reset-cells",
+						 0, index, &args);
 	if (ret == -EINVAL)
 		return ERR_PTR(ret);
 	if (ret)
@@ -841,7 +876,7 @@ __of_reset_control_get(struct device_node *node, const char *id, int index,
 	mutex_lock(&reset_list_mutex);
 	rcdev = NULL;
 	list_for_each_entry(r, &reset_controller_list, list) {
-		if (args.np == r->of_node) {
+		if (args.fwnode == r->fwnode) {
 			rcdev = r;
 			break;
 		}
@@ -852,12 +887,12 @@ __of_reset_control_get(struct device_node *node, const char *id, int index,
 		goto out;
 	}
 
-	if (WARN_ON(args.args_count != rcdev->of_reset_n_cells)) {
+	if (WARN_ON(args.nargs != rcdev->fwnode_reset_n_cells)) {
 		rstc = ERR_PTR(-EINVAL);
 		goto out;
 	}
 
-	rstc_id = rcdev->of_xlate(rcdev, &args);
+	rstc_id = rcdev->fwnode_xlate(rcdev, &args);
 	if (rstc_id < 0) {
 		rstc = ERR_PTR(rstc_id);
 		goto out;
@@ -868,10 +903,19 @@ __of_reset_control_get(struct device_node *node, const char *id, int index,
 
 out:
 	mutex_unlock(&reset_list_mutex);
-	of_node_put(args.np);
+	fwnode_handle_put(args.fwnode);
 
 	return rstc;
 }
+EXPORT_SYMBOL_GPL(__fwnode_reset_control_get);
+
+struct reset_control *
+__of_reset_control_get(struct device_node *node, const char *id, int index,
+		       bool shared, bool optional, bool acquired)
+{
+	return __fwnode_reset_control_get(of_fwnode_handle(node), id, index,
+					  shared, optional, acquired);
+}
 EXPORT_SYMBOL_GPL(__of_reset_control_get);
 
 static struct reset_controller_dev *
@@ -945,6 +989,9 @@ struct reset_control *__reset_control_get(struct device *dev, const char *id,
 	if (dev->of_node)
 		return __of_reset_control_get(dev->of_node, id, index, shared,
 					      optional, acquired);
+	if (dev_fwnode(dev))
+		return __fwnode_reset_control_get(dev_fwnode(dev), id, index,
+						  shared, optional, acquired);
 
 	return __reset_control_get_from_lookup(dev, id, shared, optional,
 					       acquired);
diff --git a/include/linux/reset-controller.h b/include/linux/reset-controller.h
index 0fa4f60e1186..292552003d11 100644
--- a/include/linux/reset-controller.h
+++ b/include/linux/reset-controller.h
@@ -24,7 +24,9 @@ struct reset_control_ops {
 
 struct module;
 struct device_node;
+struct fwnode_handle;
 struct of_phandle_args;
+struct fwnode_reference_args;
 
 /**
  * struct reset_control_lookup - represents a single lookup entry
@@ -60,10 +62,16 @@ struct reset_control_lookup {
  * @reset_control_head: head of internal list of requested reset controls
  * @dev: corresponding driver model device struct
  * @of_node: corresponding device tree node as phandle target
+ * @fwnode: corresponding firmware node as reference target
  * @of_reset_n_cells: number of cells in reset line specifiers
  * @of_xlate: translation function to translate from specifier as found in the
  *            device tree to id as given to the reset control ops, defaults
- *            to :c:func:`of_reset_simple_xlate`.
+ *            to :c:func:`fwnode_of_reset_xlate`.
+ * @fwnode_reset_n_cells: number of cells in reset line reference specifiers
+ * @fwnode_xlate: translation function to translate from reference specifier as
+ *                found in the firmware node description to id as given to the
+ *                reset control ops, defaults to
+ *                :c:func:`fwnode_reset_simple_xlate`.
  * @nr_resets: number of reset controls in this reset controller device
  */
 struct reset_controller_dev {
@@ -73,9 +81,13 @@ struct reset_controller_dev {
 	struct list_head reset_control_head;
 	struct device *dev;
 	struct device_node *of_node;
+	struct fwnode_handle *fwnode;
 	int of_reset_n_cells;
 	int (*of_xlate)(struct reset_controller_dev *rcdev,
 			const struct of_phandle_args *reset_spec);
+	int fwnode_reset_n_cells;
+	int (*fwnode_xlate)(struct reset_controller_dev *rcdev,
+			    const struct fwnode_reference_args *reset_spec);
 	unsigned int nr_resets;
 };
 
diff --git a/include/linux/reset.h b/include/linux/reset.h
index 8a21b5756c3e..0f0fe9408180 100644
--- a/include/linux/reset.h
+++ b/include/linux/reset.h
@@ -8,6 +8,7 @@
 
 struct device;
 struct device_node;
+struct fwnode_handle;
 struct reset_control;
 
 /**
@@ -41,6 +42,10 @@ int reset_control_bulk_deassert(int num_rstcs, struct reset_control_bulk_data *r
 int reset_control_bulk_acquire(int num_rstcs, struct reset_control_bulk_data *rstcs);
 void reset_control_bulk_release(int num_rstcs, struct reset_control_bulk_data *rstcs);
 
+struct reset_control *__fwnode_reset_control_get(struct fwnode_handle *node,
+						 const char *id, int index,
+						 bool shared, bool optional,
+						 bool acquired);
 struct reset_control *__of_reset_control_get(struct device_node *node,
 				     const char *id, int index, bool shared,
 				     bool optional, bool acquired);
@@ -114,6 +119,15 @@ static inline int __device_reset(struct device *dev, bool optional)
 	return optional ? 0 : -ENOTSUPP;
 }
 
+static inline
+struct reset_control *__fwnode_reset_control_get(struct fwnode_handle *node,
+						 const char *id, int index,
+						 bool shared, bool optional,
+						 bool acquired)
+{
+	return optional ? NULL : ERR_PTR(-ENOTSUPP);
+}
+
 static inline struct reset_control *__of_reset_control_get(
 					struct device_node *node,
 					const char *id, int index, bool shared,
-- 
2.34.1

