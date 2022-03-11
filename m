Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86B6C4D5F64
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 11:23:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347860AbiCKKXy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 05:23:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347826AbiCKKXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 05:23:42 -0500
Received: from esa12.hc1455-7.c3s2.iphmx.com (esa12.hc1455-7.c3s2.iphmx.com [139.138.37.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F116F219E
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 02:22:37 -0800 (PST)
X-IronPort-AV: E=McAfee;i="6200,9189,10282"; a="45621054"
X-IronPort-AV: E=Sophos;i="5.90,173,1643641200"; 
   d="scan'208";a="45621054"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
  by esa12.hc1455-7.c3s2.iphmx.com with ESMTP; 11 Mar 2022 19:21:29 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com [192.168.83.67])
        by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 92C2CC68AA
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 19:21:28 +0900 (JST)
Received: from yto-om1.fujitsu.com (yto-om1.o.css.fujitsu.com [10.128.89.162])
        by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id C2D69EA177
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 19:21:27 +0900 (JST)
Received: from cn-r05-10.example.com (n3235113.np.ts.nmh.cs.fujitsu.co.jp [10.123.235.113])
        by yto-om1.fujitsu.com (Postfix) with ESMTP id 89708406139C9;
        Fri, 11 Mar 2022 19:21:27 +0900 (JST)
From:   Kohei Tarumizu <tarumizu.kohei@fujitsu.com>
To:     catalin.marinas@arm.com, will@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     tarumizu.kohei@fujitsu.com
Subject: [PATCH v2 2/8] drivers: base: Add Kconfig/Makefile to build hardware prefetch control core driver
Date:   Fri, 11 Mar 2022 19:19:34 +0900
Message-Id: <20220311101940.3403607-3-tarumizu.kohei@fujitsu.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220311101940.3403607-1-tarumizu.kohei@fujitsu.com>
References: <20220311101940.3403607-1-tarumizu.kohei@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
index 05fd080b82f3..213537cea2e2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8452,6 +8452,12 @@ F:	include/linux/hwmon*.h
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

