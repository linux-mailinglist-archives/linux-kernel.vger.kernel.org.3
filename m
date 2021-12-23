Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 514C447E876
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 20:45:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350134AbhLWTpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 14:45:25 -0500
Received: from mga17.intel.com ([192.55.52.151]:40586 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244856AbhLWTpY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 14:45:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640288724; x=1671824724;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=j8eIjUTXW9JyiXE6K/txhHNEDG17b/pLKDktFtjKMN4=;
  b=RH+CzYIxOX4KOwZa2iVykKmurdLxE8mNqlAM7pQMbn3OUKGyOya6nPp9
   KUzfZemyFu7xri1EBV1Q4PyV5VZPjEP8G/C6Ag/16DEHEMXNbhJR0BOJK
   P1nsz33y6TuGBmsUI9eu0+i6+4vabETmu/c8VCya3D4EH06/x4pk9GlWS
   CD1Xa3Ad0hki250v5uDtK3gVSnssq2aJtxZl2Y+94pyAUW1We7tScshW7
   R7mZSsXlzXDHEDzYHdRyU6G5fzNnSHb9BHChmbipgqGNcghPHFvvVOROs
   +DE/H9u6UYBV9EDSWR8boPuucPlvTfm40RGEE/Ey4rd6iegWOOMSHpTWJ
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10207"; a="221552446"
X-IronPort-AV: E=Sophos;i="5.88,230,1635231600"; 
   d="scan'208";a="221552446"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2021 11:45:23 -0800
X-IronPort-AV: E=Sophos;i="5.88,230,1635231600"; 
   d="scan'208";a="485183615"
Received: from sameersi-mobl.amr.corp.intel.com (HELO [10.212.229.5]) ([10.212.229.5])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2021 11:45:22 -0800
Subject: Re: [PATCH 19/26] x86/tdx: Make pages shared in ioremap()
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        luto@kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
References: <20211214150304.62613-1-kirill.shutemov@linux.intel.com>
 <20211214150304.62613-20-kirill.shutemov@linux.intel.com>
 <87c288d6-9bf8-5a94-a628-1e0aaa7de690@amd.com>
 <20211223171530.v73posbqizb5l3md@black.fi.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
 z5cecg==
Message-ID: <f61b591b-a06c-bc29-4b9b-a5d46111fe4e@intel.com>
Date:   Thu, 23 Dec 2021 11:45:19 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20211223171530.v73posbqizb5l3md@black.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/23/21 9:15 AM, Kirill A. Shutemov wrote:
>>> +pgprot_t pgprot_cc_encrypted(pgprot_t prot)
>>> +{
>>> +	if (cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT))
>>> +		return __pgprot(__sme_set(pgprot_val(prot)));
>>> +	else if (cc_platform_has(CC_ATTR_GUEST_TDX))
>>> +		return __pgprot(pgprot_val(prot) & ~tdx_shared_mask());
>>> +
>> Hmmm... I believe this breaks SEV guests. __sme_set() uses sme_me_mask which
>> is used for both SME and SEV. With the current checks, an SEV guest will end
>> up never setting an encrypted address through this path. Ditto below on the
>> decrypted path.
> Hm, okay. What if I rewrite code like this:
> 
> 	pgprot_t pgprot_cc_encrypted(pgprot_t prot)
> 	{
> 		if (cc_platform_has(CC_ATTR_GUEST_TDX))
> 			return __pgprot(pgprot_val(prot) & ~tdx_shared_mask());
> 		else
> 			return __pgprot(__sme_set(pgprot_val(prot)));
> 	}
> 
> I believe it should cover all cases, right?

I _think_ that should be fine for now.  But, it does expose that
__sme_set() is weird because it get used on non-SME systems while
tdx_shared_mask() is only used on TDX systems.

Ideally, we'd eventually get to something close to what you had originally:

pgprot_t pgprot_cc_encrypted(pgprot_t prot)
{
	if (cc_platform_has(CC_ATTR_GUEST_TDX))
		return __pgprot(pgprot_val(prot) & ~tdx_shared_mask());
	if (cc_platform_has(CC_ATTR_SME_SOMETHING??))
		return __pgprot(pgprot_val(prot) | sme_me_mask));

	return prot;
}

CC_ATTR_SME_SOMETHING would get set when sme_me_mask is initialized to
something non-zero.  That will keep folks from falling into the same
trap that you did in the long term.

The SEV code wasn't crazy for doing what it did when it was the only
game in town.  But, now that TDX is joining the party, we need to make
sure that SEV isn't special.
