Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C64450C4F3
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 01:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbiDVXlg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 19:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbiDVXlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 19:41:11 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54D9578FE2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 16:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650670464; x=1682206464;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kjuWSd2sy7XgFmiv5deJMfpfD5m8N1nfUS60tlT2HHo=;
  b=fkbjniia96PShcI0JCqg4JSN9uq+Ndp6bfINNhvZwvVFHPexKw7NR17s
   EgkfeBD752WOka/koymn/WIIEfihPsVslH+XuT1vApbAiC8AKNs26FuhE
   99zG1lxl82Q0fYNiARwUfeMkXjc9GFT7Su73cb7mwTRehJKCbYmIXubTA
   c7WuqU/4yVPuc1Gdn07JNMvE+ZS+kmlCcgGwNzcsEdLdEA1cnZhV03kZ8
   clQpm5kchQvkXJR6Tfx5xBD/IdRj48GRDzZlkf91kAo4H1QXUw7vFNOVR
   /IcuF9RE0OjPJwm8MV82e/hwgx0TZ5tnIsUQnQ964ZvJoKV48WqN/L4mW
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="246719369"
X-IronPort-AV: E=Sophos;i="5.90,282,1643702400"; 
   d="scan'208";a="246719369"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2022 16:34:23 -0700
X-IronPort-AV: E=Sophos;i="5.90,282,1643702400"; 
   d="scan'208";a="648838432"
Received: from albelfat-mobl.amr.corp.intel.com (HELO skuppusw-desk1.home) ([10.212.246.20])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2022 16:34:23 -0700
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
        Kai Huang <kai.huang@intel.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/3] x86/tdx: Add TDX Guest attestation interface driver
Date:   Fri, 22 Apr 2022 16:34:16 -0700
Message-Id: <20220422233418.1203092-2-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220422233418.1203092-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20220422233418.1203092-1-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In TDX guest, attestation is used to verify the trustworthiness of a TD
to other entities before making any secure communication.

One usage example is, when a TD guest uses encrypted drive and the
decryption keys required to access the drive are stored in a secure
3rd party keyserver, TD guest can use the quote generated via the
attestation process to prove its trustworthiness with keyserver and
get access to the storage keys.

General steps involved in attestation process are,

  1. TD guest generates the TDREPORT that contains version information
     about the Intel TDX module, measurement of the TD, along with a
     TD-specified nonce.
  2. TD guest shares the TDREPORT with TD host via GetQuote hypercall
     which is used by the host to generate a quote via quoting
     enclave (QE).
  3. Quote generation completion notification is sent to TD OS via
     callback interrupt vector configured by TD using
     SetupEventNotifyInterrupt hypercall.
  4. After receiving the generated TDQUOTE, a remote verifier can be
     used to verify the quote and confirm the trustworthiness of the
     TD.
     
More details on above mentioned steps can be found in TDX Guest-Host
Communication Interface (GHCI) for Intel TDX 1.0, section titled
"TD attestation".

To allow the attestation agent (user application) to implement this
feature, add an IOCTL interface to get TDREPORT and TDQUOTE from the
user space. Since attestation agent can also use methods like vosck or
TCP/IP to get the TDQUOTE, adding an IOCTL interface for it is an
optional feature. So to simplify the driver, first add support for
TDX_CMD_GET_TDREPORT IOCTL. Support for TDQUOTE IOCTL will be added by
follow-on patches.

TDREPORT can be generated by sending a TDCALL with leaf ID as 0x04.
More details about the TDREPORT TDCALL can be found in Intel Trust
Domain Extensions (Intel TDX) Module specification, section titled
"TDG.MR.REPORT Leaf". Add a wrapper function (tdx_mcall_tdreport())
to get the TDREPORT from the TDX Module. This API will be used by the
interface driver to request for TDREPORT.

Also note that explicit access permissions are not enforced in this
driver because the quote and measurements are not a secret. However
the access permissions of the device node can be used to set any
desired access policy. The udev default is usually root access
only.

Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 arch/x86/coco/tdx/Makefile      |   2 +-
 arch/x86/coco/tdx/attest.c      | 191 ++++++++++++++++++++++++++++++++
 arch/x86/coco/tdx/tdx.c         |  45 ++++++++
 arch/x86/include/asm/tdx.h      |   2 +
 arch/x86/include/uapi/asm/tdx.h |  23 ++++
 5 files changed, 262 insertions(+), 1 deletion(-)
 create mode 100644 arch/x86/coco/tdx/attest.c
 create mode 100644 arch/x86/include/uapi/asm/tdx.h

diff --git a/arch/x86/coco/tdx/Makefile b/arch/x86/coco/tdx/Makefile
index 46c55998557d..d2db3e6770e5 100644
--- a/arch/x86/coco/tdx/Makefile
+++ b/arch/x86/coco/tdx/Makefile
@@ -1,3 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
 
-obj-y += tdx.o tdcall.o
+obj-y += tdx.o tdcall.o attest.o
diff --git a/arch/x86/coco/tdx/attest.c b/arch/x86/coco/tdx/attest.c
new file mode 100644
index 000000000000..b776e81f6c20
--- /dev/null
+++ b/arch/x86/coco/tdx/attest.c
@@ -0,0 +1,191 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * attest.c - TDX guest attestation interface driver.
+ *
+ * Implements user interface to trigger attestation process and
+ * read the TD Quote result.
+ *
+ * Copyright (C) 2022 Intel Corporation
+ *
+ */
+
+#define pr_fmt(fmt) "x86/tdx: attest: " fmt
+
+#include <linux/module.h>
+#include <linux/miscdevice.h>
+#include <linux/uaccess.h>
+#include <linux/fs.h>
+#include <linux/mm.h>
+#include <linux/slab.h>
+#include <linux/set_memory.h>
+#include <linux/dma-mapping.h>
+#include <linux/platform_device.h>
+#include <linux/jiffies.h>
+#include <linux/io.h>
+#include <asm/apic.h>
+#include <asm/tdx.h>
+#include <asm/irq_vectors.h>
+#include <uapi/asm/tdx.h>
+
+#define DRIVER_NAME "tdx-attest"
+
+static struct platform_device *pdev;
+static struct miscdevice miscdev;
+
+static long tdx_get_tdreport(void __user *argp)
+{
+	void *report_buf = NULL, *tdreport_buf = NULL;
+	long ret = 0, err;
+
+	/* Allocate space for report data */
+	report_buf = kmalloc(TDX_REPORT_DATA_LEN, GFP_KERNEL);
+	if (!report_buf)
+		return -ENOMEM;
+
+	/*
+	 * Allocate space for TDREPORT buffer (1024-byte aligned).
+	 * Full page alignment is more than enough.
+	 */
+	tdreport_buf = (void *)get_zeroed_page(GFP_KERNEL);
+	if (!tdreport_buf) {
+		ret = -ENOMEM;
+		goto tdreport_failed;
+	}
+
+	/* Copy report data to kernel buffer */
+	if (copy_from_user(report_buf, argp, TDX_REPORT_DATA_LEN)) {
+		ret = -EFAULT;
+		goto tdreport_failed;
+	}
+
+	/* Generate TDREPORT using report data in report_buf */
+	err = tdx_mcall_tdreport(tdreport_buf, report_buf);
+	if (err) {
+		/* If failed, pass TDCALL error code back to user */
+		ret = put_user(err, (long __user *)argp);
+		ret = -EIO;
+		goto tdreport_failed;
+	}
+
+	/* Copy TDREPORT data back to user buffer */
+	if (copy_to_user(argp, tdreport_buf, TDX_TDREPORT_LEN))
+		ret = -EFAULT;
+
+tdreport_failed:
+	kfree(report_buf);
+	if (tdreport_buf)
+		free_pages((unsigned long)tdreport_buf, 0);
+
+	return ret;
+}
+
+static long tdx_attest_ioctl(struct file *file, unsigned int cmd,
+			     unsigned long arg)
+{
+	void __user *argp = (void __user *)arg;
+	long ret = 0;
+
+	switch (cmd) {
+	case TDX_CMD_GET_TDREPORT:
+		ret = tdx_get_tdreport(argp);
+		break;
+	default:
+		pr_err("cmd %d not supported\n", cmd);
+		break;
+	}
+
+	return ret;
+}
+
+static const struct file_operations tdx_attest_fops = {
+	.owner		= THIS_MODULE,
+	.unlocked_ioctl	= tdx_attest_ioctl,
+	.llseek		= no_llseek,
+};
+
+static int tdx_attest_probe(struct platform_device *attest_pdev)
+{
+	struct device *dev = &attest_pdev->dev;
+	long ret = 0;
+
+	/* Only single device is allowed */
+	if (pdev)
+		return -EBUSY;
+
+	pdev = attest_pdev;
+
+	miscdev.name = DRIVER_NAME;
+	miscdev.minor = MISC_DYNAMIC_MINOR;
+	miscdev.fops = &tdx_attest_fops;
+	miscdev.parent = dev;
+
+	ret = misc_register(&miscdev);
+	if (ret) {
+		pr_err("misc device registration failed\n");
+		goto failed;
+	}
+
+	pr_debug("module initialization success\n");
+
+	return 0;
+
+failed:
+	misc_deregister(&miscdev);
+
+	pr_debug("module initialization failed\n");
+
+	return ret;
+}
+
+static int tdx_attest_remove(struct platform_device *attest_pdev)
+{
+	misc_deregister(&miscdev);
+	pr_debug("module is successfully removed\n");
+	return 0;
+}
+
+static struct platform_driver tdx_attest_driver = {
+	.probe		= tdx_attest_probe,
+	.remove		= tdx_attest_remove,
+	.driver		= {
+		.name	= DRIVER_NAME,
+	},
+};
+
+static int __init tdx_attest_init(void)
+{
+	int ret;
+
+	/* Make sure we are in a valid TDX platform */
+	if (!cpu_feature_enabled(X86_FEATURE_TDX_GUEST))
+		return -EIO;
+
+	ret = platform_driver_register(&tdx_attest_driver);
+	if (ret) {
+		pr_err("failed to register driver, err=%d\n", ret);
+		return ret;
+	}
+
+	pdev = platform_device_register_simple(DRIVER_NAME, -1, NULL, 0);
+	if (IS_ERR(pdev)) {
+		ret = PTR_ERR(pdev);
+		pr_err("failed to allocate device, err=%d\n", ret);
+		platform_driver_unregister(&tdx_attest_driver);
+		return ret;
+	}
+
+	return 0;
+}
+
+static void __exit tdx_attest_exit(void)
+{
+	platform_device_unregister(pdev);
+	platform_driver_unregister(&tdx_attest_driver);
+}
+
+module_init(tdx_attest_init);
+module_exit(tdx_attest_exit);
+
+MODULE_AUTHOR("Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>");
+MODULE_DESCRIPTION("TDX attestation driver");
+MODULE_LICENSE("GPL");
diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 03deb4d6920d..2a79ca92a52d 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -11,10 +11,12 @@
 #include <asm/insn.h>
 #include <asm/insn-eval.h>
 #include <asm/pgtable.h>
+#include <asm/io.h>
 
 /* TDX module Call Leaf IDs */
 #define TDX_GET_INFO			1
 #define TDX_GET_VEINFO			3
+#define TDX_GET_REPORT			4
 #define TDX_ACCEPT_PAGE			6
 
 /* TDX hypercall Leaf IDs */
@@ -34,6 +36,10 @@
 #define VE_GET_PORT_NUM(e)	((e) >> 16)
 #define VE_IS_IO_STRING(e)	((e) & BIT(4))
 
+/* TDX Module call error codes */
+#define TDCALL_RETURN_CODE_MASK		0xffffffff00000000
+#define TDCALL_RETURN_CODE(a)		((a) & TDCALL_RETURN_CODE_MASK)
+
 /*
  * Wrapper for standard use of __tdx_hypercall with no output aside from
  * return code.
@@ -98,6 +104,45 @@ static inline void tdx_module_call(u64 fn, u64 rcx, u64 rdx, u64 r8, u64 r9,
 		panic("TDCALL %lld failed (Buggy TDX module!)\n", fn);
 }
 
+/*
+ * tdx_mcall_tdreport() - Generate TDREPORT_STRUCT using TDCALL.
+ *
+ * @data        : Address of 1024B aligned data to store
+ *                TDREPORT_STRUCT.
+ * @reportdata  : Address of 64B aligned report data
+ *
+ * return 0 on success or failure error number.
+ */
+long tdx_mcall_tdreport(void *data, void *reportdata)
+{
+	u64 ret;
+
+	/*
+	 * Check for a valid TDX guest to ensure this API is only
+	 * used by TDX guest platform. Also make sure "data" and
+	 * "reportdata" pointers are valid.
+	 */
+	if (!data || !reportdata || !cpu_feature_enabled(X86_FEATURE_TDX_GUEST))
+		return -EINVAL;
+
+	/*
+	 * Pass the physical address of user generated report data
+	 * and the physical address of output buffer to the TDX module
+	 * to generate the TD report. Generated data contains
+	 * measurements/configuration data of the TD guest. More info
+	 * about ABI can be found in TDX 1.0 Module specification, sec
+	 * titled "TDG.MR.REPORT".
+	 */
+	ret = __tdx_module_call(TDX_GET_REPORT, virt_to_phys(data),
+				virt_to_phys(reportdata), 0, 0, NULL);
+
+	if (ret)
+		return TDCALL_RETURN_CODE(ret);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(tdx_mcall_tdreport);
+
 static u64 get_cc_mask(void)
 {
 	struct tdx_module_output out;
diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index 020c81a7c729..a151f69dd6ef 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -67,6 +67,8 @@ void tdx_safe_halt(void);
 
 bool tdx_early_handle_ve(struct pt_regs *regs);
 
+long tdx_mcall_tdreport(void *data, void *reportdata);
+
 #else
 
 static inline void tdx_early_init(void) { };
diff --git a/arch/x86/include/uapi/asm/tdx.h b/arch/x86/include/uapi/asm/tdx.h
new file mode 100644
index 000000000000..c21f9d6fe88b
--- /dev/null
+++ b/arch/x86/include/uapi/asm/tdx.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _UAPI_ASM_X86_TDX_H
+#define _UAPI_ASM_X86_TDX_H
+
+#include <linux/types.h>
+#include <linux/ioctl.h>
+
+/* Input report data length for TDX_CMD_GET_TDREPORT IOCTL request */
+#define TDX_REPORT_DATA_LEN		64
+
+/* Output TD report data length after TDX_CMD_GET_TDREPORT IOCTL execution */
+#define TDX_TDREPORT_LEN		1024
+
+/*
+ * TDX_CMD_GET_TDREPORT IOCTL is used to get TDREPORT data from the TDX
+ * Module. Users should pass report data of size TDX_REPORT_DATA_LEN bytes
+ * via user input buffer of size TDX_TDREPORT_LEN. Once IOCTL is successful
+ * TDREPORT data is copied to the user buffer. On failure, TDCALL error
+ * code is copied back to the user buffer.
+ */
+#define TDX_CMD_GET_TDREPORT		_IOWR('T', 0x01, __u64)
+
+#endif /* _UAPI_ASM_X86_TDX_H */
-- 
2.25.1

