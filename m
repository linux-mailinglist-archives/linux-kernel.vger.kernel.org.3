Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 826BD57BEEF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 22:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbiGTUCP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 16:02:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiGTUCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 16:02:13 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B83D0419A0;
        Wed, 20 Jul 2022 13:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658347332; x=1689883332;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=dHZEgzph0FJ1oHjaT4tPvKxwZIKWqbLw2YLcAk4HGGo=;
  b=ZyhyvwPXUH/cmyyTjGvRxe/S+CJITwfMQeeWpAN2R8wPcX+Ouix+d8G5
   htbN+dRUUCwuvXRz6XDdeT9F7biRM/NZ7VxDJuQ5QrKlg31KP7qBaxDV3
   ELGP6alMzmCJJYucTxdEAKtBLKFd9Pd/kIxQErRP2kMnewtt64iTzw9pd
   ZUONgt+V+GBW8FIhOJ29nWw6pioVtabAwgZDA7KOKAooAk/23SvxnRzDO
   N64pPbx9PZM1fxY6XLaWFzSM2KIGgS0RZOTIQUsVZEWTUCgfV/B3Lu37J
   5VTmRf8nz1zGb7s7KQPdhC4l9VuaZLd5ysbR+gSnrCx19qiUkpbVHGTpG
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10414"; a="273714247"
X-IronPort-AV: E=Sophos;i="5.92,287,1650956400"; 
   d="scan'208";a="273714247"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2022 13:02:12 -0700
X-IronPort-AV: E=Sophos;i="5.92,287,1650956400"; 
   d="scan'208";a="573448514"
Received: from dgovor-mobl1.amr.corp.intel.com (HELO [10.209.89.58]) ([10.209.89.58])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2022 13:02:11 -0700
Message-ID: <00b07459-5512-b00b-636b-f35845ec369f@intel.com>
Date:   Wed, 20 Jul 2022 13:02:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] [v2] x86/sgx: Allow enclaves to use Asynchrounous Exit
 Notification
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     dave@sr71.net, Jarkko Sakkinen <jarkko@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Kai Huang <kai.huang@intel.com>,
        Haitao Huang <haitao.huang@linux.intel.com>, x86@kernel.org,
        linux-sgx@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220720191347.1343986-1-dave.hansen@linux.intel.com>
 <YthcXSTfjoM+jjvN@google.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <YthcXSTfjoM+jjvN@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/20/22 12:49, Sean Christopherson wrote:
> On Wed, Jul 20, 2022, Dave Hansen wrote:
>> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
>> index 0c1ba6aa0765..96a73b5b4369 100644
>> --- a/arch/x86/kvm/cpuid.c
>> +++ b/arch/x86/kvm/cpuid.c
>> @@ -1022,9 +1022,7 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
>>  		 * userspace.  ATTRIBUTES.XFRM is not adjusted as userspace is
>>  		 * expected to derive it from supported XCR0.
>>  		 */
>> -		entry->eax &= SGX_ATTR_DEBUG | SGX_ATTR_MODE64BIT |
>> -			      SGX_ATTR_PROVISIONKEY | SGX_ATTR_EINITTOKENKEY |
>> -			      SGX_ATTR_KSS;
>> +		entry->eax &= SGX_ATTR_PRIV_MASK | SGX_ATTR_UNPRIV_MASK;
> 
> It may seem like a maintenance burdern, and it is to some extent, but I think it's
> better for KVM to have to explicitly "enable" each flag.  There is no guarantee
> that a new feature will not require additional KVM enabling, i.e. we want the pain
> of having to manually update KVM so that we get "feature X isn't virtualized"
> complaints and not "I upgraded my kernel and my enclaves broke" bug reports.
> 
> I don't think it's likely that attribute-based features will require additional
> enabling since there aren't any virtualization controls for the ENCLU side of
> things (ENCLU is effectively disabled by blocking ENCLS[ECREATE]), but updating
> KVM isn't particularly difficult so I'd rather be paranoid.

How about something where KVM gets to keep a discrete mask, but where
it's at least defined next to the attributes, something like:

/*
 * These attributes will be advertised to KVM guests as being
 * available.  This includes privileged attributes.  Only add
 * to this list when host-side KVM does not require additional
 * enabling for the attribute.
 */
#define SGX_ATTR_KVM_MASK       (SGX_ATTR_DEBUG         | \
                                 SGX_ATTR_MODE64BIT     | \
                                 SGX_ATTR_PROVISIONKEY  | \
                                 SGX_ATTR_EINITTOKENKEY | \
                                 SGX_ATTR_KSS           | \
                                 SGX_ATTR_ASYNC_EXIT_NOTIFY)

That at least has a *chance* of someone seeing it who goes to add a new
attribute.
