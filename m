Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA044515DCF
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 15:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349716AbiD3Nrt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 09:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238513AbiD3Nro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 09:47:44 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBFE851E64
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 06:44:22 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id c23so9364652plo.0
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 06:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BqIxANSCe4nfeVe4AU8f2BtOt2NenfWECIlvX3a7SYk=;
        b=AUcE1lZuPjKn80PACgAPEZP0kBiSrF5iKrv862zPCaJgDhkvtPfzOvzAdYmjIrP+Px
         1VZe2FbcwldJya2Caq+H8pXa3UurJZ8g06pppmVj/XLcRmfPcMJobGSRHmH/3xQqXBYl
         OCAlsM97tr5XcNn13Gn/Qzexj5oWSl0+aeFvmtn6tIlsTpYjfuMqXVHz8T3bzQjVVvYq
         O9j924xjCSNOS0xAPOX05WCkoQ7TBtXF5y4mMdWFa/iNhmogDE/V/0IwxhbHpjB+nUkZ
         SFzCCTa4OCEKgtx9lxCFSer20QsWPrM/6apEYpePLDHTTLHssTLwlkvvFde/+TPN1mgG
         yyZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BqIxANSCe4nfeVe4AU8f2BtOt2NenfWECIlvX3a7SYk=;
        b=M9yLPN9Ks0vsWTuEDx5If5OG+tjw6g7ZKg0Cbp03LUiFhXhGRkZt0tqTt0OTyPap/l
         PwVV7zHM34xShAeP3XP7JaTgtqESZ3x3jIHs8ifrzLU9+hVHETNqIasQYOhJvPlyg6n6
         sRPDYfB5yZgmdmnYphFmduGwcM4gsHB6wj4wMDBM0hVLXPNP/nd7T3GFX1ATYPapEzBY
         zl97N3vPgY/2Ac/7DJs8HnLRQb2Pg75XHobn6bzIRu5C69rp0J9H6xB1bn1uPu5s6T9l
         WMyGPee9C2CPbnl/ZM+PbHB/IzUpDh8R3HipRsuwOLWGqKub1tLpFBxMe1lG6Y98As4D
         WA3Q==
X-Gm-Message-State: AOAM532bnutltmIK21sOck1vqU3y1bHA1/n48D+VFprA10tnwUc4Tsy2
        dvCjdrIGiJ6CR9LVz+9Uw50=
X-Google-Smtp-Source: ABdhPJxH0grf9vbL0PX3vT9Q0wxOja7HcFLXgAV7X/ifDrk9gSCn0eg3KLVkBMX6ocMTuiir6gM2qQ==
X-Received: by 2002:a17:90a:9ea:b0:1dc:1c48:eda with SMTP id 97-20020a17090a09ea00b001dc1c480edamr5480231pjo.38.1651326262206;
        Sat, 30 Apr 2022 06:44:22 -0700 (PDT)
Received: from ip-172-31-27-201.ap-northeast-1.compute.internal (ec2-18-183-95-104.ap-northeast-1.compute.amazonaws.com. [18.183.95.104])
        by smtp.gmail.com with ESMTPSA id h3-20020a62b403000000b0050dc7628181sm1585485pfn.91.2022.04.30.06.44.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Apr 2022 06:44:21 -0700 (PDT)
Date:   Sat, 30 Apr 2022 13:44:16 +0000
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        x86@kernel.org
Subject: Re: [RFC PATCH 0/3] Prototype for direct map awareness in page
 allocator
Message-ID: <20220430134415.GA25819@ip-172-31-27-201.ap-northeast-1.compute.internal>
References: <20220127085608.306306-1-rppt@kernel.org>
 <YmezWeMZSRNRfXyG@hyeyoo>
 <YmgOFa3FUUpiANMq@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YmgOFa3FUUpiANMq@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 06:21:57PM +0300, Mike Rapoport wrote:
> Hello Hyeonggon,
> 
> On Tue, Apr 26, 2022 at 05:54:49PM +0900, Hyeonggon Yoo wrote:
> > On Thu, Jan 27, 2022 at 10:56:05AM +0200, Mike Rapoport wrote:
> > > From: Mike Rapoport <rppt@linux.ibm.com>
> > > 
> > > Hi,
> > > 
> > > This is a second attempt to make page allocator aware of the direct map
> > > layout and allow grouping of the pages that must be mapped at PTE level in
> > > the direct map.
> > >
> > 
> > Hello mike, It may be a silly question...
> > 
> > Looking at implementation of set_memory*(), they only split
> > PMD/PUD-sized entries. But why not _merge_ them when all entries
> > have same permissions after changing permission of an entry?
> > 
> > I think grouping __GFP_UNMAPPED allocations would help reducing
> > direct map fragmentation, but IMHO merging split entries seems better
> > to be done in those helpers than in page allocator.
>
> Maybe, I didn't got as far as to try merging split entries in the direct
> map.  IIRC, Kirill sent a patch for collapsing huge pages in the direct map
> some time ago, but there still was something that had to initiate the
> collapse.

But in this case buddy allocator's view of direct map is quite limited.
It cannot merge 2M entries to 1G entry as it does not support
big allocations. Also it cannot merge entries of pages freed in boot process
as they weren't allocated from page allocator.

And it will become harder when pages in MIGRATE_UNMAPPED is borrowed
from another migrate type....

So it would be nice if we can efficiently merge mappings in
change_page_attr_set(). this approach can handle cases above.

I think in this case grouping allocations and merging mappings
should be done separately.

> > For example:
> > 	1) set_memory_ro() splits 1 RW PMD entry into 511 RW PTE
> > 	entries and 1 RO PTE entry.
> > 
> > 	2) before freeing the pages, we call set_memory_rw() and we have
> > 	512 RW PTE entries. Then we can merge it to 1 RW PMD entry.
> 
> For this we need to check permissions of all 512 pages to make sure we can
> use a PMD entry to map them.

Of course that may be slow. Maybe one way to optimize this is using some bits
in struct page, something like: each bit of page->direct_map_split (unsigned long)
is set when at least one entry in (PTRS_PER_PTE = 512)/(BITS_PER_LONG = 64) = 8 entries
has special permissions.

Then we just need to set the corresponding bit when splitting mappings and
iterate 8 entries when changing permission back again. (and then unset the bit when 8 entries has
usual permissions). we can decide to merge by checking if page->direct_map_split is zero.

When scanning, 8 entries would fit into one cacheline.

Any other ideas?

> Not sure that doing the scan in each set_memory call won't cause an overall
> slowdown.

I think we can evaluate it by measuring boot time and bpf/module
load/unload time.

Is there any other workload that is directly affected
by performance of set_memory*()?

> > 	3) after 2) we can do same thing about PMD-sized entries
> > 	and merge them into 1 PUD entry if 512 PMD entries have
> > 	same permissions.
> > [...]
> > > Mike Rapoport (3):
> > >   mm/page_alloc: introduce __GFP_UNMAPPED and MIGRATE_UNMAPPED
> > >   mm/secretmem: use __GFP_UNMAPPED to allocate pages
> > >   EXPERIMENTAL: x86/module: use __GFP_UNMAPPED in module_alloc
> > -- 
> > Thanks,
> > Hyeonggon
> 
> -- 
> Sincerely yours,
> Mike.
