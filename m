Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D8A94A52CC
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 00:01:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236748AbiAaXBe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 18:01:34 -0500
Received: from mga03.intel.com ([134.134.136.65]:53704 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235781AbiAaXBT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 18:01:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643670079; x=1675206079;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HY/bz+/rI+UbhijOVUtdDlgLNv9q2KmlLYwHNyBOdnk=;
  b=e/V8LuauKppi3gITygWYtUkUouiOo1oMW5dn24gixRmeES9l6vlcYkcv
   iu45naR0iuqlcHUE0gb4muoZyP066XSnStD2V9huEqOEgLo4qvMztM6Oa
   8jk5q1WwSVLZavjsmO/CMnEpFjkm8G5069sYssemvier7YGpGVSwXcxAx
   G8ZepTRqFByKj/AxnZfb1bwJNV+Z7ynnk7jZPvwF4G5Kf4nJ6I8k//98Q
   2T7M5OhqYomDUhdn/+NpX69gmkDcpLOLXcMS4HkLsYY73Aw9xWqAw8m3L
   Uz48BDv9fYnDzzMtv/u/0eA01upFtjYbJV29EoYVBFUvEjfNsc7kP8lLE
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10244"; a="247521233"
X-IronPort-AV: E=Sophos;i="5.88,331,1635231600"; 
   d="scan'208";a="247521233"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2022 15:01:19 -0800
X-IronPort-AV: E=Sophos;i="5.88,331,1635231600"; 
   d="scan'208";a="522831350"
Received: from agluck-desk2.sc.intel.com ([10.3.52.146])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2022 15:01:18 -0800
From:   Tony Luck <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Smita Koralahalli Channabasappa 
        <smita.koralahallichannabasappa@amd.com>,
        Wei Huang <wei.huang2@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        patches@lists.linux.dev, Tony Luck <tony.luck@intel.com>
Subject: [PATCH v3 5/5] topology/sysfs: Add PPIN in sysfs under cpu topology
Date:   Mon, 31 Jan 2022 15:01:11 -0800
Message-Id: <20220131230111.2004669-6-tony.luck@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220131230111.2004669-1-tony.luck@intel.com>
References: <20220121174743.1875294-1-tony.luck@intel.com>
 <20220131230111.2004669-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PPIN is the Protected Processor Identification Number.
This is used to identify the socket as a Field Replaceable Unit (FRU).

Existing code only displays this when reporting errors. But this makes
it inconvenient for large clusters to use it for its intended purpose
of inventory control.

Add ppin to /sys/devices/system/cpu/cpu*/topology to make what
is already available using RDMSR more easily accessible. Make
the file read only for root in case there are still people
concerned about making a unique system "serial number" available.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 Documentation/ABI/stable/sysfs-devices-system-cpu  | 4 ++++
 Documentation/ABI/testing/sysfs-devices-system-cpu | 6 ++++++
 arch/x86/include/asm/topology.h                    | 1 +
 drivers/base/topology.c                            | 4 ++++
 include/linux/topology.h                           | 3 +++
 5 files changed, 18 insertions(+)

diff --git a/Documentation/ABI/stable/sysfs-devices-system-cpu b/Documentation/ABI/stable/sysfs-devices-system-cpu
index 3965ce504484..902392d7eddf 100644
--- a/Documentation/ABI/stable/sysfs-devices-system-cpu
+++ b/Documentation/ABI/stable/sysfs-devices-system-cpu
@@ -86,6 +86,10 @@ What:           /sys/devices/system/cpu/cpuX/topology/die_cpus
 Description:    internal kernel map of CPUs within the same die.
 Values:         hexadecimal bitmask.
 
+What:           /sys/devices/system/cpu/cpuX/topology/ppin
+Description:    per-socket protected processor inventory number
+Values:         hexadecimal.
+
 What:           /sys/devices/system/cpu/cpuX/topology/die_cpus_list
 Description:    human-readable list of CPUs within the same die.
                 The format is like 0-3, 8-11, 14,17.
diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
index 61f5676a7429..74962c200790 100644
--- a/Documentation/ABI/testing/sysfs-devices-system-cpu
+++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
@@ -73,6 +73,7 @@ What:		/sys/devices/system/cpu/cpuX/topology/core_id
 		/sys/devices/system/cpu/cpuX/topology/physical_package_id
 		/sys/devices/system/cpu/cpuX/topology/thread_siblings
 		/sys/devices/system/cpu/cpuX/topology/thread_siblings_list
+		/sys/devices/system/cpu/cpuX/topology/ppin
 Date:		December 2008
 Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
 Description:	CPU topology files that describe a logical CPU's relationship
@@ -103,6 +104,11 @@ Description:	CPU topology files that describe a logical CPU's relationship
 		thread_siblings_list: human-readable list of cpuX's hardware
 		threads within the same core as cpuX
 
+		ppin: human-readable Protected Processor Identification
+		Number of the socket the cpu# belongs to. There should be
+		one per physical_package_id. File is readable only to
+		admin.
+
 		See Documentation/admin-guide/cputopology.rst for more information.
 
 
diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
index 2f0b6be8eaab..43a89476a522 100644
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -110,6 +110,7 @@ extern const struct cpumask *cpu_clustergroup_mask(int cpu);
 #define topology_logical_die_id(cpu)		(cpu_data(cpu).logical_die_id)
 #define topology_die_id(cpu)			(cpu_data(cpu).cpu_die_id)
 #define topology_core_id(cpu)			(cpu_data(cpu).cpu_core_id)
+#define topology_ppin(cpu)			(cpu_data(cpu).ppin)
 
 extern unsigned int __max_die_per_package;
 
diff --git a/drivers/base/topology.c b/drivers/base/topology.c
index 044f3664f8f2..e9d1efcda89b 100644
--- a/drivers/base/topology.c
+++ b/drivers/base/topology.c
@@ -58,6 +58,9 @@ static DEVICE_ATTR_RO(cluster_id);
 define_id_show_func(core_id, "%d");
 static DEVICE_ATTR_RO(core_id);
 
+define_id_show_func(ppin, "0x%llx");
+static DEVICE_ATTR_ADMIN_RO(ppin);
+
 define_siblings_read_func(thread_siblings, sibling_cpumask);
 static BIN_ATTR_RO(thread_siblings, 0);
 static BIN_ATTR_RO(thread_siblings_list, 0);
@@ -145,6 +148,7 @@ static struct attribute *default_attrs[] = {
 #ifdef TOPOLOGY_DRAWER_SYSFS
 	&dev_attr_drawer_id.attr,
 #endif
+	&dev_attr_ppin.attr,
 	NULL
 };
 
diff --git a/include/linux/topology.h b/include/linux/topology.h
index a6e201758ae9..f19bc3626297 100644
--- a/include/linux/topology.h
+++ b/include/linux/topology.h
@@ -211,6 +211,9 @@ static inline int cpu_to_mem(int cpu)
 #ifndef topology_drawer_id
 #define topology_drawer_id(cpu)			((void)(cpu), -1)
 #endif
+#ifndef topology_ppin
+#define topology_ppin(cpu)			((void)(cpu), 0ull)
+#endif
 #ifndef topology_sibling_cpumask
 #define topology_sibling_cpumask(cpu)		cpumask_of(cpu)
 #endif
-- 
2.31.1

