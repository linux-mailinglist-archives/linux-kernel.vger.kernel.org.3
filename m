Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D865551CB3
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 15:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344342AbiFTNNj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 09:13:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343926AbiFTNJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 09:09:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8DA31AF1B
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 06:04:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 134EAB81092
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 13:04:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46F20C341C6
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 13:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655730291;
        bh=VGb1UMRHEAmOKUFKa8bAfkgCj94jjy2dHYS7GIJjBQU=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=uW+WHSDpgeyB5anm/xmsBkI88vmM8vx0un7AxmBzLFEw15dsvwSV3F5jJKZG0MF8n
         hENVLga/ymTMzMRbUkBvBfME9cdCsx9Ls4HevJc3CgnjFkms6cx2CEyvjvolb9CO1R
         6IZauqnxmPwGVFksHFkWB0xeJIcnxTVyeT/Kv2QwnHXQRl+i8UA/+iL/mlRJNVAw/t
         mOxiG5GKsWcPk/f4tDeTxGSky/BnhWI/fWcr596iztJB6GgO7cb3KAX7fSJStKg5xB
         4a13/UZmRMAwBqiuEWVDAR47SM95ny3Oo1hSSQ/ibWck2/tOeXicVox+zVNkQu6kO9
         rWY20rjqyedMw==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 11/17] habanalabs: remove unused get_dma_desc_list_size
Date:   Mon, 20 Jun 2022 16:04:26 +0300
Message-Id: <20220620130432.1180451-11-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220620130432.1180451-1-ogabbay@kernel.org>
References: <20220620130432.1180451-1-ogabbay@kernel.org>
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

This asic callback function is not called anymore from the common code.
The asic-specific function itself is called but from within the
asic-specific code.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/habanalabs.h | 3 ---
 drivers/misc/habanalabs/gaudi/gaudi.c       | 1 -
 drivers/misc/habanalabs/goya/goya.c         | 1 -
 3 files changed, 5 deletions(-)

diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 3a0f6dca8361..94893305b928 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -1260,7 +1260,6 @@ struct fw_load_mgr {
  * @hl_dma_unmap_sgtable: DMA unmap scatter-gather table.
  * @cs_parser: parse Command Submission.
  * @asic_dma_map_sgtable: DMA map scatter-gather table.
- * @get_dma_desc_list_size: get number of LIN_DMA packets required for CB.
  * @add_end_of_cb_packets: Add packets to the end of CB, if device requires it.
  * @update_eq_ci: update event queue CI.
  * @context_switch: called upon ASID context switch.
@@ -1379,8 +1378,6 @@ struct hl_asic_funcs {
 	int (*cs_parser)(struct hl_device *hdev, struct hl_cs_parser *parser);
 	int (*asic_dma_map_sgtable)(struct hl_device *hdev, struct sg_table *sgt,
 				enum dma_data_direction dir);
-	u32 (*get_dma_desc_list_size)(struct hl_device *hdev,
-					struct sg_table *sgt);
 	void (*add_end_of_cb_packets)(struct hl_device *hdev,
 					void *kernel_address, u32 len,
 					u64 cq_addr, u32 cq_val, u32 msix_num,
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 31e702846f7a..1156ec7dacc1 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -9315,7 +9315,6 @@ static const struct hl_asic_funcs gaudi_funcs = {
 	.hl_dma_unmap_sgtable = hl_dma_unmap_sgtable,
 	.cs_parser = gaudi_cs_parser,
 	.asic_dma_map_sgtable = hl_dma_map_sgtable,
-	.get_dma_desc_list_size = gaudi_get_dma_desc_list_size,
 	.add_end_of_cb_packets = gaudi_add_end_of_cb_packets,
 	.update_eq_ci = gaudi_update_eq_ci,
 	.context_switch = gaudi_context_switch,
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 4cde505a7416..64590fc55dc9 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -5461,7 +5461,6 @@ static const struct hl_asic_funcs goya_funcs = {
 	.hl_dma_unmap_sgtable = hl_dma_unmap_sgtable,
 	.cs_parser = goya_cs_parser,
 	.asic_dma_map_sgtable = hl_dma_map_sgtable,
-	.get_dma_desc_list_size = goya_get_dma_desc_list_size,
 	.add_end_of_cb_packets = goya_add_end_of_cb_packets,
 	.update_eq_ci = goya_update_eq_ci,
 	.context_switch = goya_context_switch,
-- 
2.25.1

