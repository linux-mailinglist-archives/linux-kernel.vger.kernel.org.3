Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8482754CF6B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 19:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348390AbiFORKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 13:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbiFORKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 13:10:43 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D806533A33
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 10:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655313042; x=1686849042;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=M06CL0NiYygtoYrGmEwC5NcF30mFpzKbxgEsg1xGaiw=;
  b=jR3AvSbgISNTou1KvVCETE/5YdXdxB/0Fv4f34m0HKLXGpWVT46VNoGQ
   HkXViRka+v0cT0qPffYsNdIN8DLsqPs2gAy6R+2qNkMjnnKbdH8lYVMwH
   AIxj3EXigT5wgMEW+aqIRO021TsoFoIhgRFC+4HHWAV3a8ReHrdUFfu2q
   DIEnRaDduViu4TdBJQ/BqyqFCxsyuGJU0L+OSsy6+fMJSsK1xXV7lzGqP
   BzNu1HlQ5tBtfjJSudPlrTfFBXqn+RGX97sKoKXT02md2dtipHR5zXja0
   sg5CeOWt9pK8CJzb9lYQa48+7c2IOsbUUqjfKDFTkELeaIGSM3eucL0x/
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10379"; a="365390601"
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; 
   d="scan'208";a="365390601"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2022 10:10:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; 
   d="scan'208";a="559240820"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 15 Jun 2022 10:10:38 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 65C02109; Wed, 15 Jun 2022 20:10:42 +0300 (EEST)
Date:   Wed, 15 Jun 2022 20:10:42 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        luto@kernel.org, peterz@infradead.org, ak@linux.intel.com,
        dan.j.williams@intel.com, david@redhat.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, seanjc@google.com,
        thomas.lendacky@amd.com, x86@kernel.org
Subject: Re: [PATCHv4 3/3] x86/tdx: Handle load_unaligned_zeropad()
 page-cross to a shared page
Message-ID: <20220615171042.oeumb3vs3ttu4rvd@black.fi.intel.com>
References: <20220614120135.14812-1-kirill.shutemov@linux.intel.com>
 <20220614120135.14812-4-kirill.shutemov@linux.intel.com>
 <051fd468-11e6-308b-66c8-4de16ff80deb@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <051fd468-11e6-308b-66c8-4de16ff80deb@intel.com>
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 15, 2022 at 08:27:52AM -0700, Dave Hansen wrote:
> On 6/14/22 05:01, Kirill A. Shutemov wrote:
> > load_unaligned_zeropad() can lead to unwanted loads across page boundaries.
> > The unwanted loads are typically harmless. But, they might be made to
> > totally unrelated or even unmapped memory. load_unaligned_zeropad()
> > relies on exception fixup (#PF, #GP and now #VE) to recover from these
> > unwanted loads.
> > 
> > In TDX guests, the second page can be shared page and VMM may configure
> > it to trigger #VE.
> > 
> > Kernel assumes that #VE on a shared page is MMIO access and tries to
> > decode instruction to handle it. In case of load_unaligned_zeropad() it
> > may result in confusion as it is not MMIO access.
> > 
> > Fix it by detecting split page MMIO accesses and fail them.
> > load_unaligned_zeropad() will recover using exception fixups.
> > 
> > The issue was discovered by analysis. It was not triggered during the
> > testing.
> 
> I thought this whole exercise was kicked off by hitting this in testing.
>  Am I remembering this wrong?
> 
> > https://lore.kernel.org/all/20220517153444.11195-10-kirill.shutemov@linux.intel.com/
> 
> Says:
> 
> > This is an actual, real-world problem which was discovered during TDX
> > testing.
> 
> Or were you considering this a different problem somehow?

They are different.

The patch by the link addresses issue of load_unaligned_zeropad() stepping
onto unaccepted memory. This was triggered in practice.

This patch address stepping onto MMIO shared memory. I had to force the
situation manually as MMIO memory mapped with ioremap() and it is not next
to normally allocated memory used by load_unaligned_zeropad() (such as
dentry cache).

Although any shared memory (SWIOTLB buffer for instance) can generate EPT
violation #VE if the VMM is malicious enough.

-- 
 Kirill A. Shutemov
