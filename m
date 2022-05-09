Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 520E25209B7
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 01:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232978AbiEIX6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 19:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbiEIX6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 19:58:14 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A7024E02D
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 16:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652140459; x=1683676459;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pXUUdRhqsIiTh3ALucH8Vwv7KqWGVmWUBhMWs1Y+TAg=;
  b=ihM4K6zoQDZqtwI+XHR3zG7AX7VywW3JiovJBIw36TfvAxlfG4wr7X8K
   bGRgwDo/VuNSb77IVnjksTJVF23dpbijSO4kcQCfdbT7KgpJPfrea0Bcl
   bP083sEyLeAHyBLFNckR4iEy3XlhQAOSbH4BQSTFrq3uU0MPeU5eBKJsm
   cv3NUprLZSXNU0axOPvwYPU9v22r+Tj5k1nifwVYNpd2Xt6HbKdT/Urc1
   kk4XThcx20vWu+xhXt2BkEK11+bAC1rsHEH3WXaziPeVcKbG9QY4DFPgp
   4lQTwELhX9HHUIfdsI7H+j163t+WPiuiJywVnsOEyuK6WbAli0wYscm74
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10342"; a="329799883"
X-IronPort-AV: E=Sophos;i="5.91,212,1647327600"; 
   d="scan'208";a="329799883"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2022 16:54:18 -0700
X-IronPort-AV: E=Sophos;i="5.91,212,1647327600"; 
   d="scan'208";a="552118812"
Received: from abehrenx-mobl1.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.254.1.104])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2022 16:54:14 -0700
Message-ID: <75d4755c9a376df2e98a267e10e60da3bd178b17.camel@intel.com>
Subject: Re: [PATCH v5 3/3] x86/tdx: Add Quote generation support
From:   Kai Huang <kai.huang@intel.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
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
Date:   Tue, 10 May 2022 11:54:12 +1200
In-Reply-To: <20220509120927.7rg6v5pyc3f4pxsh@box.shutemov.name>
References: <20220503012721.ok7fbvxmnvsr6qny@box.shutemov.name>
         <58d07b2d-cef5-17ed-9c57-e12fe5665e04@intel.com>
         <40ccd0f0-35a1-5aa7-9e51-25ab196d79e5@linux.intel.com>
         <2ed5c9cc316950a5a47ee714715b7980f358a140.camel@intel.com>
         <ab17102c-0cb7-87d3-3494-969866d64573@linux.intel.com>
         <d53696f85ada39a91a3685c61d177c582810772e.camel@intel.com>
         <d63d2774-c44d-27da-74b6-550935a196fd@intel.com>
         <dca06ffa36abe9989f0a7abaeafc83c1a7250651.camel@intel.com>
         <20220507004236.5p5dyksftge7wwr3@black.fi.intel.com>
         <45d184273f1950320843f6696eb3071f7d354fd3.camel@intel.com>
         <20220509120927.7rg6v5pyc3f4pxsh@box.shutemov.name>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
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

On Mon, 2022-05-09 at 15:09 +0300, Kirill A. Shutemov wrote:
> On Mon, May 09, 2022 at 03:37:22PM +1200, Kai Huang wrote:
> > On Sat, 2022-05-07 at 03:42 +0300, Kirill A. Shutemov wrote:
> > > On Fri, May 06, 2022 at 12:11:03PM +1200, Kai Huang wrote:
> > > > Kirill, what's your opinion?
> > > 
> > > I said before that I think DMA API is the right tool here.
> > > 
> > > Speculation about future of DMA in TDX is irrelevant here. If semantics
> > > change we will need to re-evaluate all users. VirtIO uses DMA API and it
> > > is conceptually the same use-case: communicate with the host.
> > 
> > Virtio is designed for device driver to use, so it's fine to use DMA API. And
> > real DMA can happen to the virtio DMA buffers.  Attestation doesn't have such
> > assumption.
> 
> Whether attestation driver uses struct device is implementation detail.
> I don't see what is you point.

No real DMA is involved in attestation.

> 
> > So I don't see why TD guest kernel cannot have a simple protocol to vmap() a
> > page (or couple of pages) as shared on-demand, like below:
> > 
> > 	page = alloc_page();
> > 
> > 	addr = vmap(page,  pgprot_decrypted(PAGE_KERNEL));
> > 
> > 	clflush_cache_range(page_address(page), PAGE_SIZE);
> > 
> > 	MapGPA(page_to_phys(page) | cc_mkdec(0), PAGE_SIZE);
> > 
> > And we can even avoid above clflush_cache_range() if I understand correctly.
> > 
> > Or  I missed something?
> 
> For completeness, cover free path too. Are you going to opencode page
> accept too?

Call __tdx_module_call(TDX_ACCEPT_PAGE, ...) right after MapGPA() to convert
back to private.  I don't think there is any problem?

> 
> Private->Shared conversion is destructive. You have to split SEPT, flush
> TLB. Backward conversion even more costly.

I think I won't call it destructive.

And I suggested before, we can allocate a default size buffer (i.e. 4 pages),
which is large enough to cover all requests for now, during driver
initialization.  This avoids IOCTL time conversion.  We should still have code
in the IOCTL to check the request buffer size and when it is larger than the
default, the old should be freed a larger one should be allocated.  But for now
this code path will never happen.

Btw above is based on assumption that we don't support concurrent IOCTLs.  This
version Sathya somehow changed to support concurrent IOCTLs but this was a
surprise as I thought we somehow agreed we don't need to support this.

Anyway, now I don't have strong opinion here.  To me alloc_pages() +
set_memory_decrypted() is also fine (seems AMD is using this anyway).   Will let
Dave to decide.

-- 
Thanks,
-Kai
