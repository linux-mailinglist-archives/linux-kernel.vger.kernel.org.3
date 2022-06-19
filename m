Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76A9B550AFC
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 15:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237351AbiFSNiS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 09:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237170AbiFSNh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 09:37:59 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 757C3DE95
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 06:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655645877; x=1687181877;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VEcol91HHatbAdggIPVidGRxtzkco7BB3Y66a8iLdes=;
  b=UnT9NrMG4wQ3lPXcvMRL/0D/+QeXxTYsb4zifqYjbpkFynqomClFsT9G
   IrnbgqgiinM518mVXc/MwEelGHFdMdDmqbp7lZ4o3EzNUHUB1sKmpflE+
   Kgj3Z0OHE+a1Va4XLK94hD/QvdgwwBsbVW9BCcBsNA6oKtctMuMqLAnzV
   QdLYcziwTcL6eqmA+xJlgu1wlVxx/12SLfZzUOaHuEekmqopw8B5Zziwb
   ZvGvTj7hDIDCVFCiPify5ppCjBiq5M4xYyomskJCLE4cNKqlqlBh8v2zZ
   UkNgvQNP5wXr9pxhD9liob2oNqkK/cbVe2K42q1Hq8egip0CjxYOiOW/i
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="305164703"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="305164703"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2022 06:37:55 -0700
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="676158527"
Received: from sannilnx.jer.intel.com ([10.12.26.157])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2022 06:37:52 -0700
From:   Alexander Usyskin <alexander.usyskin@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Cc:     Tomas Winkler <tomas.winkler@intel.com>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        Vitaly Lubart <vitaly.lubart@intel.com>,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        James Ausmus <james.ausmus@intel.com>
Subject: [PATCH v3 06/14] mei: gsc: use polling instead of interrupts
Date:   Sun, 19 Jun 2022 16:37:13 +0300
Message-Id: <20220619133721.523546-7-alexander.usyskin@intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220619133721.523546-1-alexander.usyskin@intel.com>
References: <20220619133721.523546-1-alexander.usyskin@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomas Winkler <tomas.winkler@intel.com>

A work-around for a HW issue in XEHPSDV that manifests itself when SW reads
a gsc register when gsc is sending an interrupt. The work-around is
to disable interrupts and to use polling instead.

Cc: James Ausmus <james.ausmus@intel.com>
Signed-off-by: Vitaly Lubart <vitaly.lubart@intel.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/misc/mei/gsc-me.c | 48 ++++++++++++++++++++++++++------
 drivers/misc/mei/hw-me.c  | 58 ++++++++++++++++++++++++++++++++++++---
 drivers/misc/mei/hw-me.h  | 12 ++++++++
 3 files changed, 105 insertions(+), 13 deletions(-)

diff --git a/drivers/misc/mei/gsc-me.c b/drivers/misc/mei/gsc-me.c
index c8145e9b62b6..2caba3a9ac35 100644
--- a/drivers/misc/mei/gsc-me.c
+++ b/drivers/misc/mei/gsc-me.c
@@ -13,6 +13,7 @@
 #include <linux/ktime.h>
 #include <linux/delay.h>
 #include <linux/pm_runtime.h>
+#include <linux/kthread.h>
 
 #include "mei_dev.h"
 #include "hw-me.h"
@@ -66,13 +67,28 @@ static int mei_gsc_probe(struct auxiliary_device *aux_dev,
 
 	dev_set_drvdata(device, dev);
 
-	ret = devm_request_threaded_irq(device, hw->irq,
-					mei_me_irq_quick_handler,
-					mei_me_irq_thread_handler,
-					IRQF_ONESHOT, KBUILD_MODNAME, dev);
-	if (ret) {
-		dev_err(device, "irq register failed %d\n", ret);
-		goto err;
+	/* use polling */
+	if (mei_me_hw_use_polling(hw)) {
+		mei_disable_interrupts(dev);
+		mei_clear_interrupts(dev);
+		init_waitqueue_head(&hw->wait_active);
+		hw->is_active = true; /* start in active mode for initialization */
+		hw->polling_thread = kthread_run(mei_me_polling_thread, dev,
+						 "kmegscirqd/%s", dev_name(device));
+		if (IS_ERR(hw->polling_thread)) {
+			ret = PTR_ERR(hw->polling_thread);
+			dev_err(device, "unable to create kernel thread: %d\n", ret);
+			goto err;
+		}
+	} else {
+		ret = devm_request_threaded_irq(device, hw->irq,
+						mei_me_irq_quick_handler,
+						mei_me_irq_thread_handler,
+						IRQF_ONESHOT, KBUILD_MODNAME, dev);
+		if (ret) {
+			dev_err(device, "irq register failed %d\n", ret);
+			goto err;
+		}
 	}
 
 	pm_runtime_get_noresume(device);
@@ -98,7 +114,8 @@ static int mei_gsc_probe(struct auxiliary_device *aux_dev,
 
 register_err:
 	mei_stop(dev);
-	devm_free_irq(device, hw->irq, dev);
+	if (!mei_me_hw_use_polling(hw))
+		devm_free_irq(device, hw->irq, dev);
 
 err:
 	dev_err(device, "probe failed: %d\n", ret);
@@ -119,12 +136,17 @@ static void mei_gsc_remove(struct auxiliary_device *aux_dev)
 
 	mei_stop(dev);
 
+	hw = to_me_hw(dev);
+	if (mei_me_hw_use_polling(hw))
+		kthread_stop(hw->polling_thread);
+
 	mei_deregister(dev);
 
 	pm_runtime_disable(&aux_dev->dev);
 
 	mei_disable_interrupts(dev);
-	devm_free_irq(&aux_dev->dev, hw->irq, dev);
+	if (!mei_me_hw_use_polling(hw))
+		devm_free_irq(&aux_dev->dev, hw->irq, dev);
 }
 
 static int __maybe_unused mei_gsc_pm_suspend(struct device *device)
@@ -185,6 +207,9 @@ static int  __maybe_unused mei_gsc_pm_runtime_suspend(struct device *device)
 	if (mei_write_is_idle(dev)) {
 		hw = to_me_hw(dev);
 		hw->pg_state = MEI_PG_ON;
+
+		if (mei_me_hw_use_polling(hw))
+			hw->is_active = false;
 		ret = 0;
 	} else {
 		ret = -EAGAIN;
@@ -209,6 +234,11 @@ static int __maybe_unused mei_gsc_pm_runtime_resume(struct device *device)
 	hw = to_me_hw(dev);
 	hw->pg_state = MEI_PG_OFF;
 
+	if (mei_me_hw_use_polling(hw)) {
+		hw->is_active = true;
+		wake_up(&hw->wait_active);
+	}
+
 	mutex_unlock(&dev->device_lock);
 
 	irq_ret = mei_me_irq_thread_handler(1, dev);
diff --git a/drivers/misc/mei/hw-me.c b/drivers/misc/mei/hw-me.c
index 9870bf717979..959b3329af60 100644
--- a/drivers/misc/mei/hw-me.c
+++ b/drivers/misc/mei/hw-me.c
@@ -10,6 +10,7 @@
 #include <linux/interrupt.h>
 #include <linux/pm_runtime.h>
 #include <linux/sizes.h>
+#include <linux/delay.h>
 
 #include "mei_dev.h"
 #include "hbm.h"
@@ -327,9 +328,12 @@ static void mei_me_intr_clear(struct mei_device *dev)
  */
 static void mei_me_intr_enable(struct mei_device *dev)
 {
-	u32 hcsr = mei_hcsr_read(dev);
+	u32 hcsr;
+
+	if (mei_me_hw_use_polling(to_me_hw(dev)))
+		return;
 
-	hcsr |= H_CSR_IE_MASK;
+	hcsr = mei_hcsr_read(dev) | H_CSR_IE_MASK;
 	mei_hcsr_set(dev, hcsr);
 }
 
@@ -354,6 +358,9 @@ static void mei_me_synchronize_irq(struct mei_device *dev)
 {
 	struct mei_me_hw *hw = to_me_hw(dev);
 
+	if (mei_me_hw_use_polling(hw))
+		return;
+
 	synchronize_irq(hw->irq);
 }
 
@@ -380,7 +387,10 @@ static void mei_me_host_set_ready(struct mei_device *dev)
 {
 	u32 hcsr = mei_hcsr_read(dev);
 
-	hcsr |= H_CSR_IE_MASK | H_IG | H_RDY;
+	if (!mei_me_hw_use_polling(to_me_hw(dev)))
+		hcsr |= H_CSR_IE_MASK;
+
+	hcsr |=  H_IG | H_RDY;
 	mei_hcsr_set(dev, hcsr);
 }
 
@@ -1174,7 +1184,7 @@ static int mei_me_hw_reset(struct mei_device *dev, bool intr_enable)
 
 	hcsr |= H_RST | H_IG | H_CSR_IS_MASK;
 
-	if (!intr_enable)
+	if (!intr_enable || mei_me_hw_use_polling(to_me_hw(dev)))
 		hcsr &= ~H_CSR_IE_MASK;
 
 	dev->recvd_hw_ready = false;
@@ -1329,6 +1339,46 @@ irqreturn_t mei_me_irq_thread_handler(int irq, void *dev_id)
 }
 EXPORT_SYMBOL_GPL(mei_me_irq_thread_handler);
 
+#define MEI_POLLING_TIMEOUT_ACTIVE 100
+#define MEI_POLLING_TIMEOUT_IDLE   500
+
+int mei_me_polling_thread(void *_dev)
+{
+	struct mei_device *dev = _dev;
+	irqreturn_t irq_ret;
+	long polling_timeout = MEI_POLLING_TIMEOUT_ACTIVE;
+
+	dev_dbg(dev->dev, "kernel thread is running\n");
+	while (!kthread_should_stop()) {
+		struct mei_me_hw *hw = to_me_hw(dev);
+		u32 hcsr;
+
+		wait_event_timeout(hw->wait_active,
+				   hw->is_active || kthread_should_stop(),
+				   msecs_to_jiffies(MEI_POLLING_TIMEOUT_IDLE));
+
+		if (kthread_should_stop())
+			break;
+
+		hcsr = mei_hcsr_read(dev);
+		if (me_intr_src(hcsr)) {
+			polling_timeout = MEI_POLLING_TIMEOUT_ACTIVE;
+			irq_ret = mei_me_irq_thread_handler(1, dev);
+			if (irq_ret != IRQ_HANDLED)
+				dev_err(dev->dev, "irq_ret %d\n", irq_ret);
+		} else {
+			polling_timeout = clamp_val(polling_timeout + MEI_POLLING_TIMEOUT_ACTIVE,
+						    MEI_POLLING_TIMEOUT_ACTIVE,
+						    MEI_POLLING_TIMEOUT_IDLE);
+		}
+
+		schedule_timeout_interruptible(msecs_to_jiffies(polling_timeout));
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mei_me_polling_thread);
+
 static const struct mei_hw_ops mei_me_hw_ops = {
 
 	.trc_status = mei_me_trc_status,
diff --git a/drivers/misc/mei/hw-me.h b/drivers/misc/mei/hw-me.h
index a071c645e905..ca09274ac299 100644
--- a/drivers/misc/mei/hw-me.h
+++ b/drivers/misc/mei/hw-me.h
@@ -51,6 +51,8 @@ struct mei_cfg {
  * @d0i3_supported: di03 support
  * @hbuf_depth: depth of hardware host/write buffer in slots
  * @read_fws: read FW status register handler
+ * @wait_active: the polling thread activity wait queue
+ * @is_active: the device is active
  */
 struct mei_me_hw {
 	const struct mei_cfg *cfg;
@@ -60,10 +62,19 @@ struct mei_me_hw {
 	bool d0i3_supported;
 	u8 hbuf_depth;
 	int (*read_fws)(const struct mei_device *dev, int where, u32 *val);
+	/* polling */
+	struct task_struct *polling_thread;
+	wait_queue_head_t wait_active;
+	bool is_active;
 };
 
 #define to_me_hw(dev) (struct mei_me_hw *)((dev)->hw)
 
+static inline bool mei_me_hw_use_polling(const struct mei_me_hw *hw)
+{
+	return hw->irq < 0;
+}
+
 /**
  * enum mei_cfg_idx - indices to platform specific configurations.
  *
@@ -127,5 +138,6 @@ int mei_me_pg_exit_sync(struct mei_device *dev);
 
 irqreturn_t mei_me_irq_quick_handler(int irq, void *dev_id);
 irqreturn_t mei_me_irq_thread_handler(int irq, void *dev_id);
+int mei_me_polling_thread(void *_dev);
 
 #endif /* _MEI_INTERFACE_H_ */
-- 
2.32.0

