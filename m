Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D82B55030EB
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 01:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238272AbiDOWER (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 18:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356279AbiDOWEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 18:04:05 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CF843A723;
        Fri, 15 Apr 2022 15:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650060094; x=1681596094;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vymGa2uYsRtZ2q7z3TTqcP9ARcW12kzwr1nbT+PSPeE=;
  b=Wtj8HZQgeUxo8pU3/J0eylwHTVQjzYk+cM3xHBDhiOVcT06e7pzQpeLb
   pDnIoDAo+OXJYAwQNCdSEOUEEnkE8fEEh1LtTYcKJYb/F8dJ7W1Oppl4w
   wIsKdUdcFPSXE3zleXI+92esx94A1AoImFh3bwUfbN0q1X4mh9Fp45Lsv
   RSZ11tB2kI81s+TqOHh5CzGCkqJ4+x9SsYqP2/T8Xme2JZMPR7Dulb3zz
   fQ+Tavx5nm8F7gkq7jWghYDTFdNTRCI2oPG+TvC1q7t+j/fY8ZWKREnl5
   AOt3kszTdQSXiSgpIQPSW7aj0DTIcsM4KDHnw/hO3v7bkbozVnT1z3nJH
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10318"; a="288303537"
X-IronPort-AV: E=Sophos;i="5.90,263,1643702400"; 
   d="scan'208";a="288303537"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2022 15:01:32 -0700
X-IronPort-AV: E=Sophos;i="5.90,263,1643702400"; 
   d="scan'208";a="612949103"
Received: from smashtou-mobl1.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.212.128.210])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2022 15:01:31 -0700
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>
Cc:     "H . Peter Anvin" <hpa@zytor.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH v3 4/4] platform/x86: intel_tdx_attest: Add TDX Guest attestation interface driver
Date:   Fri, 15 Apr 2022 15:01:09 -0700
Message-Id: <20220415220109.282834-5-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220415220109.282834-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20220415220109.282834-1-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TDX guest supports encrypted disk as root or secondary drives.
Decryption keys required to access such drives are usually maintained
by 3rd party key servers. Attestation is required by 3rd party key
servers to get the key for an encrypted disk volume, or possibly other
encrypted services. Attestation is used to prove to the key server that
the TD guest is running in a valid TD and the kernel and virtual BIOS
and other environment are secure.

During the boot process various components before the kernel accumulate
hashes in the TDX module, which can then combined into a report. This
would typically include a hash of the bios, bios configuration, boot
loader, command line, kernel, initrd.  After checking the hashes the
key server will securely release the keys.

The actual details of the attestation protocol depend on the particular
key server configuration, but some parts are common and need to
communicate with the TDX module.

This communication is implemented in the attestation driver.

The supported steps are:

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

Attestation agent uses IOCTLs implemented by the attestation driver to
complete the various steps of the attestation process.

Also note that, explicit access permissions are not enforced in this
driver because the quote and measurements are not a secret. However
the access permissions of the device node can be used to set any
desired access policy. The udev default is usually root access
only.

TDX_CMD_GEN_QUOTE IOCTL can be used to create an computation on the
host, but TDX assumes that the host is able to deal with malicious
guest flooding it anyways.

The interaction with the TDX module is like a RPM protocol here. There
are several operations (get tdreport, get quote) that need to input a
blob, and then output another blob. It was considered to use a sysfs
interface for this, but it doesn't fit well into the standard sysfs
model for configuring values. It would be possible to do read/write on
files, but it would need multiple file descriptors, which would be
somewhat messy. ioctls seems to be the best fitting and simplest model
here. There is one ioctl per operation, that takes the input blob and
returns the output blob, and as well as auxiliary ioctls to return the
blob lengths. The ioctls are documented in the header file. 

[Chenyi Qiang: Proposed struct tdx_gen_quote for passing user buffer]
Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Acked-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---

Changes since v2:
 * Combined attestation related global variables into
   struct attest_dev to make the code clean.
 * Added support to pass TDREPORT and GetQuote TDCALLs
   error code back to user on failure.
 * Modified the driver to use platform device driver
   model and added check to ensure only one device is
   allowed.

 drivers/platform/x86/intel/Kconfig            |   2 +-
 drivers/platform/x86/intel/Makefile           |   1 +
 drivers/platform/x86/intel/tdx/Kconfig        |  13 +
 drivers/platform/x86/intel/tdx/Makefile       |   3 +
 .../platform/x86/intel/tdx/intel_tdx_attest.c | 302 ++++++++++++++++++
 include/uapi/misc/tdx.h                       |  42 +++
 6 files changed, 362 insertions(+), 1 deletion(-)
 create mode 100644 drivers/platform/x86/intel/tdx/Kconfig
 create mode 100644 drivers/platform/x86/intel/tdx/Makefile
 create mode 100644 drivers/platform/x86/intel/tdx/intel_tdx_attest.c
 create mode 100644 include/uapi/misc/tdx.h

diff --git a/drivers/platform/x86/intel/Kconfig b/drivers/platform/x86/intel/Kconfig
index 1f01a8a23c57..a2e2a5a29bde 100644
--- a/drivers/platform/x86/intel/Kconfig
+++ b/drivers/platform/x86/intel/Kconfig
@@ -12,7 +12,7 @@ source "drivers/platform/x86/intel/speed_select_if/Kconfig"
 source "drivers/platform/x86/intel/telemetry/Kconfig"
 source "drivers/platform/x86/intel/wmi/Kconfig"
 source "drivers/platform/x86/intel/uncore-frequency/Kconfig"
-
+source "drivers/platform/x86/intel/tdx/Kconfig"
 
 config INTEL_HID_EVENT
 	tristate "Intel HID Event"
diff --git a/drivers/platform/x86/intel/Makefile b/drivers/platform/x86/intel/Makefile
index c61bc3e97121..6b7c94051519 100644
--- a/drivers/platform/x86/intel/Makefile
+++ b/drivers/platform/x86/intel/Makefile
@@ -10,6 +10,7 @@ obj-$(CONFIG_INTEL_SKL_INT3472)		+= int3472/
 obj-$(CONFIG_INTEL_PMC_CORE)		+= pmc/
 obj-$(CONFIG_INTEL_PMT_CLASS)		+= pmt/
 obj-$(CONFIG_INTEL_SPEED_SELECT_INTERFACE) += speed_select_if/
+obj-$(CONFIG_INTEL_TDX_GUEST)		+= tdx/
 obj-$(CONFIG_INTEL_TELEMETRY)		+= telemetry/
 obj-$(CONFIG_INTEL_WMI)			+= wmi/
 obj-$(CONFIG_INTEL_UNCORE_FREQ_CONTROL)	+= uncore-frequency/
diff --git a/drivers/platform/x86/intel/tdx/Kconfig b/drivers/platform/x86/intel/tdx/Kconfig
new file mode 100644
index 000000000000..332a10313b49
--- /dev/null
+++ b/drivers/platform/x86/intel/tdx/Kconfig
@@ -0,0 +1,13 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# X86 TDX Platform Specific Drivers
+#
+
+config INTEL_TDX_ATTESTATION
+	tristate "Intel TDX attestation driver"
+	depends on INTEL_TDX_GUEST
+	help
+	  The TDX attestation driver provides IOCTL interfaces to the user to
+	  request TDREPORT from the TDX module or request quote from the VMM
+	  or to get quote buffer size. It is mainly used to get secure disk
+	  decryption keys from the key server.
diff --git a/drivers/platform/x86/intel/tdx/Makefile b/drivers/platform/x86/intel/tdx/Makefile
new file mode 100644
index 000000000000..94eea6108fbd
--- /dev/null
+++ b/drivers/platform/x86/intel/tdx/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_INTEL_TDX_ATTESTATION)	+= intel_tdx_attest.o
diff --git a/drivers/platform/x86/intel/tdx/intel_tdx_attest.c b/drivers/platform/x86/intel/tdx/intel_tdx_attest.c
new file mode 100644
index 000000000000..9124db800d4f
--- /dev/null
+++ b/drivers/platform/x86/intel/tdx/intel_tdx_attest.c
@@ -0,0 +1,302 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * intel_tdx_attest.c - TDX guest attestation interface driver.
+ *
+ * Implements user interface to trigger attestation process and
+ * read the TD Quote result.
+ *
+ * Copyright (C) 2021-2022 Intel Corporation
+ *
+ * Author:
+ *     Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
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
+#include <uapi/misc/tdx.h>
+
+#define DRIVER_NAME "tdx-attest"
+
+/* Used in Quote memory allocation */
+#define QUOTE_SIZE			(2 * PAGE_SIZE)
+/* Used in Get Quote request memory allocation */
+#define GET_QUOTE_MAX_SIZE		(4 * PAGE_SIZE)
+/* Get Quote timeout in msec */
+#define GET_QUOTE_TIMEOUT		(5000)
+
+struct attest_dev {
+	/* Mutex to serialize attestation requests */
+	struct mutex lock;
+	/* Completion object to track GetQuote completion status */
+	struct completion req_compl;
+	/* Buffer used to copy report data in attestation handler */
+	u8 report_buf[TDX_REPORT_DATA_LEN] __aligned(64);
+	/* Data pointer used to get TD Quote data in attestation handler */
+	void *tdquote_buf;
+	/* Data pointer used to get TDREPORT data in attestation handler */
+	void *tdreport_buf;
+	/* DMA handle used to allocate and free tdquote DMA buffer */
+	dma_addr_t handle;
+	struct miscdevice miscdev;
+};
+
+static struct platform_device *pdev;
+
+static void attestation_callback_handler(void)
+{
+	struct attest_dev *adev = platform_get_drvdata(pdev);
+
+	complete(&adev->req_compl);
+}
+
+static long tdx_attest_ioctl(struct file *file, unsigned int cmd,
+			     unsigned long arg)
+{
+	struct attest_dev *adev = platform_get_drvdata(pdev);
+	void __user *argp = (void __user *)arg;
+	struct tdx_gen_quote tdquote_req;
+	long ret = 0, err;
+
+	mutex_lock(&adev->lock);
+
+	switch (cmd) {
+	case TDX_CMD_GET_TDREPORT:
+		if (copy_from_user(adev->report_buf, argp,
+					TDX_REPORT_DATA_LEN)) {
+			ret = -EFAULT;
+			break;
+		}
+
+		/* Generate TDREPORT_STRUCT */
+		err = tdx_mcall_tdreport(adev->tdreport_buf, adev->report_buf);
+		if (err) {
+			ret = put_user(err, (long __user *)argp);
+			ret = -EIO;
+			break;
+		}
+
+		if (copy_to_user(argp, adev->tdreport_buf, TDX_TDREPORT_LEN))
+			ret = -EFAULT;
+		break;
+	case TDX_CMD_GEN_QUOTE:
+		reinit_completion(&adev->req_compl);
+
+		/* Copy TDREPORT data from user buffer */
+		if (copy_from_user(&tdquote_req, argp, sizeof(struct tdx_gen_quote))) {
+			ret = -EFAULT;
+			break;
+		}
+
+		if (tdquote_req.len <= 0 || tdquote_req.len > GET_QUOTE_MAX_SIZE) {
+			ret = -EINVAL;
+			break;
+		}
+
+		if (copy_from_user(adev->tdquote_buf, (void __user *)tdquote_req.buf,
+					tdquote_req.len)) {
+			ret = -EFAULT;
+			break;
+		}
+
+		/* Submit GetQuote Request */
+		err = tdx_hcall_get_quote(adev->tdquote_buf, GET_QUOTE_MAX_SIZE);
+		if (err) {
+			ret = put_user(err, (long __user *)argp);
+			ret = -EIO;
+			break;
+		}
+
+		/* Wait for attestation completion */
+		ret = wait_for_completion_interruptible_timeout(
+				&adev->req_compl,
+				msecs_to_jiffies(GET_QUOTE_TIMEOUT));
+		if (ret <= 0) {
+			ret = -EIO;
+			break;
+		}
+
+		/* ret will be positive if completed. */
+		ret = 0;
+
+		if (copy_to_user((void __user *)tdquote_req.buf, adev->tdquote_buf,
+					tdquote_req.len))
+			ret = -EFAULT;
+
+		break;
+	case TDX_CMD_GET_QUOTE_SIZE:
+		ret = put_user(QUOTE_SIZE, (u64 __user *)argp);
+		break;
+	default:
+		pr_err("cmd %d not supported\n", cmd);
+		break;
+	}
+
+	mutex_unlock(&adev->lock);
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
+/* Helper function to cleanup attestation related allocations */
+static void _tdx_attest_remove(struct attest_dev *adev)
+{
+	misc_deregister(&adev->miscdev);
+
+	tdx_remove_ev_notify_handler();
+
+	if (adev->tdquote_buf)
+		dma_free_coherent(&pdev->dev, GET_QUOTE_MAX_SIZE,
+				adev->tdquote_buf, adev->handle);
+
+	if (adev->tdreport_buf)
+		free_pages((unsigned long)adev->tdreport_buf, 0);
+
+	kfree(adev);
+}
+
+static int tdx_attest_probe(struct platform_device *attest_pdev)
+{
+	struct device *dev = &attest_pdev->dev;
+	struct attest_dev *adev;
+	long ret = 0;
+
+	/* Only single device is allowed */
+	if (pdev)
+		return -EBUSY;
+
+	adev = kzalloc(sizeof(*adev), GFP_KERNEL);
+	if (!adev)
+		return -ENOMEM;
+
+	mutex_init(&adev->lock);
+	init_completion(&adev->req_compl);
+	pdev = attest_pdev;
+	platform_set_drvdata(pdev, adev);
+
+	/*
+	 * tdreport_data needs to be 64-byte aligned.
+	 * Full page alignment is more than enough.
+	 */
+	adev->tdreport_buf = (void *)__get_free_pages(GFP_KERNEL | __GFP_ZERO,
+						      0);
+	if (!adev->tdreport_buf) {
+		ret = -ENOMEM;
+		goto failed;
+	}
+
+	ret = dma_set_coherent_mask(dev, DMA_BIT_MASK(64));
+	if (ret) {
+		pr_err("dma set coherent mask failed\n");
+		goto failed;
+	}
+
+	/* Allocate DMA buffer to get TDQUOTE data from the VMM */
+	adev->tdquote_buf = dma_alloc_coherent(dev, GET_QUOTE_MAX_SIZE,
+						&adev->handle,
+						GFP_KERNEL | __GFP_ZERO);
+	if (!adev->tdquote_buf) {
+		ret = -ENOMEM;
+		goto failed;
+	}
+
+	/* Register attestation event notify handler */
+	tdx_setup_ev_notify_handler(attestation_callback_handler);
+
+	adev->miscdev.name = DRIVER_NAME;
+	adev->miscdev.minor = MISC_DYNAMIC_MINOR;
+	adev->miscdev.fops = &tdx_attest_fops;
+	adev->miscdev.parent = dev;
+
+	ret = misc_register(&adev->miscdev);
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
+	_tdx_attest_remove(adev);
+
+	pr_debug("module initialization failed\n");
+
+	return ret;
+}
+
+static int tdx_attest_remove(struct platform_device *attest_pdev)
+{
+	struct attest_dev *adev = platform_get_drvdata(attest_pdev);
+
+	mutex_lock(&adev->lock);
+	_tdx_attest_remove(adev);
+	mutex_unlock(&adev->lock);
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
+MODULE_LICENSE("GPL v2");
diff --git a/include/uapi/misc/tdx.h b/include/uapi/misc/tdx.h
new file mode 100644
index 000000000000..9920f36c79fe
--- /dev/null
+++ b/include/uapi/misc/tdx.h
@@ -0,0 +1,42 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _UAPI_MISC_TDX_H
+#define _UAPI_MISC_TDX_H
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
+ * TDREPORT data is copied to the user buffer.
+ */
+#define TDX_CMD_GET_TDREPORT		_IOWR('T', 0x01, __u64)
+
+/*
+ * TDX_CMD_GEN_QUOTE IOCTL is used to request TD QUOTE from the VMM. User
+ * should pass TD report data of size TDX_TDREPORT_LEN bytes via user input
+ * buffer of quote size. Once IOCTL is successful quote data is copied back to
+ * the user buffer.
+ */
+#define TDX_CMD_GEN_QUOTE		_IOR('T', 0x02, __u64)
+
+/*
+ * TDX_CMD_GET_QUOTE_SIZE IOCTL is used to get the TD Quote size info in bytes.
+ * This will be used for determining the input buffer allocation size when
+ * using TDX_CMD_GEN_QUOTE IOCTL.
+ */
+#define TDX_CMD_GET_QUOTE_SIZE		_IOR('T', 0x03, __u64)
+
+struct tdx_gen_quote {
+	__u64 buf;
+	__u64 len;
+};
+
+#endif /* _UAPI_MISC_TDX_H */
-- 
2.25.1

