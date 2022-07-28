Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F3815837B2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 05:45:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238264AbiG1DpI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 23:45:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237679AbiG1Dof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 23:44:35 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 842925C97F
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 20:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658979872; x=1690515872;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JRv+jq3ytd5/iS9VEDsTXUgXv6sjwLIWi+k1AmXbKKU=;
  b=LObEv7BeCYd5+b/Fm+FSlBoHW2K3FPy1El1s53IfIalivPw2C0hGfbPW
   z4CK4uQHwOzMfuI2g9rV4ySCLBMI31XRk9m8lsetHgtl7PepeHBb+iGu+
   MBWXyNPf2hXxXZWR1qq5Rxab/CcHYWIvXrZdv6YETpOiq89K4gZixglS5
   rqjwSx78SPLe29LHh18k4g2sehHugszRs/Nx6V/xr0O/nNSzXmLoYEPoj
   cnnjEEe8mY8xexKYZ9ZeATFhldF8XM0F5ICrFaF9CwxOtLlTxJur0OY6u
   p2R3qlETBJ6qYjMsA+5/+Jra5OJaQUE3nR2SuQcfRtr+AskfkX73/EDYu
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10421"; a="275292814"
X-IronPort-AV: E=Sophos;i="5.93,196,1654585200"; 
   d="scan'208";a="275292814"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2022 20:44:31 -0700
X-IronPort-AV: E=Sophos;i="5.93,196,1654585200"; 
   d="scan'208";a="600676745"
Received: from hurleyst-mobl.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.209.106.108])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2022 20:44:31 -0700
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc:     "H . Peter Anvin" <hpa@zytor.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kai Huang <kai.huang@intel.com>,
        Wander Lairson Costa <wander@redhat.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 5/6] x86/tdx: Add Quote generation support
Date:   Wed, 27 Jul 2022 20:44:19 -0700
Message-Id: <20220728034420.648314-6-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220728034420.648314-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20220728034420.648314-1-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In TDX guest, the second stage in attestation process is to send the
TDREPORT to QE/QGS to generate the TD Quote. For platforms that does
not support communication channels like vsock or TCP/IP, implement
support to get TD Quote using hypercall. GetQuote hypercall can be used
by the TD guest to request VMM facilitate the Quote generation via
QE/QGS. More details about GetQuote hypercall can be found in TDX
Guest-Host Communication Interface (GHCI) for Intel TDX 1.0, section
titled "TDG.VP.VMCALL<GetQuote>.

Since GetQuote is an asynchronous request hypercall, it will not block
till the TD Quote is generated. So VMM uses callback interrupt vector
configured by SetupEventNotifyInterrupt hypercall to notify the guest
about Quote generation completion or failure.

GetQuote TDVMCALL requires TD guest pass a 4K aligned shared buffer
with TDREPORT data as input, which is further used by the VMM to copy
the TD Quote result after successful Quote generation. To create the
shared buffer without breaking the direct map, use
cc_decrypted_alloc/free() APIs.

Also note that, shared buffer allocation is currently handled in IOCTL
handler, although it will increase the TDX_CMD_GET_QUOTE IOCTL response
time, it is negligible compared to the time required for the quote
generation completion. So IOCTL performance optimization is not
considered at this time.

Add support for TDX_CMD_GET_QUOTE IOCTL to allow attestation agent
submit GetQuote requests from the user space. Since Quote generation
is an asynchronous request, IOCTL will block indefinitely for the VMM
response in wait_for_completion_interruptible() call. Using this call
will also add an option for the user to end the current request
prematurely by raising any signals. This can be used by attestation
agent to implement Quote generation timeout feature. If attestation
agent is aware of time it can validly wait for QE/QGS response, then
a possible timeout support can be implemented in the user application
using signals. Quote generation timeout feature is currently not
implemented in the driver because the current TDX specification does
not have any recommendation for it.

After submitting the GetQuote request using hypercall, the shared buffer
allocated for the current request is owned by the VMM. So, during this
wait window, if the user terminates the request by raising a signal or
by terminating the application, add a logic to do the memory cleanup
after receiving the VMM response at a later time.

To support parallel GetQuote requests, use linked list to track the
active GetQuote requests and upon receiving the callback IRQ, loop
through the active requests and mark the processed requests complete.
Users can open multiple instances of the attestation device and send
GetQuote requests in parallel.

Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 arch/x86/coco/tdx/attest.c      | 282 ++++++++++++++++++++++++++++++++
 arch/x86/coco/tdx/tdx.c         |  10 ++
 arch/x86/coco/tdx/tdx.h         |   2 +
 arch/x86/include/uapi/asm/tdx.h |  45 +++++
 4 files changed, 339 insertions(+)

diff --git a/arch/x86/coco/tdx/attest.c b/arch/x86/coco/tdx/attest.c
index 46a2f3612753..8fc7c6e52983 100644
--- a/arch/x86/coco/tdx/attest.c
+++ b/arch/x86/coco/tdx/attest.c
@@ -8,14 +8,56 @@
  *
  */
 
+#define pr_fmt(fmt) "x86/tdx: attest: " fmt
+
 #include <linux/mm.h>
 #include <linux/io.h>
+#include <linux/interrupt.h>
+#include <linux/mutex.h>
 #include <asm/tdx.h>
+#include <asm/coco.h>
 
 #include "tdx.h"
 
 /* TDREPORT module call leaf ID */
 #define TDX_GET_REPORT			4
+/* GetQuote hypercall leaf ID */
+#define TDVMCALL_GET_QUOTE             0x10002
+
+/* Used for buffer allocation in GetQuote request */
+struct quote_buf {
+	/* Address of kernel buffer (size is page aligned) */
+	void *vmaddr;
+	/* Size of the allocated memory */
+	int size;
+};
+
+/* List entry of quote_list */
+struct quote_entry {
+	/* Flag to check validity of the GetQuote request */
+	bool valid;
+	/* Kernel buffer to share data with VMM */
+	struct quote_buf buf;
+	/* Completion object to track completion of GetQuote request */
+	struct completion compl;
+	struct list_head list;
+};
+
+/*
+ * To support parallel GetQuote requests, use the list
+ * to track active GetQuote requests.
+ */
+static LIST_HEAD(quote_list);
+
+/* Lock to protect quote_list */
+static DEFINE_MUTEX(quote_lock);
+
+/*
+ * Workqueue to handle Quote data after Quote generation
+ * notification from VMM.
+ */
+struct workqueue_struct *quote_wq;
+struct work_struct quote_work;
 
 long tdx_get_report(void __user *argp)
 {
@@ -79,3 +121,243 @@ long tdx_get_report(void __user *argp)
 	kfree(tdreport);
 	return ret;
 }
+
+/* tdx_get_quote_hypercall() - Request to get TD Quote using TDREPORT */
+static long tdx_get_quote_hypercall(struct quote_buf *buf)
+{
+	struct tdx_hypercall_args args = {0};
+
+	args.r10 = TDX_HYPERCALL_STANDARD;
+	args.r11 = TDVMCALL_GET_QUOTE;
+	args.r12 = virt_to_phys(buf->vmaddr);
+	args.r13 = buf->size;
+
+	/*
+	 * Pass the physical address of TDREPORT to the VMM and
+	 * trigger the Quote generation. It is not a blocking
+	 * call, hence completion of this request will be notified to
+	 * the TD guest via a callback interrupt. More info about ABI
+	 * can be found in TDX Guest-Host-Communication Interface
+	 * (GHCI), sec titled "TDG.VP.VMCALL<GetQuote>".
+	 */
+	return __tdx_hypercall(&args, 0);
+}
+
+/*
+ * init_quote_buf() - Initialize the quote buffer by allocating
+ *                    a shared buffer of given size.
+ *
+ * Size is page aligned and the allocated memory is decrypted
+ * to allow VMM to access it.
+ */
+static int init_quote_buf(struct quote_buf *buf, u64 req_size)
+{
+	int size = PAGE_ALIGN(req_size);
+	void *vmaddr;
+
+	vmaddr = cc_decrypted_alloc(size, GFP_KERNEL);
+	if (!vmaddr)
+		return -ENOMEM;
+
+	buf->vmaddr = vmaddr;
+	buf->size = size;
+
+	return 0;
+}
+
+/* Free the decrypted memory */
+static void deinit_quote_buf(struct quote_buf *buf)
+{
+	cc_decrypted_free(buf->vmaddr, buf->size);
+}
+
+static struct quote_entry *alloc_quote_entry(u64 buf_len)
+{
+	struct quote_entry *entry = NULL;
+
+	entry = kmalloc(sizeof(*entry), GFP_KERNEL);
+	if (!entry)
+		return NULL;
+
+	/* Init buffer for quote request */
+	if (init_quote_buf(&entry->buf, buf_len)) {
+		pr_err("Shared buffer allocation failed\n");
+		kfree(entry);
+		return NULL;
+	}
+
+	init_completion(&entry->compl);
+	entry->valid = true;
+
+	return entry;
+}
+
+static void free_quote_entry(struct quote_entry *entry)
+{
+	deinit_quote_buf(&entry->buf);
+	kfree(entry);
+}
+
+/* Must be called with quote_lock held */
+static void _del_quote_entry(struct quote_entry *entry)
+{
+	list_del(&entry->list);
+	free_quote_entry(entry);
+}
+
+static void del_quote_entry(struct quote_entry *entry)
+{
+	mutex_lock(&quote_lock);
+	_del_quote_entry(entry);
+	mutex_unlock(&quote_lock);
+}
+
+/* Handles early termination of GetQuote requests */
+static void terminate_quote_request(struct quote_entry *entry)
+{
+	struct tdx_quote_hdr *quote_hdr;
+
+	/*
+	 * For early termination, if the request is not yet
+	 * processed by VMM (GET_QUOTE_IN_FLIGHT), the VMM
+	 * still owns the shared buffer, so mark the request
+	 * invalid to let quote_callback_handler() handle the
+	 * memory cleanup function. If the request is already
+	 * processed, then do the cleanup and return.
+	 */
+
+	mutex_lock(&quote_lock);
+	quote_hdr = (struct tdx_quote_hdr *)entry->buf.vmaddr;
+	if (quote_hdr->status == GET_QUOTE_IN_FLIGHT) {
+		entry->valid = false;
+		mutex_unlock(&quote_lock);
+		return;
+	}
+	_del_quote_entry(entry);
+	mutex_unlock(&quote_lock);
+}
+
+long tdx_get_quote(void __user *argp)
+{
+	struct quote_entry *entry;
+	struct tdx_quote_req req;
+	struct quote_buf *buf;
+	long ret;
+
+	/* Copy GetQuote request struct from user buffer */
+	if (copy_from_user(&req, argp, sizeof(struct tdx_quote_req)))
+		return -EFAULT;
+
+	/* Make sure the length is valid */
+	if (!req.len) {
+		pr_err("Invalid Quote buffer length\n");
+		return -EINVAL;
+	}
+
+	entry = alloc_quote_entry(req.len);
+	if (!entry) {
+		pr_err("Quote entry allocation failed\n");
+		return -ENOMEM;
+	}
+
+	buf = &entry->buf;
+
+	/* Copy data (with TDREPORT) from user buffer to kernel Quote buffer */
+	if (copy_from_user(buf->vmaddr, (void __user *)req.buf, req.len)) {
+		free_quote_entry(entry);
+		return -EFAULT;
+	}
+
+	mutex_lock(&quote_lock);
+
+	/* Submit GetQuote Request */
+	ret = tdx_get_quote_hypercall(buf);
+	if (ret) {
+		mutex_unlock(&quote_lock);
+		pr_err("GetQuote hypercall failed, status:%lx\n", ret);
+		free_quote_entry(entry);
+		return -EIO;
+	}
+
+	/* Add current quote entry to quote_list to track active requests */
+	list_add_tail(&entry->list, &quote_list);
+
+	mutex_unlock(&quote_lock);
+
+	/* Wait for attestation completion */
+	ret = wait_for_completion_interruptible(&entry->compl);
+	if (ret < 0) {
+		pr_err("GetQuote request terminated\n");
+		terminate_quote_request(entry);
+		return -EINTR;
+	}
+
+	/*
+	 * If GetQuote request completed successfully, copy the result
+	 * back to the user and do the cleanup.
+	 */
+	if (copy_to_user((void __user *)req.buf, buf->vmaddr, req.len))
+		ret = -EFAULT;
+
+	/*
+	 * Reaching here means GetQuote request is processed
+	 * successfully. So do the cleanup and return 0.
+	 */
+	del_quote_entry(entry);
+
+	return 0;
+}
+
+static irqreturn_t attestation_callback_handler(int irq, void *dev_id)
+{
+	queue_work(quote_wq, &quote_work);
+	return IRQ_HANDLED;
+}
+
+static void quote_callback_handler(struct work_struct *work)
+{
+	struct tdx_quote_hdr *quote_hdr;
+	struct quote_entry *entry, *next;
+
+	/* Find processed quote request and mark it complete */
+	mutex_lock(&quote_lock);
+	list_for_each_entry_safe(entry, next, &quote_list, list) {
+		quote_hdr = (struct tdx_quote_hdr *)entry->buf.vmaddr;
+		if (quote_hdr->status == GET_QUOTE_IN_FLIGHT)
+			continue;
+		/*
+		 * If user invalidated the current request, remove the
+		 * entry from the quote list and free it. If the request
+		 * is still valid, mark it complete.
+		 */
+		if (entry->valid)
+			complete(&entry->compl);
+		else
+			_del_quote_entry(entry);
+	}
+	mutex_unlock(&quote_lock);
+}
+
+int __init tdx_attest_init(void *data)
+{
+	quote_wq = create_singlethread_workqueue("tdx_quote_handler");
+
+	INIT_WORK(&quote_work, quote_callback_handler);
+
+	/*
+	 * Register event notification IRQ to get Quote completion
+	 * notification. Since tdx_notify_irq is not specific to the
+	 * attestation feature, use IRQF_SHARED to make it shared IRQ.
+	 * Use IRQF_NOBALANCING to make sure the IRQ affinity will not
+	 * be changed.
+	 */
+	if (request_irq(tdx_notify_irq, attestation_callback_handler,
+				IRQF_NOBALANCING | IRQF_SHARED,
+				"tdx_quote_irq", data)) {
+		pr_err("notify IRQ request failed\n");
+		destroy_workqueue(quote_wq);
+		return -EIO;
+	}
+
+	return 0;
+}
diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 3563b208979c..801d4f14fa27 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -826,6 +826,9 @@ static long tdx_guest_ioctl(struct file *file, unsigned int cmd,
 	case TDX_CMD_GET_REPORT:
 		ret = tdx_get_report(argp);
 		break;
+	case TDX_CMD_GET_QUOTE:
+		ret = tdx_get_quote(argp);
+		break;
 	default:
 		pr_debug("cmd %d not supported\n", cmd);
 		break;
@@ -858,6 +861,13 @@ static int __init tdx_guest_init(void)
 		return ret;
 	}
 
+	ret = tdx_attest_init(&tdx_misc_dev);
+	if (ret) {
+		pr_err("attestation init failed\n");
+		misc_deregister(&tdx_misc_dev);
+		return ret;
+	}
+
 	return 0;
 }
 device_initcall(tdx_guest_init)
diff --git a/arch/x86/coco/tdx/tdx.h b/arch/x86/coco/tdx/tdx.h
index 67231d6d1027..9d40d2e4b680 100644
--- a/arch/x86/coco/tdx/tdx.h
+++ b/arch/x86/coco/tdx/tdx.h
@@ -5,5 +5,7 @@
 #include <uapi/asm/tdx.h>
 
 long tdx_get_report(void __user *argp);
+long tdx_get_quote(void __user *argp);
+int __init tdx_attest_init(void *data);
 
 #endif /* __X86_COCO_TDX_H__ */
diff --git a/arch/x86/include/uapi/asm/tdx.h b/arch/x86/include/uapi/asm/tdx.h
index 20db8081772b..2cbe42e959f9 100644
--- a/arch/x86/include/uapi/asm/tdx.h
+++ b/arch/x86/include/uapi/asm/tdx.h
@@ -48,4 +48,49 @@ struct tdx_report_req {
  */
 #define TDX_CMD_GET_REPORT		_IOWR('T', 0x01, __u64)
 
+/* TD Quote status codes */
+#define GET_QUOTE_SUCCESS               0
+#define GET_QUOTE_IN_FLIGHT             0xffffffffffffffff
+#define GET_QUOTE_ERROR                 0x8000000000000000
+#define GET_QUOTE_SERVICE_UNAVAILABLE   0x8000000000000001
+
+/*
+ * Format of Quote data header. More details can be found in TDX
+ * Guest-Host Communication Interface (GHCI) for Intel TDX 1.0,
+ * section titled "TDG.VP.VMCALL<GetQuote>"
+ */
+struct tdx_quote_hdr {
+	/* Quote version, filled by TD */
+	__u64 version;
+	/* Status code of Quote request, filled by VMM */
+	__u64 status;
+	/* Length of TDREPORT, filled by TD */
+	__u32 in_len;
+	/* Length of Quote, filled by VMM */
+	__u32 out_len;
+	/* Actual Quote data or TDREPORT on input */
+	__u64 data[0];
+};
+
+/* struct tdx_quote_req: Request to generate TD Quote using TDREPORT
+ *
+ * @buf         : Pass user data that includes TDREPORT as input. Upon
+ *                successful completion of IOCTL, output is copied
+ *                back to the same buffer.
+ * @len         : Length of the Quote buffer.
+ */
+struct tdx_quote_req {
+	__u64 buf;
+	__u64 len;
+};
+
+/*
+ * TDX_CMD_GET_QUOTE - Get TD Quote from QE/QGS using GetQuote
+ *		       TDVMCALL.
+ *
+ * Returns 0 on success, -EINTR for interrupted request, and
+ * standard errono on other failures.
+ */
+#define TDX_CMD_GET_QUOTE		_IOR('T', 0x02, __u64)
+
 #endif /* _UAPI_ASM_X86_TDX_H */
-- 
2.25.1

