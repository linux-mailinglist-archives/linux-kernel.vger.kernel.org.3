Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45A135B1296
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 04:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbiIHClt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 22:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiIHClr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 22:41:47 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2087B56EA
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 19:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662604906; x=1694140906;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=27hkdOl8DwhNIfV+ukFLHPmMnApW8R146r5/5ZGJnLw=;
  b=eV+3GXD83kds64EFpqtVMcycwZj1NvhEcQzfULDXzs3B1w6WawLH6zah
   vaQbe5yhBZMljRSGBfSGu2kFNoZvuTFq0xkxOJWOVR3Z0cL0hhWOUtlAR
   7yevgXSeFCQ3uN7zjoTzJmPAVSvX/0u7PVnYJA5FO9vLiePyTX3vxMujj
   5Dx/s3RxZhDqKy4KHWogYqivZ8xFVVvXDzX44RMGsZK62Jkhyx+n7LpcU
   rCtVxmY67ue/GLdWUPu+bZyjV7R/AfxtEP8/NuK1NDyhC7JKXdupwyA+d
   x58+c7lOOzK2QNsuDXK1hZAkgioLfh0GCDhL1ps29t2vdt3FIgqCb2Q6x
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10463"; a="284066527"
X-IronPort-AV: E=Sophos;i="5.93,298,1654585200"; 
   d="scan'208";a="284066527"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 19:41:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,298,1654585200"; 
   d="scan'208";a="617307750"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga007.fm.intel.com with ESMTP; 07 Sep 2022 19:41:44 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     iommu@lists.linux.dev
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Kevin Tian <kevin.tian@intel.com>,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 1/1] iommu/vt-d: Make SVA and IOPF irrelevant
Date:   Thu,  8 Sep 2022 10:35:57 +0800
Message-Id: <20220908023557.4582-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The existing IOPF handling code relies on the per-PASID SVA data
structures. It does not apply to scenarios other than SVA. This
decouples the I/O page fault reporting and responding code from
SVA related data structures so that the PRQ handling code could
become generic.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.h |  1 -
 drivers/iommu/intel/svm.c   | 65 +++++--------------------------------
 2 files changed, 8 insertions(+), 58 deletions(-)

diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 08618d94fbac..175f5f559e86 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -757,7 +757,6 @@ struct intel_svm_dev {
 	struct device *dev;
 	struct intel_iommu *iommu;
 	struct iommu_sva sva;
-	unsigned long prq_seq_number;
 	u32 pasid;
 	int users;
 	u16 did;
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index b391e46e537e..23a62bead112 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -32,6 +32,7 @@ static void intel_svm_drain_prq(struct device *dev, u32 pasid);
 #define to_intel_svm_dev(handle) container_of(handle, struct intel_svm_dev, sva)
 
 static DEFINE_XARRAY_ALLOC(pasid_private_array);
+static unsigned long prq_seq_number;
 static int pasid_private_add(ioasid_t pasid, void *priv)
 {
 	return xa_alloc(&pasid_private_array, &pasid, priv,
@@ -48,23 +49,6 @@ static void *pasid_private_find(ioasid_t pasid)
 	return xa_load(&pasid_private_array, pasid);
 }
 
-static struct intel_svm_dev *
-svm_lookup_device_by_sid(struct intel_svm *svm, u16 sid)
-{
-	struct intel_svm_dev *sdev = NULL, *t;
-
-	rcu_read_lock();
-	list_for_each_entry_rcu(t, &svm->devs, list) {
-		if (t->sid == sid) {
-			sdev = t;
-			break;
-		}
-	}
-	rcu_read_unlock();
-
-	return sdev;
-}
-
 static struct intel_svm_dev *
 svm_lookup_device_by_dev(struct intel_svm *svm, struct device *dev)
 {
@@ -689,11 +673,10 @@ static void handle_bad_prq_event(struct intel_iommu *iommu,
 
 static irqreturn_t prq_event_thread(int irq, void *d)
 {
-	struct intel_svm_dev *sdev = NULL;
 	struct intel_iommu *iommu = d;
-	struct intel_svm *svm = NULL;
 	struct page_req_dsc *req;
 	int head, tail, handled;
+	struct pci_dev *pdev;
 	u64 address;
 
 	/*
@@ -713,8 +696,6 @@ static irqreturn_t prq_event_thread(int irq, void *d)
 			pr_err("IOMMU: %s: Page request without PASID\n",
 			       iommu->name);
 bad_req:
-			svm = NULL;
-			sdev = NULL;
 			handle_bad_prq_event(iommu, req, QI_RESP_INVALID);
 			goto prq_advance;
 		}
@@ -741,34 +722,15 @@ static irqreturn_t prq_event_thread(int irq, void *d)
 		if (unlikely(req->lpig && !req->rd_req && !req->wr_req))
 			goto prq_advance;
 
-		if (!svm || svm->pasid != req->pasid) {
-			/*
-			 * It can't go away, because the driver is not permitted
-			 * to unbind the mm while any page faults are outstanding.
-			 */
-			svm = pasid_private_find(req->pasid);
-			if (IS_ERR_OR_NULL(svm))
-				goto bad_req;
-		}
-
-		if (!sdev || sdev->sid != req->rid) {
-			sdev = svm_lookup_device_by_sid(svm, req->rid);
-			if (!sdev)
-				goto bad_req;
-		}
-
-		sdev->prq_seq_number++;
-
-		/*
-		 * If prq is to be handled outside iommu driver via receiver of
-		 * the fault notifiers, we skip the page response here.
-		 */
-		if (intel_svm_prq_report(iommu, sdev->dev, req))
+		pdev = pci_get_domain_bus_and_slot(iommu->segment,
+						   PCI_BUS_NUM(req->rid),
+						   req->rid & 0xff);
+		if (!pdev || intel_svm_prq_report(iommu, &pdev->dev, req))
 			handle_bad_prq_event(iommu, req, QI_RESP_INVALID);
 
-		trace_prq_report(iommu, sdev->dev, req->qw_0, req->qw_1,
+		trace_prq_report(iommu, &pdev->dev, req->qw_0, req->qw_1,
 				 req->priv_data[0], req->priv_data[1],
-				 sdev->prq_seq_number);
+				 prq_seq_number++);
 prq_advance:
 		head = (head + sizeof(*req)) & PRQ_RING_MASK;
 	}
@@ -803,8 +765,6 @@ int intel_svm_page_response(struct device *dev,
 			    struct iommu_page_response *msg)
 {
 	struct iommu_fault_page_request *prm;
-	struct intel_svm_dev *sdev = NULL;
-	struct intel_svm *svm = NULL;
 	struct intel_iommu *iommu;
 	bool private_present;
 	bool pasid_present;
@@ -823,8 +783,6 @@ int intel_svm_page_response(struct device *dev,
 	if (!msg || !evt)
 		return -EINVAL;
 
-	mutex_lock(&pasid_mutex);
-
 	prm = &evt->fault.prm;
 	sid = PCI_DEVID(bus, devfn);
 	pasid_present = prm->flags & IOMMU_FAULT_PAGE_REQUEST_PASID_VALID;
@@ -841,12 +799,6 @@ int intel_svm_page_response(struct device *dev,
 		goto out;
 	}
 
-	ret = pasid_to_svm_sdev(dev, prm->pasid, &svm, &sdev);
-	if (ret || !sdev) {
-		ret = -ENODEV;
-		goto out;
-	}
-
 	/*
 	 * Per VT-d spec. v3.0 ch7.7, system software must respond
 	 * with page group response if private data is present (PDP)
@@ -876,7 +828,6 @@ int intel_svm_page_response(struct device *dev,
 		qi_submit_sync(iommu, &desc, 1, 0);
 	}
 out:
-	mutex_unlock(&pasid_mutex);
 	return ret;
 }
 
-- 
2.25.1

