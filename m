Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B4B6584E7D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 12:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235263AbiG2KEu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 06:04:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiG2KEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 06:04:48 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0D967B794
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 03:04:47 -0700 (PDT)
Received: from lemmy.home.8bytes.org (p549adf92.dip0.t-ipconnect.de [84.154.223.146])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by theia.8bytes.org (Postfix) with ESMTPSA id 794A9DC;
        Fri, 29 Jul 2022 12:04:45 +0200 (CEST)
From:   Joerg Roedel <joro@8bytes.org>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Will Deacon <will@kernel.org>,
        Jerry Snitselaar <jsnitsel@redhat.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, Joerg Roedel <jroedel@suse.de>
Subject: [PATCH] iommu/amd: Fix compile warning in init code
Date:   Fri, 29 Jul 2022 12:04:32 +0200
Message-Id: <20220729100432.22474-1-joro@8bytes.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

A recent commit introduced these compile warnings:

  CC      drivers/iommu/amd/init.o
drivers/iommu/amd/init.c:938:12: error: ‘iommu_init_ga_log’ defined but not used [-Werror=unused-function]
  938 | static int iommu_init_ga_log(struct amd_iommu *iommu)
      |            ^~~~~~~~~~~~~~~~~
drivers/iommu/amd/init.c:902:12: error: ‘iommu_ga_log_enable’ defined but not used [-Werror=unused-function]
  902 | static int iommu_ga_log_enable(struct amd_iommu *iommu)
      |            ^~~~~~~~~~~~~~~~~~~

The warnings appear because both functions are defined when IRQ
remapping is not enabled, but only used when IRQ remapping is enabled.

Fix it by only defining the functions when IRQ remapping is enabled.

Fixes: c5e1a1eb9279 ("iommu/amd: Simplify and Consolidate Virtual APIC (AVIC) Enablement")
Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/amd/init.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 6bbaf6b971e8..fdc642362c14 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -899,9 +899,9 @@ static void free_ga_log(struct amd_iommu *iommu)
 #endif
 }
 
+#ifdef CONFIG_IRQ_REMAP
 static int iommu_ga_log_enable(struct amd_iommu *iommu)
 {
-#ifdef CONFIG_IRQ_REMAP
 	u32 status, i;
 	u64 entry;
 
@@ -931,13 +931,12 @@ static int iommu_ga_log_enable(struct amd_iommu *iommu)
 
 	if (WARN_ON(i >= LOOP_TIMEOUT))
 		return -EINVAL;
-#endif /* CONFIG_IRQ_REMAP */
+
 	return 0;
 }
 
 static int iommu_init_ga_log(struct amd_iommu *iommu)
 {
-#ifdef CONFIG_IRQ_REMAP
 	if (!AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir))
 		return 0;
 
@@ -955,10 +954,8 @@ static int iommu_init_ga_log(struct amd_iommu *iommu)
 err_out:
 	free_ga_log(iommu);
 	return -EINVAL;
-#else
-	return 0;
-#endif /* CONFIG_IRQ_REMAP */
 }
+#endif /* CONFIG_IRQ_REMAP */
 
 static int __init alloc_cwwb_sem(struct amd_iommu *iommu)
 {
-- 
2.36.1

