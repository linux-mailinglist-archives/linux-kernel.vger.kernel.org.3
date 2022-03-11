Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D23024D5F65
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 11:23:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347928AbiCKKYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 05:24:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347868AbiCKKXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 05:23:55 -0500
X-Greylist: delayed 64 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 11 Mar 2022 02:22:46 PST
Received: from esa8.hc1455-7.c3s2.iphmx.com (esa8.hc1455-7.c3s2.iphmx.com [139.138.61.253])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0AC727172
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 02:22:45 -0800 (PST)
X-IronPort-AV: E=McAfee;i="6200,9189,10282"; a="53868029"
X-IronPort-AV: E=Sophos;i="5.90,173,1643641200"; 
   d="scan'208";a="53868029"
Received: from unknown (HELO oym-r4.gw.nic.fujitsu.com) ([210.162.30.92])
  by esa8.hc1455-7.c3s2.iphmx.com with ESMTP; 11 Mar 2022 19:21:39 +0900
Received: from oym-m1.gw.nic.fujitsu.com (oym-nat-oym-m1.gw.nic.fujitsu.com [192.168.87.58])
        by oym-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id D2427E05DE
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 19:21:38 +0900 (JST)
Received: from yto-om1.fujitsu.com (yto-om1.o.css.fujitsu.com [10.128.89.162])
        by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id E3457E14DF
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 19:21:37 +0900 (JST)
Received: from cn-r05-10.example.com (n3235113.np.ts.nmh.cs.fujitsu.co.jp [10.123.235.113])
        by yto-om1.fujitsu.com (Postfix) with ESMTP id 997B1406139D6;
        Fri, 11 Mar 2022 19:21:37 +0900 (JST)
From:   Kohei Tarumizu <tarumizu.kohei@fujitsu.com>
To:     catalin.marinas@arm.com, will@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     tarumizu.kohei@fujitsu.com
Subject: [PATCH v2 7/8] x86: Add Kconfig/Makefile to build hardware prefetch control driver
Date:   Fri, 11 Mar 2022 19:19:39 +0900
Message-Id: <20220311101940.3403607-8-tarumizu.kohei@fujitsu.com>
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
for x86 support. This also adds a MAINTAINERS entry.

Signed-off-by: Kohei Tarumizu <tarumizu.kohei@fujitsu.com>
---
 MAINTAINERS                  | 1 +
 arch/x86/Kconfig             | 7 +++++++
 arch/x86/kernel/cpu/Makefile | 2 ++
 3 files changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7eb530f5b301..1d2b4ba82500 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8456,6 +8456,7 @@ HARDWARE PREFETCH CONTROL DRIVERS
 M:	Kohei Tarumizu <tarumizu.kohei@fujitsu.com>
 S:	Maintained
 F:	arch/arm64/kernel/pfctl.c
+F:	arch/x86/kernel/pfctl.
 F:	drivers/base/pfctl.c
 F:	include/linux/pfctl.h
 
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 9f5bd41bf660..65235d25b6f1 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -26,6 +26,7 @@ config X86_64
 	depends on 64BIT
 	# Options that are inherently 64-bit kernel only:
 	select ARCH_HAS_GIGANTIC_PAGE
+	select ARCH_HAS_HWPF_CONTROL
 	select ARCH_SUPPORTS_INT128 if CC_HAS_INT128
 	select ARCH_USE_CMPXCHG_LOCKREF
 	select HAVE_ARCH_SOFT_DIRTY
@@ -1378,6 +1379,12 @@ config X86_CPUID
 	  with major 203 and minors 0 to 31 for /dev/cpu/0/cpuid to
 	  /dev/cpu/31/cpuid.
 
+config X86_HWPF_CONTROL
+	tristate "x86 Hardware Prefetch Control support"
+	depends on HWPF_CONTROL
+	help
+	  This adds Hardware Prefetch driver control support for X86.
+
 choice
 	prompt "High Memory Support"
 	default HIGHMEM4G
diff --git a/arch/x86/kernel/cpu/Makefile b/arch/x86/kernel/cpu/Makefile
index 9661e3e802be..aec62a6b37d2 100644
--- a/arch/x86/kernel/cpu/Makefile
+++ b/arch/x86/kernel/cpu/Makefile
@@ -56,6 +56,8 @@ obj-$(CONFIG_X86_LOCAL_APIC)		+= perfctr-watchdog.o
 obj-$(CONFIG_HYPERVISOR_GUEST)		+= vmware.o hypervisor.o mshyperv.o
 obj-$(CONFIG_ACRN_GUEST)		+= acrn.o
 
+obj-$(CONFIG_X86_HWPF_CONTROL)		+= pfctl.o
+
 ifdef CONFIG_X86_FEATURE_NAMES
 quiet_cmd_mkcapflags = MKCAP   $@
       cmd_mkcapflags = $(CONFIG_SHELL) $(srctree)/$(src)/mkcapflags.sh $@ $^
-- 
2.27.0

