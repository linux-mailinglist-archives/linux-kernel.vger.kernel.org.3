Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83401593056
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 15:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231921AbiHON6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 09:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbiHON6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 09:58:00 -0400
Received: from mail.wantstofly.org (hmm.wantstofly.org [213.239.204.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 903552180E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 06:57:58 -0700 (PDT)
Received: by mail.wantstofly.org (Postfix, from userid 1000)
        id CFC657F527; Mon, 15 Aug 2022 16:57:56 +0300 (EEST)
Date:   Mon, 15 Aug 2022 16:57:56 +0300
From:   Lennert Buytenhek <buytenh@wantstofly.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Sasha Levin <sashal@kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>, iommu@lists.linux.dev,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        linux-kernel@vger.kernel.org,
        Scarlett Gourley <scarlett@arista.com>,
        James Sewart <jamessewart@arista.com>,
        Jack O'Sullivan <jack@arista.com>
Subject: Re: lockdep splat due to klist iteration from atomic context in
 Intel IOMMU driver
Message-ID: <YvpQ5M7//AlrpJGP@wantstofly.org>
References: <Yvo2dfpEh/WC+Wrr@wantstofly.org>
 <ab15191c-d79f-b5de-7568-d15b8f8a8aa8@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab15191c-d79f-b5de-7568-d15b8f8a8aa8@acm.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 15, 2022 at 06:32:24AM -0700, Bart Van Assche wrote:

> > On a build of 7ebfc85e2cd7 ("Merge tag 'net-6.0-rc1' of
> > git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net"), with
> > CONFIG_INTEL_IOMMU_DEBUGFS enabled, I am seeing the lockdep splat
> > below when an I/O page fault occurs on a machine with an Intel
> > IOMMU in it.
> > 
> > The issue seems to be the klist iterator functions using
> > spin_*lock_irq*() but the klist insertion functions using
> > spin_*lock(), combined with the Intel DMAR IOMMU driver iterating
> > over klists from atomic (hardirq) context as of commit 8ac0b64b9735
> > ("iommu/vt-d: Use pci_get_domain_bus_and_slot() in pgtable_walk()")
> > when CONFIG_INTEL_IOMMU_DEBUGFS is enabled, where
> > pci_get_domain_bus_and_slot() calls into bus_find_device() which
> > iterates over klists.
> > 
> > I found this commit from 2018:
> > 
> > 	commit 624fa7790f80575a4ec28fbdb2034097dc18d051
> > 	Author: Bart Van Assche <bvanassche@acm.org>
> > 	Date:   Fri Jun 22 14:54:49 2018 -0700
> > 
> > 	    scsi: klist: Make it safe to use klists in atomic context
> > 
> > This commit switched lib/klist.c:klist_{prev,next} from
> > spin_{,un}lock() to spin_{lock_irqsave,unlock_irqrestore}(), but left
> > the spin_{,un}lock() calls in add_{head,tail}() untouched.
> > 
> > The simplest fix for this would be to switch lib/klist.c:add_{head,tail}()
> > over to use the IRQ-safe spinlock variants as well?
> 
> Another possibility would be to evaluate whether it is safe to revert commit
> 624fa7790f80 ("scsi: klist: Make it safe to use klists in atomic context").
> That commit is no longer needed by the SRP transport driver since the legacy
> block layer has been removed from the kernel.

And then to fix the 6.0-rc1 iommu/vt-d lockdep splat with
CONFIG_INTEL_IOMMU_DEBUGFS enabled, we could convert the Intel DMAR
IRQ handler to a threaded IRQ handler.  We (Arista) carry the patch
below in our kernel tree, and the last two hunks of the patch do
exactly that, for the same reason (having to call
pci_get_domain_bus_and_slot() from the IRQ handler) but this is
probably too big of a change for 6.0-rc.



commit 90a8e7da0facf198692a641fcfe6f89c478608e0
Author: Lennert Buytenhek <buytenh@wantstofly.org>
Date:   Wed Jul 13 15:34:30 2022 +0300

    iommu/vt-d: Use report_iommu_fault()
    
    This patch makes iommu/vt-d call report_iommu_fault() when an I/O
    page fault occurs, which has two effects:
    
    1) It allows device drivers to register a callback to be notified
       of I/O page faults, via the iommu_set_fault_handler() API.
    
    2) It triggers the io_page_fault tracepoint in report_iommu_fault()
       when an I/O page fault occurs.
    
    The latter point is the main aim of this patch, as it allows
    rasdaemon-like daemons to be notified of I/O page faults, and to
    possibly initiate corrective action in response.
    
    Most of the other IOMMU drivers already use report_iommu_fault(),
    including iommu/amd on the x86 front, since Linux 5.16 via commit
    9f78e446bde8 ("iommu/amd: Use report_iommu_fault()").
    
    To be able to call report_iommu_fault() from the dmar_fault IRQ
    handler, we need to make this IRQ handler run from thread context,
    as we need to call pci_get_domain_bus_and_slot() to turn the PCI
    BDF of the faulting device into a struct pci_dev * to pass into
    report_iommu_fault(), and pci_get_domain_bus_and_slot() uses
    bus_find_device() which iterates over klists, which is not safe to
    do from hardirq context.
    
    When IRQ remapping is enabled, iommu/vt-d will try to set up its
    dmar_fault IRQ handler from start_kernel() -> x86_late_time_init()
    -> apic_intr_mode_init() -> apic_bsp_setup() ->
    irq_remap_enable_fault_handling() -> enable_drhd_fault_handling(),
    which happens before kthreadd is started, and trying to set up a
    threaded IRQ handler this early on will oops.  However, there
    doesn't seem to be a reason why iommu/vt-d needs to set up its
    fault reporting IRQ handler this early, and if we remove the IRQ
    setup code from enable_drhd_fault_handling(), the IRQ will be
    registered instead from pci_iommu_init() -> intel_iommu_init() ->
    init_dmars(), at which point kthreadd has already been started,
    making it possible to set up a threaded IRQ handler.
    
    Suggested-by: Scarlett Gourley <scarlett@arista.com>
    Suggested-by: James Sewart <jamessewart@arista.com>
    Suggested-by: Jack O'Sullivan <jack@arista.com>
    Signed-off-by: Lennert Buytenhek <buytenh@arista.com>

diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index 5a8f780e7ffd..f366041271af 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -1909,15 +1909,43 @@ void dmar_msi_read(int irq, struct msi_msg *msg)
 	raw_spin_unlock_irqrestore(&iommu->register_lock, flag);
 }
 
-static int dmar_fault_do_one(struct intel_iommu *iommu, int type,
-		u8 fault_reason, u32 pasid, u16 source_id,
-		unsigned long long addr)
+static int check_dma_fault(struct intel_iommu *iommu, int type,
+			   u16 source_id, unsigned long long addr)
 {
-	const char *reason;
-	int fault_type;
+	int ret;
+	struct pci_dev *pdev;
+
+	ret = -1;
+
+	pdev = pci_get_domain_bus_and_slot(iommu->segment,
+					   PCI_BUS_NUM(source_id),
+					   source_id & 0xFF);
+	if (pdev) {
+		struct device_domain_info *dev_data;
+
+		dev_data = dev_iommu_priv_get(&pdev->dev);
+		if (dev_data) {
+			int flags;
+
+			if (type)
+				flags = IOMMU_FAULT_READ;
+			else
+				flags = IOMMU_FAULT_WRITE;
+
+			ret = report_iommu_fault(&dev_data->domain->domain,
+						 &pdev->dev, addr, flags);
+		}
+
+		pci_dev_put(pdev);
+	}
 
-	reason = dmar_get_fault_reason(fault_reason, &fault_type);
+	return ret;
+}
 
+static int dmar_fault_do_one(struct intel_iommu *iommu, int type,
+		u8 fault_reason, u32 pasid, u16 source_id,
+		unsigned long long addr, const char *reason, int fault_type)
+{
 	if (fault_type == INTR_REMAP) {
 		pr_err("[INTR-REMAP] Request device [%02x:%02x.%d] fault index 0x%llx [fault reason 0x%02x] %s\n",
 		       source_id >> 8, PCI_SLOT(source_id & 0xFF),
@@ -1968,8 +1996,6 @@ irqreturn_t dmar_fault(int irq, void *dev_id)
 	fault_index = dma_fsts_fault_record_index(fault_status);
 	reg = cap_fault_reg_offset(iommu->cap);
 	while (1) {
-		/* Disable printing, simply clear the fault when ratelimited */
-		bool ratelimited = !__ratelimit(&rs);
 		u8 fault_reason;
 		u16 source_id;
 		u64 guest_addr;
@@ -1977,6 +2003,8 @@ irqreturn_t dmar_fault(int irq, void *dev_id)
 		int type;
 		u32 data;
 		bool pasid_present;
+		const char *reason;
+		int fault_type;
 
 		/* highest 32 bits */
 		data = readl(iommu->reg + reg +
@@ -1984,20 +2012,18 @@ irqreturn_t dmar_fault(int irq, void *dev_id)
 		if (!(data & DMA_FRCD_F))
 			break;
 
-		if (!ratelimited) {
-			fault_reason = dma_frcd_fault_reason(data);
-			type = dma_frcd_type(data);
+		fault_reason = dma_frcd_fault_reason(data);
+		type = dma_frcd_type(data);
 
-			pasid = dma_frcd_pasid_value(data);
-			data = readl(iommu->reg + reg +
-				     fault_index * PRIMARY_FAULT_REG_LEN + 8);
-			source_id = dma_frcd_source_id(data);
+		pasid = dma_frcd_pasid_value(data);
+		data = readl(iommu->reg + reg +
+			     fault_index * PRIMARY_FAULT_REG_LEN + 8);
+		source_id = dma_frcd_source_id(data);
 
-			pasid_present = dma_frcd_pasid_present(data);
-			guest_addr = dmar_readq(iommu->reg + reg +
-					fault_index * PRIMARY_FAULT_REG_LEN);
-			guest_addr = dma_frcd_page_addr(guest_addr);
-		}
+		pasid_present = dma_frcd_pasid_present(data);
+		guest_addr = dmar_readq(iommu->reg + reg +
+				fault_index * PRIMARY_FAULT_REG_LEN);
+		guest_addr = dma_frcd_page_addr(guest_addr);
 
 		/* clear the fault */
 		writel(DMA_FRCD_F, iommu->reg + reg +
@@ -2005,11 +2031,17 @@ irqreturn_t dmar_fault(int irq, void *dev_id)
 
 		raw_spin_unlock_irqrestore(&iommu->register_lock, flag);
 
-		if (!ratelimited)
+		reason = dmar_get_fault_reason(fault_reason, &fault_type);
+
+		if ((fault_type != DMA_REMAP ||
+		     check_dma_fault(iommu, type, source_id, guest_addr)) &&
+		    __ratelimit(&rs)) {
 			/* Using pasid -1 if pasid is not present */
 			dmar_fault_do_one(iommu, type, fault_reason,
 					  pasid_present ? pasid : INVALID_IOASID,
-					  source_id, guest_addr);
+					  source_id, guest_addr,
+					  reason, fault_type);
+		}
 
 		fault_index++;
 		if (fault_index >= cap_num_fault_regs(iommu->cap))
@@ -2043,7 +2075,8 @@ int dmar_set_interrupt(struct intel_iommu *iommu)
 		return -EINVAL;
 	}
 
-	ret = request_irq(irq, dmar_fault, IRQF_NO_THREAD, iommu->name, iommu);
+	ret = request_threaded_irq(irq, NULL, dmar_fault, IRQF_ONESHOT,
+				   iommu->name, iommu);
 	if (ret)
 		pr_err("Can't request irq\n");
 	return ret;
@@ -2051,30 +2084,6 @@ int dmar_set_interrupt(struct intel_iommu *iommu)
 
 int __init enable_drhd_fault_handling(void)
 {
-	struct dmar_drhd_unit *drhd;
-	struct intel_iommu *iommu;
-
-	/*
-	 * Enable fault control interrupt.
-	 */
-	for_each_iommu(iommu, drhd) {
-		u32 fault_status;
-		int ret = dmar_set_interrupt(iommu);
-
-		if (ret) {
-			pr_err("DRHD %Lx: failed to enable fault, interrupt, ret %d\n",
-			       (unsigned long long)drhd->reg_base_addr, ret);
-			return -1;
-		}
-
-		/*
-		 * Clear any previous faults.
-		 */
-		dmar_fault(iommu->irq, iommu);
-		fault_status = readl(iommu->reg + DMAR_FSTS_REG);
-		writel(fault_status, iommu->reg + DMAR_FSTS_REG);
-	}
-
 	return 0;
 }
 
