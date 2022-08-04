Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DDC158955C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 02:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237244AbiHDAeg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 20:34:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236904AbiHDAed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 20:34:33 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16341248FB
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 17:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659573272; x=1691109272;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=oAYWtI6yfLaGJLAiZp2/doF+k9ne/f77mF8s2wIbDl0=;
  b=RCBJArhmRbgyl0lS9UC09Y3NN4nDxMOuKKXfb04YA/0NQXoCB5oTIe5I
   Vj98YWQeRGb4w7RNl6dLBZIIgOunJoOUNCYmvaO8n3x8etcw1gsQ7uhNY
   hLvDr68EBHjP09MP0GVZCSKjbkMShmWi+hCgQmsdRV5eZyXa+ZWlJWZvf
   iIGPQ1D+Ff38eIHMH4YvJ9hmA3a2ID2EeSmwNSIzyooSrk34Xm6fuPPqG
   6Balr5yKw/HW3fwJDYstrrcrusvG1CWIQxiQc0xuhGjxEiV4gb1mJuctF
   oqOKQro/asgk6vm49K58P9AgFSci2Uxu3hynYF125QxSN6NcSutw8c64I
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10428"; a="272852987"
X-IronPort-AV: E=Sophos;i="5.93,214,1654585200"; 
   d="scan'208";a="272852987"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2022 17:34:31 -0700
X-IronPort-AV: E=Sophos;i="5.93,214,1654585200"; 
   d="scan'208";a="848764421"
Received: from lucasmye-mobl.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.209.42.231])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2022 17:34:30 -0700
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
Subject: [PATCH v10 1/2] x86/tdx: Add TDX Guest attestation interface driver
Date:   Wed,  3 Aug 2022 17:33:22 -0700
Message-Id: <20220804003323.1441376-1-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
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
to other entities before provisioning secrets to the TD. Such attestation
process is required by 3rd party servers before sending sensitive
information to TD guests. One usage example is to get encryption keys
from the key server for mounting the encrypted rootfs or secondary drive.

During the TD launch, the initial contents and configuration of the TD
are recorded by the Intel TDX module in build time measurement register
(MRTD). It is a SHA384 digest created using data from TD private pages(
including TD firmware) and the configuration of the TD.

After TD build, run-time measurement registers (RTMRs)  can be used by
the guest TD software to extend the TD measurements. TDX supports 4
RTMR registers, and TDG.MR.RTMR.EXTEND TDCALL is used to update the
RTMR registers securely. RTMRs are mainly used to record measurements
related to sections like the kernel image, command line parameters,
initrd, ACPI tables, firmware data, configuration firmware volume (CFV)
of TDVF, etc. For more details, please refer to TDX Virtual Firmware
design specification, sec titled "TD Measurement".

At TD runtime, the Intel TDX module reuses the Intel SGX attestation
infrastructure to provide support for attesting to these measurements
as described below.

The attestation process consists of two steps: TDREPORT generation and
Quote generation.

TDREPORT (TDREPORT_STRUCT) is a fixed-size data structure generated by
the TDX module which contains TD-specific information (such as TD
measurements), platform security version, and the MAC to protect the
integrity of the TDREPORT. The TD kernel uses TDCALL[TDG.MR.REPORT] to
get the TDREPORT from the TDX module. A user-provided 64-Byte
REPORTDATA is used as input and included in the TDREPORT. Typically it
can be some nonce provided by attestation service so the TDREPORT can
be verified uniquely. More details about TDREPORT can be found in
Intel TDX Module specification, section titled "TDG.MR.REPORT Leaf".

TDREPORT by design can only be verified on local platform as the MAC
key is bound to the platform. To support remote verification of the
TDREPORT, TDX leverages Intel SGX Quote Enclave (QE) to verify the
TDREPORT locally and convert it to a remote verifiable Quote.

After getting the TDREPORT, the second step of the attestation process
is to send it to the QE to generate the Quote. TDX doesn't support SGX
inside the TD, so the QE can be deployed in the host, or in another
legacy VM with SGX support. QE uses EVERIFYREPORT2 instruction to help
check the integrity of TDREPORT and if it is valid, a certified quote
signing key is used to sign the Quote. How to send the TDREPORT to QE
and receive the Quote is implementation and deployment specific.

Implement a basic TD guest misc driver to allow TD userspace to get the
TDREPORT. The TD userspace attestation software can get the TDREPORT
and then choose whatever communication channel available (i.e. vsock
or hypercall) to send the TDREPORT to QE and receive the Quote.

Also note that explicit access permissions are not enforced in this
driver because the quote and measurements are not a secret. However
the access permissions of the device node can be used to set any
desired access policy. The udev default is usually root access
only.

Operations like getting TDREPORT or Quote generation involves sending
a blob of data as input and getting another blob of data as output. It
was considered to use a sysfs interface for this, but it doesn't fit
well into the standard sysfs model for configuring values. It would be
possible to do read/write on files, but it would need multiple file
descriptors, which would be somewhat messy. IOCTLs seems to be the best
fitting and simplest model for this use case. This is similar to AMD
SEV platform, which also uses IOCTL interface to support attestation.

Any distribution enabling TDX is also expected to need attestation. So
enable it by default with TDX guest support.

Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Acked-by: Kai Huang <kai.huang@intel.com>
Acked-by: Wander Lairson Costa <wander@redhat.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---

Changes since v9:
 * Dropped the cover letter. Since this patch set only adds
   TDREPORT support, the commit log itself has all the required details.
 * Dropped the Quote support and event IRQ support as per Dave's
   review suggestion.
 * Dropped attest.c and moved its contents to tdx.c
 * Updated commit log and comments to reflect latest changes.

Changes since v8:
 * Please refer to https://lore.kernel.org/all/ \
   20220728034420.648314-1-sathyanarayanan.kuppuswamy@linux.intel.com/

 arch/x86/coco/tdx/tdx.c         | 117 ++++++++++++++++++++++++++++++++
 arch/x86/include/uapi/asm/tdx.h |  51 ++++++++++++++
 2 files changed, 168 insertions(+)
 create mode 100644 arch/x86/include/uapi/asm/tdx.h

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 928dcf7a20d9..3abb3d1daa9e 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -5,16 +5,21 @@
 #define pr_fmt(fmt)     "tdx: " fmt
 
 #include <linux/cpufeature.h>
+#include <linux/miscdevice.h>
+#include <linux/mm.h>
+#include <linux/io.h>
 #include <asm/coco.h>
 #include <asm/tdx.h>
 #include <asm/vmx.h>
 #include <asm/insn.h>
 #include <asm/insn-eval.h>
 #include <asm/pgtable.h>
+#include <uapi/asm/tdx.h>
 
 /* TDX module Call Leaf IDs */
 #define TDX_GET_INFO			1
 #define TDX_GET_VEINFO			3
+#define TDX_GET_REPORT			4
 #define TDX_ACCEPT_PAGE			6
 
 /* TDX hypercall Leaf IDs */
@@ -34,6 +39,10 @@
 #define VE_GET_PORT_NUM(e)	((e) >> 16)
 #define VE_IS_IO_STRING(e)	((e) & BIT(4))
 
+#define DRIVER_NAME	"tdx-guest"
+
+static struct miscdevice tdx_misc_dev;
+
 /*
  * Wrapper for standard use of __tdx_hypercall with no output aside from
  * return code.
@@ -775,3 +784,111 @@ void __init tdx_early_init(void)
 
 	pr_info("Guest detected\n");
 }
+
+static long tdx_get_report(void __user *argp)
+{
+	u8 *reportdata = NULL, *tdreport = NULL;
+	struct tdx_report_req req;
+	long ret;
+
+	/* Copy request struct from the user buffer */
+	if (copy_from_user(&req, argp, sizeof(req)))
+		return -EFAULT;
+
+	/*
+	 * Per TDX Module 1.0 specification, section titled
+	 * "TDG.MR.REPORT", REPORTDATA and TDREPORT length
+	 * is fixed as TDX_REPORTDATA_LEN and TDX_REPORT_LEN.
+	 */
+	if (req.rpd_len != TDX_REPORTDATA_LEN || req.tdr_len != TDX_REPORT_LEN)
+		return -EINVAL;
+
+	/* Allocate kernel buffers for REPORTDATA and TDREPORT */
+	reportdata = kzalloc(req.rpd_len, GFP_KERNEL);
+	if (!reportdata) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	tdreport = kzalloc(req.tdr_len, GFP_KERNEL);
+	if (!tdreport) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+
+	/* Copy REPORTDATA from user to kernel buffer */
+	if (copy_from_user(reportdata, (void *)req.reportdata, req.rpd_len)) {
+		ret = -EFAULT;
+		goto out;
+	}
+
+	/*
+	 * Generate TDREPORT using "TDG.MR.REPORT" TDCALL.
+	 *
+	 * Get the TDREPORT using REPORTDATA as input. Refer to
+	 * section 22.3.3 TDG.MR.REPORT leaf in the TDX Module 1.0
+	 * Specification for detailed information.
+	 */
+	ret = __tdx_module_call(TDX_GET_REPORT, virt_to_phys(tdreport),
+				virt_to_phys(reportdata), req.subtype,
+				0, NULL);
+	if (ret) {
+		ret = -EIO;
+		goto out;
+	}
+
+	/* Copy TDREPORT data back to the user buffer */
+	if (copy_to_user((void *)req.tdreport, tdreport, req.tdr_len))
+		ret = -EFAULT;
+
+out:
+	kfree(reportdata);
+	kfree(tdreport);
+	return ret;
+}
+static long tdx_guest_ioctl(struct file *file, unsigned int cmd,
+			    unsigned long arg)
+{
+	void __user *argp = (void __user *)arg;
+	long ret = -EINVAL;
+
+	switch (cmd) {
+	case TDX_CMD_GET_REPORT:
+		ret = tdx_get_report(argp);
+		break;
+	default:
+		pr_debug("cmd %d not supported\n", cmd);
+		break;
+	}
+
+	return ret;
+}
+
+static const struct file_operations tdx_guest_fops = {
+	.owner		= THIS_MODULE,
+	.unlocked_ioctl	= tdx_guest_ioctl,
+	.llseek		= no_llseek,
+};
+
+static int __init tdx_guest_init(void)
+{
+	int ret;
+
+	/* Make sure we are in a valid TDX platform */
+	if (!cpu_feature_enabled(X86_FEATURE_TDX_GUEST))
+		return -EIO;
+
+	tdx_misc_dev.name = DRIVER_NAME;
+	tdx_misc_dev.minor = MISC_DYNAMIC_MINOR;
+	tdx_misc_dev.fops = &tdx_guest_fops;
+
+	ret = misc_register(&tdx_misc_dev);
+	if (ret) {
+		pr_err("misc device registration failed\n");
+		return ret;
+	}
+
+	return 0;
+}
+device_initcall(tdx_guest_init)
diff --git a/arch/x86/include/uapi/asm/tdx.h b/arch/x86/include/uapi/asm/tdx.h
new file mode 100644
index 000000000000..c1667b20fe20
--- /dev/null
+++ b/arch/x86/include/uapi/asm/tdx.h
@@ -0,0 +1,51 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _UAPI_ASM_X86_TDX_H
+#define _UAPI_ASM_X86_TDX_H
+
+#include <linux/types.h>
+#include <linux/ioctl.h>
+
+/* Length of the REPORTDATA used in TDG.MR.REPORT TDCALL */
+#define TDX_REPORTDATA_LEN              64
+
+/* Length of TDREPORT used in TDG.MR.REPORT TDCALL */
+#define TDX_REPORT_LEN                  1024
+
+/**
+ * struct tdx_report_req: Get TDREPORT using REPORTDATA as input.
+ *
+ * @subtype        : Subtype of TDREPORT (fixed as 0 by TDX Module
+ *                   specification, but added a parameter to handle
+ *                   future extension).
+ * @reportdata     : User-defined REPORTDATA to be included into
+ *                   TDREPORT. Typically it can be some nonce
+ *                   provided by attestation service, so the
+ *                   generated TDREPORT can be uniquely verified.
+ * @rpd_len        : Length of the REPORTDATA (fixed as 64 bytes by
+ *                   the TDX Module specification, but parameter is
+ *                   added to handle future extension).
+ * @tdreport       : TDREPORT output from TDCALL[TDG.MR.REPORT].
+ * @tdr_len        : Length of the TDREPORT (fixed as 1024 bytes by
+ *                   the TDX Module specification, but a parameter
+ *                   is added to accommodate future extension).
+ *
+ * Used in TDX_CMD_GET_REPORT IOCTL request.
+ */
+struct tdx_report_req {
+	__u8  subtype;
+	__u64 reportdata;
+	__u32 rpd_len;
+	__u64 tdreport;
+	__u32 tdr_len;
+};
+
+/*
+ * TDX_CMD_GET_REPORT - Get TDREPORT using TDCALL[TDG.MR.REPORT]
+ *
+ * Return 0 on success, -EIO on TDCALL execution failure, and
+ * standard errno on other general error cases.
+ *
+ */
+#define TDX_CMD_GET_REPORT		_IOWR('T', 0x01, __u64)
+
+#endif /* _UAPI_ASM_X86_TDX_H */
-- 
2.25.1

