Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B215E4B5D70
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 23:12:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231730AbiBNWJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 17:09:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231719AbiBNWJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 17:09:26 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9D2313C395
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 14:09:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644876557; x=1676412557;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MN0LuCClIf12LDl41vx5eilbtSgL9wlzY9x+3q5BCBs=;
  b=EtAaLvNpPPRqKtCAEAHuxJgR9s1LR/QdJXfTdqDqJOVPVPSjL3RpDGgS
   BLtECiS4Uo0ggLD13tQ3LPp1a5nCh4zYqs0d5tTQdkaruw9SP3TEB6REI
   dLZlI6oqtEAtoR9cY2ZEzlyLmlZHNPjJhC8WdbCjOJI0kUtFGtzFA6dW4
   dziEpPx1IR1SqRwpOuSNSEKe5Gdj97uJxV/g0QX+0ejzTWA5oRhG1FyDR
   jDPHJrLXA1tgUSKX22716gsorAChqtpt4RMOARIlvUkvzevy219l+VAev
   Z3zi/nTXRxnU5INxTmA2Dd+bcR8dc+XVN6Ox1vd/G7e7PLxG7NfFld3aM
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10258"; a="237604182"
X-IronPort-AV: E=Sophos;i="5.88,368,1635231600"; 
   d="scan'208";a="237604182"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 14:09:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,368,1635231600"; 
   d="scan'208";a="635461870"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 14 Feb 2022 14:09:11 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id EC53E107; Tue, 15 Feb 2022 00:09:26 +0200 (EET)
Date:   Tue, 15 Feb 2022 01:09:26 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Dave Hansen <dave.hansen@intel.com>, tglx@linutronix.de,
        mingo@redhat.com, luto@kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 22/29] x86/tdx: Make pages shared in ioremap()
Message-ID: <20220214220926.fjwlyieatwjhcpij@black.fi.intel.com>
References: <20220124150215.36893-1-kirill.shutemov@linux.intel.com>
 <20220124150215.36893-23-kirill.shutemov@linux.intel.com>
 <YgFIaJ8ijgQQ04Nv@zn.tnic>
 <1d77e91c-e151-7846-6cd4-6264236ca5ae@intel.com>
 <YgFWpGQfA84Y0mW/@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YgFWpGQfA84Y0mW/@zn.tnic>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 07, 2022 at 06:28:04PM +0100, Borislav Petkov wrote:
> On Mon, Feb 07, 2022 at 08:57:39AM -0800, Dave Hansen wrote:
> > We can surely *do* this with cc_something() helpers.  It's just not as
> > easy as making cc_set/cc_clear().
> 
> Sure, that's easy: cc_pgprot_{enc,dec}() or so.

So, I've ended up with this in <asm/pgtable.h>

/*
 * Macros to add or remove encryption attribute
 */
#ifdef CONFIG_ARCH_HAS_CC_PLATFORM
pgprotval_t cc_enc(pgprotval_t protval);
pgprotval_t cc_dec(pgprotval_t protval);
#define pgprot_encrypted(prot)	__pgprot(cc_enc(pgprot_val(prot)))
#define pgprot_decrypted(prot)	__pgprot(cc_dec(pgprot_val(prot)))
#else
#define pgprot_encrypted(prot) (prot)
#define pgprot_decrypted(prot) (prot)
#endif

And cc_platform.c:

pgprotval_t cc_enc(pgprotval_t protval)
{
	if (sme_me_mask)
		return __sme_set(protval);
	else if (cpu_feature_enabled(X86_FEATURE_TDX_GUEST))
		return protval & ~tdx_shared_mask();
	else
		return protval;
}

pgprotval_t cc_dec(pgprotval_t protval)
{
	if (sme_me_mask)
		return __sme_clr(protval);
	else if (cpu_feature_enabled(X86_FEATURE_TDX_GUEST))
		return protval | tdx_shared_mask();
	else
		return protval;
}
EXPORT_SYMBOL_GPL(cc_dec);
-- 
 Kirill A. Shutemov
