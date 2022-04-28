Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8E585130D4
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 12:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234340AbiD1KIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 06:08:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbiD1KHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 06:07:06 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8954243ACD;
        Thu, 28 Apr 2022 02:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1651139798; x=1682675798;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2SRHszNSlxAzB+vKJpcdy1q4zTfhGNXLAeSWY/14grY=;
  b=NR4liILLywy/0zzKiUvPZml0b+YUoWbI4trQ+Un7fHlZRJiy2d1+nSVR
   UhKl8EY9LticQqgUqHDUQ+g4zKjm/LNmtpJBzYkxf1TgfrHs81T9xETud
   d24ytPhiSvdqbRlsg+r6j496V0GIu2rCF5hJP90sPmyt1vw5r7LIZ9M+Y
   g=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 28 Apr 2022 02:56:37 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2022 02:56:36 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 28 Apr 2022 02:56:32 -0700
Received: from blr-ubuntu-253.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 28 Apr 2022 02:56:28 -0700
From:   Sai Prakash Ranjan <quic_saipraka@quicinc.com>
To:     <arnd@arndb.de>, <catalin.marinas@arm.com>,
        <gregkh@linuxfoundation.org>, <rostedt@goodmis.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <maz@kernel.org>, <quic_psodagud@quicinc.com>,
        <quic_tsoni@quicinc.com>, <will@kernel.org>,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>
Subject: [PATCHv12 7/9] asm-generic/io: Add logging support for MMIO accessors
Date:   Thu, 28 Apr 2022 15:25:30 +0530
Message-ID: <6673a2e73d3dd4c7aa01fee9b26cc4a52176ba7a.1651139070.git.quic_saipraka@quicinc.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1651139070.git.quic_saipraka@quicinc.com>
References: <cover.1651139070.git.quic_saipraka@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add logging support for MMIO high level accessors such as read{b,w,l,q}
and their relaxed versions to aid in debugging unexpected crashes/hangs
caused by the corresponding MMIO operation.

Signed-off-by: Sai Prakash Ranjan <quic_saipraka@quicinc.com>
---
 include/asm-generic/io.h | 82 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 78 insertions(+), 4 deletions(-)

diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index 7ce93aaf69f8..99090722cb4b 100644
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -10,6 +10,7 @@
 #include <asm/page.h> /* I/O is all done through memory accesses */
 #include <linux/string.h> /* for memset() and memcpy() */
 #include <linux/types.h>
+#include <linux/instruction_pointer.h>
 
 #ifdef CONFIG_GENERIC_IOMAP
 #include <asm-generic/iomap.h>
@@ -61,6 +62,35 @@
 #define __io_par(v)     __io_ar(v)
 #endif
 
+#if IS_ENABLED(CONFIG_TRACE_MMIO_ACCESS) && !(defined(__DISABLE_TRACE_MMIO__))
+#include <linux/tracepoint-defs.h>
+
+DECLARE_TRACEPOINT(rwmmio_write);
+DECLARE_TRACEPOINT(rwmmio_post_write);
+DECLARE_TRACEPOINT(rwmmio_read);
+DECLARE_TRACEPOINT(rwmmio_post_read);
+
+void log_write_mmio(u64 val, u8 width, volatile void __iomem *addr,
+		    unsigned long caller_addr);
+void log_post_write_mmio(u64 val, u8 width, volatile void __iomem *addr,
+			 unsigned long caller_addr);
+void log_read_mmio(u8 width, const volatile void __iomem *addr,
+		   unsigned long caller_addr);
+void log_post_read_mmio(u64 val, u8 width, const volatile void __iomem *addr,
+			unsigned long caller_addr);
+
+#else
+
+static inline void log_write_mmio(u64 val, u8 width, volatile void __iomem *addr,
+				  unsigned long caller_addr) {}
+static inline void log_post_write_mmio(u64 val, u8 width, volatile void __iomem *addr,
+				       unsigned long caller_addr) {}
+static inline void log_read_mmio(u8 width, const volatile void __iomem *addr,
+				 unsigned long caller_addr) {}
+static inline void log_post_read_mmio(u64 val, u8 width, const volatile void __iomem *addr,
+				      unsigned long caller_addr) {}
+
+#endif /* CONFIG_TRACE_MMIO_ACCESS */
 
 /*
  * __raw_{read,write}{b,w,l,q}() access memory in native endianness.
@@ -149,9 +179,11 @@ static inline u8 readb(const volatile void __iomem *addr)
 {
 	u8 val;
 
+	log_read_mmio(8, addr, _THIS_IP_);
 	__io_br();
 	val = __raw_readb(addr);
 	__io_ar(val);
+	log_post_read_mmio(val, 8, addr, _THIS_IP_);
 	return val;
 }
 #endif
@@ -162,9 +194,11 @@ static inline u16 readw(const volatile void __iomem *addr)
 {
 	u16 val;
 
+	log_read_mmio(16, addr, _THIS_IP_);
 	__io_br();
 	val = __le16_to_cpu((__le16 __force)__raw_readw(addr));
 	__io_ar(val);
+	log_post_read_mmio(val, 16, addr, _THIS_IP_);
 	return val;
 }
 #endif
@@ -175,9 +209,11 @@ static inline u32 readl(const volatile void __iomem *addr)
 {
 	u32 val;
 
+	log_read_mmio(32, addr, _THIS_IP_);
 	__io_br();
 	val = __le32_to_cpu((__le32 __force)__raw_readl(addr));
 	__io_ar(val);
+	log_post_read_mmio(val, 32, addr, _THIS_IP_);
 	return val;
 }
 #endif
@@ -189,9 +225,11 @@ static inline u64 readq(const volatile void __iomem *addr)
 {
 	u64 val;
 
+	log_read_mmio(64, addr, _THIS_IP_);
 	__io_br();
 	val = __le64_to_cpu(__raw_readq(addr));
 	__io_ar(val);
+	log_post_read_mmio(val, 64, addr, _THIS_IP_);
 	return val;
 }
 #endif
@@ -201,9 +239,11 @@ static inline u64 readq(const volatile void __iomem *addr)
 #define writeb writeb
 static inline void writeb(u8 value, volatile void __iomem *addr)
 {
+	log_write_mmio(value, 8, addr, _THIS_IP_);
 	__io_bw();
 	__raw_writeb(value, addr);
 	__io_aw();
+	log_post_write_mmio(value, 8, addr, _THIS_IP_);
 }
 #endif
 
@@ -211,9 +251,11 @@ static inline void writeb(u8 value, volatile void __iomem *addr)
 #define writew writew
 static inline void writew(u16 value, volatile void __iomem *addr)
 {
+	log_write_mmio(value, 16, addr, _THIS_IP_);
 	__io_bw();
 	__raw_writew((u16 __force)cpu_to_le16(value), addr);
 	__io_aw();
+	log_post_write_mmio(value, 16, addr, _THIS_IP_);
 }
 #endif
 
@@ -221,9 +263,11 @@ static inline void writew(u16 value, volatile void __iomem *addr)
 #define writel writel
 static inline void writel(u32 value, volatile void __iomem *addr)
 {
+	log_write_mmio(value, 32, addr, _THIS_IP_);
 	__io_bw();
 	__raw_writel((u32 __force)__cpu_to_le32(value), addr);
 	__io_aw();
+	log_post_write_mmio(value, 32, addr, _THIS_IP_);
 }
 #endif
 
@@ -232,9 +276,11 @@ static inline void writel(u32 value, volatile void __iomem *addr)
 #define writeq writeq
 static inline void writeq(u64 value, volatile void __iomem *addr)
 {
+	log_write_mmio(value, 64, addr, _THIS_IP_);
 	__io_bw();
 	__raw_writeq(__cpu_to_le64(value), addr);
 	__io_aw();
+	log_post_write_mmio(value, 64, addr, _THIS_IP_);
 }
 #endif
 #endif /* CONFIG_64BIT */
@@ -248,7 +294,12 @@ static inline void writeq(u64 value, volatile void __iomem *addr)
 #define readb_relaxed readb_relaxed
 static inline u8 readb_relaxed(const volatile void __iomem *addr)
 {
-	return __raw_readb(addr);
+	u8 val;
+
+	log_read_mmio(8, addr, _THIS_IP_);
+	val = __raw_readb(addr);
+	log_post_read_mmio(val, 8, addr, _THIS_IP_);
+	return val;
 }
 #endif
 
@@ -256,7 +307,12 @@ static inline u8 readb_relaxed(const volatile void __iomem *addr)
 #define readw_relaxed readw_relaxed
 static inline u16 readw_relaxed(const volatile void __iomem *addr)
 {
-	return __le16_to_cpu(__raw_readw(addr));
+	u16 val;
+
+	log_read_mmio(16, addr, _THIS_IP_);
+	val = __le16_to_cpu(__raw_readw(addr));
+	log_post_read_mmio(val, 16, addr, _THIS_IP_);
+	return val;
 }
 #endif
 
@@ -264,7 +320,12 @@ static inline u16 readw_relaxed(const volatile void __iomem *addr)
 #define readl_relaxed readl_relaxed
 static inline u32 readl_relaxed(const volatile void __iomem *addr)
 {
-	return __le32_to_cpu(__raw_readl(addr));
+	u32 val;
+
+	log_read_mmio(32, addr, _THIS_IP_);
+	val = __le32_to_cpu(__raw_readl(addr));
+	log_post_read_mmio(val, 32, addr, _THIS_IP_);
+	return val;
 }
 #endif
 
@@ -272,7 +333,12 @@ static inline u32 readl_relaxed(const volatile void __iomem *addr)
 #define readq_relaxed readq_relaxed
 static inline u64 readq_relaxed(const volatile void __iomem *addr)
 {
-	return __le64_to_cpu(__raw_readq(addr));
+	u64 val;
+
+	log_read_mmio(64, addr, _THIS_IP_);
+	val = __le64_to_cpu(__raw_readq(addr));
+	log_post_read_mmio(val, 64, addr, _THIS_IP_);
+	return val;
 }
 #endif
 
@@ -280,7 +346,9 @@ static inline u64 readq_relaxed(const volatile void __iomem *addr)
 #define writeb_relaxed writeb_relaxed
 static inline void writeb_relaxed(u8 value, volatile void __iomem *addr)
 {
+	log_write_mmio(value, 8, addr, _THIS_IP_);
 	__raw_writeb(value, addr);
+	log_post_write_mmio(value, 8, addr, _THIS_IP_);
 }
 #endif
 
@@ -288,7 +356,9 @@ static inline void writeb_relaxed(u8 value, volatile void __iomem *addr)
 #define writew_relaxed writew_relaxed
 static inline void writew_relaxed(u16 value, volatile void __iomem *addr)
 {
+	log_write_mmio(value, 16, addr, _THIS_IP_);
 	__raw_writew(cpu_to_le16(value), addr);
+	log_post_write_mmio(value, 16, addr, _THIS_IP_);
 }
 #endif
 
@@ -296,7 +366,9 @@ static inline void writew_relaxed(u16 value, volatile void __iomem *addr)
 #define writel_relaxed writel_relaxed
 static inline void writel_relaxed(u32 value, volatile void __iomem *addr)
 {
+	log_write_mmio(value, 32, addr, _THIS_IP_);
 	__raw_writel(__cpu_to_le32(value), addr);
+	log_post_write_mmio(value, 32, addr, _THIS_IP_);
 }
 #endif
 
@@ -304,7 +376,9 @@ static inline void writel_relaxed(u32 value, volatile void __iomem *addr)
 #define writeq_relaxed writeq_relaxed
 static inline void writeq_relaxed(u64 value, volatile void __iomem *addr)
 {
+	log_write_mmio(value, 64, addr, _THIS_IP_);
 	__raw_writeq(__cpu_to_le64(value), addr);
+	log_post_write_mmio(value, 64, addr, _THIS_IP_);
 }
 #endif
 
-- 
2.33.1

