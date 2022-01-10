Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1591B48A260
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 23:05:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345227AbiAJWF2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 17:05:28 -0500
Received: from mga11.intel.com ([192.55.52.93]:58899 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345088AbiAJWFZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 17:05:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641852325; x=1673388325;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=0GDhTqMrEZ06SvbRnviHwB73FbyvKmj7DMslxvGR4ZQ=;
  b=G5HLZKone7cSRZ0hs0TwKpQoB4QVRnk06k1apFvch2L/N7CUFJ66OMQN
   8M8AOxDH/D0Sy2v64QXaKhq6NW3Giis53aU1CSpsJIN5UxBWDMAmJR7S9
   zAPaLgqV3RsBPSmo561XNEw/lHej5dmAK9FccsUfp5lB/40n6FiAwNveS
   tpP6HUmgIub0ROFPFQihfAkVyYiA1MbCj1LfqSlaH+zivW0XmaXyw83Gn
   uwugHDkOG2h+YVtD3Y8rK0Cr4lRxCDKOqS4yMciXQSeuzodTSWx5wluDg
   FYY0ZZKHYPmsaMX4J7j00FgOyAmGl/KFxZTNIFxvkIYivjSOCVksIXlEQ
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10223"; a="240887473"
X-IronPort-AV: E=Sophos;i="5.88,278,1635231600"; 
   d="scan'208";a="240887473"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2022 14:05:25 -0800
X-IronPort-AV: E=Sophos;i="5.88,278,1635231600"; 
   d="scan'208";a="528453748"
Received: from hhuan26-mobl1.amr.corp.intel.com (HELO hhuan26-mobl1.mshome.net) ([10.255.35.106])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA; 10 Jan 2022 14:05:22 -0800
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
To:     "Jarkko Sakkinen" <jarkko@kernel.org>
Cc:     "Reinette Chatre" <reinette.chatre@intel.com>,
        "Andy Lutomirski" <luto@kernel.org>, dave.hansen@linux.intel.com,
        tglx@linutronix.de, bp@alien8.de, mingo@redhat.com,
        linux-sgx@vger.kernel.org, x86@kernel.org, seanjc@google.com,
        kai.huang@intel.com, cathy.zhang@intel.com, cedric.xing@intel.com,
        haitao.huang@intel.com, mark.shanahan@intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/25] x86/sgx: Introduce runtime protection bits
References: <YawAWmodeNaUbzV8@iki.fi>
 <a1b14f33-5142-8cab-3b5f-4cc79b62091e@intel.com>
 <a24bc46e4ba8a69938a7f73012019ce0f61005c2.camel@kernel.org>
 <f6a55943-13ef-41ef-609a-6406cffef513@intel.com> <YcsklLw1uFyppSji@iki.fi>
 <573e0836-6ac2-30a4-0c21-d4763707ac96@intel.com> <YdgvFTIRboHwTgRT@iki.fi>
 <op.1fmvdehpwjvjmi@hhuan26-mobl1.mshome.net> <YdmxpTVM1JG8nxQ3@iki.fi>
 <YdmzDy1BOHgh8CII@iki.fi> <Ydm6RiIwuh3IspRI@iki.fi>
Date:   Mon, 10 Jan 2022 16:05:21 -0600
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From:   "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel Corp
Message-ID: <op.1fsvkfiwwjvjmi@hhuan26-mobl1.mshome.net>
In-Reply-To: <Ydm6RiIwuh3IspRI@iki.fi>
User-Agent: Opera Mail/1.0 (Win32)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 08 Jan 2022 10:22:30 -0600, Jarkko Sakkinen <jarkko@kernel.org>  
wrote:

> On Sat, Jan 08, 2022 at 05:51:46PM +0200, Jarkko Sakkinen wrote:
>> On Sat, Jan 08, 2022 at 05:45:44PM +0200, Jarkko Sakkinen wrote:
>> > On Fri, Jan 07, 2022 at 10:14:29AM -0600, Haitao Huang wrote:
>> > > > > > OK, so the question is: do we need both or would a mechanism  
>> just
>> > > > > to extend
>> > > > > > permissions be sufficient?
>> > > > >
>> > > > > I do believe that we need both in order to support pages having  
>> only
>> > > > > the permissions required to support their intended use during  
>> the
>> > > > > time the
>> > > > > particular access is required. While technically it is possible  
>> to grant
>> > > > > pages all permissions they may need during their lifetime it is  
>> safer to
>> > > > > remove permissions when no longer required.
>> > > >
>> > > > So if we imagine a run-time: how EMODPR would be useful, and how  
>> using it
>> > > > would make things safer?
>> > > >
>> > > In scenarios of JIT compilers, once code is generated into RW pages,
>> > > modifying both PTE and EPCM permissions to RX would be a good  
>> defensive
>> > > measure. In that case, EMODPR is useful.
>> >
>> > What is the exact threat we are talking about?
>>
>> To add: it should be *significantly* critical thread, given that not
>> supporting only EAUG would leave us only one complex call pattern with
>> EACCEPT involvement.
>>
>> I'd even go to suggest to leave EMODPR out of the patch set, and  
>> introduce
>> it when there is PoC code for any of the existing run-time that
>> demonstrates the demand for it. Right now this way too speculative.
>>
>> Supporting EMODPE is IMHO by factors more critical.
>
> At least it does not protected against enclave code because an enclave  
> can
> always choose not to EACCEPT any of the EMODPR requests. I'm not only
> confused here about the actual threat but also the potential adversary  
> and
> target.
>
I'm not sure I follow your thoughts here. The sequence should be for  
enclave to request  EMODPR in the first place through runtime to kernel,  
then to verify with EACCEPT that the OS indeed has done EMODPR.
If enclave does not verify with EACCEPT, then its own code has  
vulnerability. But this does not justify OS not providing the mechanism to  
request EMODPR.

Similar to how we don't want have RWX code pages for normal Linux  
application, when an enclave loads code pages (either directly or JIT  
compiled from high level code ) into EAUG'd page (which has RW), we do not  
want leave pages to be RWX for code to be executable, hence the need of  
EMODPR request OS to reduce the permissions to RX once the code is ready  
to execute.

I believe this is needed for LibOS runtimes (e.g.,Gramine) loading  
unmodified app binaries, or an enclave with JIT compiler (I think Enarx in  
this category?). Experts from those project can confirm or contradict.  
Intel SDK currently also has implementation to reduce permissions of RELRO  
sections in ELF binaries to ReadOnly after relocation is done. In our new  
EDMM user support[1] based on this patch series, we also support flows to  
reduce permissions using EMODPR in a generic way.

[1]https://github.com/intel/linux-sgx/pull/751
