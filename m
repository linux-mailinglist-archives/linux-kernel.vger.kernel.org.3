Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C23B651D61A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 13:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391120AbiEFLEW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 07:04:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391101AbiEFLEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 07:04:20 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CF55237EE
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 04:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651834836; x=1683370836;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ot650wBvADBiyGWniBkj5JCKLPqmissAdNNsxn0wrgI=;
  b=inkDt/+Zj2sVkfJLdcL0wIC/SaIx8TRFhaA8QdoA8YapiYECbztxrl7O
   cYS6dWCWLtIsN0YAHbIwVEdjAtAxPpom4pvOUSn9ui5scR9Ko3I7yVa6F
   6Bwo0FCN4o8DTKZafkQ0fxyxJdeitAMOjfUzvmLj10RMQLXoNedaMHz1B
   Dvr0FGuvg+0w3c2CFkfdkI+u4dkcUWKRoiigum/QaHQweP92SlyCnRcjB
   dJ4XHB/FuBCNurLbpilLCEsLH2Mt8eFtEVr7OmDdPlgfpUDJiBnYKsNNK
   V7xorZH9YcH7fyyVoXv7n1WK5ejp/VJR3w2Q9jdZhEpLAFJzBirYHC4TL
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="268040861"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="268040861"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2022 04:00:36 -0700
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="549814353"
Received: from selvaraj-mobl1.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.254.3.239])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2022 04:00:31 -0700
Message-ID: <c3003e378504d2cd034e54bca6cab4d6bb53e008.camel@intel.com>
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
Date:   Fri, 06 May 2022 23:00:29 +1200
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
> 
> That said, I've forgotten by now if this _could_ have used vmalloc() or
> vmap() or vmap_pfn().  None of the logic about why or how the allocator
> and mapping design decisions were made.  Could that be be rectified for
> the next post?

Hi Dave,

(Sorry previous reply was too fast..)

I spent some time looking into how __change_page_attr_set_clr() is implemented,
which is called by all set_memory_xxx() variants.  If my understanding is
correct, __change_page_attr_set_clr() will work for vmap() variants, because it
internally uses lookup_address(), which walks the page table directly, to find
the actual PTE (and PFN).  So set_memory_decrypted() can be fixed to support
vmap() mapping for TDX.

However, looking at the code, set_memory_decrypted() calls
__change_page_attr_set_clr(&cpa, 1).  The second argument is 'checkalias', which
means even we call set_memory_decrypted() against vmap() address, the aliasing
mappings will be changed too.  And if I understand correctly, the aliasing
mapping includes direct-mapping too:

static int cpa_process_alias(struct cpa_data *cpa)                             
{                                                                              
        struct cpa_data alias_cpa;
        unsigned long laddr = (unsigned long)__va(cpa->pfn << PAGE_SHIFT);     
        unsigned long vaddr;
        int ret;                                                               
                                                                                                                                                   
        if (!pfn_range_is_mapped(cpa->pfn, cpa->pfn + 1))                      
                return 0;                                                      

        /*
         * No need to redo, when the primary call touched the direct           
         * mapping already:                                                    
         */
        vaddr = __cpa_addr(cpa, cpa->curpage);                                 
        if (!(within(vaddr, PAGE_OFFSET,
                    PAGE_OFFSET + (max_pfn_mapped << PAGE_SHIFT)))) {
                
                alias_cpa = *cpa; 
                alias_cpa.vaddr = &laddr;
                alias_cpa.flags &= ~(CPA_PAGES_ARRAY | CPA_ARRAY);             
                alias_cpa.curpage = 0;                                         
                
                cpa->force_flush_all = 1;                                      

                ret = __change_page_attr_set_clr(&alias_cpa, 0);               
                if (ret)                                                       
                        return ret;
        }                                                                      

#ifdef CONFIG_X86_64                                                           
        /*
         * If the primary call didn't touch the high mapping already           
         * and the physical address is inside the kernel map, we need          
         * to touch the high mapped kernel as well:
         */                                                                    
        if (!within(vaddr, (unsigned long)_text, _brk_end) &&                  
            __cpa_pfn_in_highmap(cpa->pfn)) {                                  
                unsigned long temp_cpa_vaddr = (cpa->pfn << PAGE_SHIFT) +      
                                               __START_KERNEL_map - phys_base; 
                alias_cpa = *cpa;                                              
                alias_cpa.vaddr = &temp_cpa_vaddr;                             
                alias_cpa.flags &= ~(CPA_PAGES_ARRAY | CPA_ARRAY);
                alias_cpa.curpage = 0;                                         

                cpa->force_flush_all = 1;
                /*
                 * The high mapping range is imprecise, so ignore the
                 * return value.
                 */
                __change_page_attr_set_clr(&alias_cpa, 0);
        }
#endif

        return 0;
}

As you can see, the first chunk checks whether the virtual address is direct-
mapping, and if it is not, direct mapping is changed too.

The second chunk even changes the high kernel mapping.

So, if we use set_memory_decrypted(), there's no difference whether the address
is vmap() or direct mapping address.  The direct mapping will be changed anyway.

(However, it seems if we call set_memory_decrypted() against direct mapping
address, the vmap() mapping won't be impacted, because it seems
cpa_process_alias() doesn't check vmap() area..).

However I may have missed something.  Kirill please help to confirm if you see
this.

-- 
Thanks,
-Kai


