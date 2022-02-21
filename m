Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AFD54BEAC8
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 20:37:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232159AbiBUT2r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 14:28:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiBUT2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 14:28:45 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7299C65FC
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 11:28:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645471702; x=1677007702;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=ax7MOh6iqPNpABeyMv0mtFHIoP6A+V0ZoaBmiM4rzLQ=;
  b=ZUuoxiNErOPB/scw0vHfZ57LMovqFp6L6jTvyJcHz4LytUT/D1jlf1rX
   1u+qZt9jQV5sctwzrLVmdey0vh3ZCK/EpFSgRafnEHxvzsHWgMsHXObzj
   9CfQIw7v56tiVmQPmxg8AM0/dxP74sNQk48FhHVLwuWv6KAGWhLXjE5/x
   kkbtOAsmIH2Yo7xHXmf6Ob5lnJk1ASVlkCfJiwCQy+vkgY0XPvo/6PYBc
   /1fPpaHVjero/iLmXXwoTfcFrJIubxm7+vM/iiJNpQMnLb3kp620a4RxB
   lh2TMAzomz1l8s9jeV6d/goxpudNZRidwNW4sJq9N4IihbKwHJ2Uc3NI0
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10265"; a="232180697"
X-IronPort-AV: E=Sophos;i="5.88,386,1635231600"; 
   d="scan'208";a="232180697"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2022 11:28:21 -0800
X-IronPort-AV: E=Sophos;i="5.88,386,1635231600"; 
   d="scan'208";a="638651388"
Received: from cynthiaj-mobl1.amr.corp.intel.com (HELO [10.212.185.129]) ([10.212.185.129])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2022 11:28:21 -0800
Message-ID: <7ebd6ba1-85a4-6fee-c897-22ed108ac8b7@intel.com>
Date:   Mon, 21 Feb 2022 11:28:16 -0800
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
        x86@kernel.org, linux-kernel@vger.kernel.org
References: <20220218161718.67148-1-kirill.shutemov@linux.intel.com>
 <20220218161718.67148-3-kirill.shutemov@linux.intel.com>
 <66fcd7e7-deb6-f27e-9fc6-33293ce04f16@intel.com>
 <20220218213300.2bs4t3admhozonaq@black.fi.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCHv3 02/32] x86/coco: Add API to handle encryption mask
In-Reply-To: <20220218213300.2bs4t3admhozonaq@black.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/18/22 13:33, Kirill A. Shutemov wrote:
> On Fri, Feb 18, 2022 at 12:36:02PM -0800, Dave Hansen wrote:
>> On 2/18/22 08:16, Kirill A. Shutemov wrote:
>>> +#ifdef CONFIG_ARCH_HAS_CC_PLATFORM
>>> +u64 cc_get_mask(bool enc);
>>> +u64 cc_mkenc(u64 val);
>>> +u64 cc_mkdec(u64 val);
>>> +#else
>>> +#define cc_get_mask(enc)	0
>>> +#define cc_mkenc(val)		(val)
>>> +#define cc_mkdec(val)		(val)
>>> +#endif
>>
>> Is there a reason the stubs as #defines?  Static inlines are preferred
>> for consistent type safety among other things.
> 
> I was slightly worried about 32-bit non-PAE that has phys_addr_t and
> pgprotval_t 32-bit. I was not completely sure it will not cause any
> issue due to type mismatch. Maybe it is ungrounded.
> 
> With CONFIG_ARCH_HAS_CC_PLATFORM=y, all relevant types are 64-bit.
> 
>> It would also be nice to talk about the u64 type in the changelog.  If I
>> remember right, there was a reason you didn't want to have a pgprot_t
>> here.
> 
> With standalone <asm/coco.h> I think we can make it work with other type.
> But I'm not sure what it has to be.
> 
> I found helpers useful for modifying pgprotval_t and phys_addr_t. I
> considered u64 a common ground.
> 
> Should I change this to something else?

cc_get_mask() is only used once and is assigned to a pgprot_t variable.
 I expect it to return a pgprot_t.

...
>>> +u64 cc_mkenc(u64 val)
>>> +{
>>> +	switch (cc_vendor) {
>>> +	case CC_VENDOR_AMD:
>>> +		return val | cc_mask;
>>> +	default:
>>> +		return val;
>>> +	}
>>> +}
>>> +
>>> +u64 cc_mkdec(u64 val)
>>> +{
>>> +	switch (cc_vendor) {
>>> +	case CC_VENDOR_AMD:
>>> +		return val & ~cc_mask;
>>> +	default:
>>> +		return val;
>>> +	}
>>> +}
>>> +EXPORT_SYMBOL_GPL(cc_mkdec);

I'm just a bit confused why *this* was chosen as the cc_whatever() hook.
 Just like the mask function, it has one spot where it gets used:

+#define pgprot_encrypted(prot)	__pgprot(cc_mkenc(pgprot_val(prot)))
+#define pgprot_decrypted(prot)	__pgprot(cc_mkdec(pgprot_val(prot)))

So, why bother having another level of abstraction?

Why don't we just have:

	pgprot_t cc_mkenc(pgprot prot)
	pgprot_t cc_mkenc(pgprot prot)

and *no* pgprot_{en,de}crypted()?

...
>>> +out:
>>>  	physical_mask &= ~sme_me_mask;
>>> +	if (sme_me_mask)
>>> +		cc_init(CC_VENDOR_AMD, sme_me_mask);
>>>  }
>>
>> I don't think you need to mop it up here, but where does this leave
>> sme_me_mask?
> 
> I think sme_me_mask still can be useful to indicate that the code is only
> relevant for AMD context.

Shouldn't we be able to tell that because something is in an
AMD-specific file, function or #ifdef?

Is there ever a time where sme_me_mask is populated by cc_mask is not?
This seems like it is just making a copy of sme_me_mask.

sme_me_mask does look quite AMD-specialized, like its assembly
manipulation.  Even if it's just a copy of cc_mask, it would be nice to
call that out so the relationship is crystal clear.
