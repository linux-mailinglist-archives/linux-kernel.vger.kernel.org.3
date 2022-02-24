Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B08B4C308A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 16:59:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236744AbiBXP6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 10:58:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236748AbiBXP5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 10:57:16 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D40264DB
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 07:56:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645718199; x=1677254199;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=q7UkitiuT+GdBLhgi9ovK3JIVhbOcenWO7329OdQmvk=;
  b=Nv6d/Dyyt2LP9RlvlxOT9poaM0VSDGZa02nQFrc9o435u29zB6y9UKcw
   s+yki9cotfDQXj4oTTt/+uCmpSREn2W9NLk85SihLnjMows8NO2QhPHt9
   MkzqOthk0a/K5vg0r/QzwqZTwmFEQxIakOPhxHMct78dmwE2F73I3QVgi
   nR243i6iw9m4AkWWn3AxSH1OsONTLpDPWecTOvEgmlzp9jk2BCoIZIlPT
   4m0Lo9q1vV5aAwuAGuwIe4TqFNjAAc92Ewu/GU1eNHoODs16dR4Ps64Q9
   JzcvSNQe/2MuzEpDfEzDwyuvD7neqfAlN/2dBSjzea9LkU3473VGAaJYn
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10268"; a="312983032"
X-IronPort-AV: E=Sophos;i="5.90,134,1643702400"; 
   d="scan'208";a="312983032"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2022 07:56:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,134,1643702400"; 
   d="scan'208";a="506362100"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 24 Feb 2022 07:56:32 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 707DDB30; Thu, 24 Feb 2022 17:56:35 +0200 (EET)
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
Subject: [PATCHv4 24/30] x86/topology: Disable CPU online/offline control for TDX guests
Date:   Thu, 24 Feb 2022 18:56:24 +0300
Message-Id: <20220224155630.52734-25-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220224155630.52734-1-kirill.shutemov@linux.intel.com>
References: <20220224155630.52734-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
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
index 5615b75e6fc6..54344122e2fe 100644
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

