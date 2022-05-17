Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1BFC52AC79
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 22:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245204AbiEQUIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 16:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233463AbiEQUIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 16:08:32 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCC5B50015
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 13:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652818111; x=1684354111;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=YRQr0n/uot8+h2hfpkEQa750LRQnbJfIFOiEsThKuHY=;
  b=SKDKYkEe4wUAjUUbIJ1v6Hr3hD0EgwHn9gOx3rwsv5epcLxM2ZW2TLae
   AQgcOGvRCQgsfeZXbdSIoZwjJkJ31kANogTvcSIE/sygrIwV91Vo09tOx
   DGcfPEavJFe2hl6Ap9s8CC7jZsqbVZmk2qXwxXi6h6hhJ0Q4wmV3yz950
   gQD21kdqTTI+m9i59f8V5+To6vDqvwvk3/qRJIySg1xV6Tn9YybmpBcIM
   aWou7pdHPBKSX8uABtYzPpwzcGzys6/60NXUMVUJv/ieJYbjvmiY06sDm
   xR3AZf+7Jp9H2QlYBmDy2CaR+BqnXis18rOnOzOA4ihVhCgZAIXHwMI+U
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10350"; a="271005103"
X-IronPort-AV: E=Sophos;i="5.91,233,1647327600"; 
   d="scan'208";a="271005103"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2022 13:08:31 -0700
X-IronPort-AV: E=Sophos;i="5.91,233,1647327600"; 
   d="scan'208";a="597324846"
Received: from gyhughes-mobl1.amr.corp.intel.com (HELO [10.212.165.9]) ([10.212.165.9])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2022 13:08:29 -0700
Message-ID: <145b19b7-00e1-3542-a99d-866539081add@linux.intel.com>
Date:   Tue, 17 May 2022 13:08:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.8.1
Subject: Re: [PATCH v6 5/5] x86/tdx: Add Quote generation support
Content-Language: en-US
To:     Kai Huang <kai.huang@intel.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Wander Lairson Costa <wander@redhat.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        linux-kernel@vger.kernel.org
References: <20220512221952.3647598-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20220512221952.3647598-6-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20220513185824.GB2913259@ls.amr.corp.intel.com>
 <c07c9fa1-ff6a-df8a-6050-60ade29367f3@linux.intel.com>
 <38a7c7406f0b0c65e68679fb8399ffe3fae05cb2.camel@intel.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <38a7c7406f0b0c65e68679fb8399ffe3fae05cb2.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/16/22 7:58 PM, Kai Huang wrote:
> On Fri, 2022-05-13 at 12:29 -0700, Sathyanarayanan Kuppuswamy wrote:
>>>
>>>
>>>> +
>>>> +	/* Wait for attestation completion */
>>>> +	ret = wait_for_completion_interruptible(&entry->compl);
>>>> +	if (ret < 0) {
>>>> +		/*
>>>> +		 * For premature termination, since VMM still owns the
>>>> +		 * shared buffer, mark the request invalid to let
>>>> +		 * quote_callback_handler() handle the memory cleanup
>>>> +		 * function.
>>>> +		 */
>>>> +		invalidate_quote_request(entry);
>>>
>>> Interrupt can arrive after signal interrupt.  So invalidate_quote_request()
>>> should check if the request is already processed, and return 0 or -EINTR.
>>> Probably check the state always and del_list under single lock/unlock pair.
>>
>> Agree. But I think we should return -EINTR for the interrupted case
>> irrespective of the processed status (so no return 0).
>>
>> I will hold the lock and handle the cleanup for the processed
>> status.
> 
> Even if we check the buffer status in invalidate_quote_request(), there's no
> guarantee the VMM won't change the buffer status _after_ we do the check, so
> looks such check isn't necessary.
> 

Consider the case where we get a callback interrupt, and before we
complete the processing for it, user terminates the request. In this
scenario,  quote_callback_handler() will consider the request is
still valid and no do the memory cleanup. To handle this case,
we need to check the status in invalidate_quote_request() and do
the cleanup if required.

/* Handles early termination of GetQuote requests */
void invalidate_quote_request(struct quote_entry *entry)
{
         struct tdx_quote_hdr *quote_hdr;

         /*
          * For early termination, if the request is not yet
          * processed by VMM (GET_QUOTE_IN_FLIGHT), the VMM
          * still owns the shared buffer, so mark the request
          * invalid to let quote_callback_handler() handle the
          * memory cleanup function. If the request is already
          * processed, then do the cleanup and return.
          */

         mutex_lock(&quote_lock);
         quote_hdr = (struct tdx_quote_hdr *)entry->buf->vmaddr;
         if (quote_hdr->status == GET_QUOTE_IN_FLIGHT) {
                 entry->valid = false;
                 mutex_unlock(&quote_lock);
                 return;
         }
         _del_quote_entry(entry);
         mutex_unlock(&quote_lock);
}


-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
