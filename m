Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF59F4B71B4
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 17:41:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240913AbiBOPrq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 10:47:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241024AbiBOPpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 10:45:32 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7267124C1F
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 07:41:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644939669; x=1676475669;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eY2KZ759nJJ193QyirITPXbPZMmn0kpdQZNK786m41o=;
  b=Chsly+UK+5A18hv/z8g4MLfDYrdZW2ued2oxvgXj1nmfoFEByEDUe7cJ
   ZHXnN+0xIjVG744Zt7F8+vq29aqSnF6wM6PdROxcQb7h4NPzC3P4Zo0NF
   4zxeyQiE9wZe5mD6GxWWfX7tBKnEhNqgwvWnyRRJdLrwA1bROdv4j2sC3
   mcNFCiwj4bT4y2UGcFKIkDWA4m3iSCiRsdfW0a7X7Q1Sp8AUKUwa3AKrp
   SJgIt34ZZNcIHEJXL2KLpeo+e0RksIFJQkqih6uKeKYL3ytvoybmXu5SW
   GOg2sMY9gektp8TD9xtUtpGnPhl564fL5hkLGvU0/Gb5nQlRwWe/ZXmQY
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10258"; a="247973908"
X-IronPort-AV: E=Sophos;i="5.88,371,1635231600"; 
   d="scan'208";a="247973908"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 07:41:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,371,1635231600"; 
   d="scan'208";a="528924530"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 15 Feb 2022 07:41:03 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 08A12107; Tue, 15 Feb 2022 17:41:18 +0200 (EET)
Date:   Tue, 15 Feb 2022 18:41:18 +0300
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
Message-ID: <20220215154118.ldpvvk5seljntl44@black.fi.intel.com>
References: <20220124150215.36893-1-kirill.shutemov@linux.intel.com>
 <20220124150215.36893-23-kirill.shutemov@linux.intel.com>
 <YgFIaJ8ijgQQ04Nv@zn.tnic>
 <1d77e91c-e151-7846-6cd4-6264236ca5ae@intel.com>
 <YgFWpGQfA84Y0mW/@zn.tnic>
 <20220214220926.fjwlyieatwjhcpij@black.fi.intel.com>
 <f1dfc268-7b2f-9980-27ce-0b5bb1aea962@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1dfc268-7b2f-9980-27ce-0b5bb1aea962@amd.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 15, 2022 at 08:49:34AM -0600, Tom Lendacky wrote:
> On 2/14/22 16:09, Kirill A. Shutemov wrote:
> > On Mon, Feb 07, 2022 at 06:28:04PM +0100, Borislav Petkov wrote:
> > > On Mon, Feb 07, 2022 at 08:57:39AM -0800, Dave Hansen wrote:
> > > > We can surely *do* this with cc_something() helpers.  It's just not as
> > > > easy as making cc_set/cc_clear().
> > > 
> > > Sure, that's easy: cc_pgprot_{enc,dec}() or so.
> > 
> > So, I've ended up with this in <asm/pgtable.h>
> > 
> > /*
> >   * Macros to add or remove encryption attribute
> >   */
> > #ifdef CONFIG_ARCH_HAS_CC_PLATFORM
> > pgprotval_t cc_enc(pgprotval_t protval);
> > pgprotval_t cc_dec(pgprotval_t protval);
> > #define pgprot_encrypted(prot)	__pgprot(cc_enc(pgprot_val(prot)))
> > #define pgprot_decrypted(prot)	__pgprot(cc_dec(pgprot_val(prot)))
> > #else
> > #define pgprot_encrypted(prot) (prot)
> > #define pgprot_decrypted(prot) (prot)
> > #endif
> 
> A couple of things. I think cc_pgprot_enc() and cc_pgprot_dec() would be
> more descriptive/better names to use here.
> 
> Also, can they be defined in include/linux/cc_platform.h (with two versions
> based on CONFIG_ARCH_HAS_CC_PLATFORM) and have that included here? Or is
> there some header file include issues when trying to include it? That would
> clean this block up into just two lines.

Well, pgprotval_t is x86-specific. It cannot be used in generic headers.
We can use u64 here instead. It is wider than pgprotval_t on 2-level
paging x86, but should work.

But with u64 as type, I'm not sure 'pgprot' in the name is jutified.

Hm?

-- 
 Kirill A. Shutemov
