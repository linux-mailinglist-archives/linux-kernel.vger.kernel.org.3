Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92AC946B344
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 07:56:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbhLGG7Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 01:59:25 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:59773 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229892AbhLGG7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 01:59:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1638860150; x=1670396150;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TpLS93RXAZ/sZorngDLFH9Hajf/22TOxqKAzR0ToyOY=;
  b=tKI1wzmA4lVtCjkjDspNS5jno4ZHoLBlTHYqxVBRCMyK29EQagM0dz7+
   WGYPWeDTTzRl3wLi6JPRnzcO1nts9edBjUBI3Wdf2QRLIVK6LLmJay7+J
   SQCc6aSbtE2c54y28K7SuEB04y3AO8abFDNZxEyzPpZfuG8ORFa5qhiTH
   M=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 06 Dec 2021 22:55:50 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2021 22:55:50 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Mon, 6 Dec 2021 22:55:47 -0800
Received: from blr-ubuntu-311.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Mon, 6 Dec 2021 22:55:43 -0800
From:   Sai Prakash Ranjan <quic_saipraka@quicinc.com>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Steven Rostedt <rostedt@goodmis.org>
CC:     gregkh <gregkh@linuxfoundation.org>, <quic_psodagud@quicinc.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>
Subject: [PATCHv6 5/5] asm-generic/io: Add logging support for MMIO accessors
Date:   Tue, 7 Dec 2021 12:24:49 +0530
Message-ID: <e64a532ce10e88269b1e8550293e07ea669c5f73.1638858747.git.quic_saipraka@quicinc.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1638858746.git.quic_saipraka@quicinc.com>
References: <cover.1638858746.git.quic_saipraka@quicinc.com>
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

Used _THIS_IP_ instead of CALLER_ADDR0 in MMIO accessors as using CALLER_ADDR0
was resulting in parent caller information which was not accurate such as below,

rwmmio_read: raw_notifier_call_chain+0x50/0x70 width=32 addr=0xffff800010040000

Use of _THIS_IP_ also helps in keeping ftrace.h away from asm-generic/io.h which
would have resulted in tons of header inclusion issues.

---
 arch/arm64/kvm/hyp/nvhe/Makefile |  7 ++-
 include/asm-generic/io.h         | 81 ++++++++++++++++++++++++++++++--
 2 files changed, 83 insertions(+), 5 deletions(-)

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
index 7ce93aaf69f8..96d144d3a26f 100644
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -61,6 +61,35 @@
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
@@ -149,9 +178,11 @@ static inline u8 readb(const volatile void __iomem *addr)
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
@@ -162,9 +193,11 @@ static inline u16 readw(const volatile void __iomem *addr)
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
@@ -175,9 +208,11 @@ static inline u32 readl(const volatile void __iomem *addr)
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
@@ -189,9 +224,11 @@ static inline u64 readq(const volatile void __iomem *addr)
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
@@ -201,9 +238,11 @@ static inline u64 readq(const volatile void __iomem *addr)
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
 
@@ -211,9 +250,11 @@ static inline void writeb(u8 value, volatile void __iomem *addr)
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
 
@@ -221,9 +262,11 @@ static inline void writew(u16 value, volatile void __iomem *addr)
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
 
@@ -232,9 +275,11 @@ static inline void writel(u32 value, volatile void __iomem *addr)
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
@@ -248,7 +293,12 @@ static inline void writeq(u64 value, volatile void __iomem *addr)
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
 
@@ -256,7 +306,12 @@ static inline u8 readb_relaxed(const volatile void __iomem *addr)
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
 
@@ -264,7 +319,12 @@ static inline u16 readw_relaxed(const volatile void __iomem *addr)
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
 
@@ -272,7 +332,12 @@ static inline u32 readl_relaxed(const volatile void __iomem *addr)
 #define readq_relaxed readq_relaxed
 static inline u64 readq_relaxed(const volatile void __iomem *addr)
 {
-	return __le64_to_cpu(__raw_readq(addr));
+	u64 val;
+
+	log_read_mmio(64, addr, _THIS_IP_);
+	val =__le64_to_cpu(__raw_readq(addr));
+	log_post_read_mmio(val, 64, addr, _THIS_IP_);
+	return val;
 }
 #endif
 
@@ -280,7 +345,9 @@ static inline u64 readq_relaxed(const volatile void __iomem *addr)
 #define writeb_relaxed writeb_relaxed
 static inline void writeb_relaxed(u8 value, volatile void __iomem *addr)
 {
+	log_write_mmio(value, 8, addr, _THIS_IP_);
 	__raw_writeb(value, addr);
+	log_post_write_mmio(value, 8, addr, _THIS_IP_);
 }
 #endif
 
@@ -288,7 +355,9 @@ static inline void writeb_relaxed(u8 value, volatile void __iomem *addr)
 #define writew_relaxed writew_relaxed
 static inline void writew_relaxed(u16 value, volatile void __iomem *addr)
 {
+	log_write_mmio(value, 16, addr, _THIS_IP_);
 	__raw_writew(cpu_to_le16(value), addr);
+	log_post_write_mmio(value, 16, addr, _THIS_IP_);
 }
 #endif
 
@@ -296,7 +365,9 @@ static inline void writew_relaxed(u16 value, volatile void __iomem *addr)
 #define writel_relaxed writel_relaxed
 static inline void writel_relaxed(u32 value, volatile void __iomem *addr)
 {
+	log_write_mmio(value, 32, addr, _THIS_IP_);
 	__raw_writel(__cpu_to_le32(value), addr);
+	log_post_write_mmio(value, 32, addr, _THIS_IP_);
 }
 #endif
 
@@ -304,7 +375,9 @@ static inline void writel_relaxed(u32 value, volatile void __iomem *addr)
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

