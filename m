Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7144B8CDB
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 16:49:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235717AbiBPPuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 10:50:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235708AbiBPPuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 10:50:08 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 983BA2A797E
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 07:49:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645026596; x=1676562596;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JzUds6X1bUTyxpBXWbKEWASJPbimDwHMfh9ltPG6QzI=;
  b=je7yJJxIfM2qnfsF8WYwnI/UiRUCfrGf3KDcjt/UJEX+6bueQ6md9j+b
   rqXAszi1SZV24TZlubXsM8An6DegH1J/5suNqR1GJXvvwIfJ8y2ZQA8Ki
   5VRkceZpkiTszb2aIarJgWcByrNb1ETud7B+j1mpXp95wQAc+i/NjKiqY
   TSLFqr3zHRkL3VUpzauGn3+r1eD+BYRuhM10gzJnSmcmYOJPHPK2ayhCj
   0o706TQ0o7LtPA/Gvc2daznqkCV7pwJqRH8q2+qwXrFvw8iYIEXTjx7ud
   Zr5ufbDcH9FcTExs4P5DZfBA00xKCFQfdhqsDOdU83U/vPC5T+PsmJ1T1
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10260"; a="249475825"
X-IronPort-AV: E=Sophos;i="5.88,374,1635231600"; 
   d="scan'208";a="249475825"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2022 07:36:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,374,1635231600"; 
   d="scan'208";a="704347320"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 16 Feb 2022 07:36:47 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 6C87037E; Wed, 16 Feb 2022 17:37:03 +0200 (EET)
Date:   Wed, 16 Feb 2022 18:37:03 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>, tglx@linutronix.de,
        mingo@redhat.com, luto@kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 22/29] x86/tdx: Make pages shared in ioremap()
Message-ID: <20220216153703.42wnvgxcvshgpkj2@black.fi.intel.com>
References: <1d77e91c-e151-7846-6cd4-6264236ca5ae@intel.com>
 <YgFWpGQfA84Y0mW/@zn.tnic>
 <20220214220926.fjwlyieatwjhcpij@black.fi.intel.com>
 <f1dfc268-7b2f-9980-27ce-0b5bb1aea962@amd.com>
 <20220215154118.ldpvvk5seljntl44@black.fi.intel.com>
 <dd21e54a-a431-4d6f-47b7-ab1a3e8e0cc8@amd.com>
 <20220215162722.cvzik5r57spr2krz@black.fi.intel.com>
 <52e34ee2-e6a8-5b5c-41f9-5fcf21902a25@intel.com>
 <20220215173321.lwvfl6rxifrkcoit@black.fi.intel.com>
 <YgzKymHnbAUAVSMT@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YgzKymHnbAUAVSMT@zn.tnic>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 16, 2022 at 10:58:34AM +0100, Borislav Petkov wrote:
> On Tue, Feb 15, 2022 at 08:33:21PM +0300, Kirill A. Shutemov wrote:
> > Like cc_mkencrypted()/cc_mkdecrypted()? I donno. Looks strange.
> 
> cc_mkenc/cc_mkdec probably.

Okay, what about this:

	static u64 cc_mask;

	pgprotval_t cc_mkenc(pgprotval_t protval)
	{
		if (cpu_feature_enabled(X86_FEATURE_TDX_GUEST))
			return protval & ~cc_mask;
		else
			return protval | cc_mask;
	}

	pgprotval_t cc_mkdec(pgprotval_t protval)
	{
		if (cpu_feature_enabled(X86_FEATURE_TDX_GUEST))
			return protval | cc_mask;
		else
			return protval & ~cc_mask;
	}
	EXPORT_SYMBOL_GPL(cc_mkdec);

	__init void cc_init(void)
	{
		if (cpu_feature_enabled(X86_FEATURE_TDX_GUEST))
			cc_mask = tdx_shared_mask();
		else
			cc_mask = sme_me_mask;
	}

I did not introduce explicit vendor variable but opted for
X86_FEATURE_TDX_GUEST to check vendor. There's no X86_FEATURE counter part
on AMD side presumably because it get used too early to be functional.

TDX needs cc_platform_has() later and X86_FEATURE infrastructure is
already functional there (and we can benefit from static branch).

cc_init() got called from sme_enable() for AMD and from tdx_early_init()
for TDX.

I also reworked cc_platform_has() to use combination of
X86_FEATURE_TDX_GUEST and cc_mask to route to right helper:

	bool cc_platform_has(enum cc_attr attr)
	{
		if (cpu_feature_enabled(X86_FEATURE_TDX_GUEST))
			return intel_cc_platform_has(attr);
		else if (cc_mask)
			return amd_cc_platform_has(attr);
		else if (hv_is_isolation_supported())
			return hyperv_cc_platform_has(attr);
		else
			return false;
	}

Any opinions?

-- 
 Kirill A. Shutemov
