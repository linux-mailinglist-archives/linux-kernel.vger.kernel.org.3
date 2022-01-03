Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 627C44831B9
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 15:17:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233263AbiACORC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 09:17:02 -0500
Received: from mga07.intel.com ([134.134.136.100]:55071 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229831AbiACORB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 09:17:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641219421; x=1672755421;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GjYXt/ODx7J7/7NS8za6Xq0tVsMrMeyI68UwaJUOMto=;
  b=TrUKo4Oze3s86a6DXvZcKP072TsfQ/wUyIbi/ky7tcUbkUYU0qPvlgY7
   PrODlRH3dtpgKwxCrvbL74imD3SsY7tFNPQitW8q8jIxrOkStVOQJG+5T
   NWfzMCIfddRfcoAy5ubZEHefoSU/zSfQTx8nGekXNTpQ3X0WHn9fr8tPJ
   MIyvBzu02+RR7xE8WSeQQ75ueF1kt7lpuON7aC6Usn8wnQa+k++Zxv7F3
   OwaWA7ksJgp1lNqw1011xi9b2ec3BEIXoy6gVMnA4W7wws9vIWRDz3A+u
   ZwuSHLHoSsipmyZlD2lL3rT4IE33u0gM+POpUzHi13O39hNL8bNAUgDqN
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10215"; a="305422026"
X-IronPort-AV: E=Sophos;i="5.88,258,1635231600"; 
   d="scan'208";a="305422026"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2022 06:17:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,258,1635231600"; 
   d="scan'208";a="617226065"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 03 Jan 2022 06:16:54 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 27378283; Mon,  3 Jan 2022 16:17:05 +0200 (EET)
Date:   Mon, 3 Jan 2022 17:17:05 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Dave Hansen <dave.hansen@intel.com>, tglx@linutronix.de,
        mingo@redhat.com, luto@kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 19/26] x86/tdx: Make pages shared in ioremap()
Message-ID: <20220103141705.6hqflhwykqmtfim6@black.fi.intel.com>
References: <20211214150304.62613-1-kirill.shutemov@linux.intel.com>
 <20211214150304.62613-20-kirill.shutemov@linux.intel.com>
 <87c288d6-9bf8-5a94-a628-1e0aaa7de690@amd.com>
 <20211223171530.v73posbqizb5l3md@black.fi.intel.com>
 <f61b591b-a06c-bc29-4b9b-a5d46111fe4e@intel.com>
 <YcTTt4LXKfDO+9u3@zn.tnic>
 <20211223205604.g44kez5d7iedatfo@box.shutemov.name>
 <YcTlhp1PUfrMOelI@zn.tnic>
 <20211224110300.7zj3nc5nbbv7jobp@black.fi.intel.com>
 <33914dc1-37e8-f0bb-6468-71c3b5f4169d@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33914dc1-37e8-f0bb-6468-71c3b5f4169d@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 27, 2021 at 09:07:10AM -0600, Tom Lendacky wrote:
> Why can't this follow the cc_platform_has() logic and maybe even live in
> the cc_platform.c file (though there might be issues with that, I haven't
> really looked)?

There's issue with declaring cc_pgprot_encrypted()/cc_pgprot_decrypted()
in cc_platform.h. It requires pgprot_t to be defined and attempt to
include relevant header leads to circular dependencies.

Moreover, pgprot_t defined in different headers, depending on an
architecture.

I'm not sure how to unwind this dependency hell. Any clues?

-- 
 Kirill A. Shutemov
