Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18CFB55E269
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237824AbiF0PNX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 11:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237962AbiF0PM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 11:12:57 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF03811819
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 08:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656342776; x=1687878776;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NbIrdKrUNh3MxRBYH+k9IK39tT7o7aV72Bn2pVO6UI0=;
  b=bK2UcJdtnabwb6b/hw6asJw0xnmbAD4c4+rAFv6eeDQpfaACr52gBeX2
   KIPLK1fJmBy6+Gy0i/2elj6RAYf5M7v4x5zIU6RXaMn+rbZYBksHM6bRP
   KvpGZFosx1XlBaGPtR7fZPavh+OYqHln0Qwjo3b9siPnaZhREjeQtqnNv
   uV2sBJ5JCbTJB95G8OBFgk11ei5JBR3aX8F5/1+MOKoPAZjbAdf9hr7jU
   rgQgonxVhC2WaXVtFohLan+eT0KjbfnwrdyGK5B/wdwlHZhsSah4l0VM0
   5DOVp6zyJV4MRyw+01NcnJNdJjdgvlhBbvCj/LEss8cwvcZ34rCuOD+s9
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10390"; a="282203196"
X-IronPort-AV: E=Sophos;i="5.92,226,1650956400"; 
   d="scan'208";a="282203196"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 08:12:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,226,1650956400"; 
   d="scan'208";a="594338030"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 27 Jun 2022 08:12:51 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 9FDC0D9; Mon, 27 Jun 2022 18:12:57 +0300 (EEST)
Date:   Mon, 27 Jun 2022 18:12:57 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kai Huang <kai.huang@intel.com>,
        Wander Lairson Costa <wander@redhat.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 4/5] x86/mm: Add noalias variants of
 set_memory_*crypted() functions
Message-ID: <20220627151257.fhynhvcnpk22kflw@black.fi.intel.com>
References: <20220609025220.2615197-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20220609025220.2615197-5-sathyanarayanan.kuppuswamy@linux.intel.com>
 <b4190b5d-89e8-b02f-5ef6-c05047af8166@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4190b5d-89e8-b02f-5ef6-c05047af8166@intel.com>
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 24, 2022 at 06:19:23AM -0700, Dave Hansen wrote:
> On 6/8/22 19:52, Kuppuswamy Sathyanarayanan wrote:
> > set_memory_*crypted() functions are used to modify the "shared" page
> > attribute of the given memory. Using these APIs will modify the page
> > attributes of the aliased mappings (which also includes the direct
> > mapping).
> > 
> > But such aliased mappings modification is not desirable in use cases
> > like TDX guest, where the requirement is to create the shared mapping
> > without touching the direct map. It is used when allocating VMM shared
> > buffers using alloc_pages()/vmap()/set_memory_*crypted() API
> > combinations.
> > 
> > So to support such use cases, add support for noalias variants of
> > set_memory_*crypted() functions.
> 
> This changelog has a lot of words, but doesn't tell us much.
> 
> It basically says, we don't want to touch the direct map in use cases
> where we don't want to touch the direct map.  Not helpful.
> 
> The alias processing is there for a reason.  What is it?  Why don't you
> need alias processing for TDX?  Sure, you decided you don't want to
> touch the direct map, but *WHY*?  Why is it normally OK to touch the
> direct map, but not OK in this case?  Even better, why is it *DESIRABLE*
> to leave the direct map alone?  Lastly, why is this safe?  If alias
> processing was to protect us from something, why is losing that
> protection OK here?

The whole idea of alloc_pages()/vmap()/set_memory_decrypted() exercise is
to avoid direct map fragmentation.

Alias processing modifies direct mapping and highmap in addition to the
mapping user requested the modification for. Alias processing is required
to keep different mappings in sync, but here we want to avoid this because
it leads to direct mapping fragmentation.

Normally, direct mapping modifications are done for long-lasting
allocation where fragmentation is lesser concern. Here we have transient
allocation which may repeat over and over trashing the direct mapping.

Speaking of safety, I wanted initially claim that it is safe as only owner
of the allocation will touch the memory and it only does via the vmap
mapping.

*BUT* 

It made me thing about my recent story with load_unaligned_zeropad(). 
If we leave the page in direct mapping mapped as private and
load_unaligned_zeropad() will roll off to it, we will get SEPT violation
that will terminate the TD as it is considered unaccepted.

I think we must keep aliases in think. And vmap() doesn't make much sense
in this case :/

I urge you folks to consider DMA API again. Or have any other way to tap
into swiotlb pool.

-- 
 Kirill A. Shutemov
