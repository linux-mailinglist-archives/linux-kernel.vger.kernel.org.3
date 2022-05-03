Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D3C9517C45
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 05:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbiECDj5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 23:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbiECDjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 23:39:52 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E2943C48E
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 20:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651548981; x=1683084981;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=j8SNqMY1RzS9DfIOPNpkRCABqY6lQpCdtjpUShAG0AI=;
  b=Ed4zL0N6Oc3pHhxPf1BNRgPtE6sZ/ZkWBUTrpT9ty0bdl3SgcT9kEobq
   J6ZkyydZEztRg5MCJhQ7jpSQVi76KAQuMwwTie4KNVgTwR8rflhqcBvy0
   112PHyS10eSnAgczZiFh/XDCwe8bvrPgi5VjujWwoEr3WnMs2+3sfICPm
   Gvqctu7MmcPrl2JdaDjPGepuITPvexZUDrv1k/lMWuVQbXndd9UQHAdNq
   h4si6luRdMlwtisn+9tPV+WHZtMpVaZOuUSIcERLUtKaXCw5ykR48QM7y
   j2oUcZsL1gApFzrVc5dkV94HDxNaMBC5ggtxRA2VA7QAVvy2uOuWSRKNx
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10335"; a="264980341"
X-IronPort-AV: E=Sophos;i="5.91,194,1647327600"; 
   d="scan'208";a="264980341"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2022 20:36:21 -0700
X-IronPort-AV: E=Sophos;i="5.91,194,1647327600"; 
   d="scan'208";a="707873600"
Received: from hlyons-mobl.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.254.61.126])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2022 20:36:17 -0700
Message-ID: <0ab679ea506b3955bd2787aa8dcb000dd718f76b.camel@intel.com>
Subject: Re: [PATCH v5 3/3] x86/tdx: Add Quote generation support
From:   Kai Huang <kai.huang@intel.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Wander Lairson Costa <wander@redhat.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        linux-kernel@vger.kernel.org
Date:   Tue, 03 May 2022 15:36:15 +1200
In-Reply-To: <20220503024508.qjh4nfygfstb3ls3@box.shutemov.name>
References: <20220501183500.2242828-1-sathyanarayanan.kuppuswamy@linux.intel.com>
         <20220501183500.2242828-4-sathyanarayanan.kuppuswamy@linux.intel.com>
         <243e918c523320ba3d216cbe22d24fe5ce33f370.camel@intel.com>
         <20220503012721.ok7fbvxmnvsr6qny@box.shutemov.name>
         <4cf22a0799cc13fa6f09ffbf0e5d83ed7eeb32ad.camel@intel.com>
         <20220503024508.qjh4nfygfstb3ls3@box.shutemov.name>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-05-03 at 05:45 +0300, Kirill A. Shutemov wrote:
> On Tue, May 03, 2022 at 02:18:10PM +1200, Kai Huang wrote:
> > On Tue, 2022-05-03 at 04:27 +0300, Kirill A. Shutemov wrote:
> > > On Mon, May 02, 2022 at 02:40:26PM +1200, Kai Huang wrote:
> > > > 
> > > > > +
> > > > > +	/* Get order for Quote buffer page allocation */
> > > > > +	order = get_order(quote_req.len);
> > > > > +
> > > > > +	/*
> > > > > +	 * Allocate buffer to get TD Quote from the VMM.
> > > > > +	 * Size needs to be 4KB aligned (which is already
> > > > > +	 * met in page allocation).
> > > > > +	 */
> > > > > +	tdquote = (void *)__get_free_pages(GFP_KERNEL | __GFP_ZERO, order);
> > > > > +	if (!tdquote) {
> > > > > +		ret = -ENOMEM;
> > > > > +		goto quote_failed;
> > > > > +	}
> > > > 
> > > > You can use alloc_pages_exact().
> > > > 
> > > > > +
> > > > > +	/*
> > > > > +	 * Since this buffer will be shared with the VMM via GetQuote
> > > > > +	 * hypercall, decrypt it.
> > > > > +	 */
> > > > > +	ret = set_memory_decrypted((unsigned long)tdquote, 1UL << order);
> > > > > +	if (ret)
> > > > > +		goto quote_failed;
> > > > 
> > > > 
> > > > Again, Dave and Andi already commented you should use vmap() to avoid breaking
> > > > up the direct-mapping.  Please use vmap() instead.
> > > > 
> > > > https://lore.kernel.org/all/ce0feeec-a949-35f8-3010-b0d69acbbc2e@linux.intel.com/
> > > > 
> > > > Will review the rest later.
> > > 
> > > I would rather convert it to use DMA API for memory allocation. It will
> > > tap into swiotlb buffer that already converted and there's no need to
> > > touch direct mapping. Both allocation and freeing such memory is cheaper
> > > because of that.
> > > 
> > 
> > Does each DMA allocation and free internally do the actual private/shared
> > conversion?  Or the swiotlb is converted at the beginning at boot and DMA
> > allocation will always get the shared buffer automatically?
> 
> It can remap as fallback, but usually it allocates from the pool.
> 
> > The problem of using DMA API is it will need to bring additional code to use
> > platform device, which isn't necessary.
> 
> Heh? DMA is in the kernel anyway. Or do you mean some cost from the header
> for the compilation unit? That's strange argument. Kernel provides
> infrastructure for a reason.

I mean using platform device is more complicated than using misc_register()
directly.  You can compare the code between v4 and v5.

> 
> > Using vmap() we can still (almost) avoid private/shared conversion at IOCTL time
> > by allocating a default size buffer (which is large enough to cover 99% cases,
> > etc) at driver initialization time:
> > 
> > https://lore.kernel.org/lkml/20220422233418.1203092-2-sathyanarayanan.kuppuswamy@linux.intel.com/T/#maf7e5f6894548972c5de71f607199a79645856ff
> 
> I don't see a reason to invent ad-hoc solution if there's an establised
> API for the task.
> 

DMA API can fit this job doesn't mean it fits better.  And I don't see why using
vmap() as I described above is a ad-hoc.

1) There's no real DMA involved in attestation.  Using DMA API is overkill.
2) DMA buffers are always shared, but this is only true for now.  It's not
guaranteed to be true for future generation of TDX.

It's just a little bit weird to use DMA API when there's no real device and no
real DMA is involved.  It's much more like using DMA API for convenience
purpose. 


-- 
Thanks,
-Kai


