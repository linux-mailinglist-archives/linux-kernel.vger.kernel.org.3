Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 679DC4B3721
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 19:22:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbiBLSWO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 13:22:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbiBLSWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 13:22:11 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 179075F8E1
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 10:22:04 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id x3so7259293pll.3
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 10:22:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cGQSDhdU/VUiCgxjKsrYQ6T6ZSVoqze1ynzNfFCo8J0=;
        b=DhI2MpZWJZ+jYk4sYly+K1Z7scW6UhRSbiiQA6OLedXS39MXnmD2qR34f+4idOkLXB
         ICtMvSFyHldPxieF58RaZcHb0SYBOCr4miNocMTCcfo6nJPe8b83h+VxefRY4hppb7BT
         dGZdF7dC/HavmID9BlFLz9cFwwkogp1mIJYjINGZSmMeVHm82KvfZPZNHNq0a1T40Co/
         Gv2x8yXEwCJiI3a2OkUUsTQO5syBHPNG44MMor/g2IjHeGaOYXMNXqbPbvZsJwb24W2x
         mZJ0allZN6wJWieFNsWAqE42x0eNYOD2fvLtN0o/mSci8A8/jYft2Pi2V6+YHk6BNEWg
         C/aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cGQSDhdU/VUiCgxjKsrYQ6T6ZSVoqze1ynzNfFCo8J0=;
        b=5NYM3sKX/5lFEiNbKsEgtdkATL394uIMFPo0Eu77tIPrdaYzhGVm0s0yhLYxSmaHxs
         WHdxJLn8gczhAbpzMC4XBrSnBWrZAXungvdDV3aIexAPeqeqSB6SUFzSAbX142MyaBHY
         pI4MkMMKVNTtoqrykB2iie4z7f0VZM15YG2W0cgH1Cr54wFEkL8Q/7a5nw4Da/S+QCsP
         d/rnUcSDX6NQIeFwYF7uvB8k+GEC3DJDDasb7Tmqt3M6lVhvM7oJjAtMrUBdrGiRhfuK
         4AIlL71vZ8NCsLX6oWEZl14xzWe7SGKgBOKnTYzioJXLdV5DVklpDYCXsPXq9s4g8c2S
         BLjw==
X-Gm-Message-State: AOAM5332XcQKu2N+GfwZO79ngTXU+KWM9xwuOgWgGb7g8ECcZBSxW2CA
        vhVaGavQ5/iwEfKr5HQ7avL6
X-Google-Smtp-Source: ABdhPJwIEv6hA2vrcGaMyWVmw2UstQpntZzIAZo3+61M/ex11zRhbm9q5caSjDOHjoDW1i9Ry8l6tg==
X-Received: by 2002:a17:90b:4a06:: with SMTP id kk6mr6347563pjb.236.1644690123444;
        Sat, 12 Feb 2022 10:22:03 -0800 (PST)
Received: from localhost.localdomain ([27.111.75.57])
        by smtp.gmail.com with ESMTPSA id g12sm14961987pfj.148.2022.02.12.10.21.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Feb 2022 10:22:03 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     mhi@lists.linux.dev
Cc:     quic_hemantk@quicinc.com, quic_bbhatt@quicinc.com,
        quic_jhugo@quicinc.com, vinod.koul@linaro.org,
        bjorn.andersson@linaro.org, dmitry.baryshkov@linaro.org,
        quic_vbadigan@quicinc.com, quic_cang@quicinc.com,
        quic_skananth@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, elder@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 04/25] bus: mhi: Move common MHI definitions out of host directory
Date:   Sat, 12 Feb 2022 23:50:56 +0530
Message-Id: <20220212182117.49438-5-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220212182117.49438-1-manivannan.sadhasivam@linaro.org>
References: <20220212182117.49438-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the common MHI definitions in host "internal.h" to "common.h" so
that the endpoint code can make use of them. This also avoids
duplicating the definitions in the endpoint stack.

Still, the MHI register definitions are not moved since the offsets
vary between host and endpoint.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/bus/mhi/common.h        | 167 ++++++++++++++++++++++++++++++++
 drivers/bus/mhi/host/internal.h | 155 +----------------------------
 2 files changed, 168 insertions(+), 154 deletions(-)
 create mode 100644 drivers/bus/mhi/common.h

diff --git a/drivers/bus/mhi/common.h b/drivers/bus/mhi/common.h
new file mode 100644
index 000000000000..0d13a202d334
--- /dev/null
+++ b/drivers/bus/mhi/common.h
@@ -0,0 +1,167 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2021, Linaro Ltd.
+ *
+ */
+
+#ifndef _MHI_COMMON_H
+#define _MHI_COMMON_H
+
+#include <linux/mhi.h>
+
+/* Command Ring Element macros */
+/* No operation command */
+#define MHI_TRE_CMD_NOOP_PTR (0)
+#define MHI_TRE_CMD_NOOP_DWORD0 (0)
+#define MHI_TRE_CMD_NOOP_DWORD1 (cpu_to_le32(MHI_CMD_NOP << 16))
+
+/* Channel reset command */
+#define MHI_TRE_CMD_RESET_PTR (0)
+#define MHI_TRE_CMD_RESET_DWORD0 (0)
+#define MHI_TRE_CMD_RESET_DWORD1(chid) (cpu_to_le32((chid << 24) | \
+					(MHI_CMD_RESET_CHAN << 16)))
+
+/* Channel stop command */
+#define MHI_TRE_CMD_STOP_PTR (0)
+#define MHI_TRE_CMD_STOP_DWORD0 (0)
+#define MHI_TRE_CMD_STOP_DWORD1(chid) (cpu_to_le32((chid << 24) | \
+				       (MHI_CMD_STOP_CHAN << 16)))
+
+/* Channel start command */
+#define MHI_TRE_CMD_START_PTR (0)
+#define MHI_TRE_CMD_START_DWORD0 (0)
+#define MHI_TRE_CMD_START_DWORD1(chid) (cpu_to_le32((chid << 24) | \
+					(MHI_CMD_START_CHAN << 16)))
+
+#define MHI_TRE_GET_DWORD(tre, word) (le32_to_cpu((tre)->dword[(word)]))
+#define MHI_TRE_GET_CMD_CHID(tre) ((MHI_TRE_GET_DWORD(tre, 1) >> 24) & 0xFF)
+#define MHI_TRE_GET_CMD_TYPE(tre) ((MHI_TRE_GET_DWORD(tre, 1) >> 16) & 0xFF)
+
+/* Event descriptor macros */
+#define MHI_TRE_EV_PTR(ptr) (cpu_to_le64(ptr))
+#define MHI_TRE_EV_DWORD0(code, len) (cpu_to_le32((code << 24) | len))
+#define MHI_TRE_EV_DWORD1(chid, type) (cpu_to_le32((chid << 24) | (type << 16)))
+#define MHI_TRE_GET_EV_PTR(tre) (le64_to_cpu((tre)->ptr))
+#define MHI_TRE_GET_EV_CODE(tre) ((MHI_TRE_GET_DWORD(tre, 0) >> 24) & 0xFF)
+#define MHI_TRE_GET_EV_LEN(tre) (MHI_TRE_GET_DWORD(tre, 0) & 0xFFFF)
+#define MHI_TRE_GET_EV_CHID(tre) ((MHI_TRE_GET_DWORD(tre, 1) >> 24) & 0xFF)
+#define MHI_TRE_GET_EV_TYPE(tre) ((MHI_TRE_GET_DWORD(tre, 1) >> 16) & 0xFF)
+#define MHI_TRE_GET_EV_STATE(tre) ((MHI_TRE_GET_DWORD(tre, 0) >> 24) & 0xFF)
+#define MHI_TRE_GET_EV_EXECENV(tre) ((MHI_TRE_GET_DWORD(tre, 0) >> 24) & 0xFF)
+#define MHI_TRE_GET_EV_SEQ(tre) MHI_TRE_GET_DWORD(tre, 0)
+#define MHI_TRE_GET_EV_TIME(tre) (MHI_TRE_GET_EV_PTR(tre))
+#define MHI_TRE_GET_EV_COOKIE(tre) lower_32_bits(MHI_TRE_GET_EV_PTR(tre))
+#define MHI_TRE_GET_EV_VEID(tre) ((MHI_TRE_GET_DWORD(tre, 0) >> 16) & 0xFF)
+#define MHI_TRE_GET_EV_LINKSPEED(tre) ((MHI_TRE_GET_DWORD(tre, 1) >> 24) & 0xFF)
+#define MHI_TRE_GET_EV_LINKWIDTH(tre) (MHI_TRE_GET_DWORD(tre, 0) & 0xFF)
+
+/* Transfer descriptor macros */
+#define MHI_TRE_DATA_PTR(ptr) (cpu_to_le64(ptr))
+#define MHI_TRE_DATA_DWORD0(len) (cpu_to_le32(len & MHI_MAX_MTU))
+#define MHI_TRE_DATA_DWORD1(bei, ieot, ieob, chain) (cpu_to_le32((2 << 16) | (bei << 10) \
+	| (ieot << 9) | (ieob << 8) | chain))
+
+/* RSC transfer descriptor macros */
+#define MHI_RSCTRE_DATA_PTR(ptr, len) (cpu_to_le64(((u64)len << 48) | ptr))
+#define MHI_RSCTRE_DATA_DWORD0(cookie) (cpu_to_le32(cookie))
+#define MHI_RSCTRE_DATA_DWORD1 (cpu_to_le32(MHI_PKT_TYPE_COALESCING << 16))
+
+enum mhi_pkt_type {
+	MHI_PKT_TYPE_INVALID = 0x0,
+	MHI_PKT_TYPE_NOOP_CMD = 0x1,
+	MHI_PKT_TYPE_TRANSFER = 0x2,
+	MHI_PKT_TYPE_COALESCING = 0x8,
+	MHI_PKT_TYPE_RESET_CHAN_CMD = 0x10,
+	MHI_PKT_TYPE_STOP_CHAN_CMD = 0x11,
+	MHI_PKT_TYPE_START_CHAN_CMD = 0x12,
+	MHI_PKT_TYPE_STATE_CHANGE_EVENT = 0x20,
+	MHI_PKT_TYPE_CMD_COMPLETION_EVENT = 0x21,
+	MHI_PKT_TYPE_TX_EVENT = 0x22,
+	MHI_PKT_TYPE_RSC_TX_EVENT = 0x28,
+	MHI_PKT_TYPE_EE_EVENT = 0x40,
+	MHI_PKT_TYPE_TSYNC_EVENT = 0x48,
+	MHI_PKT_TYPE_BW_REQ_EVENT = 0x50,
+	MHI_PKT_TYPE_STALE_EVENT, /* internal event */
+};
+
+/* MHI transfer completion events */
+enum mhi_ev_ccs {
+	MHI_EV_CC_INVALID = 0x0,
+	MHI_EV_CC_SUCCESS = 0x1,
+	MHI_EV_CC_EOT = 0x2, /* End of transfer event */
+	MHI_EV_CC_OVERFLOW = 0x3,
+	MHI_EV_CC_EOB = 0x4, /* End of block event */
+	MHI_EV_CC_OOB = 0x5, /* Out of block event */
+	MHI_EV_CC_DB_MODE = 0x6,
+	MHI_EV_CC_UNDEFINED_ERR = 0x10,
+	MHI_EV_CC_BAD_TRE = 0x11,
+};
+
+/* Channel state */
+enum mhi_ch_state {
+	MHI_CH_STATE_DISABLED,
+	MHI_CH_STATE_ENABLED,
+	MHI_CH_STATE_RUNNING,
+	MHI_CH_STATE_SUSPENDED,
+	MHI_CH_STATE_STOP,
+	MHI_CH_STATE_ERROR,
+};
+
+enum mhi_cmd_type {
+	MHI_CMD_NOP = 1,
+	MHI_CMD_RESET_CHAN = 16,
+	MHI_CMD_STOP_CHAN = 17,
+	MHI_CMD_START_CHAN = 18,
+};
+
+#define EV_CTX_RESERVED_MASK GENMASK(7, 0)
+#define EV_CTX_INTMODC_MASK GENMASK(15, 8)
+#define EV_CTX_INTMODC_SHIFT 8
+#define EV_CTX_INTMODT_MASK GENMASK(31, 16)
+#define EV_CTX_INTMODT_SHIFT 16
+struct mhi_event_ctxt {
+	__le32 intmod;
+	__le32 ertype;
+	__le32 msivec;
+
+	__le64 rbase __packed __aligned(4);
+	__le64 rlen __packed __aligned(4);
+	__le64 rp __packed __aligned(4);
+	__le64 wp __packed __aligned(4);
+};
+
+#define CHAN_CTX_CHSTATE_MASK GENMASK(7, 0)
+#define CHAN_CTX_CHSTATE_SHIFT 0
+#define CHAN_CTX_BRSTMODE_MASK GENMASK(9, 8)
+#define CHAN_CTX_BRSTMODE_SHIFT 8
+#define CHAN_CTX_POLLCFG_MASK GENMASK(15, 10)
+#define CHAN_CTX_POLLCFG_SHIFT 10
+#define CHAN_CTX_RESERVED_MASK GENMASK(31, 16)
+struct mhi_chan_ctxt {
+	__le32 chcfg;
+	__le32 chtype;
+	__le32 erindex;
+
+	__le64 rbase __packed __aligned(4);
+	__le64 rlen __packed __aligned(4);
+	__le64 rp __packed __aligned(4);
+	__le64 wp __packed __aligned(4);
+};
+
+struct mhi_cmd_ctxt {
+	__le32 reserved0;
+	__le32 reserved1;
+	__le32 reserved2;
+
+	__le64 rbase __packed __aligned(4);
+	__le64 rlen __packed __aligned(4);
+	__le64 rp __packed __aligned(4);
+	__le64 wp __packed __aligned(4);
+};
+
+extern const char * const mhi_state_str[MHI_STATE_MAX];
+#define TO_MHI_STATE_STR(state) ((state >= MHI_STATE_MAX || \
+				  !mhi_state_str[state]) ? \
+				"INVALID_STATE" : mhi_state_str[state])
+
+#endif /* _MHI_COMMON_H */
diff --git a/drivers/bus/mhi/host/internal.h b/drivers/bus/mhi/host/internal.h
index fa64340a8997..622de6ba1a0b 100644
--- a/drivers/bus/mhi/host/internal.h
+++ b/drivers/bus/mhi/host/internal.h
@@ -7,7 +7,7 @@
 #ifndef _MHI_INT_H
 #define _MHI_INT_H
 
-#include <linux/mhi.h>
+#include "../common.h"
 
 extern struct bus_type mhi_bus_type;
 
@@ -203,51 +203,6 @@ extern struct bus_type mhi_bus_type;
 #define SOC_HW_VERSION_MINOR_VER_BMSK (0x000000FF)
 #define SOC_HW_VERSION_MINOR_VER_SHFT (0)
 
-#define EV_CTX_RESERVED_MASK GENMASK(7, 0)
-#define EV_CTX_INTMODC_MASK GENMASK(15, 8)
-#define EV_CTX_INTMODC_SHIFT 8
-#define EV_CTX_INTMODT_MASK GENMASK(31, 16)
-#define EV_CTX_INTMODT_SHIFT 16
-struct mhi_event_ctxt {
-	__le32 intmod;
-	__le32 ertype;
-	__le32 msivec;
-
-	__le64 rbase __packed __aligned(4);
-	__le64 rlen __packed __aligned(4);
-	__le64 rp __packed __aligned(4);
-	__le64 wp __packed __aligned(4);
-};
-
-#define CHAN_CTX_CHSTATE_MASK GENMASK(7, 0)
-#define CHAN_CTX_CHSTATE_SHIFT 0
-#define CHAN_CTX_BRSTMODE_MASK GENMASK(9, 8)
-#define CHAN_CTX_BRSTMODE_SHIFT 8
-#define CHAN_CTX_POLLCFG_MASK GENMASK(15, 10)
-#define CHAN_CTX_POLLCFG_SHIFT 10
-#define CHAN_CTX_RESERVED_MASK GENMASK(31, 16)
-struct mhi_chan_ctxt {
-	__le32 chcfg;
-	__le32 chtype;
-	__le32 erindex;
-
-	__le64 rbase __packed __aligned(4);
-	__le64 rlen __packed __aligned(4);
-	__le64 rp __packed __aligned(4);
-	__le64 wp __packed __aligned(4);
-};
-
-struct mhi_cmd_ctxt {
-	__le32 reserved0;
-	__le32 reserved1;
-	__le32 reserved2;
-
-	__le64 rbase __packed __aligned(4);
-	__le64 rlen __packed __aligned(4);
-	__le64 rp __packed __aligned(4);
-	__le64 wp __packed __aligned(4);
-};
-
 struct mhi_ctxt {
 	struct mhi_event_ctxt *er_ctxt;
 	struct mhi_chan_ctxt *chan_ctxt;
@@ -267,109 +222,6 @@ struct bhi_vec_entry {
 	u64 size;
 };
 
-enum mhi_cmd_type {
-	MHI_CMD_NOP = 1,
-	MHI_CMD_RESET_CHAN = 16,
-	MHI_CMD_STOP_CHAN = 17,
-	MHI_CMD_START_CHAN = 18,
-};
-
-/* No operation command */
-#define MHI_TRE_CMD_NOOP_PTR (0)
-#define MHI_TRE_CMD_NOOP_DWORD0 (0)
-#define MHI_TRE_CMD_NOOP_DWORD1 (cpu_to_le32(MHI_CMD_NOP << 16))
-
-/* Channel reset command */
-#define MHI_TRE_CMD_RESET_PTR (0)
-#define MHI_TRE_CMD_RESET_DWORD0 (0)
-#define MHI_TRE_CMD_RESET_DWORD1(chid) (cpu_to_le32((chid << 24) | \
-					(MHI_CMD_RESET_CHAN << 16)))
-
-/* Channel stop command */
-#define MHI_TRE_CMD_STOP_PTR (0)
-#define MHI_TRE_CMD_STOP_DWORD0 (0)
-#define MHI_TRE_CMD_STOP_DWORD1(chid) (cpu_to_le32((chid << 24) | \
-				       (MHI_CMD_STOP_CHAN << 16)))
-
-/* Channel start command */
-#define MHI_TRE_CMD_START_PTR (0)
-#define MHI_TRE_CMD_START_DWORD0 (0)
-#define MHI_TRE_CMD_START_DWORD1(chid) (cpu_to_le32((chid << 24) | \
-					(MHI_CMD_START_CHAN << 16)))
-
-#define MHI_TRE_GET_DWORD(tre, word) (le32_to_cpu((tre)->dword[(word)]))
-#define MHI_TRE_GET_CMD_CHID(tre) ((MHI_TRE_GET_DWORD(tre, 1) >> 24) & 0xFF)
-#define MHI_TRE_GET_CMD_TYPE(tre) ((MHI_TRE_GET_DWORD(tre, 1) >> 16) & 0xFF)
-
-/* Event descriptor macros */
-#define MHI_TRE_EV_PTR(ptr) (cpu_to_le64(ptr))
-#define MHI_TRE_EV_DWORD0(code, len) (cpu_to_le32((code << 24) | len))
-#define MHI_TRE_EV_DWORD1(chid, type) (cpu_to_le32((chid << 24) | (type << 16)))
-#define MHI_TRE_GET_EV_PTR(tre) (le64_to_cpu((tre)->ptr))
-#define MHI_TRE_GET_EV_CODE(tre) ((MHI_TRE_GET_DWORD(tre, 0) >> 24) & 0xFF)
-#define MHI_TRE_GET_EV_LEN(tre) (MHI_TRE_GET_DWORD(tre, 0) & 0xFFFF)
-#define MHI_TRE_GET_EV_CHID(tre) ((MHI_TRE_GET_DWORD(tre, 1) >> 24) & 0xFF)
-#define MHI_TRE_GET_EV_TYPE(tre) ((MHI_TRE_GET_DWORD(tre, 1) >> 16) & 0xFF)
-#define MHI_TRE_GET_EV_STATE(tre) ((MHI_TRE_GET_DWORD(tre, 0) >> 24) & 0xFF)
-#define MHI_TRE_GET_EV_EXECENV(tre) ((MHI_TRE_GET_DWORD(tre, 0) >> 24) & 0xFF)
-#define MHI_TRE_GET_EV_SEQ(tre) MHI_TRE_GET_DWORD(tre, 0)
-#define MHI_TRE_GET_EV_TIME(tre) (MHI_TRE_GET_EV_PTR(tre))
-#define MHI_TRE_GET_EV_COOKIE(tre) lower_32_bits(MHI_TRE_GET_EV_PTR(tre))
-#define MHI_TRE_GET_EV_VEID(tre) ((MHI_TRE_GET_DWORD(tre, 0) >> 16) & 0xFF)
-#define MHI_TRE_GET_EV_LINKSPEED(tre) ((MHI_TRE_GET_DWORD(tre, 1) >> 24) & 0xFF)
-#define MHI_TRE_GET_EV_LINKWIDTH(tre) (MHI_TRE_GET_DWORD(tre, 0) & 0xFF)
-
-/* Transfer descriptor macros */
-#define MHI_TRE_DATA_PTR(ptr) (cpu_to_le64(ptr))
-#define MHI_TRE_DATA_DWORD0(len) (cpu_to_le32(len & MHI_MAX_MTU))
-#define MHI_TRE_DATA_DWORD1(bei, ieot, ieob, chain) (cpu_to_le32((2 << 16) | (bei << 10) \
-	| (ieot << 9) | (ieob << 8) | chain))
-
-/* RSC transfer descriptor macros */
-#define MHI_RSCTRE_DATA_PTR(ptr, len) (cpu_to_le64(((u64)len << 48) | ptr))
-#define MHI_RSCTRE_DATA_DWORD0(cookie) (cpu_to_le32(cookie))
-#define MHI_RSCTRE_DATA_DWORD1 (cpu_to_le32(MHI_PKT_TYPE_COALESCING << 16))
-
-enum mhi_pkt_type {
-	MHI_PKT_TYPE_INVALID = 0x0,
-	MHI_PKT_TYPE_NOOP_CMD = 0x1,
-	MHI_PKT_TYPE_TRANSFER = 0x2,
-	MHI_PKT_TYPE_COALESCING = 0x8,
-	MHI_PKT_TYPE_RESET_CHAN_CMD = 0x10,
-	MHI_PKT_TYPE_STOP_CHAN_CMD = 0x11,
-	MHI_PKT_TYPE_START_CHAN_CMD = 0x12,
-	MHI_PKT_TYPE_STATE_CHANGE_EVENT = 0x20,
-	MHI_PKT_TYPE_CMD_COMPLETION_EVENT = 0x21,
-	MHI_PKT_TYPE_TX_EVENT = 0x22,
-	MHI_PKT_TYPE_RSC_TX_EVENT = 0x28,
-	MHI_PKT_TYPE_EE_EVENT = 0x40,
-	MHI_PKT_TYPE_TSYNC_EVENT = 0x48,
-	MHI_PKT_TYPE_BW_REQ_EVENT = 0x50,
-	MHI_PKT_TYPE_STALE_EVENT, /* internal event */
-};
-
-/* MHI transfer completion events */
-enum mhi_ev_ccs {
-	MHI_EV_CC_INVALID = 0x0,
-	MHI_EV_CC_SUCCESS = 0x1,
-	MHI_EV_CC_EOT = 0x2, /* End of transfer event */
-	MHI_EV_CC_OVERFLOW = 0x3,
-	MHI_EV_CC_EOB = 0x4, /* End of block event */
-	MHI_EV_CC_OOB = 0x5, /* Out of block event */
-	MHI_EV_CC_DB_MODE = 0x6,
-	MHI_EV_CC_UNDEFINED_ERR = 0x10,
-	MHI_EV_CC_BAD_TRE = 0x11,
-};
-
-enum mhi_ch_state {
-	MHI_CH_STATE_DISABLED = 0x0,
-	MHI_CH_STATE_ENABLED = 0x1,
-	MHI_CH_STATE_RUNNING = 0x2,
-	MHI_CH_STATE_SUSPENDED = 0x3,
-	MHI_CH_STATE_STOP = 0x4,
-	MHI_CH_STATE_ERROR = 0x5,
-};
-
 enum mhi_ch_state_type {
 	MHI_CH_STATE_TYPE_RESET,
 	MHI_CH_STATE_TYPE_STOP,
@@ -411,11 +263,6 @@ extern const char * const dev_state_tran_str[DEV_ST_TRANSITION_MAX];
 #define TO_DEV_STATE_TRANS_STR(state) (((state) >= DEV_ST_TRANSITION_MAX) ? \
 				"INVALID_STATE" : dev_state_tran_str[state])
 
-extern const char * const mhi_state_str[MHI_STATE_MAX];
-#define TO_MHI_STATE_STR(state) ((state >= MHI_STATE_MAX || \
-				  !mhi_state_str[state]) ? \
-				"INVALID_STATE" : mhi_state_str[state])
-
 /* internal power states */
 enum mhi_pm_state {
 	MHI_PM_STATE_DISABLE,
-- 
2.25.1

