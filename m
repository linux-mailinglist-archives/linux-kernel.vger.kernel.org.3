Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 027BE4D8854
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 16:39:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242634AbiCNPk5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 11:40:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242619AbiCNPku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 11:40:50 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88A7A2B1BF;
        Mon, 14 Mar 2022 08:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647272380; x=1678808380;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=Mu8Q0p1RLEfyaYx1a20uH10PLs/a7FuK8GEKxzLijI0=;
  b=lupF+Bq+WkQ92PlhTAltzjQhhC0SOCWz/9a6z95Od3HxwHym5gtSCQyW
   5tC1WjxAKMC9GzXf+KE6GcgVBXc300OPoRxoUoXIMUytCx9ygAWNWeoef
   hmqSbjgI1TNZxsUpCbie9XCREmZP/574iaJ0+C04m65QGsez+8ZaqFgbE
   7qlF1yy1oHZyB1syYbaHAzlyqREZ5Phi59bt9oFuG6qTOcYX5rAkfyK0H
   cvhS/4txSTGTlp0PUmYShF7lEPjt3nfC2gk6EpR+fm68iOaV6aia2vi1J
   rS5kqQsWfRMOYTdklP6vRpAl5KzYtV7B0sTzboovJSMvnX0Vflw2jHuzi
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10285"; a="238233488"
X-IronPort-AV: E=Sophos;i="5.90,181,1643702400"; 
   d="scan'208";a="238233488"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2022 08:39:40 -0700
X-IronPort-AV: E=Sophos;i="5.90,181,1643702400"; 
   d="scan'208";a="556474339"
Received: from hhuan26-mobl1.amr.corp.intel.com (HELO hhuan26-mobl1.mshome.net) ([10.255.37.182])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA; 14 Mar 2022 08:39:37 -0700
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
To:     "Reinette Chatre" <reinette.chatre@intel.com>,
        "Jarkko Sakkinen" <jarkko@kernel.org>
Cc:     "Dhanraj, Vijay" <vijay.dhanraj@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "bp@alien8.de" <bp@alien8.de>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Christopherson,, Sean" <seanjc@google.com>,
        "Huang, Kai" <kai.huang@intel.com>,
        "Zhang, Cathy" <cathy.zhang@intel.com>,
        "Xing, Cedric" <cedric.xing@intel.com>,
        "Huang, Haitao" <haitao.huang@intel.com>,
        "Shanahan, Mark" <mark.shanahan@intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        nathaniel@profian.com
Subject: Re: [PATCH V2 16/32] x86/sgx: Support restricting of enclave page
 permissions
References: <4ce06608b5351f65f4e6bc6fc87c88a71215a2e7.1644274683.git.reinette.chatre@intel.com> <YhLhoMFPyOFZ2fsX@iki.fi> <DM8PR11MB55917F499CDF4CC7D426B0A7F63C9@DM8PR11MB5591.namprd11.prod.outlook.com> <YimWaAqEnXHbLdjh@iki.fi> <op.1itu5vkewjvjmi@hhuan26-mobl1.mshome.net> <Yis8LV99mORcLYs6@iki.fi> <Yis9rA8uC/0bmWCF@iki.fi> <97565fed-dc67-bab1-28d4-c40201c9f055@intel.com> <Yi6tPLLt9Q+ailQ3@iki.fi> <Yi6tinbF+Y7a66eQ@iki.fi> <Yi6va4dCaljiQ1WQ@iki.fi>
Date:   Mon, 14 Mar 2022 10:39:36 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From:   "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel Corp
Message-ID: <op.1i01q9s0wjvjmi@hhuan26-mobl1.mshome.net>
In-Reply-To: <Yi6va4dCaljiQ1WQ@iki.fi>
User-Agent: Opera Mail/1.0 (Win32)
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jarkko

On Sun, 13 Mar 2022 21:58:51 -0500, Jarkko Sakkinen <jarkko@kernel.org>  
wrote:

> On Mon, Mar 14, 2022 at 04:50:56AM +0200, Jarkko Sakkinen wrote:
>> On Mon, Mar 14, 2022 at 04:49:37AM +0200, Jarkko Sakkinen wrote:
>> > On Fri, Mar 11, 2022 at 09:53:29AM -0800, Reinette Chatre wrote:
>> >
>> > > I saw Haitao's note that EMODPE requires "Read access permitted by  
>> enclave".
>> > > This motivates that EMODPR->PROT_NONE should not be allowed since  
>> it would
>> > > not be possible to relax permissions (run EMODPE) after that. Even  
>> so, I
>> > > also found in the SDM that EACCEPT has the note "Read access  
>> permitted
>> > > by enclave". That seems to indicate that EMODPR->PROT_NONE is not  
>> practical
>> > > from that perspective either since the enclave will not be able to
>> > > EACCEPT the change. Does that match your understanding?
>> >
>> > Yes, PROT_NONE should not be allowed.
>> >
>> > This is however the real problem.
>> >
>> > The current kernel patch set has inconsistent API and EMODPR ioctl is
>> > simply unacceptable. It  also requires more concurrency management  
>> from
>> > user space run-time, which would be heck a lot easier to do in the  
>> kernel.
>> >
>> > If you really want EMODPR as ioctl, then for consistencys sake, then  
>> EAUG
>> > should be too. Like this when things go opposite directions, this  
>> patch set
>> > plain and simply will not work out.
>> >
>> > I would pick EAUG's strategy from these two as it requires half the  
>> back
>> > calls to host from an enclave. I.e. please combine mprotect() and  
>> EMODPR,
>> > either in the #PF handler or as part of mprotect(), which ever suits  
>> you
>> > best.
>> >
>> > I'll try demonstrate this with two examples.
>> >
>> > mmap() could go something like this() (simplified):
>> > 1. Execution #UD's to SYSCALL.
>> > 2. Host calls enclave's mmap() handler with mmap() parameters.
>> > 3. Enclave up-calls host's mmap().
>> > 4. Loops the range with EACCEPTCOPY.
>> >
>> > mprotect() has to be done like this:
>> > 1. Execution #UD's to SYSCALL.
>> > 2. Host calls enclave's mprotect() handler.
>> > 3. Enclave up-calls host's mprotect().
>> > 4. Enclave up-calls host's ioctl() to SGX_IOC_ENCLAVE_PERMISSIONS.

I assume up-calls here are ocalls as we call them in our implementation,  
which are the calls enclave make to untrusted side via EEXIT.

If so, can your implementation combine this two up-calls into one, then  
host side just do ioctl() and mprotect to kernel? If so, would that  
address your concern about extra up-calls?


>> > 3. Loops the range with EACCEPT.
>>   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>   5. Loops the range with EACCEPT + EMODPE.
>>
>> > This is just terrible IMHO. I hope these examples bring some insight.
>
> E.g. in Enarx we have to add a special up-call (so called enarxcall in
> intermediate that we call sallyport, which provides shared buffer to
> communicate with the enclave) just for reseting the range with PROT_READ.
> Feel very redundant, adds ugly cruft and is completely opposite strategy  
> to
> what you've chosen to do with EAUG, which is I think correct choice as  
> far
> as API is concerned.

The problem with EMODPR on #PF is that kernel needs to know what  
permissions requested from enclave at the time of #PF. So enclave has to  
make at least one call to kernel (again via ocall in our case, I assume  
up-call in your case) to make the change.

Enclave runtime may not know the permissions until upper layer application  
code (JIT or some kind of code loader) make the decision to change it. And  
the ocalls/up-calls can only be done at that time, not upfront, like mmap  
that is only used to reserve ranges.

I also see this model as consistent to what kernel does for regular memory  
mappings: adding physical pages on #PF or pre-fault and changing PTE  
permissions only after mprotect is called.

I would agree/prefer mprotect and the ioctl() for EMODPR be combined, but  
Reinette pointed out some issues above on managing VMAs and handling  
errors in that approach.

BR
Haitao
