Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 107F253FE62
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 14:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243524AbiFGMIb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 08:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243449AbiFGMH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 08:07:57 -0400
Received: from esa7.hc1455-7.c3s2.iphmx.com (esa7.hc1455-7.c3s2.iphmx.com [139.138.61.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E3F48BD15
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 05:07:50 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6400,9594,10370"; a="54332932"
X-IronPort-AV: E=Sophos;i="5.91,283,1647270000"; 
   d="scan'208";a="54332932"
Received: from unknown (HELO yto-r3.gw.nic.fujitsu.com) ([218.44.52.219])
  by esa7.hc1455-7.c3s2.iphmx.com with ESMTP; 07 Jun 2022 21:07:48 +0900
Received: from yto-m2.gw.nic.fujitsu.com (yto-nat-yto-m2.gw.nic.fujitsu.com [192.168.83.65])
        by yto-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 51419D5028;
        Tue,  7 Jun 2022 21:07:47 +0900 (JST)
Received: from oym-om4.fujitsu.com (oym-om4.o.css.fujitsu.com [10.85.58.164])
        by yto-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 7901FD35B2;
        Tue,  7 Jun 2022 21:07:46 +0900 (JST)
Received: from cn-r05-10.example.com (n3235113.np.ts.nmh.cs.fujitsu.co.jp [10.123.235.113])
        by oym-om4.fujitsu.com (Postfix) with ESMTP id EB3744008021D;
        Tue,  7 Jun 2022 21:07:45 +0900 (JST)
From:   Kohei Tarumizu <tarumizu.kohei@fujitsu.com>
To:     catalin.marinas@arm.com, will@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, rafael@kernel.org, lenb@kernel.org,
        gregkh@linuxfoundation.org, mchehab+huawei@kernel.org,
        eugenis@google.com, tony.luck@intel.com, pcc@google.com,
        peterz@infradead.org, marcos@orca.pet, marcan@marcan.st,
        linus.walleij@linaro.org, nicolas.ferre@microchip.com,
        conor.dooley@microchip.com, arnd@arndb.de, ast@kernel.org,
        peter.chen@kernel.org, kuba@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-acpi@vger.kernel.org
Cc:     tarumizu.kohei@fujitsu.com
Subject: [PATCH v5 5/6] x86: Add Kconfig/Makefile to build hardware prefetch control driver
Date:   Tue,  7 Jun 2022 21:05:29 +0900
Message-Id: <20220607120530.2447112-6-tarumizu.kohei@fujitsu.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220607120530.2447112-1-tarumizu.kohei@fujitsu.com>
References: <20220607120530.2447112-1-tarumizu.kohei@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
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
 MAINTAINERS                  |  1 +
 arch/x86/Kconfig             | 17 +++++++++++++++++
 arch/x86/kernel/cpu/Makefile |  2 ++
 3 files changed, 20 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b3e920a8a044..4f44bbef2614 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8623,6 +8623,7 @@ K:	(devm_)?hwmon_device_(un)?register(|_with_groups|_with_info)
 HARDWARE PREFETCH CONTROL DRIVERS
 M:	Kohei Tarumizu <tarumizu.kohei@fujitsu.com>
 S:	Maintained
+F:	arch/x86/kernel/cpu/x86-pfctl.c
 F:	drivers/soc/fujitsu/a64fx-pfctl.c
 
 HARDWARE RANDOM NUMBER GENERATOR CORE
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 4bed3abf444d..3ee173483f9f 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1359,6 +1359,23 @@ config X86_CPUID
 	  with major 203 and minors 0 to 31 for /dev/cpu/0/cpuid to
 	  /dev/cpu/31/cpuid.
 
+config X86_HWPF_CONTROL
+	tristate "x86 Hardware Prefetch Control support"
+	depends on X86_64
+	help
+	  This provides a sysfs interface to control the Hardware Prefetch
+	  behavior for X86.
+
+	  Some Intel processors have MSR 0x1a4 (MSR_MISC_FEATURE_CONTROL),
+	  which can control the hardware prefech behavior. If the processor
+	  supports this, the module can be loaded with the name x86-pfctl.
+
+	  Depending on the characteristics of the application, this register
+	  parameters improve or degrade performance.
+
+	  Please see Documentation/ABI/testing/sysfs-devices-system-cpu for
+	  more information.
+
 choice
 	prompt "High Memory Support"
 	default HIGHMEM4G
diff --git a/arch/x86/kernel/cpu/Makefile b/arch/x86/kernel/cpu/Makefile
index 9661e3e802be..1aa13dad17a3 100644
--- a/arch/x86/kernel/cpu/Makefile
+++ b/arch/x86/kernel/cpu/Makefile
@@ -56,6 +56,8 @@ obj-$(CONFIG_X86_LOCAL_APIC)		+= perfctr-watchdog.o
 obj-$(CONFIG_HYPERVISOR_GUEST)		+= vmware.o hypervisor.o mshyperv.o
 obj-$(CONFIG_ACRN_GUEST)		+= acrn.o
 
+obj-$(CONFIG_X86_HWPF_CONTROL)		+= x86-pfctl.o
+
 ifdef CONFIG_X86_FEATURE_NAMES
 quiet_cmd_mkcapflags = MKCAP   $@
       cmd_mkcapflags = $(CONFIG_SHELL) $(srctree)/$(src)/mkcapflags.sh $@ $^
-- 
2.27.0

