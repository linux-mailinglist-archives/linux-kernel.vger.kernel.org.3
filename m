Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D09A58EF41
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 17:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233095AbiHJPUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 11:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233118AbiHJPUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 11:20:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DA00E792E3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 08:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660144796;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FficIWOFeLjuHiM92gf0Vr7lpmb8nVxpiEgSclxrqmQ=;
        b=fEbtuvdfJDYLDCJOH8l65Ck4VTA8Izz2zVwoOfwUAneBnF/XFiREGWIPXV3UxdAB+mtwFZ
        pc5z9AmovQk7HAjZ8pKugX0Dew12N5DgNFA7LMm+NHfrFG+7GuOVUvl8GtXvFSzPiQW+Pp
        U8GJmeGSf07ZO5K/4HxztE5sTzOZe1U=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-220-O-Er6coPOAmJpW6NEz_uWA-1; Wed, 10 Aug 2022 11:19:54 -0400
X-MC-Unique: O-Er6coPOAmJpW6NEz_uWA-1
Received: by mail-io1-f72.google.com with SMTP id v14-20020a6b5b0e000000b0067bc967a6c0so8110771ioh.5
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 08:19:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=FficIWOFeLjuHiM92gf0Vr7lpmb8nVxpiEgSclxrqmQ=;
        b=zguGVtjLAOInwtWpOW9pDEdzqQh4f0x6l1aSCOKtfC8QIH2QXUsba/2ex8qA/Aoqfn
         Cim9jlAaocBe3Nfgbzvkmni3hVO8hQmztbDG88EDcW57XdfTAX+qUsbAbOYJJJMqrnX1
         wdUfZ0wkxxt5yjeMzbzUcaZ+p0xlYV/T6NLVmwec+MdVoc4qcdQLFRebksDr7V8+mntt
         hoaqD/vV527Aqbvf0e6lv8SS1QyjFLJRxamwCbKw+RIEwLX6TxswlIvk44bfy4UZgtCP
         xVRperdf7Z15jGNpcZMsE5zTIbF7rdd43exbxIz+Cu/RHf6/JdFlnrK/EuRIHPjdZwoy
         HyCg==
X-Gm-Message-State: ACgBeo3AK/u5VZGCJNIqTAwSia6Q6pWyBI26+R4mbcoc5M6VUlcHj4eP
        YWm2mvz5p5iNl33v6L6JO5LRcMpJlLPH/8a1voS9hvBVuuQEsPrckGYfCSs9Sr+wtE2Ei9cPWe/
        O/aIj8wxKGpLP7xQ8kY9yHyvl
X-Received: by 2002:a92:b742:0:b0:2de:14d8:e801 with SMTP id c2-20020a92b742000000b002de14d8e801mr13434705ilm.105.1660144793994;
        Wed, 10 Aug 2022 08:19:53 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7WuT8iDHEqyGrGAlUMRx9BNUhHDxYjZWfu4PnuArLauU6rsVNMbUKyZQ96Lx+d1VEnx9IHog==
X-Received: by 2002:a92:b742:0:b0:2de:14d8:e801 with SMTP id c2-20020a92b742000000b002de14d8e801mr13434687ilm.105.1660144793701;
        Wed, 10 Aug 2022 08:19:53 -0700 (PDT)
Received: from xz-m1.local (bras-base-aurron9127w-grc-35-70-27-3-10.dsl.bell.ca. [70.27.3.10])
        by smtp.gmail.com with ESMTPSA id k8-20020a056e02156800b002dc100ab6fdsm2271969ilu.35.2022.08.10.08.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 08:19:53 -0700 (PDT)
Date:   Wed, 10 Aug 2022 11:19:51 -0400
From:   Peter Xu <peterx@redhat.com>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Minchan Kim <minchan@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andi Kleen <andi.kleen@intel.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCH v3 5/7] mm: Remember young/dirty bit for page migrations
Message-ID: <YvPMl1tca42yKr2y@xz-m1.local>
References: <20220809220100.20033-1-peterx@redhat.com>
 <20220809220100.20033-6-peterx@redhat.com>
 <8735e4fw52.fsf@yhuang6-desk2.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8735e4fw52.fsf@yhuang6-desk2.ccr.corp.intel.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 10, 2022 at 02:30:33PM +0800, Huang, Ying wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > When page migration happens, we always ignore the young/dirty bit settings
> > in the old pgtable, and marking the page as old in the new page table using
> > either pte_mkold() or pmd_mkold(), and keeping the pte clean.
> >
> > That's fine from functional-wise, but that's not friendly to page reclaim
> > because the moving page can be actively accessed within the procedure.  Not
> > to mention hardware setting the young bit can bring quite some overhead on
> > some systems, e.g. x86_64 needs a few hundreds nanoseconds to set the bit.
> > The same slowdown problem to dirty bits when the memory is first written
> > after page migration happened.
> >
> > Actually we can easily remember the A/D bit configuration and recover the
> > information after the page is migrated.  To achieve it, define a new set of
> > bits in the migration swap offset field to cache the A/D bits for old pte.
> > Then when removing/recovering the migration entry, we can recover the A/D
> > bits even if the page changed.
> >
> > One thing to mention is that here we used max_swapfile_size() to detect how
> > many swp offset bits we have, and we'll only enable this feature if we know
> > the swp offset can be big enough to store both the PFN value and the young
>                                                                        ~~~~~
> Nitpick: A/D

Fixed.

> 
> > bit.  Otherwise the A/D bits are dropped like before.
> >
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  include/linux/swapops.h | 99 +++++++++++++++++++++++++++++++++++++++++
> >  mm/huge_memory.c        | 18 +++++++-
> >  mm/migrate.c            |  6 ++-
> >  mm/migrate_device.c     |  4 ++
> >  mm/rmap.c               |  5 ++-
> >  5 files changed, 128 insertions(+), 4 deletions(-)
> >
> > diff --git a/include/linux/swapops.h b/include/linux/swapops.h
> > index e1accbcd1136..0e9579b90659 100644
> > --- a/include/linux/swapops.h
> > +++ b/include/linux/swapops.h
> > @@ -8,6 +8,10 @@
> >  
> >  #ifdef CONFIG_MMU
> >  
> > +#ifdef CONFIG_SWAP
> > +#include <linux/swapfile.h>
> > +#endif	/* CONFIG_SWAP */
> 
> I don't think we need the comment here.  The #ifdef is too near.  But
> this isn't a big deal.

I'd slightly prefer keeping it (especially Nadav used to complain on
missing comments on ifdefs in previous versions..) since any ifdef can grow
by adding code into it. Then it'll be hard to justify how to define "near"
or not, so hard to define who should be adding that if I'm not the one.

Thanks,

-- 
Peter Xu

