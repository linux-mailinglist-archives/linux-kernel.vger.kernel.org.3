Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F133E4846D5
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 18:15:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234376AbiADRPd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 12:15:33 -0500
Received: from mga03.intel.com ([134.134.136.65]:4971 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234294AbiADRP2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 12:15:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641316528; x=1672852528;
  h=subject:to:cc:from:date:message-id;
  bh=mHAhhGsW98mrkuTgaYoayQ/f0o33+rOi96OFkqp8lO0=;
  b=SRKqxRJAJqxeSuQUohbkBRzNEVMOGx80Tp3RQew/rh9DWtA1eQbxT677
   u2qYWQUgvRHfceQ3qXU44Dkew/eSe6iwNDFnFig7opZOINIohmKf831/x
   tJ0VSsICfewr/kFz2OqFu3YiRsIpFpI3WEKh8k6s9CSwO9YpI+vDhAjiq
   Ui8dE0Gpae6qKhaaMZuCOgBg2QXoZXwDwHdnS7VtOnxAHC3po8p0Hidwo
   9eWcTPwH/HjdlGk4yA2kpZy+dg8FR/tRP/8t3YXkFyDD5fhQCeRkk5OVF
   8Tw6I3eO3dY1/iwHzn3q+Fa43Rv1+dXGtbO5BQM1MtRZ5JnD+9mox06yt
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10216"; a="242220004"
X-IronPort-AV: E=Sophos;i="5.88,261,1635231600"; 
   d="scan'208";a="242220004"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2022 09:15:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,261,1635231600"; 
   d="scan'208";a="556228829"
Received: from davehans-spike.ostc.intel.com (HELO localhost.localdomain) ([10.165.28.105])
  by orsmga001.jf.intel.com with ESMTP; 04 Jan 2022 09:15:27 -0800
Subject: [PATCH] [v3] x86/sgx: Fix NULL pointer dereference on non-SGX systems
To:     linux-kernel@vger.kernel.org
Cc:     patches@lists.linux.dev, Dave Hansen <dave.hansen@linux.intel.com>,
        nathan@kernel.org, gregkh@linuxfoundation.org, jarkko@kernel.org,
        linux-sgx@vger.kernel.org, x86@kernel.org
From:   Dave Hansen <dave.hansen@linux.intel.com>
Date:   Tue, 04 Jan 2022 09:15:27 -0800
Message-Id: <20220104171527.5E8416A8@davehans-spike.ostc.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: Dave Hansen <dave.hansen@linux.intel.com>

== Problem ==

Nathan Chancellor reported an oops when aceessing the
'sgx_total_bytes' sysfs file:

	https://lore.kernel.org/all/YbzhBrimHGGpddDM@archlinux-ax161/

The sysfs output code accesses the sgx_numa_nodes[] array
unconditionally.  However, this array is allocated during SGX
initialization, which only occurs on systems where SGX is
supported.

If the sysfs file is accessed on systems without SGX support,
sgx_numa_nodes[] is NULL and an oops occurs.

== Solution ==

To fix this, hide the entire nodeX/x86/ attribute group on
systems without SGX support using the ->is_visible attribute
group callback.

Unfortunately, SGX is initialized via a device_initcall() which
occurs _after_ the ->is_visible() callback.  Instead of moving
SGX initialization earlier, call sysfs_update_group() during
SGX initialization to update the group visiblility.

This update requires moving the SGX sysfs code earlier in
sgx/main.c.  There are no code changes other than the addition of
arch_update_sysfs_visibility() and a minor whitespace fixup to
arch_node_attr_is_visible() which checkpatch caught.

Fixes: 50468e431335 ("x86/sgx: Add an attribute for the amount of SGX memory in a NUMA node")
Reported-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-sgx@vger.kernel.org
Cc: x86@kernel.org
---

 b/arch/x86/kernel/cpu/sgx/main.c |   65 ++++++++++++++++++++++++++++-----------
 1 file changed, 47 insertions(+), 18 deletions(-)

diff -puN arch/x86/kernel/cpu/sgx/main.c~sgx-null-ptr arch/x86/kernel/cpu/sgx/main.c
--- a/arch/x86/kernel/cpu/sgx/main.c~sgx-null-ptr	2021-12-20 07:56:38.309584807 -0800
+++ b/arch/x86/kernel/cpu/sgx/main.c	2022-01-04 08:43:17.042821249 -0800
@@ -6,11 +6,13 @@
 #include <linux/highmem.h>
 #include <linux/kthread.h>
 #include <linux/miscdevice.h>
+#include <linux/node.h>
 #include <linux/pagemap.h>
 #include <linux/ratelimit.h>
 #include <linux/sched/mm.h>
 #include <linux/sched/signal.h>
 #include <linux/slab.h>
+#include <linux/sysfs.h>
 #include <asm/sgx.h>
 #include "driver.h"
 #include "encl.h"
@@ -780,6 +782,48 @@ static inline u64 __init sgx_calc_sectio
 	       ((high & GENMASK_ULL(19, 0)) << 32);
 }
 
+#ifdef CONFIG_NUMA
+static ssize_t sgx_total_bytes_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%lu\n", sgx_numa_nodes[dev->id].size);
+}
+static DEVICE_ATTR_RO(sgx_total_bytes);
+
+static umode_t arch_node_attr_is_visible(struct kobject *kobj,
+		struct attribute *attr, int idx)
+{
+	/* Make all x86/ attributes invisible when SGX is not initialized: */
+	if (nodes_empty(sgx_numa_mask))
+		return 0;
+
+	return attr->mode;
+}
+
+static struct attribute *arch_node_dev_attrs[] = {
+	&dev_attr_sgx_total_bytes.attr,
+	NULL,
+};
+
+const struct attribute_group arch_node_dev_group = {
+	.name = "x86",
+	.attrs = arch_node_dev_attrs,
+	.is_visible = arch_node_attr_is_visible,
+};
+
+static void __init arch_update_sysfs_visibility(int nid)
+{
+	struct node *node = node_devices[nid];
+	int ret;
+
+	ret = sysfs_update_group(&node->dev.kobj, &arch_node_dev_group);
+
+	if (ret)
+		pr_err("sysfs update failed (%d), files may be invisible", ret);
+}
+#else /* !CONFIG_NUMA */
+static void __init arch_update_sysfs_visibility(int nid) {}
+#endif
+
 static bool __init sgx_page_cache_init(void)
 {
 	u32 eax, ebx, ecx, edx, type;
@@ -826,6 +870,9 @@ static bool __init sgx_page_cache_init(v
 			INIT_LIST_HEAD(&sgx_numa_nodes[nid].sgx_poison_page_list);
 			node_set(nid, sgx_numa_mask);
 			sgx_numa_nodes[nid].size = 0;
+
+			/* Make SGX-specific node sysfs files visible: */
+			arch_update_sysfs_visibility(nid);
 		}
 
 		sgx_epc_sections[i].node =  &sgx_numa_nodes[nid];
@@ -903,24 +950,6 @@ int sgx_set_attribute(unsigned long *all
 }
 EXPORT_SYMBOL_GPL(sgx_set_attribute);
 
-#ifdef CONFIG_NUMA
-static ssize_t sgx_total_bytes_show(struct device *dev, struct device_attribute *attr, char *buf)
-{
-	return sysfs_emit(buf, "%lu\n", sgx_numa_nodes[dev->id].size);
-}
-static DEVICE_ATTR_RO(sgx_total_bytes);
-
-static struct attribute *arch_node_dev_attrs[] = {
-	&dev_attr_sgx_total_bytes.attr,
-	NULL,
-};
-
-const struct attribute_group arch_node_dev_group = {
-	.name = "x86",
-	.attrs = arch_node_dev_attrs,
-};
-#endif /* CONFIG_NUMA */
-
 static int __init sgx_init(void)
 {
 	int ret;
_
