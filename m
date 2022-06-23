Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF908558A51
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 22:43:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbiFWUma (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 16:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbiFWUmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 16:42:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4849162719
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 13:42:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DA2EBB8253A
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 20:42:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1CF6C341C0;
        Thu, 23 Jun 2022 20:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656016939;
        bh=Rv/AjYz5QxaXbECmH5MQV4wfwmYyXM0aq2nM+xVo5Uo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hVGUXMHyq/20YYPv6AMlD5kVfvdK0tKKlujXHjHovkTLFtvNb3Ca1ydAByisUegz0
         NJ2fwsPNETzMtJ5pQVM9XMbYPg8qdCwseGY3X/r8NVRgGZSv5MmOcwkqMGFxQkieHW
         FWz83FSiTu8VFDYZL+bksLAmR2c9veMirPyfkp2CUlzN1m5tmRUzjdbP7/4t80udLA
         whVLgUz+AjYeQsy89JdaP2tfqR/cjXe+2cRiotQnHqfw45kGsHbiFYu0dBt+Yt1gsC
         vs4Z2RicpXsqdkVXrI1QbUtohvkkaHfzs0lcYSnRZXwKQzUowISfnxj/PTSbAbrpq1
         +cKsAzEWnOZ6A==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Yuri Nudelman <ynudelman@habana.ai>
Subject: [PATCH 3/9] habanalabs/gaudi: fix a race condition causing DMAR error
Date:   Thu, 23 Jun 2022 23:42:06 +0300
Message-Id: <20220623204212.1628709-3-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220623204212.1628709-1-ogabbay@kernel.org>
References: <20220623204212.1628709-1-ogabbay@kernel.org>
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

From: Yuri Nudelman <ynudelman@habana.ai>

There is a rare race condition in CB completion mechanism, that can
occur under a very high pressure of command submissions.
The preconditions for this to happen are:

 1. There should be enough command submissions for the pre-allocated
    patched CB pool to run out of commands. At this stage we start
    allocating new patched CBs as they arrive.
 2. CB size has to be exactly (128*n + 104)B for some n, i.e. 24B below
    a cache line end.

The flow:

 1. Two command buffers being completed on different streams, at the
    same time. Denote those CB1 and CB2.
 2. Each command buffer is injected with two messages, 16B each - one
    for a HBW update of the completion queue, another to raise
    interrupt.
 3. Assume CB1 updated the completion queue and raise the interrupt.
 4. Assume CB2 updated the completion queue but did not raise the
    interrupt yet.
 5. The host receives the interrupt. It goes over the completion queue
    and sees two completions - CB1 and CB2. Release them both.
 6. CB2 performs the last command. The problem is that the last command
    is split between 2 cache lines. So to read the last 8B of the last
    command, it has to access the host again. Problem is - CB2 is
    already released. This causes a DMAR error.

The solution to this problem is simply to make sure the last two
commands in the CB are always in the same cache line, using NOP padding.

Signed-off-by: Yuri Nudelman <ynudelman@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/habanalabs.h |  1 +
 drivers/misc/habanalabs/common/hw_queue.c   |  1 +
 drivers/misc/habanalabs/gaudi/gaudi.c       | 46 +++++++++++++++------
 drivers/misc/habanalabs/goya/goya.c         |  4 +-
 drivers/misc/habanalabs/goya/goyaP.h        |  4 +-
 5 files changed, 40 insertions(+), 16 deletions(-)

diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 931fa7092646..44752e5954ca 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -1380,6 +1380,7 @@ struct hl_asic_funcs {
 				enum dma_data_direction dir);
 	void (*add_end_of_cb_packets)(struct hl_device *hdev,
 					void *kernel_address, u32 len,
+					u32 original_len,
 					u64 cq_addr, u32 cq_val, u32 msix_num,
 					bool eb);
 	void (*update_eq_ci)(struct hl_device *hdev, u32 val);
diff --git a/drivers/misc/habanalabs/common/hw_queue.c b/drivers/misc/habanalabs/common/hw_queue.c
index 6103e479e855..32408887dd7c 100644
--- a/drivers/misc/habanalabs/common/hw_queue.c
+++ b/drivers/misc/habanalabs/common/hw_queue.c
@@ -308,6 +308,7 @@ static void ext_queue_schedule_job(struct hl_cs_job *job)
 	cq_addr = cq->bus_address + cq->pi * sizeof(struct hl_cq_entry);
 
 	hdev->asic_funcs->add_end_of_cb_packets(hdev, cb->kernel_address, len,
+						job->user_cb_size,
 						cq_addr,
 						le32_to_cpu(cq_pkt.data),
 						q->msi_vec,
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 172c21f262e7..453de3d27d0c 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -1423,6 +1423,19 @@ static int gaudi_collective_wait_init_cs(struct hl_cs *cs)
 	return 0;
 }
 
+static u32 gaudi_get_patched_cb_extra_size(u32 user_cb_size)
+{
+	u32 cacheline_end, additional_commands;
+
+	cacheline_end = round_up(user_cb_size, DEVICE_CACHE_LINE_SIZE);
+	additional_commands = sizeof(struct packet_msg_prot) * 2;
+
+	if (user_cb_size + additional_commands > cacheline_end)
+		return cacheline_end - user_cb_size + additional_commands;
+	else
+		return additional_commands;
+}
+
 static int gaudi_collective_wait_create_job(struct hl_device *hdev,
 		struct hl_ctx *ctx, struct hl_cs *cs,
 		enum hl_collective_mode mode, u32 queue_id, u32 wait_queue_id,
@@ -1443,7 +1456,7 @@ static int gaudi_collective_wait_create_job(struct hl_device *hdev,
 		 * 1 fence packet
 		 * 4 msg short packets for monitor 2 configuration
 		 * 1 fence packet
-		 * 2 msg prot packets for completion and MSI-X
+		 * 2 msg prot packets for completion and MSI
 		 */
 		cb_size = sizeof(struct packet_msg_short) * 8 +
 				sizeof(struct packet_fence) * 2 +
@@ -5337,11 +5350,13 @@ static int gaudi_validate_cb(struct hl_device *hdev,
 
 	/*
 	 * The new CB should have space at the end for two MSG_PROT packets:
-	 * 1. A packet that will act as a completion packet
-	 * 2. A packet that will generate MSI-X interrupt
+	 * 1. Optional NOP padding for cacheline alignment
+	 * 2. A packet that will act as a completion packet
+	 * 3. A packet that will generate MSI interrupt
 	 */
 	if (parser->completion)
-		parser->patched_cb_size += sizeof(struct packet_msg_prot) * 2;
+		parser->patched_cb_size += gaudi_get_patched_cb_extra_size(
+			parser->patched_cb_size);
 
 	return rc;
 }
@@ -5564,13 +5579,14 @@ static int gaudi_parse_cb_mmu(struct hl_device *hdev,
 	int rc;
 
 	/*
-	 * The new CB should have space at the end for two MSG_PROT pkt:
-	 * 1. A packet that will act as a completion packet
-	 * 2. A packet that will generate MSI interrupt
+	 * The new CB should have space at the end for two MSG_PROT packets:
+	 * 1. Optional NOP padding for cacheline alignment
+	 * 2. A packet that will act as a completion packet
+	 * 3. A packet that will generate MSI interrupt
 	 */
 	if (parser->completion)
 		parser->patched_cb_size = parser->user_cb_size +
-				sizeof(struct packet_msg_prot) * 2;
+				gaudi_get_patched_cb_extra_size(parser->user_cb_size);
 	else
 		parser->patched_cb_size = parser->user_cb_size;
 
@@ -5745,18 +5761,24 @@ static int gaudi_cs_parser(struct hl_device *hdev, struct hl_cs_parser *parser)
 		return gaudi_parse_cb_no_mmu(hdev, parser);
 }
 
-static void gaudi_add_end_of_cb_packets(struct hl_device *hdev,
-					void *kernel_address, u32 len,
-					u64 cq_addr, u32 cq_val, u32 msi_vec,
-					bool eb)
+static void gaudi_add_end_of_cb_packets(struct hl_device *hdev, void *kernel_address,
+				u32 len, u32 original_len, u64 cq_addr, u32 cq_val,
+				u32 msi_vec, bool eb)
 {
 	struct gaudi_device *gaudi = hdev->asic_specific;
 	struct packet_msg_prot *cq_pkt;
+	struct packet_nop *cq_padding;
 	u64 msi_addr;
 	u32 tmp;
 
+	cq_padding = kernel_address + original_len;
 	cq_pkt = kernel_address + len - (sizeof(struct packet_msg_prot) * 2);
 
+	while ((void *)cq_padding < (void *)cq_pkt) {
+		cq_padding->ctl = FIELD_PREP(GAUDI_PKT_CTL_OPCODE_MASK, PACKET_NOP);
+		cq_padding++;
+	}
+
 	tmp = FIELD_PREP(GAUDI_PKT_CTL_OPCODE_MASK, PACKET_MSG_PROT);
 	tmp |= FIELD_PREP(GAUDI_PKT_CTL_MB_MASK, 1);
 
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 64590fc55dc9..40c082cafbd7 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -4166,8 +4166,8 @@ int goya_cs_parser(struct hl_device *hdev, struct hl_cs_parser *parser)
 }
 
 void goya_add_end_of_cb_packets(struct hl_device *hdev, void *kernel_address,
-				u32 len, u64 cq_addr, u32 cq_val, u32 msix_vec,
-				bool eb)
+				u32 len, u32 original_len, u64 cq_addr, u32 cq_val,
+				u32 msix_vec, bool eb)
 {
 	struct packet_msg_prot *cq_pkt;
 	u32 tmp;
diff --git a/drivers/misc/habanalabs/goya/goyaP.h b/drivers/misc/habanalabs/goya/goyaP.h
index 647f57402616..54b5b6125df5 100644
--- a/drivers/misc/habanalabs/goya/goyaP.h
+++ b/drivers/misc/habanalabs/goya/goyaP.h
@@ -230,8 +230,8 @@ void goya_handle_eqe(struct hl_device *hdev, struct hl_eq_entry *eq_entry);
 void *goya_get_events_stat(struct hl_device *hdev, bool aggregate, u32 *size);
 
 void goya_add_end_of_cb_packets(struct hl_device *hdev, void *kernel_address,
-				u32 len, u64 cq_addr, u32 cq_val, u32 msix_vec,
-				bool eb);
+				u32 len, u32 original_len, u64 cq_addr, u32 cq_val,
+				u32 msix_vec, bool eb);
 int goya_cs_parser(struct hl_device *hdev, struct hl_cs_parser *parser);
 int goya_scrub_device_mem(struct hl_device *hdev, u64 addr, u64 size);
 void *goya_get_int_queue_base(struct hl_device *hdev, u32 queue_id,
-- 
2.25.1

