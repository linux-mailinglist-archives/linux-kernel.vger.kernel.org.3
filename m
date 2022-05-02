Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1729E5173AB
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 18:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347559AbiEBQHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 12:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386145AbiEBQGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 12:06:51 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBF9813F47
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 09:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651507371; x=1683043371;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=KBeRLrN5kv3noIyPri6QAd7wn59IyT9R4gQ29Lb1Sro=;
  b=fxGnrEbHjt031uucAZrzL8dA823hgzHBGsItyzf7AR2ChteiJ8hKaOXV
   TqpdaUB7YORtAlX2gzYz+njluysXdKUCgXwRANy6OnDdfpBgBwYumy9vz
   3uUuz874jGGseM++oPUpOMKEKt9PN8lWmu6zHNx4U0jBKJA0S1AR6SwSO
   blRuglIeTf4gf/xf294nEJJGqyV35+1wmuiy+WeoUktTO9a8j1Cm5LC9N
   ueuvCuu7VJUS4TlqhkSEfwCHrXxOlLiti2zkp9X4uAnMh07PuLhpd+ZMO
   e3iuN/N3TcDmqJfcV5iHrY9JJb1gua48yNvPmqZM4aFE+eijwIIEv2cHi
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10335"; a="330238577"
X-IronPort-AV: E=Sophos;i="5.91,192,1647327600"; 
   d="scan'208";a="330238577"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2022 09:02:37 -0700
X-IronPort-AV: E=Sophos;i="5.91,192,1647327600"; 
   d="scan'208";a="583766235"
Received: from wahmed-mobl.amr.corp.intel.com (HELO [10.209.71.202]) ([10.209.71.202])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2022 09:02:30 -0700
Message-ID: <aae6c58c-a89f-e24c-946b-c16b2415c77e@linux.intel.com>
Date:   Mon, 2 May 2022 09:02:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.7.0
Subject: Re: [PATCH v5 3/3] x86/tdx: Add Quote generation support
Content-Language: en-US
To:     Kai Huang <kai.huang@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc:     "H . Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Wander Lairson Costa <wander@redhat.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        linux-kernel@vger.kernel.org
References: <20220501183500.2242828-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20220501183500.2242828-4-sathyanarayanan.kuppuswamy@linux.intel.com>
 <7daf429ffda2bf834c129899426e204fbbcbd0b0.camel@intel.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <7daf429ffda2bf834c129899426e204fbbcbd0b0.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kai,

On 5/1/22 10:01 PM, Kai Huang wrote:
> 
>> +
>> +static long tdx_get_quote(void __user *argp)
>> +{
>> +	struct tdx_quote_req quote_req;
>> +	long ret = 0;
>> +	int order;
>> +
>> +	/* Hold lock to serialize GetQuote requests */
>> +	mutex_lock(&quote_lock);
>> +
>> +	reinit_completion(&req_compl);
>> +
>> +	/* Copy GetQuote request struct from user buffer */
>> +	if (copy_from_user(&quote_req, argp, sizeof(struct tdx_quote_req))) {
>> +		ret = -EFAULT;
>> +		goto quote_failed;
>> +	}
>> +
>> +	/* Make sure the length & timeout is valid */
>> +	if (!quote_req.len || !quote_req.timeout) {
>> +		ret = -EINVAL;
>> +		goto quote_failed;
>> +	}
>> +
>> +	/* Get order for Quote buffer page allocation */
>> +	order = get_order(quote_req.len);
>> +
>> +	/*
>> +	 * Allocate buffer to get TD Quote from the VMM.
>> +	 * Size needs to be 4KB aligned (which is already
>> +	 * met in page allocation).
>> +	 */
>> +	tdquote = (void *)__get_free_pages(GFP_KERNEL | __GFP_ZERO, order);
>> +	if (!tdquote) {
>> +		ret = -ENOMEM;
>> +		goto quote_failed;
>> +	}
>> +
>> +	/*
>> +	 * Since this buffer will be shared with the VMM via GetQuote
>> +	 * hypercall, decrypt it.
>> +	 */
>> +	ret = set_memory_decrypted((unsigned long)tdquote, 1UL << order);
>> +	if (ret)
>> +		goto quote_failed;
>> +
>> +	/* Copy TDREPORT from user buffer to kernel Quote buffer */
>> +	if (copy_from_user(tdquote, (void __user *)quote_req.buf, quote_req.len)) {
>> +		ret = -EFAULT;
>> +		goto quote_failed;
>> +	}
>> +
>> +	/* Submit GetQuote Request */
>> +	ret = tdx_get_quote_hypercall(tdquote, (1ULL << order) * PAGE_SIZE);
>> +	if (ret) {
>> +		pr_err("GetQuote hypercall failed, status:%lx\n", ret);
>> +		ret = -EIO;
>> +		goto quote_failed;
>> +	}
>> +
>> +	/* Wait for attestation completion */
>> +	ret = wait_for_completion_interruptible(&req_compl);
>> +	if (ret <= 0) {
>> +		ret = -EIO;
>> +		goto quote_failed;
>> +	}
>> +
>> +	/* Copy output data back to user buffer */
>> +	if (copy_to_user((void __user *)quote_req.buf, tdquote, quote_req.len))
>> +		ret = -EFAULT;
>> +
>> +quote_failed:
>> +	if (tdquote)
>> +		free_pages((unsigned long)tdquote, order);
> 
> The buffer is freed w/o being converted back to private.  How can you prevent
> the buffer from being allocated by kernel and used as private pages again?

Yes. It needs set_memory_encrypted() call here. I will fix this in next
version.

> 
> Also, the  buffer may be still used by VMM when timeout (IN_FLIGHT), how can
> this even work?

We will never reach here for IN_FLIGHT case. We will block in
wait_for_completion_interruptible() till the status changes to success
or failure.

> 
>> +	tdquote = NULL;
>> +	mutex_unlock(&quote_lock);
>> +	return ret;
>> +}
>> +
>> +static void attestation_callback_handler(void)
>> +{
>> +	struct tdx_quote_hdr *quote_hdr;
>> +
>> +	quote_hdr = (struct tdx_quote_hdr *) tdquote;
>> +
>> +	/* Check for spurious callback IRQ case */
>> +	if (!tdquote || quote_hdr->status == GET_QUOTE_IN_FLIGHT)
>> +		return;
> 
> I don't get the logic.  Please explain.

I am trying to handle spurious IRQ case here. If we receive a callback
IRQ from VMM before even we allocate tdquote or post the GetQuote
request, accessing quote_hdr->status will lead to NULL pointer
exception. So I have added check for valid quote buffer (tdquote !=
NULL)

Second condition (quote_hdr->status == GET_QUOTE_IN_FLIGHT)) makes
sure we don't mark the current quote request complete until the
Quote buffer status changes to GET_QUOTE_SUCCESS, GET_QUOTE_ERROR or
GET_QUOTE_SERVICE_UNAVAILABLE.

> 
>> +
>> +	complete(&req_compl);
>> +}
>> +
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
