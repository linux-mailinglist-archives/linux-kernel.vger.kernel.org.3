Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7C9E5108A6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 21:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354175AbiDZTLk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 15:11:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354157AbiDZTKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 15:10:51 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F721396A0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 12:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651000042; x=1682536042;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Bw6NJeComU+oMlcVMqPV4505YsLXcBsf5J+3MwEM24M=;
  b=CviKOxRr4gsGA/pjT8FBwSVj5uhOZ88nQykltmlDsBuwwUFHxDgquTzy
   vDb86Ne+8oek8t2NWyoRQB/+ZqkVfUT40euOwxIWyPN5F/mVJJAIeOxAs
   AssJZ6+PFJlRqX8UWvm1cAo0nlbm8GsLXxgLvGTCABF4zPWIjp/RYs0A0
   ikxvypTtawrzzwRnqtOzHNO4AwXd0EH0z5clQ4X0qmXc5hZZQldEi+1S2
   Ke89kYREQRIXOx+xsMS+x49j3WTMVlzGMv0yKaXJjc2vMwH9Pb0kyLl19
   +1BhflfjUUGvzGovG01yKSuh1uU1aPJ+rexx08a87gr9K/wWyDdI4BcwX
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10329"; a="264540530"
X-IronPort-AV: E=Sophos;i="5.90,291,1643702400"; 
   d="scan'208";a="264540530"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 12:07:21 -0700
X-IronPort-AV: E=Sophos;i="5.90,291,1643702400"; 
   d="scan'208";a="650350193"
Received: from akanupar-mobl.amr.corp.intel.com (HELO [10.209.102.16]) ([10.209.102.16])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 12:07:20 -0700
Message-ID: <1168a7cc-9e41-ee2d-8b3d-8dbd1ab85609@linux.intel.com>
Date:   Tue, 26 Apr 2022 12:07:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.7.0
Subject: Re: [PATCH v4 1/3] x86/tdx: Add TDX Guest attestation interface
 driver
Content-Language: en-US
To:     Kai Huang <kai.huang@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc:     "H . Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org
References: <20220422233418.1203092-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20220422233418.1203092-2-sathyanarayanan.kuppuswamy@linux.intel.com>
 <0457ce8e78ddd1d6c7832176368e095adae1bc18.camel@intel.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <0457ce8e78ddd1d6c7832176368e095adae1bc18.camel@intel.com>
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

Hi Kai,

Thanks for the review.

On 4/24/22 10:44 PM, Kai Huang wrote:
> On Fri, 2022-04-22 at 16:34 -0700, Kuppuswamy Sathyanarayanan wrote:
>> In TDX guest, attestation is used to verify the trustworthiness of a TD
>> to other entities before making any secure communication.
> 
> Before provisioning secrets to the TD.

Ok. Will change it.

> 
>>
>> One usage example is, when a TD guest uses encrypted drive and the
>> decryption keys required to access the drive are stored in a secure
>> 3rd party keyserver, TD guest can use the quote generated via the
>> attestation process to prove its trustworthiness with keyserver and
>> get access to the storage keys.
> 
> "The key server can use attestation to verify TD's trustworthiness and release
> the decryption keys to the TD".
> 
> It is the key server who starts the attestation request, but not the TD.
> 
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
> 
> Let's separate TDREPORT generation and Quote generation, and get rid of details
> of how to get Quote part for now. Detail of GetQuote belongs to the patch which
> implements it.  Here I think we should focus on explaining why we need such a
> basic driver to allow userspace to get the TDREPORT.
> 
> Below is for your reference:
> 
> "
> The attestation process consists of two steps: TDREPORT generation and Quote
> generation.  TDREPORT (TDREPORT_STRUCT) is a fixed-size data structure generated
> by the TDX module to contain the TD-specific informatin (such as TD
> measurements), platform information such as the security version of the platform
> and the TDX module and the MAC to protect the integrity of the TDREPORT. TD
> kernel uses TDCALL[TDG.MR.REPORT] to get the TDREPORT from the TDX module.  A
> user-provided 64-Byte REPORTDATA is used as input and included in the TDREPORT.
> Typically it can be some nonce provided by attestation service so the TDREPORT
> can be verified uniquely.
> 
> TDREPORT can only be verified locally as the MAC key is bound to the platform.
> TDX attestation leverages Intel SGX Quote Enclave (QE) to verify the TDREPORT
> locally and convert it to a remote verifiable Quote to support remote
> attestation of the TDREPORT.  After getting the TDREPORT, the second step of
> attestation process is to send the TDREPORT to QE to generate the Quote.
> 
> How is the QE, or Quote Generation Service (QGS) in general, implemented and
> deployed is implementation specific.  As a result, how to send the TDREPORT to
> QE/QGS also depends on QE/QGS implementation and the deployment.  TDX doesn't
> support SGX inside a TD, so the QE/QGS can be deployed in the host, or inside a
> dedicated legacy VM.
> 
> A typical implementation is TD userspace attestation software gets the TDREPORT
> from TD kernel, sends it to QE/QGS, and QE/QGS returns the Quote.  The data and
> data format that TD userspace attestation software sends to the QE/QGS is also
> implementation specific, but not necessarily just the raw TDREPORT.  TD
> attestation software can use any available communication channel to talk to
> QE/QGS, such as using vsock and tcp/ip.
> 
> To support the case that those communication channels are not directly available
> to the TD, TDX also defines TDVMCALLs to allow TD to use TDVMCALL to ask VMM to
> help with sending the TDREPORT and receiving the Quote.  This support is
> documented in the GHCI spec "5.4 TD attestation".
> 
> Implement a basic attestation driver to allow TD userspace to get the TDREPORT
> so the attestation software can send it to the QE to generate a Quote for remote
> verification.
> "
> 

Thanks. I will use it with some addition about the driver mentioned
below.

> 
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
> 
> Read TDREPORT.  You can extend it in later patch if you want to call out
> TDREPORT, Quote.  But I don't think it's even necessary.  Perhaps just say "TDX
> attestation support" in general is enough.

Ok. I will fix it.

> 
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
>> +		ret = -EIO;
>> +		goto tdreport_failed;
>> +	}
> 
> If you want support this, I guess it's better to explicitly use some data
> structure so userspace software can be very clear about what does this IOCTL do:
> 
> 	struct tdx_get_tdreport {
> 		union {
> 			/* Input: REPORTDATA for TDCALL[TDG.MR.REPORT] */
> 			__u8 reportdata[TDX_REPORT_DATA_LEN];
> 			/* Output when TDCALL[TDG.MR.REPORT] fails */
> 			__u64 tdcall_err;
> 		} buf;
> 	};
> 
> And you need to explain in the comment saying -EIO means TDCALL failed, and the
> error code is returned to userspace.
> 
> But I am not sure whether this is necessary.  The spec says TDG.MR.REPORT can
> return: TDX_OPERAND_BUSY, TDX_OPERAND_INVALID, TDX_SUCCESS.
> 
> TDX_OPERAND_INVALID basically happens when buffer alignment doesn't meet, GPA is
> wrong, etc, so this case is kernel bug.  I don't see there's a need to expose it
> to userspace as userspace won't be able to do anything anyway.
> 
> The BUSY case is (if I understand correctly, I took a look at the SEAM module
> code) basically there's another thread updating the TDMR (registers for runtime
> measurement update).  Since it seems current kernel doesn't support
> TDG.MR.RTMR.EXTEND, TDX_OPERAND_BUSY should not happen either.  Even considering
> the support of TDG.MR.RTMR.EXTEND in the future, I think kernel should use some
> mutex to serialize it with TDG.MR.REPORT?

Ok. I will keep this in mind when adding RTMR support in future.

> 
> The bottom line is even we want to report BUSY to userspace, we choose to
> return -EBUSY to indicate this case.  So basically I don't see the value of
> exposing TDCALL error to userspace.

I have mainly added it to get more debug info about the failure in user
app. But I agree with your point that this not necessary. I will remove 
this in next version.

> 
> 
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
>> +		break;
> 
> Seems you are returning 0 in the default case.

Good catch. I will fix it in next version.

> 
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
> 
> Is there any particular reason to use platform driver and support it as a
> module?
> 
> SGX driver uses misc_register() to register /dev/sgx_enclave during boot.  Looks
> it would be simpler.

Main reason is to use a proper device in dma_alloc* APIs.

My initial version only used misc device as you have mentioned. But
Hans raised a concern about using proper struct device in dma_alloc*
APIs and suggested modifying the driver to use platform device
model. You can find relevant discussion here.

https://lore.kernel.org/all/47d06f45-c1b5-2c8f-d937-3abacbf10321@redhat.com/
> 
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
>> + */
>> +long tdx_mcall_tdreport(void *data, void *reportdata)
> 
> Change 'data' to be something more meaningful, i.e. tdreport?

Ok. I will change it.

> 
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
> 
> Other TDCALL wrappers such as tdx_get_ve_info() doesn't have
> X86_FEATURE_TDX_GUEST check.  Why is it needed in this particular one?

Previously the attestation driver can be compiled as a module so I have
exported this function. But I was not sure whether this function will be
called *only* from the attestation driver. So to protect against any
incorrect usage, I have added check for valid TDX guest with in this
function.

But I think this is no longer required. I will remove it in the next
version.

> 
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
> If we don't expose TDCALL error to userspace, I don't think this is required?
> 
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(tdx_mcall_tdreport);
> 
> If you use SGX similar way to use misc_register() at boot but don't support the
> driver as module, then you don't have to export this symbol.

Now that we don't have separate config for attestation, module
compilation is not possible. I will remove it.

> 
>> +
>>   static u64 get_cc_mask(void)
>>   {
>>   	struct tdx_module_output out;
>> diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
>> index 020c81a7c729..a151f69dd6ef 100644
>> --- a/arch/x86/include/asm/tdx.h
>> +++ b/arch/x86/include/asm/tdx.h
>> @@ -67,6 +67,8 @@ void tdx_safe_halt(void);
>>   
>>   bool tdx_early_handle_ve(struct pt_regs *regs);
>>   
>> +long tdx_mcall_tdreport(void *data, void *reportdata);
>> +
>>   #else
>>   
>>   static inline void tdx_early_init(void) { };
>> diff --git a/arch/x86/include/uapi/asm/tdx.h b/arch/x86/include/uapi/asm/tdx.h
>> new file mode 100644
>> index 000000000000..c21f9d6fe88b
>> --- /dev/null
>> +++ b/arch/x86/include/uapi/asm/tdx.h
>> @@ -0,0 +1,23 @@
>> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
>> +#ifndef _UAPI_ASM_X86_TDX_H
>> +#define _UAPI_ASM_X86_TDX_H
>> +
>> +#include <linux/types.h>
>> +#include <linux/ioctl.h>
>> +
>> +/* Input report data length for TDX_CMD_GET_TDREPORT IOCTL request */
>> +#define TDX_REPORT_DATA_LEN		64
> 
> I'd change to TDX_REPORTDATA_LEN to make it consistent with spec.
> 
> REPORT_DATA can be vague.

Ok.

> 
>> +
>> +/* Output TD report data length after TDX_CMD_GET_TDREPORT IOCTL execution */
>> +#define TDX_TDREPORT_LEN		1024
>> +
>> +/*
>> + * TDX_CMD_GET_TDREPORT IOCTL is used to get TDREPORT data from the TDX
> 
> "TDREPORT data" -> "TDREPORT", or "TDREPORT_STRUCT".

Ok. I will make it consistent.

> 
>> + * Module. Users should pass report data of size TDX_REPORT_DATA_LEN bytes
>> + * via user input buffer of size TDX_TDREPORT_LEN. Once IOCTL is successful
>> + * TDREPORT data is copied to the user buffer. On failure, TDCALL error
>> + * code is copied back to the user buffer.
> 
> As I commented above, I am not convinced we need to copy TDCALL error code back
> to userspace.  If we want to do that, we need to explicitly tell on what error
> code (-EIO, i.e.), the TDCALL error code is copied back.
> 

I will remove the error code return support.



-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
