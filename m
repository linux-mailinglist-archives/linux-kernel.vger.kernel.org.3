Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE6FE56D4B3
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 08:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbiGKGaP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 02:30:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiGKGaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 02:30:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F29D615A
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 23:30:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1B3B6B80D75
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 06:30:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 086AFC34115;
        Mon, 11 Jul 2022 06:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657521008;
        bh=4dmm6fcCZk+sXewwMD07mRmlyFqgLm5LpNmD8IdAyU0=;
        h=From:To:Cc:Subject:Date:From;
        b=KF2plprpEtGm8/TUgEsc6b9mggrBMvS7wHnt1mbYsBLxzgEmKXgyJnAytmJbk5Uvv
         BeUM9FKSXHADn2FzfxwLQCfSrXY5614x8z2+AcE+43a7lxGCsM8euvtcUo7jpgh/6L
         ruAdpOnE99ZdR7gYfSrNdRY2/sFvoqPxjjX/Uao0TXZ+r37z7JRUX8T52rYyo3lQS0
         y2I/a+5IegXu7ii6fBURbtRrdf2h7bIwctSs9yoHwNjunX0TAz5q2fi/Au1hI6OIYy
         ufG77qcq5Gz9pMCU+x9ddRXrrmcNKRvO5wWgADwL6UikS7OY/r4HD9VbVx6W8bzsdu
         yLPVQJsqiljVw==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ohad Sharabi <osharabi@habana.ai>
Subject: [PATCH 01/12] habanalabs: fixes to the poll-timeout macros
Date:   Mon, 11 Jul 2022 09:29:52 +0300
Message-Id: <20220711063003.3182795-1-ogabbay@kernel.org>
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

From: Ohad Sharabi <osharabi@habana.ai>

- use conventional internal macro variables (double underscore prefix)
- adjust address casting
- on register poll using ELBI use ELBI read rather than BAR read on
  error condition
- remove unused macro

Signed-off-by: Ohad Sharabi <osharabi@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/habanalabs.h | 119 +++++++++++++++-----
 1 file changed, 90 insertions(+), 29 deletions(-)

diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 72cb12f2068a..3c51eaca521c 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -2473,9 +2473,11 @@ void hl_wreg(struct hl_device *hdev, u32 reg, u32 val);
 /* Timeout should be longer when working with simulator but cap the
  * increased timeout to some maximum
  */
-#define hl_poll_timeout(hdev, addr, val, cond, sleep_us, timeout_us) \
+#define hl_poll_timeout_common(hdev, addr, val, cond, sleep_us, timeout_us, elbi) \
 ({ \
 	ktime_t __timeout; \
+	u32 __elbi_read; \
+	int __rc = 0; \
 	if (hdev->pdev) \
 		__timeout = ktime_add_us(ktime_get(), timeout_us); \
 	else \
@@ -2484,19 +2486,103 @@ void hl_wreg(struct hl_device *hdev, u32 reg, u32 val);
 					(u64) HL_SIM_MAX_TIMEOUT_US)); \
 	might_sleep_if(sleep_us); \
 	for (;;) { \
-		(val) = RREG32(addr); \
+		if (elbi) { \
+			__rc = hl_pci_elbi_read(hdev, addr, &__elbi_read); \
+			if (__rc) \
+				break; \
+			(val) = __elbi_read; \
+		} else {\
+			(val) = RREG32((u32)addr); \
+		} \
 		if (cond) \
 			break; \
 		if (timeout_us && ktime_compare(ktime_get(), __timeout) > 0) { \
-			(val) = RREG32(addr); \
+			if (elbi) { \
+				__rc = hl_pci_elbi_read(hdev, addr, &__elbi_read); \
+				if (__rc) \
+					break; \
+				(val) = __elbi_read; \
+			} else {\
+				(val) = RREG32((u32)addr); \
+			} \
 			break; \
 		} \
 		if (sleep_us) \
 			usleep_range((sleep_us >> 2) + 1, sleep_us); \
 	} \
-	(cond) ? 0 : -ETIMEDOUT; \
+	__rc ? __rc : ((cond) ? 0 : -ETIMEDOUT); \
 })
 
+#define hl_poll_timeout(hdev, addr, val, cond, sleep_us, timeout_us) \
+		hl_poll_timeout_common(hdev, addr, val, cond, sleep_us, timeout_us, false)
+
+#define hl_poll_timeout_elbi(hdev, addr, val, cond, sleep_us, timeout_us) \
+		hl_poll_timeout_common(hdev, addr, val, cond, sleep_us, timeout_us, true)
+
+/*
+ * poll array of register addresses.
+ * condition is satisfied if all registers values match the expected value.
+ * once some register in the array satisfies the condition it will not be polled again,
+ * this is done both for efficiency and due to some registers are "clear on read".
+ * TODO: use read from PCI bar in other places in the code (SW-91406)
+ */
+#define hl_poll_reg_array_timeout_common(hdev, addr_arr, arr_size, expected_val, sleep_us, \
+						timeout_us, elbi) \
+({ \
+	ktime_t __timeout; \
+	u64 __elem_bitmask; \
+	u32 __read_val;	\
+	u8 __arr_idx;	\
+	int __rc = 0; \
+	\
+	if (hdev->pdev) \
+		__timeout = ktime_add_us(ktime_get(), timeout_us); \
+	else \
+		__timeout = ktime_add_us(ktime_get(),\
+				min(((u64)timeout_us * 10), \
+					(u64) HL_SIM_MAX_TIMEOUT_US)); \
+	\
+	might_sleep_if(sleep_us); \
+	if (arr_size >= 64) \
+		__rc = -EINVAL; \
+	else \
+		__elem_bitmask = BIT_ULL(arr_size) - 1; \
+	for (;;) { \
+		if (__rc) \
+			break; \
+		for (__arr_idx = 0; __arr_idx < (arr_size); __arr_idx++) {	\
+			if (!(__elem_bitmask & BIT_ULL(__arr_idx)))	\
+				continue;	\
+			if (elbi) { \
+				__rc = hl_pci_elbi_read(hdev, (addr_arr)[__arr_idx], &__read_val); \
+				if (__rc) \
+					break; \
+			} else { \
+				__read_val = RREG32((u32)(addr_arr)[__arr_idx]); \
+			} \
+			if (__read_val == (expected_val))	\
+				__elem_bitmask &= ~BIT_ULL(__arr_idx);	\
+		}	\
+		if (__rc || (__elem_bitmask == 0)) \
+			break; \
+		if (timeout_us && ktime_compare(ktime_get(), __timeout) > 0) \
+			break; \
+		if (sleep_us) \
+			usleep_range((sleep_us >> 2) + 1, sleep_us); \
+	} \
+	__rc ? __rc : ((__elem_bitmask == 0) ? 0 : -ETIMEDOUT); \
+})
+
+#define hl_poll_reg_array_timeout(hdev, addr_arr, arr_size, expected_val, sleep_us, \
+					timeout_us) \
+	hl_poll_reg_array_timeout_common(hdev, addr_arr, arr_size, expected_val, sleep_us, \
+						timeout_us, false)
+
+#define hl_poll_reg_array_timeout_elbi(hdev, addr_arr, arr_size, expected_val, sleep_us, \
+					timeout_us) \
+	hl_poll_reg_array_timeout_common(hdev, addr_arr, arr_size, expected_val, sleep_us, \
+						timeout_us, true)
+
 /*
  * address in this macro points always to a memory location in the
  * host's (server's) memory. That location is updated asynchronously
@@ -2540,31 +2626,6 @@ void hl_wreg(struct hl_device *hdev, u32 reg, u32 val);
 	(cond) ? 0 : -ETIMEDOUT; \
 })
 
-#define hl_poll_timeout_device_memory(hdev, addr, val, cond, sleep_us, \
-					timeout_us) \
-({ \
-	ktime_t __timeout; \
-	if (hdev->pdev) \
-		__timeout = ktime_add_us(ktime_get(), timeout_us); \
-	else \
-		__timeout = ktime_add_us(ktime_get(),\
-				min((u64)(timeout_us * 10), \
-					(u64) HL_SIM_MAX_TIMEOUT_US)); \
-	might_sleep_if(sleep_us); \
-	for (;;) { \
-		(val) = readl(addr); \
-		if (cond) \
-			break; \
-		if (timeout_us && ktime_compare(ktime_get(), __timeout) > 0) { \
-			(val) = readl(addr); \
-			break; \
-		} \
-		if (sleep_us) \
-			usleep_range((sleep_us >> 2) + 1, sleep_us); \
-	} \
-	(cond) ? 0 : -ETIMEDOUT; \
-})
-
 #define HL_USR_MAPPED_BLK_INIT(blk, base, sz) \
 ({ \
 	struct user_mapped_block *p = blk; \
-- 
2.25.1

