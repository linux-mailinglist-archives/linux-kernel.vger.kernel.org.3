Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46E42516126
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 03:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238771AbiEABGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 21:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232966AbiEABGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 21:06:14 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4A1D1EEC7
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 18:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651366969; x=1682902969;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=buYy0AIOZ5elzslx5uVRcad8u3HB9OJai1BPjDQvznU=;
  b=jBI0rfKHvqa+MO9Qqo7aueF1lyQXsVUx+o0b0ZZWf7hj5eNMYM5fyj3T
   KEOposMKQK4xCtj+uj3WONcASzl1L/zXMXyhCBloE09Lsrwz+vdZuU0y/
   upSutWkP9d3KWJ+At3NFPKItqfGTlhgiV544nUdj/ZeQVDyAID1sNxnf6
   XufwsDWrjW3CgH1zravYRHIx8T8OY5Gw2V9cs2sTiCC1NHvwk/OQ6sKIM
   6yERPec/J4p8tdbJE9TUtS3oyYYMaqbfJRpGvwMw9m2iooomTDxam5NPt
   DGDw2yI1bxjAemhVLup0SINCnHTCeSiHifTD4EF2hrGD6iabZLbmrTGaD
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10333"; a="248901157"
X-IronPort-AV: E=Sophos;i="5.91,189,1647327600"; 
   d="scan'208";a="248901157"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2022 18:02:48 -0700
X-IronPort-AV: E=Sophos;i="5.91,189,1647327600"; 
   d="scan'208";a="732800067"
Received: from svkandu1-mobl.amr.corp.intel.com (HELO [10.212.233.173]) ([10.212.233.173])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2022 18:02:48 -0700
Message-ID: <9ea1434b-9b61-62f4-85db-ae1369740ec7@linux.intel.com>
Date:   Sat, 30 Apr 2022 18:02:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.7.0
Subject: Re: [PATCH v4 3/3] x86/tdx: Add Quote generation support
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
 <20220422233418.1203092-4-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20220427061438.GB4167861@ls.amr.corp.intel.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20220427061438.GB4167861@ls.amr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 4/26/22 11:14 PM, Isaku Yamahata wrote:
> On Fri, Apr 22, 2022 at 04:34:18PM -0700,
> Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
> 
>> In TDX guest, the second stage in attestation process is quote
>> generation and signing. GetQuote hypercall can be used by the TD guest
>> to request VMM facilitate the quote generation via a Quoting Enclave
>> (QE). More details about GetQuote hypercall can be found in TDX
>> Guest-Host Communication Interface (GHCI) for Intel TDX 1.0, section
>> titled "TDG.VP.VMCALL<GetQuote>.
>>
>> Since GetQuote is an asynchronous request hypercall, it will not block
>> till the quote is generated. So VMM uses callback interrupt vector
>> configured by SetupEventNotifyInterrupt hypercall to notify the guest
>> about quote generation completion or failure. Upon receiving the
>> completion notification, status can be found in the Quote data header.
>>
>> Add tdx_hcall_get_quote() helper function to implement the GetQuote
>> hypercall and add TDX_CMD_GEN_QUOTE IOCTL support to allow the user
>> agent request for quote generation.
>>
>> When a user agent requests for quote generation, it is expected that
>> the user agent knows about the Quoting Enclave response time, and sets
>> a valid timeout value for the quote generation completion. Timeout
>> support is added to make sure the kernel does not wait for the
>> quote completion indefinitely.
>>
>> Although GHCI specification does not restrict parallel GetQuote
>> requests, since quote generation is not in performance critical path
>> and the frequency of attestation requests are expected to be low, only
>> support serialized quote generation requests. Serialization support is
>> added via a mutex lock (attest_lock). Parallel quote request support
>> can be added once demand arises.
>>
>> Reviewed-by: Tony Luck <tony.luck@intel.com>
>> Reviewed-by: Andi Kleen <ak@linux.intel.com>
>> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>> ---
>>   arch/x86/coco/tdx/attest.c      | 118 +++++++++++++++++++++++++++++++-
>>   arch/x86/coco/tdx/tdx.c         |  37 ++++++++++
>>   arch/x86/include/asm/tdx.h      |   2 +
>>   arch/x86/include/uapi/asm/tdx.h |  36 ++++++++++
>>   4 files changed, 191 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/x86/coco/tdx/attest.c b/arch/x86/coco/tdx/attest.c
>> index b776e81f6c20..d485163d3222 100644
>> --- a/arch/x86/coco/tdx/attest.c
>> +++ b/arch/x86/coco/tdx/attest.c
>> @@ -32,6 +32,11 @@
>>   static struct platform_device *pdev;
>>   static struct miscdevice miscdev;
>>   
>> +/* Completion object to track GetQuote completion status */
>> +static DECLARE_COMPLETION(req_compl);
>> +/* Mutex to serialize GetQuote requests */
>> +static DEFINE_MUTEX(quote_lock);
>> +
>>   static long tdx_get_tdreport(void __user *argp)
>>   {
>>   	void *report_buf = NULL, *tdreport_buf = NULL;
>> @@ -79,6 +84,95 @@ static long tdx_get_tdreport(void __user *argp)
>>   	return ret;
>>   }
>>   
>> +static long tdx_get_tdquote(void __user *argp)
>> +{
>> +	struct tdx_quote_hdr *quote_hdr;
>> +	struct tdx_quote_req quote_req;
>> +	void *quote_buf = NULL;
>> +	dma_addr_t handle;
>> +	long ret = 0, err;
>> +	u64 quote_buf_len;
>> +
>> +	mutex_lock(&quote_lock);
>> +
>> +	reinit_completion(&req_compl);
>> +
>> +	/* Copy Quote request struct from user buffer */
>> +	if (copy_from_user(&quote_req, argp, sizeof(struct tdx_quote_req)))
>> +		return -EFAULT;
>> +
>> +	/* Make sure the length & timeout is valid */
>> +	if (quote_req.len <= 0 || quote_req.timeout <= 0)
>> +		return -EINVAL;
>> +
>> +	/* Align with page size to meet 4K alignment */
>> +	quote_buf_len = PAGE_ALIGN(quote_req.len);
>> +
>> +	/*
>> +	 * Allocate DMA buffer to get TDQUOTE data from the VMM.
>> +	 * dma_alloc_coherent() API internally marks allocated
>> +	 * memory as shared with VMM. So explicit shared mapping is
>> +	 * not required.
>> +	 */
>> +	quote_buf = dma_alloc_coherent(&pdev->dev, quote_buf_len, &handle,
>> +					GFP_KERNEL | __GFP_ZERO);
>> +	if (!quote_buf) {
>> +		ret = -ENOMEM;
>> +		goto quote_failed;
>> +	}
>> +
>> +	/* Copy TDREPORT from user Quote data buffer to kernel Quote buffer */
>> +	if (copy_from_user(quote_buf, (void __user *)quote_req.buf, quote_req.len)) {
>> +		ret = -EFAULT;
>> +		goto quote_failed;
>> +	}
>> +
>> +	/* Submit GetQuote Request */
>> +	err = tdx_hcall_get_quote(quote_buf, quote_buf_len);
>> +	if (err) {
>> +		/* if failed, copy hypercall error code to user buffer */
>> +		ret = put_user(err, (long __user *)argp);
> 
> ret is ignored.  Do you want to return TDX status code to user?
> Does just -EIO suffice?
> (If you really want, the TDX status code should be defined as uapi.)

I will remove it in next version.

> 
> 
>> +		ret = -EIO;
>> +		goto quote_failed;
>> +	}
>> +
>> +	/* Wait for attestation completion */
>> +	ret = wait_for_completion_interruptible_timeout(
>> +			&req_compl,
>> +			msecs_to_jiffies(quote_req.timeout));
> 
> If you want to support timeout, you need to handle in-flight case below.

Regarding IN_FLIGHT case, I will let user agent handle it. I am going to
change this code to just copy the quote data once hypercall is
successful.


> 
> 
>> +		ret = 0;
>> +	else
>> +		ret = -EIO;
>> +
>> +quote_failed:
>> +	if (quote_buf)
>> +		dma_free_coherent(&pdev->dev, quote_buf_len, quote_buf, handle);
> 
> quote_buf can be still owned by VMM because timeout is used above.
> Even if interrupt is arrived,  quote_hdr->status can still be in-flight.

Since timeout behavior is not clearly defined in the spec, I let the
user agent configure the appropriate timeout value. Once it timesout,
I assume QE/QGS/VMM will no longer respond or use the buffer. I have
planned to add the following help in struct tdx_quote_hdr.timeout.

@timeout: Time to wait for VMM to respond back to GetQuote request.
This value is dependent on response time of the Quoting Enclave
(QE) or Quote generation service (QGS) involved. It is expected
the user agent is aware of it and sets the appropriate value.

Agree ?

> 
> 
>> +
>> +	mutex_unlock(&quote_lock);
>> +
>> +	return ret;
>> +}
>> +
>> +static void attestation_callback_handler(void)
>> +{
>> +	complete(&req_compl);
>> +}
>> +
>>   static long tdx_attest_ioctl(struct file *file, unsigned int cmd,
>>   			     unsigned long arg)
>>   {
>> @@ -89,6 +183,9 @@ static long tdx_attest_ioctl(struct file *file, unsigned int cmd,
>>   	case TDX_CMD_GET_TDREPORT:
>>   		ret = tdx_get_tdreport(argp);
>>   		break;
>> +	case TDX_CMD_GEN_QUOTE:
>> +		ret = tdx_get_tdquote(argp);
>> +		break;
>>   	default:
>>   		pr_err("cmd %d not supported\n", cmd);
>>   		break;
>> @@ -103,6 +200,14 @@ static const struct file_operations tdx_attest_fops = {
>>   	.llseek		= no_llseek,
>>   };
>>   
>> +/* Helper function to cleanup attestation related allocations */
>> +static void _tdx_attest_remove(void)
>> +{
>> +	misc_deregister(&miscdev);
>> +
>> +	tdx_remove_ev_notify_handler();
>> +}
>> +
>>   static int tdx_attest_probe(struct platform_device *attest_pdev)
>>   {
>>   	struct device *dev = &attest_pdev->dev;
>> @@ -114,6 +219,15 @@ static int tdx_attest_probe(struct platform_device *attest_pdev)
>>   
>>   	pdev = attest_pdev;
>>   
>> +	ret = dma_set_coherent_mask(dev, DMA_BIT_MASK(64));
>> +	if (ret) {
>> +		pr_err("dma set coherent mask failed\n");
>> +		goto failed;
>> +	}
>> +
>> +	/* Register attestation event notify handler */
>> +	tdx_setup_ev_notify_handler(attestation_callback_handler);
>> +
>>   	miscdev.name = DRIVER_NAME;
>>   	miscdev.minor = MISC_DYNAMIC_MINOR;
>>   	miscdev.fops = &tdx_attest_fops;
>> @@ -130,7 +244,7 @@ static int tdx_attest_probe(struct platform_device *attest_pdev)
>>   	return 0;
>>   
>>   failed:
>> -	misc_deregister(&miscdev);
>> +	_tdx_attest_remove();
>>   
>>   	pr_debug("module initialization failed\n");
>>   
>> @@ -139,7 +253,7 @@ static int tdx_attest_probe(struct platform_device *attest_pdev)
>>   
>>   static int tdx_attest_remove(struct platform_device *attest_pdev)
>>   {
>> -	misc_deregister(&miscdev);
>> +	_tdx_attest_remove();
>>   	pr_debug("module is successfully removed\n");
>>   	return 0;
>>   }
>> diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
>> index d0c62b94a1f6..cba22a8d4084 100644
>> --- a/arch/x86/coco/tdx/tdx.c
>> +++ b/arch/x86/coco/tdx/tdx.c
>> @@ -25,6 +25,7 @@
>>   
>>   /* TDX hypercall Leaf IDs */
>>   #define TDVMCALL_MAP_GPA		0x10001
>> +#define TDVMCALL_GET_QUOTE		0x10002
>>   #define TDVMCALL_SETUP_NOTIFY_INTR	0x10004
>>   
>>   /* MMIO direction */
>> @@ -214,6 +215,42 @@ static long tdx_hcall_set_notify_intr(u8 vector)
>>   	return 0;
>>   }
>>   
>> +/*
>> + * tdx_hcall_get_quote() - Request for TDQUOTE using TDREPORT.
>> + *
>> + * @data        : Address of 4KB aligned GPA memory which contains
>> + *                TDREPORT_STRUCT.
>> + * @len		: Length of the GPA in bytes.
>> + *
>> + * return 0 on success or failure error number.
>> + */
>> +long tdx_hcall_get_quote(void *data, u64 len)
>> +{
>> +	u64 ret;
>> +
>> +	/*
>> +	 * Use confidential guest TDX check to ensure this API is only
>> +	 * used by TDX guest platforms.
>> +	 */
>> +	if (!data || !cpu_feature_enabled(X86_FEATURE_TDX_GUEST))
>> +		return -EINVAL;
> 
> Isn't X86_FEATURE_TDX_GUEST checked on module loading time?
> 
>> +
>> +	/*
>> +	 * Pass the physical address of tdreport data to the VMM
>> +	 * and trigger the TDQUOTE generation. It is not a blocking
>> +	 * call, hence completion of this request will be notified to
>> +	 * the TD guest via a callback interrupt. More info about ABI
>> +	 * can be found in TDX Guest-Host-Communication Interface
>> +	 * (GHCI), sec titled "TDG.VP.VMCALL<GetQuote>".
>> +	 */
>> +	ret = _tdx_hypercall(TDVMCALL_GET_QUOTE, cc_mkdec(virt_to_phys(data)),
>> +			     len, 0, 0);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return 0;
>> +}
>> +
>>   static u64 get_cc_mask(void)
>>   {
>>   	struct tdx_module_output out;
>> diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
>> index 89ed09809c13..90c2a5f6c40c 100644
>> --- a/arch/x86/include/asm/tdx.h
>> +++ b/arch/x86/include/asm/tdx.h
>> @@ -73,6 +73,8 @@ void tdx_setup_ev_notify_handler(void (*handler)(void));
>>   
>>   void tdx_remove_ev_notify_handler(void);
>>   
>> +long tdx_hcall_get_quote(void *data, u64 len);
>> +
>>   #else
>>   
>>   static inline void tdx_early_init(void) { };
>> diff --git a/arch/x86/include/uapi/asm/tdx.h b/arch/x86/include/uapi/asm/tdx.h
>> index c21f9d6fe88b..69259b7841a9 100644
>> --- a/arch/x86/include/uapi/asm/tdx.h
>> +++ b/arch/x86/include/uapi/asm/tdx.h
>> @@ -20,4 +20,40 @@
>>    */
>>   #define TDX_CMD_GET_TDREPORT		_IOWR('T', 0x01, __u64)
>>   
>> +/*
>> + * TDX_CMD_GEN_QUOTE IOCTL is used to request TD QUOTE from the VMM. User
>> + * should pass TD report data of size TDX_TDREPORT_LEN bytes via user input
>> + * buffer of quote size. Once IOCTL is successful quote data is copied back to
>> + * the user buffer. On failure, TDCALL error code is copied back to the user
>> + * buffer.
>> + */
>> +#define TDX_CMD_GEN_QUOTE		_IOR('T', 0x02, __u64)
>> +
>> +struct tdx_quote_req {
>> +	/* Buffer address to store Quote data */
>> +	__u64 buf;
>> +	/* Length of the Quote buffer */
>> +	__u64 len;
>> +	/* Quote generation timeout value in ms */
>> +	__u32 timeout;
> 
> What's the point of timeout?

Explained above.

> 
> 
>> +};
>> +
>> +/*
>> + * Format of quote data header. More details can be found in
>> + * TDX Guest-Host Communication Interface (GHCI) for Intel TDX
>> + * 1.0, section titled "TDG.VP.VMCALL<GetQuote>"
>> + */
>> +struct tdx_quote_hdr {
>> +	/* Quote version, filled by TD */
>> +	__u64 version;
>> +	/* Status code of Quote request, filled by VMM */
>> +	__u64 status;
> 
> If you export version and status, also define related constants for user space.

Ok.

> 
> 
>> +	/* Length of TDREPORT, filled by TD */
>> +	__u32 in_len;
>> +	/* Length of Quote, filled by VMM */
>> +	__u32 out_len;
>> +	/* Actual Quote data */
>> +	__u64 data;
>> +};
>> +
>>   #endif /* _UAPI_ASM_X86_TDX_H */
>> -- 
>> 2.25.1
>>
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
