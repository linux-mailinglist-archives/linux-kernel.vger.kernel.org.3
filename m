Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE6B4D4FB5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 17:50:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243610AbiCJQt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 11:49:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244144AbiCJQtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 11:49:53 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D8D717585A
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 08:48:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646930932; x=1678466932;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IcAkxvYvS0GhKBxpgZC3fjhoXmiXRZxmpIyCLd0r7M0=;
  b=eT/FI4rvHkCrHw5iDhocOFgTzYAIYPVTFSfHLatw0IPAPaFANE2rZ5u+
   sdxsg1H+Vp3kjy12GQVtrjffgWoo2hyJmn0CkonNg9oanFqrcj1VdnJZv
   YSJRuXD3KfJERmqYPI8XXSPo8RQA5+RROEZeOfZdYWxUERcKScS08mCrO
   N52J7/UzoHMdDZUeiFCMbC79roJRoZvfJAZV6bZ3GjnmRfccP5YIzbHrt
   8gzrS86WyBz4wRFAwTWiN5+ww+BVlBJAC6Y9Tdcuw2ucKaLinqg32wa3D
   OYRb/opiyt/sYKcF9Q3AuM7Povjmm4SVUgK1fLgqikkKZLaDd/hzrB9Oj
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10282"; a="280039890"
X-IronPort-AV: E=Sophos;i="5.90,171,1643702400"; 
   d="scan'208";a="280039890"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 08:48:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,171,1643702400"; 
   d="scan'208";a="633051594"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 10 Mar 2022 08:48:21 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id E621625F; Thu, 10 Mar 2022 18:48:39 +0200 (EET)
Date:   Thu, 10 Mar 2022 19:48:39 +0300
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
        thomas.lendacky@amd.com, brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv5 11/30] x86/tdx: Handle in-kernel MMIO
Message-ID: <20220310164839.erpjijvxwuzjql5x@black.fi.intel.com>
References: <20220302142806.51844-1-kirill.shutemov@linux.intel.com>
 <20220302142806.51844-12-kirill.shutemov@linux.intel.com>
 <81a7ad6d-6bd9-7674-3229-67a5cd2e485a@intel.com>
 <20220310005145.hzv2lzxgs7uxblfr@black.fi.intel.com>
 <da0056e8-58cf-2c95-fe66-4dad1ae9c4da@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da0056e8-58cf-2c95-fe66-4dad1ae9c4da@intel.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 09, 2022 at 05:06:11PM -0800, Dave Hansen wrote:
> On 3/9/22 16:51, Kirill A. Shutemov wrote:
> > On Tue, Mar 08, 2022 at 01:26:28PM -0800, Dave Hansen wrote:
> >> Memory encryption has zero to do with this.  The TDX isolation
> >> mechanisms are totally discrete from memory encryption, although they
> >> are "neighbors" of sorts.
> > 
> > Hm. I don't see why you say encryption is not relevant. VMM (host kernel)
> > has ultimate access to guest memory cypher text. It can read it as
> > cypher text without any issue (using KeyID-0).
> > 
> > Could you elaborate on the point?
> 
> I think you're just confusing what TDX has with MKTME.  The whitepaper says:
> 
> > The TD-bit associated with the line in memory seeks to
> > detect software or devices attempting to read memory
> > encrypted with private KeyID, using a shared KeyID, to reveal
> > the ciphertext. On such accesses, the MKTME returns a fixed
> > pattern to prevent ciphertext analysis.
> 
> I think several firstborn were sacrificed to get that bit.  Let's not
> forget why we have it. :)

Okay, I missed the memo. I will drop reference to encryption:

  - The CPU disallows software other than the TDX module and TDs from
    making memory accesses using the private key. Without the correct
    key VMM has no way to access TD-private memory.

> >>> Rather than touching the entire kernel, it might also be possible to
> >>> just go after drivers that use MMIO in TDX guests.  Right now, that's
> >>> limited only to virtio and some x86-specific drivers.
> >>>
> >>> All virtio MMIO appears to be done through a single function, which
> >>> makes virtio eminently easy to patch.
> >>>
> >>> This approach will be adopted in the future, removing the bulk of
> >>> MMIO #VEs. The #VE-based MMIO will remain serving non-virtio use cases.
> >>
> >> This still doesn't *quite* do it for me for a justification.  Why can't
> >> the non-virtio cases be converted as well?  Why doesn't the "patching
> >> MMIO sites" work for x86 code too?
> >>
> >> You really need to convince us that *this* approach will be required
> >> forever.
> > 
> > What if I add:
> > 
> > 	Many drivers can potentially be used inside TDX guest (e.g. via device
> > 	passthough or random device emulation by VMM), but very few will.
> > 	Patching every possible driver is not practical. #VE-based MMIO provides
> > 	functionality for everybody. Performance-critical cases can be optimized
> > 	as needed.
> 
> This problem was laid out as having three cases:
> 1. virtio
> 2. x86-specific drivers
> 3. random drivers (everything else)
> 
> #1 could be done with paravirt
> #2 is unspecified and unknown
> #3 use doesn't as far as I know exist in TDX guests today

#2 doesn't matter from performance point of view and there is no
convenient place where they can be intercepted as they are scattered
across the tree. Patching them doesn't bring any benefit, only pain.

#3 some customers already declared that they will use device passthough
(yes, it is not safe). CSP may want to emulate random device, depending on
setup. Like, a power button or something.

> > BUG() here makes it clear that the handler itself is buggy. Returning
> > false and kicking in #GP-like logic indicates that something wrong with
> > the code that triggered #VE. I think it is an important distinction.
> 
> OK, then how about a WARN_ON() which is followed by the #GP?

You folks give mixed messages. Thomas was very unhappy when I tried to add
code that recovers from WBINVD:

https://lore.kernel.org/all/87y22uujkm.ffs@tglx

It is exactly the same scenario: kernel code is buggy and has to be fixed.

So, what the policy?

> Let's say insn_decode_mmio() does something insane like:
> 
> 	return -EINVAL;
> 
> Should we really be killing the kernel for that?

Note that #GP is most likely kill kernel as well. We handle in-kernel
MMIO. There are no many chances for recover.

Is it really the big deal?

-- 
 Kirill A. Shutemov
