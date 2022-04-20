Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02DEA507F53
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 05:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359096AbiDTDGU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 23:06:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354806AbiDTDGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 23:06:10 -0400
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 19 Apr 2022 20:03:25 PDT
Received: from esa6.hc1455-7.c3s2.iphmx.com (esa6.hc1455-7.c3s2.iphmx.com [68.232.139.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3EF5393E3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 20:03:25 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6400,9594,10322"; a="70939953"
X-IronPort-AV: E=Sophos;i="5.90,274,1643641200"; 
   d="scan'208";a="70939953"
Received: from unknown (HELO oym-r2.gw.nic.fujitsu.com) ([210.162.30.90])
  by esa6.hc1455-7.c3s2.iphmx.com with ESMTP; 20 Apr 2022 12:02:20 +0900
Received: from oym-m2.gw.nic.fujitsu.com (oym-nat-oym-m2.gw.nic.fujitsu.com [192.168.87.59])
        by oym-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 7C33BDB9F5
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 12:02:19 +0900 (JST)
Received: from yto-om1.fujitsu.com (yto-om1.o.css.fujitsu.com [10.128.89.162])
        by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id A97F0BDC32
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 12:02:18 +0900 (JST)
Received: from cn-r05-10.example.com (n3235113.np.ts.nmh.cs.fujitsu.co.jp [10.123.235.113])
        by yto-om1.fujitsu.com (Postfix) with ESMTP id 50B8B40618A81;
        Wed, 20 Apr 2022 12:02:18 +0900 (JST)
From:   Kohei Tarumizu <tarumizu.kohei@fujitsu.com>
To:     catalin.marinas@arm.com, will@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        fenghua.yu@intel.com, reinette.chatre@intel.com
Cc:     tarumizu.kohei@fujitsu.com
Subject: [PATCH v3 2/9] drivers: base: Add Kconfig/Makefile to build hardware prefetch control core driver
Date:   Wed, 20 Apr 2022 12:02:16 +0900
Message-Id: <20220420030223.689259-3-tarumizu.kohei@fujitsu.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220420030223.689259-1-tarumizu.kohei@fujitsu.com>
References: <20220420030223.689259-1-tarumizu.kohei@fujitsu.com>
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
 MAINTAINERS           | 6 ++++++
 drivers/base/Kconfig  | 9 +++++++++
 drivers/base/Makefile | 1 +
 3 files changed, 16 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 40fa1955ca3f..f6640dc053c0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8615,6 +8615,12 @@ F:	include/linux/hwmon*.h
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
index 6f04b831a5c0..8f8a69e7f645 100644
--- a/drivers/base/Kconfig
+++ b/drivers/base/Kconfig
@@ -230,4 +230,13 @@ config GENERIC_ARCH_NUMA
 	  Enable support for generic NUMA implementation. Currently, RISC-V
 	  and ARM64 use it.
 
+config HWPF_CONTROL
+	bool "Hardware Prefetch Control driver"
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

