Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3BDF52AEA0
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 01:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231827AbiEQXcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 19:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231833AbiEQXcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 19:32:05 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9DD02B1B8
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 16:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652830323; x=1684366323;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=myRbsDC5rprZHcC4t56ThhaCXwfwd8Lxxx25VPDQnbU=;
  b=jKyujzN5WGlGwfwckuetw7Sd9KJty7EXJqPf2j7OtCaFceinfJH/TD6g
   KyiFvMR5qdvO1LyZeCiPyXdfgdeiBSzmG9PMPvuOSDf5pjPR5ax+oG7R5
   GRaRbUh8UJfonmr64cmv/J3CqZWNdyDsA53syqMy3IGeKuti1gkIj6w4N
   ckh5vFUww7j/CZdPphPc1I9wp+XWcZS1KyIJbxKUD5oEqy9XUf1U06HsK
   Gel9WjhbJLn/Ofs1CF4cgRWb5+OoBxsgygjNte7Rmkf5Dzsqv/ctHGMQ0
   7qym25MUPXMt5iTHm5nxR0lnKrGoubADhtGG5LsfTS3sUlOeUfaEfXYdO
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10350"; a="296669102"
X-IronPort-AV: E=Sophos;i="5.91,233,1647327600"; 
   d="scan'208";a="296669102"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2022 16:32:03 -0700
X-IronPort-AV: E=Sophos;i="5.91,233,1647327600"; 
   d="scan'208";a="597408881"
Received: from gyhughes-mobl1.amr.corp.intel.com (HELO [10.212.165.9]) ([10.212.165.9])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2022 16:32:02 -0700
Message-ID: <5e22f88f-fbef-0031-067f-1abd5cdaecb8@linux.intel.com>
Date:   Tue, 17 May 2022 16:32:02 -0700
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
 <145b19b7-00e1-3542-a99d-866539081add@linux.intel.com>
 <40caabe4c708b35844c246ec6a01b4ee03cbfa63.camel@intel.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <40caabe4c708b35844c246ec6a01b4ee03cbfa63.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/17/22 4:06 PM, Kai Huang wrote:
> On Tue, 2022-05-17 at 13:08 -0700, Sathyanarayanan Kuppuswamy wrote:
>>
>> On 5/16/22 7:58 PM, Kai Huang wrote:
>>> On Fri, 2022-05-13 at 12:29 -0700, Sathyanarayanan Kuppuswamy wrote:
>>>>>
>>>>>
>>>>>> +
>>>>>> +	/* Wait for attestation completion */
>>>>>> +	ret = wait_for_completion_interruptible(&entry->compl);
>>>>>> +	if (ret < 0) {
>>>>>> +		/*
>>>>>> +		 * For premature termination, since VMM still owns the
>>>>>> +		 * shared buffer, mark the request invalid to let
>>>>>> +		 * quote_callback_handler() handle the memory cleanup
>>>>>> +		 * function.
>>>>>> +		 */
>>>>>> +		invalidate_quote_request(entry);
>>>>>
>>>>> Interrupt can arrive after signal interrupt.  So invalidate_quote_request()
>>>>> should check if the request is already processed, and return 0 or -EINTR.
>>>>> Probably check the state always and del_list under single lock/unlock pair.
>>>>
>>>> Agree. But I think we should return -EINTR for the interrupted case
>>>> irrespective of the processed status (so no return 0).
>>>>
>>>> I will hold the lock and handle the cleanup for the processed
>>>> status.
>>>
>>> Even if we check the buffer status in invalidate_quote_request(), there's no
>>> guarantee the VMM won't change the buffer status _after_ we do the check, so
>>> looks such check isn't necessary.
>>>
>>
>> Consider the case where we get a callback interrupt, and before we
>> complete the processing for it, user terminates the request. In this
>> scenario,  quote_callback_handler() will consider the request is
>> still valid and no do the memory cleanup. To handle this case,
>> we need to check the status in invalidate_quote_request() and do
>> the cleanup if required.
>>
>> /* Handles early termination of GetQuote requests */
>> void invalidate_quote_request(struct quote_entry *entry)
>> {
>>           struct tdx_quote_hdr *quote_hdr;
>>
>>           /*
>>            * For early termination, if the request is not yet
>>            * processed by VMM (GET_QUOTE_IN_FLIGHT), the VMM
>>            * still owns the shared buffer, so mark the request
>>            * invalid to let quote_callback_handler() handle the
>>            * memory cleanup function. If the request is already
>>            * processed, then do the cleanup and return.
>>            */
>>
>>           mutex_lock(&quote_lock);
>>           quote_hdr = (struct tdx_quote_hdr *)entry->buf->vmaddr;
>>           if (quote_hdr->status == GET_QUOTE_IN_FLIGHT) {
> 
> What prevents VMM from updating quote_hdr->status from IN_FLIGHT to DONE _after_
> this check?

If IN_FLIGHT -> DONE happens at this point, you will get a separate
callback interrupt for it after this change. Since we hold quote_lock
here, processing of that callback work will wait till we make the
request invalid. For invalid requests, quote_callback_handler() will
handle the cleanup.

This logic is mainly for the case where quote_callback_handler() in
process and user terminates the request. In this case,
quote_callback_handler() will not do the cleanup, and we should add
logic here to handle it.

> 
> If you want to add such check, you should check against GET_QUOTE_DONE, but not
> IN_FLIGHT.  Only after status is DONE,  VMM will not update the buffer.  Perhaps
> something like below:
> 
> 	mutex_lock(&quote_lock);
> 	/* Skip invalidate the buffer if VMM has done with the buffer */
> 	if (quote_hdr->status == GET_QUOTE_DONE) {
> 		mutex_unlock(&quote_lock);
> 		return 0;
> 	}

There is no DONE status. Status can be either one of the following values.

GET_QUOTE_ERROR
GET_QUOTE_SUCCESS
GET_QUOTE_SERVICE_UNAVAILABLE
GET_QUOTE_IN_FLIGHT

> 
> And in the IOCTL, you can perhaps to choose to return 0, instead of -EINTR in
> this case, as the Quote has been finished already.

I think your logic above is to return 0 for the completed request even
if it is interrupted. But IMO, since the user already interrupted the
request, then I think it is more appropriate to just return -EINTR for
this case.

> 
> But I am not sure whether this is necessary.  The worst case is one finished
> Quote is wasted I guess.

> 
>>                   entry->valid = false;
>>                   mutex_unlock(&quote_lock);
>>                   return;
>>           }
>>           _del_quote_entry(entry);
>>           mutex_unlock(&quote_lock);
>> }
>>
>>
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
