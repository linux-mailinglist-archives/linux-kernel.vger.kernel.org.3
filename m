Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90CCD4936D1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 10:08:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352816AbiASJHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 04:07:46 -0500
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:44598 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1352352AbiASJHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 04:07:43 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R371e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=zelin.deng@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0V2GH.UM_1642583260;
Received: from localhost(mailfrom:zelin.deng@linux.alibaba.com fp:SMTPD_---0V2GH.UM_1642583260)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 19 Jan 2022 17:07:40 +0800
From:   Zelin Deng <zelin.deng@linux.alibaba.com>
To:     David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Kyung Min Park <kyung.min.park@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iommu/vt-d: Do not dump pasid table entries in kdump kernel
Date:   Wed, 19 Jan 2022 17:07:40 +0800
Message-Id: <1642583260-21095-1-git-send-email-zelin.deng@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In kdump kernel PASID translations won't be copied from previous kernel
even if scalable-mode is enabled, so pages of PASID translations are
non-present in kdump kernel. Attempt to access those address will cause
PF fault:

[   13.396476] DMAR: DRHD: handling fault status reg 3
[   13.396478] DMAR: [DMA Read NO_PASID] Request device [81:00.0] fault addr 0xffffd000 [fault reason 0x59] SM: Present bit in PA$
[   13.396480] DMAR: Dump dmar5 table entries for IOVA 0xffffd000
[   13.396481] DMAR: scalable mode root entry: hi 0x0000000000000000, low 0x00000000460d1001
[   13.396482] DMAR: context entry: hi 0x0000000000000008, low 0x00000010c4237401
[   13.396485] BUG: unable to handle page fault for address: ff110010c4237000
[   13.396486] #PF: supervisor read access in kernel mode
[   13.396487] #PF: error_code(0x0000) - not-present page
[   13.396488] PGD 5d201067 P4D 5d202067 PUD 0
[   13.396490] Oops: 0000 [#1] PREEMPT SMP NOPTI
[   13.396491] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.16.0-rc6-next-20211224+ #6
[   13.396493] Hardware name: Intel Corporation EAGLESTREAM/EAGLESTREAM, BIOS EGSDCRB1.86B.0067.D12.2110190950 10/19/2021
[   13.396494] RIP: 0010:dmar_fault_dump_ptes+0x13b/0x295

Hence skip dumping pasid table entries if in kdump kernel.

Fixes: 914ff7719e8a (“iommu/vt-d: Dump DMAR translation structure when DMA fault occurs”)
Signed-off-by: Zelin Deng <zelin.deng@linux.alibaba.com>
---
 drivers/iommu/intel/iommu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 92fea3fb..f0134cf 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1074,6 +1074,12 @@ void dmar_fault_dump_ptes(struct intel_iommu *iommu, u16 source_id,
 	if (!sm_supported(iommu))
 		goto pgtable_walk;
 
+	/* PASID translations is not copied, skip dumping pasid table entries
+	 * otherwise non-present page will be accessed.
+	 */
+	if (is_kdump_kernel())
+		goto pgtable_walk;
+
 	/* get the pointer to pasid directory entry */
 	dir = phys_to_virt(ctx_entry->lo & VTD_PAGE_MASK);
 	if (!dir) {
-- 
1.8.3.1

