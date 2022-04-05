Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE4084F53E8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 06:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445680AbiDFDTy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 23:19:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1449070AbiDFCO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 22:14:59 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83E841B30B8
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 16:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649201723; x=1680737723;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8TtOVCgVVk6EmPQmazwH+aWxaBnQ5aDw9pjLJMTZLmE=;
  b=n1alPOZWPz81uC3F1EHJ41AJvVzEhAC9U/f8fvfQIxV0txrRyiIwcz6n
   rFe4gnjC+HUoSC65O/9OsXtADyMcoMqH8N/kxgTrbaTM2Kgv4cimftJa3
   zZTN/INaQDsTxGOSHiuOCve7GFS2exdMlh0kEULpXM9iHiPQCUZ6+qLZO
   Jpm0Y3CO9194hyXpuRTfo0x1m/8P70XzJgoEKVKyLTLc+hPiJKuppRBay
   /orlMfzBPXyKadGEtP5V9nwhe4QhK/ZlwwFBhEuL6uMe6Nc7HnvSWi7Ib
   TG5n6OeBV5dlpx0dqDdq2N5Ty7sNMFZXhFyW/kJMaMVgfcmOuIxENrdTb
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10308"; a="324063657"
X-IronPort-AV: E=Sophos;i="5.90,238,1643702400"; 
   d="scan'208";a="324063657"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2022 16:34:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,238,1643702400"; 
   d="scan'208";a="505482015"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 05 Apr 2022 16:34:49 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id BD4D9F1B; Wed,  6 Apr 2022 02:29:46 +0300 (EEST)
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
Subject: [PATCHv8 24/30] x86/topology: Disable CPU online/offline control for TDX guests
Date:   Wed,  6 Apr 2022 02:29:33 +0300
Message-Id: <20220405232939.73860-25-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220405232939.73860-1-kirill.shutemov@linux.intel.com>
References: <20220405232939.73860-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
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

Attempt to offline CPU will fail with -EOPNOTSUPP.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
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
index 5797c2a7a93f..edb8c199f6a3 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -35,6 +35,7 @@
 #include <linux/percpu-rwsem.h>
 #include <linux/cpuset.h>
 #include <linux/random.h>
+#include <linux/cc_platform.h>
 
 #include <trace/events/power.h>
 #define CREATE_TRACE_POINTS
@@ -1186,6 +1187,12 @@ static int __ref _cpu_down(unsigned int cpu, int tasks_frozen,
 
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
2.35.1

