Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA778487AB0
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 17:48:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348319AbiAGQsx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 11:48:53 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:56550 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiAGQsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 11:48:52 -0500
Date:   Fri, 07 Jan 2022 16:48:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1641574130;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OCY4EAlKlYnLHXZBeKTj2/unpIMOBS4Pq6lUTcCYIl0=;
        b=rjBUoHDWalCGCjsf/UiUfB1ag84oZ5RNdGsxQskE0kzBe/ZhVEOgjBt3MxiddhU+sDhoox
        BDmtCiBcKZ0qRcrWTOOIJyTToHlxnkbI7wrcEKCMRUbC/JIdGSoLrH2c+iZ2HXiOhMWSht
        262sTU9IVx7/WW/XIuhvlCIkfU6JReJfzP8MSUdnVYSXWL3KCZXiFnevO7PwhpLIiUG3In
        M9+g48d/uZReh5t2QHniSeCE/x/REMtaPAoH9GSRokRBpzAi/AZY/dinqu/liYZlPfUHDZ
        qAbKmHH4n4euwgKfl4hWmRO3NnCZ4hSsBqUgKfVAjbrz694QETctQo2lKQo62g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1641574130;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OCY4EAlKlYnLHXZBeKTj2/unpIMOBS4Pq6lUTcCYIl0=;
        b=6hGRLEEvyoOkhGhpiO952XR1I70VjKnq5gzb66euGUzvkqJpAFFCHRy0YXv7nIKRG8n33X
        ooq+GmwiXsRMH/Cw==
From:   "tip-bot2 for Dave Hansen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sgx] x86/sgx: Fix NULL pointer dereference on non-SGX systems
Cc:     linux-sgx@vger.kernel.org, x86@kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220104171527.5E8416A8@davehans-spike.ostc.intel.com>
References: <20220104171527.5E8416A8@davehans-spike.ostc.intel.com>
MIME-Version: 1.0
Message-ID: <164157412947.16921.14651280675483708212.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/sgx branch of tip:

Commit-ID:     cebb880030045059e55d21cbe049cdfa18d3990d
Gitweb:        https://git.kernel.org/tip/cebb880030045059e55d21cbe049cdfa18d3990d
Author:        Dave Hansen <dave.hansen@linux.intel.com>
AuthorDate:    Tue, 04 Jan 2022 09:15:27 -08:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Fri, 07 Jan 2022 08:42:33 -08:00

x86/sgx: Fix NULL pointer dereference on non-SGX systems

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

CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-sgx@vger.kernel.org
Cc: x86@kernel.org
Fixes: 50468e431335 ("x86/sgx: Add an attribute for the amount of SGX memory in a NUMA node")
Reported-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Tested-by: Nathan Chancellor <nathan@kernel.org>
Tested-by: Jarkko Sakkinen <jarkko@kernel.org>
Link: https://lkml.kernel.org/r/20220104171527.5E8416A8@davehans-spike.ostc.intel.com
---
 arch/x86/kernel/cpu/sgx/main.c | 65 +++++++++++++++++++++++----------
 1 file changed, 47 insertions(+), 18 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index 2857a49..4b41efc 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
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
@@ -780,6 +782,48 @@ static inline u64 __init sgx_calc_section_metric(u64 low, u64 high)
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
@@ -826,6 +870,9 @@ static bool __init sgx_page_cache_init(void)
 			INIT_LIST_HEAD(&sgx_numa_nodes[nid].sgx_poison_page_list);
 			node_set(nid, sgx_numa_mask);
 			sgx_numa_nodes[nid].size = 0;
+
+			/* Make SGX-specific node sysfs files visible: */
+			arch_update_sysfs_visibility(nid);
 		}
 
 		sgx_epc_sections[i].node =  &sgx_numa_nodes[nid];
@@ -903,24 +950,6 @@ int sgx_set_attribute(unsigned long *allowed_attributes,
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
