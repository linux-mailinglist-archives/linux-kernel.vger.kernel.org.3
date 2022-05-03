Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD8ED517BE5
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 04:23:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbiECCWO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 22:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbiECCWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 22:22:10 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9A9D237DF
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 19:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651544319; x=1683080319;
  h=message-id:subject:from:to:cc:in-reply-to:references:
   mime-version:date:content-transfer-encoding;
  bh=lhwIzlQ7BEH7NMAJX5d5Xsx3/7qs/+IAl0iXeiqrC7Y=;
  b=RHXPZBZhBm/CixlVTuv6jWx8YWBmLOh65QH93fZw+Y3SlgNwllC7TJJK
   0sfqBNrdlhAufUe2tqenP4sWjxwKaRqwSEsmHyzsL0/3EXJrSPqKv1wzt
   Ul9bcV/o4MCIMblgOy69WfPwUOAiBGiI31lVMp5L3GxAMLnA1OAkItwiu
   Cg200S5eTcwTXXiEhTd9BiJa+mMTU7/D2nXDYdCot4WVdYT0NYtOlzB6t
   4zaGc3m40QC4R9d4iWrSI0dtkDSGWKaRtB4Rp/gXaWZrTaWGEV87Vp1Jv
   SZ5CLnRKTDGKjfVdteIDIeZzDtH4oCJt6xOYoNTATVLveE7GD6x1apZdB
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10335"; a="266226451"
X-IronPort-AV: E=Sophos;i="5.91,193,1647327600"; 
   d="scan'208";a="266226451"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2022 19:18:39 -0700
X-IronPort-AV: E=Sophos;i="5.91,193,1647327600"; 
   d="scan'208";a="663794614"
Received: from hlyons-mobl.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.254.61.126])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2022 19:18:36 -0700
Message-ID: <4cf22a0799cc13fa6f09ffbf0e5d83ed7eeb32ad.camel@intel.com>
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
In-Reply-To: <20220503012721.ok7fbvxmnvsr6qny@box.shutemov.name>
References: <20220501183500.2242828-1-sathyanarayanan.kuppuswamy@linux.intel.com>
         <20220501183500.2242828-4-sathyanarayanan.kuppuswamy@linux.intel.com>
         <243e918c523320ba3d216cbe22d24fe5ce33f370.camel@intel.com>
         <20220503012721.ok7fbvxmnvsr6qny@box.shutemov.name>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Date:   Tue, 03 May 2022 14:18:10 +1200
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-05-03 at 04:27 +0300, Kirill A. Shutemov wrote:
> On Mon, May 02, 2022 at 02:40:26PM +1200, Kai Huang wrote:
> > 
> > > +
> > > +	/* Get order for Quote buffer page allocation */
> > > +	order = get_order(quote_req.len);
> > > +
> > > +	/*
> > > +	 * Allocate buffer to get TD Quote from the VMM.
> > > +	 * Size needs to be 4KB aligned (which is already
> > > +	 * met in page allocation).
> > > +	 */
> > > +	tdquote = (void *)__get_free_pages(GFP_KERNEL | __GFP_ZERO, order);
> > > +	if (!tdquote) {
> > > +		ret = -ENOMEM;
> > > +		goto quote_failed;
> > > +	}
> > 
> > You can use alloc_pages_exact().
> > 
> > > +
> > > +	/*
> > > +	 * Since this buffer will be shared with the VMM via GetQuote
> > > +	 * hypercall, decrypt it.
> > > +	 */
> > > +	ret = set_memory_decrypted((unsigned long)tdquote, 1UL << order);
> > > +	if (ret)
> > > +		goto quote_failed;
> > 
> > 
> > Again, Dave and Andi already commented you should use vmap() to avoid breaking
> > up the direct-mapping.  Please use vmap() instead.
> > 
> > https://lore.kernel.org/all/ce0feeec-a949-35f8-3010-b0d69acbbc2e@linux.intel.com/
> > 
> > Will review the rest later.
> 
> I would rather convert it to use DMA API for memory allocation. It will
> tap into swiotlb buffer that already converted and there's no need to
> touch direct mapping. Both allocation and freeing such memory is cheaper
> because of that.
> 

Does each DMA allocation and free internally do the actual private/shared
conversion?  Or the swiotlb is converted at the beginning at boot and DMA
allocation will always get the shared buffer automatically?

The problem of using DMA API is it will need to bring additional code to use
platform device, which isn't necessary.

Using vmap() we can still (almost) avoid private/shared conversion at IOCTL time
by allocating a default size buffer (which is large enough to cover 99% cases,
etc) at driver initialization time:

https://lore.kernel.org/lkml/20220422233418.1203092-2-sathyanarayanan.kuppuswamy@linux.intel.com/T/#maf7e5f6894548972c5de71f607199a79645856ff


-- 
Thanks,
-Kai


