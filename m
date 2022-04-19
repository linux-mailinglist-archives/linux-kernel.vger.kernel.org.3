Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC81F506328
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 06:26:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348175AbiDSEHm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 00:07:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347355AbiDSEHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 00:07:39 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6A37DF98;
        Mon, 18 Apr 2022 21:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650341097; x=1681877097;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Y18g11oQ101Ybf63LfTcjQeedu9M8l5czBaIWzYx+2Q=;
  b=XnMwVnkHW/htwDsdE/WVTZJ4oLAgoLLqmddhMbDofRoMLbWTN/0Dk3tr
   ekDEAozmN5sazbwihv44J9L0bLzDSKOo6q0kBlpZ+jYjc5j9cD8oZaY3l
   sHofsQLVmn8qsRqc07KaPqciKa6EDHnvKybhHS/V2YckVRYdzHuV5e2et
   rqfTc+XSuNnv18iGspK9l1xNsw8xCc4Dmmg+8n90fqq8YjehrD6DDVXXY
   /iS0j4PXpclche7Tgc+GHZm+5rkGw5mY17zbEOSqHRGmYRQejwTdG8ke9
   uUESthtRx46i4KvIXUvETJmAuVe8ieD0cpaWj2f9Gu7OIUicxvbz5eceJ
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10321"; a="245561047"
X-IronPort-AV: E=Sophos;i="5.90,271,1643702400"; 
   d="scan'208";a="245561047"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2022 21:04:56 -0700
X-IronPort-AV: E=Sophos;i="5.90,271,1643702400"; 
   d="scan'208";a="657489605"
Received: from chferrer-mobl.amr.corp.intel.com (HELO [10.209.37.31]) ([10.209.37.31])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2022 21:04:53 -0700
Message-ID: <0a49a4f1-637a-fa92-555f-485b529e6811@linux.intel.com>
Date:   Mon, 18 Apr 2022 21:04:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.7.0
Subject: Re: [PATCH v3 2/4] x86/tdx: Add tdx_hcall_get_quote() API support
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
 <20220415220109.282834-3-sathyanarayanan.kuppuswamy@linux.intel.com>
 <4ad97e6118688faf35e96ade46690c84f6c729f4.camel@intel.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <4ad97e6118688faf35e96ade46690c84f6c729f4.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/18/22 7:59 PM, Kai Huang wrote:
> On Fri, 2022-04-15 at 15:01 -0700, Kuppuswamy Sathyanarayanan wrote:
>> Attestation is the process used by two un-trusted entities to prove to
>> each other that it can be trusted.
>>
> 
> I don't think this is accurate.  TDX attestation is used to attest a TD is
> genuine and runs on genuine Intel platforms to any challenger who wants to
> verify this.  Theoretically, the TD guest doesn't necessarily need to verify the
> trustworthiness of the challenger.

Above is a generic explanation for attestation (not TDX specific).

> 
>> In TDX guest, attestation is mainly
>> used to verify the trustworthiness of a TD to the 3rd party key
>> servers.
> 
> And "key servers" is only one potential use case of using the attestation
> service.  I don't think it's right to say attestation is mainly used for this.

Agree. I will change it to,

Attestation is used to verify the trustworthiness of a TD to the other
3rd party entities before exchanging sensitive information.

> 
>>
>> First step in the attestation process is to generate the TDREPORT data.
>> This support is added using tdx_mcall_tdreport() API. The second stage
>> in the attestation process is for the guest to request the VMM generate
>> and sign a quote based on the TDREPORT acquired earlier.
>>
> 
> This is not accurate.  The VMM cannot generate and sign the Quote.  Only Quoting
> enclave (QE) can do that.  The VMM is just a bridge which helps to send the
> TDREPORT to the QE and then give the Quote back to TD guest when it receives it.
> 
> For instance, theoretically GetQuote TDVMCALL isn't absolutely necessarily for
> attestation.  The TD attestation agent (runs in TD guest userspace) can choose
> to connect to QE directly if feasible (i.e. via vsock, tcp/ip, ..) and then send
> the TDREPORT to QE and receive the Quote directly.

Yes, since guest does not get involved with how VMM facilities the
Quote Generation, I did not elaborate on Quoting Enclave part.

How about following change?

The second stage in the attestation process is for the guest to pass the
TDREPORT data (generated by TDREPORT TDCALL) to the VMM and
request it to trigger Quote generation via a Quoting enclave (QE).

Also note that GetQuote is an asynchronous request. So this API does not
block till Quote is generated. VMM will notify the TD guest about the
quote generation completion via interrupt (configured by
SetupEventNotifyInterrupt hypercall). This support will be added by
follow on patches in this series.


> 
>> More details
>> about the steps involved in attestation process can be found in TDX
>> Guest-Host Communication Interface (GHCI) for Intel TDX 1.5, section
>> titled "TD attestation"
> 
> See my reply to previous patch.  It's mentioned in GHCI 1.0 spec (section 5.4 TD
> attestation).

Yes. I will change it to 1.0 reference.

> 
>>
>> Add tdx_hcall_get_quote() helper function to implement the GetQuote
>> hypercall.
>>
>> More details about the GetQuote TDVMCALL are in the Guest-Host
>> Communication Interface (GHCI) Specification, sec 3.3, titled
>> "VP.VMCALL<GetQuote>".
>>
>> This will be used by the TD attestation driver in follow-on patches.
>>
>> Reviewed-by: Tony Luck <tony.luck@intel.com>
>> Reviewed-by: Andi Kleen <ak@linux.intel.com>
>> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>> ---
>>   arch/x86/coco/tdx/tdx.c    | 38 ++++++++++++++++++++++++++++++++++++++
>>   arch/x86/include/asm/tdx.h |  2 ++
>>   2 files changed, 40 insertions(+)
>>
>> diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
>> index 3e409b618d3f..c259d81a5d7f 100644
>> --- a/arch/x86/coco/tdx/tdx.c
>> +++ b/arch/x86/coco/tdx/tdx.c
>> @@ -21,6 +21,7 @@
>>   
>>   /* TDX hypercall Leaf IDs */
>>   #define TDVMCALL_MAP_GPA		0x10001
>> +#define TDVMCALL_GET_QUOTE		0x10002
>>   
>>   /* MMIO direction */
>>   #define EPT_READ	0
>> @@ -144,6 +145,43 @@ long tdx_mcall_tdreport(void *data, void *reportdata)
>>   }
>>   EXPORT_SYMBOL_GPL(tdx_mcall_tdreport);
>>   
>> +/*
>> + * tdx_hcall_get_quote() - Generate TDQUOTE using TDREPORT_STRUCT.
>> + *
>> + * @data        : Address of 8KB GPA memory which contains
>> + *                TDREPORT_STRUCT.
>> + * @len		: Length of the GPA in bytes.
> 
> It seems GetQuote definitions in public GHCI 1.0 and GHCI 1.5 are different.  In
> GHCI 1.5, R13 is used to specify the shared memory size.
> 
> I think it is because the public GHCI 1.0 hasn't been updated yet?

Please check the latest 1.0 specification (updated on Feb 2022). It has
details about R13 register.

> 
>> + *
>> + * return 0 on success or failure error number.
>> + */
>> +long tdx_hcall_get_quote(void *data, u64 len)
>> +{
>> +	u64 ret;
>> +
>> +	/*
>> +	 * Use confidential guest TDX check to ensure this API is only
>> +	 * used by TDX guest platforms.
>> +	 */
>> +	if (!data || !cpu_feature_enabled(X86_FEATURE_TDX_GUEST))
>> +		return -EINVAL;
>> +
>> +	/*
>> +	 * Pass the physical address of tdreport data to the VMM
>> +	 * and trigger the tdquote generation. Quote data will be
>> +	 * stored back in the same physical address space. More info
>> +	 * about ABI can be found in TDX Guest-Host-Communication
>> +	 * Interface (GHCI), sec titled "TDG.VP.VMCALL<GetQuote>".
>> +	 */
>> +	ret = _tdx_hypercall(TDVMCALL_GET_QUOTE, cc_mkdec(virt_to_phys(data)),
>> +			     len, 0, 0);
> 
> I think this function gives people impression that when this function is done,
> the Quote is ready immediately in the shared buffer.  But actually GetQuote is
> asynchronous.  It only means the VMM has accepted this request, but the Quote is
> actually only ready when the guest receives the event notification (done in
> later patch).  So I guess there should be a comment somewhere (or even in commit
> message) to explain that?

I will include details about asynchronous request in commit log as
mentioned above.



-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
