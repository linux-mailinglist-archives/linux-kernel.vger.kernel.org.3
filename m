Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F21246EB65
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 16:35:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239822AbhLIPjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 10:39:12 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:39850 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232844AbhLIPjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 10:39:11 -0500
Date:   Thu, 09 Dec 2021 15:35:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639064137;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Zu/1bGzgFrU72uxhtpp9m5ujWsKUY0BkquhPhHCCzQY=;
        b=02dJsQyl/Oy23ftn25TIiQZOoTLkZTwE9WRRL/P1TrUxns1d++fNHCKmaBSEIc1ptYeKLn
        DY4XhL4OHC2ptEsujMicWPk/6ew0YphnW7ydpgPfWQDOXAF9Y4jOzQxoWrMkL+qlggSlCR
        mU/Ckdj8lUAX623KMOqwOXQHuuzUTN/aoWtbplBXUb3AHonXXWnbyTZHQm2zAVYhQpalbm
        CXDs8ixN0PmLPwL3VzBtajyEug07Rnxj6cTNH0RLiQFbt4tXXAfZE3JxKn+4x/3fFFNgoX
        10u9DhVjw/7elccZ2wYovjxD8jTFJRGgdGDkxyhWdTPO8GJ1r4sXo5rjcwxm5g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639064137;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Zu/1bGzgFrU72uxhtpp9m5ujWsKUY0BkquhPhHCCzQY=;
        b=6u06CVyX3Q0SMIhmbfMsgReOhTXnE3dzKINk4puJCDmXEsFtSIPpWb8ah3UN3R4Rc1vUDo
        hvuOgNDyflxvTYBQ==
From:   "tip-bot2 for Jarkko Sakkinen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sgx] x86/sgx: Add an attribute for the amount of SGX memory
 in a NUMA node
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211116162116.93081-2-jarkko@kernel.org>
References: <20211116162116.93081-2-jarkko@kernel.org>
MIME-Version: 1.0
Message-ID: <163906413588.11128.16644856184890792513.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/sgx branch of tip:

Commit-ID:     50468e4313355b161cac8a5155a45832995b7f25
Gitweb:        https://git.kernel.org/tip/50468e4313355b161cac8a5155a45832995b7f25
Author:        Jarkko Sakkinen <jarkko@kernel.org>
AuthorDate:    Tue, 16 Nov 2021 18:21:16 +02:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 09 Dec 2021 07:02:22 -08:00

x86/sgx: Add an attribute for the amount of SGX memory in a NUMA node

== Problem ==

The amount of SGX memory on a system is determined by the BIOS and it
varies wildly between systems.  It can be as small as dozens of MB's
and as large as many GB's on servers.  Just like how applications need
to know how much regular RAM is available, enclave builders need to
know how much SGX memory an enclave can consume.

== Solution ==

Introduce a new sysfs file:

	/sys/devices/system/node/nodeX/x86/sgx_total_bytes

to enumerate the amount of SGX memory available in each NUMA node.
This serves the same function for SGX as /proc/meminfo or
/sys/devices/system/node/nodeX/meminfo does for normal RAM.

'sgx_total_bytes' is needed today to help drive the SGX selftests.
SGX-specific swap code is exercised by creating overcommitted enclaves
which are larger than the physical SGX memory on the system.  They
currently use a CPUID-based approach which can diverge from the actual
amount of SGX memory available.  'sgx_total_bytes' ensures that the
selftests can work efficiently and do not attempt stupid things like
creating a 100,000 MB enclave on a system with 128 MB of SGX memory.

== Implementation Details ==

Introduce CONFIG_HAVE_ARCH_NODE_DEV_GROUP opt-in flag to expose an
arch specific attribute group, and add an attribute for the amount of
SGX memory in bytes to each NUMA node:

== ABI Design Discussion ==

As opposed to the per-node ABI, a single, global ABI was considered.
However, this would prevent enclaves from being able to size
themselves so that they fit on a single NUMA node.  Essentially, a
single value would rule out NUMA optimizations for enclaves.

Create a new "x86/" directory inside each "nodeX/" sysfs directory.
'sgx_total_bytes' is expected to be the first of at least a few
sgx-specific files to be placed in the new directory.  Just scanning
/proc/meminfo, these are the no-brainers that we have for RAM, but we
need for SGX:

	MemTotal:       xxxx kB // sgx_total_bytes (implemented here)
	MemFree:        yyyy kB // sgx_free_bytes
	SwapTotal:      zzzz kB // sgx_swapped_bytes

So, at *least* three.  I think we will eventually end up needing
something more along the lines of a dozen.  A new directory (as
opposed to being in the nodeX/ "root") directory avoids cluttering the
root with several "sgx_*" files.

Place the new file in a new "nodeX/x86/" directory because SGX is
highly x86-specific.  It is very unlikely that any other architecture
(or even non-Intel x86 vendor) will ever implement SGX.  Using "sgx/"
as opposed to "x86/" was also considered.  But, there is a real chance
this can get used for other arch-specific purposes.

[ dhansen: rewrite changelog ]

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Acked-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20211116162116.93081-2-jarkko@kernel.org
---
 Documentation/ABI/stable/sysfs-devices-node |  6 ++++++-
 arch/Kconfig                                |  4 ++++-
 arch/x86/Kconfig                            |  1 +-
 arch/x86/kernel/cpu/sgx/main.c              | 20 ++++++++++++++++++++-
 arch/x86/kernel/cpu/sgx/sgx.h               |  1 +-
 drivers/base/node.c                         |  3 +++-
 include/linux/numa.h                        |  4 ++++-
 7 files changed, 39 insertions(+)

diff --git a/Documentation/ABI/stable/sysfs-devices-node b/Documentation/ABI/stable/sysfs-devices-node
index 484fc04..8db67aa 100644
--- a/Documentation/ABI/stable/sysfs-devices-node
+++ b/Documentation/ABI/stable/sysfs-devices-node
@@ -176,3 +176,9 @@ Contact:	Keith Busch <keith.busch@intel.com>
 Description:
 		The cache write policy: 0 for write-back, 1 for write-through,
 		other or unknown.
+
+What:		/sys/devices/system/node/nodeX/x86/sgx_total_bytes
+Date:		November 2021
+Contact:	Jarkko Sakkinen <jarkko@kernel.org>
+Description:
+		The total amount of SGX physical memory in bytes.
diff --git a/arch/Kconfig b/arch/Kconfig
index 26b8ed1..0a9dadb 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -1302,6 +1302,10 @@ config ARCH_HAS_PARANOID_L1D_FLUSH
 config DYNAMIC_SIGFRAME
 	bool
 
+# Select, if arch has a named attribute group bound to NUMA device nodes.
+config HAVE_ARCH_NODE_DEV_GROUP
+	bool
+
 source "kernel/gcov/Kconfig"
 
 source "scripts/gcc-plugins/Kconfig"
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index b9281fa..f2b699d 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -269,6 +269,7 @@ config X86
 	select HAVE_ARCH_KCSAN			if X86_64
 	select X86_FEATURE_NAMES		if PROC_FS
 	select PROC_PID_ARCH_STATUS		if PROC_FS
+	select HAVE_ARCH_NODE_DEV_GROUP		if X86_SGX
 	imply IMA_SECURE_AND_OR_TRUSTED_BOOT    if EFI
 
 config INSTRUCTION_DECODER
diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index 6036328..2857a49 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -825,9 +825,11 @@ static bool __init sgx_page_cache_init(void)
 			INIT_LIST_HEAD(&sgx_numa_nodes[nid].free_page_list);
 			INIT_LIST_HEAD(&sgx_numa_nodes[nid].sgx_poison_page_list);
 			node_set(nid, sgx_numa_mask);
+			sgx_numa_nodes[nid].size = 0;
 		}
 
 		sgx_epc_sections[i].node =  &sgx_numa_nodes[nid];
+		sgx_numa_nodes[nid].size += size;
 
 		sgx_nr_epc_sections++;
 	}
@@ -901,6 +903,24 @@ int sgx_set_attribute(unsigned long *allowed_attributes,
 }
 EXPORT_SYMBOL_GPL(sgx_set_attribute);
 
+#ifdef CONFIG_NUMA
+static ssize_t sgx_total_bytes_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%lu\n", sgx_numa_nodes[dev->id].size);
+}
+static DEVICE_ATTR_RO(sgx_total_bytes);
+
+static struct attribute *arch_node_dev_attrs[] = {
+	&dev_attr_sgx_total_bytes.attr,
+	NULL,
+};
+
+const struct attribute_group arch_node_dev_group = {
+	.name = "x86",
+	.attrs = arch_node_dev_attrs,
+};
+#endif /* CONFIG_NUMA */
+
 static int __init sgx_init(void)
 {
 	int ret;
diff --git a/arch/x86/kernel/cpu/sgx/sgx.h b/arch/x86/kernel/cpu/sgx/sgx.h
index 9ec3136..0f17def 100644
--- a/arch/x86/kernel/cpu/sgx/sgx.h
+++ b/arch/x86/kernel/cpu/sgx/sgx.h
@@ -44,6 +44,7 @@ struct sgx_epc_page {
 struct sgx_numa_node {
 	struct list_head free_page_list;
 	struct list_head sgx_poison_page_list;
+	unsigned long size;
 	spinlock_t lock;
 };
 
diff --git a/drivers/base/node.c b/drivers/base/node.c
index b5a4ba1..87acc47 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -581,6 +581,9 @@ static const struct attribute_group node_dev_group = {
 
 static const struct attribute_group *node_dev_groups[] = {
 	&node_dev_group,
+#ifdef CONFIG_HAVE_ARCH_NODE_DEV_GROUP
+	&arch_node_dev_group,
+#endif
 	NULL
 };
 
diff --git a/include/linux/numa.h b/include/linux/numa.h
index cb44cfe..59df211 100644
--- a/include/linux/numa.h
+++ b/include/linux/numa.h
@@ -58,4 +58,8 @@ static inline int phys_to_target_node(u64 start)
 }
 #endif
 
+#ifdef CONFIG_HAVE_ARCH_NODE_DEV_GROUP
+extern const struct attribute_group arch_node_dev_group;
+#endif
+
 #endif /* _LINUX_NUMA_H */
