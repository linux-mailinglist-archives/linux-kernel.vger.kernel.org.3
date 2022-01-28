Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B29F49FEBD
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 18:14:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350499AbiA1RO4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 12:14:56 -0500
Received: from bedivere.hansenpartnership.com ([96.44.175.130]:36680 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350481AbiA1ROy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 12:14:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1643390094;
        bh=Eqoe3BaXFAi+D+dpU4Y3Ic9BsHj9faqnLb78IoGQrjU=;
        h=Message-ID:Subject:From:To:Date:From;
        b=W1qbmmr9mRCr6M110OFVhBLY19q7qEnTT/sfpdcsD85rSeqIs9nnXV7/o+UujmD1Z
         XDjRUZ3yr2k+ywPQmxarlyqtl2bfY4iHjoOqRCv71Eu91VoRiL/OLIdC7jCu1AO8hK
         PLStp+KDiYa2HVoLAF928Q2TH5Qo5tmhteQ4cKKY=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 399A212805D6;
        Fri, 28 Jan 2022 12:14:54 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id F-DgpCgQn7Gw; Fri, 28 Jan 2022 12:14:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1643390094;
        bh=Eqoe3BaXFAi+D+dpU4Y3Ic9BsHj9faqnLb78IoGQrjU=;
        h=Message-ID:Subject:From:To:Date:From;
        b=W1qbmmr9mRCr6M110OFVhBLY19q7qEnTT/sfpdcsD85rSeqIs9nnXV7/o+UujmD1Z
         XDjRUZ3yr2k+ywPQmxarlyqtl2bfY4iHjoOqRCv71Eu91VoRiL/OLIdC7jCu1AO8hK
         PLStp+KDiYa2HVoLAF928Q2TH5Qo5tmhteQ4cKKY=
Received: from jarvis.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4300:c551::527])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id AE169128034E;
        Fri, 28 Jan 2022 12:14:53 -0500 (EST)
Message-ID: <ebd76be7c06fd3f8f888094fb2dd8e138fe97b33.camel@HansenPartnership.com>
Subject: [GIT PULL] SCSI fixes for 5.17-rc1
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Fri, 28 Jan 2022 12:14:52 -0500
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sixteen patches, mostly minor fixes and updates; however there are
substantive driver bug fixes in pm8001, bnx2fc, zfcp, myrs and qedf.

The patch is available here:

git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

The short changelog is:

Christophe JAILLET (3):
      scsi: bfa: Remove useless DMA-32 fallback configuration
      scsi: hisi_sas: Remove useless DMA-32 fallback configuration
      scsi: 3w-sas: Remove useless DMA-32 fallback configuration

Colin Ian King (1):
      scsi: 53c700: Remove redundant assignment to pointer SCp

John Garry (1):
      scsi: pm8001: Fix bogus FW crash for maxcpus=1

John Meneghini (1):
      scsi: bnx2fc: Flush destroy_work queue before calling bnx2fc_interface_put()

Kiwoong Kim (2):
      scsi: ufs: Treat link loss as fatal error
      scsi: ufs: Use generic error code in ufshcd_set_dev_pwr_mode()

Saurav Kashyap (3):
      scsi: qedf: Change context reset messages to ratelimited
      scsi: qedf: Fix refcount issue when LOGO is received during TMF
      scsi: qedf: Add stag_work to all the vports

Steffen Maier (1):
      scsi: zfcp: Fix failed recovery on gone remote port with non-NPIV FCP devices

Tong Zhang (1):
      scsi: myrs: Fix crash in error case

Xiaoke Wang (1):
      scsi: ufs: ufshcd-pltfrm: Check the return value of devm_kstrdup()

Yang Yingliang (1):
      scsi: elx: efct: Don't use GFP_KERNEL under spin lock

ZouMingzhe (1):
      scsi: target: iscsi: Make sure the np under each tpg is unique

And the diffstat:

 drivers/s390/scsi/zfcp_fc.c             | 13 ++++++++++++-
 drivers/scsi/3w-sas.c                   |  4 ----
 drivers/scsi/53c700.c                   |  1 -
 drivers/scsi/bfa/bfad.c                 |  6 ------
 drivers/scsi/bnx2fc/bnx2fc_fcoe.c       | 20 +++++---------------
 drivers/scsi/elx/libefc/efc_els.c       |  8 ++------
 drivers/scsi/hisi_sas/hisi_sas_main.c   |  3 ---
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c  |  2 --
 drivers/scsi/myrs.c                     |  3 ++-
 drivers/scsi/pm8001/pm80xx_hwi.c        | 16 ++++++++++++++--
 drivers/scsi/pm8001/pm80xx_hwi.h        |  6 +++++-
 drivers/scsi/qedf/qedf_io.c             |  1 +
 drivers/scsi/qedf/qedf_main.c           |  7 +++++--
 drivers/scsi/ufs/ufshcd-pltfrm.c        |  7 +++++++
 drivers/scsi/ufs/ufshcd.c               |  9 ++++++---
 drivers/scsi/ufs/ufshci.h               |  3 ++-
 drivers/target/iscsi/iscsi_target_tpg.c |  3 +++
 17 files changed, 64 insertions(+), 48 deletions(-)

With full diff below.

James

---

diff --git a/drivers/s390/scsi/zfcp_fc.c b/drivers/s390/scsi/zfcp_fc.c
index d24cafe02708..511bf8e0a436 100644
--- a/drivers/s390/scsi/zfcp_fc.c
+++ b/drivers/s390/scsi/zfcp_fc.c
@@ -521,6 +521,8 @@ static void zfcp_fc_adisc_handler(void *data)
 		goto out;
 	}
 
+	/* re-init to undo drop from zfcp_fc_adisc() */
+	port->d_id = ntoh24(adisc_resp->adisc_port_id);
 	/* port is good, unblock rport without going through erp */
 	zfcp_scsi_schedule_rport_register(port);
  out:
@@ -534,6 +536,7 @@ static int zfcp_fc_adisc(struct zfcp_port *port)
 	struct zfcp_fc_req *fc_req;
 	struct zfcp_adapter *adapter = port->adapter;
 	struct Scsi_Host *shost = adapter->scsi_host;
+	u32 d_id;
 	int ret;
 
 	fc_req = kmem_cache_zalloc(zfcp_fc_req_cache, GFP_ATOMIC);
@@ -558,7 +561,15 @@ static int zfcp_fc_adisc(struct zfcp_port *port)
 	fc_req->u.adisc.req.adisc_cmd = ELS_ADISC;
 	hton24(fc_req->u.adisc.req.adisc_port_id, fc_host_port_id(shost));
 
-	ret = zfcp_fsf_send_els(adapter, port->d_id, &fc_req->ct_els,
+	d_id = port->d_id; /* remember as destination for send els below */
+	/*
+	 * Force fresh GID_PN lookup on next port recovery.
+	 * Must happen after request setup and before sending request,
+	 * to prevent race with port->d_id re-init in zfcp_fc_adisc_handler().
+	 */
+	port->d_id = 0;
+
+	ret = zfcp_fsf_send_els(adapter, d_id, &fc_req->ct_els,
 				ZFCP_FC_CTELS_TMO);
 	if (ret)
 		kmem_cache_free(zfcp_fc_req_cache, fc_req);
diff --git a/drivers/scsi/3w-sas.c b/drivers/scsi/3w-sas.c
index b9482da79512..3ebe66151dcb 100644
--- a/drivers/scsi/3w-sas.c
+++ b/drivers/scsi/3w-sas.c
@@ -1567,8 +1567,6 @@ static int twl_probe(struct pci_dev *pdev, const struct pci_device_id *dev_id)
 	pci_try_set_mwi(pdev);
 
 	retval = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
-	if (retval)
-		retval = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
 	if (retval) {
 		TW_PRINTK(host, TW_DRIVER, 0x18, "Failed to set dma mask");
 		retval = -ENODEV;
@@ -1786,8 +1784,6 @@ static int __maybe_unused twl_resume(struct device *dev)
 	pci_try_set_mwi(pdev);
 
 	retval = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
-	if (retval)
-		retval = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
 	if (retval) {
 		TW_PRINTK(host, TW_DRIVER, 0x25, "Failed to set dma mask during resume");
 		retval = -ENODEV;
diff --git a/drivers/scsi/53c700.c b/drivers/scsi/53c700.c
index 3ad3ebaca8e9..ad4972c0fc53 100644
--- a/drivers/scsi/53c700.c
+++ b/drivers/scsi/53c700.c
@@ -1507,7 +1507,6 @@ NCR_700_intr(int irq, void *dev_id)
 		struct scsi_cmnd *SCp = hostdata->cmd;
 
 		handled = 1;
-		SCp = hostdata->cmd;
 
 		if(istat & SCSI_INT_PENDING) {
 			udelay(10);
diff --git a/drivers/scsi/bfa/bfad.c b/drivers/scsi/bfa/bfad.c
index 440ef32be048..e5aa982ffedc 100644
--- a/drivers/scsi/bfa/bfad.c
+++ b/drivers/scsi/bfa/bfad.c
@@ -732,9 +732,6 @@ bfad_pci_init(struct pci_dev *pdev, struct bfad_s *bfad)
 	pci_set_master(pdev);
 
 	rc = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
-	if (rc)
-		rc = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
-
 	if (rc) {
 		rc = -ENODEV;
 		printk(KERN_ERR "dma_set_mask_and_coherent fail %p\n", pdev);
@@ -1559,9 +1556,6 @@ bfad_pci_slot_reset(struct pci_dev *pdev)
 	pci_set_master(pdev);
 
 	rc = dma_set_mask_and_coherent(&bfad->pcidev->dev, DMA_BIT_MASK(64));
-	if (rc)
-		rc = dma_set_mask_and_coherent(&bfad->pcidev->dev,
-					       DMA_BIT_MASK(32));
 	if (rc)
 		goto out_disable_device;
 
diff --git a/drivers/scsi/bnx2fc/bnx2fc_fcoe.c b/drivers/scsi/bnx2fc/bnx2fc_fcoe.c
index 71fa62bd3083..9be273c320e2 100644
--- a/drivers/scsi/bnx2fc/bnx2fc_fcoe.c
+++ b/drivers/scsi/bnx2fc/bnx2fc_fcoe.c
@@ -82,7 +82,7 @@ static int bnx2fc_bind_pcidev(struct bnx2fc_hba *hba);
 static void bnx2fc_unbind_pcidev(struct bnx2fc_hba *hba);
 static struct fc_lport *bnx2fc_if_create(struct bnx2fc_interface *interface,
 				  struct device *parent, int npiv);
-static void bnx2fc_destroy_work(struct work_struct *work);
+static void bnx2fc_port_destroy(struct fcoe_port *port);
 
 static struct bnx2fc_hba *bnx2fc_hba_lookup(struct net_device *phys_dev);
 static struct bnx2fc_interface *bnx2fc_interface_lookup(struct net_device
@@ -907,9 +907,6 @@ static void bnx2fc_indicate_netevent(void *context, unsigned long event,
 				__bnx2fc_destroy(interface);
 		}
 		mutex_unlock(&bnx2fc_dev_lock);
-
-		/* Ensure ALL destroy work has been completed before return */
-		flush_workqueue(bnx2fc_wq);
 		return;
 
 	default:
@@ -1215,8 +1212,8 @@ static int bnx2fc_vport_destroy(struct fc_vport *vport)
 	mutex_unlock(&n_port->lp_mutex);
 	bnx2fc_free_vport(interface->hba, port->lport);
 	bnx2fc_port_shutdown(port->lport);
+	bnx2fc_port_destroy(port);
 	bnx2fc_interface_put(interface);
-	queue_work(bnx2fc_wq, &port->destroy_work);
 	return 0;
 }
 
@@ -1525,7 +1522,6 @@ static struct fc_lport *bnx2fc_if_create(struct bnx2fc_interface *interface,
 	port->lport = lport;
 	port->priv = interface;
 	port->get_netdev = bnx2fc_netdev;
-	INIT_WORK(&port->destroy_work, bnx2fc_destroy_work);
 
 	/* Configure fcoe_port */
 	rc = bnx2fc_lport_config(lport);
@@ -1653,8 +1649,8 @@ static void __bnx2fc_destroy(struct bnx2fc_interface *interface)
 	bnx2fc_interface_cleanup(interface);
 	bnx2fc_stop(interface);
 	list_del(&interface->list);
+	bnx2fc_port_destroy(port);
 	bnx2fc_interface_put(interface);
-	queue_work(bnx2fc_wq, &port->destroy_work);
 }
 
 /**
@@ -1694,15 +1690,12 @@ static int bnx2fc_destroy(struct net_device *netdev)
 	return rc;
 }
 
-static void bnx2fc_destroy_work(struct work_struct *work)
+static void bnx2fc_port_destroy(struct fcoe_port *port)
 {
-	struct fcoe_port *port;
 	struct fc_lport *lport;
 
-	port = container_of(work, struct fcoe_port, destroy_work);
 	lport = port->lport;
-
-	BNX2FC_HBA_DBG(lport, "Entered bnx2fc_destroy_work\n");
+	BNX2FC_HBA_DBG(lport, "Entered %s, destroying lport %p\n", __func__, lport);
 
 	bnx2fc_if_destroy(lport);
 }
@@ -2556,9 +2549,6 @@ static void bnx2fc_ulp_exit(struct cnic_dev *dev)
 			__bnx2fc_destroy(interface);
 	mutex_unlock(&bnx2fc_dev_lock);
 
-	/* Ensure ALL destroy work has been completed before return */
-	flush_workqueue(bnx2fc_wq);
-
 	bnx2fc_ulp_stop(hba);
 	/* unregister cnic device */
 	if (test_and_clear_bit(BNX2FC_CNIC_REGISTERED, &hba->reg_with_cnic))
diff --git a/drivers/scsi/elx/libefc/efc_els.c b/drivers/scsi/elx/libefc/efc_els.c
index 7bb4f9aad2c8..84bc81d7ce76 100644
--- a/drivers/scsi/elx/libefc/efc_els.c
+++ b/drivers/scsi/elx/libefc/efc_els.c
@@ -46,18 +46,14 @@ efc_els_io_alloc_size(struct efc_node *node, u32 reqlen, u32 rsplen)
 
 	efc = node->efc;
 
-	spin_lock_irqsave(&node->els_ios_lock, flags);
-
 	if (!node->els_io_enabled) {
 		efc_log_err(efc, "els io alloc disabled\n");
-		spin_unlock_irqrestore(&node->els_ios_lock, flags);
 		return NULL;
 	}
 
 	els = mempool_alloc(efc->els_io_pool, GFP_ATOMIC);
 	if (!els) {
 		atomic_add_return(1, &efc->els_io_alloc_failed_count);
-		spin_unlock_irqrestore(&node->els_ios_lock, flags);
 		return NULL;
 	}
 
@@ -74,7 +70,6 @@ efc_els_io_alloc_size(struct efc_node *node, u32 reqlen, u32 rsplen)
 					      &els->io.req.phys, GFP_KERNEL);
 	if (!els->io.req.virt) {
 		mempool_free(els, efc->els_io_pool);
-		spin_unlock_irqrestore(&node->els_ios_lock, flags);
 		return NULL;
 	}
 
@@ -94,10 +89,11 @@ efc_els_io_alloc_size(struct efc_node *node, u32 reqlen, u32 rsplen)
 
 		/* add els structure to ELS IO list */
 		INIT_LIST_HEAD(&els->list_entry);
+		spin_lock_irqsave(&node->els_ios_lock, flags);
 		list_add_tail(&els->list_entry, &node->els_ios_list);
+		spin_unlock_irqrestore(&node->els_ios_lock, flags);
 	}
 
-	spin_unlock_irqrestore(&node->els_ios_lock, flags);
 	return els;
 }
 
diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
index a05ec7aece5a..2f53a2ee024a 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_main.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
@@ -2666,9 +2666,6 @@ static struct Scsi_Host *hisi_sas_shost_alloc(struct platform_device *pdev,
 		goto err_out;
 
 	error = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
-	if (error)
-		error = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
-
 	if (error) {
 		dev_err(dev, "No usable DMA addressing method\n");
 		goto err_out;
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
index a45ef9a5e12e..a01a3a7b706b 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
@@ -4695,8 +4695,6 @@ hisi_sas_v3_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		goto err_out;
 
 	rc = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
-	if (rc)
-		rc = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
 	if (rc) {
 		dev_err(dev, "No usable DMA addressing method\n");
 		rc = -ENODEV;
diff --git a/drivers/scsi/myrs.c b/drivers/scsi/myrs.c
index 253ceca54a84..7eb8c39da366 100644
--- a/drivers/scsi/myrs.c
+++ b/drivers/scsi/myrs.c
@@ -2267,7 +2267,8 @@ static void myrs_cleanup(struct myrs_hba *cs)
 	myrs_unmap(cs);
 
 	if (cs->mmio_base) {
-		cs->disable_intr(cs);
+		if (cs->disable_intr)
+			cs->disable_intr(cs);
 		iounmap(cs->mmio_base);
 		cs->mmio_base = NULL;
 	}
diff --git a/drivers/scsi/pm8001/pm80xx_hwi.c b/drivers/scsi/pm8001/pm80xx_hwi.c
index bbf538fe15b3..2530d1365556 100644
--- a/drivers/scsi/pm8001/pm80xx_hwi.c
+++ b/drivers/scsi/pm8001/pm80xx_hwi.c
@@ -4151,10 +4151,22 @@ static int process_oq(struct pm8001_hba_info *pm8001_ha, u8 vec)
 	u32 ret = MPI_IO_STATUS_FAIL;
 	u32 regval;
 
+	/*
+	 * Fatal errors are programmed to be signalled in irq vector
+	 * pm8001_ha->max_q_num - 1 through pm8001_ha->main_cfg_tbl.pm80xx_tbl.
+	 * fatal_err_interrupt
+	 */
 	if (vec == (pm8001_ha->max_q_num - 1)) {
+		u32 mipsall_ready;
+
+		if (pm8001_ha->chip_id == chip_8008 ||
+		    pm8001_ha->chip_id == chip_8009)
+			mipsall_ready = SCRATCH_PAD_MIPSALL_READY_8PORT;
+		else
+			mipsall_ready = SCRATCH_PAD_MIPSALL_READY_16PORT;
+
 		regval = pm8001_cr32(pm8001_ha, 0, MSGU_SCRATCH_PAD_1);
-		if ((regval & SCRATCH_PAD_MIPSALL_READY) !=
-					SCRATCH_PAD_MIPSALL_READY) {
+		if ((regval & mipsall_ready) != mipsall_ready) {
 			pm8001_ha->controller_fatal_error = true;
 			pm8001_dbg(pm8001_ha, FAIL,
 				   "Firmware Fatal error! Regval:0x%x\n",
diff --git a/drivers/scsi/pm8001/pm80xx_hwi.h b/drivers/scsi/pm8001/pm80xx_hwi.h
index c7e5d93bea92..c41ed039c92a 100644
--- a/drivers/scsi/pm8001/pm80xx_hwi.h
+++ b/drivers/scsi/pm8001/pm80xx_hwi.h
@@ -1405,8 +1405,12 @@ typedef struct SASProtocolTimerConfig SASProtocolTimerConfig_t;
 #define SCRATCH_PAD_BOOT_LOAD_SUCCESS	0x0
 #define SCRATCH_PAD_IOP0_READY		0xC00
 #define SCRATCH_PAD_IOP1_READY		0x3000
-#define SCRATCH_PAD_MIPSALL_READY	(SCRATCH_PAD_IOP1_READY | \
+#define SCRATCH_PAD_MIPSALL_READY_16PORT	(SCRATCH_PAD_IOP1_READY | \
 					SCRATCH_PAD_IOP0_READY | \
+					SCRATCH_PAD_ILA_READY | \
+					SCRATCH_PAD_RAAE_READY)
+#define SCRATCH_PAD_MIPSALL_READY_8PORT	(SCRATCH_PAD_IOP0_READY | \
+					SCRATCH_PAD_ILA_READY | \
 					SCRATCH_PAD_RAAE_READY)
 
 /* boot loader state */
diff --git a/drivers/scsi/qedf/qedf_io.c b/drivers/scsi/qedf/qedf_io.c
index 99a56ca1fb16..fab43dabe5b3 100644
--- a/drivers/scsi/qedf/qedf_io.c
+++ b/drivers/scsi/qedf/qedf_io.c
@@ -2250,6 +2250,7 @@ int qedf_initiate_cleanup(struct qedf_ioreq *io_req,
 	    io_req->tm_flags == FCP_TMF_TGT_RESET) {
 		clear_bit(QEDF_CMD_OUTSTANDING, &io_req->flags);
 		io_req->sc_cmd = NULL;
+		kref_put(&io_req->refcount, qedf_release_cmd);
 		complete(&io_req->tm_done);
 	}
 
diff --git a/drivers/scsi/qedf/qedf_main.c b/drivers/scsi/qedf/qedf_main.c
index cdc66e2a9488..6ad28bc8e948 100644
--- a/drivers/scsi/qedf/qedf_main.c
+++ b/drivers/scsi/qedf/qedf_main.c
@@ -911,7 +911,7 @@ void qedf_ctx_soft_reset(struct fc_lport *lport)
 	struct qed_link_output if_link;
 
 	if (lport->vport) {
-		QEDF_ERR(NULL, "Cannot issue host reset on NPIV port.\n");
+		printk_ratelimited("Cannot issue host reset on NPIV port.\n");
 		return;
 	}
 
@@ -1864,6 +1864,7 @@ static int qedf_vport_create(struct fc_vport *vport, bool disabled)
 	vport_qedf->cmd_mgr = base_qedf->cmd_mgr;
 	init_completion(&vport_qedf->flogi_compl);
 	INIT_LIST_HEAD(&vport_qedf->fcports);
+	INIT_DELAYED_WORK(&vport_qedf->stag_work, qedf_stag_change_work);
 
 	rc = qedf_vport_libfc_config(vport, vn_port);
 	if (rc) {
@@ -3980,7 +3981,9 @@ void qedf_stag_change_work(struct work_struct *work)
 	struct qedf_ctx *qedf =
 	    container_of(work, struct qedf_ctx, stag_work.work);
 
-	QEDF_ERR(&qedf->dbg_ctx, "Performing software context reset.\n");
+	printk_ratelimited("[%s]:[%s:%d]:%d: Performing software context reset.",
+			dev_name(&qedf->pdev->dev), __func__, __LINE__,
+			qedf->dbg_ctx.host_no);
 	qedf_ctx_soft_reset(qedf->lport);
 }
 
diff --git a/drivers/scsi/ufs/ufshcd-pltfrm.c b/drivers/scsi/ufs/ufshcd-pltfrm.c
index 8b16bbbcb806..87975d1a21c8 100644
--- a/drivers/scsi/ufs/ufshcd-pltfrm.c
+++ b/drivers/scsi/ufs/ufshcd-pltfrm.c
@@ -92,6 +92,11 @@ static int ufshcd_parse_clock_info(struct ufs_hba *hba)
 		clki->min_freq = clkfreq[i];
 		clki->max_freq = clkfreq[i+1];
 		clki->name = devm_kstrdup(dev, name, GFP_KERNEL);
+		if (!clki->name) {
+			ret = -ENOMEM;
+			goto out;
+		}
+
 		if (!strcmp(name, "ref_clk"))
 			clki->keep_link_active = true;
 		dev_dbg(dev, "%s: min %u max %u name %s\n", "freq-table-hz",
@@ -127,6 +132,8 @@ static int ufshcd_populate_vreg(struct device *dev, const char *name,
 		return -ENOMEM;
 
 	vreg->name = devm_kstrdup(dev, name, GFP_KERNEL);
+	if (!vreg->name)
+		return -ENOMEM;
 
 	snprintf(prop_name, MAX_PROP_SIZE, "%s-max-microamp", name);
 	if (of_property_read_u32(np, prop_name, &vreg->max_uA)) {
diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 460d2b440d2e..50b12d60dc1b 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -8613,7 +8613,7 @@ static void ufshcd_hba_exit(struct ufs_hba *hba)
  * @pwr_mode: device power mode to set
  *
  * Returns 0 if requested power mode is set successfully
- * Returns non-zero if failed to set the requested power mode
+ * Returns < 0 if failed to set the requested power mode
  */
 static int ufshcd_set_dev_pwr_mode(struct ufs_hba *hba,
 				     enum ufs_dev_pwr_mode pwr_mode)
@@ -8667,8 +8667,11 @@ static int ufshcd_set_dev_pwr_mode(struct ufs_hba *hba,
 		sdev_printk(KERN_WARNING, sdp,
 			    "START_STOP failed for power mode: %d, result %x\n",
 			    pwr_mode, ret);
-		if (ret > 0 && scsi_sense_valid(&sshdr))
-			scsi_print_sense_hdr(sdp, NULL, &sshdr);
+		if (ret > 0) {
+			if (scsi_sense_valid(&sshdr))
+				scsi_print_sense_hdr(sdp, NULL, &sshdr);
+			ret = -EIO;
+		}
 	}
 
 	if (!ret)
diff --git a/drivers/scsi/ufs/ufshci.h b/drivers/scsi/ufs/ufshci.h
index 6a295c88d850..a7ff0e5b5494 100644
--- a/drivers/scsi/ufs/ufshci.h
+++ b/drivers/scsi/ufs/ufshci.h
@@ -142,7 +142,8 @@ static inline u32 ufshci_version(u32 major, u32 minor)
 #define INT_FATAL_ERRORS	(DEVICE_FATAL_ERROR |\
 				CONTROLLER_FATAL_ERROR |\
 				SYSTEM_BUS_FATAL_ERROR |\
-				CRYPTO_ENGINE_FATAL_ERROR)
+				CRYPTO_ENGINE_FATAL_ERROR |\
+				UIC_LINK_LOST)
 
 /* HCS - Host Controller Status 30h */
 #define DEVICE_PRESENT				0x1
diff --git a/drivers/target/iscsi/iscsi_target_tpg.c b/drivers/target/iscsi/iscsi_target_tpg.c
index 8075f60fd02c..2d5cf1714ae0 100644
--- a/drivers/target/iscsi/iscsi_target_tpg.c
+++ b/drivers/target/iscsi/iscsi_target_tpg.c
@@ -443,6 +443,9 @@ static bool iscsit_tpg_check_network_portal(
 				break;
 		}
 		spin_unlock(&tpg->tpg_np_lock);
+
+		if (match)
+			break;
 	}
 	spin_unlock(&tiqn->tiqn_tpg_lock);
 

