Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E62DC4B3D56
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 21:15:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238174AbiBMUPa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 15:15:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231844AbiBMUPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 15:15:23 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F99E532E6;
        Sun, 13 Feb 2022 12:15:17 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 21DKCnf2017975;
        Sun, 13 Feb 2022 14:12:49 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1644783169;
        bh=GcmN7pw+JRq0CVRhAkBWYyW4VkiTFmlM4mCV9ZiwAG0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=H1SpIJYMdt2MP1uFTgS2yIaSROF2p5l9Cp40TZdk76N4bp20tKmFriyG0hDD6WlWF
         kZ8mV+/zsdAQpHUDLZC4UUwFrkFvLqfnShXo5MpwVNh3gTbpA+T9Nwf8mN6qdYadHV
         2HBVAxApadbQVlY9UG/tS1GTWI0n/F0BUF2Cyeqs=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 21DKCnts065493
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 13 Feb 2022 14:12:49 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Sun, 13
 Feb 2022 14:12:49 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Sun, 13 Feb 2022 14:12:49 -0600
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 21DKCnbI022108;
        Sun, 13 Feb 2022 14:12:49 -0600
Received: from localhost ([10.249.37.221])
        by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 21DKCnug002418;
        Sun, 13 Feb 2022 14:12:49 -0600
From:   Suman Anna <s-anna@ti.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     Hari Nagalla <hnagalla@ti.com>, Praneeth Bajjuri <praneeth@ti.com>,
        <linux-remoteproc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Suman Anna <s-anna@ti.com>
Subject: [PATCH v3 3/5] remoteproc: k3-r5: Add support for IPC-only mode for all R5Fs
Date:   Sun, 13 Feb 2022 14:12:44 -0600
Message-ID: <20220213201246.25952-4-s-anna@ti.com>
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

Add support to the K3 R5F remoteproc driver to configure all the R5F
cores to be either in IPC-only mode or the traditional remoteproc mode.
The IPC-only mode expects that the remote processors are already booted
by the bootloader, and only performs the minimum steps required to
initialize and deinitialize the virtio IPC transports. The remoteproc
mode allows the kernel remoteproc driver to do the regular load and
boot and other device management operations for a R5F core.

The IPC-only mode for a R5F core is detected and configured at driver
probe time by querying the System Firmware for the R5F power and reset
state and/or status and making sure that the R5F core is indeed started
by the bootloaders, otherwise the device is configured for remoteproc
mode.

Support for IPC-only mode is achieved through .attach(), .detach() and
.get_loaded_rsc_table() callback ops and zeroing out the regular rproc
ops .prepare(), .unprepare(), .start() and .stop(). The resource table
follows a design-by-contract approach and is expected to be at the base
of the DDR firmware region reserved for each remoteproc, it is mostly
expected to contain only the virtio device and trace resource entries.

NOTE:
The driver cannot configure a R5F core for remoteproc mode by any
means without rebooting the kernel if that R5F core has been started
by a bootloader. This is the current desired behavior and can be
enhanced in the future if the feature is needed.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
v3: Revised version of v2 patch adjusted for dropping v2 Patch 1
 - Added rproc_detach logic in k3_r5_cluster_rproc_exit() before invoking
   rproc_del()
 - Added rproc_detach logic in cleanup path in k3_r5_cluster_rproc_exit()
   before invoking rproc_del()
v2: https://patchwork.kernel.org/project/linux-remoteproc/patch/20210723220248.6554-4-s-anna@ti.com/
v1: https://patchwork.kernel.org/project/linux-remoteproc/patch/20210522000309.26134-5-s-anna@ti.com/

 drivers/remoteproc/ti_k3_r5_remoteproc.c | 219 ++++++++++++++++++++++-
 1 file changed, 215 insertions(+), 4 deletions(-)

diff --git a/drivers/remoteproc/ti_k3_r5_remoteproc.c b/drivers/remoteproc/ti_k3_r5_remoteproc.c
index ff4e1fac1c7f..4840ad906018 100644
--- a/drivers/remoteproc/ti_k3_r5_remoteproc.c
+++ b/drivers/remoteproc/ti_k3_r5_remoteproc.c
@@ -428,6 +428,7 @@ static int k3_r5_rproc_request_mbox(struct rproc *rproc)
  * private to each core. Only Core0 needs to be unhalted for running the
  * cluster in this mode. The function uses the same reset logic as LockStep
  * mode for this (though the behavior is agnostic of the reset release order).
+ * This callback is invoked only in remoteproc mode.
  */
 static int k3_r5_rproc_prepare(struct rproc *rproc)
 {
@@ -493,7 +494,8 @@ static int k3_r5_rproc_prepare(struct rproc *rproc)
  * both cores. The access is made possible only with releasing the resets for
  * both cores, but with only Core0 unhalted. This function re-uses the same
  * reset assert logic as LockStep mode for this mode (though the behavior is
- * agnostic of the reset assert order).
+ * agnostic of the reset assert order). This callback is invoked only in
+ * remoteproc mode.
  */
 static int k3_r5_rproc_unprepare(struct rproc *rproc)
 {
@@ -527,7 +529,8 @@ static int k3_r5_rproc_unprepare(struct rproc *rproc)
  *
  * The Single-CPU mode on applicable SoCs (eg: AM64x) only uses Core0 to execute
  * code, so only Core0 needs to be unhalted. The function uses the same logic
- * flow as Split-mode for this.
+ * flow as Split-mode for this. This callback is invoked only in remoteproc
+ * mode.
  */
 static int k3_r5_rproc_start(struct rproc *rproc)
 {
@@ -598,7 +601,8 @@ static int k3_r5_rproc_start(struct rproc *rproc)
  * be done here, but is preferred to be done in the .unprepare() ops - this
  * maintains the symmetric behavior between the .start(), .stop(), .prepare()
  * and .unprepare() ops, and also balances them well between sysfs 'state'
- * flow and device bind/unbind or module removal.
+ * flow and device bind/unbind or module removal. This callback is invoked
+ * only in remoteproc mode.
  */
 static int k3_r5_rproc_stop(struct rproc *rproc)
 {
@@ -635,6 +639,78 @@ static int k3_r5_rproc_stop(struct rproc *rproc)
 	return ret;
 }
 
+/*
+ * Attach to a running R5F remote processor (IPC-only mode)
+ *
+ * The R5F attach callback only needs to request the mailbox, the remote
+ * processor is already booted, so there is no need to issue any TI-SCI
+ * commands to boot the R5F cores in IPC-only mode. This callback is invoked
+ * only in IPC-only mode.
+ */
+static int k3_r5_rproc_attach(struct rproc *rproc)
+{
+	struct k3_r5_rproc *kproc = rproc->priv;
+	struct device *dev = kproc->dev;
+	int ret;
+
+	ret = k3_r5_rproc_request_mbox(rproc);
+	if (ret)
+		return ret;
+
+	dev_info(dev, "R5F core initialized in IPC-only mode\n");
+	return 0;
+}
+
+/*
+ * Detach from a running R5F remote processor (IPC-only mode)
+ *
+ * The R5F detach callback performs the opposite operation to attach callback
+ * and only needs to release the mailbox, the R5F cores are not stopped and
+ * will be left in booted state in IPC-only mode. This callback is invoked
+ * only in IPC-only mode.
+ */
+static int k3_r5_rproc_detach(struct rproc *rproc)
+{
+	struct k3_r5_rproc *kproc = rproc->priv;
+	struct device *dev = kproc->dev;
+
+	mbox_free_channel(kproc->mbox);
+	dev_info(dev, "R5F core deinitialized in IPC-only mode\n");
+	return 0;
+}
+
+/*
+ * This function implements the .get_loaded_rsc_table() callback and is used
+ * to provide the resource table for the booted R5F in IPC-only mode. The K3 R5F
+ * firmwares follow a design-by-contract approach and are expected to have the
+ * resource table at the base of the DDR region reserved for firmware usage.
+ * This provides flexibility for the remote processor to be booted by different
+ * bootloaders that may or may not have the ability to publish the resource table
+ * address and size through a DT property. This callback is invoked only in
+ * IPC-only mode.
+ */
+static struct resource_table *k3_r5_get_loaded_rsc_table(struct rproc *rproc,
+							 size_t *rsc_table_sz)
+{
+	struct k3_r5_rproc *kproc = rproc->priv;
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
  * Internal Memory translation helper
  *
@@ -1014,6 +1090,116 @@ static void k3_r5_adjust_tcm_sizes(struct k3_r5_rproc *kproc)
 	}
 }
 
+/*
+ * This function checks and configures a R5F core for IPC-only or remoteproc
+ * mode. The driver is configured to be in IPC-only mode for a R5F core when
+ * the core has been loaded and started by a bootloader. The IPC-only mode is
+ * detected by querying the System Firmware for reset, power on and halt status
+ * and ensuring that the core is running. Any incomplete steps at bootloader
+ * are validated and errored out.
+ *
+ * In IPC-only mode, the driver state flags for ATCM, BTCM and LOCZRAMA settings
+ * and cluster mode parsed originally from kernel DT are updated to reflect the
+ * actual values configured by bootloader. The driver internal device memory
+ * addresses for TCMs are also updated.
+ */
+static int k3_r5_rproc_configure_mode(struct k3_r5_rproc *kproc)
+{
+	struct k3_r5_cluster *cluster = kproc->cluster;
+	struct k3_r5_core *core = kproc->core;
+	struct device *cdev = core->dev;
+	bool r_state = false, c_state = false;
+	u32 ctrl = 0, cfg = 0, stat = 0, halted = 0;
+	u64 boot_vec = 0;
+	u32 atcm_enable, btcm_enable, loczrama;
+	struct k3_r5_core *core0;
+	enum cluster_mode mode;
+	int ret;
+
+	core0 = list_first_entry(&cluster->cores, struct k3_r5_core, elem);
+
+	ret = core->ti_sci->ops.dev_ops.is_on(core->ti_sci, core->ti_sci_id,
+					      &r_state, &c_state);
+	if (ret) {
+		dev_err(cdev, "failed to get initial state, mode cannot be determined, ret = %d\n",
+			ret);
+		return ret;
+	}
+	if (r_state != c_state) {
+		dev_warn(cdev, "R5F core may have been powered on by a different host, programmed state (%d) != actual state (%d)\n",
+			 r_state, c_state);
+	}
+
+	ret = reset_control_status(core->reset);
+	if (ret < 0) {
+		dev_err(cdev, "failed to get initial local reset status, ret = %d\n",
+			ret);
+		return ret;
+	}
+
+	ret = ti_sci_proc_get_status(core->tsp, &boot_vec, &cfg, &ctrl,
+				     &stat);
+	if (ret < 0) {
+		dev_err(cdev, "failed to get initial processor status, ret = %d\n",
+			ret);
+		return ret;
+	}
+	atcm_enable = cfg & PROC_BOOT_CFG_FLAG_R5_ATCM_EN ?  1 : 0;
+	btcm_enable = cfg & PROC_BOOT_CFG_FLAG_R5_BTCM_EN ?  1 : 0;
+	loczrama = cfg & PROC_BOOT_CFG_FLAG_R5_TCM_RSTBASE ?  1 : 0;
+	if (cluster->soc_data->single_cpu_mode) {
+		mode = cfg & PROC_BOOT_CFG_FLAG_R5_SINGLE_CORE ?
+				CLUSTER_MODE_SINGLECPU : CLUSTER_MODE_SPLIT;
+	} else {
+		mode = cfg & PROC_BOOT_CFG_FLAG_R5_LOCKSTEP ?
+				CLUSTER_MODE_LOCKSTEP : CLUSTER_MODE_SPLIT;
+	}
+	halted = ctrl & PROC_BOOT_CTRL_FLAG_R5_CORE_HALT;
+
+	/*
+	 * IPC-only mode detection requires both local and module resets to
+	 * be deasserted and R5F core to be unhalted. Local reset status is
+	 * irrelevant if module reset is asserted (POR value has local reset
+	 * deasserted), and is deemed as remoteproc mode
+	 */
+	if (c_state && !ret && !halted) {
+		dev_info(cdev, "configured R5F for IPC-only mode\n");
+		kproc->rproc->state = RPROC_DETACHED;
+		ret = 1;
+		/* override rproc ops with only required IPC-only mode ops */
+		kproc->rproc->ops->prepare = NULL;
+		kproc->rproc->ops->unprepare = NULL;
+		kproc->rproc->ops->start = NULL;
+		kproc->rproc->ops->stop = NULL;
+		kproc->rproc->ops->attach = k3_r5_rproc_attach;
+		kproc->rproc->ops->detach = k3_r5_rproc_detach;
+		kproc->rproc->ops->get_loaded_rsc_table =
+						k3_r5_get_loaded_rsc_table;
+	} else if (!c_state) {
+		dev_info(cdev, "configured R5F for remoteproc mode\n");
+		ret = 0;
+	} else {
+		dev_err(cdev, "mismatched mode: local_reset = %s, module_reset = %s, core_state = %s\n",
+			!ret ? "deasserted" : "asserted",
+			c_state ? "deasserted" : "asserted",
+			halted ? "halted" : "unhalted");
+		ret = -EINVAL;
+	}
+
+	/* fixup TCMs, cluster & core flags to actual values in IPC-only mode */
+	if (ret > 0) {
+		if (core == core0)
+			cluster->mode = mode;
+		core->atcm_enable = atcm_enable;
+		core->btcm_enable = btcm_enable;
+		core->loczrama = loczrama;
+		core->mem[0].dev_addr = loczrama ? 0 : K3_R5_TCM_DEV_ADDR;
+		core->mem[1].dev_addr = loczrama ? K3_R5_TCM_DEV_ADDR : 0;
+	}
+
+	return ret;
+}
+
 static int k3_r5_cluster_rproc_init(struct platform_device *pdev)
 {
 	struct k3_r5_cluster *cluster = platform_get_drvdata(pdev);
@@ -1023,7 +1209,7 @@ static int k3_r5_cluster_rproc_init(struct platform_device *pdev)
 	struct device *cdev;
 	const char *fw_name;
 	struct rproc *rproc;
-	int ret;
+	int ret, ret1;
 
 	core1 = list_last_entry(&cluster->cores, struct k3_r5_core, elem);
 	list_for_each_entry(core, &cluster->cores, elem) {
@@ -1054,6 +1240,12 @@ static int k3_r5_cluster_rproc_init(struct platform_device *pdev)
 		kproc->rproc = rproc;
 		core->rproc = rproc;
 
+		ret = k3_r5_rproc_configure_mode(kproc);
+		if (ret < 0)
+			goto err_config;
+		if (ret)
+			goto init_rmem;
+
 		ret = k3_r5_rproc_configure(kproc);
 		if (ret) {
 			dev_err(dev, "initial configure failed, ret = %d\n",
@@ -1061,6 +1253,7 @@ static int k3_r5_cluster_rproc_init(struct platform_device *pdev)
 			goto err_config;
 		}
 
+init_rmem:
 		k3_r5_adjust_tcm_sizes(kproc);
 
 		ret = k3_r5_reserved_mem_init(kproc);
@@ -1085,6 +1278,15 @@ static int k3_r5_cluster_rproc_init(struct platform_device *pdev)
 	return 0;
 
 err_split:
+	if (rproc->state == RPROC_ATTACHED) {
+		ret1 = rproc_detach(rproc);
+		if (ret1) {
+			dev_err(kproc->dev, "failed to detach rproc, ret = %d\n",
+				ret1);
+			return ret1;
+		}
+	}
+
 	rproc_del(rproc);
 err_add:
 	k3_r5_reserved_mem_exit(kproc);
@@ -1108,6 +1310,7 @@ static void k3_r5_cluster_rproc_exit(void *data)
 	struct k3_r5_rproc *kproc;
 	struct k3_r5_core *core;
 	struct rproc *rproc;
+	int ret;
 
 	/*
 	 * lockstep mode and single-cpu modes have only one rproc associated
@@ -1123,6 +1326,14 @@ static void k3_r5_cluster_rproc_exit(void *data)
 		rproc = core->rproc;
 		kproc = rproc->priv;
 
+		if (rproc->state == RPROC_ATTACHED) {
+			ret = rproc_detach(rproc);
+			if (ret) {
+				dev_err(kproc->dev, "failed to detach rproc, ret = %d\n", ret);
+				return;
+			}
+		}
+
 		rproc_del(rproc);
 
 		k3_r5_reserved_mem_exit(kproc);
-- 
2.32.0

