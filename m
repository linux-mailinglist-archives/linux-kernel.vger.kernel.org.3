Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7042947EE6C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 12:03:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352529AbhLXLC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 06:02:59 -0500
Received: from mga17.intel.com ([192.55.52.151]:7982 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1352524AbhLXLC6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 06:02:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640343778; x=1671879778;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2sBxp1S7i2xOh6symJ3U/3bblwf9to+sMboPWcqsbjU=;
  b=c5XBD8aDwZrU9/6CKy1iHUS/e49+nuMLIIHDiFHXsox0hcFkAP5iT+gk
   qBrMXmZI4OgP9/7RE5lPIQ64Gac1Vii+8sYto8JRaFD+tjCGOxC9wQwy2
   HAq2A4NiNk8vB7JEyuCgJvvfla57Wpx7YE8aryhcsVS1BD4vxApjIR9H7
   lqTJCe4uY5pM/z953X7hm7X9Um10iB2u27w2wct+DPou1FGgTc1kOS1Cq
   DQo5aUT+dsCHLLVtT8b7v/qTOL79By62fajEi8Zcq9PzOcdF3L4vCA+yb
   9U0ywb21n4OYGJ9FXqPkwdr5oK5m1utaETZ4FIX/DPViMOBJGnyvEFhoI
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10207"; a="221637201"
X-IronPort-AV: E=Sophos;i="5.88,232,1635231600"; 
   d="scan'208";a="221637201"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Dec 2021 03:02:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,232,1635231600"; 
   d="scan'208";a="522410729"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 24 Dec 2021 03:02:51 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 7CCCB11E; Fri, 24 Dec 2021 13:03:00 +0200 (EET)
Date:   Fri, 24 Dec 2021 14:03:00 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Dave Hansen <dave.hansen@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>, tglx@linutronix.de,
        mingo@redhat.com, luto@kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 19/26] x86/tdx: Make pages shared in ioremap()
Message-ID: <20211224110300.7zj3nc5nbbv7jobp@black.fi.intel.com>
References: <20211214150304.62613-1-kirill.shutemov@linux.intel.com>
 <20211214150304.62613-20-kirill.shutemov@linux.intel.com>
 <87c288d6-9bf8-5a94-a628-1e0aaa7de690@amd.com>
 <20211223171530.v73posbqizb5l3md@black.fi.intel.com>
 <f61b591b-a06c-bc29-4b9b-a5d46111fe4e@intel.com>
 <YcTTt4LXKfDO+9u3@zn.tnic>
 <20211223205604.g44kez5d7iedatfo@box.shutemov.name>
 <YcTlhp1PUfrMOelI@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YcTlhp1PUfrMOelI@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 23, 2021 at 10:09:26PM +0100, Borislav Petkov wrote:
> On Thu, Dec 23, 2021 at 11:56:04PM +0300, Kirill A. Shutemov wrote:
> > Except CC_ATTR_MEM_ENCRYPT is true for TDX too, so it will also depend on
> > check order. It is fragile.
> 
> So the query you wanna do is:
> 
> 	if (memory encryption in use)
> 		use mask;
> 
> and the mask you use depends on whether it is SEV or TDX. Right?
> 
> If so, you can either do a cc_get_mask() function which gives you either
> the SEV or TDX mask or simply do:
> 
> 	if (CC_ATTR_MEM_ENCRYPT) {
> 		if (CC_ATTR_GUEST_TDX)
> 			mask = tdx_shared_mask();
> 		else if (sme_me_mask)
> 			mask = sme_me_mask;
> 	}
> 
> Yeah, sme_me_mask has become synonymous with the kernel running as a AMD
> confidential guest. I need to think about how to make this cleaner...

Okay. Meanwhile I leave it this way:

	pgprot_t pgprot_cc_encrypted(pgprot_t prot)
	{
		if (cc_platform_has(CC_ATTR_MEM_ENCRYPT)) {
			if (cc_platform_has(CC_ATTR_GUEST_TDX))
				return __pgprot(pgprot_val(prot) & ~tdx_shared_mask());
			else if (sme_me_mask)
				return __pgprot(__sme_set(pgprot_val(prot)));
			else
				WARN_ON_ONCE(1);
		}

		return prot;
	}
	EXPORT_SYMBOL_GPL(pgprot_cc_encrypted);

	pgprot_t pgprot_cc_decrypted(pgprot_t prot)
	{
		if (cc_platform_has(CC_ATTR_MEM_ENCRYPT)) {
			if (cc_platform_has(CC_ATTR_GUEST_TDX))
				return __pgprot(pgprot_val(prot) | tdx_shared_mask());
			else if (sme_me_mask)
				return __pgprot(__sme_clr(pgprot_val(prot)));
			else
				WARN_ON_ONCE(1);
		}

		return prot;
	}
	EXPORT_SYMBOL_GPL(pgprot_cc_decrypted);

-- 
 Kirill A. Shutemov
