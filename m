Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8BB4480DEC
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 00:33:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237808AbhL1XdL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 18:33:11 -0500
Received: from mga09.intel.com ([134.134.136.24]:52856 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237755AbhL1XdJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 18:33:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640734389; x=1672270389;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OX1MfWUCyvp8hlID5Q02hlE3ZZ5gH1Co7jqlUZRyjmY=;
  b=KGB+uuQxwdkfq1ktykDWhMsmUxZ8LauEBPvnjLuGblTAGLh0C/5ozJxB
   8K4cuLp/mSrENFPKFzoV6RiohCbP401rJ3mBaVJz16NAPM5TdrKcKufqg
   5blU45GcyumTnclNMnn+5ytNwyHoYvKgJQhaS1reJk8JFIwN4/tohCWuf
   ViJsek8EWOakJpMe+8lRjxHkfGFL6KhQt2QR9dlps7IkDNY8tEeJfg6cq
   /zmXcY1G/fmUi49R76s5bE8hR3glouKIhwzEMtvWF0IVxM6YRcULCpEGE
   azqGL3dMKejKELO1ctIYO1PRHwYqTYuUeVimgUFEr3lCyXUEhOUWOWen+
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10211"; a="241237176"
X-IronPort-AV: E=Sophos;i="5.88,243,1635231600"; 
   d="scan'208";a="241237176"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2021 15:33:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,243,1635231600"; 
   d="scan'208";a="470152689"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 28 Dec 2021 15:33:02 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id B3830120; Wed, 29 Dec 2021 01:33:11 +0200 (EET)
Date:   Wed, 29 Dec 2021 02:33:11 +0300
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
Message-ID: <20211228233311.47g673t3pqjyyxys@black.fi.intel.com>
References: <87c288d6-9bf8-5a94-a628-1e0aaa7de690@amd.com>
 <20211223171530.v73posbqizb5l3md@black.fi.intel.com>
 <f61b591b-a06c-bc29-4b9b-a5d46111fe4e@intel.com>
 <YcTTt4LXKfDO+9u3@zn.tnic>
 <20211223205604.g44kez5d7iedatfo@box.shutemov.name>
 <YcTlhp1PUfrMOelI@zn.tnic>
 <20211224110300.7zj3nc5nbbv7jobp@black.fi.intel.com>
 <YcmoucfxOF8mwox8@zn.tnic>
 <20211227141436.ahvdngnae6xnf4nl@black.fi.intel.com>
 <YctZ8gCoaLgFCClP@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YctZ8gCoaLgFCClP@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 28, 2021 at 07:39:46PM +0100, Borislav Petkov wrote:
> But my point about removing the outer check is bull - you need the
> TDX/SEV checks too to figure out which mask to use.
> 
> So, reading Tom's latest email, having
> 
> 	cc_pgprot_encrypted(prot)
> 
> and
> 	cc_pgprot_decrypted(prot)
> 
> in cc_platform.c and which hide all that logic inside doesn't sound like
> a bad idea. And cc_platform.c already looks at sme_me_mask and we do
> that there for the early path so I guess that's probably halfway fine...

Okay, will go this path.

-- 
 Kirill A. Shutemov
