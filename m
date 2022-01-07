Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1674D487ACC
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 17:55:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348390AbiAGQzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 11:55:55 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:56584 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240137AbiAGQzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 11:55:50 -0500
Date:   Fri, 07 Jan 2022 16:55:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1641574548;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=czIJid5YRRHws7Ee6CSNs6t7w5jtE4beYMoRQ3qtPE8=;
        b=0ZBJrehae9YRoOV7yrOGdtKMdhhImUhuG9T3DDm6PP1l7jlbXTdkLsnNnaiH/MyFkghEvx
        EndvVbOhlD8KxKnO7Tp396lvlQddskmRb2WK/G1ZFKEGSDNFHXLbFHtCk7jtUOO23bBeqq
        qjoi3TnkWdIySb2V/FSe+Kd7cnURFwr4dp4SeE/XIFT10i9xXDUlD5KsKki8iwMZfBrBd9
        p6Hs7D2uH57rAQayVDCj2OT34fhp+XAFL4TRqYzhmC6fcH7yWTBJrdPANihC/nVB6LuUbh
        yAZava7W/ZTnuRbCbb9TIU1RDg5nIR1zrLumYOuAwf6A+1H9d+QJ9Qq6pt1nGg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1641574548;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=czIJid5YRRHws7Ee6CSNs6t7w5jtE4beYMoRQ3qtPE8=;
        b=8l3fSO5jorxH56fRUbSWvJ3GlT0wbdmmcSjbqczlOINicBka7LyfIkAHoKsh8ZrACIPH4r
        Ba18MpRKz3BU5JCQ==
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
Message-ID: <164157454727.16921.2222151221151650802.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/sgx branch of tip:

Commit-ID:     2056e2989bf47ad7274ecc5e9dda2add53c112f9
Gitweb:        https://git.kernel.org/tip/2056e2989bf47ad7274ecc5e9dda2add53c112f9
Author:        Dave Hansen <dave.hansen@linux.intel.com>
AuthorDate:    Tue, 04 Jan 2022 09:15:27 -08:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Fri, 07 Jan 2022 08:47:23 -08:00

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
