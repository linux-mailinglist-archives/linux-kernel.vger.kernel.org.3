Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC0CC46917E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 09:29:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239388AbhLFIdW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 03:33:22 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:3267 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239398AbhLFIdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 03:33:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1638779385; x=1670315385;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VrUW0syZe2Tr4MdcSGs7TDS+dR+xRNasOAJKeONw8xk=;
  b=F71rLC3TLjeCgUkFfc1nvv4qTcmQ9yQHROmoMYsAYc7aKA7xgELotagv
   +Rct9KjzBPTLC8HzYMAG6ls6GxTGyssjm8gHINocdkzkobtBOFwaGkzCG
   M9/R5rAdf+0rdDl9AyQWysT9ehWuvckZc4bmpEpsxwNYRKzwWv7hcWXtH
   0=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 06 Dec 2021 00:29:45 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2021 00:29:44 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Mon, 6 Dec 2021 00:29:43 -0800
Received: from blr-ubuntu-311.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Mon, 6 Dec 2021 00:29:40 -0800
From:   Sai Prakash Ranjan <quic_saipraka@quicinc.com>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Marc Zyngier" <maz@kernel.org>
CC:     gregkh <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>, <quic_psodagud@quicinc.com>,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>
Subject: [PATCHv5 4/4] asm-generic/io: Add logging support for MMIO accessors
Date:   Mon, 6 Dec 2021 13:58:06 +0530
Message-ID: <99ecc64c6da3abb3ea2930082c40f1820655664c.1638275062.git.quic_saipraka@quicinc.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1638275062.git.quic_saipraka@quicinc.com>
References: <cover.1638275062.git.quic_saipraka@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add logging support for MMIO high level accessors such as read{b,w,l,q}
and their relaxed versions to aid in debugging unexpected crashes/hangs
caused by the corresponding MMIO operation. Also add a generic flag
(__DISABLE_TRACE_MMIO__) which is used to disable MMIO tracing in nVHE KVM
and if required can be used to disable MMIO tracing for specific drivers.

Signed-off-by: Sai Prakash Ranjan <quic_saipraka@quicinc.com>
---
 arch/arm64/kvm/hyp/nvhe/Makefile |  7 ++++-
 include/asm-generic/io.h         | 49 ++++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/Makefile b/arch/arm64/kvm/hyp/nvhe/Makefile
index c3c11974fa3b..2765ec38a269 100644
--- a/arch/arm64/kvm/hyp/nvhe/Makefile
+++ b/arch/arm64/kvm/hyp/nvhe/Makefile
@@ -4,7 +4,12 @@
 #
 
 asflags-y := -D__KVM_NVHE_HYPERVISOR__ -D__DISABLE_EXPORTS
-ccflags-y := -D__KVM_NVHE_HYPERVISOR__ -D__DISABLE_EXPORTS
+
+# Tracepoint and MMIO logging symbols should not be visible at nVHE KVM as
+# there is no way to execute them and any such MMIO access from nVHE KVM
+# will explode instantly (Words of Marc Zyngier). So introduce a generic flag
+# __DISABLE_TRACE_MMIO__ to disable MMIO tracing for nVHE KVM.
+ccflags-y := -D__KVM_NVHE_HYPERVISOR__ -D__DISABLE_EXPORTS -D__DISABLE_TRACE_MMIO__
 
 hostprogs := gen-hyprel
 HOST_EXTRACFLAGS += -I$(objtree)/include
diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index 7ce93aaf69f8..dd5a803c8479 100644
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -61,6 +61,23 @@
 #define __io_par(v)     __io_ar(v)
 #endif
 
+#if IS_ENABLED(CONFIG_TRACE_MMIO_ACCESS) && !(defined(__DISABLE_TRACE_MMIO__))
+#include <linux/tracepoint-defs.h>
+
+DECLARE_TRACEPOINT(rwmmio_write);
+DECLARE_TRACEPOINT(rwmmio_read);
+
+#define rwmmio_tracepoint_active(t) tracepoint_enabled(t)
+void log_write_mmio(u64 val, u8 width, volatile void __iomem *addr);
+void log_read_mmio(u8 width, const volatile void __iomem *addr);
+
+#else
+
+#define rwmmio_tracepoint_active(t) false
+static inline void log_write_mmio(u64 val, u8 width, volatile void __iomem *addr) {}
+static inline void log_read_mmio(u8 width, const volatile void __iomem *addr) {}
+
+#endif /* CONFIG_TRACE_MMIO_ACCESS */
 
 /*
  * __raw_{read,write}{b,w,l,q}() access memory in native endianness.
@@ -149,6 +166,8 @@ static inline u8 readb(const volatile void __iomem *addr)
 {
 	u8 val;
 
+	if (rwmmio_tracepoint_active(rwmmio_read))
+		log_read_mmio(8, addr);
 	__io_br();
 	val = __raw_readb(addr);
 	__io_ar(val);
@@ -162,6 +181,8 @@ static inline u16 readw(const volatile void __iomem *addr)
 {
 	u16 val;
 
+	if (rwmmio_tracepoint_active(rwmmio_read))
+		log_read_mmio(16, addr);
 	__io_br();
 	val = __le16_to_cpu((__le16 __force)__raw_readw(addr));
 	__io_ar(val);
@@ -175,6 +196,8 @@ static inline u32 readl(const volatile void __iomem *addr)
 {
 	u32 val;
 
+	if (rwmmio_tracepoint_active(rwmmio_read))
+		log_read_mmio(32, addr);
 	__io_br();
 	val = __le32_to_cpu((__le32 __force)__raw_readl(addr));
 	__io_ar(val);
@@ -189,6 +212,8 @@ static inline u64 readq(const volatile void __iomem *addr)
 {
 	u64 val;
 
+	if (rwmmio_tracepoint_active(rwmmio_read))
+		log_read_mmio(64, addr);
 	__io_br();
 	val = __le64_to_cpu(__raw_readq(addr));
 	__io_ar(val);
@@ -201,6 +226,8 @@ static inline u64 readq(const volatile void __iomem *addr)
 #define writeb writeb
 static inline void writeb(u8 value, volatile void __iomem *addr)
 {
+	if (rwmmio_tracepoint_active(rwmmio_write))
+		log_write_mmio(value, 8, addr);
 	__io_bw();
 	__raw_writeb(value, addr);
 	__io_aw();
@@ -211,6 +238,8 @@ static inline void writeb(u8 value, volatile void __iomem *addr)
 #define writew writew
 static inline void writew(u16 value, volatile void __iomem *addr)
 {
+	if (rwmmio_tracepoint_active(rwmmio_write))
+		log_write_mmio(value, 16, addr);
 	__io_bw();
 	__raw_writew((u16 __force)cpu_to_le16(value), addr);
 	__io_aw();
@@ -221,6 +250,8 @@ static inline void writew(u16 value, volatile void __iomem *addr)
 #define writel writel
 static inline void writel(u32 value, volatile void __iomem *addr)
 {
+	if (rwmmio_tracepoint_active(rwmmio_write))
+		log_write_mmio(value, 32, addr);
 	__io_bw();
 	__raw_writel((u32 __force)__cpu_to_le32(value), addr);
 	__io_aw();
@@ -232,6 +263,8 @@ static inline void writel(u32 value, volatile void __iomem *addr)
 #define writeq writeq
 static inline void writeq(u64 value, volatile void __iomem *addr)
 {
+	if (rwmmio_tracepoint_active(rwmmio_write))
+		log_write_mmio(value, 64, addr);
 	__io_bw();
 	__raw_writeq(__cpu_to_le64(value), addr);
 	__io_aw();
@@ -248,6 +281,8 @@ static inline void writeq(u64 value, volatile void __iomem *addr)
 #define readb_relaxed readb_relaxed
 static inline u8 readb_relaxed(const volatile void __iomem *addr)
 {
+	if (rwmmio_tracepoint_active(rwmmio_read))
+		log_read_mmio(8, addr);
 	return __raw_readb(addr);
 }
 #endif
@@ -256,6 +291,8 @@ static inline u8 readb_relaxed(const volatile void __iomem *addr)
 #define readw_relaxed readw_relaxed
 static inline u16 readw_relaxed(const volatile void __iomem *addr)
 {
+	if (rwmmio_tracepoint_active(rwmmio_read))
+		log_read_mmio(16, addr);
 	return __le16_to_cpu(__raw_readw(addr));
 }
 #endif
@@ -264,6 +301,8 @@ static inline u16 readw_relaxed(const volatile void __iomem *addr)
 #define readl_relaxed readl_relaxed
 static inline u32 readl_relaxed(const volatile void __iomem *addr)
 {
+	if (rwmmio_tracepoint_active(rwmmio_read))
+		log_read_mmio(32, addr);
 	return __le32_to_cpu(__raw_readl(addr));
 }
 #endif
@@ -272,6 +311,8 @@ static inline u32 readl_relaxed(const volatile void __iomem *addr)
 #define readq_relaxed readq_relaxed
 static inline u64 readq_relaxed(const volatile void __iomem *addr)
 {
+	if (rwmmio_tracepoint_active(rwmmio_read))
+		log_read_mmio(64, addr);
 	return __le64_to_cpu(__raw_readq(addr));
 }
 #endif
@@ -280,6 +321,8 @@ static inline u64 readq_relaxed(const volatile void __iomem *addr)
 #define writeb_relaxed writeb_relaxed
 static inline void writeb_relaxed(u8 value, volatile void __iomem *addr)
 {
+	if (rwmmio_tracepoint_active(rwmmio_write))
+		log_write_mmio(value, 8, addr);
 	__raw_writeb(value, addr);
 }
 #endif
@@ -288,6 +331,8 @@ static inline void writeb_relaxed(u8 value, volatile void __iomem *addr)
 #define writew_relaxed writew_relaxed
 static inline void writew_relaxed(u16 value, volatile void __iomem *addr)
 {
+	if (rwmmio_tracepoint_active(rwmmio_write))
+		log_write_mmio(value, 16, addr);
 	__raw_writew(cpu_to_le16(value), addr);
 }
 #endif
@@ -296,6 +341,8 @@ static inline void writew_relaxed(u16 value, volatile void __iomem *addr)
 #define writel_relaxed writel_relaxed
 static inline void writel_relaxed(u32 value, volatile void __iomem *addr)
 {
+	if (rwmmio_tracepoint_active(rwmmio_write))
+		log_write_mmio(value, 32, addr);
 	__raw_writel(__cpu_to_le32(value), addr);
 }
 #endif
@@ -304,6 +351,8 @@ static inline void writel_relaxed(u32 value, volatile void __iomem *addr)
 #define writeq_relaxed writeq_relaxed
 static inline void writeq_relaxed(u64 value, volatile void __iomem *addr)
 {
+	if (rwmmio_tracepoint_active(rwmmio_write))
+		log_write_mmio(value, 64, addr);
 	__raw_writeq(__cpu_to_le64(value), addr);
 }
 #endif
-- 
2.33.1

