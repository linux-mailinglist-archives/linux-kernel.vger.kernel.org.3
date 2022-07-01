Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 061E4562FB3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 11:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234348AbiGAJRt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 05:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231218AbiGAJRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 05:17:47 -0400
Received: from ssh248.corpemail.net (ssh248.corpemail.net [210.51.61.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF83E4D4CA
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 02:17:42 -0700 (PDT)
Received: from ([60.208.111.195])
        by ssh248.corpemail.net ((D)) with ASMTP (SSL) id WIT00036;
        Fri, 01 Jul 2022 17:17:36 +0800
Received: from localhost.localdomain (10.200.104.82) by
 jtjnmail201602.home.langchao.com (10.100.2.2) with Microsoft SMTP Server id
 15.1.2507.9; Fri, 1 Jul 2022 17:17:38 +0800
From:   Deming Wang <wangdeming@inspur.com>
To:     <mpe@ellerman.id.au>
CC:     <benh@kernel.crashing.org>, <paulus@samba.org>,
        <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        Deming Wang <wangdeming@inspur.com>
Subject: [PATCH] powerpc/pseries: Add a null judgment after iommu_pseries_alloc_group
Date:   Fri, 1 Jul 2022 05:17:35 -0400
Message-ID: <20220701091735.1584-1-wangdeming@inspur.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.200.104.82]
tUid:   2022701171736651d1779fff6865ab42eefc41774dda2
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We should avoid use the return value directly after  call
iommu_pseries_alloc_group. Because it_may return a null.

Signed-off-by: Deming Wang <wangdeming@inspur.com>
---
 arch/powerpc/platforms/pseries/iommu.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index fba64304e859..801eb9d4bdca 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -649,6 +649,9 @@ static void pci_dma_bus_setup_pSeries(struct pci_bus *bus)
 	pci->phb->dma_window_base_cur = 0x8000000ul;
 
 	pci->table_group = iommu_pseries_alloc_group(pci->phb->node);
+	if (!pci->table_group)
+		return;
+
 	tbl = pci->table_group->tables[0];
 
 	iommu_table_setparms(pci->phb, dn, tbl);
@@ -734,6 +737,9 @@ static void pci_dma_bus_setup_pSeriesLP(struct pci_bus *bus)
 
 	if (!ppci->table_group) {
 		ppci->table_group = iommu_pseries_alloc_group(ppci->phb->node);
+		if (!ppci->table_group)
+			return;
+
 		tbl = ppci->table_group->tables[0];
 		iommu_table_setparms_lpar(ppci->phb, pdn, tbl,
 				ppci->table_group, dma_window);
@@ -765,6 +771,9 @@ static void pci_dma_dev_setup_pSeries(struct pci_dev *dev)
 
 		pr_debug(" --> first child, no bridge. Allocating iommu table.\n");
 		PCI_DN(dn)->table_group = iommu_pseries_alloc_group(phb->node);
+		if (!PCI_DN(dn)->table_group)
+			return;
+
 		tbl = PCI_DN(dn)->table_group->tables[0];
 		iommu_table_setparms(phb, dn, tbl);
 
@@ -1521,6 +1530,9 @@ static void pci_dma_dev_setup_pSeriesLP(struct pci_dev *dev)
 	pci = PCI_DN(pdn);
 	if (!pci->table_group) {
 		pci->table_group = iommu_pseries_alloc_group(pci->phb->node);
+		if (!pci->table_group)
+			return;
+
 		tbl = pci->table_group->tables[0];
 		iommu_table_setparms_lpar(pci->phb, pdn, tbl,
 				pci->table_group, dma_window);
-- 
2.27.0

