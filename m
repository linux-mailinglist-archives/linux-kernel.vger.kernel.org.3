Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A6BE559ADE
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 16:04:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232246AbiFXOEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 10:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbiFXOEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 10:04:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8CC34ECC5
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 07:04:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 867B961FAE
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 14:04:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53F22C3411C
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 14:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656079474;
        bh=FW7sXbsJBw8Y/8U8TUxU64sk7YbTtpgVSqVkbt4IH0I=;
        h=From:To:Subject:Date:From;
        b=r2CMBn5H01CfZfRBlJIECp+tqrgBLjqg4T6ELrtcBuinOG8N9TxNdMevKV9PVgWmQ
         Xv3/lDOW2CGuiOeMQuYWGAR4FMik5BXgVIxxTZe4AOdRW/GUC9dUD1P1vQT2nfEpgC
         murqdz2HKfPchaKQGA1XPgAUEaV58M63WATPa0IYZ5Kpkhwd1oE/qxACMSjYWu4K0+
         n9dr7o2oKG3qFk6U9sK6I+bnjDSnDsbyMSr0BAUe7WYIwCsOcBTLHugjBSwLREOeJY
         X0R5O6B2GjnUDXBcaPHDG1Xx0veDOAzPLUkn6luYzvRPiLkcvnj3/LxfVA78U8fi95
         GcYzDwd7DzbqQ==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] habanalabs/goya: add dma direction enum to uapi file
Date:   Fri, 24 Jun 2022 17:04:25 +0300
Message-Id: <20220624140429.1778402-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The values in this enum are not used by h/w but are a contract
between userspace and the kernel driver so they must be defined
in the uapi file.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/goya/goya.c | 28 ++++++++++++++--------------
 include/uapi/misc/habanalabs.h      | 27 +++++++++++++++++++++++++++
 2 files changed, 41 insertions(+), 14 deletions(-)

diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 25b1e3e139e8..411a4be09aa6 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -3403,7 +3403,7 @@ static int goya_validate_dma_pkt_host(struct hl_device *hdev,
 {
 	u64 device_memory_addr, addr;
 	enum dma_data_direction dir;
-	enum goya_dma_direction user_dir;
+	enum hl_goya_dma_direction user_dir;
 	bool sram_addr = true;
 	bool skip_host_mem_pin = false;
 	bool user_memset;
@@ -3419,7 +3419,7 @@ static int goya_validate_dma_pkt_host(struct hl_device *hdev,
 			GOYA_PKT_LIN_DMA_CTL_MEMSET_SHIFT;
 
 	switch (user_dir) {
-	case DMA_HOST_TO_DRAM:
+	case HL_DMA_HOST_TO_DRAM:
 		dev_dbg(hdev->dev, "DMA direction is HOST --> DRAM\n");
 		dir = DMA_TO_DEVICE;
 		sram_addr = false;
@@ -3429,7 +3429,7 @@ static int goya_validate_dma_pkt_host(struct hl_device *hdev,
 			skip_host_mem_pin = true;
 		break;
 
-	case DMA_DRAM_TO_HOST:
+	case HL_DMA_DRAM_TO_HOST:
 		dev_dbg(hdev->dev, "DMA direction is DRAM --> HOST\n");
 		dir = DMA_FROM_DEVICE;
 		sram_addr = false;
@@ -3437,7 +3437,7 @@ static int goya_validate_dma_pkt_host(struct hl_device *hdev,
 		device_memory_addr = le64_to_cpu(user_dma_pkt->src_addr);
 		break;
 
-	case DMA_HOST_TO_SRAM:
+	case HL_DMA_HOST_TO_SRAM:
 		dev_dbg(hdev->dev, "DMA direction is HOST --> SRAM\n");
 		dir = DMA_TO_DEVICE;
 		addr = le64_to_cpu(user_dma_pkt->src_addr);
@@ -3446,14 +3446,14 @@ static int goya_validate_dma_pkt_host(struct hl_device *hdev,
 			skip_host_mem_pin = true;
 		break;
 
-	case DMA_SRAM_TO_HOST:
+	case HL_DMA_SRAM_TO_HOST:
 		dev_dbg(hdev->dev, "DMA direction is SRAM --> HOST\n");
 		dir = DMA_FROM_DEVICE;
 		addr = le64_to_cpu(user_dma_pkt->dst_addr);
 		device_memory_addr = le64_to_cpu(user_dma_pkt->src_addr);
 		break;
 	default:
-		dev_err(hdev->dev, "DMA direction is undefined\n");
+		dev_err(hdev->dev, "DMA direction %d is unsupported/undefined\n", user_dir);
 		return -EFAULT;
 	}
 
@@ -3505,14 +3505,14 @@ static int goya_validate_dma_pkt_no_host(struct hl_device *hdev,
 				struct packet_lin_dma *user_dma_pkt)
 {
 	u64 sram_memory_addr, dram_memory_addr;
-	enum goya_dma_direction user_dir;
+	enum hl_goya_dma_direction user_dir;
 	u32 ctl;
 
 	ctl = le32_to_cpu(user_dma_pkt->ctl);
 	user_dir = (ctl & GOYA_PKT_LIN_DMA_CTL_DMA_DIR_MASK) >>
 			GOYA_PKT_LIN_DMA_CTL_DMA_DIR_SHIFT;
 
-	if (user_dir == DMA_DRAM_TO_SRAM) {
+	if (user_dir == HL_DMA_DRAM_TO_SRAM) {
 		dev_dbg(hdev->dev, "DMA direction is DRAM --> SRAM\n");
 		dram_memory_addr = le64_to_cpu(user_dma_pkt->src_addr);
 		sram_memory_addr = le64_to_cpu(user_dma_pkt->dst_addr);
@@ -3549,7 +3549,7 @@ static int goya_validate_dma_pkt_no_mmu(struct hl_device *hdev,
 				struct hl_cs_parser *parser,
 				struct packet_lin_dma *user_dma_pkt)
 {
-	enum goya_dma_direction user_dir;
+	enum hl_goya_dma_direction user_dir;
 	u32 ctl;
 	int rc;
 
@@ -3574,7 +3574,7 @@ static int goya_validate_dma_pkt_no_mmu(struct hl_device *hdev,
 		return -EINVAL;
 	}
 
-	if ((user_dir == DMA_DRAM_TO_SRAM) || (user_dir == DMA_SRAM_TO_DRAM))
+	if ((user_dir == HL_DMA_DRAM_TO_SRAM) || (user_dir == HL_DMA_SRAM_TO_DRAM))
 		rc = goya_validate_dma_pkt_no_host(hdev, parser, user_dma_pkt);
 	else
 		rc = goya_validate_dma_pkt_host(hdev, parser, user_dma_pkt);
@@ -3781,7 +3781,7 @@ static int goya_patch_dma_packet(struct hl_device *hdev,
 	u32 count, dma_desc_cnt;
 	u64 len, len_next;
 	dma_addr_t dma_addr, dma_addr_next;
-	enum goya_dma_direction user_dir;
+	enum hl_goya_dma_direction user_dir;
 	u64 device_memory_addr, addr;
 	enum dma_data_direction dir;
 	struct sg_table *sgt;
@@ -3797,14 +3797,14 @@ static int goya_patch_dma_packet(struct hl_device *hdev,
 	user_memset = (ctl & GOYA_PKT_LIN_DMA_CTL_MEMSET_MASK) >>
 			GOYA_PKT_LIN_DMA_CTL_MEMSET_SHIFT;
 
-	if ((user_dir == DMA_DRAM_TO_SRAM) || (user_dir == DMA_SRAM_TO_DRAM) ||
+	if ((user_dir == HL_DMA_DRAM_TO_SRAM) || (user_dir == HL_DMA_SRAM_TO_DRAM) ||
 			(user_dma_pkt->tsize == 0)) {
 		memcpy(new_dma_pkt, user_dma_pkt, sizeof(*new_dma_pkt));
 		*new_dma_pkt_size = sizeof(*new_dma_pkt);
 		return 0;
 	}
 
-	if ((user_dir == DMA_HOST_TO_DRAM) || (user_dir == DMA_HOST_TO_SRAM)) {
+	if ((user_dir == HL_DMA_HOST_TO_DRAM) || (user_dir == HL_DMA_HOST_TO_SRAM)) {
 		addr = le64_to_cpu(user_dma_pkt->src_addr);
 		device_memory_addr = le64_to_cpu(user_dma_pkt->dst_addr);
 		dir = DMA_TO_DEVICE;
@@ -4804,7 +4804,7 @@ static int goya_memset_device_memory(struct hl_device *hdev, u64 addr, u64 size,
 				(1 << GOYA_PKT_LIN_DMA_CTL_WO_SHIFT) |
 				(1 << GOYA_PKT_CTL_RB_SHIFT) |
 				(1 << GOYA_PKT_CTL_MB_SHIFT));
-		ctl |= (is_dram ? DMA_HOST_TO_DRAM : DMA_HOST_TO_SRAM) <<
+		ctl |= (is_dram ? HL_DMA_HOST_TO_DRAM : HL_DMA_HOST_TO_SRAM) <<
 				GOYA_PKT_LIN_DMA_CTL_DMA_DIR_SHIFT;
 		lin_dma_pkt->ctl = cpu_to_le32(ctl);
 
diff --git a/include/uapi/misc/habanalabs.h b/include/uapi/misc/habanalabs.h
index 78aecea4684d..41a0fa345e4e 100644
--- a/include/uapi/misc/habanalabs.h
+++ b/include/uapi/misc/habanalabs.h
@@ -275,6 +275,33 @@ enum hl_gaudi_pll_index {
 	HL_GAUDI_PLL_MAX
 };
 
+/**
+ * enum hl_goya_dma_direction - Direction of DMA operation inside a LIN_DMA packet that is
+ *                              submitted to the GOYA's DMA QMAN. This attribute is not relevant
+ *                              to the H/W but the kernel driver use it to parse the packet's
+ *                              addresses and patch/validate them.
+ * @HL_DMA_HOST_TO_DRAM: DMA operation from Host memory to GOYA's DDR.
+ * @HL_DMA_HOST_TO_SRAM: DMA operation from Host memory to GOYA's SRAM.
+ * @HL_DMA_DRAM_TO_SRAM: DMA operation from GOYA's DDR to GOYA's SRAM.
+ * @HL_DMA_SRAM_TO_DRAM: DMA operation from GOYA's SRAM to GOYA's DDR.
+ * @HL_DMA_SRAM_TO_HOST: DMA operation from GOYA's SRAM to Host memory.
+ * @HL_DMA_DRAM_TO_HOST: DMA operation from GOYA's DDR to Host memory.
+ * @HL_DMA_DRAM_TO_DRAM: DMA operation from GOYA's DDR to GOYA's DDR.
+ * @HL_DMA_SRAM_TO_SRAM: DMA operation from GOYA's SRAM to GOYA's SRAM.
+ * @HL_DMA_ENUM_MAX: number of values in enum
+ */
+enum hl_goya_dma_direction {
+	HL_DMA_HOST_TO_DRAM,
+	HL_DMA_HOST_TO_SRAM,
+	HL_DMA_DRAM_TO_SRAM,
+	HL_DMA_SRAM_TO_DRAM,
+	HL_DMA_SRAM_TO_HOST,
+	HL_DMA_DRAM_TO_HOST,
+	HL_DMA_DRAM_TO_DRAM,
+	HL_DMA_SRAM_TO_SRAM,
+	HL_DMA_ENUM_MAX
+};
+
 /**
  * enum hl_device_status - Device status information.
  * @HL_DEVICE_STATUS_OPERATIONAL: Device is operational.
-- 
2.25.1

