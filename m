Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 070BD52341C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 15:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238957AbiEKNVY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 09:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243786AbiEKNUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 09:20:01 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0380C2457BD
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 06:19:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 50E7DCE249C
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 13:19:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 064C0C34110
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 13:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652275192;
        bh=uJNAc1t8T+kTYKJOXUGKSRo17sVrsJjMQmCKXoxR5Vw=;
        h=From:To:Subject:Date:From;
        b=EgUYxmnVxPbxUSeuOXfTuJJgW2izrL8XSCPezZOYfe2SdDFEk2QmKVGyhhEp5bdUZ
         kMKG8BaZXK6dGv3G2T6h33tu+9At77M1L8EO+6OfbT5N3qb3boOcL5SFyzvqvFugmt
         NZM8gXOhGGrHHuYTpy6oE7vfK+S4Ub5t8+KJrGorhWW7xc0mwbdVd+iNXote/8Jnax
         pZEJLjaQmQeoDueTKyljZGnLvtOvD/QAFLT58PQZkjyD7hWJg8YnfNTqIBRcoSNUTA
         l7J6AMc6SaXpwVpRaGdjSz1lQLHB/Nucf+C/PiRZZHQxGdaa38f/2I3/JBhzMhW+Yx
         V0nEAzC1Ca0yA==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] habanalabs: update firmware header
Date:   Wed, 11 May 2022 16:19:46 +0300
Message-Id: <20220511131948.1156471-1-ogabbay@kernel.org>
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

Update cpucp_if.h to latest version.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 .../misc/habanalabs/include/common/cpucp_if.h | 32 ++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/include/common/cpucp_if.h b/drivers/misc/habanalabs/include/common/cpucp_if.h
index 4af5bb695c16..38e44b6cf581 100644
--- a/drivers/misc/habanalabs/include/common/cpucp_if.h
+++ b/drivers/misc/habanalabs/include/common/cpucp_if.h
@@ -568,6 +568,12 @@ struct cpucp_array_data_packet {
 	__le32 data[];
 };
 
+enum cpucp_led_index {
+	CPUCP_LED0_INDEX = 0,
+	CPUCP_LED1_INDEX,
+	CPUCP_LED2_INDEX
+};
+
 enum cpucp_packet_rc {
 	cpucp_packet_success,
 	cpucp_packet_invalid,
@@ -589,7 +595,10 @@ enum cpucp_temp_type {
 	cpucp_temp_offset = 19,
 	cpucp_temp_lowest = 21,
 	cpucp_temp_highest = 22,
-	cpucp_temp_reset_history = 23
+	cpucp_temp_reset_history = 23,
+	cpucp_temp_warn = 24,
+	cpucp_temp_max_crit = 25,
+	cpucp_temp_max_warn = 26,
 };
 
 enum cpucp_in_attributes {
@@ -699,6 +708,7 @@ enum pll_index {
 enum rl_index {
 	TPC_RL = 0,
 	MME_RL,
+	EDMA_RL,
 };
 
 enum pvt_index {
@@ -833,6 +843,7 @@ enum cpucp_serdes_type {
 	TYPE_2_SERDES_TYPE,
 	HLS1_SERDES_TYPE,
 	HLS1H_SERDES_TYPE,
+	HLS2_SERDES_TYPE,
 	UNKNOWN_SERDES_TYPE,
 	MAX_NUM_SERDES_TYPE = UNKNOWN_SERDES_TYPE
 };
@@ -846,9 +857,28 @@ struct cpucp_nic_info {
 	__u8 qsfp_eeprom[CPUCP_NIC_QSFP_EEPROM_MAX_LEN];
 	__le64 auto_neg_mask[CPUCP_NIC_MASK_ARR_LEN];
 	__le16 serdes_type; /* enum cpucp_serdes_type */
+	__le16 tx_swap_map[CPUCP_MAX_NICS];
 	__u8 reserved[6];
 };
 
+#define PAGE_DISCARD_MAX	64
+
+struct page_discard_info {
+	__u8 num_entries;
+	__u8 reserved[7];
+	__le32 mmu_page_idx[PAGE_DISCARD_MAX];
+};
+
+/*
+ * struct ser_val - the SER (symbol error rate) value is represented by "integer * 10 ^ -exp".
+ * @integer: the integer part of the SER value;
+ * @exp: the exponent part of the SER value.
+ */
+struct ser_val {
+	__le16 integer;
+	__le16 exp;
+};
+
 /*
  * struct cpucp_nic_status - describes the status of a NIC port.
  * @port: NIC port index.
-- 
2.25.1

