Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 094E252C193
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 19:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240943AbiERRhM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 13:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240945AbiERRhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 13:37:06 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 891AA11E1E3
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 10:37:04 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1CB6723A;
        Wed, 18 May 2022 10:37:04 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1BC3F3F718;
        Wed, 18 May 2022 10:37:03 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     joro@8bytes.org, will@kernel.org
Cc:     iommu@lists.linux-foundation.org, john.garry@huawei.com,
        hch@lst.de, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] iommu/dma: Add config for PCI SAC address trick
Date:   Wed, 18 May 2022 18:36:59 +0100
Message-Id: <ef8abf1c6b0839e39b272738fc7bc4d9699c8bcb.1652895419.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.35.3.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For devices stuck behind a conventional PCI bus, saving extra cycles at
33MHz is probably fairly significant. However since native PCI Express
is now the norm for high-performance devices, the optimisation to always
prefer 32-bit addresses for the sake of avoiding DAC is starting to look
rather anachronistic. Technically 32-bit addresses do have shorter TLPs
on PCIe, but unless the device is saturating its link bandwidth with
small transfers it seems unlikely that the difference is appreciable.

What definitely is appreciable, however, is that the IOVA allocator
doesn't behave all that well once the 32-bit space starts getting full.
As DMA working sets get bigger, this optimisation increasingly backfires
and adds considerable overhead to the dma_map path for use-cases like
high-bandwidth networking. We've increasingly bandaged the allocator
in attempts to mitigate this, but it remains fundamentally at odds with
other valid requirements to try as hard as possible to satisfy a request
within the given limit; what we really need is to just avoid this odd
notion of a speculative allocation when it isn't beneficial anyway.

Unfortunately that's where things get awkward... Having been present on
x86 for 15 years or so now, it turns out there are systems which fail to
properly define the upper limit of usable IOVA space for certain devices
and this trick was the only thing letting them work OK. I had a similar
ulterior motive for a couple of early arm64 systems when originally
adding it to iommu-dma, but those really should now be fixed with proper
firmware bindings, and other arm64 users really need it out of the way,
so let's just leave it default-on for x86.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/Kconfig     | 24 ++++++++++++++++++++++++
 drivers/iommu/dma-iommu.c |  2 +-
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index c79a0df090c0..bf9b295f1c89 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -144,6 +144,30 @@ config IOMMU_DMA
 	select IRQ_MSI_IOMMU
 	select NEED_SG_DMA_LENGTH
 
+config IOMMU_DMA_PCI_SAC_OPT
+	bool "Enable 64-bit legacy PCI optimisation by default"
+	depends on IOMMU_DMA
+	default X86
+	help
+	  Enable by default an IOMMU optimisation for 64-bit legacy PCI devices,
+	  wherein the DMA API layer will always first try to allocate a 32-bit
+	  DMA address suitable for a single address cycle, before falling back
+	  to allocating from the full usable address range. If your system has
+	  64-bit legacy PCI devices in 32-bit slots where using dual address
+	  cycles reduces DMA throughput significantly, this optimisation may be
+	  beneficial to overall performance.
+
+	  If you have a modern PCI Express based system, it should usually be
+	  safe to say "n" here and avoid the potential extra allocation overhead.
+	  However, beware that this optimisation has also historically papered
+	  over bugs where the IOMMU address range above 32 bits is not fully
+	  usable. If device DMA problems and/or IOMMU faults start occurring
+	  with IOMMU translation enabled after disabling this option, it is
+	  likely a sign of a latent driver or firmware/BIOS bug.
+
+	  If this option is not set, the optimisation can be enabled at
+	  boot time with the "iommu.forcedac=0" command-line argument.
+
 # Shared Virtual Addressing
 config IOMMU_SVA
 	bool
diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 09f6e1c0f9c0..c8d409d3f861 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -66,7 +66,7 @@ struct iommu_dma_cookie {
 };
 
 static DEFINE_STATIC_KEY_FALSE(iommu_deferred_attach_enabled);
-bool iommu_dma_forcedac __read_mostly;
+bool iommu_dma_forcedac __read_mostly = !IS_ENABLED(CONFIG_IOMMU_DMA_PCI_SAC_OPT);
 
 static int __init iommu_dma_forcedac_setup(char *str)
 {
-- 
2.35.3.dirty

