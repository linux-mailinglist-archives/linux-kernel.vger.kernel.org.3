Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C87C47E6BB
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 18:15:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244424AbhLWRP3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 12:15:29 -0500
Received: from mga17.intel.com ([192.55.52.151]:29383 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240188AbhLWRP1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 12:15:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640279727; x=1671815727;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QqFBfmp5RzVWtBEjuzqJTnU0qdscrlJtGqwQLoPJA7o=;
  b=boXvP8PY2lomknruH4HSq0sbnqeKc6WIcND63hOqu7YxrVW5T9836eLk
   KE4TrDAQH26OJeCCOrqZlnecrx3J4TF73qTlZhlSm01UqmI7bduPmqaq8
   qOanoaQGb00psnnxIyepTd62R4h0d7Cs18lfjyZId9cN6cB6fkYKPMC+U
   56V7NJ8JIB1dUhWhg+MObHD8+hMZSL7MIiZf5b+HntJr6WQmYDh/odwzW
   f8cCPY0w/47bMdyAaAo9pGGZ9frwOqNSG/Db0lMta4IV+32uYoYBsFtGt
   gmjHxpskUc5imgyV+pl+6zx2YmFwBx4C+mKPj9Cy9gH7csVVj/DUWatn3
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10207"; a="221532085"
X-IronPort-AV: E=Sophos;i="5.88,230,1635231600"; 
   d="scan'208";a="221532085"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2021 09:15:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,230,1635231600"; 
   d="scan'208";a="664639357"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 23 Dec 2021 09:15:21 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 42F7F125; Thu, 23 Dec 2021 19:15:30 +0200 (EET)
Date:   Thu, 23 Dec 2021 20:15:30 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@intel.com, luto@kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 19/26] x86/tdx: Make pages shared in ioremap()
Message-ID: <20211223171530.v73posbqizb5l3md@black.fi.intel.com>
References: <20211214150304.62613-1-kirill.shutemov@linux.intel.com>
 <20211214150304.62613-20-kirill.shutemov@linux.intel.com>
 <87c288d6-9bf8-5a94-a628-1e0aaa7de690@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87c288d6-9bf8-5a94-a628-1e0aaa7de690@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 22, 2021 at 11:26:59AM -0600, Tom Lendacky wrote:
> On 12/14/21 9:02 AM, Kirill A. Shutemov wrote:
> > In TDX guests, guest memory is protected from host access. If a guest
> > performs I/O, it needs to explicitly share the I/O memory with the host.
> > 
> > Make all ioremap()ed pages that are not backed by normal memory
> > (IORES_DESC_NONE or IORES_DESC_RESERVED) mapped as shared.
> > 
> > Since TDX memory encryption support is similar to AMD SEV architecture,
> > reuse the infrastructure from AMD SEV code. Introduce CC_ATTR_GUEST_TDX
> > to add TDX-specific changes to the AMD SEV/SME memory encryption code.
> > 
> > Add tdx_shared_mask() interface to get the TDX guest shared bitmask.
> > 
> > pgprot_decrypted() is used by drivers (i915, virtio_gpu, vfio). Export
> > both pgprot_encrypted() and pgprot_decrypted().
> > 
> 
> > --- a/arch/x86/mm/mem_encrypt.c
> > +++ b/arch/x86/mm/mem_encrypt.c
> > @@ -14,6 +14,33 @@
> >   #include <linux/mem_encrypt.h>
> >   #include <linux/virtio_config.h>
> > +#include <asm/tdx.h>
> > +
> > +/*
> > + * Set or unset encryption attribute in vendor agnostic way.
> > + */
> > +pgprot_t pgprot_cc_encrypted(pgprot_t prot)
> > +{
> > +	if (cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT))
> > +		return __pgprot(__sme_set(pgprot_val(prot)));
> > +	else if (cc_platform_has(CC_ATTR_GUEST_TDX))
> > +		return __pgprot(pgprot_val(prot) & ~tdx_shared_mask());
> > +
> 
> Hmmm... I believe this breaks SEV guests. __sme_set() uses sme_me_mask which
> is used for both SME and SEV. With the current checks, an SEV guest will end
> up never setting an encrypted address through this path. Ditto below on the
> decrypted path.

Hm, okay. What if I rewrite code like this:

	pgprot_t pgprot_cc_encrypted(pgprot_t prot)
	{
		if (cc_platform_has(CC_ATTR_GUEST_TDX))
			return __pgprot(pgprot_val(prot) & ~tdx_shared_mask());
		else
			return __pgprot(__sme_set(pgprot_val(prot)));
	}

I believe it should cover all cases, right?

-- 
 Kirill A. Shutemov
