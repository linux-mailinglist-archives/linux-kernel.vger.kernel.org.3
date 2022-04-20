Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5928A50832B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 10:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376638AbiDTILj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 04:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376548AbiDTILe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 04:11:34 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC3BC317;
        Wed, 20 Apr 2022 01:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650442128; x=1681978128;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=T8IOiGimponAiFg6YblqZ157bWvfR073NI+3RNlitMA=;
  b=O39DPZHBatvJvhYO9R8GqM71EHJ8yItg5TnBUrw8CilukWYy6RG9mtlL
   N6UPO3ftlO+v2hlUTemGwtbIpWuz54XG35v3Pwr7Crh+soR9LxXTWb8uO
   1AqGSM/ebujJAgOU09u5mcAesbZyk8vi5uydTR5bK1COD/UJzwfvE3yl3
   KwfeDMLAgvycsUGMH1xUVAUaKNRTWQnRBtP4EUeJfe8AwUmmeFi9GXS/X
   7u0TxhIURdQQLt+TUWOjwqq7R2ceIwlsPUNLNLFj/Zf7w/cPywuMbHk4F
   gNRJuFh5XdaGLLm8sfD3+ZkCaTri7kAWsSfvQEmCeybIK+J/CIyvIYGog
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10322"; a="263733651"
X-IronPort-AV: E=Sophos;i="5.90,275,1643702400"; 
   d="scan'208";a="263733651"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2022 01:08:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,275,1643702400"; 
   d="scan'208";a="668062369"
Received: from aubrey-app.sh.intel.com (HELO [10.239.53.25]) ([10.239.53.25])
  by orsmga004.jf.intel.com with ESMTP; 20 Apr 2022 01:08:45 -0700
Subject: Re: [PATCH v3 2/4] x86/tdx: Add tdx_hcall_get_quote() API support
To:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
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
 <f4d1fdb6-b836-a7c7-c9fb-cc4e6c14a335@linux.intel.com>
 <9a72ac4d-bb39-0459-7989-2bd65db1a2c2@linux.intel.com>
From:   Aubrey Li <aubrey.li@linux.intel.com>
Message-ID: <ac063746-8907-f364-36bc-f9d5b1b2edc8@linux.intel.com>
Date:   Wed, 20 Apr 2022 16:08:45 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <9a72ac4d-bb39-0459-7989-2bd65db1a2c2@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/4/20 下午3:16, Sathyanarayanan Kuppuswamy wrote:
> 
> 
> On 4/19/22 8:39 PM, Aubrey Li wrote:
>> On 2022/4/16 上午6:01, Kuppuswamy Sathyanarayanan wrote:
>>> Attestation is the process used by two un-trusted entities to prove to
>>> each other that it can be trusted. In TDX guest, attestation is mainly
>>> used to verify the trustworthiness of a TD to the 3rd party key
>>> servers.
>>>
>>> First step in the attestation process is to generate the TDREPORT data.
>>> This support is added using tdx_mcall_tdreport() API. The second stage
>>> in the attestation process is for the guest to request the VMM generate
>>> and sign a quote based on the TDREPORT acquired earlier. More details
>>> about the steps involved in attestation process can be found in TDX
>>> Guest-Host Communication Interface (GHCI) for Intel TDX 1.5, section
>>> titled "TD attestation"
>>>
>>> Add tdx_hcall_get_quote() helper function to implement the GetQuote
>>> hypercall.
>>>
>>> More details about the GetQuote TDVMCALL are in the Guest-Host
>>> Communication Interface (GHCI) Specification, sec 3.3, titled
>>> "VP.VMCALL<GetQuote>".
>>>
>>> This will be used by the TD attestation driver in follow-on patches.
>>>
>>> Reviewed-by: Tony Luck <tony.luck@intel.com>
>>> Reviewed-by: Andi Kleen <ak@linux.intel.com>
>>> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>>> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>>> ---
>>>   arch/x86/coco/tdx/tdx.c    | 38 ++++++++++++++++++++++++++++++++++++++
>>>   arch/x86/include/asm/tdx.h |  2 ++
>>>   2 files changed, 40 insertions(+)
>>>
>>> diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
>>> index 3e409b618d3f..c259d81a5d7f 100644
>>> --- a/arch/x86/coco/tdx/tdx.c
>>> +++ b/arch/x86/coco/tdx/tdx.c
>>> @@ -21,6 +21,7 @@
>>>     /* TDX hypercall Leaf IDs */
>>>   #define TDVMCALL_MAP_GPA        0x10001
>>> +#define TDVMCALL_GET_QUOTE        0x10002
>>>     /* MMIO direction */
>>>   #define EPT_READ    0
>>> @@ -144,6 +145,43 @@ long tdx_mcall_tdreport(void *data, void *reportdata)
>>>   }
>>>   EXPORT_SYMBOL_GPL(tdx_mcall_tdreport);
>>>   +/*
>>> + * tdx_hcall_get_quote() - Generate TDQUOTE using TDREPORT_STRUCT.
>>> + *
>>> + * @data        : Address of 8KB GPA memory which contains
>>> + *                TDREPORT_STRUCT.
>>> + * @len        : Length of the GPA in bytes.
>>> + *
>>> + * return 0 on success or failure error number.
>>> + */
>>> +long tdx_hcall_get_quote(void *data, u64 len)
>>> +{
>>> +    u64 ret;
>>> +
>>> +    /*
>>> +     * Use confidential guest TDX check to ensure this API is only
>>> +     * used by TDX guest platforms.
>>> +     */
>>> +    if (!data || !cpu_feature_enabled(X86_FEATURE_TDX_GUEST))
>>> +        return -EINVAL;
>>> +
>>> +    /*
>>> +     * Pass the physical address of tdreport data to the VMM
>>> +     * and trigger the tdquote generation. Quote data will be
>>> +     * stored back in the same physical address space. More info
>>> +     * about ABI can be found in TDX Guest-Host-Communication
>>> +     * Interface (GHCI), sec titled "TDG.VP.VMCALL<GetQuote>".
>>> +     */
>>> +    ret = _tdx_hypercall(TDVMCALL_GET_QUOTE, cc_mkdec(virt_to_phys(data)),
>>> +                 len, 0, 0);
>>> +
>>
>> I commented here in v2 but no response, so let me try again.
>>
>> IIUC, virt_to_phys(data) (GPA) will be stored in the register when
>> TDCALL brings the context back to the VMX root mode, and hypervisor(QEMU)
>> will find the mapped host virtual address(HVA) with the GPA in the register,
>> and the subsequent ops will be HVA<->HVA in hypervisor, EPT will not be
>> involved so no need to cc_mkdec() this GPA.
>>
>> Please help to correct me if I was wrong.
> 
> It was done to meet the expectation from VMM. For shared GPA address,
> VMM expects shared bit set. All cc_mkdec() does is to set this bit.
> 

It seems not a good idea to make the guest aware of the shared bit IMHO.
I didn't see it specified in GHCI, there should be at least a comment here
to explain this behavior.

Thanks,
-Aubrey


