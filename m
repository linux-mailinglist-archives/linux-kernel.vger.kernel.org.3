Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7670452B253
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 08:37:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231481AbiERGbt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 02:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231465AbiERGbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 02:31:39 -0400
Received: from esa1.hc1455-7.c3s2.iphmx.com (esa1.hc1455-7.c3s2.iphmx.com [207.54.90.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E12751E3D8
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 23:31:37 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6400,9594,10350"; a="73279863"
X-IronPort-AV: E=Sophos;i="5.91,234,1647270000"; 
   d="scan'208";a="73279863"
Received: from unknown (HELO oym-r3.gw.nic.fujitsu.com) ([210.162.30.91])
  by esa1.hc1455-7.c3s2.iphmx.com with ESMTP; 18 May 2022 15:31:36 +0900
Received: from oym-m4.gw.nic.fujitsu.com (oym-nat-oym-m4.gw.nic.fujitsu.com [192.168.87.61])
        by oym-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 07A16D646F
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 15:31:35 +0900 (JST)
Received: from yto-om4.fujitsu.com (yto-om4.o.css.fujitsu.com [10.128.89.165])
        by oym-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 21D4BE126C
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 15:31:34 +0900 (JST)
Received: from cn-r05-10.example.com (n3235113.np.ts.nmh.cs.fujitsu.co.jp [10.123.235.113])
        by yto-om4.fujitsu.com (Postfix) with ESMTP id 96609400C1BB9;
        Wed, 18 May 2022 15:31:33 +0900 (JST)
From:   Kohei Tarumizu <tarumizu.kohei@fujitsu.com>
To:     catalin.marinas@arm.com, will@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, gregkh@linuxfoundation.org,
        rafael@kernel.org, mchehab+huawei@kernel.org, eugenis@google.com,
        tony.luck@intel.com, pcc@google.com, peterz@infradead.org,
        marcos@orca.pet, conor.dooley@microchip.com,
        nicolas.ferre@microchip.com, marcan@marcan.st,
        linus.walleij@linaro.org, arnd@arndb.de,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     tarumizu.kohei@fujitsu.com
Subject: [PATCH v4 7/8] x86: Add Kconfig/Makefile to build hardware prefetch control driver
Date:   Wed, 18 May 2022 15:30:31 +0900
Message-Id: <20220518063032.2377351-8-tarumizu.kohei@fujitsu.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220518063032.2377351-1-tarumizu.kohei@fujitsu.com>
References: <20220518063032.2377351-1-tarumizu.kohei@fujitsu.com>
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
 arch/x86/Kconfig             | 6 ++++++
 arch/x86/kernel/cpu/Makefile | 2 ++
 3 files changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index dd1345087881..9759c3606c7d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8623,6 +8623,7 @@ K:	(devm_)?hwmon_device_(un)?register(|_with_groups|_with_info)
 HARDWARE PREFETCH CONTROL DRIVERS
 M:	Kohei Tarumizu <tarumizu.kohei@fujitsu.com>
 S:	Maintained
+F:	arch/x86/kernel/cpu/x86-pfctl.c
 F:	drivers/base/pfctl.c
 F:	drivers/soc/fujitsu/a64fx-pfctl.c
 F:	include/linux/pfctl.h
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 4bed3abf444d..81df9efc69e5 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1359,6 +1359,12 @@ config X86_CPUID
 	  with major 203 and minors 0 to 31 for /dev/cpu/0/cpuid to
 	  /dev/cpu/31/cpuid.
 
+config X86_HWPF_CONTROL
+	tristate "x86 Hardware Prefetch Control support"
+	depends on X86_64 && HWPF_CONTROL
+	help
+	  This adds Hardware Prefetch driver control support for X86.
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

