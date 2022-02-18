Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2516D4BBD43
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 17:20:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237800AbiBRQS0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 11:18:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237647AbiBRQR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 11:17:57 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71DF03A5F4
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 08:17:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645201047; x=1676737047;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pmoi+0bYj0GuweeL5almEtz+YRMf5ukEAhoLaZfIGhg=;
  b=Q9GNGDEc3OrUfc3FI0cffdb1KXuw9FzPgnyqW0TRu9gf92+gpQWWUDA0
   vK55KayZJJThdmfyXoxr65JtFgtxdu+jWrRvDu4GGdlMZgbXdV+y74udV
   xHBHZyljxlWYGvMSFe5OJ1jF8JN3wi5oGRRM20WsHDa9+ZUsPkkNs0A4F
   WHqbBJwZeoDMQXzzFbLiLPrBV5S3r06Vr07qgNAvFa5kl+keO86JRM037
   Z0I3qE3EKL3Gt90+sOozMCtyb10oCmR3b+FK/wBMlIMv9RGRmyBkmVO1U
   d0X+EEl+fV3NOlV45Br9HbxIQ2xKYURIdhQfL+2GgTJ3cVj3T10GIQ3Ei
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10261"; a="337599832"
X-IronPort-AV: E=Sophos;i="5.88,379,1635231600"; 
   d="scan'208";a="337599832"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2022 08:17:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,379,1635231600"; 
   d="scan'208";a="626675668"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 18 Feb 2022 08:17:20 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 4A3D8DFD; Fri, 18 Feb 2022 18:17:23 +0200 (EET)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@intel.com, luto@kernel.org, peterz@infradead.org
Cc:     sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv3 25/32] x86/topology: Disable CPU online/offline control for TDX guests
Date:   Fri, 18 Feb 2022 19:17:11 +0300
Message-Id: <20220218161718.67148-26-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220218161718.67148-1-kirill.shutemov@linux.intel.com>
References: <20220218161718.67148-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
 arch/x86/kernel/cc_platform.c |  1 +
 include/linux/cc_platform.h   | 10 ++++++++++
 kernel/cpu.c                  |  7 +++++++
 3 files changed, 18 insertions(+)

diff --git a/arch/x86/kernel/cc_platform.c b/arch/x86/kernel/cc_platform.c
index 55128de5e27c..4a05b13e24f2 100644
--- a/arch/x86/kernel/cc_platform.c
+++ b/arch/x86/kernel/cc_platform.c
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
index 407a2568f35e..6a6e98c19269 100644
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

