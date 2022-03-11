Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E47814D5F62
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 11:23:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347866AbiCKKYA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 05:24:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347835AbiCKKXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 05:23:44 -0500
X-Greylist: delayed 64 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 11 Mar 2022 02:22:40 PST
Received: from esa11.hc1455-7.c3s2.iphmx.com (esa11.hc1455-7.c3s2.iphmx.com [207.54.90.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CC965F5B
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 02:22:38 -0800 (PST)
X-IronPort-AV: E=McAfee;i="6200,9189,10282"; a="45468770"
X-IronPort-AV: E=Sophos;i="5.90,173,1643641200"; 
   d="scan'208";a="45468770"
Received: from unknown (HELO yto-r4.gw.nic.fujitsu.com) ([218.44.52.220])
  by esa11.hc1455-7.c3s2.iphmx.com with ESMTP; 11 Mar 2022 19:21:33 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com [192.168.83.67])
        by yto-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 99104E05CC
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 19:21:32 +0900 (JST)
Received: from yto-om1.fujitsu.com (yto-om1.o.css.fujitsu.com [10.128.89.162])
        by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id BFDBFEA177
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 19:21:31 +0900 (JST)
Received: from cn-r05-10.example.com (n3235113.np.ts.nmh.cs.fujitsu.co.jp [10.123.235.113])
        by yto-om1.fujitsu.com (Postfix) with ESMTP id 7FA0F406139C9;
        Fri, 11 Mar 2022 19:21:31 +0900 (JST)
From:   Kohei Tarumizu <tarumizu.kohei@fujitsu.com>
To:     catalin.marinas@arm.com, will@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     tarumizu.kohei@fujitsu.com
Subject: [PATCH v2 4/8] arm64: Add Kconfig/Makefile to build hardware prefetch control driver
Date:   Fri, 11 Mar 2022 19:19:36 +0900
Message-Id: <20220311101940.3403607-5-tarumizu.kohei@fujitsu.com>
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

This adds Kconfig/Makefile to build hardware prefetch control driver
for arm64 support. This also adds a MAINTAINERS entry.

Signed-off-by: Kohei Tarumizu <tarumizu.kohei@fujitsu.com>
---
 MAINTAINERS                | 1 +
 arch/arm64/Kconfig         | 7 +++++++
 arch/arm64/kernel/Makefile | 1 +
 3 files changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 213537cea2e2..7eb530f5b301 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8455,6 +8455,7 @@ K:	(devm_)?hwmon_device_(un)?register(|_with_groups|_with_info)
 HARDWARE PREFETCH CONTROL DRIVERS
 M:	Kohei Tarumizu <tarumizu.kohei@fujitsu.com>
 S:	Maintained
+F:	arch/arm64/kernel/pfctl.c
 F:	drivers/base/pfctl.c
 F:	include/linux/pfctl.h
 
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 09b885cc4db5..da6bf7e75df6 100644
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
@@ -2027,6 +2028,12 @@ config STACKPROTECTOR_PER_TASK
 	def_bool y
 	depends on STACKPROTECTOR && CC_HAVE_STACKPROTECTOR_SYSREG
 
+config ARM64_HWPF_CONTROL
+	tristate "ARM64 Hardware Prefetch Control support"
+	depends on HWPF_CONTROL
+	help
+	  This adds Hardware Prefetch driver control support for ARM64.
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

