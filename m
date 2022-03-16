Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD0A34DA7C6
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 03:11:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350417AbiCPCM2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 22:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352759AbiCPCL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 22:11:28 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C709F5E746
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 19:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647396613; x=1678932613;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QVpQSz1/Cv+bYiUNPNsOXSNCLmi88SVZ6Y8DDnwhiws=;
  b=dj83YeOuUpj7kytTyUD9R20KfD4+H8jGWoDMseSPncbkf9qjAJEXUfV5
   EnLadNYZh2eypJhGOBfUTByhMJgdwE7WBzWEYue2TKKEXduEgRQMjsvYh
   gqjH/TlYqg4g+Gupcb54e/vrZ59FxYZHsKvZgBczFSYRwME2Kj0+03KKn
   WkCjqi+iOfETeZtDZhPr9xoohoOcxlGi72zWo44yHu2YwLWCty3t4oq/2
   sWFzETJRRFYGNvTymmdGUbTPHOvD9jUJKsROpUmN68xer2c3KR0pob523
   3oqZEZItY8f/BTLIZRnBLN5gH+Ls5Og10918ao6gqat6nHAL0uOMbdaKy
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="236415685"
X-IronPort-AV: E=Sophos;i="5.90,185,1643702400"; 
   d="scan'208";a="236415685"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 19:10:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,185,1643702400"; 
   d="scan'208";a="714416785"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 15 Mar 2022 19:10:05 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id C24E5C00; Wed, 16 Mar 2022 04:10:10 +0200 (EET)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@intel.com, luto@kernel.org, peterz@infradead.org
Cc:     sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        thomas.lendacky@amd.com, brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv6 24/30] x86/topology: Disable CPU online/offline control for TDX guests
Date:   Wed, 16 Mar 2022 05:08:50 +0300
Message-Id: <20220316020856.24435-25-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220316020856.24435-1-kirill.shutemov@linux.intel.com>
References: <20220316020856.24435-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

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

With hotplug disabled, /sys/devices/system/cpu/cpuX/online sysfs option
will not exist for TDX guests.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/coco/core.c        |  1 +
 include/linux/cc_platform.h | 10 ++++++++++
 kernel/cpu.c                |  7 +++++++
 3 files changed, 18 insertions(+)

diff --git a/arch/x86/coco/core.c b/arch/x86/coco/core.c
index df08edc94f9b..70956f9d7c7e 100644
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
index efd8205282da..691494bbaf5a 100644
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
index f39eb0b52dfe..c94f00fa34d3 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -34,6 +34,7 @@
 #include <linux/scs.h>
 #include <linux/percpu-rwsem.h>
 #include <linux/cpuset.h>
+#include <linux/cc_platform.h>
 
 #include <trace/events/power.h>
 #define CREATE_TRACE_POINTS
@@ -1185,6 +1186,12 @@ static int __ref _cpu_down(unsigned int cpu, int tasks_frozen,
 
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
-- 
2.34.1

