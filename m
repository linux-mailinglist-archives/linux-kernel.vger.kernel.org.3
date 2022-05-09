Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA6F051F308
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 05:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232087AbiEIDt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 23:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233289AbiEIDlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 23:41:22 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 833B766CA4
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 20:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652067449; x=1683603449;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=A8hPcJAwAOv3y9+r5NnNKJG55OgN9t9//di8+1ioCcA=;
  b=U+CXyp+VLIjXIJ1K9OJlq4vF8IayJvTMY/KcCtOHaHwyKSzZQ0d2fS7B
   8ZpWjhOkMr8iAouWYPG8QFT6U9rKopXK6z9iiUnzLBFA+luwWfcVFKMgu
   IJ9b8XYASle/xVF+Ep/Vhiz9lCdIyOsfCwjIxs/WT7QnoNfYCINjpRv6m
   IFONg35kQQwctEyaxOu4Lyl11WCRJnKvHu8wXRClrpTKWpMW9IinSCm2h
   N80g3RFabtt6EgD9Agdzq9tUQfvu0cOay8aCb2EBilvcXlT9ZA18O396a
   Hx0MSdHQe7B7pF4AmBC5DvAY0d877+Q3xOZrjctopDTjbTreHGE3dPpZy
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10341"; a="268585320"
X-IronPort-AV: E=Sophos;i="5.91,210,1647327600"; 
   d="scan'208";a="268585320"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2022 20:37:29 -0700
X-IronPort-AV: E=Sophos;i="5.91,210,1647327600"; 
   d="scan'208";a="550815845"
Received: from cbfoste1-mobl.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.254.62.77])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2022 20:37:24 -0700
Message-ID: <45d184273f1950320843f6696eb3071f7d354fd3.camel@intel.com>
Subject: Re: [PATCH v5 3/3] x86/tdx: Add Quote generation support
From:   Kai Huang <kai.huang@intel.com>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Wander Lairson Costa <wander@redhat.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        linux-kernel@vger.kernel.org
Date:   Mon, 09 May 2022 15:37:22 +1200
In-Reply-To: <20220507004236.5p5dyksftge7wwr3@black.fi.intel.com>
References: <20220501183500.2242828-4-sathyanarayanan.kuppuswamy@linux.intel.com>
         <243e918c523320ba3d216cbe22d24fe5ce33f370.camel@intel.com>
         <20220503012721.ok7fbvxmnvsr6qny@box.shutemov.name>
         <58d07b2d-cef5-17ed-9c57-e12fe5665e04@intel.com>
         <40ccd0f0-35a1-5aa7-9e51-25ab196d79e5@linux.intel.com>
         <2ed5c9cc316950a5a47ee714715b7980f358a140.camel@intel.com>
         <ab17102c-0cb7-87d3-3494-969866d64573@linux.intel.com>
         <d53696f85ada39a91a3685c61d177c582810772e.camel@intel.com>
         <d63d2774-c44d-27da-74b6-550935a196fd@intel.com>
         <dca06ffa36abe9989f0a7abaeafc83c1a7250651.camel@intel.com>
         <20220507004236.5p5dyksftge7wwr3@black.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2022-05-07 at 03:42 +0300, Kirill A. Shutemov wrote:
> On Fri, May 06, 2022 at 12:11:03PM +1200, Kai Huang wrote:
> > Kirill, what's your opinion?
> 
> I said before that I think DMA API is the right tool here.
> 
> Speculation about future of DMA in TDX is irrelevant here. If semantics
> change we will need to re-evaluate all users. VirtIO uses DMA API and it
> is conceptually the same use-case: communicate with the host.

Virtio is designed for device driver to use, so it's fine to use DMA API. And
real DMA can happen to the virtio DMA buffers.  Attestation doesn't have such
assumption.

DMA API has it's limitations.  I don't see the protocol to convert GPA from
private to shared is so complicated (see below), and I think regardless this
attestation use case, it's perhaps worth to provide an additional simple
infrastructure for such case so it can be used when needed.

> 
> But vmap() + set_memory_decrypted() also works and Sathya already has code
> for it. I'm fine with this.

Dave said (again) he wanted to avoid breaking up direct mapping.

https://lore.kernel.org/lkml/5d34ac93-09dc-ea93-bffe-f3995647cd5b@linux.intel.com/T/#m37778b8af5d72c3db79e3cfa4b46ee37836f771c

So we need to use seither use DMA API (which already breaks direct-mapping for
swiotlb), or we use vmap() + MapGPA() as I mentioned below.

> 
> Going a step below to manual MapGPA() is just wrong. We introduced
> abstructions for a reason. Protocol of changing GPA status is not trivial.
> We should not spread it across all kernel codebase.
> 

I kinda disagree with this.  In fact, the protocol of changing GPA status isn't
that complicated.  TD guest can have both private and shared mappings to the
same GPA simultaneously.  We don't need to change all the mappings when
converting private page to shared.

For instance, we can use vmap() to have a shared mapping to a page, while the
page is still mapped as private in direct-mapping.  TD uses MapGPA() to tell VMM
which mapping it wants to use, and it just needs to guarantee that the private
(direct) mapping won't be used.  Speculative fetch using the direct mapping is
fine, as long as the core won't consume the data.  The only thing we need to
guarantee is we need to flush any dirty cachelines before MapGPA(). My
understanding is we don't even need to flush the TLB of the private mapping.

And reading the GHCI MapGPA() again, to me MapGPA() itself requires VMM to
guarantee the TLB and cache flush:

"
If the GPA (range) was already mapped as an active, private page, the host VMM
may remove the private page from the TD by following the “Removing TD Private
Pages” sequence in the Intel TDX-module specification [3] to safely block the
mapping(s), flush the TLB and cache, and remove the mapping(s). The VMM is
designed to be able to then map the specified GPA (range) in the shared-EPT
structure and allow the TD to access the page(s) as a shared GPA (range).
"

You can see the cache flush is guaranteed by VMM.

Btw, the use of word "may" in "host VMM may remove..." in above paragraph is
horrible.  It should use "must", just like to the "converting shared to private"
case:

"
If the Start GPA specified is a private GPA (GPA.S bit is clear), this MapGPA
TDG.VP.VMCALL can be used to help request the host VMM map the specific, private
page(s) (which mapping may involve converting the backing-physical page from a
shared page to a private page). As intended in this case, the VMM must unmap the
GPA from the shared-EPT region and invalidate the TLB and caches for the TD
vcpus to help ensure no stale mappings and cache contents exist.
"

As you can see "must" is used in "the VMM must unmap the GPA from the shared-EPT
...".

So I don't see why TD guest kernel cannot have a simple protocol to vmap() a
page (or couple of pages) as shared on-demand, like below:

	page = alloc_page();

	addr = vmap(page,  pgprot_decrypted(PAGE_KERNEL));

	clflush_cache_range(page_address(page), PAGE_SIZE);

	MapGPA(page_to_phys(page) | cc_mkdec(0), PAGE_SIZE);

And we can even avoid above clflush_cache_range() if I understand correctly.

Or  I missed something?


-- 
Thanks,
-Kai


