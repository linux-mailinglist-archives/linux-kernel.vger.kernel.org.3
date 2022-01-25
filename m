Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0C0749AD9A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 08:31:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445180AbiAYH1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 02:27:08 -0500
Received: from esa5.hc1455-7.c3s2.iphmx.com ([68.232.139.130]:34712 "EHLO
        esa5.hc1455-7.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1443736AbiAYHWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 02:22:01 -0500
IronPort-SDR: JYoD63yj9LFTzLLIlQ/KoD8A4atNtC1uDHFNlLdGitAgX/N+j2ojoKUwZS5+DzY90W7DhCL23j
 GSKaJDnJriZXGdhHz5nkvSuVcAvRBgx3XXNMUI6YQbY3L/lvsEAPn42OSVsWDn8583uHoyeXlz
 AYSp5Mju3dBtbKWqGGke35uLL/L3aMcMVrsrEkK9YfubEuK66MdMQTF0ju2oxjunCUn63InTvL
 ShIfJwga6ofpBh8gJThEiE93sXnzDsZh6V460kkGm2XmUMV6l9GNph1zZOASfOF8CX69uX/mpZ
 626QMF+Yixx4ACZkjISP3iIf
X-IronPort-AV: E=McAfee;i="6200,9189,10237"; a="60079469"
X-IronPort-AV: E=Sophos;i="5.88,314,1635174000"; 
   d="scan'208";a="60079469"
Received: from unknown (HELO oym-r4.gw.nic.fujitsu.com) ([210.162.30.92])
  by esa5.hc1455-7.c3s2.iphmx.com with ESMTP; 25 Jan 2022 16:14:41 +0900
Received: from oym-m1.gw.nic.fujitsu.com (oym-nat-oym-m1.gw.nic.fujitsu.com [192.168.87.58])
        by oym-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 35D47E07E1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 16:14:40 +0900 (JST)
Received: from yto-om4.fujitsu.com (yto-om4.o.css.fujitsu.com [10.128.89.165])
        by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 7007DD994E
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 16:14:39 +0900 (JST)
Received: from localhost.localdomain (n3235113.np.ts.nmh.cs.fujitsu.co.jp [10.123.235.113])
        by yto-om4.fujitsu.com (Postfix) with ESMTP id 266E8400C1BBE;
        Tue, 25 Jan 2022 16:14:39 +0900 (JST)
From:   Kohei Tarumizu <tarumizu.kohei@fujitsu.com>
To:     catalin.marinas@arm.com, will@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     tarumizu.kohei@fujitsu.com
Subject: [PATCH 7/8] x86: Add Kconfig/Makefile to build hardware prefetch control driver
Date:   Tue, 25 Jan 2022 16:14:13 +0900
Message-Id: <20220125071414.811344-8-tarumizu.kohei@fujitsu.com>
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
for x86 support. This also adds a MAINTAINERS entry.

Signed-off-by: Kohei Tarumizu <tarumizu.kohei@fujitsu.com>
---
 MAINTAINERS                  | 1 +
 arch/x86/Kconfig             | 7 +++++++
 arch/x86/kernel/cpu/Makefile | 2 ++
 3 files changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0eaee76438e9..ea049bddc4e6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8448,6 +8448,7 @@ HARDWARE PREFETCH CONTROL DRIVERS
 M:	Kohei Tarumizu <tarumizu.kohei@fujitsu.com>
 S:	Maintained
 F:	arch/arm64/kernel/pfctl.c
+F:	arch/x86/kernel/pfctl.c
 F:	drivers/base/pfctl.c
 F:	include/linux/pfctl.h
 
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index ebe8fc76949a..069aee252ba3 100644
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
@@ -1377,6 +1378,12 @@ config X86_CPUID
 	  with major 203 and minors 0 to 31 for /dev/cpu/0/cpuid to
 	  /dev/cpu/31/cpuid.
 
+config X86_HWPF_CONTROL
+	tristate "x86 Hardware Prefetch Control support"
+	depends on HWPF_CONTROL
+	help
+	  This adds Hardware Prefetch Control driver support for X86.
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

