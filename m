Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ABDB466274
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 12:37:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357437AbhLBLks (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 06:40:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357402AbhLBLki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 06:40:38 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D61FBC06175F
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 03:37:09 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id m15so26747876pgu.11
        for <linux-kernel@vger.kernel.org>; Thu, 02 Dec 2021 03:37:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NXz2Nme4PADwb/24qgvdumlpERSiGKFVsXsd62vLlsA=;
        b=cisksCOP5msegeUQEIqtUG4mcQFciW/n6szlsumHkv4o6ZOjOQ3u+z4/egOC3r+Q7u
         UXA0OAxFvCZface5eVl6tXOgGGKcjKb9aEAO0N6/ItwClKqN9XcJfcYPc6FARQ4O2JyH
         GNuV0+MB6nfdsBNAzSVSkB2FpDAFJqW+T1mfgGRtH0b2PnI4lDEbR0+3gPeyUqzFPW+2
         EZs535wpFL6v7Kg0SFveCzWMjv8eINnfxYKsBBQW/Qz6sxohm/VA51/6JymTVI8CwHTf
         khFO9vhRNs+1KuLgSsGfeL3uubI3mfTv4QeryqoIX5tmlgqz314M4XZ3vsjZn3fc+nmK
         IrzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NXz2Nme4PADwb/24qgvdumlpERSiGKFVsXsd62vLlsA=;
        b=qgJGNch3hTDmh9hVyJxfDvjJ0a9C6YugviTKzmvGLg29rvTAz8HGP/xuhbyYKaKGFz
         oZK7cmDczBypOEdrsZGviULzwgGFSy2DEDKp8l6f3ji32VZvVhKuPZ4xHlGXtRotaw+q
         1vuDJun0bp8YcgthGDogCSx3LCmVZwZzz8HaCgzhfgV30ULBoIFncQxN/G07PAHXRdkb
         swzOLoUYxN9j98bSKaMZy1YcJ0i/0ZjYKyCezRKeZtPt/d/ile1bhoqoaq9l5MUK1A/Q
         IIfn9o5khvIv0JX3hxMHoqduKwR+SQYyC9tl86FaLpidLZ68XpvXTbVh+ndpWXFoKblr
         XUsQ==
X-Gm-Message-State: AOAM530RvQPH87zVL7+OEwbpUQe2VZ78+2sdSqzALbdICUtBXCJL27x3
        b2g01Hdsn/Xkuugu1glSwi84
X-Google-Smtp-Source: ABdhPJy5uDZgdx3A/+s7eg5KSQSD0syY7NusVOg9oMoJ7bhOAfifYbPtEXPdIFW60GIKBeA3Aewncg==
X-Received: by 2002:a05:6a00:1396:b0:4a4:ca76:bc0f with SMTP id t22-20020a056a00139600b004a4ca76bc0fmr12146221pfg.5.1638445029299;
        Thu, 02 Dec 2021 03:37:09 -0800 (PST)
Received: from localhost.localdomain ([117.202.184.5])
        by smtp.gmail.com with ESMTPSA id h5sm3602552pfi.46.2021.12.02.03.37.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 03:37:08 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     mhi@lists.linux.dev
Cc:     hemantk@codeaurora.org, bbhatt@codeaurora.org,
        quic_jhugo@quicinc.com, vinod.koul@linaro.org,
        bjorn.andersson@linaro.org, dmitry.baryshkov@linaro.org,
        skananth@codeaurora.org, vpernami@codeaurora.org,
        vbadigan@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 02/20] bus: mhi: Move common MHI definitions out of host directory
Date:   Thu,  2 Dec 2021 17:05:34 +0530
Message-Id: <20211202113553.238011-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211202113553.238011-1-manivannan.sadhasivam@linaro.org>
References: <20211202113553.238011-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
 drivers/bus/mhi/common.h        | 182 ++++++++++++++++++++++++++++++++
 drivers/bus/mhi/host/internal.h | 154 +--------------------------
 2 files changed, 183 insertions(+), 153 deletions(-)
 create mode 100644 drivers/bus/mhi/common.h

diff --git a/drivers/bus/mhi/common.h b/drivers/bus/mhi/common.h
new file mode 100644
index 000000000000..0f4f3b9f3027
--- /dev/null
+++ b/drivers/bus/mhi/common.h
@@ -0,0 +1,182 @@
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
+#define MHI_TRE_CMD_NOOP_DWORD1 (MHI_CMD_NOP << 16)
+
+/* Channel reset command */
+#define MHI_TRE_CMD_RESET_PTR (0)
+#define MHI_TRE_CMD_RESET_DWORD0 (0)
+#define MHI_TRE_CMD_RESET_DWORD1(chid) ((chid << 24) | \
+					(MHI_CMD_RESET_CHAN << 16))
+
+/* Channel stop command */
+#define MHI_TRE_CMD_STOP_PTR (0)
+#define MHI_TRE_CMD_STOP_DWORD0 (0)
+#define MHI_TRE_CMD_STOP_DWORD1(chid) ((chid << 24) | \
+				       (MHI_CMD_STOP_CHAN << 16))
+
+/* Channel start command */
+#define MHI_TRE_CMD_START_PTR (0)
+#define MHI_TRE_CMD_START_DWORD0 (0)
+#define MHI_TRE_CMD_START_DWORD1(chid) ((chid << 24) | \
+					(MHI_CMD_START_CHAN << 16))
+
+#define MHI_TRE_GET_CMD_CHID(tre) (((tre)->dword[1] >> 24) & 0xFF)
+#define MHI_TRE_GET_CMD_TYPE(tre) (((tre)->dword[1] >> 16) & 0xFF)
+
+/* Event descriptor macros */
+/* Transfer completion event */
+#define MHI_TRE_EV_PTR(ptr) (ptr)
+#define MHI_TRE_EV_DWORD0(code, len) ((code << 24) | len)
+#define MHI_TRE_EV_DWORD1(chid, type) ((chid << 24) | (type << 16))
+#define MHI_TRE_GET_EV_PTR(tre) ((tre)->ptr)
+#define MHI_TRE_GET_EV_CODE(tre) (((tre)->dword[0] >> 24) & 0xFF)
+#define MHI_TRE_GET_EV_LEN(tre) ((tre)->dword[0] & 0xFFFF)
+#define MHI_TRE_GET_EV_CHID(tre) (((tre)->dword[1] >> 24) & 0xFF)
+#define MHI_TRE_GET_EV_TYPE(tre) (((tre)->dword[1] >> 16) & 0xFF)
+#define MHI_TRE_GET_EV_STATE(tre) (((tre)->dword[0] >> 24) & 0xFF)
+#define MHI_TRE_GET_EV_EXECENV(tre) (((tre)->dword[0] >> 24) & 0xFF)
+#define MHI_TRE_GET_EV_SEQ(tre) ((tre)->dword[0])
+#define MHI_TRE_GET_EV_TIME(tre) ((tre)->ptr)
+#define MHI_TRE_GET_EV_COOKIE(tre) lower_32_bits((tre)->ptr)
+#define MHI_TRE_GET_EV_VEID(tre) (((tre)->dword[0] >> 16) & 0xFF)
+#define MHI_TRE_GET_EV_LINKSPEED(tre) (((tre)->dword[1] >> 24) & 0xFF)
+#define MHI_TRE_GET_EV_LINKWIDTH(tre) ((tre)->dword[0] & 0xFF)
+
+/* State change event */
+#define MHI_SC_EV_PTR 0
+#define MHI_SC_EV_DWORD0(state) (state << 24)
+#define MHI_SC_EV_DWORD1(type) (type << 16)
+
+/* EE event */
+#define MHI_EE_EV_PTR 0
+#define MHI_EE_EV_DWORD0(ee) (ee << 24)
+#define MHI_EE_EV_DWORD1(type) (type << 16)
+
+/* Command Completion event */
+#define MHI_CC_EV_PTR(ptr) (ptr)
+#define MHI_CC_EV_DWORD0(code) (code << 24)
+#define MHI_CC_EV_DWORD1(type) (type << 16)
+
+/* Transfer descriptor macros */
+#define MHI_TRE_DATA_PTR(ptr) (ptr)
+#define MHI_TRE_DATA_DWORD0(len) (len & MHI_MAX_MTU)
+#define MHI_TRE_DATA_DWORD1(bei, ieot, ieob, chain) ((2 << 16) | (bei << 10) \
+	| (ieot << 9) | (ieob << 8) | chain)
+
+/* RSC transfer descriptor macros */
+#define MHI_RSCTRE_DATA_PTR(ptr, len) (((u64)len << 48) | ptr)
+#define MHI_RSCTRE_DATA_DWORD0(cookie) (cookie)
+#define MHI_RSCTRE_DATA_DWORD1 (MHI_PKT_TYPE_COALESCING << 16)
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
+	__u32 intmod;
+	__u32 ertype;
+	__u32 msivec;
+
+	__u64 rbase __packed __aligned(4);
+	__u64 rlen __packed __aligned(4);
+	__u64 rp __packed __aligned(4);
+	__u64 wp __packed __aligned(4);
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
+	__u32 chcfg;
+	__u32 chtype;
+	__u32 erindex;
+
+	__u64 rbase __packed __aligned(4);
+	__u64 rlen __packed __aligned(4);
+	__u64 rp __packed __aligned(4);
+	__u64 wp __packed __aligned(4);
+};
+
+struct mhi_cmd_ctxt {
+	__u32 reserved0;
+	__u32 reserved1;
+	__u32 reserved2;
+
+	__u64 rbase __packed __aligned(4);
+	__u64 rlen __packed __aligned(4);
+	__u64 rp __packed __aligned(4);
+	__u64 wp __packed __aligned(4);
+};
+
+extern const char * const mhi_state_str[MHI_STATE_MAX];
+#define TO_MHI_STATE_STR(state) ((state >= MHI_STATE_MAX || \
+				  !mhi_state_str[state]) ? \
+				"INVALID_STATE" : mhi_state_str[state])
+
+#endif /* _MHI_COMMON_H */
diff --git a/drivers/bus/mhi/host/internal.h b/drivers/bus/mhi/host/internal.h
index 3a732afaf73e..a324a76684d0 100644
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
-	__u32 intmod;
-	__u32 ertype;
-	__u32 msivec;
-
-	__u64 rbase __packed __aligned(4);
-	__u64 rlen __packed __aligned(4);
-	__u64 rp __packed __aligned(4);
-	__u64 wp __packed __aligned(4);
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
-	__u32 chcfg;
-	__u32 chtype;
-	__u32 erindex;
-
-	__u64 rbase __packed __aligned(4);
-	__u64 rlen __packed __aligned(4);
-	__u64 rp __packed __aligned(4);
-	__u64 wp __packed __aligned(4);
-};
-
-struct mhi_cmd_ctxt {
-	__u32 reserved0;
-	__u32 reserved1;
-	__u32 reserved2;
-
-	__u64 rbase __packed __aligned(4);
-	__u64 rlen __packed __aligned(4);
-	__u64 rp __packed __aligned(4);
-	__u64 wp __packed __aligned(4);
-};
-
 struct mhi_ctxt {
 	struct mhi_event_ctxt *er_ctxt;
 	struct mhi_chan_ctxt *chan_ctxt;
@@ -267,108 +222,6 @@ struct bhi_vec_entry {
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
-#define MHI_TRE_CMD_NOOP_DWORD1 (MHI_CMD_NOP << 16)
-
-/* Channel reset command */
-#define MHI_TRE_CMD_RESET_PTR (0)
-#define MHI_TRE_CMD_RESET_DWORD0 (0)
-#define MHI_TRE_CMD_RESET_DWORD1(chid) ((chid << 24) | \
-					(MHI_CMD_RESET_CHAN << 16))
-
-/* Channel stop command */
-#define MHI_TRE_CMD_STOP_PTR (0)
-#define MHI_TRE_CMD_STOP_DWORD0 (0)
-#define MHI_TRE_CMD_STOP_DWORD1(chid) ((chid << 24) | \
-				       (MHI_CMD_STOP_CHAN << 16))
-
-/* Channel start command */
-#define MHI_TRE_CMD_START_PTR (0)
-#define MHI_TRE_CMD_START_DWORD0 (0)
-#define MHI_TRE_CMD_START_DWORD1(chid) ((chid << 24) | \
-					(MHI_CMD_START_CHAN << 16))
-
-#define MHI_TRE_GET_CMD_CHID(tre) (((tre)->dword[1] >> 24) & 0xFF)
-#define MHI_TRE_GET_CMD_TYPE(tre) (((tre)->dword[1] >> 16) & 0xFF)
-
-/* Event descriptor macros */
-#define MHI_TRE_EV_PTR(ptr) (ptr)
-#define MHI_TRE_EV_DWORD0(code, len) ((code << 24) | len)
-#define MHI_TRE_EV_DWORD1(chid, type) ((chid << 24) | (type << 16))
-#define MHI_TRE_GET_EV_PTR(tre) ((tre)->ptr)
-#define MHI_TRE_GET_EV_CODE(tre) (((tre)->dword[0] >> 24) & 0xFF)
-#define MHI_TRE_GET_EV_LEN(tre) ((tre)->dword[0] & 0xFFFF)
-#define MHI_TRE_GET_EV_CHID(tre) (((tre)->dword[1] >> 24) & 0xFF)
-#define MHI_TRE_GET_EV_TYPE(tre) (((tre)->dword[1] >> 16) & 0xFF)
-#define MHI_TRE_GET_EV_STATE(tre) (((tre)->dword[0] >> 24) & 0xFF)
-#define MHI_TRE_GET_EV_EXECENV(tre) (((tre)->dword[0] >> 24) & 0xFF)
-#define MHI_TRE_GET_EV_SEQ(tre) ((tre)->dword[0])
-#define MHI_TRE_GET_EV_TIME(tre) ((tre)->ptr)
-#define MHI_TRE_GET_EV_COOKIE(tre) lower_32_bits((tre)->ptr)
-#define MHI_TRE_GET_EV_VEID(tre) (((tre)->dword[0] >> 16) & 0xFF)
-#define MHI_TRE_GET_EV_LINKSPEED(tre) (((tre)->dword[1] >> 24) & 0xFF)
-#define MHI_TRE_GET_EV_LINKWIDTH(tre) ((tre)->dword[0] & 0xFF)
-
-/* Transfer descriptor macros */
-#define MHI_TRE_DATA_PTR(ptr) (ptr)
-#define MHI_TRE_DATA_DWORD0(len) (len & MHI_MAX_MTU)
-#define MHI_TRE_DATA_DWORD1(bei, ieot, ieob, chain) ((2 << 16) | (bei << 10) \
-	| (ieot << 9) | (ieob << 8) | chain)
-
-/* RSC transfer descriptor macros */
-#define MHI_RSCTRE_DATA_PTR(ptr, len) (((u64)len << 48) | ptr)
-#define MHI_RSCTRE_DATA_DWORD0(cookie) (cookie)
-#define MHI_RSCTRE_DATA_DWORD1 (MHI_PKT_TYPE_COALESCING << 16)
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
@@ -409,11 +262,6 @@ extern const char * const dev_state_tran_str[DEV_ST_TRANSITION_MAX];
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

