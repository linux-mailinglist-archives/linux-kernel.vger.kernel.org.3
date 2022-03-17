Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D5BA4DC925
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 15:45:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235378AbiCQOoQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 10:44:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235399AbiCQOoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 10:44:07 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 783D6202143;
        Thu, 17 Mar 2022 07:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647528166; x=1679064166;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=Gre9tdzP44C52oDk3PRk/F9hKCqLtJjXkUun5eatYeQ=;
  b=F26Hyod5UTn5HCjwEZ+qCmbRVgwS0d+oRTJQr9ekHKpjAKEJkzbygbwC
   vu+MQnG3MfeF2GZc8FXwZ84efDqEz4eEOvNyPyK29YrZwpPZxt76iw10D
   7Y3/7vwFAk55OU7dU4yPi68BLtIx/aKPjXgDUvep/DTnFnwXbDljYqG74
   m4465a3pgfjL8Py7DPQOXQKxs/EuY1erTt/D4+alahFMOVDuiR2obRgHf
   8r32L91DiU6ASgYDqh+bMAgcHW54bjNejpKarVU4JWuPBRWlNt/cu8/Ph
   bSreDFQx0Iysh6eyiJckE678sXucNfp1REubq0vqeKOR/IpHn8Qf9VX2R
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10289"; a="254437367"
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="254437367"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 07:42:34 -0700
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="557957418"
Received: from hhuan26-mobl1.amr.corp.intel.com (HELO hhuan26-mobl1.mshome.net) ([10.255.39.199])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA; 17 Mar 2022 07:42:31 -0700
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
To:     "Jarkko Sakkinen" <jarkko@kernel.org>
Cc:     "Reinette Chatre" <reinette.chatre@intel.com>,
        "Dhanraj, Vijay" <vijay.dhanraj@intel.com>,
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
References: <DM8PR11MB55917F499CDF4CC7D426B0A7F63C9@DM8PR11MB5591.namprd11.prod.outlook.com> <YimWaAqEnXHbLdjh@iki.fi> <op.1itu5vkewjvjmi@hhuan26-mobl1.mshome.net> <Yis8LV99mORcLYs6@iki.fi> <Yis9rA8uC/0bmWCF@iki.fi> <97565fed-dc67-bab1-28d4-c40201c9f055@intel.com> <Yi6tPLLt9Q+ailQ3@iki.fi> <Yi6tinbF+Y7a66eQ@iki.fi> <Yi6va4dCaljiQ1WQ@iki.fi> <op.1i01q9s0wjvjmi@hhuan26-mobl1.mshome.net> <YjK6X3qX/E/J7qc+@iki.fi>
Date:   Thu, 17 Mar 2022 09:42:30 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From:   "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel Corp
Message-ID: <op.1i6i44rawjvjmi@hhuan26-mobl1.mshome.net>
In-Reply-To: <YjK6X3qX/E/J7qc+@iki.fi>
User-Agent: Opera Mail/1.0 (Win32)
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Mar 2022 23:34:39 -0500, Jarkko Sakkinen <jarkko@kernel.org>  
wrote:

> On Mon, Mar 14, 2022 at 10:39:36AM -0500, Haitao Huang wrote:
>> Hi Jarkko
>>
>> On Sun, 13 Mar 2022 21:58:51 -0500, Jarkko Sakkinen <jarkko@kernel.org>
>> wrote:
>>
>> > On Mon, Mar 14, 2022 at 04:50:56AM +0200, Jarkko Sakkinen wrote:
>> > > On Mon, Mar 14, 2022 at 04:49:37AM +0200, Jarkko Sakkinen wrote:
>> > > > On Fri, Mar 11, 2022 at 09:53:29AM -0800, Reinette Chatre wrote:
>> > > >
>> > > > > I saw Haitao's note that EMODPE requires "Read access permitted
>> > > by enclave".
>> > > > > This motivates that EMODPR->PROT_NONE should not be allowed
>> > > since it would
>> > > > > not be possible to relax permissions (run EMODPE) after that.
>> > > Even so, I
>> > > > > also found in the SDM that EACCEPT has the note "Read access
>> > > permitted
>> > > > > by enclave". That seems to indicate that EMODPR->PROT_NONE is
>> > > not practical
>> > > > > from that perspective either since the enclave will not be able  
>> to
>> > > > > EACCEPT the change. Does that match your understanding?
>> > > >
>> > > > Yes, PROT_NONE should not be allowed.
>> > > >
>> > > > This is however the real problem.
>> > > >
>> > > > The current kernel patch set has inconsistent API and EMODPR  
>> ioctl is
>> > > > simply unacceptable. It  also requires more concurrency management
>> > > from
>> > > > user space run-time, which would be heck a lot easier to do in the
>> > > kernel.
>> > > >
>> > > > If you really want EMODPR as ioctl, then for consistencys sake,
>> > > then EAUG
>> > > > should be too. Like this when things go opposite directions, this
>> > > patch set
>> > > > plain and simply will not work out.
>> > > >
>> > > > I would pick EAUG's strategy from these two as it requires half
>> > > the back
>> > > > calls to host from an enclave. I.e. please combine mprotect() and
>> > > EMODPR,
>> > > > either in the #PF handler or as part of mprotect(), which ever
>> > > suits you
>> > > > best.
>> > > >
>> > > > I'll try demonstrate this with two examples.
>> > > >
>> > > > mmap() could go something like this() (simplified):
>> > > > 1. Execution #UD's to SYSCALL.
>> > > > 2. Host calls enclave's mmap() handler with mmap() parameters.
>> > > > 3. Enclave up-calls host's mmap().
>> > > > 4. Loops the range with EACCEPTCOPY.
>> > > >
>> > > > mprotect() has to be done like this:
>> > > > 1. Execution #UD's to SYSCALL.
>> > > > 2. Host calls enclave's mprotect() handler.
>> > > > 3. Enclave up-calls host's mprotect().
>> > > > 4. Enclave up-calls host's ioctl() to SGX_IOC_ENCLAVE_PERMISSIONS.
>>
>> I assume up-calls here are ocalls as we call them in our implementation,
>> which are the calls enclave make to untrusted side via EEXIT.
>>
>> If so, can your implementation combine this two up-calls into one, then  
>> host
>> side just do ioctl() and mprotect to kernel? If so, would that address  
>> your
>> concern about extra up-calls?
>>
>>
>> > > > 3. Loops the range with EACCEPT.
>> > >   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> > >   5. Loops the range with EACCEPT + EMODPE.
>> > >
>> > > > This is just terrible IMHO. I hope these examples bring some  
>> insight.
>> >
>> > E.g. in Enarx we have to add a special up-call (so called enarxcall in
>> > intermediate that we call sallyport, which provides shared buffer to
>> > communicate with the enclave) just for reseting the range with  
>> PROT_READ.
>> > Feel very redundant, adds ugly cruft and is completely opposite  
>> strategy
>> > to
>> > what you've chosen to do with EAUG, which is I think correct choice as
>> > far
>> > as API is concerned.
>>
>> The problem with EMODPR on #PF is that kernel needs to know what  
>> permissions
>> requested from enclave at the time of #PF. So enclave has to make at  
>> least
>> one call to kernel (again via ocall in our case, I assume up-call in  
>> your
>> case) to make the change.
>
> Your security scheme is broken if permissions are requested outside the
> enclave, i.e. the hostile environment controls the permissions. That  
> should
> always come from the enclave and enclave uses EACCEPT* to validate that
> what was given to EMODPR, EAUG and EMODT matches its expections.
>
> Upper layer application should not never be in charge, and a broken
> security scheme should never be supported.
>
Upper layer in this case I mean code inside enclave.
Enclave can always use EACCEPT to verify permissions and is in full  
control of EPCM permissions.
Kernel(code outside enclave invoking kernel) would only be able to reduce  
EPCM permissions, and as you know enclave can always EMODPE.
So this is not related to enclave security.

Haitao
