Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9CF45284E6
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 15:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243578AbiEPND2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 09:03:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbiEPND0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 09:03:26 -0400
Received: from outbound-smtp07.blacknight.com (outbound-smtp07.blacknight.com [46.22.139.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EDEC39B8B
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 06:03:24 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp07.blacknight.com (Postfix) with ESMTPS id 79B231C3737
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 14:03:23 +0100 (IST)
Received: (qmail 2770 invoked from network); 16 May 2022 13:03:23 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 16 May 2022 13:03:23 -0000
Date:   Mon, 16 May 2022 14:03:20 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, vbabka@suse.cz,
        akpm@linux-foundation.org, willy@infradead.org
Subject: Re: Is _PAGE_PROTNONE set only for user mappings?
Message-ID: <20220516130319.GM3441@techsingularity.net>
References: <20220506051940.156952-1-42.hyeyoo@gmail.com>
 <56f89895-601e-44c9-bda4-5fae6782e27e@amd.com>
 <YnpTHMvOO/pLJQ+l@hyeyoo>
 <5fe161cb-6c55-6c4d-c208-16c77e115d3f@amd.com>
 <8c2735ac-0335-6e2a-8341-8266d5d13c30@intel.com>
 <YntHrTX12TGp35aF@hyeyoo>
 <20220512103748.GH3441@techsingularity.net>
 <Yn3tssUR8w8mC1DJ@hyeyoo>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <Yn3tssUR8w8mC1DJ@hyeyoo>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2022 at 02:33:38PM +0900, Hyeonggon Yoo wrote:
> On Thu, May 12, 2022 at 11:37:48AM +0100, Mel Gorman wrote:
> > On Wed, May 11, 2022 at 02:20:45PM +0900, Hyeonggon Yoo wrote:
> > > > pgprot_t vm_get_page_prot(unsigned long vm_flags)
> > > > {
> > > >        pgprot_t ret = __pgprot(pgprot_val(protection_map[vm_flags &
> > > >                                (VM_READ|VM_WRITE|VM_EXEC|VM_SHARED)]) |
> > > >                        pgprot_val(arch_vm_get_page_prot(vm_flags)));
> > > >
> > > >        return arch_filter_pgprot(ret);
> > > > }
> > > > EXPORT_SYMBOL(vm_get_page_prot);
> > > 
> > > I guess it's only set for processes' VMA if no caller is abusing
> > > vm_get_page_prot() for kernel mappings.
> > > 
> > > But yeah, just quick guessing does not make us convinced.
> > > Let's Cc people working on mm.
> > > 
> > > If kernel never uses _PAGE_PROTNONE for kernel mappings, it's just okay
> > > not to clear _PAGE_GLOBAL at first in __change_page_attr() if it's not user address,
> > > because no user will confuse _PAGE_GLOBAL as _PAGE_PROTNONE if it's kernel
> > > address. right?
> > > 
> > 
> > I'm not aware of a case where _PAGE_BIT_PROTNONE is used for a kernel
> > address expecting PROT_NONE semantics instead of the global bit. NUMA
> > Balancing is not going to accidentally treat a kernel address as if it's
> > a NUMA hinting fault. By the time a fault is determining if a PTE access
> > is a numa hinting fault or accesssing a PROT_NONE region, it has been
> > established that it is a userspace address backed by a valid VMA.
> > 
> 
> Thanks Mel, and IIUC nor does do_kern_addr_fault() in arch/x86/mm/fault.c
> expect _PAGE_PROTNONE instead of _PAGE_GLOBAL. I want to make it clear
> in the code that _PAGE_PROTNONE is only used for user mappings.
> 
> How does below look?
> 

I've no strong objections. I worry that this somehow could be used to
set PAGE_USER on a kernel mapping page and maybe a comment would be more
appropriate. However, I'm failing to imagine how NUMA balancing could be
fooled into doing that.

-- 
Mel Gorman
SUSE Labs
