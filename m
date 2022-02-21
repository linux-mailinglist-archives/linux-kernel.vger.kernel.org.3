Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6461E4BED0D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 23:14:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235257AbiBUWOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 17:14:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbiBUWOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 17:14:41 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CE3EDA1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 14:14:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645481657; x=1677017657;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=k0LGZcF34AzYUyZ6uE6NhbzWtk03tdkaMAz0Tr4gNVg=;
  b=Ux/bRjoWiyllfSrnRYwqNXJ/FzLbETn5P4EnFNIfU8nFq3Hdj8+3rmB7
   +aICklqDszFOo5ibVBWs7nGBuCLXXSqKV3BCL74Ic8Z+nGHiaActBX3Ws
   RVYl6NpAl4RE67Ka58k++rpPiRLDonZS+5TuU5OTma/8Ae8wps/QEcM7z
   gp2a6iF41dpw81FRK4pugDVD/5z0kqF3TCAfTioOao+UJmBOy/j7Qi8m1
   2QLklRk4PNEfJikXaX5TNwKhro+x+w62xW3NbI5fq7aJo4RRj5ebBsm2L
   luplG8KG7UvEeiW61NOlm9e51LkuLYuF9nrMmuEw+T8r/9o9tYfRT8hUf
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10265"; a="338006042"
X-IronPort-AV: E=Sophos;i="5.88,386,1635231600"; 
   d="scan'208";a="338006042"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2022 14:14:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,386,1635231600"; 
   d="scan'208";a="591087330"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 21 Feb 2022 14:14:08 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 190AD12C; Tue, 22 Feb 2022 00:14:25 +0200 (EET)
Date:   Tue, 22 Feb 2022 01:14:24 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>, bp@alien8.de,
        aarcange@redhat.com, ak@linux.intel.com, dan.j.williams@intel.com,
        dave.hansen@intel.com, david@redhat.com, hpa@zytor.com,
        jgross@suse.com, jmattson@google.com, joro@8bytes.org,
        jpoimboe@redhat.com, knsathya@kernel.org,
        linux-kernel@vger.kernel.org, luto@kernel.org, mingo@redhat.com,
        pbonzini@redhat.com, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, sdeep@vmware.com,
        seanjc@google.com, tglx@linutronix.de, tony.luck@intel.com,
        vkuznets@redhat.com, wanpengli@tencent.com, x86@kernel.org
Subject: Re: [PATCHv3.1 2.1/2] x86/coco: Add API to handle encryption mask
Message-ID: <20220221221424.r7ffo5je4lyt4tw5@black.fi.intel.com>
References: <YhAWcPbzgUGcJZjI@zn.tnic>
 <20220219001305.22883-1-kirill.shutemov@linux.intel.com>
 <20220219001305.22883-2-kirill.shutemov@linux.intel.com>
 <0c0a4199-1318-5290-9d9d-43bcb9017228@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c0a4199-1318-5290-9d9d-43bcb9017228@amd.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 21, 2022 at 12:31:40PM -0600, Tom Lendacky wrote:
> On 2/18/22 18:13, Kirill A. Shutemov wrote:
> > AMD SME/SEV uses a bit in the page table entries to indicate that the
> > page is encrypted and not accessible to the VMM.
> > 
> > TDX uses a similar approach, but the polarity of the mask is opposite to
> > AMD: if the bit is set the page is accessible to VMM.
> > 
> > Provide vendor-neutral API to deal with the mask:
> > 
> >    - cc_mkenc() and cc_mkdec() modify given address to make it
> >      encrypted/decrypted. It can be applied to phys_addr_t, pgprotval_t
> >      or page table entry value.
> > 
> >    - cc_get_mask() returns encryption or decrypthion mask. It is useful
> >      for set_memory_encrypted() and set_memory_decrypted()
> >      implementation.
> > 
> > The implementation will be extended to cover TDX.
> > 
> > pgprot_decrypted() is used by drivers (i915, virtio_gpu, vfio).
> > cc_mkdec() called by pgprot_decrypted(). Export cc_mkdec().
> > 
> > HyperV doesn't use bits in page table entries, so the mask is 0 for both
> > encrypthion and decrypthion.
> > 
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> 
> > @@ -84,7 +85,39 @@ bool cc_platform_has(enum cc_attr attr)
> >   }
> >   EXPORT_SYMBOL_GPL(cc_platform_has);
> > -__init void cc_init(enum cc_vendor vendor)
> > +u64 cc_get_mask(bool enc)
> 
> I was a bit confused by this name, expecting to always get the mask, but it
> is dependent on the input parameter.

Well, it always get you a mask. But it can be empty :P

> How about cc_get_operation_mask() or ... ? I'm struggling to come up
> with a good name, but plain cc_get_mask() is very confusing.

Yeah. Naming is hard. cc_get_operation_mask() doesn't clarify anything
comparing to cc_get_mask(). To me it is as confusing.
> 
> > +{
> > +	switch (cc_vendor) {
> > +	case CC_VENDOR_AMD:
> > +		return enc ? cc_mask : 0;
> > +	default:
> > +		return 0;
> > +	}
> > +}
> > +
> 
> > diff --git a/arch/x86/mm/mem_encrypt_identity.c b/arch/x86/mm/mem_encrypt_identity.c
> > index eb7fbd85b77e..fa758247ab57 100644
> > --- a/arch/x86/mm/mem_encrypt_identity.c
> > +++ b/arch/x86/mm/mem_encrypt_identity.c
> > @@ -603,5 +603,5 @@ void __init sme_enable(struct boot_params *bp)
> >   out:
> >   	physical_mask &= ~sme_me_mask;
> >   	if (sme_me_mask)
> > -		cc_init(CC_VENDOR_AMD);
> > +		cc_init(CC_VENDOR_AMD, sme_me_mask);
> 
> Since you're adding the if statement, you can probably wrap the adjustment
> to physical_mask within the if, also (I guess in the previous patch). Not
> required, though.

Can do.

-- 
 Kirill A. Shutemov
