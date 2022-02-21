Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F1924BED34
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 23:28:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235551AbiBUW3N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 17:29:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235514AbiBUW3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 17:29:10 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CC4465A4
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 14:28:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645482526; x=1677018526;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5z6TNYBa1E/tQG09GqFVS0q8BYwOfAtcawhwoAICR4o=;
  b=mXoVMVEy9WiDJnd94Zewmqpjcbdy85pyLTBOYqXnEFgsKOSEtY8zLV0O
   OYM+tXWN2hK7JlIGM5i/xVJTmnPEVHS0+jjHGj9RcD6wEQDOYkEfa5dwx
   XF4hTLnCU2w1ahdyFOw/+A5SG5G6U3iBJ+25iFVmAVnQmLtuvgHkuapkP
   pELR11kIBAFFJ05oyYPYKNx18+IVJ30UYHs/7IO5si2gFaKcGENsQHMrl
   kRWPNicVY5uZlZwuoGeHzcAfyco5++CCko7fAhravYASxFBc7f2WWYpbY
   0JFN6TO0Q7Z2Bvk/rq718H0AsB7vsbNPHIWGrk5dl1LXynAvhvg0gfhGB
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10265"; a="276169999"
X-IronPort-AV: E=Sophos;i="5.88,386,1635231600"; 
   d="scan'208";a="276169999"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2022 14:28:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,386,1635231600"; 
   d="scan'208";a="776106630"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 21 Feb 2022 14:28:40 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id EA84C12C; Tue, 22 Feb 2022 00:28:56 +0200 (EET)
Date:   Tue, 22 Feb 2022 01:28:56 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        luto@kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv3 02/32] x86/coco: Add API to handle encryption mask
Message-ID: <20220221222856.c6b74b3n3fwqe6vy@black.fi.intel.com>
References: <20220218161718.67148-1-kirill.shutemov@linux.intel.com>
 <20220218161718.67148-3-kirill.shutemov@linux.intel.com>
 <66fcd7e7-deb6-f27e-9fc6-33293ce04f16@intel.com>
 <20220218213300.2bs4t3admhozonaq@black.fi.intel.com>
 <7ebd6ba1-85a4-6fee-c897-22ed108ac8b7@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ebd6ba1-85a4-6fee-c897-22ed108ac8b7@intel.com>
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 21, 2022 at 11:28:16AM -0800, Dave Hansen wrote:
> I'm just a bit confused why *this* was chosen as the cc_whatever() hook.
>  Just like the mask function, it has one spot where it gets used:
> 
> +#define pgprot_encrypted(prot)	__pgprot(cc_mkenc(pgprot_val(prot)))
> +#define pgprot_decrypted(prot)	__pgprot(cc_mkdec(pgprot_val(prot)))
> 
> So, why bother having another level of abstraction?
> 
> Why don't we just have:
> 
> 	pgprot_t cc_mkenc(pgprot prot)
> 	pgprot_t cc_mkenc(pgprot prot)
> 
> and *no* pgprot_{en,de}crypted()?

Okay. Let me try this.

> >>> +out:
> >>>  	physical_mask &= ~sme_me_mask;
> >>> +	if (sme_me_mask)
> >>> +		cc_init(CC_VENDOR_AMD, sme_me_mask);
> >>>  }
> >>
> >> I don't think you need to mop it up here, but where does this leave
> >> sme_me_mask?
> > 
> > I think sme_me_mask still can be useful to indicate that the code is only
> > relevant for AMD context.
> 
> Shouldn't we be able to tell that because something is in an
> AMD-specific file, function or #ifdef?

Sure. But for some code it is not immidiately obvious that it is
AMD-specific. Like from file name alone, mem_encrypt_identity.c doesn't
look like it is only AMD thing.

Anyway, I think getting rid of sme_me_mask is out of scope for the
patchset.

> Is there ever a time where sme_me_mask is populated by cc_mask is not?

Yes. Decompression code. (I know it doesn't affect bottom line much).

> This seems like it is just making a copy of sme_me_mask.
> 
> sme_me_mask does look quite AMD-specialized, like its assembly
> manipulation.  Even if it's just a copy of cc_mask, it would be nice to
> call that out so the relationship is crystal clear.

-- 
 Kirill A. Shutemov
