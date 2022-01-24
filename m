Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C822D4978F2
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 07:34:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231725AbiAXGeF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 01:34:05 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:42837 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241634AbiAXGeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 01:34:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1643006044; x=1674542044;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tBGUoEXvKxlGYkBeNgMRWCYfUterZHVE0VWnguF/6c4=;
  b=uVDSwIjD97yKaZsNCy1Gfnt/aJXIVtGEp7VN5IG3pTEX9IEmRyan761Q
   eABPiH/zoEkhm1dlJmqjan2D2ZHfGSGHdpiPbRhtKfCloKlxkCJnvrHq1
   qslJQVWHgNkExnztktcbQuUcNpJAOElT9+KsVoemba9R98nLXtparK4NT
   o=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 23 Jan 2022 22:34:03 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2022 22:34:03 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Sun, 23 Jan 2022 22:34:03 -0800
Received: from blr-ubuntu-253.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Sun, 23 Jan 2022 22:33:58 -0800
From:   Sai Prakash Ranjan <quic_saipraka@quicinc.com>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <maz@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
CC:     gregkh <gregkh@linuxfoundation.org>, <quic_psodagud@quicinc.com>,
        "Trilok Soni" <quic_tsoni@quicinc.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>,
        "Sai Prakash Ranjan" <quic_saipraka@quicinc.com>
Subject: [PATCHv9 1/5] arm64: io: Use asm-generic high level MMIO accessors
Date:   Mon, 24 Jan 2022 12:03:30 +0530
Message-ID: <87926437f2f9e72dd94f0b30c8784c2da5508644.1642482334.git.quic_saipraka@quicinc.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1642482334.git.quic_saipraka@quicinc.com>
References: <cover.1642482334.git.quic_saipraka@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove custom arm64 MMIO accessors read{b,w,l,q} and their relaxed
versions in support to use asm-generic defined accessors. Also define
one set of IO barriers (ar/bw version) used by asm-generic code to
override the arm64 specific variants.

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Sai Prakash Ranjan <quic_saipraka@quicinc.com>
---
 arch/arm64/include/asm/io.h | 41 ++++++++-----------------------------
 1 file changed, 8 insertions(+), 33 deletions(-)

diff --git a/arch/arm64/include/asm/io.h b/arch/arm64/include/asm/io.h
index 7fd836bea7eb..1b436810d779 100644
--- a/arch/arm64/include/asm/io.h
+++ b/arch/arm64/include/asm/io.h
@@ -91,7 +91,7 @@ static inline u64 __raw_readq(const volatile void __iomem *addr)
 }
 
 /* IO barriers */
-#define __iormb(v)							\
+#define __io_ar(v)							\
 ({									\
 	unsigned long tmp;						\
 									\
@@ -108,39 +108,14 @@ static inline u64 __raw_readq(const volatile void __iomem *addr)
 		     : "memory");					\
 })
 
-#define __io_par(v)		__iormb(v)
-#define __iowmb()		dma_wmb()
-#define __iomb()		dma_mb()
-
-/*
- * Relaxed I/O memory access primitives. These follow the Device memory
- * ordering rules but do not guarantee any ordering relative to Normal memory
- * accesses.
- */
-#define readb_relaxed(c)	({ u8  __r = __raw_readb(c); __r; })
-#define readw_relaxed(c)	({ u16 __r = le16_to_cpu((__force __le16)__raw_readw(c)); __r; })
-#define readl_relaxed(c)	({ u32 __r = le32_to_cpu((__force __le32)__raw_readl(c)); __r; })
-#define readq_relaxed(c)	({ u64 __r = le64_to_cpu((__force __le64)__raw_readq(c)); __r; })
+#define __io_bw()		dma_wmb()
+#define __io_br(v)
+#define __io_aw(v)
 
-#define writeb_relaxed(v,c)	((void)__raw_writeb((v),(c)))
-#define writew_relaxed(v,c)	((void)__raw_writew((__force u16)cpu_to_le16(v),(c)))
-#define writel_relaxed(v,c)	((void)__raw_writel((__force u32)cpu_to_le32(v),(c)))
-#define writeq_relaxed(v,c)	((void)__raw_writeq((__force u64)cpu_to_le64(v),(c)))
-
-/*
- * I/O memory access primitives. Reads are ordered relative to any
- * following Normal memory access. Writes are ordered relative to any prior
- * Normal memory access.
- */
-#define readb(c)		({ u8  __v = readb_relaxed(c); __iormb(__v); __v; })
-#define readw(c)		({ u16 __v = readw_relaxed(c); __iormb(__v); __v; })
-#define readl(c)		({ u32 __v = readl_relaxed(c); __iormb(__v); __v; })
-#define readq(c)		({ u64 __v = readq_relaxed(c); __iormb(__v); __v; })
-
-#define writeb(v,c)		({ __iowmb(); writeb_relaxed((v),(c)); })
-#define writew(v,c)		({ __iowmb(); writew_relaxed((v),(c)); })
-#define writel(v,c)		({ __iowmb(); writel_relaxed((v),(c)); })
-#define writeq(v,c)		({ __iowmb(); writeq_relaxed((v),(c)); })
+/* arm64-specific, don't use in portable drivers */
+#define __iormb(v)		__io_ar(v)
+#define __iowmb()		__io_bw()
+#define __iomb()		dma_mb()
 
 /*
  *  I/O port access primitives.
-- 
2.33.1

