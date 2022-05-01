Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA06D516721
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 20:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351695AbiEASjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 14:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356447AbiEASi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 14:38:58 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B592515A12
        for <linux-kernel@vger.kernel.org>; Sun,  1 May 2022 11:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651430131; x=1682966131;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=J7MITVQDoFRMxYxGn9fxqS8JfrjoBTz62kPmO3NoxjA=;
  b=F1JKUkPAVWRXFeggwqbv5ex87MFsu6lQkgGQYGnlGIVDM/NZqf6+DR0g
   46kFEJiKW9H2uZtS6jDQ07is4y64yOkln5eDrtYwluUtUFDCyA75+54N1
   8zJFk9/LdcCFntR/pl1xOlLsfpTcE5fY8WYaPgi5BqfI5UcBz7Gc69rK6
   S0aqHywujgk1t1dU/rri1vWZwxQRx4/bLN3uX6W3zuoj0MX0+oGCiAl23
   SxYTtbK/qzzYIzM3fGZTZJE16b1QMWiqXuH6gWW22d6JF//tILB4FL63s
   GgnLMWq44zn/jh/3x1uu9eLUtYoJJfPWZDrA2+mFsJ1wyXibjN0x1hBKI
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10334"; a="247598673"
X-IronPort-AV: E=Sophos;i="5.91,190,1647327600"; 
   d="scan'208";a="247598673"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2022 11:35:30 -0700
X-IronPort-AV: E=Sophos;i="5.91,190,1647327600"; 
   d="scan'208";a="515731282"
Received: from pghaisax-mobl1.amr.corp.intel.com (HELO skuppusw-desk1.home) ([10.209.85.28])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2022 11:35:29 -0700
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
Subject: [PATCH v5 3/3] x86/tdx: Add Quote generation support
Date:   Sun,  1 May 2022 11:35:00 -0700
Message-Id: <20220501183500.2242828-4-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220501183500.2242828-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20220501183500.2242828-1-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In TDX guest, the second stage in attestation process is to send the
TDREPORT to QE/QGS to generate the TD Quote. For platforms that does
not support communication channels like vsock or TCP/IP, implement
support to get TD Quote using TDVMCALL. GetQuote hypercall can be used
by the TD guest to request VMM facilitate the Quote generation via
QE/QGS. More details about GetQuote hypercall can be found in TDX
Guest-Host Communication Interface (GHCI) for Intel TDX 1.0, section
titled "TDG.VP.VMCALL<GetQuote>.

Since GetQuote is an asynchronous request hypercall, it will not block
till the TD Quote is generated. So VMM uses callback interrupt vector
configured by SetupEventNotifyInterrupt hypercall to notify the guest
about Quote generation completion or failure. Upon receiving the
completion notification, status can be found in the TD Quote request
header.

Although GHCI specification does not restrict parallel GetQuote
requests, since Quote generation is not in performance critical path
and the frequency of attestation requests are expected to be low, only
support serialized quote generation requests. Parallel quote request
support can be added once demand arises.

Currently the buffer required to get the TD Quote data and its shared
mapping conversion (using set_memory_decrypted()) is handled within the
IOCTL handler. Although it will increase the TDX_CMD_GET_QUOTE IOCTL
response time,  it is negligible compared to the time required for the
quote generation completion. So IOCTL performance optimization is not
considered at this time.

Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 arch/x86/coco/tdx/attest.c      | 135 ++++++++++++++++++++++++++++++++
 arch/x86/include/uapi/asm/tdx.h |  40 ++++++++++
 2 files changed, 175 insertions(+)

diff --git a/arch/x86/coco/tdx/attest.c b/arch/x86/coco/tdx/attest.c
index 4543a0264ce7..6aba85297708 100644
--- a/arch/x86/coco/tdx/attest.c
+++ b/arch/x86/coco/tdx/attest.c
@@ -22,6 +22,7 @@
 #include <linux/io.h>
 #include <asm/apic.h>
 #include <asm/tdx.h>
+#include <asm/coco.h>
 #include <asm/irq_vectors.h>
 #include <uapi/asm/tdx.h>
 
@@ -29,12 +30,20 @@
 
 /* TDREPORT module call leaf ID */
 #define TDX_GET_REPORT			4
+/* GetQuote hypercall leaf ID */
+#define TDVMCALL_GET_QUOTE             0x10002
 
 /* Upper 32 bits has the status code, so mask it */
 #define TDCALL_STATUS_CODE_MASK		0xffffffff00000000
 #define TDCALL_STATUS_CODE(a)		((a) & TDCALL_STATUS_CODE_MASK)
 
 static struct miscdevice miscdev;
+/* Completion object to track GetQuote completion status */
+static DECLARE_COMPLETION(req_compl);
+/* Mutex to serialize GetQuote requests */
+static DEFINE_MUTEX(quote_lock);
+/* Pointer to track current quote request */
+static void *tdquote;
 
 static long tdx_get_report(void __user *argp)
 {
@@ -88,6 +97,126 @@ static long tdx_get_report(void __user *argp)
 	return ret;
 }
 
+/* tdx_get_quote_hypercall() - Request to get TD Quote using TDREPORT.
+ *
+ * @quote_buf	: Address of 4KB aligned GPA memory which contains
+ *		  TDREPORT. It is also used as output buffer to copy
+ *		  the GetQuote output upon successful execution.
+ * @quote_len	: Length of the GPA in bytes.
+ *
+ * Return hypercall status code.
+ */
+static long tdx_get_quote_hypercall(void *quote_buf, u64 quote_len)
+{
+	struct tdx_hypercall_args args = {0};
+
+	args.r10 = TDX_HYPERCALL_STANDARD;
+	args.r11 = TDVMCALL_GET_QUOTE;
+	args.r12 = cc_mkdec(virt_to_phys(quote_buf));
+	args.r13 = quote_len;
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
+static long tdx_get_quote(void __user *argp)
+{
+	struct tdx_quote_req quote_req;
+	long ret = 0;
+	int order;
+
+	/* Hold lock to serialize GetQuote requests */
+	mutex_lock(&quote_lock);
+
+	reinit_completion(&req_compl);
+
+	/* Copy GetQuote request struct from user buffer */
+	if (copy_from_user(&quote_req, argp, sizeof(struct tdx_quote_req))) {
+		ret = -EFAULT;
+		goto quote_failed;
+	}
+
+	/* Make sure the length & timeout is valid */
+	if (!quote_req.len || !quote_req.timeout) {
+		ret = -EINVAL;
+		goto quote_failed;
+	}
+
+	/* Get order for Quote buffer page allocation */
+	order = get_order(quote_req.len);
+
+	/*
+	 * Allocate buffer to get TD Quote from the VMM.
+	 * Size needs to be 4KB aligned (which is already
+	 * met in page allocation).
+	 */
+	tdquote = (void *)__get_free_pages(GFP_KERNEL | __GFP_ZERO, order);
+	if (!tdquote) {
+		ret = -ENOMEM;
+		goto quote_failed;
+	}
+
+	/*
+	 * Since this buffer will be shared with the VMM via GetQuote
+	 * hypercall, decrypt it.
+	 */
+	ret = set_memory_decrypted((unsigned long)tdquote, 1UL << order);
+	if (ret)
+		goto quote_failed;
+
+	/* Copy TDREPORT from user buffer to kernel Quote buffer */
+	if (copy_from_user(tdquote, (void __user *)quote_req.buf, quote_req.len)) {
+		ret = -EFAULT;
+		goto quote_failed;
+	}
+
+	/* Submit GetQuote Request */
+	ret = tdx_get_quote_hypercall(tdquote, (1ULL << order) * PAGE_SIZE);
+	if (ret) {
+		pr_err("GetQuote hypercall failed, status:%lx\n", ret);
+		ret = -EIO;
+		goto quote_failed;
+	}
+
+	/* Wait for attestation completion */
+	ret = wait_for_completion_interruptible(&req_compl);
+	if (ret <= 0) {
+		ret = -EIO;
+		goto quote_failed;
+	}
+
+	/* Copy output data back to user buffer */
+	if (copy_to_user((void __user *)quote_req.buf, tdquote, quote_req.len))
+		ret = -EFAULT;
+
+quote_failed:
+	if (tdquote)
+		free_pages((unsigned long)tdquote, order);
+	tdquote = NULL;
+	mutex_unlock(&quote_lock);
+	return ret;
+}
+
+static void attestation_callback_handler(void)
+{
+	struct tdx_quote_hdr *quote_hdr;
+
+	quote_hdr = (struct tdx_quote_hdr *) tdquote;
+
+	/* Check for spurious callback IRQ case */
+	if (!tdquote || quote_hdr->status == GET_QUOTE_IN_FLIGHT)
+		return;
+
+	complete(&req_compl);
+}
+
 static long tdx_attest_ioctl(struct file *file, unsigned int cmd,
 			     unsigned long arg)
 {
@@ -98,6 +227,9 @@ static long tdx_attest_ioctl(struct file *file, unsigned int cmd,
 	case TDX_CMD_GET_REPORT:
 		ret = tdx_get_report(argp);
 		break;
+	case TDX_CMD_GET_QUOTE:
+		ret = tdx_get_quote(argp);
+		break;
 	default:
 		pr_debug("cmd %d not supported\n", cmd);
 		ret = -EINVAL;
@@ -121,6 +253,9 @@ static int __init tdx_attestation_init(void)
 	if (!cpu_feature_enabled(X86_FEATURE_TDX_GUEST))
 		return -EIO;
 
+	/* Register attestation event notify handler */
+	tdx_setup_ev_notify_handler(attestation_callback_handler);
+
 	miscdev.name = DRIVER_NAME;
 	miscdev.minor = MISC_DYNAMIC_MINOR;
 	miscdev.fops = &tdx_attest_fops;
diff --git a/arch/x86/include/uapi/asm/tdx.h b/arch/x86/include/uapi/asm/tdx.h
index 9a7377723667..3eb60253432c 100644
--- a/arch/x86/include/uapi/asm/tdx.h
+++ b/arch/x86/include/uapi/asm/tdx.h
@@ -33,4 +33,44 @@ struct tdx_report_req {
 /* Get TDREPORT from the TDX module using TDCALL[TDG.MR.REPORT) */
 #define TDX_CMD_GET_REPORT		_IOWR('T', 0x01, struct tdx_report_req)
 
+/* struct tdx_quote_req: Request to generate TD Quote using TDREPORT
+ *
+ * @buf		: Pass user data that includes TDREPORT as input. Upon
+ *		  successful completion of IOCTL, output is copied
+ *		  back to the same buffer.
+ * @len		: Length of the buffer.
+ */
+struct tdx_quote_req {
+	__u64 buf;
+	__u64 len;
+	__u32 timeout;
+};
+
+/* Get TD Quote from QE/QGS using TDREPORT passed by the user */
+#define TDX_CMD_GET_QUOTE		_IOR('T', 0x02, struct tdx_quote_req)
+
+/* TD Quote status codes */
+#define GET_QUOTE_SUCCESS		0
+#define GET_QUOTE_IN_FLIGHT		0xffffffffffffffff
+#define GET_QUOTE_ERROR			0x8000000000000000
+#define GET_QUOTE_SERVICE_UNAVAILABLE	0x8000000000000001
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
+	/* Actual Quote data */
+	__u64 data[0];
+};
+
 #endif /* _UAPI_ASM_X86_TDX_H */
-- 
2.25.1

