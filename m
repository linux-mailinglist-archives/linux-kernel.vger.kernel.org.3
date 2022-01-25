Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 971F049AD97
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 08:31:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378090AbiAYH0O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 02:26:14 -0500
Received: from esa7.hc1455-7.c3s2.iphmx.com ([139.138.61.252]:16758 "EHLO
        esa7.hc1455-7.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1444482AbiAYHV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 02:21:58 -0500
X-Greylist: delayed 432 seconds by postgrey-1.27 at vger.kernel.org; Tue, 25 Jan 2022 02:21:58 EST
IronPort-SDR: DO5rrdXVRGdxqfxenqFIhBFYicT9pIjAggEXo2eXaGuXLO5twJoKYAy5umlxekrMFQ8KZNOfIx
 v955dTAkfR/Cl4/ypzdab2Cb5LH4L2Kq97+m0+w+CTYZAPJ6gazN5A5yzt/W189MOUQ+/Lnhli
 fQWAzx5tNjqFGci/dcrUmlbmqaGq0IQ43FvDEIH3Gsjczdl1m/3tHqPuB4RijojZWcnYbJvciW
 A9d/rLC6QJbazKwnzqMViYCNA9jdPrLNCiNe1d5BiQTTUwgRoFuPO5RRyQVMLqQHTgNrEpkGzS
 o5esxtIvgpMMpDjhThyS/RAQ
X-IronPort-AV: E=McAfee;i="6200,9189,10237"; a="39268502"
X-IronPort-AV: E=Sophos;i="5.88,314,1635174000"; 
   d="scan'208";a="39268502"
Received: from unknown (HELO yto-r1.gw.nic.fujitsu.com) ([218.44.52.217])
  by esa7.hc1455-7.c3s2.iphmx.com with ESMTP; 25 Jan 2022 16:14:34 +0900
Received: from yto-m2.gw.nic.fujitsu.com (yto-nat-yto-m2.gw.nic.fujitsu.com [192.168.83.65])
        by yto-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 4A47DE5B29
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 16:14:33 +0900 (JST)
Received: from yto-om4.fujitsu.com (yto-om4.o.css.fujitsu.com [10.128.89.165])
        by yto-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 7E6EBE654E
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 16:14:32 +0900 (JST)
Received: from localhost.localdomain (n3235113.np.ts.nmh.cs.fujitsu.co.jp [10.123.235.113])
        by yto-om4.fujitsu.com (Postfix) with ESMTP id CC491400C1BBD;
        Tue, 25 Jan 2022 16:14:31 +0900 (JST)
From:   Kohei Tarumizu <tarumizu.kohei@fujitsu.com>
To:     catalin.marinas@arm.com, will@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     tarumizu.kohei@fujitsu.com
Subject: [PATCH 4/8] arm64: Add Kconfig/Makefile to build hardware prefetch control driver
Date:   Tue, 25 Jan 2022 16:14:10 +0900
Message-Id: <20220125071414.811344-5-tarumizu.kohei@fujitsu.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220125071414.811344-1-tarumizu.kohei@fujitsu.com>
References: <20220125071414.811344-1-tarumizu.kohei@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds Kconfig/Makefile to build hardware prefetch control driver
for arm64 support. This also adds a MAINTAINERS entry.

Signed-off-by: Kohei Tarumizu <tarumizu.kohei@fujitsu.com>
---
 MAINTAINERS                | 1 +
 arch/arm64/Kconfig         | 8 ++++++++
 arch/arm64/kernel/Makefile | 1 +
 3 files changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b474051c41e7..0eaee76438e9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8447,6 +8447,7 @@ K:	(devm_)?hwmon_device_(un)?register(|_with_groups|_with_info)
 HARDWARE PREFETCH CONTROL DRIVERS
 M:	Kohei Tarumizu <tarumizu.kohei@fujitsu.com>
 S:	Maintained
+F:	arch/arm64/kernel/pfctl.c
 F:	drivers/base/pfctl.c
 F:	include/linux/pfctl.h
 
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 6978140edfa4..c2256dbb0243 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -36,6 +36,7 @@ config ARM64
 	select ARCH_HAS_SET_DIRECT_MAP
 	select ARCH_HAS_SET_MEMORY
 	select ARCH_STACKWALK
+	select ARCH_HAS_HWPF_CONTROL
 	select ARCH_HAS_STRICT_KERNEL_RWX
 	select ARCH_HAS_STRICT_MODULE_RWX
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
@@ -1941,6 +1942,13 @@ config STACKPROTECTOR_PER_TASK
 	def_bool y
 	depends on STACKPROTECTOR && CC_HAVE_STACKPROTECTOR_SYSREG
 
+config ARM64_HWPF_CONTROL
+	tristate "ARM64 Hardware Prefetch Control support"
+	depends on HWPF_CONTROL
+	default m
+	help
+	  This adds Hardware Prefetch Control driver support for ARM64.
+
 endmenu
 
 menu "Boot options"
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index 88b3e2a21408..d5eb1dc6bfa6 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -73,6 +73,7 @@ obj-$(CONFIG_ARM64_PTR_AUTH)		+= pointer_auth.o
 obj-$(CONFIG_ARM64_MTE)			+= mte.o
 obj-y					+= vdso-wrap.o
 obj-$(CONFIG_COMPAT_VDSO)		+= vdso32-wrap.o
+obj-$(CONFIG_ARM64_HWPF_CONTROL)	+= pfctl.o
 
 obj-y					+= probes/
 head-y					:= head.o
-- 
2.27.0

