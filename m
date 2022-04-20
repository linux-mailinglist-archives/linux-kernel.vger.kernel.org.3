Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95F83507F55
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 05:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359128AbiDTDGa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 23:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359099AbiDTDGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 23:06:15 -0400
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 19 Apr 2022 20:03:30 PDT
Received: from esa1.hc1455-7.c3s2.iphmx.com (esa1.hc1455-7.c3s2.iphmx.com [207.54.90.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE69639699
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 20:03:30 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6400,9594,10322"; a="70545362"
X-IronPort-AV: E=Sophos;i="5.90,274,1643641200"; 
   d="scan'208";a="70545362"
Received: from unknown (HELO oym-r4.gw.nic.fujitsu.com) ([210.162.30.92])
  by esa1.hc1455-7.c3s2.iphmx.com with ESMTP; 20 Apr 2022 12:02:25 +0900
Received: from oym-m4.gw.nic.fujitsu.com (oym-nat-oym-m4.gw.nic.fujitsu.com [192.168.87.61])
        by oym-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id A1FA2E07EA
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 12:02:24 +0900 (JST)
Received: from yto-om1.fujitsu.com (yto-om1.o.css.fujitsu.com [10.128.89.162])
        by oym-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 5C6C2104546
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 12:02:23 +0900 (JST)
Received: from cn-r05-10.example.com (n3235113.np.ts.nmh.cs.fujitsu.co.jp [10.123.235.113])
        by yto-om1.fujitsu.com (Postfix) with ESMTP id D882E40618A82;
        Wed, 20 Apr 2022 12:02:21 +0900 (JST)
From:   Kohei Tarumizu <tarumizu.kohei@fujitsu.com>
To:     catalin.marinas@arm.com, will@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        fenghua.yu@intel.com, reinette.chatre@intel.com
Cc:     tarumizu.kohei@fujitsu.com
Subject: [PATCH v3 4/9] soc: fujitsu: Add Kconfig/Makefile to build hardware prefetch control driver
Date:   Wed, 20 Apr 2022 12:02:18 +0900
Message-Id: <20220420030223.689259-5-tarumizu.kohei@fujitsu.com>
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

This adds Kconfig/Makefile to build hardware prefetch control driver
for A64FX support. This also adds a MAINTAINERS entry.

Signed-off-by: Kohei Tarumizu <tarumizu.kohei@fujitsu.com>
---
 MAINTAINERS                  |  1 +
 drivers/soc/Kconfig          |  1 +
 drivers/soc/Makefile         |  1 +
 drivers/soc/fujitsu/Kconfig  | 11 +++++++++++
 drivers/soc/fujitsu/Makefile |  2 ++
 5 files changed, 16 insertions(+)
 create mode 100644 drivers/soc/fujitsu/Kconfig
 create mode 100644 drivers/soc/fujitsu/Makefile

diff --git a/MAINTAINERS b/MAINTAINERS
index f6640dc053c0..b359dcc38be3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8619,6 +8619,7 @@ HARDWARE PREFETCH CONTROL DRIVERS
 M:	Kohei Tarumizu <tarumizu.kohei@fujitsu.com>
 S:	Maintained
 F:	drivers/base/pfctl.c
+F:	drivers/soc/fujitsu/a64fx-pfctl.c
 F:	include/linux/pfctl.h
 
 HARDWARE RANDOM NUMBER GENERATOR CORE
diff --git a/drivers/soc/Kconfig b/drivers/soc/Kconfig
index c5aae42673d3..d87754799d90 100644
--- a/drivers/soc/Kconfig
+++ b/drivers/soc/Kconfig
@@ -9,6 +9,7 @@ source "drivers/soc/atmel/Kconfig"
 source "drivers/soc/bcm/Kconfig"
 source "drivers/soc/canaan/Kconfig"
 source "drivers/soc/fsl/Kconfig"
+source "drivers/soc/fujitsu/Kconfig"
 source "drivers/soc/imx/Kconfig"
 source "drivers/soc/ixp4xx/Kconfig"
 source "drivers/soc/litex/Kconfig"
diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
index 904eec2a7871..6c8ff1792cda 100644
--- a/drivers/soc/Makefile
+++ b/drivers/soc/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_SOC_CANAAN)	+= canaan/
 obj-$(CONFIG_ARCH_DOVE)		+= dove/
 obj-$(CONFIG_MACH_DOVE)		+= dove/
 obj-y				+= fsl/
+obj-y				+= fujitsu/
 obj-$(CONFIG_ARCH_GEMINI)	+= gemini/
 obj-y				+= imx/
 obj-y				+= ixp4xx/
diff --git a/drivers/soc/fujitsu/Kconfig b/drivers/soc/fujitsu/Kconfig
new file mode 100644
index 000000000000..d9db05d5055d
--- /dev/null
+++ b/drivers/soc/fujitsu/Kconfig
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+menu "Fujitsu SoC drivers"
+
+config A64FX_HWPF_CONTROL
+	tristate "A64FX Hardware Prefetch Control driver"
+	depends on ARM64 || HWPF_CONTROL
+	help
+	  This adds Hardware Prefetch driver control support for A64FX.
+
+endmenu
diff --git a/drivers/soc/fujitsu/Makefile b/drivers/soc/fujitsu/Makefile
new file mode 100644
index 000000000000..35e284a548bb
--- /dev/null
+++ b/drivers/soc/fujitsu/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+obj-$(CONFIG_A64FX_HWPF_CONTROL)	+= a64fx-pfctl.o
-- 
2.27.0

