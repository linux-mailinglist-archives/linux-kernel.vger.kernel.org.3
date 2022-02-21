Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BAEF4BED09
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 23:10:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235239AbiBUWLG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 17:11:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232574AbiBUWLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 17:11:03 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E5DD22BE8
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 14:10:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645481440; x=1677017440;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HXDpsO4PnA7oK+iuqN0JclwgfliWjhPPC0sBwx2fyv0=;
  b=kh9elufbL2LQPflG/90bJWRLN77A3RLQNLQb2isOR23fRENpIcy9z/Q1
   3GPGPzMxMwXo//VBoHUqN5Rcio9EWUK3mCw9JxfEOYCBOeaOkjgizKbSh
   NUyJ7/QZXWZtvArTZV5fRJpQOXaOzansXc4JHbC+aMuHrflx+imKDVD15
   T/6kYLmjmnpa/M/UebA9HjB0JhX4kK6cRqVhaavD8hKKLFVQQlNT3kag9
   zAsNAjE8p4QVd42nXYhBuQyqAD/2cWSJ1Aq7INsDKpVs/J7qTVCmw6Hi2
   8TXyEHgvMf+la6VtLgxgpnNb/Ek6dxkCsks7SUaSs01194QYa/g2HFUm7
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10265"; a="276168585"
X-IronPort-AV: E=Sophos;i="5.88,386,1635231600"; 
   d="scan'208";a="276168585"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2022 14:10:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,386,1635231600"; 
   d="scan'208";a="573218344"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 21 Feb 2022 14:10:33 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id E3D4612C; Tue, 22 Feb 2022 00:10:49 +0200 (EET)
Date:   Tue, 22 Feb 2022 01:10:49 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com,
        dave.hansen@intel.com, david@redhat.com, hpa@zytor.com,
        jgross@suse.com, jmattson@google.com, joro@8bytes.org,
        jpoimboe@redhat.com, knsathya@kernel.org,
        linux-kernel@vger.kernel.org, luto@kernel.org, mingo@redhat.com,
        pbonzini@redhat.com, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, sdeep@vmware.com,
        seanjc@google.com, tglx@linutronix.de, tony.luck@intel.com,
        vkuznets@redhat.com, wanpengli@tencent.com, x86@kernel.org
Subject: Re: [PATCHv3.1 2.1/2] x86/coco: Add API to handle encryption mask
Message-ID: <20220221221049.p5zvappg4s2mjem7@black.fi.intel.com>
References: <YhAWcPbzgUGcJZjI@zn.tnic>
 <20220219001305.22883-1-kirill.shutemov@linux.intel.com>
 <20220219001305.22883-2-kirill.shutemov@linux.intel.com>
 <YhP+kES/UVx7RwYz@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YhP+kES/UVx7RwYz@zn.tnic>
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 21, 2022 at 10:05:20PM +0100, Borislav Petkov wrote:
> On Sat, Feb 19, 2022 at 03:13:05AM +0300, Kirill A. Shutemov wrote:
> > AMD SME/SEV uses a bit in the page table entries to indicate that the
> > page is encrypted and not accessible to the VMM.
> > 
> > TDX uses a similar approach, but the polarity of the mask is opposite to
> > AMD: if the bit is set the page is accessible to VMM.
> > 
> > Provide vendor-neutral API to deal with the mask:
> > 
> >   - cc_mkenc() and cc_mkdec() modify given address to make it
> >     encrypted/decrypted. It can be applied to phys_addr_t, pgprotval_t
> >     or page table entry value.
> > 
> >   - cc_get_mask() returns encryption or decrypthion mask. It is useful
> 
> Unknown word [encrypthion] in commit message.
> Suggestions: ['encryption', 'decryption']
> 
> Unknown word [decrypthion] in commit message.
> Suggestions: ['decryption', 'encryption']

Ughh. Sorry. Will fix.

> > diff --git a/arch/x86/mm/mem_encrypt_identity.c b/arch/x86/mm/mem_encrypt_identity.c
> > index eb7fbd85b77e..fa758247ab57 100644
> > --- a/arch/x86/mm/mem_encrypt_identity.c
> > +++ b/arch/x86/mm/mem_encrypt_identity.c
> > @@ -603,5 +603,5 @@ void __init sme_enable(struct boot_params *bp)
> >  out:
> >  	physical_mask &= ~sme_me_mask;
> >  	if (sme_me_mask)
> > -		cc_init(CC_VENDOR_AMD);
> > +		cc_init(CC_VENDOR_AMD, sme_me_mask);
> 
> I'm wondering why this is looking weird... an init function with two
> arguments which get assigned. I think it would be better if you do:
> 
> 	cc_set_vendor(CC_VENDOR_XXX);
> 	cc_set_mask(mask);
> 
> and those helpers simply assign to __ro_after_init, local variables.
> 
> IOW, simple setter functions.

I'm not sure it is a good idea. It leaves room for code between these two
calls. I believe they conceptually has to initialized in one shot. That's
the only way we get consistent state.

-- 
 Kirill A. Shutemov
