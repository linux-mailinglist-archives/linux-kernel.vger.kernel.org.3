Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A32A4B3D55
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 21:15:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238156AbiBMUP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 15:15:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238137AbiBMUPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 15:15:22 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 357FC532E0;
        Sun, 13 Feb 2022 12:15:16 -0800 (PST)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 21DKCosm017979;
        Sun, 13 Feb 2022 14:12:50 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1644783170;
        bh=Hezq1HwvYvPdObXSVdr7ef8Fd0u4XHVQ/eNP2Clqhcc=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=abLnosUpx9EuhKJ7qvhQNs81vZEHNTeYOEtxe+e2ESxz86W3TGf8ubqndBtuphkVe
         LfXzHSrCk5ITFVLfK51r7NWoJrLLmWN22ISsdr2rU9opihLoyhxGJGaQeN+r4OWiZ5
         c8klYqOBYWHbBEOrkczu0+4saQilPNQ51i4T/N/s=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 21DKCnwF065517
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 13 Feb 2022 14:12:50 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Sun, 13
 Feb 2022 14:12:49 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Sun, 13 Feb 2022 14:12:49 -0600
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 21DKCnhj022115;
        Sun, 13 Feb 2022 14:12:49 -0600
Received: from localhost ([10.249.37.221])
        by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 21DKCnQf002424;
        Sun, 13 Feb 2022 14:12:49 -0600
From:   Suman Anna <s-anna@ti.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     Hari Nagalla <hnagalla@ti.com>, Praneeth Bajjuri <praneeth@ti.com>,
        <linux-remoteproc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Suman Anna <s-anna@ti.com>
Subject: [PATCH v3 5/5] remoteproc: k3-dsp: Add support for IPC-only mode for all K3 DSPs
Date:   Sun, 13 Feb 2022 14:12:46 -0600
Message-ID: <20220213201246.25952-6-s-anna@ti.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220213201246.25952-1-s-anna@ti.com>
References: <20220213201246.25952-1-s-anna@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support to the K3 DSP remoteproc driver to configure all the C66x
and C71x cores on J721E SoCs to be either in IPC-only mode or the
traditional remoteproc mode. The IPC-only mode expects that the remote
processors are already booted by the bootloader, and only perform the
minimum steps required to initialize and deinitialize the virtio IPC
transports. The remoteproc mode allows the kernel remoteproc driver to
do the regular load and boot and other device management operations for
a DSP.

The IPC-only mode for a DSP is detected and configured at driver probe
time by querying the System Firmware for the DSP power and reset state
and/or status and making sure that the DSP is indeed started by the
bootloaders, otherwise the device is configured for remoteproc mode.

Support for IPC-only mode is achieved through .attach(), .detach() and
.get_loaded_rsc_table() callback ops and zeroing out the regular rproc
ops .prepare(), .unprepare(), .start() and .stop(). The resource table
follows a design-by-contract approach and is expected to be at the base
of the DDR firmware region reserved for each remoteproc, it is mostly
expected to contain only the virtio device and trace resource entries.

NOTE:
The driver cannot configure a DSP core for remoteproc mode by any
means without rebooting the kernel if that DSP core has been started
by a bootloader.  This is the current desired behavior and can be
enhanced in the future if the feature is needed.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
v3: Revised version of v2 patch adjusted for dropping v2 Patch 1
 - Added rproc_detach logic in k3_dsp_rproc_remove() before invoking
   rproc_del()
v2: https://patchwork.kernel.org/project/linux-remoteproc/patch/20210723220248.6554-6-s-anna@ti.com/
v1: https://patchwork.kernel.org/project/linux-remoteproc/patch/20210522000309.26134-7-s-anna@ti.com/

 drivers/remoteproc/ti_k3_dsp_remoteproc.c | 141 +++++++++++++++++++---
 1 file changed, 124 insertions(+), 17 deletions(-)

diff --git a/drivers/remoteproc/ti_k3_dsp_remoteproc.c b/drivers/remoteproc/ti_k3_dsp_remoteproc.c
index b3ee03da5569..eb9c64f7b9b4 100644
--- a/drivers/remoteproc/ti_k3_dsp_remoteproc.c
+++ b/drivers/remoteproc/ti_k3_dsp_remoteproc.c
@@ -260,7 +260,8 @@ static int k3_dsp_rproc_request_mbox(struct rproc *rproc)
  * used to release the global reset on C66x DSPs to allow loading into the DSP
  * internal RAMs. The .prepare() ops is invoked by remoteproc core before any
  * firmware loading, and is followed by the .start() ops after loading to
- * actually let the C66x DSP cores run.
+ * actually let the C66x DSP cores run. This callback is invoked only in
+ * remoteproc mode.
  */
 static int k3_dsp_rproc_prepare(struct rproc *rproc)
 {
@@ -284,7 +285,7 @@ static int k3_dsp_rproc_prepare(struct rproc *rproc)
  * powering down the C66x DSP cores. The cores themselves are only halted in the
  * .stop() callback through the local reset, and the .unprepare() ops is invoked
  * by the remoteproc core after the remoteproc is stopped to balance the global
- * reset.
+ * reset. This callback is invoked only in remoteproc mode.
  */
 static int k3_dsp_rproc_unprepare(struct rproc *rproc)
 {
@@ -305,7 +306,7 @@ static int k3_dsp_rproc_unprepare(struct rproc *rproc)
  *
  * This function will be invoked only after the firmware for this rproc
  * was loaded, parsed successfully, and all of its resource requirements
- * were met.
+ * were met. This callback is invoked only in remoteproc mode.
  */
 static int k3_dsp_rproc_start(struct rproc *rproc)
 {
@@ -346,7 +347,7 @@ static int k3_dsp_rproc_start(struct rproc *rproc)
  * Stop the DSP remote processor.
  *
  * This function puts the DSP processor into reset, and finishes processing
- * of any pending messages.
+ * of any pending messages. This callback is invoked only in remoteproc mode.
  */
 static int k3_dsp_rproc_stop(struct rproc *rproc)
 {
@@ -359,6 +360,78 @@ static int k3_dsp_rproc_stop(struct rproc *rproc)
 	return 0;
 }
 
+/*
+ * Attach to a running DSP remote processor (IPC-only mode)
+ *
+ * This rproc attach callback only needs to request the mailbox, the remote
+ * processor is already booted, so there is no need to issue any TI-SCI
+ * commands to boot the DSP core. This callback is invoked only in IPC-only
+ * mode.
+ */
+static int k3_dsp_rproc_attach(struct rproc *rproc)
+{
+	struct k3_dsp_rproc *kproc = rproc->priv;
+	struct device *dev = kproc->dev;
+	int ret;
+
+	ret = k3_dsp_rproc_request_mbox(rproc);
+	if (ret)
+		return ret;
+
+	dev_info(dev, "DSP initialized in IPC-only mode\n");
+	return 0;
+}
+
+/*
+ * Detach from a running DSP remote processor (IPC-only mode)
+ *
+ * This rproc detach callback performs the opposite operation to attach callback
+ * and only needs to release the mailbox, the DSP core is not stopped and will
+ * be left to continue to run its booted firmware. This callback is invoked only
+ * in IPC-only mode.
+ */
+static int k3_dsp_rproc_detach(struct rproc *rproc)
+{
+	struct k3_dsp_rproc *kproc = rproc->priv;
+	struct device *dev = kproc->dev;
+
+	mbox_free_channel(kproc->mbox);
+	dev_info(dev, "DSP deinitialized in IPC-only mode\n");
+	return 0;
+}
+
+/*
+ * This function implements the .get_loaded_rsc_table() callback and is used
+ * to provide the resource table for a booted DSP in IPC-only mode. The K3 DSP
+ * firmwares follow a design-by-contract approach and are expected to have the
+ * resource table at the base of the DDR region reserved for firmware usage.
+ * This provides flexibility for the remote processor to be booted by different
+ * bootloaders that may or may not have the ability to publish the resource table
+ * address and size through a DT property. This callback is invoked only in
+ * IPC-only mode.
+ */
+static struct resource_table *k3_dsp_get_loaded_rsc_table(struct rproc *rproc,
+							  size_t *rsc_table_sz)
+{
+	struct k3_dsp_rproc *kproc = rproc->priv;
+	struct device *dev = kproc->dev;
+
+	if (!kproc->rmem[0].cpu_addr) {
+		dev_err(dev, "memory-region #1 does not exist, loaded rsc table can't be found");
+		return ERR_PTR(-ENOMEM);
+	}
+
+	/*
+	 * NOTE: The resource table size is currently hard-coded to a maximum
+	 * of 256 bytes. The most common resource table usage for K3 firmwares
+	 * is to only have the vdev resource entry and an optional trace entry.
+	 * The exact size could be computed based on resource table address, but
+	 * the hard-coded value suffices to support the IPC-only mode.
+	 */
+	*rsc_table_sz = 256;
+	return (struct resource_table *)kproc->rmem[0].cpu_addr;
+}
+
 /*
  * Custom function to translate a DSP device address (internal RAMs only) to a
  * kernel virtual address.  The DSPs can access their RAMs at either an internal
@@ -605,6 +678,7 @@ static int k3_dsp_rproc_probe(struct platform_device *pdev)
 	struct k3_dsp_rproc *kproc;
 	struct rproc *rproc;
 	const char *fw_name;
+	bool p_state = false;
 	int ret = 0;
 	int ret1;
 
@@ -683,19 +757,43 @@ static int k3_dsp_rproc_probe(struct platform_device *pdev)
 		goto release_tsp;
 	}
 
-	/*
-	 * ensure the DSP local reset is asserted to ensure the DSP doesn't
-	 * execute bogus code in .prepare() when the module reset is released.
-	 */
-	if (data->uses_lreset) {
-		ret = reset_control_status(kproc->reset);
-		if (ret < 0) {
-			dev_err(dev, "failed to get reset status, status = %d\n",
-				ret);
-			goto release_mem;
-		} else if (ret == 0) {
-			dev_warn(dev, "local reset is deasserted for device\n");
-			k3_dsp_rproc_reset(kproc);
+	ret = kproc->ti_sci->ops.dev_ops.is_on(kproc->ti_sci, kproc->ti_sci_id,
+					       NULL, &p_state);
+	if (ret) {
+		dev_err(dev, "failed to get initial state, mode cannot be determined, ret = %d\n",
+			ret);
+		goto release_mem;
+	}
+
+	/* configure J721E devices for either remoteproc or IPC-only mode */
+	if (p_state) {
+		dev_info(dev, "configured DSP for IPC-only mode\n");
+		rproc->state = RPROC_DETACHED;
+		/* override rproc ops with only required IPC-only mode ops */
+		rproc->ops->prepare = NULL;
+		rproc->ops->unprepare = NULL;
+		rproc->ops->start = NULL;
+		rproc->ops->stop = NULL;
+		rproc->ops->attach = k3_dsp_rproc_attach;
+		rproc->ops->detach = k3_dsp_rproc_detach;
+		rproc->ops->get_loaded_rsc_table = k3_dsp_get_loaded_rsc_table;
+	} else {
+		dev_info(dev, "configured DSP for remoteproc mode\n");
+		/*
+		 * ensure the DSP local reset is asserted to ensure the DSP
+		 * doesn't execute bogus code in .prepare() when the module
+		 * reset is released.
+		 */
+		if (data->uses_lreset) {
+			ret = reset_control_status(kproc->reset);
+			if (ret < 0) {
+				dev_err(dev, "failed to get reset status, status = %d\n",
+					ret);
+				goto release_mem;
+			} else if (ret == 0) {
+				dev_warn(dev, "local reset is deasserted for device\n");
+				k3_dsp_rproc_reset(kproc);
+			}
 		}
 	}
 
@@ -730,9 +828,18 @@ static int k3_dsp_rproc_probe(struct platform_device *pdev)
 static int k3_dsp_rproc_remove(struct platform_device *pdev)
 {
 	struct k3_dsp_rproc *kproc = platform_get_drvdata(pdev);
+	struct rproc *rproc = kproc->rproc;
 	struct device *dev = &pdev->dev;
 	int ret;
 
+	if (rproc->state == RPROC_ATTACHED) {
+		ret = rproc_detach(rproc);
+		if (ret) {
+			dev_err(dev, "failed to detach proc, ret = %d\n", ret);
+			return ret;
+		}
+	}
+
 	rproc_del(kproc->rproc);
 
 	ret = ti_sci_proc_release(kproc->tsp);
-- 
2.32.0

