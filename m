Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B8115269C3
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 20:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383485AbiEMS6n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 14:58:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383511AbiEMS6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 14:58:30 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ADEF6BFCB
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 11:58:28 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id g184so8316404pgc.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 11:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uaMwgpxg4IsEJXjbZwkrxh50m2ZCyKkd2N5/fLe9g8Y=;
        b=XTKCtalOncaP5tXLK6XqJ7SubrMUVQXCwM0QdkMAZ/1ou41VTt4VsNIn9m1LwdGa1F
         7xxUicmGVerRGXau1hRRTzcmgcHNkgZA6KVGHm8IOiAxra07KWL11C+ColzXCR/qOe65
         A5P6c3goEKWeFoauXW6dHsCpxn/RJgOsjBGzDN7LUSmAE2H9+59E+Cq6qriPzeTvaMmE
         KNyN9CnfABj8GxQw2vpho+BRLuVUYJHhoRanALYruHtpTh9P+lyqof0gAfPJOcaZtvVg
         DIi2OCd8wsXthyeE8Ms8MMTx6gQN8GaIVhWR/YZE4TpRp4Do5rMN2+xAn/rGhgznHZ74
         Lmyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uaMwgpxg4IsEJXjbZwkrxh50m2ZCyKkd2N5/fLe9g8Y=;
        b=67Su9b2AYw6rd8glL4IMKbnwq+Beu1gqX41LLYk/q/2dMyK8VEW4jTDokRSUwYhGDJ
         qJc3PSXORMFlOosKJgDlkR1EoUEocq/5/sWoruGCz+4aVVDJx02Y8avX+MGlvR7b2Zbm
         BQ9Qan/6SSUzIDv1B3bBGbsOmOXorxkkEw/1XYlWOY5PF+xYhXWbuEhdNoPpKW6Cqgz+
         +B3O16LY2SvZWN1hSR471/87VJCPBTkXY1vUGL2nX3RSaOvF28hbiy6+sfeh9XjgpjbI
         teuLN/X2Nfs+GjSJwk0VqVjH1T+o5tfzPBHr7XZFyYy9o+HXMED3otrTl6dhgBIWMGH1
         w1QQ==
X-Gm-Message-State: AOAM533B9xOCekyjWHT+R3UpDBx/f7I1BGWjnyUKWpQakd7yZMZyI5lH
        fXY4Yxa1hgpiYsqhKasp/j0=
X-Google-Smtp-Source: ABdhPJzmkDaKiYg8no/zLRHaI2Tn4WeOpKE3vnL7XRwpqjABmeO+glhl4tZq3xXIigpjS9qMOHEfsw==
X-Received: by 2002:a62:c545:0:b0:50d:2d0f:2e8a with SMTP id j66-20020a62c545000000b0050d2d0f2e8amr6071788pfg.12.1652468307216;
        Fri, 13 May 2022 11:58:27 -0700 (PDT)
Received: from localhost ([192.55.54.48])
        by smtp.gmail.com with ESMTPSA id w2-20020a17090abc0200b001d9253a32fcsm1894545pjr.36.2022.05.13.11.58.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 11:58:26 -0700 (PDT)
Date:   Fri, 13 May 2022 11:58:24 -0700
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
        Kai Huang <kai.huang@intel.com>,
        Wander Lairson Costa <wander@redhat.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 5/5] x86/tdx: Add Quote generation support
Message-ID: <20220513185824.GB2913259@ls.amr.corp.intel.com>
References: <20220512221952.3647598-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20220512221952.3647598-6-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220512221952.3647598-6-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2022 at 03:19:52PM -0700,
Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com> wrote:

> In TDX guest, the second stage in attestation process is to send the
> TDREPORT to QE/QGS to generate the TD Quote. For platforms that does
> not support communication channels like vsock or TCP/IP, implement
> support to get TD Quote using hypercall. GetQuote hypercall can be used
> by the TD guest to request VMM facilitate the Quote generation via
> QE/QGS. More details about GetQuote hypercall can be found in TDX
> Guest-Host Communication Interface (GHCI) for Intel TDX 1.0, section
> titled "TDG.VP.VMCALL<GetQuote>.
> 
> Since GetQuote is an asynchronous request hypercall, it will not block
> till the TD Quote is generated. So VMM uses callback interrupt vector
> configured by SetupEventNotifyInterrupt hypercall to notify the guest
> about Quote generation completion or failure.
> 
> GetQuote TDVMCALL requires TD guest pass a 4K aligned shared buffer
> with TDREPORT data as input, which is further used by the VMM to copy
> the TD Quote result after successful Quote generation. To create the
> shared buffer without breaking the direct map, allocate physically
> contiguous kernel memory and create a virtual mapping for it using
> vmap(). set_memory_*crypted_noalias() functions can be used to share or
> unshare the vmapped page without affecting the direct map.
> 
> Also note that, shared buffer allocation is currently handled in IOCTL
> handler, although it will increase the TDX_CMD_GET_QUOTE IOCTL response
> time, it is negligible compared to the time required for the quote
> generation completion. So IOCTL performance optimization is not
> considered at this time.
> 
> For shared buffer allocation, alternatives like using the DMA API is
> also considered. Although it simpler to use, it is not preferred because
> dma_alloc_*() APIs require a valid bus device as argument, which would
> need converting the attestation driver into a platform device driver.
> This is unnecessary, and since the attestation driver does not do real
> DMA, there is no need to use real DMA APIs.
> 
> Add support for TDX_CMD_GET_QUOTE IOCTL to allow attestation agent
> submit GetQuote requests from the user space. Since Quote generation
> is an asynchronous request, IOCTL will block indefinitely for the VMM
> response in wait_for_completion_interruptible() call. Using this call
> will also add an option for the user to end the current request
> prematurely by raising any signals. This can be used by attestation
> agent to implement Quote generation timeout feature. If attestation
> agent is aware of time it can validly wait for QE/QGS response, then
> a possible timeout support can be implemented in the user application
> using signals. Quote generation timeout feature is currently not
> implemented in the driver because the current TDX specification does
> not have any recommendation for it.
> 
> After submitting the GetQuote request using hypercall, the shared buffer
> allocated for the current request is owned by the VMM. So, during this
> wait window, if the user terminates the request by raising a signal or
> by terminating the application, add a logic to do the memory cleanup
> after receiving the VMM response at a later time. Such memory cleanup
> support requires accepting the page again using TDX_ACCEPT_PAGE TDX
> Module call. So to not overload the callback IRQ handler, move the
> callback handler logic to a separate work queue.
> 
> To support parallel GetQuote requests, use linked list to track the
> active GetQuote requests and upon receiving the callback IRQ, loop
> through the active requests and mark the processed requests complete.
> Users can open multiple instances of the attestation device and send
> GetQuote requests in parallel.
> 
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Reviewed-by: Andi Kleen <ak@linux.intel.com>
> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> ---
>  arch/x86/coco/tdx/attest.c      | 293 ++++++++++++++++++++++++++++++++
>  arch/x86/include/uapi/asm/tdx.h |  45 +++++
>  2 files changed, 338 insertions(+)
> 
> diff --git a/arch/x86/coco/tdx/attest.c b/arch/x86/coco/tdx/attest.c
> index a5f4111f9b18..5531a1834f8c 100644
> --- a/arch/x86/coco/tdx/attest.c
> +++ b/arch/x86/coco/tdx/attest.c
> @@ -13,16 +13,51 @@
>  #include <linux/miscdevice.h>
>  #include <linux/mm.h>
>  #include <linux/io.h>
> +#include <linux/set_memory.h>
> +#include <linux/mutex.h>
>  #include <asm/tdx.h>
> +#include <asm/coco.h>
>  #include <uapi/asm/tdx.h>
>  
>  #define DRIVER_NAME "tdx-attest"
>  
>  /* TDREPORT module call leaf ID */
>  #define TDX_GET_REPORT			4
> +/* GetQuote hypercall leaf ID */
> +#define TDVMCALL_GET_QUOTE             0x10002
> +
> +/* Used for buffer allocation in GetQuote request */
> +struct quote_buf {
> +	void *vmaddr;
> +	int count;
> +};
> +
> +/* List entry of quote_list*/
> +struct quote_entry {
> +	bool valid;
> +	struct quote_buf *buf;
> +	struct list_head list;
> +	struct completion compl;
> +};
>  
>  static struct miscdevice miscdev;
>  
> +/*
> + * To support parallel GetQuote requests, use the list
> + * to track active GetQuote requests.
> + */
> +static LIST_HEAD(quote_list);
> +
> +/* Lock to protect quote_list */
> +static DEFINE_MUTEX(quote_lock);
> +
> +/*
> + * Workqueue to handle Quote data after Quote generation
> + * notification from VMM.
> + */
> +struct workqueue_struct *quote_wq;
> +struct work_struct quote_work;
> +
>  static long tdx_get_report(void __user *argp)
>  {
>  	void *reportdata = NULL, *tdreport = NULL;
> @@ -71,6 +106,254 @@ static long tdx_get_report(void __user *argp)
>  	return ret;
>  }
>  
> +/* tdx_get_quote_hypercall() - Request to get TD Quote using TDREPORT */
> +static long tdx_get_quote_hypercall(struct quote_buf *buf)
> +{
> +	struct tdx_hypercall_args args = {0};
> +
> +	args.r10 = TDX_HYPERCALL_STANDARD;
> +	args.r11 = TDVMCALL_GET_QUOTE;
> +	args.r12 = cc_mkdec(page_to_phys(vmalloc_to_page(buf->vmaddr)));
> +	args.r13 = buf->count * PAGE_SIZE;
> +
> +	/*
> +	 * Pass the physical address of TDREPORT to the VMM and
> +	 * trigger the Quote generation. It is not a blocking
> +	 * call, hence completion of this request will be notified to
> +	 * the TD guest via a callback interrupt. More info about ABI
> +	 * can be found in TDX Guest-Host-Communication Interface
> +	 * (GHCI), sec titled "TDG.VP.VMCALL<GetQuote>".
> +	 */
> +	return __tdx_hypercall(&args, 0);
> +}
> +
> +/*
> + * alloc_quote_buf() - Used to allocate a shared buffer of
> + *		       given size.
> + *
> + * Size is page aligned and the allocated memory is decrypted
> + * to allow VMM access to it. Uses VMAP to create a shared mapping
> + * for the buffer to not affect the direct map.
> + */
> +static struct quote_buf *alloc_quote_buf(u64 req_size)
> +{
> +	int size = PAGE_ALIGN(req_size);
> +	void *addr = NULL, *vmaddr = NULL;
> +	int count = size >> PAGE_SHIFT;
> +	struct page **pages = NULL;
> +	struct quote_buf *buf;
> +	int i;
> +
> +	buf = kmalloc(sizeof(*buf), GFP_KERNEL);
> +	if (!buf)
> +		return NULL;
> +
> +	addr = alloc_pages_exact(size, GFP_KERNEL);
> +	if (!addr)
> +		goto alloc_failed;
> +
> +	/* Allocate mem for array of page ptrs */
> +	pages = kcalloc(count, sizeof(*pages), GFP_KERNEL);
> +	if (!pages)
> +		goto alloc_failed;
> +
> +	for (i = 0; i < count; i++)
> +		pages[i] = virt_to_page(addr + i * PAGE_SIZE);
> +
> +	/*
> +	 * Use VMAP to create shared mapping without affecting
> +	 * the direct map. Use VM_MAP_PUT_PAGES to allow vmap()
> +	 * responsible for freeing the pages when using vfree().
> +	 */
> +	vmaddr = vmap(pages, count, VM_MAP_PUT_PAGES, PAGE_KERNEL);
> +	if (!vmaddr)
> +		goto alloc_failed;
> +
> +	/* Use noalias variant to not affect the direct mapping */
> +	if (set_memory_decrypted_noalias((unsigned long)vmaddr, count))
> +		goto alloc_failed;
> +
> +	buf->vmaddr = vmaddr;
> +	buf->count = count;
> +
> +	return buf;
> +
> +alloc_failed:
> +	if (!vmaddr) {
> +		kfree(pages);
> +		if (addr)
> +			free_pages_exact(addr, size);
> +	}
> +	vfree(vmaddr);
> +	kfree(buf);
> +	return NULL;
> +}
> +
> +/* Remove the shared mapping and free the buffer */
> +static void free_quote_buf(struct quote_buf *buf)
> +{
> +	if (!buf)
> +		return;
> +
> +	/* Mark pages private */
> +	if (set_memory_encrypted_noalias((unsigned long)buf->vmaddr,
> +				buf->count)) {
> +		pr_warn("Failed to encrypt %d pages at %p", buf->count,
> +				buf->vmaddr);
> +		return;
> +	}
> +
> +	vfree(buf->vmaddr);
> +	kfree(buf);
> +}
> +
> +static struct quote_entry *alloc_quote_entry(u64 buf_len)
> +{
> +	struct quote_entry *entry = NULL;
> +
> +	entry = kmalloc(sizeof(*entry), GFP_KERNEL);
> +	if (!entry)
> +		return NULL;
> +
> +	/* Allocate buffer for quote request */
> +	entry->buf = alloc_quote_buf(buf_len);
> +	if (!entry->buf) {
> +		kfree(entry);
> +		return NULL;
> +	}
> +
> +	init_completion(&entry->compl);
> +	entry->valid = true;
> +
> +	return entry;
> +}
> +
> +static void free_quote_entry(struct quote_entry *entry)
> +{
> +	free_quote_buf(entry->buf);
> +	kfree(entry);
> +}
> +
> +static void add_quote_entry(struct quote_entry *entry)
> +{
> +	mutex_lock(&quote_lock);
> +	list_add_tail(&entry->list, &quote_list);
> +	mutex_unlock(&quote_lock);
> +}
> +
> +static void del_quote_entry(struct quote_entry *entry)
> +{
> +	mutex_lock(&quote_lock);
> +	list_del(&entry->list);
> +	mutex_unlock(&quote_lock);
> +}
> +
> +static void invalidate_quote_request(struct quote_entry *entry)
> +{
> +	mutex_lock(&quote_lock);
> +	entry->valid = false;
> +	mutex_unlock(&quote_lock);
> +}
> +
> +static long tdx_get_quote(void __user *argp)
> +{
> +	struct quote_entry *entry;
> +	struct tdx_quote_req req;
> +	struct quote_buf *buf;
> +	long ret;
> +
> +	/* Copy GetQuote request struct from user buffer */
> +	if (copy_from_user(&req, argp, sizeof(struct tdx_quote_req)))
> +		return -EFAULT;
> +
> +	/* Make sure the length is valid */
> +	if (!req.len)
> +		return -EINVAL;
> +
> +	entry = alloc_quote_entry(req.len);
> +	if (!entry)
> +		return -ENOMEM;
> +
> +	buf = entry->buf;
> +
> +	/* Copy TDREPORT from user buffer to kernel Quote buffer */
> +	if (copy_from_user(buf->vmaddr, (void __user *)req.buf, req.len)) {
> +		free_quote_entry(entry);
> +		return -EFAULT;
> +	}
> +
> +	/* Submit GetQuote Request */
> +	ret = tdx_get_quote_hypercall(buf);
> +	if (ret) {
> +		pr_err("GetQuote hypercall failed, status:%lx\n", ret);
> +		free_quote_entry(entry);
> +		return -EIO;
> +	}
> +
> +	/* Add current quote entry to quote_list to track active requests */
> +	add_quote_entry(entry);

There is a race condition. Interrupt can arrive after hypercall and before
list_add_tail and workqueue can run before reaching add_quote_entry().  lock
around both hypercall and list_add_tail. i.e. lock, hypercall, list_add_tail,
unlock.


> +
> +	/* Wait for attestation completion */
> +	ret = wait_for_completion_interruptible(&entry->compl);
> +	if (ret < 0) {
> +		/*
> +		 * For premature termination, since VMM still owns the
> +		 * shared buffer, mark the request invalid to let
> +		 * quote_callback_handler() handle the memory cleanup
> +		 * function.
> +		 */
> +		invalidate_quote_request(entry);

Interrupt can arrive after signal interrupt.  So invalidate_quote_request()
should check if the request is already processed, and return 0 or -EINTR.
Probably check the state always and del_list under single lock/unlock pair.


> +		return -EINTR;
> +	}
> +
> +	/*
> +	 * If GetQuote request completed successfully, copy the result
> +	 * back to the user and do the cleanup.
> +	 */
> +	if (copy_to_user((void __user *)req.buf, buf->vmaddr, req.len))
> +		ret = -EIO;

-EFAULT.


> +
> +	/*
> +	 * Reaching here means GetQuote request is processed
> +	 * successfully. So do the cleanup.
> +	 */
> +	del_quote_entry(entry);
> +	free_quote_entry(entry);
> +
> +	return 0;
> +}
> +
> +static void attestation_callback_handler(void)
> +{
> +	queue_work(quote_wq, &quote_work);
> +}
> +
> +static void quote_callback_handler(struct work_struct *work)
> +{
> +	struct tdx_quote_hdr *quote_hdr;
> +	struct quote_entry *entry, *next;
> +
> +	/* Find processed quote request and mark it complete */
> +	mutex_lock(&quote_lock);
> +	list_for_each_entry_safe(entry, next, &quote_list, list) {
> +		quote_hdr = (struct tdx_quote_hdr *)entry->buf->vmaddr;
> +		if (quote_hdr->status == GET_QUOTE_IN_FLIGHT)
> +			continue;
> +		/*
> +		 * If user invalidated the current request, remove the
> +		 * entry from the quote list and free it. If the request
> +		 * is still valid, mark it complete.
> +		 */
> +		if (entry->valid) {
> +			complete(&entry->compl);
> +		} else {
> +			list_del(&entry->list);
> +			free_quote_entry(entry);
> +		}
> +	}
> +	mutex_unlock(&quote_lock);
> +}
> +
>  static long tdx_attest_ioctl(struct file *file, unsigned int cmd,
>  			     unsigned long arg)
>  {
> @@ -81,6 +364,9 @@ static long tdx_attest_ioctl(struct file *file, unsigned int cmd,
>  	case TDX_CMD_GET_REPORT:
>  		ret = tdx_get_report(argp);
>  		break;
> +	case TDX_CMD_GET_QUOTE:
> +		ret = tdx_get_quote(argp);
> +		break;
>  	default:
>  		pr_debug("cmd %d not supported\n", cmd);
>  		break;
> @@ -103,6 +389,13 @@ static int __init tdx_attestation_init(void)
>  	if (!cpu_feature_enabled(X86_FEATURE_TDX_GUEST))
>  		return -EIO;
>  
> +	quote_wq = create_singlethread_workqueue("tdx_quote_handler");
> +
> +	INIT_WORK(&quote_work, quote_callback_handler);
> +
> +	/* Register attestation event notify handler */
> +	tdx_setup_ev_notify_handler(attestation_callback_handler);
> +
>  	miscdev.name = DRIVER_NAME;
>  	miscdev.minor = MISC_DYNAMIC_MINOR;
>  	miscdev.fops = &tdx_attest_fops;
> diff --git a/arch/x86/include/uapi/asm/tdx.h b/arch/x86/include/uapi/asm/tdx.h
> index e06da56058a1..76a9e71e7b39 100644
> --- a/arch/x86/include/uapi/asm/tdx.h
> +++ b/arch/x86/include/uapi/asm/tdx.h
> @@ -39,4 +39,49 @@ struct tdx_report_req {
>   */
>  #define TDX_CMD_GET_REPORT		_IOWR('T', 0x01, struct tdx_report_req)
>  
> +/* struct tdx_quote_req: Request to generate TD Quote using TDREPORT
> + *
> + * @buf		: Pass user data that includes TDREPORT as input. Upon
> + *		  successful completion of IOCTL, output is copied
> + *		  back to the same buffer.
> + * @len		: Length of the buffer.
> + */
> +struct tdx_quote_req {
> +	__u64 buf;
> +	__u64 len;
> +};
> +
> +/*
> + * TDX_CMD_GET_QUOTE - Get TD Quote from QE/QGS using GetQuote
> + *		       TDVMCALL.
> + *
> + * Returns 0 on success, -EINTR for interrupted request, and
> + * standard errono on other failures.
> + */
> +#define TDX_CMD_GET_QUOTE		_IOR('T', 0x02, struct tdx_quote_req)
> +
> +/* TD Quote status codes */
> +#define GET_QUOTE_SUCCESS		0
> +#define GET_QUOTE_IN_FLIGHT		0xffffffffffffffff
> +#define GET_QUOTE_ERROR			0x8000000000000000
> +#define GET_QUOTE_SERVICE_UNAVAILABLE	0x8000000000000001
> +
> +/*
> + * Format of Quote data header. More details can be found in TDX
> + * Guest-Host Communication Interface (GHCI) for Intel TDX 1.0,
> + * section titled "TDG.VP.VMCALL<GetQuote>"
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
> +	__u64 data[0];
> +};
> +
>  #endif /* _UAPI_ASM_X86_TDX_H */
> -- 
> 2.25.1
> 

-- 
Isaku Yamahata <isaku.yamahata@gmail.com>
