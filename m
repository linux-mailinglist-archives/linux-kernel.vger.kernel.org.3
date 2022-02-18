Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 256B04BBC2E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 16:28:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237005AbiBRP2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 10:28:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234592AbiBRP21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 10:28:27 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 607EC253BD6
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 07:28:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645198089; x=1676734089;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=8F+hvQh1HLTFJ48iQkIz9GfpLjZw8N6VD1IhLKkIiqQ=;
  b=WnSOMzAVyYjVRbA3/7J3WjwAbIBY+q3GmpI09Pnyt/mC3ZJOqMvj7WUa
   XqJJMMrGY8jwQ6F0JaOKkO7MGmJ7Animg/JDOsMmCxgdDHyb/a/DkpwE/
   OP/VUt/9bu98oNLuhlBNdmJoDkEC1I6uquuazCuuFDLTy/bj91KyU3dpQ
   7FG6GIXAvXZrwZH22VpBTAHt0m6G2NJxUYy70l1PxwV1hLPM/JsadBBak
   YjKZS1PCM6W1kPAk2W0TshrdlqYq0DiXZtg1KZaL+noMo4RzXNWeZXYJ4
   XRNESyLrqdpBCh/IgSMS9WaBaF8fXXNjn0cskw0Ahi7FmncRcMYcosw5P
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10261"; a="238549537"
X-IronPort-AV: E=Sophos;i="5.88,379,1635231600"; 
   d="scan'208";a="238549537"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2022 07:28:09 -0800
X-IronPort-AV: E=Sophos;i="5.88,379,1635231600"; 
   d="scan'208";a="705412534"
Received: from ttisa-mobl1.amr.corp.intel.com (HELO [10.212.198.60]) ([10.212.198.60])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2022 07:28:08 -0800
Message-ID: <311ef2df-dd49-0711-aa8b-fa88a87ff196@intel.com>
Date:   Fri, 18 Feb 2022 07:28:04 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-kernel@vger.kernel.org
References: <20220127175505.851391-1-ira.weiny@intel.com>
 <20220127175505.851391-20-ira.weiny@intel.com>
 <00b87c5f-b4ed-7593-827c-0e1114b8b456@intel.com>
 <Yg8v8XPyDTH4O2rr@iweiny-desk3>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH V8 19/44] mm/pkeys: PKS Testing, add pks_mk_*() tests
In-Reply-To: <Yg8v8XPyDTH4O2rr@iweiny-desk3>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/17/22 21:34, Ira Weiny wrote:
> On Tue, Feb 01, 2022 at 09:45:03AM -0800, Dave Hansen wrote:
>> On 1/27/22 09:54, ira.weiny@intel.com wrote:
>>>  bool pks_test_callback(void)
>>>  {
>>> -	return false;
>>> +	bool armed = (test_armed_key != 0);
>>> +
>>> +	if (armed) {
>>> +		pks_mk_readwrite(test_armed_key);
>>> +		fault_cnt++;
>>> +	}
>>> +
>>> +	return armed;
>>> +}
>>
>> Where's the locking for all this?  I don't think we need anything fancy,
>> but is there anything preventing the test from being started from
>> multiple threads at the same time?  I think a simple global test mutex
>> would probably suffice.
> 
> Good idea.  Generally I don't see that happening but it is good to be safe.

I'm not sure what you mean.

In the kernel, we always program as if userspace is out to get us.  If
userspace can possibly do something to confuse the kernel, it will.  It
might be malicious or incompetent, but it will happen.

This isn't really a "good to be safe" kind of thing.  Kernel code must
*be* safe.

>> Also, pks_test_callback() needs at least a comment or two about what
>> it's doing.
> 
> The previous patch which adds this call in the fault handler contains the
> following comment which is in the final code:
> 
> /*
>  * pks_test_callback() is called by the fault handler to indicate it saw a pkey
>  * fault.
>  *
>  * NOTE: The callback is responsible for clearing any condition which would
>  * cause the fault to re-trigger.
>  */
> 
> Would you like more comments within the function?

Ahh, it just wasn't in the context.

Looking at this again, I don't really like the name "callback" is almost
always a waste of bytes.  Imagine this was named something like:

	pks_test_induced_fault();

... and had a comment like:

/*
 * Ensure that the fault handler does not treat
 * test-induced faults as actual errors.
 */

>> Does this work if you have a test armed and then you get an unrelated
>> PKS fault on another CPU?  I think this will disarm the test from the
>> unrelated thread.
> 
> This code will detect a false fault.  

That's a bug that's going to get fixed, right? ;)

