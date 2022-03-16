Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A54084DAE64
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 11:43:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355188AbiCPKoO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 06:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238075AbiCPKoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 06:44:13 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 026CF13DCC
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 03:42:58 -0700 (PDT)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4KJRYy4Pd7z1GCMq;
        Wed, 16 Mar 2022 18:37:58 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Wed, 16 Mar
 2022 18:42:56 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <ruscur@russell.cc>, <oohall@gmail.com>, <mpe@ellerman.id.au>,
        <benh@kernel.crashing.org>, <paulus@samba.org>,
        <nick.child@ibm.com>, <yuehaibing@huawei.com>,
        <christophe.leroy@csgroup.eu>
CC:     <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 -next] powerpc/eeh: Remove unused inline functions
Date:   Wed, 16 Mar 2022 18:42:39 +0800
Message-ID: <20220316104239.26508-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pseries_eeh_init_edev() is exclusively in eeh_pseries.c,
make it static and remove unused inline function.
pseries_eeh_init_edev_recursive() is only called from files build
wich CONFIG_HOTPLUG_PCI_RPA which depends on CONFIG_PSERIES and
CONFIG_EEH, so can remove the unused inline version.

Suggested-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
v2: remove unused inline function instead of corret it.
---
 arch/powerpc/include/asm/eeh.h               | 4 ----
 arch/powerpc/platforms/pseries/eeh_pseries.c | 4 +++-
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index bd513fd49be9..8304727fba55 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -354,11 +354,7 @@ static inline int eeh_phb_pe_create(struct pci_controller *phb) { return 0; }
 #endif /* CONFIG_EEH */
 
 #if defined(CONFIG_PPC_PSERIES) && defined(CONFIG_EEH)
-void pseries_eeh_init_edev(struct pci_dn *pdn);
 void pseries_eeh_init_edev_recursive(struct pci_dn *pdn);
-#else
-static inline void pseries_eeh_add_device_early(struct pci_dn *pdn) { }
-static inline void pseries_eeh_add_device_tree_early(struct pci_dn *pdn) { }
 #endif
 
 #ifdef CONFIG_PPC64
diff --git a/arch/powerpc/platforms/pseries/eeh_pseries.c b/arch/powerpc/platforms/pseries/eeh_pseries.c
index 09fafcf2d3a0..f9af879c0222 100644
--- a/arch/powerpc/platforms/pseries/eeh_pseries.c
+++ b/arch/powerpc/platforms/pseries/eeh_pseries.c
@@ -43,6 +43,8 @@ static int ibm_get_config_addr_info;
 static int ibm_get_config_addr_info2;
 static int ibm_configure_pe;
 
+static void pseries_eeh_init_edev(struct pci_dn *pdn);
+
 static void pseries_pcibios_bus_add_device(struct pci_dev *pdev)
 {
 	struct pci_dn *pdn = pci_get_pdn(pdev);
@@ -359,7 +361,7 @@ static struct eeh_pe *pseries_eeh_pe_get_parent(struct eeh_dev *edev)
  * This function takes care of the initialisation and inserts the eeh_dev
  * into the correct eeh_pe. If no eeh_pe exists we'll allocate one.
  */
-void pseries_eeh_init_edev(struct pci_dn *pdn)
+static void pseries_eeh_init_edev(struct pci_dn *pdn)
 {
 	struct eeh_pe pe, *parent;
 	struct eeh_dev *edev;
-- 
2.17.1

