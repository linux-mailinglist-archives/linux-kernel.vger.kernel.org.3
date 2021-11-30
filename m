Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E2FC46340D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 13:19:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241520AbhK3MWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 07:22:36 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:55886 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241446AbhK3MWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 07:22:24 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1AUCIu6M126904;
        Tue, 30 Nov 2021 06:18:57 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1638274737;
        bh=o0/3UdOrEOM8reEefuRjI3hHTXU2KN+rnDTKAjnRaTE=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Lvqc5i6FF/9h/IRhy1NwdYTZ6cr3K9IhOpuHJMhqcjyY+6KlM466t/OT5daIV+ZfO
         0gRFj5wiRVPIphSpJNhnhSa83ZRsz60enFONuv6wyI3G2ut/hHldwExer/wpKyyP3n
         gaGK17+r0R1bxmTgaNlyTq6h5Hh0wWBMZPRlq4vs=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1AUCIunK103285
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 30 Nov 2021 06:18:56 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 30
 Nov 2021 06:18:56 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 30 Nov 2021 06:18:56 -0600
Received: from gsaswath-HP-ProBook-640-G5.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1AUCIliR058207;
        Tue, 30 Nov 2021 06:18:54 -0600
From:   Aswath Govindraju <a-govindraju@ti.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Peter Rosin <peda@axentia.se>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Aswath Govindraju <a-govindraju@ti.com>
Subject: [PATCH 2/2] mux: Add support for reading mux state from consumer DT node
Date:   Tue, 30 Nov 2021 17:48:47 +0530
Message-ID: <20211130121847.11112-3-a-govindraju@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211130121847.11112-1-a-govindraju@ti.com>
References: <20211130121847.11112-1-a-govindraju@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some cases, we might need to provide the state of the mux to be set for
the operation of a given peripheral. Therefore, pass this information using
mux-states property.

Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
---
 drivers/mux/core.c           | 213 +++++++++++++++++++++++++++++++----
 include/linux/mux/consumer.h |  19 +++-
 2 files changed, 212 insertions(+), 20 deletions(-)

diff --git a/drivers/mux/core.c b/drivers/mux/core.c
index 22f4709768d1..38869c3680a8 100644
--- a/drivers/mux/core.c
+++ b/drivers/mux/core.c
@@ -29,6 +29,19 @@
  */
 #define MUX_CACHE_UNKNOWN MUX_IDLE_AS_IS
 
+/**
+ * struct mux_state -	Represents a mux controller specific to a given device
+ * @mux:		Pointer to a mux controller
+ * @state		State of the mux to be set
+ *
+ * This structure is specific to a device that acquires it and has information
+ * specific to the device.
+ */
+struct mux_state {
+	struct mux_control *mux;
+	unsigned int state;
+};
+
 static struct class mux_class = {
 	.name = "mux",
 	.owner = THIS_MODULE,
@@ -370,6 +383,30 @@ int mux_control_select_delay(struct mux_control *mux, unsigned int state,
 }
 EXPORT_SYMBOL_GPL(mux_control_select_delay);
 
+/**
+ * mux_state_select_delay() - Select mux-state
+ * @mux: The mux-state to select
+ * @delay_us: The time to delay (in microseconds) if the mux control
+ *            changes state on select
+ *
+ * On successfully selecting the mux-state, it will be locked until
+ * there is a call to mux_state_deselect(). If the mux-control is already
+ * selected when mux_state_select() is called, the caller will be blocked
+ * until mux_state_deselect() is called (by someone else).
+ *
+ * Therefore, make sure to call mux_state_deselect() when the operation is
+ * complete and the mux-control is free for others to use, but do not call
+ * mux_state_deselect() if mux_state_select() fails.
+ *
+ * Return: 0 when the mux-state has been selected or a negative
+ * errno on error.
+ */
+int mux_state_select_delay(struct mux_state *mstate, unsigned int delay_us)
+{
+	return mux_control_select_delay(mstate->mux, mstate->state, delay_us);
+}
+EXPORT_SYMBOL_GPL(mux_state_select_delay);
+
 /**
  * mux_control_try_select_delay() - Try to select the given multiplexer state.
  * @mux: The mux-control to request a change of state from.
@@ -405,6 +442,27 @@ int mux_control_try_select_delay(struct mux_control *mux, unsigned int state,
 }
 EXPORT_SYMBOL_GPL(mux_control_try_select_delay);
 
+/**
+ * mux_state_try_select_delay() - Try to select the mux-state.
+ * @mux: The mux-state to select
+ * @delay_us: The time to delay (in microseconds) if the mux state is changed.
+ *
+ * On successfully selecting the mux-state, it will be locked until
+ * mux_state_deselect() called.
+ *
+ * Therefore, make sure to call mux_state_deselect() when the operation is
+ * complete and the mux-control is free for others to use, but do not call
+ * mux_state_deselect() if mux_state_try_select() fails.
+ *
+ * Return: 0 when the mux-control state has the requested state or a negative
+ * errno on error. Specifically -EBUSY if the mux-control is contended.
+ */
+int mux_state_try_select_delay(struct mux_state *mstate, unsigned int delay_us)
+{
+	return mux_control_try_select_delay(mstate->mux, mstate->state, delay_us);
+}
+EXPORT_SYMBOL_GPL(mux_state_try_select_delay);
+
 /**
  * mux_control_deselect() - Deselect the previously selected multiplexer state.
  * @mux: The mux-control to deselect.
@@ -431,6 +489,24 @@ int mux_control_deselect(struct mux_control *mux)
 }
 EXPORT_SYMBOL_GPL(mux_control_deselect);
 
+/**
+ * mux_state_deselect() - Deselect the previously selected multiplexer state.
+ * @mux: The mux-state to deselect.
+ *
+ * It is required that a single call is made to mux_state_deselect() for
+ * each and every successful call made to either of mux_state_select() or
+ * mux_state_try_select().
+ *
+ * Return: 0 on success and a negative errno on error. An error can only
+ * occur if the mux has an idle state. Note that even if an error occurs, the
+ * mux-control is unlocked and is thus free for the next access.
+ */
+int mux_state_deselect(struct mux_state *mstate)
+{
+	return mux_control_deselect(mstate->mux);
+}
+EXPORT_SYMBOL_GPL(mux_state_deselect);
+
 /* Note this function returns a reference to the mux_chip dev. */
 static struct mux_chip *of_find_mux_chip_by_node(struct device_node *np)
 {
@@ -442,13 +518,15 @@ static struct mux_chip *of_find_mux_chip_by_node(struct device_node *np)
 }
 
 /**
- * mux_control_get() - Get the mux-control for a device.
+ * mux_get() - Get the mux-control for a device.
  * @dev: The device that needs a mux-control.
  * @mux_name: The name identifying the mux-control.
+ * @state: The variable to store the enable state for the requested device
  *
  * Return: A pointer to the mux-control, or an ERR_PTR with a negative errno.
  */
-struct mux_control *mux_control_get(struct device *dev, const char *mux_name)
+static struct mux_control *mux_get(struct device *dev, const char *mux_name,
+				   unsigned int *state)
 {
 	struct device_node *np = dev->of_node;
 	struct of_phandle_args args;
@@ -458,8 +536,12 @@ struct mux_control *mux_control_get(struct device *dev, const char *mux_name)
 	int ret;
 
 	if (mux_name) {
-		index = of_property_match_string(np, "mux-control-names",
-						 mux_name);
+		if (state)
+			index = of_property_match_string(np, "mux-state-names",
+							 mux_name);
+		else
+			index = of_property_match_string(np, "mux-control-names",
+							 mux_name);
 		if (index < 0) {
 			dev_err(dev, "mux controller '%s' not found\n",
 				mux_name);
@@ -467,12 +549,17 @@ struct mux_control *mux_control_get(struct device *dev, const char *mux_name)
 		}
 	}
 
-	ret = of_parse_phandle_with_args(np,
-					 "mux-controls", "#mux-control-cells",
-					 index, &args);
+	if (state)
+		ret = of_parse_phandle_with_args(np,
+						 "mux-states", "#mux-state-cells",
+						 index, &args);
+	else
+		ret = of_parse_phandle_with_args(np,
+						 "mux-controls", "#mux-control-cells",
+						 index, &args);
 	if (ret) {
-		dev_err(dev, "%pOF: failed to get mux-control %s(%i)\n",
-			np, mux_name ?: "", index);
+		dev_err(dev, "%pOF: failed to get mux-%s %s(%i)\n",
+			np, state ? "state" : "control", mux_name ?: "", index);
 		return ERR_PTR(ret);
 	}
 
@@ -481,17 +568,35 @@ struct mux_control *mux_control_get(struct device *dev, const char *mux_name)
 	if (!mux_chip)
 		return ERR_PTR(-EPROBE_DEFER);
 
-	if (args.args_count > 1 ||
-	    (!args.args_count && (mux_chip->controllers > 1))) {
-		dev_err(dev, "%pOF: wrong #mux-control-cells for %pOF\n",
-			np, args.np);
-		put_device(&mux_chip->dev);
-		return ERR_PTR(-EINVAL);
-	}
-
 	controller = 0;
-	if (args.args_count)
-		controller = args.args[0];
+	if (state) {
+		if (args.args_count > 2 || args.args_count == 0 ||
+		    (args.args_count < 2 && mux_chip->controllers > 1)) {
+			dev_err(dev, "%pOF: wrong #mux-state-cells for %pOF\n",
+				np, args.np);
+			put_device(&mux_chip->dev);
+			return ERR_PTR(-EINVAL);
+		}
+
+		if (args.args_count == 2) {
+			controller = args.args[0];
+			*state = args.args[1];
+		} else {
+			*state = args.args[0];
+		}
+
+	} else {
+		if (args.args_count > 1 ||
+		    (!args.args_count && mux_chip->controllers > 1)) {
+			dev_err(dev, "%pOF: wrong #mux-control-cells for %pOF\n",
+				np, args.np);
+			put_device(&mux_chip->dev);
+			return ERR_PTR(-EINVAL);
+		}
+
+		if (args.args_count)
+			controller = args.args[0];
+	}
 
 	if (controller >= mux_chip->controllers) {
 		dev_err(dev, "%pOF: bad mux controller %u specified in %pOF\n",
@@ -502,6 +607,18 @@ struct mux_control *mux_control_get(struct device *dev, const char *mux_name)
 
 	return &mux_chip->mux[controller];
 }
+
+/**
+ * mux_control_get() - Get the mux-control for a device.
+ * @dev: The device that needs a mux-control.
+ * @mux_name: The name identifying the mux-control.
+ *
+ * Return: A pointer to the mux-control, or an ERR_PTR with a negative errno.
+ */
+struct mux_control *mux_control_get(struct device *dev, const char *mux_name)
+{
+	return mux_get(dev, mux_name, NULL);
+}
 EXPORT_SYMBOL_GPL(mux_control_get);
 
 /**
@@ -523,6 +640,26 @@ static void devm_mux_control_release(struct device *dev, void *res)
 	mux_control_put(mux);
 }
 
+/**
+ * mux_state_put() - Put away the mux-state for good.
+ * @mux: The mux-state to put away.
+ *
+ * mux_control_put() reverses the effects of mux_control_get().
+ */
+void mux_state_put(struct mux_state *mstate)
+{
+	mux_control_put(mstate->mux);
+	kfree(mstate);
+}
+EXPORT_SYMBOL_GPL(mux_state_put);
+
+static void devm_mux_state_release(struct device *dev, void *res)
+{
+	struct mux_state *mstate = *(struct mux_state **)res;
+
+	mux_state_put(mstate);
+}
+
 /**
  * devm_mux_control_get() - Get the mux-control for a device, with resource
  *			    management.
@@ -553,6 +690,44 @@ struct mux_control *devm_mux_control_get(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(devm_mux_control_get);
 
+/**
+ * devm_mux_state_get() - Get the mux-state for a device, with resource
+ *			  management.
+ * @dev: The device that needs a mux-control.
+ * @mux_name: The name identifying the mux-control.
+ *
+ * Return: Pointer to the mux-state, or an ERR_PTR with a negative errno.
+ */
+struct mux_state *devm_mux_state_get(struct device *dev,
+				     const char *mux_name)
+{
+	struct mux_state **ptr, *mstate;
+	struct mux_control *mux_ctrl;
+	int state;
+
+	mstate = devm_kzalloc(dev, sizeof(struct mux_state), GFP_KERNEL);
+	if (!mstate)
+		return ERR_PTR(-ENOMEM);
+
+	ptr = devres_alloc(devm_mux_state_release, sizeof(*ptr), GFP_KERNEL);
+	if (!ptr)
+		return ERR_PTR(-ENOMEM);
+
+	mux_ctrl = mux_get(dev, mux_name, &state);
+	if (IS_ERR(mux_ctrl)) {
+		devres_free(ptr);
+		return (struct mux_state *)mux_ctrl;
+	}
+
+	mstate->mux = mux_ctrl;
+	mstate->state = state;
+	*ptr = mstate;
+	devres_add(dev, ptr);
+
+	return mstate;
+}
+EXPORT_SYMBOL_GPL(devm_mux_state_get);
+
 /*
  * Using subsys_initcall instead of module_init here to try to ensure - for
  * the non-modular case - that the subsystem is initialized when mux consumers
diff --git a/include/linux/mux/consumer.h b/include/linux/mux/consumer.h
index 7a09b040ac39..bf5abf062c21 100644
--- a/include/linux/mux/consumer.h
+++ b/include/linux/mux/consumer.h
@@ -14,33 +14,50 @@
 
 struct device;
 struct mux_control;
+struct mux_state;
 
 unsigned int mux_control_states(struct mux_control *mux);
 int __must_check mux_control_select_delay(struct mux_control *mux,
 					  unsigned int state,
 					  unsigned int delay_us);
+int __must_check mux_state_select_delay(struct mux_state *mstate,
+					unsigned int delay_us);
 int __must_check mux_control_try_select_delay(struct mux_control *mux,
 					      unsigned int state,
 					      unsigned int delay_us);
-
+int __must_check mux_state_try_select_delay(struct mux_state *mstate,
+					    unsigned int delay_us);
 static inline int __must_check mux_control_select(struct mux_control *mux,
 						  unsigned int state)
 {
 	return mux_control_select_delay(mux, state, 0);
 }
 
+static inline int __must_check mux_state_select(struct mux_state *mstate)
+{
+	return mux_state_select_delay(mstate, 0);
+}
 static inline int __must_check mux_control_try_select(struct mux_control *mux,
 						      unsigned int state)
 {
 	return mux_control_try_select_delay(mux, state, 0);
 }
 
+static inline int __must_check mux_state_try_select(struct mux_state *mstate)
+{
+	return mux_state_try_select_delay(mstate, 0);
+}
+
 int mux_control_deselect(struct mux_control *mux);
+int mux_state_deselect(struct mux_state *mstate);
 
 struct mux_control *mux_control_get(struct device *dev, const char *mux_name);
 void mux_control_put(struct mux_control *mux);
+void mux_state_put(struct mux_state *mstate);
 
 struct mux_control *devm_mux_control_get(struct device *dev,
 					 const char *mux_name);
+struct mux_state *devm_mux_state_get(struct device *dev,
+				     const char *mux_name);
 
 #endif /* _LINUX_MUX_CONSUMER_H */
-- 
2.17.1

