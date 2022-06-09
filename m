Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF77544DF4
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 15:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244514AbiFINn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 09:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343936AbiFINnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 09:43:50 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ECF349937;
        Thu,  9 Jun 2022 06:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1654782228; x=1686318228;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=1WVkXl50t9Il/XMHdciZY20302TmK7LTbudpy4UwY60=;
  b=BNl3wIER9X8oI2gNJg6YR5401PoX5sh8H92nONGOkeGWAtT5aiMhDsjY
   KdxwhMOMKVplDqekBVaR1hYdnnCg896Xe25loGN33Bb+d8I5IvRN8Hjdg
   vz79BkNAJf921HTWklJIZDsfBt1xzFJ56nWWc/gKyhAiK2r8jLVcj69A2
   s=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 09 Jun 2022 06:43:48 -0700
X-QCInternal: smtphost
Received: from unknown (HELO nasanex01a.na.qualcomm.com) ([10.52.223.231])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2022 06:43:47 -0700
Received: from cbsp-sh-gv.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 9 Jun 2022 06:43:45 -0700
From:   Qiang Yu <quic_qianyu@quicinc.com>
To:     <mani@kernel.org>, <quic_hemantk@quicinc.com>,
        <loic.poulain@linaro.org>
CC:     <mhi@lists.linux.dev>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Qiang Yu <quic_qianyu@quicinc.com>
Subject: [PATCH] bus: mhi: Disable IRQs instead of freeing them during power down
Date:   Thu, 9 Jun 2022 21:43:35 +0800
Message-ID: <1654782215-70383-1-git-send-email-quic_qianyu@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

EP tends to read MSI address/data once and cache them after BME is set.
So host should avoid changing MSI address/data after BME is set.

In pci reset function, host invokes free_irq(), which also clears MSI
address/data in EP's PCIe config space. If the invalid address/data
are cached and used by EP, MSI triggered by EP wouldn't be received by
host, because an invalid MSI data is sent to an invalid MSI address.

To fix this issue, after host runs request_irq() successfully during
mhi driver probe, let's invoke enable_irq()/disable_irq() instead of
request_irq()/free_irq() when we want to power on and power down MHI.
Meanwhile, Host should invoke free_irq() when mhi host driver is
removed.

Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
---
 drivers/bus/mhi/host/init.c        | 31 +++++++++++++++++++++++++++++++
 drivers/bus/mhi/host/pci_generic.c |  2 ++
 drivers/bus/mhi/host/pm.c          |  4 ++--
 3 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/drivers/bus/mhi/host/init.c b/drivers/bus/mhi/host/init.c
index cbb86b2..48cb093 100644
--- a/drivers/bus/mhi/host/init.c
+++ b/drivers/bus/mhi/host/init.c
@@ -18,6 +18,7 @@
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 #include <linux/wait.h>
+#include <linux/irq.h>
 #include "internal.h"
 
 static DEFINE_IDA(mhi_controller_ida);
@@ -168,6 +169,22 @@ int mhi_init_irq_setup(struct mhi_controller *mhi_cntrl)
 	unsigned long irq_flags = IRQF_SHARED | IRQF_NO_SUSPEND;
 	int i, ret;
 
+	/*
+	 * if irq[0] has action, it represents all MSI IRQs have been
+	 * requested, so we just need to enable them.
+	 */
+	if (irq_has_action(mhi_cntrl->irq[0])) {
+		enable_irq(mhi_cntrl->irq[0]);
+
+		for (i = 0; i < mhi_cntrl->total_ev_rings; i++, mhi_event++) {
+			if (mhi_event->offload_ev)
+				continue;
+
+			enable_irq(mhi_cntrl->irq[mhi_event->irq]);
+		}
+		return 0;
+	}
+
 	/* if controller driver has set irq_flags, use it */
 	if (mhi_cntrl->irq_flags)
 		irq_flags = mhi_cntrl->irq_flags;
@@ -179,6 +196,11 @@ int mhi_init_irq_setup(struct mhi_controller *mhi_cntrl)
 				   "bhi", mhi_cntrl);
 	if (ret)
 		return ret;
+	/*
+	 * IRQ marked IRQF_SHARED isn't recommended to use IRQ_NOAUTOEN,
+	 * so disable it explicitly.
+	 */
+	disable_irq(mhi_cntrl->irq[0]);
 
 	for (i = 0; i < mhi_cntrl->total_ev_rings; i++, mhi_event++) {
 		if (mhi_event->offload_ev)
@@ -200,6 +222,8 @@ int mhi_init_irq_setup(struct mhi_controller *mhi_cntrl)
 				mhi_cntrl->irq[mhi_event->irq], i);
 			goto error_request;
 		}
+
+		disable_irq(mhi_cntrl->irq[mhi_event->irq]);
 	}
 
 	return 0;
@@ -1003,8 +1027,14 @@ int mhi_register_controller(struct mhi_controller *mhi_cntrl,
 
 	mhi_create_debugfs(mhi_cntrl);
 
+	ret = mhi_init_irq_setup(mhi_cntrl);
+	if (ret)
+		goto error_setup_irq;
+
 	return 0;
 
+error_setup_irq:
+	mhi_destroy_debugfs(mhi_cntrl);
 err_release_dev:
 	put_device(&mhi_dev->dev);
 err_ida_free:
@@ -1027,6 +1057,7 @@ void mhi_unregister_controller(struct mhi_controller *mhi_cntrl)
 	struct mhi_chan *mhi_chan = mhi_cntrl->mhi_chan;
 	unsigned int i;
 
+	mhi_deinit_free_irq(mhi_cntrl);
 	mhi_destroy_debugfs(mhi_cntrl);
 
 	destroy_workqueue(mhi_cntrl->hiprio_wq);
diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/host/pci_generic.c
index 6fbc591..60020d0 100644
--- a/drivers/bus/mhi/host/pci_generic.c
+++ b/drivers/bus/mhi/host/pci_generic.c
@@ -945,6 +945,8 @@ static void mhi_pci_remove(struct pci_dev *pdev)
 
 	mhi_unregister_controller(mhi_cntrl);
 	pci_disable_pcie_error_reporting(pdev);
+
+	pci_free_irq_vectors(pdev);
 }
 
 static void mhi_pci_shutdown(struct pci_dev *pdev)
diff --git a/drivers/bus/mhi/host/pm.c b/drivers/bus/mhi/host/pm.c
index dc2e8ff..190231c 100644
--- a/drivers/bus/mhi/host/pm.c
+++ b/drivers/bus/mhi/host/pm.c
@@ -500,7 +500,7 @@ static void mhi_pm_disable_transition(struct mhi_controller *mhi_cntrl)
 	for (i = 0; i < mhi_cntrl->total_ev_rings; i++, mhi_event++) {
 		if (mhi_event->offload_ev)
 			continue;
-		free_irq(mhi_cntrl->irq[mhi_event->irq], mhi_event);
+		disable_irq(mhi_cntrl->irq[mhi_event->irq]);
 		tasklet_kill(&mhi_event->task);
 	}
 
@@ -1182,7 +1182,7 @@ void mhi_power_down(struct mhi_controller *mhi_cntrl, bool graceful)
 	/* Wait for shutdown to complete */
 	flush_work(&mhi_cntrl->st_worker);
 
-	free_irq(mhi_cntrl->irq[0], mhi_cntrl);
+	disable_irq(mhi_cntrl->irq[0]);
 }
 EXPORT_SYMBOL_GPL(mhi_power_down);
 
-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

