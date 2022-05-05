Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B6C251CBFF
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 00:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386261AbiEEWTn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 18:19:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386260AbiEEWTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 18:19:38 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 188F235DC4
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 15:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651788955; x=1683324955;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cM/cYbeH8cmYHw4i7cDJBJWVOR85+10QmIqjVi8WfMs=;
  b=LwwpiVzC7mNGeejOwTsbobCfI3umGn01X3Dd99jEG2WlavTD+Ucy0iOD
   OR0370f6AZ3MIbpnVwvUuBhS0TFb+SXb27mTIcKfEZTGHM/5KX4Xvt6oM
   kRVAxRZRc2OwUT+MWiE6TOZAkDp5B4DIwmKVcJXwj7/paSbHCa1nnqcge
   hxxJ+PMAjDB1SsxJtLB/7+felT3pLeEh7R8L17anurgjj/Qvu1Jq8iETZ
   8y5G4J9yZYyaPJoClEEdqT9zSi3AQ6GrpG5SqkqBzOrdNiEE4cVngV5IR
   Yy95OIUeNFTKAGmFW4G5z1dfCkXBCfv75kprDBHQ3+amhbfNVoN/uE3bo
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="331256686"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="331256686"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 15:15:54 -0700
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="665174029"
Received: from anthienn-mobl1.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.254.4.139])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 15:15:50 -0700
Message-ID: <d53696f85ada39a91a3685c61d177c582810772e.camel@intel.com>
Subject: Re: [PATCH v5 3/3] x86/tdx: Add Quote generation support
From:   Kai Huang <kai.huang@intel.com>
To:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
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
Date:   Fri, 06 May 2022 10:15:48 +1200
In-Reply-To: <ab17102c-0cb7-87d3-3494-969866d64573@linux.intel.com>
References: <20220501183500.2242828-1-sathyanarayanan.kuppuswamy@linux.intel.com>
         <20220501183500.2242828-4-sathyanarayanan.kuppuswamy@linux.intel.com>
         <243e918c523320ba3d216cbe22d24fe5ce33f370.camel@intel.com>
         <20220503012721.ok7fbvxmnvsr6qny@box.shutemov.name>
         <58d07b2d-cef5-17ed-9c57-e12fe5665e04@intel.com>
         <40ccd0f0-35a1-5aa7-9e51-25ab196d79e5@linux.intel.com>
         <2ed5c9cc316950a5a47ee714715b7980f358a140.camel@intel.com>
         <ab17102c-0cb7-87d3-3494-969866d64573@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-05-05 at 13:53 -0700, Sathyanarayanan Kuppuswamy wrote:
> Hi Kai,
> 
> On 5/4/22 4:28 PM, Kai Huang wrote:
> > On Wed, 2022-05-04 at 15:49 -0700, Sathyanarayanan Kuppuswamy wrote:
> > > --- a/arch/x86/coco/tdx/tdx.c
> > > +++ b/arch/x86/coco/tdx/tdx.c
> > > @@ -15,6 +15,7 @@
> > >    #include <asm/idtentry.h>
> > >    #include <asm/irq_regs.h>
> > >    #include <asm/desc.h>
> > > +#include <asm/io.h>
> > > 
> > >    /* TDX module Call Leaf IDs */
> > >    #define TDX_GET_INFO                   1
> > > @@ -680,8 +681,15 @@ static bool try_accept_one(phys_addr_t *start,
> > > unsigned long len,
> > >     */
> > >    static bool tdx_enc_status_changed(unsigned long vaddr, int numpages,
> > > bool enc)
> > >    {
> > > -       phys_addr_t start = __pa(vaddr);
> > > -       phys_addr_t end   = __pa(vaddr + numpages * PAGE_SIZE);
> > > +       phys_addr_t start;
> > > +       phys_addr_t end;
> > > +
> > > +       if (is_vmalloc_addr((void *)vaddr))
> > > +               start =  page_to_phys(vmalloc_to_page((void*)vaddr));
> > > +       else
> > > +               start = __pa(vaddr);
> > > +
> > > +       end = start + numpages * PAGE_SIZE;
> > > 
> > >           if (!enc) {
> > >                   /* Set the shared (decrypted) bits: */
> > 
> > Looks set_memory_decrypted() only works for direct-mapping, so you should not
> > use this.  Instead, you can pass shared bit in 'prot' argument (using
> > pgprot_decrypted()) when you call vmap(), and explicitly call MapGPA().
> 
> Is it because of the above change, or you see other direct-mapping 
> dependencies in set_memory_*() functions?
> 
> 
> 
set_memory_xx()  is supposedly only for direct-mapping.  Please use my
suggestion above.

-- 
Thanks,
-Kai


