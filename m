Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E9ED546E44
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 22:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350669AbiFJUXW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 16:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350629AbiFJUXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 16:23:09 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14BB0A1AF;
        Fri, 10 Jun 2022 13:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654892587; x=1686428587;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kguekHKNOtx1NTqs2aNW64FIZbGBj8NyP+GczZMtqFo=;
  b=LgdpFK9IeWC5rx9Tro0J9Tn3cYEAgmNzMJYGXF8IGITH7D09ca3IADqX
   zkR/5t2Q1BJ578mZ74s6ydqnPRxs88ye8+rBQ9vOC0iD4cjGgB3YyfxRz
   1KP1unxj935dBVCY+f9popplyBdEvGmyTjpEPzwkMZ/ecnwyPx15WiKV7
   SJFlo4T+Gx0VQVw5xm7LCf1HOBwnKIddOE4Iyu2lUXiLXuo3oVRO5KxSP
   gq6KDlMJqjMvDlv6bAkYO4TUapBJCF+pjR9ptwbiB08MX62nIhhJ+GrcW
   eNkbA+U64z56bTgMIs1c8w0WpgxkOE0Lif3xRYUmHCcICZcCw0nuUaOw+
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10374"; a="260855407"
X-IronPort-AV: E=Sophos;i="5.91,291,1647327600"; 
   d="scan'208";a="260855407"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2022 13:23:06 -0700
X-IronPort-AV: E=Sophos;i="5.91,291,1647327600"; 
   d="scan'208";a="909097459"
Received: from pleung-mobl1.amr.corp.intel.com (HELO localhost) ([10.212.33.34])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2022 13:23:06 -0700
From:   ira.weiny@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH V11 3/8] PCI: Create PCI library functions in support of DOE mailboxes.
Date:   Fri, 10 Jun 2022 13:22:54 -0700
Message-Id: <20220610202259.3544623-4-ira.weiny@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220610202259.3544623-1-ira.weiny@intel.com>
References: <20220610202259.3544623-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Introduced in a PCI r6.0, sec 6.30, DOE provides a config space based
mailbox with standard protocol discovery.  Each mailbox is accessed
through a DOE Extended Capability.

Each DOE mailbox must support the DOE discovery protocol in addition to
any number of additional protocols.

Define core PCI functionality to manage a single PCI DOE mailbox at a
defined config space offset.  Functionality includes iterating,
creating, query of supported protocol, task submission, and destruction
of the mailboxes.

If interrupts are desired, the interrupt number can be queried and
passed to the create function.  Passing a negative value disables
interrupts for that mailbox.  It is the callers responsibility to ensure
enough interrupt vectors are allocated.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Co-developed-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes from V9
	Lukas Wunner
		Update comments
		Move private doe structures and defines from pci-doe.h to doe.c
		check Data Obj Ready prior to last ack
	Davidlohr
		make task_lock a spinlock
	Lukas/Jonathan
		Remove special case of error in irq handler
	Fix potential race with the scheduling of a task when one is ending.
		The current task can't be retired until the state
		machine is idle.  Otherwise a new task work item may run
		and the state machine would be out of sync.

Changes from V8
	Remove Bjorn's ack
	Expose a function to find the irq number for a mailbox based on
	offset.  This is the code Jonathan proposed for finding the irq
	number here:
	https://lore.kernel.org/linux-cxl/20220503153449.4088-2-Jonathan.Cameron@huawei.com/
		This removes funky bool parameter to create.
	Move pci_set_master() within the pci_doe_enable_irq()
	Per Bjorn
		Clean up commit messages
		move pci-doe.c to doe.c
		Clean up PCI spec references
		Ensure all messages use pci_*()
		Add offset to error messages to distinguish mailboxes
			use hex for DOE offsets
		Print 4 nibbles for Vendor ID and 2 for type.
		s/irq/IRQ in comments
		Fix long lines
		Fix typos

Changes from V7
	Add a Kconfig for this functionality
	Fix bug in pci_doe_supports_prot()
	Rebased on cxl-pending

Changes from V6
	Clean up signed off by lines
	Make this functionality all PCI library functions
	Clean up header files
	s/pci_doe_irq/pci_doe_irq_handler
	Use pci_{request,free}_irq
		Remove irq_name (maintained by pci_request_irq)
	Fix checks to use an irq
	Consistently use u16 for cap_offset
	Cleanup kdocs and comments
	Create a helper retire_cur_task() to handle locking of the
		current task pointer.
	Remove devm_ calls from PCI layer.
		The devm_ calls do not allow for the pci_doe_mb objects
		to be tied to an auxiliary device.  Leave it to the
		caller to use devm_ if desired.
	From Dan Williams
		s/cb/end_task/; Pass pci_doe_task to end_task
		Clarify exchange/task/request/response.
			Merge pci_doe_task and pci_doe_exchange into
			pci_doe_task which represents a single
			request/response task for the state machine to
			process.
		Simplify submitting work to the mailbox
			Replace pci_doe_exchange_sync() with
			pci_doe_submit_task() Consumers of the mailbox
			are now responsible for setting up callbacks
			within a task object and submitting them to the
			mailbox to be processed.
		Remove WARN_ON when task != NULL and be sure to abort that task.
		Convert abort/dead to atomic flags
		s/state_lock/task_lock to better define what the lock is
			protecting
		Remove all the auxiliary bus code from the PCI layer
			The PCI layer provides helpers to use the DOE
			Mailboxes.  Each subsystem can then use the
			helpers as they see fit.  The CXL layer in this
			series uses aux devices to manage the new
			pci_doe_mb objects.

	From Bjorn
		Clarify the fact that DOE mailboxes are capabilities of
			the device.
		Code clean ups
		Cleanup Makefile
		Update references to PCI SIG spec v6.0
		Move this attribution here:
		This code is based on Jonathan's V4 series here:
		https://lore.kernel.org/linux-cxl/20210524133938.2815206-1-Jonathan.Cameron@huawei.com/

Changes from V5
	From Bjorn
		s/pci_WARN/pci_warn
			Add timeout period to print
		Trim to 80 chars
		Use Tabs for DOE define spacing
		Use %#x for clarity
	From Jonathan
		Addresses concerns about the order of unwinding stuff
		s/doe/doe_dev in pci_doe_exhcnage_sync
		Correct kernel Doc comment
		Move pci_doe_task_complete() down in the file.
		Rework pci_doe_irq()
			process STATUS_ERROR first
			Return IRQ_NONE if the irq is not processed
			Use PCI_DOE_STATUS_INT_STATUS explicitly to
				clear the irq
	Clean up goto label s/err_free_irqs/err_free_irq
	use devm_kzalloc for doe struct
	clean up error paths in pci_doe_probe
	s/pci_doe_drv/pci_doe
	remove include mutex.h
	remove device name and define, move it in the next patch which uses it
	use devm_kasprintf() for irq_name
	use devm_request_irq()
	remove pci_doe_unregister()
		[get/put]_device() were unneeded and with the use of
		devm_* this function can be removed completely.
	refactor pci_doe_register and s/pci_doe_register/pci_doe_reg_irq
		make this function just a registration of the irq and
		move pci_doe_abort() into pci_doe_probe()
	use devm_* to allocate the protocol array

Changes from Jonathan's V4
	Move the DOE MB code into the DOE auxiliary driver
	Remove Task List in favor of a wait queue

Changes from Ben
	remove CXL references
	propagate rc from pci functions on error
---
 drivers/pci/Kconfig           |   3 +
 drivers/pci/Makefile          |   1 +
 drivers/pci/doe.c             | 693 ++++++++++++++++++++++++++++++++++
 include/linux/pci-doe.h       |  65 ++++
 include/uapi/linux/pci_regs.h |  29 +-
 5 files changed, 790 insertions(+), 1 deletion(-)
 create mode 100644 drivers/pci/doe.c
 create mode 100644 include/linux/pci-doe.h

diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 133c73207782..b2f2e588a817 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -121,6 +121,9 @@ config XEN_PCIDEV_FRONTEND
 config PCI_ATS
 	bool
 
+config PCI_DOE
+	bool
+
 config PCI_ECAM
 	bool
 
diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
index 0da6b1ebc694..2680e4c92f0a 100644
--- a/drivers/pci/Makefile
+++ b/drivers/pci/Makefile
@@ -31,6 +31,7 @@ obj-$(CONFIG_PCI_ECAM)		+= ecam.o
 obj-$(CONFIG_PCI_P2PDMA)	+= p2pdma.o
 obj-$(CONFIG_XEN_PCIDEV_FRONTEND) += xen-pcifront.o
 obj-$(CONFIG_VGA_ARB)		+= vgaarb.o
+obj-$(CONFIG_PCI_DOE)		+= doe.o
 
 # Endpoint library must be initialized before its users
 obj-$(CONFIG_PCI_ENDPOINT)	+= endpoint/
diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
new file mode 100644
index 000000000000..4619c3e547f2
--- /dev/null
+++ b/drivers/pci/doe.c
@@ -0,0 +1,693 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Data Object Exchange
+ *	PCIe r6.0, sec 6.30 DOE
+ *
+ * Copyright (C) 2021 Huawei
+ *	Jonathan Cameron <Jonathan.Cameron@huawei.com>
+ *
+ * Copyright (C) 2022 Intel Corporation
+ *	Ira Weiny <ira.weiny@intel.com>
+ */
+
+#include <linux/bitfield.h>
+#include <linux/delay.h>
+#include <linux/jiffies.h>
+#include <linux/mutex.h>
+#include <linux/pci.h>
+#include <linux/pci-doe.h>
+#include <linux/workqueue.h>
+
+#define PCI_DOE_PROTOCOL_DISCOVERY 0
+
+#define PCI_DOE_BUSY_MAX_RETRIES 16
+#define PCI_DOE_POLL_INTERVAL (HZ / 128)
+
+/* Timeout of 1 second from 6.30.2 Operation, PCI Spec r6.0 */
+#define PCI_DOE_TIMEOUT HZ
+
+enum pci_doe_state {
+	DOE_IDLE,
+	DOE_WAIT_RESP,
+	DOE_WAIT_ABORT,
+	DOE_WAIT_ABORT_ON_ERR,
+};
+
+#define PCI_DOE_FLAG_ABORT	0
+#define PCI_DOE_FLAG_DEAD	1
+
+/**
+ * struct pci_doe_mb - State for a single DOE mailbox
+ *
+ * This state is used to manage a single DOE mailbox capability.  All fields
+ * should be considered opaque to the consumers and the structure passed into
+ * the helpers below after being created by devm_pci_doe_create()
+ *
+ * @pdev: PCI device this mailbox belongs to
+ * @abort_c: Completion used for initial abort handling
+ * @irq: Interrupt used for signaling DOE ready or abort
+ * @prots: Array of protocols supported on this DOE
+ * @num_prots: Size of @prots array
+ * @cap_offset: Capability offset
+ * @wq: Wait queue to wait on if a query is in progress
+ * @cur_task: Current task the state machine is working on
+ * @task_lock: Protect cur_task
+ * @statemachine: Work item for the DOE state machine
+ * @state: Current state of this DOE
+ * @timeout_jiffies: 1 second after GO set
+ * @busy_retries: Count of retry attempts
+ * @flags: Bit array of PCI_DOE_FLAG_* flags
+ *
+ * Note: @prots can't be allocated with struct size because the number of
+ * protocols is not known until after this structure is in use.  However, the
+ * single discovery protocol is always required to query for the number of
+ * protocols.
+ */
+struct pci_doe_mb {
+	struct pci_dev *pdev;
+	struct completion abort_c;
+	int irq;
+	struct pci_doe_protocol *prots;
+	int num_prots;
+	u16 cap_offset;
+
+	wait_queue_head_t wq;
+	struct pci_doe_task *cur_task;
+	spinlock_t task_lock;
+	struct delayed_work statemachine;
+	enum pci_doe_state state;
+	unsigned long timeout_jiffies;
+	unsigned int busy_retries;
+	unsigned long flags;
+};
+
+static irqreturn_t pci_doe_irq_handler(int irq, void *data)
+{
+	struct pci_doe_mb *doe_mb = data;
+	struct pci_dev *pdev = doe_mb->pdev;
+	int offset = doe_mb->cap_offset;
+	u32 val;
+
+	pci_read_config_dword(pdev, offset + PCI_DOE_STATUS, &val);
+	if (FIELD_GET(PCI_DOE_STATUS_INT_STATUS, val)) {
+		pci_write_config_dword(pdev, offset + PCI_DOE_STATUS,
+					PCI_DOE_STATUS_INT_STATUS);
+		mod_delayed_work(system_wq, &doe_mb->statemachine, 0);
+		return IRQ_HANDLED;
+	}
+
+	return IRQ_NONE;
+}
+
+/*
+ * Only called when safe to directly access the DOE from
+ * doe_statemachine_work().  Outside access is not protected.  Users who
+ * perform such access are left with the pieces.
+ */
+static void pci_doe_abort_start(struct pci_doe_mb *doe_mb)
+{
+	struct pci_dev *pdev = doe_mb->pdev;
+	int offset = doe_mb->cap_offset;
+	u32 val;
+
+	val = PCI_DOE_CTRL_ABORT;
+	if (doe_mb->irq >= 0)
+		val |= PCI_DOE_CTRL_INT_EN;
+	pci_write_config_dword(pdev, offset + PCI_DOE_CTRL, val);
+
+	doe_mb->timeout_jiffies = jiffies + HZ;
+	schedule_delayed_work(&doe_mb->statemachine, HZ);
+}
+
+static int pci_doe_send_req(struct pci_doe_mb *doe_mb,
+			    struct pci_doe_task *task)
+{
+	struct pci_dev *pdev = doe_mb->pdev;
+	int offset = doe_mb->cap_offset;
+	u32 val;
+	int i;
+
+	/*
+	 * Check the DOE busy bit is not set. If it is set, this could indicate
+	 * someone other than Linux (e.g. firmware) is using the mailbox. Note
+	 * it is expected that firmware and OS will negotiate access rights via
+	 * an, as yet to be defined method.
+	 */
+	pci_read_config_dword(pdev, offset + PCI_DOE_STATUS, &val);
+	if (FIELD_GET(PCI_DOE_STATUS_BUSY, val))
+		return -EBUSY;
+
+	if (FIELD_GET(PCI_DOE_STATUS_ERROR, val))
+		return -EIO;
+
+	/* Write DOE Header */
+	val = FIELD_PREP(PCI_DOE_DATA_OBJECT_HEADER_1_VID, task->prot.vid) |
+		FIELD_PREP(PCI_DOE_DATA_OBJECT_HEADER_1_TYPE, task->prot.type);
+	pci_write_config_dword(pdev, offset + PCI_DOE_WRITE, val);
+	/* Length is 2 DW of header + length of payload in DW */
+	pci_write_config_dword(pdev, offset + PCI_DOE_WRITE,
+			       FIELD_PREP(PCI_DOE_DATA_OBJECT_HEADER_2_LENGTH,
+					  2 + task->request_pl_sz /
+						sizeof(u32)));
+	for (i = 0; i < task->request_pl_sz / sizeof(u32); i++)
+		pci_write_config_dword(pdev, offset + PCI_DOE_WRITE,
+				       task->request_pl[i]);
+
+	val = PCI_DOE_CTRL_GO;
+	if (doe_mb->irq >= 0)
+		val |= PCI_DOE_CTRL_INT_EN;
+
+	pci_write_config_dword(pdev, offset + PCI_DOE_CTRL, val);
+	/* Request is sent - now wait for poll or IRQ */
+	return 0;
+}
+
+static bool pci_doe_data_obj_ready(struct pci_doe_mb *doe_mb)
+{
+	struct pci_dev *pdev = doe_mb->pdev;
+	int offset = doe_mb->cap_offset;
+	u32 val;
+
+	pci_read_config_dword(pdev, offset + PCI_DOE_STATUS, &val);
+	if (FIELD_GET(PCI_DOE_STATUS_DATA_OBJECT_READY, val))
+		return true;
+	return false;
+}
+
+static int pci_doe_recv_resp(struct pci_doe_mb *doe_mb, struct pci_doe_task *task)
+{
+	struct pci_dev *pdev = doe_mb->pdev;
+	int offset = doe_mb->cap_offset;
+	size_t length, payload_length;
+	u32 val;
+	int i;
+
+	/* Read the first dword to get the protocol */
+	pci_read_config_dword(pdev, offset + PCI_DOE_READ, &val);
+	if ((FIELD_GET(PCI_DOE_DATA_OBJECT_HEADER_1_VID, val) != task->prot.vid) ||
+	    (FIELD_GET(PCI_DOE_DATA_OBJECT_HEADER_1_TYPE, val) != task->prot.type)) {
+		pci_err(pdev,
+			"DOE [%x] expected [VID, Protocol] = [%04x, %02x], got [%04x, %02x]\n",
+			doe_mb->cap_offset,
+			task->prot.vid, task->prot.type,
+			FIELD_GET(PCI_DOE_DATA_OBJECT_HEADER_1_VID, val),
+			FIELD_GET(PCI_DOE_DATA_OBJECT_HEADER_1_TYPE, val));
+		return -EIO;
+	}
+
+	pci_write_config_dword(pdev, offset + PCI_DOE_READ, 0);
+	/* Read the second dword to get the length */
+	pci_read_config_dword(pdev, offset + PCI_DOE_READ, &val);
+	pci_write_config_dword(pdev, offset + PCI_DOE_READ, 0);
+
+	length = FIELD_GET(PCI_DOE_DATA_OBJECT_HEADER_2_LENGTH, val);
+	if (length > SZ_1M || length < 2)
+		return -EIO;
+
+	/* First 2 dwords have already been read */
+	length -= 2;
+	payload_length = min(length, task->response_pl_sz / sizeof(u32));
+	/* Read the rest of the response payload */
+	for (i = 0; i < payload_length; i++) {
+		pci_read_config_dword(pdev, offset + PCI_DOE_READ,
+				      &task->response_pl[i]);
+		/* Prior to the last ack, ensure Data Object Ready */
+		if (i == (payload_length-1) && !pci_doe_data_obj_ready(doe_mb))
+			return -EIO;
+		pci_write_config_dword(pdev, offset + PCI_DOE_READ, 0);
+	}
+
+	/* Flush excess length */
+	for (; i < length; i++) {
+		pci_read_config_dword(pdev, offset + PCI_DOE_READ, &val);
+		pci_write_config_dword(pdev, offset + PCI_DOE_READ, 0);
+	}
+
+	/* Final error check to pick up on any since Data Object Ready */
+	pci_read_config_dword(pdev, offset + PCI_DOE_STATUS, &val);
+	if (FIELD_GET(PCI_DOE_STATUS_ERROR, val))
+		return -EIO;
+
+	return min(length, task->response_pl_sz / sizeof(u32)) * sizeof(u32);
+}
+
+static void signal_task_complete(struct pci_doe_task *task, int rv)
+{
+	task->rv = rv;
+	task->complete(task);
+}
+
+static void retire_cur_task(struct pci_doe_mb *doe_mb)
+{
+	spin_lock(&doe_mb->task_lock);
+	doe_mb->cur_task = NULL;
+	spin_unlock(&doe_mb->task_lock);
+	wake_up_interruptible(&doe_mb->wq);
+}
+
+static void doe_statemachine_work(struct work_struct *work)
+{
+	struct delayed_work *w = to_delayed_work(work);
+	struct pci_doe_mb *doe_mb = container_of(w, struct pci_doe_mb,
+						 statemachine);
+	struct pci_dev *pdev = doe_mb->pdev;
+	int offset = doe_mb->cap_offset;
+	enum pci_doe_state prev_state;
+	struct pci_doe_task *task;
+	u32 val;
+	int rc;
+
+	spin_lock(&doe_mb->task_lock);
+	task = doe_mb->cur_task;
+	spin_unlock(&doe_mb->task_lock);
+
+	if (test_and_clear_bit(PCI_DOE_FLAG_ABORT, &doe_mb->flags)) {
+		/*
+		 * Currently only used during init - care needed if
+		 * pci_doe_abort() is generally exposed as it would impact
+		 * queries in flight.
+		 */
+		if (task)
+			pci_err(pdev, "DOE [%x] Aborting with active task!\n",
+				doe_mb->cap_offset);
+		doe_mb->state = DOE_WAIT_ABORT;
+		pci_doe_abort_start(doe_mb);
+		return;
+	}
+
+	switch (doe_mb->state) {
+	case DOE_IDLE:
+		if (task == NULL)
+			return;
+
+		rc = pci_doe_send_req(doe_mb, task);
+
+		/*
+		 * The specification does not provide any guidance on how long
+		 * some other entity could keep the DOE busy, so try for 1
+		 * second then fail. Busy handling is best effort only, because
+		 * there is no way of avoiding racing against another user of
+		 * the DOE.
+		 */
+		if (rc == -EBUSY) {
+			doe_mb->busy_retries++;
+			if (doe_mb->busy_retries == PCI_DOE_BUSY_MAX_RETRIES) {
+				/* Long enough, fail this request */
+				pci_warn(pdev,
+					"DOE [%x] busy for too long (> 1 sec)\n",
+					doe_mb->cap_offset);
+				doe_mb->busy_retries = 0;
+				goto err_busy;
+			}
+			schedule_delayed_work(w, HZ / PCI_DOE_BUSY_MAX_RETRIES);
+			return;
+		}
+		if (rc)
+			goto err_abort;
+		doe_mb->busy_retries = 0;
+
+		doe_mb->state = DOE_WAIT_RESP;
+		doe_mb->timeout_jiffies = jiffies + HZ;
+		/* Now poll or wait for IRQ with timeout */
+		if (doe_mb->irq >= 0)
+			schedule_delayed_work(w, PCI_DOE_TIMEOUT);
+		else
+			schedule_delayed_work(w, PCI_DOE_POLL_INTERVAL);
+		return;
+
+	case DOE_WAIT_RESP:
+		/* Not possible to get here with NULL task */
+		pci_read_config_dword(pdev, offset + PCI_DOE_STATUS, &val);
+		if (FIELD_GET(PCI_DOE_STATUS_ERROR, val)) {
+			rc = -EIO;
+			goto err_abort;
+		}
+
+		if (!FIELD_GET(PCI_DOE_STATUS_DATA_OBJECT_READY, val)) {
+			/* If not yet at timeout reschedule otherwise abort */
+			if (time_after(jiffies, doe_mb->timeout_jiffies)) {
+				rc = -ETIMEDOUT;
+				goto err_abort;
+			}
+			schedule_delayed_work(w, PCI_DOE_POLL_INTERVAL);
+			return;
+		}
+
+		rc  = pci_doe_recv_resp(doe_mb, task);
+		if (rc < 0)
+			goto err_abort;
+
+		doe_mb->state = DOE_IDLE;
+
+		retire_cur_task(doe_mb);
+		/* Set the return value to the length of received payload */
+		signal_task_complete(task, rc);
+
+		return;
+
+	case DOE_WAIT_ABORT:
+	case DOE_WAIT_ABORT_ON_ERR:
+		prev_state = doe_mb->state;
+
+		pci_read_config_dword(pdev, offset + PCI_DOE_STATUS, &val);
+
+		if (!FIELD_GET(PCI_DOE_STATUS_ERROR, val) &&
+		    !FIELD_GET(PCI_DOE_STATUS_BUSY, val)) {
+			doe_mb->state = DOE_IDLE;
+			/* Back to normal state - carry on */
+			retire_cur_task(doe_mb);
+		} else if (time_after(jiffies, doe_mb->timeout_jiffies)) {
+			/* Task has timed out and is dead - abort */
+			pci_err(pdev, "DOE [%x] ABORT timed out\n",
+				doe_mb->cap_offset);
+			set_bit(PCI_DOE_FLAG_DEAD, &doe_mb->flags);
+			retire_cur_task(doe_mb);
+		}
+
+		/*
+		 * For deliberately triggered abort, someone is
+		 * waiting.
+		 */
+		if (prev_state == DOE_WAIT_ABORT) {
+			if (task)
+				signal_task_complete(task, -EFAULT);
+			complete(&doe_mb->abort_c);
+		}
+
+		return;
+	}
+
+err_abort:
+	doe_mb->state = DOE_WAIT_ABORT_ON_ERR;
+	pci_doe_abort_start(doe_mb);
+err_busy:
+	signal_task_complete(task, rc);
+	if (doe_mb->state == DOE_IDLE)
+		retire_cur_task(doe_mb);
+}
+
+static void pci_doe_task_complete(struct pci_doe_task *task)
+{
+	complete(task->private);
+}
+
+static int pci_doe_discovery(struct pci_doe_mb *doe_mb, u8 *index, u16 *vid,
+			     u8 *protocol)
+{
+	u32 request_pl = FIELD_PREP(PCI_DOE_DATA_OBJECT_DISC_REQ_3_INDEX,
+				    *index);
+	u32 response_pl;
+	DECLARE_COMPLETION_ONSTACK(c);
+	struct pci_doe_task task = {
+		.prot.vid = PCI_VENDOR_ID_PCI_SIG,
+		.prot.type = PCI_DOE_PROTOCOL_DISCOVERY,
+		.request_pl = &request_pl,
+		.request_pl_sz = sizeof(request_pl),
+		.response_pl = &response_pl,
+		.response_pl_sz = sizeof(response_pl),
+		.complete = pci_doe_task_complete,
+		.private = &c,
+	};
+	int ret;
+
+	ret = pci_doe_submit_task(doe_mb, &task);
+	if (ret < 0)
+		return ret;
+
+	wait_for_completion(&c);
+
+	if (task.rv != sizeof(response_pl))
+		return -EIO;
+
+	*vid = FIELD_GET(PCI_DOE_DATA_OBJECT_DISC_RSP_3_VID, response_pl);
+	*protocol = FIELD_GET(PCI_DOE_DATA_OBJECT_DISC_RSP_3_PROTOCOL,
+			      response_pl);
+	*index = FIELD_GET(PCI_DOE_DATA_OBJECT_DISC_RSP_3_NEXT_INDEX,
+			   response_pl);
+
+	return 0;
+}
+
+static int pci_doe_cache_protocols(struct pci_doe_mb *doe_mb)
+{
+	u8 index = 0;
+	int num_prots;
+	int rc;
+
+	/* Discovery protocol must always be supported and must report itself */
+	num_prots = 1;
+
+	doe_mb->prots = kcalloc(num_prots, sizeof(*doe_mb->prots), GFP_KERNEL);
+	if (!doe_mb->prots)
+		return -ENOMEM;
+
+	/*
+	 * NOTE: doe_mb_prots is freed by pci_doe_free_mb() automatically on
+	 * error if pci_doe_cache_protocols() fails past this point.
+	 */
+	do {
+		struct pci_doe_protocol *prot;
+
+		prot = &doe_mb->prots[num_prots - 1];
+		rc = pci_doe_discovery(doe_mb, &index, &prot->vid, &prot->type);
+		if (rc)
+			return rc;
+
+		if (index) {
+			struct pci_doe_protocol *prot_new;
+
+			num_prots++;
+			prot_new = krealloc(doe_mb->prots,
+					    sizeof(*doe_mb->prots) * num_prots,
+					    GFP_KERNEL);
+			if (!prot_new)
+				return -ENOMEM;
+
+			doe_mb->prots = prot_new;
+		}
+	} while (index);
+
+	doe_mb->num_prots = num_prots;
+	return 0;
+}
+
+static int pci_doe_abort(struct pci_doe_mb *doe_mb)
+{
+	reinit_completion(&doe_mb->abort_c);
+	set_bit(PCI_DOE_FLAG_ABORT, &doe_mb->flags);
+	schedule_delayed_work(&doe_mb->statemachine, 0);
+	wait_for_completion(&doe_mb->abort_c);
+
+	if (test_bit(PCI_DOE_FLAG_DEAD, &doe_mb->flags))
+		return -EIO;
+
+	return 0;
+}
+
+static int pci_doe_enable_irq(struct pci_doe_mb *doe_mb, unsigned int irq)
+{
+	struct pci_dev *pdev = doe_mb->pdev;
+	int offset = doe_mb->cap_offset;
+	int rc;
+
+	/*
+	 * Enabling bus mastering is required for MSI/MSIx.  It is safe to call
+	 * this multiple times and thus is called here to ensure that mastering
+	 * is enabled even if the driver has done so.
+	 */
+	pci_set_master(pdev);
+	rc = pci_request_irq(pdev, irq, pci_doe_irq_handler, NULL, doe_mb,
+			     "DOE[%d:%s]", irq, pci_name(pdev));
+	if (rc)
+		return rc;
+
+	doe_mb->irq = irq;
+	pci_write_config_dword(pdev, offset + PCI_DOE_CTRL,
+			       PCI_DOE_CTRL_INT_EN);
+	return 0;
+}
+
+static void pci_doe_free_mb(struct pci_doe_mb *doe_mb)
+{
+	if (doe_mb->irq >= 0)
+		pci_free_irq(doe_mb->pdev, doe_mb->irq, doe_mb);
+	kfree(doe_mb->prots);
+	kfree(doe_mb);
+}
+
+/**
+ * pci_doe_get_irq_num() - Return the irq number for the mailbox at offset
+ *
+ * @pdev: The PCI device
+ * @offset: Offset of the DOE mailbox
+ *
+ * Returns: irq number on success
+ *	    -errno if irqs are not supported on this mailbox
+ */
+int pci_doe_get_irq_num(struct pci_dev *pdev, int offset)
+{
+	u32 val;
+
+	pci_read_config_dword(pdev, offset + PCI_DOE_CAP, &val);
+	if (!FIELD_GET(PCI_DOE_CAP_INT, val))
+		return -EOPNOTSUPP;
+
+	return FIELD_GET(PCI_DOE_CAP_IRQ, val);
+}
+EXPORT_SYMBOL_GPL(pci_doe_get_irq_num);
+
+/**
+ * pci_doe_create_mb() - Create a DOE mailbox object
+ *
+ * @pdev: PCI device to create the DOE mailbox for
+ * @cap_offset: Offset of the DOE mailbox
+ * @irq: irq number to use; a negative value means don't use interrupts
+ *
+ * Create a single mailbox object to manage the mailbox protocol at the
+ * cap_offset specified.
+ *
+ * Caller should allocate PCI IRQ vectors before setting use_irq.
+ *
+ * RETURNS: created mailbox object on success
+ *	    ERR_PTR(-errno) on failure
+ */
+struct pci_doe_mb *pci_doe_create_mb(struct pci_dev *pdev, u16 cap_offset,
+				     int irq)
+{
+	struct pci_doe_mb *doe_mb;
+	int rc;
+
+	doe_mb = kzalloc(sizeof(*doe_mb), GFP_KERNEL);
+	if (!doe_mb)
+		return ERR_PTR(-ENOMEM);
+
+	doe_mb->pdev = pdev;
+	init_completion(&doe_mb->abort_c);
+	doe_mb->irq = -1;
+	doe_mb->cap_offset = cap_offset;
+
+	init_waitqueue_head(&doe_mb->wq);
+	spin_lock_init(&doe_mb->task_lock);
+	INIT_DELAYED_WORK(&doe_mb->statemachine, doe_statemachine_work);
+	doe_mb->state = DOE_IDLE;
+
+	if (irq >= 0) {
+		rc = pci_doe_enable_irq(doe_mb, irq);
+		if (rc)
+			pci_err(pdev,
+				"DOE [%x] enable requested IRQ (%d) failed : %d\n",
+				doe_mb->cap_offset, irq, rc);
+	}
+
+	/* Reset the mailbox by issuing an abort */
+	rc = pci_doe_abort(doe_mb);
+	if (rc) {
+		pci_err(pdev, "DOE [%x] failed to reset : %d\n",
+			doe_mb->cap_offset, rc);
+		pci_doe_free_mb(doe_mb);
+		return ERR_PTR(rc);
+	}
+
+	rc = pci_doe_cache_protocols(doe_mb);
+	if (rc) {
+		pci_err(pdev, "DOE [%x] failed to cache protocols : %d\n",
+			doe_mb->cap_offset, rc);
+		pci_doe_free_mb(doe_mb);
+		return ERR_PTR(rc);
+	}
+
+	return doe_mb;
+}
+EXPORT_SYMBOL_GPL(pci_doe_create_mb);
+
+/**
+ * pci_doe_supports_prot() - Return if the DOE instance supports the given
+ *			     protocol
+ * @doe_mb: DOE mailbox capability to query
+ * @vid: Protocol Vendor ID
+ * @type: Protocol type
+ *
+ * RETURNS: True if the DOE mailbox supports the protocol specified
+ */
+bool pci_doe_supports_prot(struct pci_doe_mb *doe_mb, u16 vid, u8 type)
+{
+	int i;
+
+	/* The discovery protocol must always be supported */
+	if (vid == PCI_VENDOR_ID_PCI_SIG && type == PCI_DOE_PROTOCOL_DISCOVERY)
+		return true;
+
+	for (i = 0; i < doe_mb->num_prots; i++)
+		if ((doe_mb->prots[i].vid == vid) &&
+		    (doe_mb->prots[i].type == type))
+			return true;
+
+	return false;
+}
+EXPORT_SYMBOL_GPL(pci_doe_supports_prot);
+
+/**
+ * pci_doe_submit_task() - Submit a task to be processed by the state machine
+ *
+ * @doe_mb: DOE mailbox capability to submit to
+ * @task: task to be queued
+ *
+ * Submit a DOE task (request/response) to the DOE mailbox to be processed.
+ * Returns upon queueing the task object.  If the queue is full this function
+ * will sleep until there is room in the queue.
+ *
+ * task->complete will be called when the state machine is done processing this
+ * task.
+ *
+ * Excess data will be discarded.
+ *
+ * RETURNS: 0 when task has been successful queued, -ERRNO on error
+ */
+int pci_doe_submit_task(struct pci_doe_mb *doe_mb, struct pci_doe_task *task)
+{
+	if (!pci_doe_supports_prot(doe_mb, task->prot.vid, task->prot.type))
+		return -EINVAL;
+
+	/* DOE requests must be a whole number of DW */
+	if (task->request_pl_sz % sizeof(u32))
+		return -EINVAL;
+
+again:
+	spin_lock(&doe_mb->task_lock);
+	if (doe_mb->cur_task) {
+		spin_unlock(&doe_mb->task_lock);
+		wait_event_interruptible(doe_mb->wq, doe_mb->cur_task == NULL);
+		goto again;
+	}
+
+	if (test_bit(PCI_DOE_FLAG_DEAD, &doe_mb->flags)) {
+		spin_unlock(&doe_mb->task_lock);
+		return -EIO;
+	}
+	doe_mb->cur_task = task;
+	spin_unlock(&doe_mb->task_lock);
+	schedule_delayed_work(&doe_mb->statemachine, 0);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pci_doe_submit_task);
+
+/**
+ * pci_doe_destroy_mb() - Destroy a DOE mailbox object created with
+ * pci_doe_create_mb()
+ *
+ * @doe_mb: DOE mailbox capability structure to destroy
+ *
+ * The mailbox becomes invalid and should not be used after this call.
+ */
+void pci_doe_destroy_mb(struct pci_doe_mb *doe_mb)
+{
+	/* abort any work in progress */
+	pci_doe_abort(doe_mb);
+
+	/* halt the state machine */
+	cancel_delayed_work_sync(&doe_mb->statemachine);
+
+	pci_doe_free_mb(doe_mb);
+}
+EXPORT_SYMBOL_GPL(pci_doe_destroy_mb);
diff --git a/include/linux/pci-doe.h b/include/linux/pci-doe.h
new file mode 100644
index 000000000000..4623881d0e3e
--- /dev/null
+++ b/include/linux/pci-doe.h
@@ -0,0 +1,65 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Data Object Exchange
+ *	PCIe r6.0, sec 6.30 DOE
+ *
+ * Copyright (C) 2021 Huawei
+ *     Jonathan Cameron <Jonathan.Cameron@huawei.com>
+ *
+ * Copyright (C) 2022 Intel Corporation
+ *	Ira Weiny <ira.weiny@intel.com>
+ */
+
+#ifndef LINUX_PCI_DOE_H
+#define LINUX_PCI_DOE_H
+
+#include <linux/completion.h>
+
+struct pci_doe_protocol {
+	u16 vid;
+	u8 type;
+};
+
+/**
+ * struct pci_doe_task - represents a single query/response
+ *
+ * @prot: DOE Protocol
+ * @request_pl: The request payload
+ * @request_pl_sz: Size of the request payload
+ * @response_pl: The response payload
+ * @response_pl_sz: Size of the response payload
+ * @rv: Return value.  Length of received response or error
+ * @complete: Called when task is complete
+ * @private: Private data for the consumer
+ */
+struct pci_doe_task {
+	struct pci_doe_protocol prot;
+	u32 *request_pl;
+	size_t request_pl_sz;
+	u32 *response_pl;
+	size_t response_pl_sz;
+	int rv;
+	void (*complete)(struct pci_doe_task *task);
+	void *private;
+};
+
+/**
+ * pci_doe_for_each_off - Iterate each DOE capability
+ * @pdev: struct pci_dev to iterate
+ * @off: u16 of config space offset of each mailbox capability found
+ */
+#define pci_doe_for_each_off(pdev, off) \
+	for (off = pci_find_next_ext_capability(pdev, off, \
+					PCI_EXT_CAP_ID_DOE); \
+		off > 0; \
+		off = pci_find_next_ext_capability(pdev, off, \
+					PCI_EXT_CAP_ID_DOE))
+
+int pci_doe_get_irq_num(struct pci_dev *pdev, int offset);
+struct pci_doe_mb *pci_doe_create_mb(struct pci_dev *pdev, u16 cap_offset,
+				     int irq);
+void pci_doe_destroy_mb(struct pci_doe_mb *doe_mb);
+bool pci_doe_supports_prot(struct pci_doe_mb *doe_mb, u16 vid, u8 type);
+int pci_doe_submit_task(struct pci_doe_mb *doe_mb, struct pci_doe_task *task);
+
+#endif
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index bee1a9ed6e66..4e96b45ee36d 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -736,7 +736,8 @@
 #define PCI_EXT_CAP_ID_DVSEC	0x23	/* Designated Vendor-Specific */
 #define PCI_EXT_CAP_ID_DLF	0x25	/* Data Link Feature */
 #define PCI_EXT_CAP_ID_PL_16GT	0x26	/* Physical Layer 16.0 GT/s */
-#define PCI_EXT_CAP_ID_MAX	PCI_EXT_CAP_ID_PL_16GT
+#define PCI_EXT_CAP_ID_DOE	0x2E	/* Data Object Exchange */
+#define PCI_EXT_CAP_ID_MAX	PCI_EXT_CAP_ID_DOE
 
 #define PCI_EXT_CAP_DSN_SIZEOF	12
 #define PCI_EXT_CAP_MCAST_ENDPOINT_SIZEOF 40
@@ -1102,4 +1103,30 @@
 #define  PCI_PL_16GT_LE_CTRL_USP_TX_PRESET_MASK		0x000000F0
 #define  PCI_PL_16GT_LE_CTRL_USP_TX_PRESET_SHIFT	4
 
+/* Data Object Exchange */
+#define PCI_DOE_CAP		0x04    /* DOE Capabilities Register */
+#define  PCI_DOE_CAP_INT			0x00000001  /* Interrupt Support */
+#define  PCI_DOE_CAP_IRQ			0x00000ffe  /* Interrupt Message Number */
+#define PCI_DOE_CTRL		0x08    /* DOE Control Register */
+#define  PCI_DOE_CTRL_ABORT			0x00000001  /* DOE Abort */
+#define  PCI_DOE_CTRL_INT_EN			0x00000002  /* DOE Interrupt Enable */
+#define  PCI_DOE_CTRL_GO			0x80000000  /* DOE Go */
+#define PCI_DOE_STATUS		0x0c    /* DOE Status Register */
+#define  PCI_DOE_STATUS_BUSY			0x00000001  /* DOE Busy */
+#define  PCI_DOE_STATUS_INT_STATUS		0x00000002  /* DOE Interrupt Status */
+#define  PCI_DOE_STATUS_ERROR			0x00000004  /* DOE Error */
+#define  PCI_DOE_STATUS_DATA_OBJECT_READY	0x80000000  /* Data Object Ready */
+#define PCI_DOE_WRITE		0x10    /* DOE Write Data Mailbox Register */
+#define PCI_DOE_READ		0x14    /* DOE Read Data Mailbox Register */
+
+/* DOE Data Object - note not actually registers */
+#define PCI_DOE_DATA_OBJECT_HEADER_1_VID		0x0000ffff
+#define PCI_DOE_DATA_OBJECT_HEADER_1_TYPE		0x00ff0000
+#define PCI_DOE_DATA_OBJECT_HEADER_2_LENGTH		0x0003ffff
+
+#define PCI_DOE_DATA_OBJECT_DISC_REQ_3_INDEX		0x000000ff
+#define PCI_DOE_DATA_OBJECT_DISC_RSP_3_VID		0x0000ffff
+#define PCI_DOE_DATA_OBJECT_DISC_RSP_3_PROTOCOL		0x00ff0000
+#define PCI_DOE_DATA_OBJECT_DISC_RSP_3_NEXT_INDEX	0xff000000
+
 #endif /* LINUX_PCI_REGS_H */
-- 
2.35.1

