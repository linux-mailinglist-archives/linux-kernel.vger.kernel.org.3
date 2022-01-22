Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51BA8496DCE
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 20:58:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235035AbiAVT6x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 14:58:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234851AbiAVT6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 14:58:16 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89B9DC06175C
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 11:58:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id DF30BCE09EC
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 19:58:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9C47C004E1
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 19:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642881489;
        bh=2PudwKpNsb0aAT/yVOiIfKcwK/3z4tdrz1xC7uH1ZDg=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=p/i04t+E8uZsx5UYZsvIPhw5llWIUdJwI8UmL5O1MlO78S8n+agTYrdE4RIZQ1MmV
         gZ56wj7QOmAnW0fkSiA5qQ4kB6T9NX35iWWY60xzcz4++Mc/Siw3bhOEYEQFlxkRKF
         1ROrmciBPpp9t+ktYSHUM2JEUJ3rqmXjLYt3WoqwBKikxOgjelu2G8kkNAvqR0PzGT
         jP+Zr+PijvXRTOd6Ktqslga8wMOGvr9oIoEi8LEysfzo7IjxQec/2ST8B86ZokqwK5
         gTY6Cg9y7QOkxBxwpetINUSgh8R1rSKprstZjuSxLsiClzuJ5ps4HFseSKqFwNt2eW
         sMsDrvze1onyg==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 25/30] habanalabs: expose number of user interrupts
Date:   Sat, 22 Jan 2022 21:57:26 +0200
Message-Id: <20220122195731.934494-25-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220122195731.934494-1-ogabbay@kernel.org>
References: <20220122195731.934494-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently we only expose to the user the ID of the first available
user interrupt. To make user interrupts allocation truly dynamic, we
need to also expose the number of user interrupts.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/habanalabs_ioctl.c | 4 ++--
 include/uapi/misc/habanalabs.h                    | 5 +++++
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/habanalabs/common/habanalabs_ioctl.c b/drivers/misc/habanalabs/common/habanalabs_ioctl.c
index d19097576b05..c13a3c2a7013 100644
--- a/drivers/misc/habanalabs/common/habanalabs_ioctl.c
+++ b/drivers/misc/habanalabs/common/habanalabs_ioctl.c
@@ -92,8 +92,8 @@ static int hw_ip_info(struct hl_device *hdev, struct hl_info_args *args)
 	hw_ip.psoc_pci_pll_od = prop->psoc_pci_pll_od;
 	hw_ip.psoc_pci_pll_div_factor = prop->psoc_pci_pll_div_factor;
 
-	hw_ip.first_available_interrupt_id =
-			prop->first_available_user_msix_interrupt;
+	hw_ip.first_available_interrupt_id = prop->first_available_user_msix_interrupt;
+	hw_ip.number_of_user_interrupts = prop->user_interrupt_count;
 	hw_ip.server_type = prop->server_type;
 
 	return copy_to_user(out, &hw_ip,
diff --git a/include/uapi/misc/habanalabs.h b/include/uapi/misc/habanalabs.h
index 371dfc4243b3..12976f7a8d84 100644
--- a/include/uapi/misc/habanalabs.h
+++ b/include/uapi/misc/habanalabs.h
@@ -404,6 +404,8 @@ enum hl_server_type {
  * @cpucp_version: The CPUCP f/w version.
  * @card_name: The card name as passed by the f/w.
  * @dram_page_size: The DRAM physical page size.
+ * @number_of_user_interrupts: The number of interrupts that are available to the userspace
+ *                             application to use. Relevant for Gaudi2 and later.
  */
 struct hl_info_hw_ip_info {
 	__u64 sram_base_address;
@@ -428,6 +430,9 @@ struct hl_info_hw_ip_info {
 	__u8 card_name[HL_INFO_CARD_NAME_MAX_LEN];
 	__u64 reserved2;
 	__u64 dram_page_size;
+	__u32 reserved3;
+	__u16 number_of_user_interrupts;
+	__u16 pad2;
 };
 
 struct hl_info_dram_usage {
-- 
2.25.1

