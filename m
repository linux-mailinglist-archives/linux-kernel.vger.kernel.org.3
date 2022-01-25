Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8481449AD96
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 08:31:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445090AbiAYH0J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 02:26:09 -0500
Received: from esa5.hc1455-7.c3s2.iphmx.com ([68.232.139.130]:24644 "EHLO
        esa5.hc1455-7.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1443999AbiAYHV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 02:21:57 -0500
X-Greylist: delayed 449 seconds by postgrey-1.27 at vger.kernel.org; Tue, 25 Jan 2022 02:21:57 EST
IronPort-SDR: Hulmt9SCTCfNRZKC3fW6Qmcyfi13TwRwVOtSPTVRwkiluoOdONI58QxyTB5cLnt8DUlJ8cLecz
 VjfS7YqGZdZ7xs0AD7o/79b84RUpT+lz9UnUzknnSFznp9VI0/GC6tv+RhnnzRLy71dXZQXAXZ
 26t+SzhsStBYVqYY103lZVNs35cmFfiEzmOnmSHCVbOixPAXv7K9WYi3iZXzaArA8SQrLRYx3G
 kertGmq3yjkrUbOhZ0kvWR56IY3Znp8p/rTi2GDtk2zbzoXxIy9XZWEbMamLQ8RAkXfzT7ftP1
 6+v13Hi39pHOnIwTcbAgdW9r
X-IronPort-AV: E=McAfee;i="6200,9189,10237"; a="60079426"
X-IronPort-AV: E=Sophos;i="5.88,314,1635174000"; 
   d="scan'208";a="60079426"
Received: from unknown (HELO oym-r2.gw.nic.fujitsu.com) ([210.162.30.90])
  by esa5.hc1455-7.c3s2.iphmx.com with ESMTP; 25 Jan 2022 16:14:16 +0900
Received: from oym-m3.gw.nic.fujitsu.com (oym-nat-oym-m3.gw.nic.fujitsu.com [192.168.87.60])
        by oym-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 9A680DB9F7
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 16:14:15 +0900 (JST)
Received: from yto-om4.fujitsu.com (yto-om4.o.css.fujitsu.com [10.128.89.165])
        by oym-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id D2A86D95EE
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 16:14:14 +0900 (JST)
Received: from localhost.localdomain (n3235113.np.ts.nmh.cs.fujitsu.co.jp [10.123.235.113])
        by yto-om4.fujitsu.com (Postfix) with ESMTP id 87F6B4007ED6C;
        Tue, 25 Jan 2022 16:14:14 +0900 (JST)
From:   Kohei Tarumizu <tarumizu.kohei@fujitsu.com>
To:     catalin.marinas@arm.com, will@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     tarumizu.kohei@fujitsu.com
Subject: [PATCH 2/8] drivers: base: Add Kconfig/Makefile to build hardware prefetch control core driver
Date:   Tue, 25 Jan 2022 16:14:08 +0900
Message-Id: <20220125071414.811344-3-tarumizu.kohei@fujitsu.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220125071414.811344-1-tarumizu.kohei@fujitsu.com>
References: <20220125071414.811344-1-tarumizu.kohei@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds Kconfig/Makefile to build hardware prefetch control core
driver. This also adds a MAINTAINERS entry.

Signed-off-by: Kohei Tarumizu <tarumizu.kohei@fujitsu.com>
---
 MAINTAINERS           |  6 ++++++
 drivers/base/Kconfig  | 13 +++++++++++++
 drivers/base/Makefile |  1 +
 3 files changed, 20 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ea3e6c914384..b474051c41e7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8444,6 +8444,12 @@ F:	include/linux/hwmon*.h
 F:	include/trace/events/hwmon*.h
 K:	(devm_)?hwmon_device_(un)?register(|_with_groups|_with_info)
 
+HARDWARE PREFETCH CONTROL DRIVERS
+M:	Kohei Tarumizu <tarumizu.kohei@fujitsu.com>
+S:	Maintained
+F:	drivers/base/pfctl.c
+F:	include/linux/pfctl.h
+
 HARDWARE RANDOM NUMBER GENERATOR CORE
 M:	Matt Mackall <mpm@selenic.com>
 M:	Herbert Xu <herbert@gondor.apana.org.au>
diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
index 6f04b831a5c0..d146604b5b3a 100644
--- a/drivers/base/Kconfig
+++ b/drivers/base/Kconfig
@@ -230,4 +230,17 @@ config GENERIC_ARCH_NUMA
 	  Enable support for generic NUMA implementation. Currently, RISC-V
 	  and ARM64 use it.
 
+config ARCH_HAS_HWPF_CONTROL
+	bool
+
+config HWPF_CONTROL
+	bool "Hardware Prefetch Control driver"
+	depends on ARCH_HAS_HWPF_CONTROL && SYSFS
+	help
+	  This driver allows user to control CPU's Hardware Prefetch behavior.
+	  If the machine supports this behavior, it provides a sysfs interface.
+
+	  See Documentation/ABI/testing/sysfs-devices-system-cpu for more
+	  information.
+
 endmenu
diff --git a/drivers/base/Makefile b/drivers/base/Makefile
index 02f7f1358e86..13f3a0ddf3d1 100644
--- a/drivers/base/Makefile
+++ b/drivers/base/Makefile
@@ -25,6 +25,7 @@ obj-$(CONFIG_DEV_COREDUMP) += devcoredump.o
 obj-$(CONFIG_GENERIC_MSI_IRQ_DOMAIN) += platform-msi.o
 obj-$(CONFIG_GENERIC_ARCH_TOPOLOGY) += arch_topology.o
 obj-$(CONFIG_GENERIC_ARCH_NUMA) += arch_numa.o
+obj-$(CONFIG_HWPF_CONTROL)	+= pfctl.o
 
 obj-y			+= test/
 
-- 
2.27.0

