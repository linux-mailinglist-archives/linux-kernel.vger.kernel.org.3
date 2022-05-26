Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6539853518A
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 17:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbiEZPhY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 11:37:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232249AbiEZPhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 11:37:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6CCB7BDA3A
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 08:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653579439;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Bj94L2IvxNOeKDHuJZKq8s0G+bkC8HQOBznq/WJnoNY=;
        b=T+b/sUQxz88KU+vq22j+yIiwTLWmVpVMZrwESV0nzVY10n5jzlYgrnSNy/CcMMdX9Hd1Yg
        pldPUVK/p9Yz10v0djp7YF7lBqYqxSNEWlwUQFubqvkQRP/cdVEE5QRTHMOSH7wzZOkChB
        FWrytnSbxJ8BgLS3B6AE5G4YjUpUbg4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-630-KWe_HMoXMd6iwASx8Oj5Sw-1; Thu, 26 May 2022 11:37:16 -0400
X-MC-Unique: KWe_HMoXMd6iwASx8Oj5Sw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 58E95858F00;
        Thu, 26 May 2022 15:37:15 +0000 (UTC)
Received: from fedora (unknown [10.22.16.201])
        by smtp.corp.redhat.com (Postfix) with SMTP id C1CB92166B26;
        Thu, 26 May 2022 15:37:11 +0000 (UTC)
Date:   Thu, 26 May 2022 12:37:10 -0300
From:   Wander Lairson Costa <wander@redhat.com>
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
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 5/5] x86/tdx: Add Quote generation support
Message-ID: <Yo+epmvA0U0+m3/C@fedora>
References: <20220524040517.703581-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20220524040517.703581-6-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220524040517.703581-6-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 23, 2022 at 09:05:17PM -0700, Kuppuswamy Sathyanarayanan wrote:
> +
> +/* Used for buffer allocation in GetQuote request */
> +struct quote_buf {
> +	/* vmapped address of kernel buffer (size is page aligned) */
> +	void *vmaddr;
> +	/* Number of pages */
> +	int count;
> +};
> +
> +/* List entry of quote_list */
> +struct quote_entry {
> +	/* Flag to check validity of the GetQuote request */
> +	bool valid;
> +	/* Kernel buffer to share data with VMM */
> +	struct quote_buf *buf;

Instead of a pointer, we can embed the quote_buf object directly into the
quote_entry. alloc_quote_buf would receive a pointer to quote_buf, and would
only allocate vmaddr (may we should change the names from alloc/free to
init/deinit). This way we can save one memory allocation and have a
simpler code. Not to mention is one less pointer to track its lifetime.

> +	/* Completion object to track completion of GetQuote request */
> +	struct completion compl;
> +	struct list_head list;
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
> @@ -71,6 +111,270 @@ static long tdx_get_report(void __user *argp)
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
> + * to allow VMM to access it. Uses VMAP to create a virtual
> + * mapping, which is further used to create a shared mapping
> + * for the buffer without affecting the direct map.
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
> +	 * Use VMAP to create a virtual mapping, which is used
> +	 * to create shared mapping without affecting the
> +	 * direct map. Use VM_MAP_PUT_PAGES to allow vmap()
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

