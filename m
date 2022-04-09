Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9A5A4FA118
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 03:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240299AbiDIB35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 21:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240253AbiDIB3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 21:29:31 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DF6E10428E;
        Fri,  8 Apr 2022 18:27:25 -0700 (PDT)
Date:   Sat, 09 Apr 2022 01:27:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649467644;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nsKjo7b5BJ9MSr8SUroCbByi5yW9JG5hg7haZIIsKu4=;
        b=Q5Frkhfzb18PBxxphJ/kqEuXJIfmth4m2r0hrLdDmr8wzTcjyU9g+Z4Or7rRPqjEkBH3xW
        5QnAln4IEFc8x/rH8tKbZPYbmvce72G4qABJz6lvwiWt9M4lf5BGBqADTCy25wl6r9HQl2
        10uMt57I8fdBJtf8txxskvX1CoNJu8MsLGBbNfTb8xMi/dDeq6Xn4HcV4m1sryVZwuUVdw
        PlqQhzh6eBKlF+3A7uN34OJDjQL+ApyEMKdH4sMbqzerorW7Dh/M3iIQUc4lP01aoikuSI
        kseWvcgM73cR6k/66A38mMsRwFOatcs/DXNXcrEsdBhpJHhGn3l8jaWIL24FUQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649467644;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nsKjo7b5BJ9MSr8SUroCbByi5yW9JG5hg7haZIIsKu4=;
        b=FI53CLxZiXYHWwAwSLQVITtCwZKSxuSAD3+00uARxj+0+gFFJwnVOGz8h67wowzCxqeLZA
        gpqGRXeedsxyRBBg==
From:   "tip-bot2 for Kuppuswamy Sathyanarayanan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/tdx] x86/topology: Disable CPU online/offline control for
 TDX guests
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220405232939.73860-25-kirill.shutemov@linux.intel.com>
References: <20220405232939.73860-25-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Message-ID: <164946764312.4207.14697790452742535352.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/tdx branch of tip:

Commit-ID:     bae1a962ac2c5e6be08319ff3f7d6df542584fce
Gitweb:        https://git.kernel.org/tip/bae1a962ac2c5e6be08319ff3f7d6df542584fce
Author:        Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
AuthorDate:    Wed, 06 Apr 2022 02:29:33 +03:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 07 Apr 2022 08:27:53 -07:00

x86/topology: Disable CPU online/offline control for TDX guests

Unlike regular VMs, TDX guests use the firmware hand-off wakeup method
to wake up the APs during the boot process. This wakeup model uses a
mailbox to communicate with firmware to bring up the APs. As per the
design, this mailbox can only be used once for the given AP, which means
after the APs are booted, the same mailbox cannot be used to
offline/online the given AP. More details about this requirement can be
found in Intel TDX Virtual Firmware Design Guide, sec titled "AP
initialization in OS" and in sec titled "Hotplug Device".

Since the architecture does not support any method of offlining the
CPUs, disable CPU hotplug support in the kernel.

Since this hotplug disable feature can be re-used by other VM guests,
add a new CC attribute CC_ATTR_HOTPLUG_DISABLED and use it to disable
the hotplug support.

Attempt to offline CPU will fail with -EOPNOTSUPP.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20220405232939.73860-25-kirill.shutemov@linux.intel.com
---
 arch/x86/coco/core.c        |  1 +
 include/linux/cc_platform.h | 10 ++++++++++
 kernel/cpu.c                |  7 +++++++
 3 files changed, 18 insertions(+)

diff --git a/arch/x86/coco/core.c b/arch/x86/coco/core.c
index df08edc..70956f9 100644
--- a/arch/x86/coco/core.c
+++ b/arch/x86/coco/core.c
@@ -20,6 +20,7 @@ static bool intel_cc_platform_has(enum cc_attr attr)
 {
 	switch (attr) {
 	case CC_ATTR_GUEST_UNROLL_STRING_IO:
+	case CC_ATTR_HOTPLUG_DISABLED:
 		return true;
 	default:
 		return false;
diff --git a/include/linux/cc_platform.h b/include/linux/cc_platform.h
index efd8205..691494b 100644
--- a/include/linux/cc_platform.h
+++ b/include/linux/cc_platform.h
@@ -72,6 +72,16 @@ enum cc_attr {
 	 * Examples include TDX guest & SEV.
 	 */
 	CC_ATTR_GUEST_UNROLL_STRING_IO,
+
+	/**
+	 * @CC_ATTR_HOTPLUG_DISABLED: Hotplug is not supported or disabled.
+	 *
+	 * The platform/OS is running as a guest/virtual machine does not
+	 * support CPU hotplug feature.
+	 *
+	 * Examples include TDX Guest.
+	 */
+	CC_ATTR_HOTPLUG_DISABLED,
 };
 
 #ifdef CONFIG_ARCH_HAS_CC_PLATFORM
diff --git a/kernel/cpu.c b/kernel/cpu.c
index 5797c2a..edb8c19 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -35,6 +35,7 @@
 #include <linux/percpu-rwsem.h>
 #include <linux/cpuset.h>
 #include <linux/random.h>
+#include <linux/cc_platform.h>
 
 #include <trace/events/power.h>
 #define CREATE_TRACE_POINTS
@@ -1186,6 +1187,12 @@ out:
 
 static int cpu_down_maps_locked(unsigned int cpu, enum cpuhp_state target)
 {
+	/*
+	 * If the platform does not support hotplug, report it explicitly to
+	 * differentiate it from a transient offlining failure.
+	 */
+	if (cc_platform_has(CC_ATTR_HOTPLUG_DISABLED))
+		return -EOPNOTSUPP;
 	if (cpu_hotplug_disabled)
 		return -EBUSY;
 	return _cpu_down(cpu, 0, target);
