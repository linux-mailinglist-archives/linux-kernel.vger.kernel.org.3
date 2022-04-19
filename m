Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96AA85062D8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 05:37:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348149AbiDSDkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 23:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348122AbiDSDkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 23:40:10 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B47FD64C0;
        Mon, 18 Apr 2022 20:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650339448; x=1681875448;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=wr38o5qJ3qUzqezKMwzqRkUfYXNErQBLQMZleRWCg5A=;
  b=GIUk7ngzxK/hcCcIx3QxGn+Z6B8neh8IWmOODlJ8cm3r2lCLitJ73PAj
   oYbrc9ecl0FHKEGH6I7FLMBKHJZY1JGCFYBWrtnxteRtRKzy3T0h97n4p
   fa6lBwi7sOk2boJZevkpjFwPPEFQrZrbLoA8HcgcVU2eJOTRnFKIdmnb0
   EJOmH/Xkap3RrxwM93PVu/SvToQxihD1WTJDMiBqwi7uE+RPCqTlRYPX4
   lpx4WPOTJ8JbjwtIfHAM14LYbmLnAL4wZfckwGJRXIY3IBqbBrEdzkJ3t
   BCGEBbB1nM10pL5VzGwK/fIxQH9R0H3kbP9JDw687F5vzbcCxwx28ZPvb
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10321"; a="263127362"
X-IronPort-AV: E=Sophos;i="5.90,271,1643702400"; 
   d="scan'208";a="263127362"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2022 20:37:28 -0700
X-IronPort-AV: E=Sophos;i="5.90,271,1643702400"; 
   d="scan'208";a="657482559"
Received: from chferrer-mobl.amr.corp.intel.com (HELO [10.209.37.31]) ([10.209.37.31])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2022 20:37:27 -0700
Message-ID: <ce0c1d0b-b60f-79e1-b602-450def91ae77@linux.intel.com>
Date:   Mon, 18 Apr 2022 20:37:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.7.0
Subject: Re: [PATCH v3 1/4] x86/tdx: Add tdx_mcall_tdreport() API support
Content-Language: en-US
To:     Kai Huang <kai.huang@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>
Cc:     "H . Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
References: <20220415220109.282834-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20220415220109.282834-2-sathyanarayanan.kuppuswamy@linux.intel.com>
 <eca68f9b522b6586c883ac9765d8a071e803ee3f.camel@intel.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <eca68f9b522b6586c883ac9765d8a071e803ee3f.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/18/22 7:29 PM, Kai Huang wrote:
> On Fri, 2022-04-15 at 15:01 -0700, Kuppuswamy Sathyanarayanan wrote:
>> In TDX guest, attestation is mainly used to verify the trustworthiness
>> of a TD to the 3rd party key servers.
>>
> 
> "key servers" is only a use case of using the attestation service. This sentence
> looks not accurate.

I thought it is mainly used for this use case. If it is not accurate,
how about following?

Attestation is used to verify the trustworthiness of a TD to the other
3rd party entities (like key servers) before exchanging sensitive
information.

> 
>> First step in attestation process
>> is to get the TDREPORT data and the generated data is further used in
>> subsequent steps of the attestation process. TDREPORT data contains
>> details like TDX module version information, measurement of the TD,
>> along with a TD-specified nonce
>>
>> Add a wrapper function (tdx_mcall_tdreport()) to get the TDREPORT from
>> the TDX Module.
>>
>> More details about the TDREPORT TDCALL can be found in TDX Guest-Host
>> Communication Interface (GHCI) for Intel TDX 1.5, section titled
>> "TDCALL [MR.REPORT]".
> 
> Attestation is a must for TDX architecture, so The TDCALL[MR.REPORT] is
> available in TDX 1.0.  I don't think we should use TDX 1.5 here.  And this

Yes. It is also part of v1.0. Since the feature is similar between v1.0
and v1.5, I have included one link. If v1.0 reference is preferred, I
will update it.

> TDCALL is defined in the TDX module spec 1.0.  You can find it in the public TDX
> module 1.0 spec (22.3.3. TDG.MR.REPORT Leaf):

It looks like in the latest update, they have moved this section from
ABI spec. I will update the specification reference.


> 
> https://www.intel.com/content/dam/develop/external/us/en/documents/tdx-module-1.0-public-spec-v0.931.pdf
> 
>>
>> Steps involved in attestation process can be found in TDX Guest-Host
>> Communication Interface (GHCI) for Intel TDX 1.5, section titled
>> "TD attestation"
> 
> It's strange we need to use GHCI for TDX 1.5 to get some idea about the
> attestation process.  Looking at the GHCI 1.0 spec, it seems it already has one
> section to talk about attestation process (5.4 TD attestation).

Both are same. I will change it to 1.0 reference.

> 
>>
>> This API will be mainly used by the attestation driver. Attestation
>> driver support will be added by upcoming patches.
>>
>> Reviewed-by: Tony Luck <tony.luck@intel.com>
>> Reviewed-by: Andi Kleen <ak@linux.intel.com>
>> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>> ---
>>   arch/x86/coco/tdx/tdx.c    | 46 ++++++++++++++++++++++++++++++++++++++
>>   arch/x86/include/asm/tdx.h |  2 ++
>>   2 files changed, 48 insertions(+)
>>
>> diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
>> index 03deb4d6920d..3e409b618d3f 100644
>> --- a/arch/x86/coco/tdx/tdx.c
>> +++ b/arch/x86/coco/tdx/tdx.c
>> @@ -11,10 +11,12 @@
>>   #include <asm/insn.h>
>>   #include <asm/insn-eval.h>
>>   #include <asm/pgtable.h>
>> +#include <asm/io.h>
>>   
>>   /* TDX module Call Leaf IDs */
>>   #define TDX_GET_INFO			1
>>   #define TDX_GET_VEINFO			3
>> +#define TDX_GET_REPORT			4
>>   #define TDX_ACCEPT_PAGE			6
>>   
>>   /* TDX hypercall Leaf IDs */
>> @@ -34,6 +36,10 @@
>>   #define VE_GET_PORT_NUM(e)	((e) >> 16)
>>   #define VE_IS_IO_STRING(e)	((e) & BIT(4))
>>   
>> +/* TDX Module call error codes */
>> +#define TDCALL_RETURN_CODE_MASK		0xffffffff00000000
>> +#define TDCALL_RETURN_CODE(a)		((a) & TDCALL_RETURN_CODE_MASK)
>> +
>>   /*
>>    * Wrapper for standard use of __tdx_hypercall with no output aside from
>>    * return code.
>> @@ -98,6 +104,46 @@ static inline void tdx_module_call(u64 fn, u64 rcx, u64 rdx, u64 r8, u64 r9,
>>   		panic("TDCALL %lld failed (Buggy TDX module!)\n", fn);
>>   }
>>   
>> +/*
>> + * tdx_mcall_tdreport() - Generate TDREPORT_STRUCT using TDCALL.
>> + *
>> + * @data        : Address of 1024B aligned data to store
>> + *                TDREPORT_STRUCT.
>> + * @reportdata  : Address of 64B aligned report data
>> + *
>> + * return 0 on success or failure error number.
>> + */
>> +long tdx_mcall_tdreport(void *data, void *reportdata)
>> +{
>> +	u64 ret;
>> +
>> +	/*
>> +	 * Check for a valid TDX guest to ensure this API is only
>> +	 * used by TDX guest platform. Also make sure "data" and
>> +	 * "reportdata" pointers are valid.
>> +	 */
>> +	if (!data || !reportdata || !cpu_feature_enabled(X86_FEATURE_TDX_GUEST))
>> +		return -EINVAL;
> 
> Do we need to manually check the alignment since it is mentioned in the comment
> of this function?

Users are responsible to allocate aligned data. I don't think we need
to add a check for it. If it is unaligned, TDCALL will return error.

> 
>> +
>> +	/*
>> +	 * Pass the physical address of user generated reportdata
>> +	 * and the physical address of out pointer to store the
>> +	 * TDREPORT data to the TDX module to generate the
>> +	 * TD report. Generated data contains measurements/configuration
>> +	 * data of the TD guest. More info about ABI can be found in TDX
>> +	 * Guest-Host-Communication Interface (GHCI), sec titled
>> +	 * "TDG.MR.REPORT".
> 
> If you agree with my above comments, then this comment should be updated too:
> TDG.MR.REPORT is defined in TDX module 1.0 spec.

Ok. will change it.



-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
