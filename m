Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACC5D5110FE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 08:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358025AbiD0GRw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 02:17:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348979AbiD0GRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 02:17:51 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FF4672E1A
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 23:14:41 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id l11-20020a17090a49cb00b001d923a9ca99so938428pjm.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 23:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=NK/k1len6ipI7VRblO2zlSBnStryVwiRhHd7pXt8Q/g=;
        b=DyjlNJrpRKEFyzbzhoul2Ga6SQ3jqLjJSUf2N5zMX2eBdwnXuGSJY+Qk9V1tCO8cZE
         Seo/z296JFRN9hvtK67QMqxICvum7EuHNkTBWiXG+c7tGFCFKsClRR1+GadM36N8nlWA
         gtLjeStXvTGOqe6GqvBzOEZhGTW8ZaWyOaJxVfvyPKyr1zm+YMaZL0CZP84mEhmp93Qv
         n3ILJ8k68GYsCkaYumHVOXQyuK2k/DVpU+Ofbm+VL3lPKdWc0K3tYkYbU9ifDh6WanJx
         ryidinI/uLAXqkePF6QWIcJ+cjRYA/WmHrHFXlicrPMRMdSk7SGfQnujc7cGnf5jbFVa
         9IBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=NK/k1len6ipI7VRblO2zlSBnStryVwiRhHd7pXt8Q/g=;
        b=PPBWoim9OlW7xXVrhCFbFVf4xjRgI+PYEwdRYkz0NBeXtiDDoyLW8N/bJKSbG2jha9
         dZ/U305Xg6RD+uQNFk+gv2qNo1fT5eT+bcKMsZgGBQ1J//oefqgnWaDgXD7gSkeX0Bh4
         +oaP+WiskUbzpz7rD5hABUfIzYlAJaGZG4PYuSGTqW8IwOVpDh9dX87nw0W5WtYg+fSt
         96HJaRJqXjYMS1RVBk9BsqdLAouYZ+/WvGJcty3OmT9hp0K1H5DGduKzVS9+psbmjp83
         6My4z8GjiTlP4OW1l3KjvAETGLtqLAYYao3zrma4IuVJESke4BYQSH1XHjlfKe5h+ol4
         637Q==
X-Gm-Message-State: AOAM530JjgO7FGzGE2ClPVEZzvXoBjebgFUjIoCMB/FGeTfgfdc1hQ8T
        n+ztsqA31ZskUT1Ah/BeR0w=
X-Google-Smtp-Source: ABdhPJwwcNeOxRdIGSt161AGSj765xcx+fnwziixQp42pOdmttK8/Gj+Q1vbaMFxrmPa9NorIuZ64Q==
X-Received: by 2002:a17:902:7897:b0:15d:318d:706b with SMTP id q23-20020a170902789700b0015d318d706bmr8364824pll.16.1651040080749;
        Tue, 26 Apr 2022 23:14:40 -0700 (PDT)
Received: from localhost ([192.55.54.48])
        by smtp.gmail.com with ESMTPSA id i5-20020a635845000000b003aaba2d78c2sm14488225pgm.71.2022.04.26.23.14.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 23:14:39 -0700 (PDT)
Date:   Tue, 26 Apr 2022 23:14:38 -0700
From:   Isaku Yamahata <isaku.yamahata@gmail.com>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kai Huang <kai.huang@intel.com>, linux-kernel@vger.kernel.org,
        isaku.yamahata@gmail.com
Subject: Re: [PATCH v4 3/3] x86/tdx: Add Quote generation support
Message-ID: <20220427061438.GB4167861@ls.amr.corp.intel.com>
References: <20220422233418.1203092-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20220422233418.1203092-4-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220422233418.1203092-4-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22, 2022 at 04:34:18PM -0700,
Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com> wrote:

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
> +
> +	/* Submit GetQuote Request */
> +	err = tdx_hcall_get_quote(quote_buf, quote_buf_len);
> +	if (err) {
> +		/* if failed, copy hypercall error code to user buffer */
> +		ret = put_user(err, (long __user *)argp);

ret is ignored.  Do you want to return TDX status code to user?
Does just -EIO suffice?
(If you really want, the TDX status code should be defined as uapi.)


> +		ret = -EIO;
> +		goto quote_failed;
> +	}
> +
> +	/* Wait for attestation completion */
> +	ret = wait_for_completion_interruptible_timeout(
> +			&req_compl,
> +			msecs_to_jiffies(quote_req.timeout));

If you want to support timeout, you need to handle in-flight case below.


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

status check should be before copy_to_user() above.


> +		ret = 0;
> +	else
> +		ret = -EIO;
> +
> +quote_failed:
> +	if (quote_buf)
> +		dma_free_coherent(&pdev->dev, quote_buf_len, quote_buf, handle);

quote_buf can be still owned by VMM because timeout is used above.
Even if interrupt is arrived,  quote_hdr->status can still be in-flight.


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
> +{
> +	u64 ret;
> +
> +	/*
> +	 * Use confidential guest TDX check to ensure this API is only
> +	 * used by TDX guest platforms.
> +	 */
> +	if (!data || !cpu_feature_enabled(X86_FEATURE_TDX_GUEST))
> +		return -EINVAL;

Isn't X86_FEATURE_TDX_GUEST checked on module loading time?

> +
> +	/*
> +	 * Pass the physical address of tdreport data to the VMM
> +	 * and trigger the TDQUOTE generation. It is not a blocking
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
> + * should pass TD report data of size TDX_TDREPORT_LEN bytes via user input
> + * buffer of quote size. Once IOCTL is successful quote data is copied back to
> + * the user buffer. On failure, TDCALL error code is copied back to the user
> + * buffer.
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

What's the point of timeout?


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

If you export version and status, also define related constants for user space.


> +	/* Length of TDREPORT, filled by TD */
> +	__u32 in_len;
> +	/* Length of Quote, filled by VMM */
> +	__u32 out_len;
> +	/* Actual Quote data */
> +	__u64 data;
> +};
> +
>  #endif /* _UAPI_ASM_X86_TDX_H */
> -- 
> 2.25.1
> 

-- 
Isaku Yamahata <isaku.yamahata@gmail.com>
