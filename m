Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C16A4B71E6
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 17:41:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241577AbiBOQ1k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 11:27:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241558AbiBOQ1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 11:27:25 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEE716BDDB
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 08:27:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644942433; x=1676478433;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FhUgSu8QDriqHaKgF3RSsaX1eOMu6Th4q4D3Ki12HOQ=;
  b=IL6/NkCWfuMMlWKFaDwipGZ7FZU6IJE4Rggi3SAymxwhvXou9JiTShK2
   QzjSvTtGxUOquKXtFCjJPGIEF8xVbkpRKPqH/LCR+RLByQbDUNdFucLeP
   cbFVuQvmKHGKbs+Z4hYbWYqLRLFiZSqGs6S0Q0aFVdDuGmgmn4/2ezyOe
   3E6pAzuAHYneXAKU2cVZArd3o9NFkXzmXKTUsshYjFYwnXkvUZdxSdn9K
   ra04DyydTVphQBV9QqcsCWjnJVRDboml99qg4xoigCrAwsU0hjf3AKCJO
   xcU6Y+2G0ifOoEImj4WaNHje8lADoR5M8cFxNDxcL31hCEVeFRuleHAb1
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10258"; a="250128868"
X-IronPort-AV: E=Sophos;i="5.88,371,1635231600"; 
   d="scan'208";a="250128868"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 08:27:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,371,1635231600"; 
   d="scan'208";a="502523569"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 15 Feb 2022 08:27:07 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id A3748107; Tue, 15 Feb 2022 18:27:22 +0200 (EET)
Date:   Tue, 15 Feb 2022 19:27:22 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@intel.com>, tglx@linutronix.de,
        mingo@redhat.com, luto@kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 22/29] x86/tdx: Make pages shared in ioremap()
Message-ID: <20220215162722.cvzik5r57spr2krz@black.fi.intel.com>
References: <20220124150215.36893-1-kirill.shutemov@linux.intel.com>
 <20220124150215.36893-23-kirill.shutemov@linux.intel.com>
 <YgFIaJ8ijgQQ04Nv@zn.tnic>
 <1d77e91c-e151-7846-6cd4-6264236ca5ae@intel.com>
 <YgFWpGQfA84Y0mW/@zn.tnic>
 <20220214220926.fjwlyieatwjhcpij@black.fi.intel.com>
 <f1dfc268-7b2f-9980-27ce-0b5bb1aea962@amd.com>
 <20220215154118.ldpvvk5seljntl44@black.fi.intel.com>
 <dd21e54a-a431-4d6f-47b7-ab1a3e8e0cc8@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd21e54a-a431-4d6f-47b7-ab1a3e8e0cc8@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 15, 2022 at 09:55:16AM -0600, Tom Lendacky wrote:
> On 2/15/22 09:41, Kirill A. Shutemov wrote:
> > On Tue, Feb 15, 2022 at 08:49:34AM -0600, Tom Lendacky wrote:
> > > On 2/14/22 16:09, Kirill A. Shutemov wrote:
> > > > On Mon, Feb 07, 2022 at 06:28:04PM +0100, Borislav Petkov wrote:
> > > > > On Mon, Feb 07, 2022 at 08:57:39AM -0800, Dave Hansen wrote:
> > > > > > We can surely *do* this with cc_something() helpers.  It's just not as
> > > > > > easy as making cc_set/cc_clear().
> > > > > 
> > > > > Sure, that's easy: cc_pgprot_{enc,dec}() or so.
> > > > 
> > > > So, I've ended up with this in <asm/pgtable.h>
> > > > 
> > > > /*
> > > >    * Macros to add or remove encryption attribute
> > > >    */
> > > > #ifdef CONFIG_ARCH_HAS_CC_PLATFORM
> > > > pgprotval_t cc_enc(pgprotval_t protval);
> > > > pgprotval_t cc_dec(pgprotval_t protval);
> > > > #define pgprot_encrypted(prot)	__pgprot(cc_enc(pgprot_val(prot)))
> > > > #define pgprot_decrypted(prot)	__pgprot(cc_dec(pgprot_val(prot)))
> > > > #else
> > > > #define pgprot_encrypted(prot) (prot)
> > > > #define pgprot_decrypted(prot) (prot)
> > > > #endif
> > > 
> > > A couple of things. I think cc_pgprot_enc() and cc_pgprot_dec() would be
> > > more descriptive/better names to use here.
> > > 
> > > Also, can they be defined in include/linux/cc_platform.h (with two versions
> > > based on CONFIG_ARCH_HAS_CC_PLATFORM) and have that included here? Or is
> > > there some header file include issues when trying to include it? That would
> > > clean this block up into just two lines.
> > 
> > Well, pgprotval_t is x86-specific. It cannot be used in generic headers.
> 
> Ah, right.
> 
> > We can use u64 here instead. It is wider than pgprotval_t on 2-level
> > paging x86, but should work.
> 
> Hmm..., yeah. Maybe unsigned long? CONFIG_ARCH_HAS_CC_PLATFORM is X86_64
> only, so 2-level paging wouldn't be applicable when an unsigned long is
> 64-bits?

Hm. So for !CONFIG_ARCH_HAS_CC_PLATFORM it has to be define, if we would
try static inline dummy instead it will break x86 PAE as upper bit get
trancated when passed via helper.

I donno.

> I'll let the maintainers weigh in on that.
> 
> > 
> > But with u64 as type, I'm not sure 'pgprot' in the name is jutified.
> 
> Maybe cc_mask_{enc,dec}()? It just sounds like cc_{enc,dec}() is actually
> performing encryption or decryption and can be confusing.

cc_{enc,dec}_mask() sounds better to me.

-- 
 Kirill A. Shutemov
