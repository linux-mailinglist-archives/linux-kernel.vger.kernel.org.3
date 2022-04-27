Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B902B512512
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 00:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231336AbiD0WMA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 18:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbiD0WL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 18:11:58 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EEDC49C80
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 15:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651097326; x=1682633326;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=K9zadYWnmpx9cxtn4FnFOm+TaV+3STwQq0KZFxAFUKE=;
  b=cG2OReHdIxoDdlF/t7DOsOuGFlPuPmE/2+UQ/VLYclazzzI3ilQjZNTM
   cD/ru9kar2E3uukbS2mjz7GiWmL/EouI9UnlLv1tigkll8vkyz3e1eLI6
   8Eih9Nlroai3NvOvWV/Zeja8uXXRaUHDH56JiTpcjfqi/j4pd2h8c0xHt
   IT01Ocz6UC5fn+gc6TXHDaizparRawnImrZk06e1tsvBWGpKi4wompO+e
   xfzlQGUxFZ1wVfzrvsaiIlLEQNLS3UguqOrAoF7HVQ66QKs4mQVHVfIRc
   s0XkXc2iQXgnWaaC8ZMxb6PlJwngTEZ3q2fhIHdxis2hbHqdiT2BLLM2d
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10330"; a="329026087"
X-IronPort-AV: E=Sophos;i="5.90,294,1643702400"; 
   d="scan'208";a="329026087"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2022 15:08:45 -0700
X-IronPort-AV: E=Sophos;i="5.90,294,1643702400"; 
   d="scan'208";a="731034339"
Received: from leeyongj-mobl1.amr.corp.intel.com (HELO [10.212.138.148]) ([10.212.138.148])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2022 15:08:45 -0700
Message-ID: <fd8c663e-eca4-8413-464e-2d7f9d685f36@linux.intel.com>
Date:   Wed, 27 Apr 2022 15:08:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.7.0
Subject: Re: [PATCH v4 1/3] x86/tdx: Add TDX Guest attestation interface
 driver
Content-Language: en-US
To:     Isaku Yamahata <isaku.yamahata@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kai Huang <kai.huang@intel.com>, linux-kernel@vger.kernel.org
References: <20220422233418.1203092-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20220422233418.1203092-2-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20220427054523.GA4167861@ls.amr.corp.intel.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20220427054523.GA4167861@ls.amr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Isaku,

On 4/26/22 10:45 PM, Isaku Yamahata wrote:
> On Fri, Apr 22, 2022 at 04:34:16PM -0700,
> Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
> 
>> In TDX guest, attestation is used to verify the trustworthiness of a TD
>> to other entities before making any secure communication.
>>
>> One usage example is, when a TD guest uses encrypted drive and the
>> decryption keys required to access the drive are stored in a secure
>> 3rd party keyserver, TD guest can use the quote generated via the
>> attestation process to prove its trustworthiness with keyserver and
>> get access to the storage keys.
>>
>> General steps involved in attestation process are,
>>
>>    1. TD guest generates the TDREPORT that contains version information
>>       about the Intel TDX module, measurement of the TD, along with a
>>       TD-specified nonce.
>>    2. TD guest shares the TDREPORT with TD host via GetQuote hypercall
>>       which is used by the host to generate a quote via quoting
>>       enclave (QE).
>>    3. Quote generation completion notification is sent to TD OS via
>>       callback interrupt vector configured by TD using
>>       SetupEventNotifyInterrupt hypercall.
>>    4. After receiving the generated TDQUOTE, a remote verifier can be
>>       used to verify the quote and confirm the trustworthiness of the
>>       TD.
>>       
>> More details on above mentioned steps can be found in TDX Guest-Host
>> Communication Interface (GHCI) for Intel TDX 1.0, section titled
>> "TD attestation".
>>
>> To allow the attestation agent (user application) to implement this
>> feature, add an IOCTL interface to get TDREPORT and TDQUOTE from the
>> user space. Since attestation agent can also use methods like vosck or
>> TCP/IP to get the TDQUOTE, adding an IOCTL interface for it is an
>> optional feature. So to simplify the driver, first add support for
>> TDX_CMD_GET_TDREPORT IOCTL. Support for TDQUOTE IOCTL will be added by
>> follow-on patches.
>>
>> TDREPORT can be generated by sending a TDCALL with leaf ID as 0x04.
>> More details about the TDREPORT TDCALL can be found in Intel Trust
>> Domain Extensions (Intel TDX) Module specification, section titled
>> "TDG.MR.REPORT Leaf". Add a wrapper function (tdx_mcall_tdreport())
>> to get the TDREPORT from the TDX Module. This API will be used by the
>> interface driver to request for TDREPORT.
>>
>> Also note that explicit access permissions are not enforced in this
>> driver because the quote and measurements are not a secret. However
>> the access permissions of the device node can be used to set any
>> desired access policy. The udev default is usually root access
>> only.
>>
>> Reviewed-by: Tony Luck <tony.luck@intel.com>
>> Reviewed-by: Andi Kleen <ak@linux.intel.com>
>> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>> ---
>>   arch/x86/coco/tdx/Makefile      |   2 +-
>>   arch/x86/coco/tdx/attest.c      | 191 ++++++++++++++++++++++++++++++++
>>   arch/x86/coco/tdx/tdx.c         |  45 ++++++++
>>   arch/x86/include/asm/tdx.h      |   2 +
>>   arch/x86/include/uapi/asm/tdx.h |  23 ++++
>>   5 files changed, 262 insertions(+), 1 deletion(-)
>>   create mode 100644 arch/x86/coco/tdx/attest.c
>>   create mode 100644 arch/x86/include/uapi/asm/tdx.h
>>
>> diff --git a/arch/x86/coco/tdx/Makefile b/arch/x86/coco/tdx/Makefile
>> index 46c55998557d..d2db3e6770e5 100644
>> --- a/arch/x86/coco/tdx/Makefile
>> +++ b/arch/x86/coco/tdx/Makefile
>> @@ -1,3 +1,3 @@
>>   # SPDX-License-Identifier: GPL-2.0
>>   
>> -obj-y += tdx.o tdcall.o
>> +obj-y += tdx.o tdcall.o attest.o
>> diff --git a/arch/x86/coco/tdx/attest.c b/arch/x86/coco/tdx/attest.c
>> new file mode 100644
>> index 000000000000..b776e81f6c20
>> --- /dev/null
>> +++ b/arch/x86/coco/tdx/attest.c
>> @@ -0,0 +1,191 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * attest.c - TDX guest attestation interface driver.
>> + *
>> + * Implements user interface to trigger attestation process and
>> + * read the TD Quote result.
>> + *
>> + * Copyright (C) 2022 Intel Corporation
>> + *
>> + */
>> +
>> +#define pr_fmt(fmt) "x86/tdx: attest: " fmt
>> +
>> +#include <linux/module.h>
>> +#include <linux/miscdevice.h>
>> +#include <linux/uaccess.h>
>> +#include <linux/fs.h>
>> +#include <linux/mm.h>
>> +#include <linux/slab.h>
>> +#include <linux/set_memory.h>
>> +#include <linux/dma-mapping.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/jiffies.h>
>> +#include <linux/io.h>
>> +#include <asm/apic.h>
>> +#include <asm/tdx.h>
>> +#include <asm/irq_vectors.h>
>> +#include <uapi/asm/tdx.h>
>> +
>> +#define DRIVER_NAME "tdx-attest"
>> +
>> +static struct platform_device *pdev;
>> +static struct miscdevice miscdev;
>> +
>> +static long tdx_get_tdreport(void __user *argp)
>> +{
>> +	void *report_buf = NULL, *tdreport_buf = NULL;
>> +	long ret = 0, err;
>> +
>> +	/* Allocate space for report data */
>> +	report_buf = kmalloc(TDX_REPORT_DATA_LEN, GFP_KERNEL);
>> +	if (!report_buf)
>> +		return -ENOMEM;
>> +
>> +	/*
>> +	 * Allocate space for TDREPORT buffer (1024-byte aligned).
>> +	 * Full page alignment is more than enough.
>> +	 */
>> +	tdreport_buf = (void *)get_zeroed_page(GFP_KERNEL);
>> +	if (!tdreport_buf) {
>> +		ret = -ENOMEM;
>> +		goto tdreport_failed;
>> +	}
>> +
>> +	/* Copy report data to kernel buffer */
>> +	if (copy_from_user(report_buf, argp, TDX_REPORT_DATA_LEN)) {
>> +		ret = -EFAULT;
>> +		goto tdreport_failed;
>> +	}
>> +
>> +	/* Generate TDREPORT using report data in report_buf */
>> +	err = tdx_mcall_tdreport(tdreport_buf, report_buf);
>> +	if (err) {
>> +		/* If failed, pass TDCALL error code back to user */
>> +		ret = put_user(err, (long __user *)argp);
> 
> ret is ignored.  ret should be checked or ignore it explicitly by (void).

Since we are already in error path and we are going to return -EIO, I
did not  check for it. I will ignore it explictly in next version.


> 
> 
>> +		ret = -EIO;
>> +		goto tdreport_failed;
>> +	}
>> +
>> +	/* Copy TDREPORT data back to user buffer */
>> +	if (copy_to_user(argp, tdreport_buf, TDX_TDREPORT_LEN))
>> +		ret = -EFAULT;
>> +
>> +tdreport_failed:
>> +	kfree(report_buf);
>> +	if (tdreport_buf)
>> +		free_pages((unsigned long)tdreport_buf, 0);
>> +
>> +	return ret;
>> +}
>> +
>> +static long tdx_attest_ioctl(struct file *file, unsigned int cmd,
>> +			     unsigned long arg)
>> +{
>> +	void __user *argp = (void __user *)arg;
>> +	long ret = 0;
>> +
>> +	switch (cmd) {
>> +	case TDX_CMD_GET_TDREPORT:
>> +		ret = tdx_get_tdreport(argp);
>> +		break;
>> +	default:
>> +		pr_err("cmd %d not supported\n", cmd);
> 
> pr_debug()?  At least error should be returned to user space.

Ok. I will change it to pr_debug(). I have already addressed the
issue of not setting error value in default case.

> 
>> +		break;
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>> +static const struct file_operations tdx_attest_fops = {
>> +	.owner		= THIS_MODULE,
>> +	.unlocked_ioctl	= tdx_attest_ioctl,
>> +	.llseek		= no_llseek,
>> +};
>> +
>> +static int tdx_attest_probe(struct platform_device *attest_pdev)
>> +{
>> +	struct device *dev = &attest_pdev->dev;
>> +	long ret = 0;
>> +
>> +	/* Only single device is allowed */
>> +	if (pdev)
>> +		return -EBUSY;
>> +
>> +	pdev = attest_pdev;
>> +
>> +	miscdev.name = DRIVER_NAME;
>> +	miscdev.minor = MISC_DYNAMIC_MINOR;
>> +	miscdev.fops = &tdx_attest_fops;
>> +	miscdev.parent = dev;
>> +
>> +	ret = misc_register(&miscdev);
>> +	if (ret) {
>> +		pr_err("misc device registration failed\n");
>> +		goto failed;
>> +	}
>> +
>> +	pr_debug("module initialization success\n");
>> +
>> +	return 0;
>> +
>> +failed:
>> +	misc_deregister(&miscdev);
>> +
>> +	pr_debug("module initialization failed\n");
>> +
>> +	return ret;
>> +}
>> +
>> +static int tdx_attest_remove(struct platform_device *attest_pdev)
>> +{
>> +	misc_deregister(&miscdev);
>> +	pr_debug("module is successfully removed\n");
>> +	return 0;
>> +}
>> +
>> +static struct platform_driver tdx_attest_driver = {
>> +	.probe		= tdx_attest_probe,
>> +	.remove		= tdx_attest_remove,
>> +	.driver		= {
>> +		.name	= DRIVER_NAME,
>> +	},
>> +};
>> +
>> +static int __init tdx_attest_init(void)
>> +{
>> +	int ret;
>> +
>> +	/* Make sure we are in a valid TDX platform */
>> +	if (!cpu_feature_enabled(X86_FEATURE_TDX_GUEST))
>> +		return -EIO;
>> +
>> +	ret = platform_driver_register(&tdx_attest_driver);
>> +	if (ret) {
>> +		pr_err("failed to register driver, err=%d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	pdev = platform_device_register_simple(DRIVER_NAME, -1, NULL, 0);
>> +	if (IS_ERR(pdev)) {
>> +		ret = PTR_ERR(pdev);
>> +		pr_err("failed to allocate device, err=%d\n", ret);
>> +		platform_driver_unregister(&tdx_attest_driver);
>> +		return ret;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static void __exit tdx_attest_exit(void)
>> +{
>> +	platform_device_unregister(pdev);
>> +	platform_driver_unregister(&tdx_attest_driver);
>> +}
>> +
>> +module_init(tdx_attest_init);
>> +module_exit(tdx_attest_exit);
>> +
>> +MODULE_AUTHOR("Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>");
>> +MODULE_DESCRIPTION("TDX attestation driver");
>> +MODULE_LICENSE("GPL");
>> diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
>> index 03deb4d6920d..2a79ca92a52d 100644
>> --- a/arch/x86/coco/tdx/tdx.c
>> +++ b/arch/x86/coco/tdx/tdx.c
>> @@ -11,10 +11,12 @@
>>   #include <asm/insn.h>
>>   #include <asm/insn-eval.h>
>>   #include <asm/pgtable.h>
>> +#include <asm/io.h>
>>   
>>   /* TDX module Call Leaf IDs */
>>   #define TDX_GET_INFO			1
>>   #define TDX_GET_VEINFO			3
>> +#define TDX_GET_REPORT			4
>>   #define TDX_ACCEPT_PAGE			6
>>   
>>   /* TDX hypercall Leaf IDs */
>> @@ -34,6 +36,10 @@
>>   #define VE_GET_PORT_NUM(e)	((e) >> 16)
>>   #define VE_IS_IO_STRING(e)	((e) & BIT(4))
>>   
>> +/* TDX Module call error codes */
>> +#define TDCALL_RETURN_CODE_MASK		0xffffffff00000000
>> +#define TDCALL_RETURN_CODE(a)		((a) & TDCALL_RETURN_CODE_MASK)
>> +
>>   /*
>>    * Wrapper for standard use of __tdx_hypercall with no output aside from
>>    * return code.
>> @@ -98,6 +104,45 @@ static inline void tdx_module_call(u64 fn, u64 rcx, u64 rdx, u64 r8, u64 r9,
>>   		panic("TDCALL %lld failed (Buggy TDX module!)\n", fn);
>>   }
>>   
>> +/*
>> + * tdx_mcall_tdreport() - Generate TDREPORT_STRUCT using TDCALL.
>> + *
>> + * @data        : Address of 1024B aligned data to store
>> + *                TDREPORT_STRUCT.
>> + * @reportdata  : Address of 64B aligned report data
>> + *
>> + * return 0 on success or failure error number.
> 
> Is "failure error number" TDX status code? not -Evalue?

It is not -Evalue. I can use the term "TDX error code"

> 
> 
>> + */
>> +long tdx_mcall_tdreport(void *data, void *reportdata)
>> +{
>> +	u64 ret;
>> +
>> +	/*
>> +	 * Check for a valid TDX guest to ensure this API is only
>> +	 * used by TDX guest platform. Also make sure "data" and
>> +	 * "reportdata" pointers are valid.
>> +	 */
>> +	if (!data || !reportdata || !cpu_feature_enabled(X86_FEATURE_TDX_GUEST))
>> +		return -EINVAL;
>> +
>> +	/*
>> +	 * Pass the physical address of user generated report data
>> +	 * and the physical address of output buffer to the TDX module
>> +	 * to generate the TD report. Generated data contains
>> +	 * measurements/configuration data of the TD guest. More info
>> +	 * about ABI can be found in TDX 1.0 Module specification, sec
>> +	 * titled "TDG.MR.REPORT".
>> +	 */
>> +	ret = __tdx_module_call(TDX_GET_REPORT, virt_to_phys(data),
>> +				virt_to_phys(reportdata), 0, 0, NULL);
>> +
>> +	if (ret)
>> +		return TDCALL_RETURN_CODE(ret);
> 
> Why is status code masked?

Only upper 32 bit has error code. Check "Function Completion Status
Codes" in TDX module spec.

> 
> 
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(tdx_mcall_tdreport);
> 
> Can this function be put into attest.c. Instead, wecan export __tdx_module_call.

We don't need to export it anymore. I will remove it in next version.

Regarding moving it to attest.c, currently all TDCALL/TDVMCALL wrappers
are left in one place (in tdx.c). For example check tdx_kvm_hypercall()
implementation in tdx.c. I don't see any specific need to break this
uniformity for our use case. Grouping them together will make
it easier if we are fixing some core issues in core functions like 
__tdx_hypercall() in future.


-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
