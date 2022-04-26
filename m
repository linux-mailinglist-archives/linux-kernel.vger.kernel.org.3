Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 414DF50FA2C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 12:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348640AbiDZKVo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 06:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245268AbiDZKVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 06:21:16 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E074A15709
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 02:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650966432; x=1682502432;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/QVSnHEfasMkiULkC+nBIO20NmASDZmcOioM6biUzv8=;
  b=RXirk2a8n4AnCGl8FN5XHIvf9nUisVYRdopKwqb0mfdld1N9Bcw77x3A
   0o6ek6PNA18AV1OReDNsutUigLDWyGcZuvQVGzPdNXc5PTIrHwsvrgP+l
   xHPM9PboegXPjkudJvdkflHmErLC02tFOGFZ1Ts8G/jt+Bo029Qw7JNie
   RJSFwhG6XJv8qQ+CRXDcU/Qrnw1ypos50ZWhciJkQhCoFRx+D4Np7Pvth
   O1WaQBSXnV2GlmKm4n541+6ie1pdTXL2cA6rW1rzuZ5damvdKyLQl6DGI
   Pv/tAKraBSv//HDtloyQISbI6zZwMMi1IRb3K0kinkHzYgKOwsugPncnJ
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10328"; a="252899163"
X-IronPort-AV: E=Sophos;i="5.90,290,1643702400"; 
   d="scan'208";a="252899163"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 02:47:12 -0700
X-IronPort-AV: E=Sophos;i="5.90,290,1643702400"; 
   d="scan'208";a="730173773"
Received: from kculcasi-mobl2.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.254.59.214])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 02:47:09 -0700
Message-ID: <5dabb285563c3eb06cf4a06ad264556c11ffc928.camel@intel.com>
Subject: Re: [PATCH v4 3/3] x86/tdx: Add Quote generation support
From:   Kai Huang <kai.huang@intel.com>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc:     "H . Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org
Date:   Tue, 26 Apr 2022 21:47:06 +1200
In-Reply-To: <20220422233418.1203092-4-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20220422233418.1203092-1-sathyanarayanan.kuppuswamy@linux.intel.com>
         <20220422233418.1203092-4-sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-04-22 at 16:34 -0700, Kuppuswamy Sathyanarayanan wrote:
> In TDX guest, the second stage in attestation process is quote
> generation and signing. GetQuote hypercall can be used by the TD guest
> to request VMM facilitate the quote generation via a Quoting Enclave
> (QE). More details about GetQuote hypercall can be found in TDX
> Guest-Host Communication Interface (GHCI) for Intel TDX 1.0, section
> titled "TDG.VP.VMCALL<GetQuote>.
> 
> Since GetQuote is an asynchronous request hypercall, it will not block
> till the quote is generated. So VMM uses callback interrupt vector
> configured by SetupEventNotifyInterrupt hypercall to notify the guest
> about quote generation completion or failure. Upon receiving the
> completion notification, status can be found in the Quote data header.
> 
> Add tdx_hcall_get_quote() helper function to implement the GetQuote
> hypercall and add TDX_CMD_GEN_QUOTE IOCTL support to allow the user
> agent request for quote generation.
> 
> When a user agent requests for quote generation, it is expected that
> the user agent knows about the Quoting Enclave response time, and sets
> a valid timeout value for the quote generation completion. Timeout
> support is added to make sure the kernel does not wait for the
> quote completion indefinitely.
> 
> Although GHCI specification does not restrict parallel GetQuote
> requests, since quote generation is not in performance critical path
> and the frequency of attestation requests are expected to be low, only
> support serialized quote generation requests. Serialization support is
> added via a mutex lock (attest_lock). Parallel quote request support
> can be added once demand arises.
> 
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Reviewed-by: Andi Kleen <ak@linux.intel.com>
> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> ---
>  arch/x86/coco/tdx/attest.c      | 118 +++++++++++++++++++++++++++++++-
>  arch/x86/coco/tdx/tdx.c         |  37 ++++++++++
>  arch/x86/include/asm/tdx.h      |   2 +
>  arch/x86/include/uapi/asm/tdx.h |  36 ++++++++++
>  4 files changed, 191 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/coco/tdx/attest.c b/arch/x86/coco/tdx/attest.c
> index b776e81f6c20..d485163d3222 100644
> --- a/arch/x86/coco/tdx/attest.c
> +++ b/arch/x86/coco/tdx/attest.c
> @@ -32,6 +32,11 @@
>  static struct platform_device *pdev;
>  static struct miscdevice miscdev;
>  
> +/* Completion object to track GetQuote completion status */
> +static DECLARE_COMPLETION(req_compl);
> +/* Mutex to serialize GetQuote requests */
> +static DEFINE_MUTEX(quote_lock);
> +
>  static long tdx_get_tdreport(void __user *argp)
>  {
>  	void *report_buf = NULL, *tdreport_buf = NULL;
> @@ -79,6 +84,95 @@ static long tdx_get_tdreport(void __user *argp)
>  	return ret;
>  }
>  
> +static long tdx_get_tdquote(void __user *argp)
> +{
> +	struct tdx_quote_hdr *quote_hdr;
> +	struct tdx_quote_req quote_req;
> +	void *quote_buf = NULL;
> +	dma_addr_t handle;
> +	long ret = 0, err;
> +	u64 quote_buf_len;
> +
> +	mutex_lock(&quote_lock);
> +
> +	reinit_completion(&req_compl);
> +
> +	/* Copy Quote request struct from user buffer */
> +	if (copy_from_user(&quote_req, argp, sizeof(struct tdx_quote_req)))
> +		return -EFAULT;
> +
> +	/* Make sure the length & timeout is valid */
> +	if (quote_req.len <= 0 || quote_req.timeout <= 0)
> +		return -EINVAL;
> +
> +	/* Align with page size to meet 4K alignment */
> +	quote_buf_len = PAGE_ALIGN(quote_req.len);
> +
> +	/*
> +	 * Allocate DMA buffer to get TDQUOTE data from the VMM.
> +	 * dma_alloc_coherent() API internally marks allocated
> +	 * memory as shared with VMM. So explicit shared mapping is
> +	 * not required.
> +	 */
> +	quote_buf = dma_alloc_coherent(&pdev->dev, quote_buf_len, &handle,
> +					GFP_KERNEL | __GFP_ZERO);
> +	if (!quote_buf) {
> +		ret = -ENOMEM;
> +		goto quote_failed;
> +	}
> +
> +	/* Copy TDREPORT from user Quote data buffer to kernel Quote buffer */
> +	if (copy_from_user(quote_buf, (void __user *)quote_req.buf, quote_req.len)) {
> +		ret = -EFAULT;
> +		goto quote_failed;
> +	}

So if I read correctly, you are depending on userspace to prepare the
tdx_quote_hdr, right? 

If so, should the driver check the correctness of the hdr? For instance, whether
hdr.version == 1, etc?

> +
> +	/* Submit GetQuote Request */
> +	err = tdx_hcall_get_quote(quote_buf, quote_buf_len);
> +	if (err) {
> +		/* if failed, copy hypercall error code to user buffer */
> +		ret = put_user(err, (long __user *)argp);
> +		ret = -EIO;
> +		goto quote_failed;
> +	}

Similar to getting TDREPORT, is there any particular case that needs to pass
TDVMCALL error code back to userspace?

> +
> +	/* Wait for attestation completion */
> +	ret = wait_for_completion_interruptible_timeout(
> +			&req_compl,
> +			msecs_to_jiffies(quote_req.timeout));
> +	if (ret <= 0) {
> +		ret = -EIO;
> +		goto quote_failed;
> +	}
> +
> +	/* Copy generated Quote data back to user buffer */
> +	if (copy_to_user((void __user *)quote_req.buf, quote_buf, quote_buf_len)) {
> +		ret = -EFAULT;
> +		goto quote_failed;
> +	}
> +
> +	quote_hdr = (struct tdx_quote_hdr *)quote_buf;
> +
> +	/* Make sure quote generation is successful */
> +	if (!quote_hdr->status)
> +		ret = 0;
> +	else
> +		ret = -EIO;
> +
> +quote_failed:
> +	if (quote_buf)
> +		dma_free_coherent(&pdev->dev, quote_buf_len, quote_buf, handle);

Will dma_free_coherent() convert the shared buffer back to private (using
MapGPA)?

If so, since it's possible to timeout, if the buffer still have IN_FLIGHT flag
set (VMM is still using it), can we do it?

Isaku, what will happen if guest uses MapGPA to convert a buffer back to private
while it still has IN_FLIGHT set?

> +
> +	mutex_unlock(&quote_lock);
> +
> +	return ret;
> +}
> +
> +static void attestation_callback_handler(void)
> +{
> +	complete(&req_compl);
> +}
> +
>  static long tdx_attest_ioctl(struct file *file, unsigned int cmd,
>  			     unsigned long arg)
>  {
> @@ -89,6 +183,9 @@ static long tdx_attest_ioctl(struct file *file, unsigned int cmd,
>  	case TDX_CMD_GET_TDREPORT:
>  		ret = tdx_get_tdreport(argp);
>  		break;
> +	case TDX_CMD_GEN_QUOTE:
> +		ret = tdx_get_tdquote(argp);
> +		break;
>  	default:
>  		pr_err("cmd %d not supported\n", cmd);
>  		break;
> @@ -103,6 +200,14 @@ static const struct file_operations tdx_attest_fops = {
>  	.llseek		= no_llseek,
>  };
>  
> +/* Helper function to cleanup attestation related allocations */
> +static void _tdx_attest_remove(void)
> +{
> +	misc_deregister(&miscdev);
> +
> +	tdx_remove_ev_notify_handler();
> +}
> +
>  static int tdx_attest_probe(struct platform_device *attest_pdev)
>  {
>  	struct device *dev = &attest_pdev->dev;
> @@ -114,6 +219,15 @@ static int tdx_attest_probe(struct platform_device *attest_pdev)
>  
>  	pdev = attest_pdev;
>  
> +	ret = dma_set_coherent_mask(dev, DMA_BIT_MASK(64));
> +	if (ret) {
> +		pr_err("dma set coherent mask failed\n");
> +		goto failed;
> +	}
> +
> +	/* Register attestation event notify handler */
> +	tdx_setup_ev_notify_handler(attestation_callback_handler);
> +
>  	miscdev.name = DRIVER_NAME;
>  	miscdev.minor = MISC_DYNAMIC_MINOR;
>  	miscdev.fops = &tdx_attest_fops;
> @@ -130,7 +244,7 @@ static int tdx_attest_probe(struct platform_device *attest_pdev)
>  	return 0;
>  
>  failed:
> -	misc_deregister(&miscdev);
> +	_tdx_attest_remove();
>  
>  	pr_debug("module initialization failed\n");
>  
> @@ -139,7 +253,7 @@ static int tdx_attest_probe(struct platform_device *attest_pdev)
>  
>  static int tdx_attest_remove(struct platform_device *attest_pdev)
>  {
> -	misc_deregister(&miscdev);
> +	_tdx_attest_remove();
>  	pr_debug("module is successfully removed\n");
>  	return 0;
>  }
> diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
> index d0c62b94a1f6..cba22a8d4084 100644
> --- a/arch/x86/coco/tdx/tdx.c
> +++ b/arch/x86/coco/tdx/tdx.c
> @@ -25,6 +25,7 @@
>  
>  /* TDX hypercall Leaf IDs */
>  #define TDVMCALL_MAP_GPA		0x10001
> +#define TDVMCALL_GET_QUOTE		0x10002
>  #define TDVMCALL_SETUP_NOTIFY_INTR	0x10004
>  
>  /* MMIO direction */
> @@ -214,6 +215,42 @@ static long tdx_hcall_set_notify_intr(u8 vector)
>  	return 0;
>  }
>  
> +/*
> + * tdx_hcall_get_quote() - Request for TDQUOTE using TDREPORT.
> + *
> + * @data        : Address of 4KB aligned GPA memory which contains
> + *                TDREPORT_STRUCT.
> + * @len		: Length of the GPA in bytes.
> + *
> + * return 0 on success or failure error number.
> + */
> +long tdx_hcall_get_quote(void *data, u64 len)

Rename data/len to something meaningful, i.e. quote_buf, quote_len ?

> +{
> +	u64 ret;
> +
> +	/*
> +	 * Use confidential guest TDX check to ensure this API is only
> +	 * used by TDX guest platforms.
> +	 */
> +	if (!data || !cpu_feature_enabled(X86_FEATURE_TDX_GUEST))
> +		return -EINVAL;

The same comment to tdx_mcall_get_tdreport().  You can have a single check of
X86_FEATURE_TDX_GUEST during driver initialization and refuse to initialize the
driver if it's not.

> +
> +	/*
> +	 * Pass the physical address of tdreport data to the VMM
> +	 * and trigger the TDQUOTE generation. It is not a blocking

I see there is inconsistency regarding to how to spell TD Quote.  I have seen
TDQUOTE, TD QUOTE, quote, and Quote.  I guess we can have a unified way for
this.  How about: Quote, or TD Quote (when you want to highlight TD)?

> +	 * call, hence completion of this request will be notified to
> +	 * the TD guest via a callback interrupt. More info about ABI
> +	 * can be found in TDX Guest-Host-Communication Interface
> +	 * (GHCI), sec titled "TDG.VP.VMCALL<GetQuote>".
> +	 */
> +	ret = _tdx_hypercall(TDVMCALL_GET_QUOTE, cc_mkdec(virt_to_phys(data)),
> +			     len, 0, 0);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
>  static u64 get_cc_mask(void)
>  {
>  	struct tdx_module_output out;
> diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
> index 89ed09809c13..90c2a5f6c40c 100644
> --- a/arch/x86/include/asm/tdx.h
> +++ b/arch/x86/include/asm/tdx.h
> @@ -73,6 +73,8 @@ void tdx_setup_ev_notify_handler(void (*handler)(void));
>  
>  void tdx_remove_ev_notify_handler(void);
>  
> +long tdx_hcall_get_quote(void *data, u64 len);
> +
>  #else
>  
>  static inline void tdx_early_init(void) { };
> diff --git a/arch/x86/include/uapi/asm/tdx.h b/arch/x86/include/uapi/asm/tdx.h
> index c21f9d6fe88b..69259b7841a9 100644
> --- a/arch/x86/include/uapi/asm/tdx.h
> +++ b/arch/x86/include/uapi/asm/tdx.h
> @@ -20,4 +20,40 @@
>   */
>  #define TDX_CMD_GET_TDREPORT		_IOWR('T', 0x01, __u64)
>  
> +/*
> + * TDX_CMD_GEN_QUOTE IOCTL is used to request TD QUOTE from the VMM. User

Replace "TD QUOTE" to some consistent name.

> + * should pass TD report data of size TDX_TDREPORT_LEN bytes via user input
> + * buffer of quote size. 
> 

This is not correct.  The data userspace put into the buffer is transparent to
driver.  It's between userspace attestation agent and QE/QGS.  In fact, Intel's
implementation has an additional header besides TDREPORT, and the whole data is
encoded in proto2 format.

> Once IOCTL is successful quote data is copied back to
> + * the user buffer. On failure, TDCALL error code is copied back to the user
> + * buffer.

The output data may be more than the Quote, the same as above.

> + */
> +#define TDX_CMD_GEN_QUOTE		_IOR('T', 0x02, __u64)
> +
> +struct tdx_quote_req {
> +	/* Buffer address to store Quote data */
> +	__u64 buf;
> +	/* Length of the Quote buffer */
> +	__u64 len;
> +	/* Quote generation timeout value in ms */
> +	__u32 timeout;
> +};
> +
> +/*
> + * Format of quote data header. More details can be found in
> + * TDX Guest-Host Communication Interface (GHCI) for Intel TDX
> + * 1.0, section titled "TDG.VP.VMCALL<GetQuote>"
> + */
> +struct tdx_quote_hdr {
> +	/* Quote version, filled by TD */
> +	__u64 version;
> +	/* Status code of Quote request, filled by VMM */
> +	__u64 status;
> +	/* Length of TDREPORT, filled by TD */
> +	__u32 in_len;
> +	/* Length of Quote, filled by VMM */
> +	__u32 out_len;
> +	/* Actual Quote data */
> +	__u64 data;
> +};

Needs to be '__u64 data[0]'.  The first 8B data isn't header.



-- 
Thanks,
-Kai


