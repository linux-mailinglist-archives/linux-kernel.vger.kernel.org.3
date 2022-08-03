Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6050F588F49
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 17:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238085AbiHCPWM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 11:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237975AbiHCPWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 11:22:08 -0400
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C95A23AE78
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 08:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.es; i=@amazon.es; q=dns/txt; s=amazon201209;
  t=1659540127; x=1691076127;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tAogWiDHErkvRl4pDKXqrqbenwRbcOqDd7W3H3Gt5Uw=;
  b=nXCDe33u/lJtKjgzErr2JiY5BVrzrScFDEsithPHb6x4eD9Q0hDYZYvz
   ypFxdn1/iI3SUQxaapNadJbpUq9oN9lZTb57jmITUX9hKrS1ECeQBk03S
   uum4rdEmExyiXxBBqL5U/xJH8Sv4h/lanMYnT2F5bd9jgV6NI1e9AT6hd
   c=;
X-IronPort-AV: E=Sophos;i="5.93,214,1654560000"; 
   d="scan'208";a="215058337"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2b-2520d768.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2022 15:21:52 +0000
Received: from EX13D37EUA003.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-pdx-2b-2520d768.us-west-2.amazon.com (Postfix) with ESMTPS id F19A7449D3;
        Wed,  3 Aug 2022 15:21:49 +0000 (UTC)
Received: from f4d4887fdcfb.ant.amazon.com (10.43.162.134) by
 EX13D37EUA003.ant.amazon.com (10.43.165.7) with Microsoft SMTP Server (TLS)
 id 15.0.1497.36; Wed, 3 Aug 2022 15:21:45 +0000
From:   <bchalios@amazon.es>
To:     <linux-kernel@vger.kernel.org>
CC:     <bchalios@amazon.es>, <tytso@mit.edu>, <Jason@zx2c4.com>,
        <dwmw@amazon.co.uk>, <graf@amazon.de>, <xmarcalx@amazon.co.uk>,
        <gregkh@linuxfoundation.org>
Subject: [PATCH 2/2] virt: vmgenid: add support for generation counter
Date:   Wed, 3 Aug 2022 17:21:27 +0200
Message-ID: <20220803152127.48281-3-bchalios@amazon.es>
X-Mailer: git-send-email 2.32.1 (Apple Git-133)
In-Reply-To: <20220803152127.48281-1-bchalios@amazon.es>
References: <20220803152127.48281-1-bchalios@amazon.es>
MIME-Version: 1.0
X-Originating-IP: [10.43.162.134]
X-ClientProxiedBy: EX13D07UWB003.ant.amazon.com (10.43.161.66) To
 EX13D37EUA003.ant.amazon.com (10.43.165.7)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Babis Chalios <bchalios@amazon.es>

VM Generation ID provides a means of reseeding kernel's RNG using a
128-bit UUID when a VM fork occurs, thus avoiding issues running
multiple VMs with the exact same RNG state. However, user-space
applications, such as user-space PRNGs and applications that maintain
world-unique data, need a mechanism to handle VM fork events as well.

To handle the user-space use-case, this: <url> qemu patch extends
Microsoft's original vmgenid specification adding an extra page which
holds a single 32-bit generation counter, which increases every time a
VM gets restored from a snapshot.

This patch exposes the generation counter through a character device
(`/dev/vmgenid`) that provides a `read` and `mmap` interface, for
user-space applications to consume. Userspace applications should read
this value before starting a transaction involving cached random bits
and ensure that it has not changed while committing the transaction.

It can be used from qemu using the `-device vmgenid,guid=auto,genctr=42`
parameter to start a VM with a generation counter with value 42.
Reading 4 bytes from `/dev/vmgenid` will return the value 42. Next, use
`savevm my_snapshot` in the monitor to snapshot the VM. Now, start
another VM using `-device vmgenid,guid=auto,genctr=43 -loadvm
my_snapshot`. Reading now from `/dev/vmgenid` will return 43.

Signed-off-by: Babis Chalios <bchalios@amazon.es>
---
 Documentation/virt/vmgenid.rst | 120 +++++++++++++++++++++++++++++++++
 drivers/virt/vmgenid.c         | 103 +++++++++++++++++++++++++++-
 2 files changed, 221 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/virt/vmgenid.rst

diff --git a/Documentation/virt/vmgenid.rst b/Documentation/virt/vmgenid.rst
new file mode 100644
index 000000000..61c29e4a7
--- /dev/null
+++ b/Documentation/virt/vmgenid.rst
@@ -0,0 +1,120 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=======
+VMGENID
+=======
+
+The VM Generation ID (VMGENID) is a feature from Microsoft
+(https://go.microsoft.com/fwlink/?LinkId=260709) supported by multiple
+hypervisor vendors.
+
+Its purpose is to help tackle issues occurying by duplication of the state
+of a Virtual Machine (VM) during events that cause a VM to "return back in
+time", like snapshot and restore. It exposes a generation ID inside the VM so
+that applications that rely on world-wide unique or random data can check if
+that value has changed before committing transactions.
+
+Problem Definition
+------------------
+
+Often in its lifetime, a VM will get snapshotted and later it will be restored
+in that previous state. Moreover, one or more new VMs can be spawned from this
+snapshot. Both scenarios result in one or more VMs running with same RNG state,
+which makes early operations after restore that rely on randomness predictable,
+and thus render them insecure, for example TLS.
+
+Userspace PRNGs, as well as code that caches streams of random bits, to speed
+up latency critical applications, suffer from similar issues.
+
+Apart from concerns related with cryptography, userspace applications operating
+with (what they consider to be) unique data, such as UUIDs, are affected by
+spawning of multiple VMs from the same snapshot.
+
+VMGENID tackles the issue by providing a unique (not random) 128-bits
+identifier every time a VM is restored from a snapshot. The identifier is used
+to reseed the kernel's RNG ensuring that different VMs spawned from the same
+snapshot will observe different streams of random data.
+
+Notice that VMGENID does not eliminate the problem but it significantly reduces
+the window in which the system's RNG will produce identical data across
+different VMs.
+
+Reseeding the kernel's RNG tackles the issue of duplicated random values
+provided by the kernel, however it does little to address the issue of
+userspace applications that use world-unique data. The UUID defined by the
+original VMGENID specification is used to reseed the RNG, so it cannot be
+exposed to the userspace. This class of applications need a separate API which
+they can consume in order to detect VM restore events and adapt accordingly.
+
+In that front, VMGENID has been extended to expose to userspace an additional
+32 bits generation counter, which acts as a notification mechanism for restore
+events. The value of the counter after a VM restore will be different than
+its value when the snapshot was taken in order to signal to userspace that
+a VM restore has occurred.
+
+VMGENID in Linux
+----------------
+
+Linux kernel uses the 128-bits UUID of VMGENID to reseed the RNG every time an
+ACPI notification arrives. Moreover, it exposes the 32-bits generation counter
+through a character device ``/dev/vmgenid``. The device supports ``read()``
+and ``mmap`` for user space applications to monitor restore events:
+
+``read()``:
+Read always returns the first 4 bytes of the page including the generation
+counter. Partial reads and reads in offset other than 0 are not allowed and
+return ``EINVAL``.
+
+``mmap()``:
+It maps a single page in the address space of the userspace application. The
+driver supports ``PROT_READ`` and ``MAP_SHARED``. Mapping with ``PROT_WRITE``
+will result in ``EPERM``, whereas mapping past the first page will result in
+``EINVAL``.
+
+A userspace application that caches random bits from the kernel should ensure
+that the moment it actually wants to consume some of these bits the value of
+the generation counter equals its value when the bits were initially cached.
+For example:
+
+```
+uint32_t *gen_cntr = mmaped_gen_counter();
+uint32_t cached_gen_cntr = *gen_cntr;
+char *secret;
+
+for(;;) {
+    secret = get_secret();
+
+    // All good, not restore has happened.
+    if (cached_gen_cntr == *gen_cntr)
+        break;
+
+    // Generation counter has changed. We need to recreate caches and try again
+
+    cached_gen_cntr = *gen_cntr;
+    barrier();
+
+    // recreate secrets' cache
+    rebuild_cache();
+}
+
+consume_secret(secret);
+
+```
+
+The driver for VMGENID lives under ``drivers/virt/vmgenid.c``.
+
+Using VMGENID
+-------------
+
+https://git.qemu.org/?p=qemu.git;a=blob_plain;f=docs/specs/vmgenid.txt;hb=refs/heads/master
+describes how the VMGENID device can be used. First we start a VM passing the
+parameter `-device vmgenid,guid=auto,genctr=42`. With this the UUID value of
+VMGENID will be populated with a UUID created by qemu and a generation counter
+of 42. Next, we can save the VM state from the monitor using the `savevm`
+command.
+
+Now, we can start another VM from the same snapshot using the `-device
+vmgenid,guid=auto,genctr=43 -loadvm {snapshot}` options. This will update the
+UUID with a new value generated by qemu and 43 for the generation counter in
+memory before resuming the vcpus and then send an appropriate ACPI notification
+to the guest.
diff --git a/drivers/virt/vmgenid.c b/drivers/virt/vmgenid.c
index 0cc2fe0f4..1cb0b3560 100644
--- a/drivers/virt/vmgenid.c
+++ b/drivers/virt/vmgenid.c
@@ -11,6 +11,10 @@
 #include <linux/module.h>
 #include <linux/acpi.h>
 #include <linux/random.h>
+#include "linux/container_of.h"
+#include <linux/miscdevice.h>
+#include <linux/fs.h>
+#include <linux/mm.h>
 
 ACPI_MODULE_NAME("vmgenid");
 
@@ -19,6 +23,69 @@ enum { VMGENID_SIZE = 16 };
 struct vmgenid_state {
 	u8 *next_id;
 	u8 this_id[VMGENID_SIZE];
+
+	phys_addr_t gen_cntr_addr;
+	u32 *next_counter;
+
+	int misc_enabled;
+	struct miscdevice misc;
+};
+
+static int vmgenid_mmap(struct file *filep, struct vm_area_struct *vma)
+{
+	struct vmgenid_state *state = filep->private_data;
+
+	if (vma->vm_pgoff || vma_pages(vma) > 1)
+		return -EINVAL;
+
+	if ((vma->vm_flags & VM_WRITE))
+		return -EPERM;
+
+	vma->vm_flags |= VM_DONTEXPAND | VM_DONTDUMP;
+	vma->vm_flags &= ~VM_MAYWRITE;
+
+	return vm_iomap_memory(vma, state->gen_cntr_addr, PAGE_SIZE);
+}
+
+static ssize_t vmgenid_read(struct file *filep, char __user *buff, size_t count,
+		loff_t *offp)
+{
+	struct vmgenid_state *state = filep->private_data;
+
+	if (count == 0)
+		return 0;
+
+	/* We don't allow partial reads */
+	if (count != sizeof(u32))
+		return -EINVAL;
+
+	if (put_user(*state->next_counter, (u32 __user *)buff))
+		return -EFAULT;
+
+	return sizeof(u32);
+}
+
+static int vmgenid_open(struct inode *inode, struct file *filep)
+{
+	struct vmgenid_state *state =
+		container_of(filep->private_data, struct vmgenid_state, misc);
+
+	filep->private_data = state;
+	return 0;
+}
+
+static const struct file_operations fops = {
+	.owner = THIS_MODULE,
+	.open = vmgenid_open,
+	.read = vmgenid_read,
+	.mmap = vmgenid_mmap,
+	.llseek = noop_llseek,
+};
+
+static struct miscdevice vmgenid_misc = {
+	.minor = MISC_DYNAMIC_MINOR,
+	.name = "vmgenid",
+	.fops = &fops,
 };
 
 static int parse_vmgenid_address(struct acpi_device *device, acpi_string object_name,
@@ -57,7 +124,7 @@ static int vmgenid_add(struct acpi_device *device)
 	phys_addr_t phys_addr;
 	int ret;
 
-	state = devm_kmalloc(&device->dev, sizeof(*state), GFP_KERNEL);
+	state = devm_kzalloc(&device->dev, sizeof(*state), GFP_KERNEL);
 	if (!state)
 		return -ENOMEM;
 
@@ -74,6 +141,27 @@ static int vmgenid_add(struct acpi_device *device)
 
 	device->driver_data = state;
 
+	/* Backwards compatibility. If CTRA is not there we just don't expose
+	 * the char device
+	 */
+	ret = parse_vmgenid_address(device, "CTRA", &state->gen_cntr_addr);
+	if (ret)
+		return 0;
+
+	state->next_counter = devm_memremap(&device->dev, state->gen_cntr_addr,
+			sizeof(u32), MEMREMAP_WB);
+	if (IS_ERR(state->next_counter))
+		return 0;
+
+	memcpy(&state->misc, &vmgenid_misc, sizeof(state->misc));
+	ret = misc_register(&state->misc);
+	if (ret) {
+		devm_memunmap(&device->dev, state->next_counter);
+		return 0;
+	}
+
+	state->misc_enabled = 1;
+
 	return 0;
 }
 
@@ -89,6 +177,16 @@ static void vmgenid_notify(struct acpi_device *device, u32 event)
 	add_vmfork_randomness(state->this_id, sizeof(state->this_id));
 }
 
+static int vmgenid_remove(struct acpi_device *device)
+{
+	struct vmgenid_state *state = device->driver_data;
+
+	if (state->misc_enabled)
+		misc_deregister(&state->misc);
+
+	return 0;
+}
+
 static const struct acpi_device_id vmgenid_ids[] = {
 	{ "VMGENCTR", 0 },
 	{ "VM_GEN_COUNTER", 0 },
@@ -101,7 +199,8 @@ static struct acpi_driver vmgenid_driver = {
 	.owner = THIS_MODULE,
 	.ops = {
 		.add = vmgenid_add,
-		.notify = vmgenid_notify
+		.notify = vmgenid_notify,
+		.remove = vmgenid_remove
 	}
 };
 
-- 
2.32.1 (Apple Git-133)

Amazon Spain Services sociedad limitada unipersonal, Calle Ramirez de Prado 5, 28045 Madrid. Registro Mercantil de Madrid . Tomo 22458 . Folio 102 . Hoja M-401234 . CIF B84570936

