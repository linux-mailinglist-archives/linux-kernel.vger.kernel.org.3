Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C5CA51CDA8
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 02:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387442AbiEFAO7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 20:14:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387439AbiEFAOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 20:14:51 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15C4B41FAE
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 17:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651795870; x=1683331870;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RFEl9WyoihfOLeIXmrJDk/Di5IhT3On96S43fPdKlGw=;
  b=OMcHFfyHizp55ahnP64e+JxypKrkGVHeZD8cIl/+pl8yggViVfAWYZWV
   JCNrcO/wn5DZ6IC2XtzLR6MbzWHJ69r3Ng+P06ieVqDNsg6I9DXexbJ5e
   wwFx1YL/r96nuWYyza0dGoK+dspl0ykz7V6VzndYfLcSXSYdk//fPf6Ea
   ifpDXSDrlGs+Jp8iE4iL9ggTOPL/eWYTwGp5RVReiGCGJLiBlIvsFxkpf
   oMq8MH1pGx2ZSCJE6cNObIovP5Oht5YPCLYRaZ2cwzVqGeCBKSoBN+h2e
   4eC+rzYqCvUiqPfafu6By7hSGRTJaLX8U9+G+mw6W2PSBL/IAdsOXDIUS
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="255775419"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="255775419"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 17:11:09 -0700
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="665213920"
Received: from anthienn-mobl1.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.254.4.139])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 17:11:05 -0700
Message-ID: <dca06ffa36abe9989f0a7abaeafc83c1a7250651.camel@intel.com>
Subject: Re: [PATCH v5 3/3] x86/tdx: Add Quote generation support
From:   Kai Huang <kai.huang@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
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
Date:   Fri, 06 May 2022 12:11:03 +1200
In-Reply-To: <d63d2774-c44d-27da-74b6-550935a196fd@intel.com>
References: <20220501183500.2242828-1-sathyanarayanan.kuppuswamy@linux.intel.com>
         <20220501183500.2242828-4-sathyanarayanan.kuppuswamy@linux.intel.com>
         <243e918c523320ba3d216cbe22d24fe5ce33f370.camel@intel.com>
         <20220503012721.ok7fbvxmnvsr6qny@box.shutemov.name>
         <58d07b2d-cef5-17ed-9c57-e12fe5665e04@intel.com>
         <40ccd0f0-35a1-5aa7-9e51-25ab196d79e5@linux.intel.com>
         <2ed5c9cc316950a5a47ee714715b7980f358a140.camel@intel.com>
         <ab17102c-0cb7-87d3-3494-969866d64573@linux.intel.com>
         <d53696f85ada39a91a3685c61d177c582810772e.camel@intel.com>
         <d63d2774-c44d-27da-74b6-550935a196fd@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-05-05 at 16:06 -0700, Dave Hansen wrote:
> On 5/5/22 15:15, Kai Huang wrote:
> > set_memory_xx()  is supposedly only for direct-mapping.  Please use my
> > suggestion above.
> 
> Kai, please take a look at some of the other users, especially
> set_memory_x().  See how long the "supposed" requirement holds up.

Right I should not have used "supposed".  My bad.  I got the impression by
roughly looking at set_memory_{uc|wc..}().  Looks they can only work on direct
mapaping as they internally uses __pa():

int set_memory_wc(unsigned long addr, int numpages)                            
{
        int ret;                                                               

        ret = memtype_reserve(__pa(addr), __pa(addr) + numpages * PAGE_SIZE,   
                _PAGE_CACHE_MODE_WC, NULL);                                    
        if (ret)
                return ret;                                                    

        ret = _set_memory_wc(addr, numpages);                                  
        if (ret)
                memtype_free(__pa(addr), __pa(addr) + numpages * PAGE_SIZE);   

        return ret;                                                            
}

Don't all set_memory_xxx() functions have the same schematic?

> 
> That said, I've forgotten by now if this _could_ have used vmalloc() or
> vmap() or vmap_pfn().  None of the logic about why or how the allocator
> and mapping design decisions were made.  Could that be be rectified for
> the next post?

Looking at set_memory_{encrypted|decrypted}() again, it seems they currently
only works on direct mapping for TDX (as sathya's code has showed).  For AMD it
appears they can work on any virtual address as AMD uses lookup_address() to
find the PFN. 

So if the two are supposed to work on any virtual address, then it makes sense
to fix at TDX side.

Btw, regarding to my suggestion of using vmap() with prot_decrypted() +
MapGPA(), after thinking again, I think there is also a problem -- the TLB for
private mapping and the cache are not flushed.  So looks we should fix
set_memory_decrypted() to work on any virtual address and use it for vmap().

Back to the "why and how the allocator and mapping design decisions were made",
let me summarize options and my preference below:

1) Using DMA API.  This guarantees for TDX1.0 the allocated buffer is shared
(set_memory_decrypted() is called for swiotlb).  But this may not guarantee the
buffer is shared in future generation of TDX.  This of course depends on how we
are going to change those DMA API implementations for future TDX but
conceptually using DMA API is more like for convenience purpose.  Also, in order
to use DMA API, we need more code to handle additional 'platform device' which
is not mandatory for attestation driver.

2) Using vmap() + set_memory_decrypted().  This requires to change the latter to
support any virtual address for TDX.  But now I guess it's the right way since
it's better to have some infrastructure to convert private page to shared
besides DMA API anyway.

3) Using vmap() + MapGPA().  This requires additional work on TLB flush and
cache flush.  Now I think we should not use this.

Given above, I personally think 2) is better.

Kirill, what's your opinion?
