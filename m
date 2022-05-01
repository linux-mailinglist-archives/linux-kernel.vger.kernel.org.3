Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E654516123
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 02:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238275AbiEAA4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 20:56:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232966AbiEAA4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 20:56:04 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54085712CF
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 17:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651366360; x=1682902360;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=KeiIkU5A2/ILSDDQ3rm64QTRXlvB3gB+6CBbAyTV0Pc=;
  b=VBekC33JdTRVNs0vwzr+0F+JEE1t1QlvGjdjBSD9uvoDgOASq1/CYfPb
   u5rmeHSa1YGQ0fTjoWDMbePPhk9k0HJygirVnzCLIG5TNKi52YEQvI9qz
   6wo6jP9YkTRGWlmeh0/EbWs4JJOsfOu0fccID0JVrc+ZcYOMqDSUmdybP
   LCB44hpEighy0PVDuzXDSXN0syr2URxq6x6AMdBxE+pzvY9+agp8iY/KN
   0DScc7w+QZMwcK1aNRuLO54WqTWDYahnZuUGPsghwdGc+8COAc6ziT/NC
   xtv2lZifE8noJbWdnZ2iLlG+xiB7wkfaRH3fyfWr398etNcVZmiGWGkgL
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10333"; a="292117999"
X-IronPort-AV: E=Sophos;i="5.91,189,1647327600"; 
   d="scan'208";a="292117999"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2022 17:52:40 -0700
X-IronPort-AV: E=Sophos;i="5.91,189,1647327600"; 
   d="scan'208";a="732795574"
Received: from svkandu1-mobl.amr.corp.intel.com (HELO [10.212.233.173]) ([10.212.233.173])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2022 17:52:38 -0700
Message-ID: <176621b0-9ae1-e6e9-50a3-a336a483282b@linux.intel.com>
Date:   Sat, 30 Apr 2022 17:52:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.7.0
Subject: Re: [PATCH v4 3/3] x86/tdx: Add Quote generation support
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
 <20220422233418.1203092-4-sathyanarayanan.kuppuswamy@linux.intel.com>
 <5dabb285563c3eb06cf4a06ad264556c11ffc928.camel@intel.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <5dabb285563c3eb06cf4a06ad264556c11ffc928.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kai,

On 4/26/22 2:47 AM, Kai Huang wrote:
> On Fri, 2022-04-22 at 16:34 -0700, Kuppuswamy Sathyanarayanan wrote:
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
> 
> So if I read correctly, you are depending on userspace to prepare the
> tdx_quote_hdr, right?

Yes.

> 
> If so, should the driver check the correctness of the hdr? For instance, whether
> hdr.version == 1, etc?

If there are incorrect values in quote header, GetQuote hypercall will
fail automatically. So I don't think we need to check for it explicitly
here and return error.

> 
>> +
>> +	/* Submit GetQuote Request */
>> +	err = tdx_hcall_get_quote(quote_buf, quote_buf_len);
>> +	if (err) {
>> +		/* if failed, copy hypercall error code to user buffer */
>> +		ret = put_user(err, (long __user *)argp);
>> +		ret = -EIO;
>> +		goto quote_failed;
>> +	}
> 
> Similar to getting TDREPORT, is there any particular case that needs to pass
> TDVMCALL error code back to userspace?

I have mainly returned this error code for debug purpose. It does not
have any other use case. As I have mentioned for TDREPORT use case, I
plan to remove it in next version.

> 
>> +
>> +	/* Wait for attestation completion */
>> +	ret = wait_for_completion_interruptible_timeout(
>> +			&req_compl,
>> +			msecs_to_jiffies(quote_req.timeout));
>> +	if (ret <= 0) {
>> +		ret = -EIO;
>> +		goto quote_failed;
>> +	}
>> +
>> +	/* Copy generated Quote data back to user buffer */
>> +	if (copy_to_user((void __user *)quote_req.buf, quote_buf, quote_buf_len)) {
>> +		ret = -EFAULT;
>> +		goto quote_failed;
>> +	}
>> +
>> +	quote_hdr = (struct tdx_quote_hdr *)quote_buf;
>> +
>> +	/* Make sure quote generation is successful */
>> +	if (!quote_hdr->status)
>> +		ret = 0;
>> +	else
>> +		ret = -EIO;
>> +
>> +quote_failed:
>> +	if (quote_buf)
>> +		dma_free_coherent(&pdev->dev, quote_buf_len, quote_buf, handle);
> 
> Will dma_free_coherent() convert the shared buffer back to private (using
> MapGPA)?
> 
> If so, since it's possible to timeout, if the buffer still have IN_FLIGHT flag
> set (VMM is still using it), can we do it?

We depend on user agent to set appropriate timeout specific to QE/QGS
involved. So once it timeout, we assume VMM/QE/QGS will not update it
anymore.

> 
> Isaku, what will happen if guest uses MapGPA to convert a buffer back to private
> while it still has IN_FLIGHT set?

This is not defined in spec. Since we allow user agent select the time
timeout, we assume QE/QGS will not update it after the timeout value.

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
> 
> Rename data/len to something meaningful, i.e. quote_buf, quote_len ?

I plan to move the hypercall implementation to attest.c.

As for names, I am fine with quote_buf and quote_len

> 
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
> The same comment to tdx_mcall_get_tdreport().  You can have a single check of
> X86_FEATURE_TDX_GUEST during driver initialization and refuse to initialize the
> driver if it's not.

Yes. Moved it to initcall of attestation driver.

> 
>> +
>> +	/*
>> +	 * Pass the physical address of tdreport data to the VMM
>> +	 * and trigger the TDQUOTE generation. It is not a blocking
> 
> I see there is inconsistency regarding to how to spell TD Quote.  I have seen
> TDQUOTE, TD QUOTE, quote, and Quote.  I guess we can have a unified way for
> this.  How about: Quote, or TD Quote (when you want to highlight TD)?

Ok.

> 
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
> 
> Replace "TD QUOTE" to some consistent name.

Ok.

> 
>> + * should pass TD report data of size TDX_TDREPORT_LEN bytes via user input
>> + * buffer of quote size.
>>
> 
> This is not correct.  The data userspace put into the buffer is transparent to
> driver.  It's between userspace attestation agent and QE/QGS.  In fact, Intel's
> implementation has an additional header besides TDREPORT, and the whole data is
> encoded in proto2 format.

Noted. I will fix the description in next version.

> 
>> Once IOCTL is successful quote data is copied back to
>> + * the user buffer. On failure, TDCALL error code is copied back to the user
>> + * buffer.
> 
> The output data may be more than the Quote, the same as above.
> 
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
>> +	/* Length of TDREPORT, filled by TD */
>> +	__u32 in_len;
>> +	/* Length of Quote, filled by VMM */
>> +	__u32 out_len;
>> +	/* Actual Quote data */
>> +	__u64 data;
>> +};
> 
> Needs to be '__u64 data[0]'.  The first 8B data isn't header.

Ok.

> 
> 
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
