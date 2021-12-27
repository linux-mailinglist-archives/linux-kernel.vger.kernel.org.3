Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 899AF47FDC5
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 15:14:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237071AbhL0OOf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 09:14:35 -0500
Received: from mga04.intel.com ([192.55.52.120]:17558 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237033AbhL0OOe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 09:14:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640614474; x=1672150474;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UgtgtdOIHCJjUaMoRNmSWb45sxZer46M2+GINuGkZwo=;
  b=hrWmwn4SfSveDJOs/1AB5IFRNfXMoNdeTkkQPEbTM67JMKP3brnz506n
   j5Sjt0IV7cLzebj5i3LPG5c1yjZm5kvlxf52/cQiogC4qqtvBKnFBPvsb
   wum1FbUZWDCWo7UPNCyNwmpz0mf+knXt09CxG1Q2QooajL4E1clH1nHfe
   uZYPBg4PlvAiXEmFd8LSGNxjtzkq87gm3rbdzbYdDtKOgxXdzQW1kKTCW
   xoDXs80Jd+5CNEOmMwpgqJ1AkmTBCtnaRqfnH63kNPkn32AwbuTcYz2fD
   CIqZMQO6tjpj82F+h52ZhYNU/+yW5NePKOieQx88Xze/w/9lg4GVGO1kI
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10209"; a="239995844"
X-IronPort-AV: E=Sophos;i="5.88,239,1635231600"; 
   d="scan'208";a="239995844"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2021 06:14:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,239,1635231600"; 
   d="scan'208";a="553806748"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 27 Dec 2021 06:14:28 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 2E41E12C; Mon, 27 Dec 2021 16:14:36 +0200 (EET)
Date:   Mon, 27 Dec 2021 17:14:36 +0300
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
Message-ID: <20211227141436.ahvdngnae6xnf4nl@black.fi.intel.com>
References: <20211214150304.62613-1-kirill.shutemov@linux.intel.com>
 <20211214150304.62613-20-kirill.shutemov@linux.intel.com>
 <87c288d6-9bf8-5a94-a628-1e0aaa7de690@amd.com>
 <20211223171530.v73posbqizb5l3md@black.fi.intel.com>
 <f61b591b-a06c-bc29-4b9b-a5d46111fe4e@intel.com>
 <YcTTt4LXKfDO+9u3@zn.tnic>
 <20211223205604.g44kez5d7iedatfo@box.shutemov.name>
 <YcTlhp1PUfrMOelI@zn.tnic>
 <20211224110300.7zj3nc5nbbv7jobp@black.fi.intel.com>
 <YcmoucfxOF8mwox8@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YcmoucfxOF8mwox8@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 27, 2021 at 12:51:21PM +0100, Borislav Petkov wrote:
> On Fri, Dec 24, 2021 at 02:03:00PM +0300, Kirill A. Shutemov wrote:
> > Okay. Meanwhile I leave it this way:
> > 
> > 	pgprot_t pgprot_cc_encrypted(pgprot_t prot)
> > 	{
> > 		if (cc_platform_has(CC_ATTR_MEM_ENCRYPT)) {
> > 			if (cc_platform_has(CC_ATTR_GUEST_TDX))
> > 				return __pgprot(pgprot_val(prot) & ~tdx_shared_mask());
> > 			else if (sme_me_mask)
> > 				return __pgprot(__sme_set(pgprot_val(prot)));
> > 			else
> > 				WARN_ON_ONCE(1);
> 
> I'm wondering if defining a generic cc_attr especially for this:
> 
> 	if (cc_platform_has(CC_ATTR_MEMORY_SHARING))
> 
> to mean, the CC guest needs to do special stuff in order to share memory
> with the host (naming sucks, ofc) would be cleaner?

Looks like CC_ATTR_MEM_ENCRYPT already does this. The attribute doesn't
have much meaning beyond that, no?

-- 
 Kirill A. Shutemov
