Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4199B4E9FA6
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 21:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238472AbiC1TTT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 15:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234167AbiC1TTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 15:19:17 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFCED66F98
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 12:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648495056; x=1680031056;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=trpX5tdxgjQO3JI80yKQLz7qoKVtzUFR4QPu1Q6nHKE=;
  b=TXT/hTB1zSuAkrmNRAzHoA49lOeo0UsXPSk5HkzPk7VZIBJ1KOHsNK+T
   XgnF92xH5DeFQhPFeASPCRojgTVeW3AOIIbDkOzkuWEG9dqBPI6br5Jkz
   2QQNIoujeOOBZy86gNF5mDTzMb+MvXUjkPY2tVhxqTnuyKNqUdtdUdlnp
   QTSsg08+VUVZYJgBsfvp8MoR49s3fZq9joGs09UpvnwYJqyMBELiQGFi1
   jGauo86KaTjoA1l4XXMJN3FybPFA5C5WC/UKlDB46mT13OPENoOHA+8gv
   fsNBErAVpkKKuOGsMhMWAMM1tQXQGx7ppjr6hQw5N626ib0e2l3Y9UN4n
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10300"; a="258800543"
X-IronPort-AV: E=Sophos;i="5.90,218,1643702400"; 
   d="scan'208";a="258800543"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2022 12:17:36 -0700
X-IronPort-AV: E=Sophos;i="5.90,218,1643702400"; 
   d="scan'208";a="832002398"
Received: from weiweihx-mobl.amr.corp.intel.com (HELO [10.255.229.113]) ([10.255.229.113])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2022 12:17:34 -0700
Message-ID: <4c0c05a8-08f2-7d5d-6746-a92d0d3c5ef0@intel.com>
Date:   Mon, 28 Mar 2022 12:17:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        luto@kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        thomas.lendacky@amd.com, brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
References: <20220318153048.51177-1-kirill.shutemov@linux.intel.com>
 <20220318153048.51177-22-kirill.shutemov@linux.intel.com>
 <2847763c-6202-9e2a-54c5-44c761b59a63@intel.com>
 <20220324152415.grt6xvhblmd4uccu@black.fi.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCHv7 21/30] x86/acpi, x86/boot: Add multiprocessor wake-up
 support
In-Reply-To: <20220324152415.grt6xvhblmd4uccu@black.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/24/22 08:24, Kirill A. Shutemov wrote:
> On Fri, Mar 18, 2022 at 11:23:59AM -0700, Dave Hansen wrote:
>> On 3/18/22 08:30, Kirill A. Shutemov wrote:
>>> +	/*
>>> +	 * After writing the wakeup command, wait for maximum timeout of 0xFF
>>> +	 * for firmware to reset the command address back zero to indicate
>>> +	 * the successful reception of command.
>>> +	 * NOTE: 0xFF as timeout value is decided based on our experiments.
>>> +	 *
>>> +	 * XXX: Change the timeout once ACPI specification comes up with
>>> +	 *      standard maximum timeout value.
>>> +	 */
>>> +	timeout = 0xFF;
>>> +	while (READ_ONCE(acpi_mp_wake_mailbox->command) && --timeout)
>>> +		cpu_relax();
>>
>> I don't feel like this was ever actually resolved.  This timeout
>> basically boiled down to "this value seems to work for us".  There are
>> also *SURELY* timeouts that are going to happen here.
> 
> It makes me think if it can be an attack vector: once kernel initiated
> wake up of a secondary vCPU it has no control on how long it takes.

I don't think that's a meaningful attack vector for TDX.  Hosts always
have a choice to not run the guest.  Sure, they can hang the boot CPU
forever if they don't run the secondary CPU.  But, they can also do that
by just not ever running the boot CPU in the first place.

> I worry that malicious VMM can induce timeout intentionally, but then wake
> up the secondary CPU when kernel doesn't expect it. After quick look I was
> not able to convince myself that kernel can deal with this without a
> problem.
> 
> Is it legitimate concern?

The only thing I'd be worried about would be a secondary CPU going off
and doing things that it's not supposed to because *it* thinks it is in
boot code and the other CPUs are off doing normal runtime things.

I don't know the boot code well enough to guess where it would hang or
what damage it could do.  I suspect it would get hung up on something
like 'cpu_callout_mask'.

Is there anything in the trampoline code or start_secondary() that would
cause damage if it got run later than the kernel expects?

> Patch below drops timeout handling completely. Any opinions?
> 
> Other option would be to check in the trampoline code that initiated wake
> up is legitimate. But it should only be untrue if VMM acting weird (or
> virtual BIOS is buggy). I don't think it's right side to deal with the
> problem.

Yeah, that would just be a band-aid.  If we are worried about the
secondary CPU doing some damage at a random time, the host can just wait
until *after* the wakeup check.

>>>         /*
>>>          * If the CPU wakeup process is successful, store the
>>>          * status in apic_id_wakemap to prevent re-wakeup
>>>          * requests.
>>>          */
>>>         physid_set(apicid, apic_id_wakemap);
>>>
>>>         return 0;
>>> }
>>
>> If this goes wrong, won't the new wakeup just timeout?  Do we really
>> need a dedicated mechanism to stop re-wakeups?  How much of a problem is
>> this going to be?
> 
> Well, it can provide a proper diagnostics and a distinct error code. If
> you think it is unneeded we can drop it.

It looks like debugging that you add when you're bringing something up.
 I'm not sure of its utility going forward.  I'd just zap it for now and
bring it back later if it's really needed.
