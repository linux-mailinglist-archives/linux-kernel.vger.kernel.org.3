Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C8B3487A2F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 17:14:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348184AbiAGQOl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 11:14:41 -0500
Received: from mga07.intel.com ([134.134.136.100]:51783 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239828AbiAGQOe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 11:14:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641572073; x=1673108073;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=27Xdr73JuxW7kZiH6psTvJf5Ib97mgEbl7iCOAv8h/c=;
  b=EPWqJfy2Pb1IpwQLxb5h+RKiuM9aZtRdfnEr4UzQjM/dkGz/rnyMQl7Z
   ua+NDe2NEQmCBdqcGaE9GFuTlxTtKcfvUex1mFyoyt2NthNKcpRCV4iHJ
   cUBoQJtMlkYaLimYoTImiC8bEuyFdlF+8c1b/T44EGwRUnMijaUkNMSZS
   eyAHRIvP/y8OoPVm1RpeaS0WHihhFTAS5htsljNB0HYRjgtCeLcmpkWEW
   s8zZEm9JFLJ4yPfs+GMOoXqiutzIrqarzX/bjG1RviWUfAm1UAH9EWV6X
   2NIUpbg4bLtxwnywQFcRYbDf7H3mhJtxmuakac2o5pZAdtIJQBoWMCqvB
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10219"; a="306255001"
X-IronPort-AV: E=Sophos;i="5.88,270,1635231600"; 
   d="scan'208";a="306255001"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2022 08:14:32 -0800
X-IronPort-AV: E=Sophos;i="5.88,270,1635231600"; 
   d="scan'208";a="513842578"
Received: from ngadikot-mobl.amr.corp.intel.com (HELO hhuan26-mobl1.mshome.net) ([10.255.37.32])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA; 07 Jan 2022 08:14:30 -0800
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
To:     "Reinette Chatre" <reinette.chatre@intel.com>,
        "Jarkko Sakkinen" <jarkko@kernel.org>
Cc:     "Andy Lutomirski" <luto@kernel.org>, dave.hansen@linux.intel.com,
        tglx@linutronix.de, bp@alien8.de, mingo@redhat.com,
        linux-sgx@vger.kernel.org, x86@kernel.org, seanjc@google.com,
        kai.huang@intel.com, cathy.zhang@intel.com, cedric.xing@intel.com,
        haitao.huang@intel.com, mark.shanahan@intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/25] x86/sgx: Introduce runtime protection bits
References: <cover.1638381245.git.reinette.chatre@intel.com> <2f6b04dd8949591ee6139072c72eb93da3dd07b0.1638381245.git.reinette.chatre@intel.com> <db9b7bc9-fdca-4dd2-2c3f-3b7354c165bb@kernel.org> <YawAWmodeNaUbzV8@iki.fi> <a1b14f33-5142-8cab-3b5f-4cc79b62091e@intel.com> <a24bc46e4ba8a69938a7f73012019ce0f61005c2.camel@kernel.org> <f6a55943-13ef-41ef-609a-6406cffef513@intel.com> <YcsklLw1uFyppSji@iki.fi> <573e0836-6ac2-30a4-0c21-d4763707ac96@intel.com> <YdgvFTIRboHwTgRT@iki.fi>
Date:   Fri, 07 Jan 2022 10:14:29 -0600
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From:   "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel Corp
Message-ID: <op.1fmvdehpwjvjmi@hhuan26-mobl1.mshome.net>
In-Reply-To: <YdgvFTIRboHwTgRT@iki.fi>
User-Agent: Opera Mail/1.0 (Win32)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 07 Jan 2022 06:16:21 -0600, Jarkko Sakkinen <jarkko@kernel.org>  
wrote:

> On Thu, Jan 06, 2022 at 09:46:06AM -0800, Reinette Chatre wrote:
>> Hi Jarkko,
>>
>> On 12/28/2021 6:52 AM, Jarkko Sakkinen wrote:
>> > On Mon, Dec 13, 2021 at 02:10:17PM -0800, Reinette Chatre wrote:
>> >> Hi Jarkko,
>> >>
>> >> On 12/10/2021 11:42 PM, Jarkko Sakkinen wrote:
>> >>> On Mon, 2021-12-06 at 13:20 -0800, Reinette Chatre wrote:
>> >>>>> This is a valid question. Since EMODPE exists why not just make  
>> things for
>> >>>>> EMODPE, and ignore EMODPR altogether?
>> >>>>>
>> >>>>
>> >>>> I believe that we should support the best practice of principle of  
>> least
>> >>>> privilege - once a page no longer needs a particular permission  
>> there
>> >>>> should be a way to remove it (the unneeded permission).
>> >>>
>> >>> What if EMODPR was not used at all, since EMODPE is there anyway?
>> >>
>> >> EMODPR and EMODPE are not equivalent.
>> >>
>> >> EMODPE can only be used to "extend"/relax permissions while EMODPR  
>> can only
>> >> be used to restrict permissions.
>> >>
>> >> Notice in the EMODPE instruction reference of the SDM:
>> >>
>> >> (* Update EPCM permissions *)
>> >> EPCM(DS:RCX).R := EPCM(DS:RCX).R | SCRATCH_SECINFO.FLAGS.R;
>> >> EPCM(DS:RCX).W := EPCM(DS:RCX).W | SCRATCH_SECINFO.FLAGS.W;
>> >> EPCM(DS:RCX).X := EPCM(DS:RCX).X | SCRATCH_SECINFO.FLAGS.X;
>> >>
>> >> So, when using EMODPE it is only possible to add permissions, not  
>> remove
>> >> permissions.
>> >>
>> >> If a user wants to remove permissions from an EPCM page it is only  
>> possible
>> >> when using EMODPR. Notice in its instruction reference found in the  
>> SDM how
>> >> it in turn can only be used to restrict permissions:
>> >>
>> >> (* Update EPCM permissions *)
>> >> EPCM(DS:RCX).R := EPCM(DS:RCX).R & SCRATCH_SECINFO.FLAGS.R;
>> >> EPCM(DS:RCX).W := EPCM(DS:RCX).W & SCRATCH_SECINFO.FLAGS.W;
>> >> EPCM(DS:RCX).X := EPCM(DS:RCX).X & SCRATCH_SECINFO.FLAGS.X;
>> >
>> > OK, so the question is: do we need both or would a mechanism just to  
>> extend
>> > permissions be sufficient?
>>
>> I do believe that we need both in order to support pages having only
>> the permissions required to support their intended use during the time  
>> the
>> particular access is required. While technically it is possible to grant
>> pages all permissions they may need during their lifetime it is safer to
>> remove permissions when no longer required.
>
> So if we imagine a run-time: how EMODPR would be useful, and how using it
> would make things safer?
>
In scenarios of JIT compilers, once code is generated into RW pages,  
modifying both PTE and EPCM permissions to RX would be a good defensive  
measure. In that case, EMODPR is useful.

Haitao
