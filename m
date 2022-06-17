Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60A0954F4AB
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 11:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380577AbiFQJyc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 05:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380092AbiFQJyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 05:54:25 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CE844AE2C;
        Fri, 17 Jun 2022 02:54:24 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 52DD021C94;
        Fri, 17 Jun 2022 09:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1655459663; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zG2cqcDSXyzEvp5pVF9J1GNp84hIzLKr5Bwlm1OtUos=;
        b=fYDb7qEjT6oS5z9kwaQkczLFF3PPeqPcqRDmr2MpJlZLGF16glOXU2IlKNWSd/PjZK4OzO
        n1ckLKV4vxlzBpnHZL5CYrRjQDJlHD4lAO1EWFBTk8D8mn25FJNZoTz+a6K51qGY+1FFk1
        hVOqQ1euxW3Q1vl4/80FdC6E4s1JWyI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1655459663;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zG2cqcDSXyzEvp5pVF9J1GNp84hIzLKr5Bwlm1OtUos=;
        b=UKL/MDgbZ5+ZWynN5FFH+8Jm2XrytgHofQZl6xnqeSlGuab+NWFhsiZryhY9S2SR4DOZE3
        FLNZEpcajUBLO2AQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AB8F41348E;
        Fri, 17 Jun 2022 09:54:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id K5YqJ05PrGLDOwAAMHmgww
        (envelope-from <osalvador@suse.de>); Fri, 17 Jun 2022 09:54:22 +0000
Date:   Fri, 17 Jun 2022 11:54:21 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     David Hildenbrand <david@redhat.com>
Cc:     Muchun Song <songmuchun@bytedance.com>, corbet@lwn.net,
        akpm@linux-foundation.org, paulmck@kernel.org,
        mike.kravetz@oracle.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, smuchun@gmail.com
Subject: Re: [PATCH v2 2/2] mm: memory_hotplug: introduce
 SECTION_CANNOT_OPTIMIZE_VMEMMAP
Message-ID: <YqxPTUuqdDpoU9o3@localhost.localdomain>
References: <20220520025538.21144-1-songmuchun@bytedance.com>
 <20220520025538.21144-3-songmuchun@bytedance.com>
 <53024884-0182-df5f-9ca2-00652c64ce36@redhat.com>
 <YqqqPjkh9r8ZrH0r@localhost.localdomain>
 <24d5ec20-9c9e-93aa-11f4-c4619f51f7d1@redhat.com>
 <YqwVTT+50vt5WpeG@localhost.localdomain>
 <186924ab-651f-71a1-93d2-3500a67dffee@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <186924ab-651f-71a1-93d2-3500a67dffee@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 17, 2022 at 09:43:33AM +0200, David Hildenbrand wrote:
> VmemmapSelfHosted, then the function names get nicer.

Definitely.

> 
> > +#endif
> > +
> >  /*
> >   * On an anonymous page mapped into a user virtual memory area,
> >   * page->mapping points to its anon_vma, not to a struct address_space;
> > diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
> > index 1089ea8a9c98..e2de7ed27e9e 100644
> > --- a/mm/hugetlb_vmemmap.c
> > +++ b/mm/hugetlb_vmemmap.c
> > @@ -101,6 +101,14 @@ void hugetlb_vmemmap_free(struct hstate *h, struct page *head)
> >  {
> >  	unsigned long vmemmap_addr = (unsigned long)head;
> >  	unsigned long vmemmap_end, vmemmap_reuse, vmemmap_pages;
> > +	struct mem_section *ms = __pfn_to_section(page_to_pfn(head));
> > +	struct page *memmap;
> > +
> > +	memmap = sparse_decode_mem_map(ms->section_mem_map,
> > +				       pfn_to_section_nr(page_to_pfn(head)));
> 
> Why can't we check the head page directly? Either I need more coffee or
> this can be simplified.

Uhm, maybe I'm the one who needs coffe here but we have something like:

[    hot-plugges section   ]
[memmap pages][normal pages]

we only mark as VmemmapSelfHosted the memmap pages.

head page points to [normal pages] range, that is why we need to go
and get its mem_map to see whether those pages are marked.

Does it make sense? Or am I missing something?
         

> > +
> > +	if (PageVmemmap_self_hosted(memmap))
> 
> Maybe that's the right place for a comment, an ascii art, and how it is
> safe to only check the first vmemmap page due to alignment restrictions.

Yes, definitely worth putting in a comment.

  
> > +	/*
> > +	 * Let us flag self-hosted memmap
> > +	 */
> 
> I think that comment can be dropped because the code does exactly that.

Yeah, was mainly to picture it, but it needs to go as it is worthless.


-- 
Oscar Salvador
SUSE Labs
