Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AE1D5A148A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 16:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242689AbiHYOmm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 10:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242670AbiHYOmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 10:42:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0278D7CB6E
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 07:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661438427;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9gl8JtwHu2ieQqvlFlp3IZDIk+riOkODkt1dgMqEPWw=;
        b=YYnh7VN+NUhs83NDJ9kojKNUJNRwYCu3LOgqHIX8IGl6uhwQhwQETmdcMK//+fizqcBUxS
        tRQ77MjKvkCPaCdBvqI/8nKxefKmJTv6YA9s6Ba0dupVh+CXJNe9osxPOj7nWmEmC+JVUN
        lr4NnaF8c+RRatRnieviFDYMwxJXUHU=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-1-jkjHTOkIO0-Ybzl6NWqMzw-1; Thu, 25 Aug 2022 10:40:25 -0400
X-MC-Unique: jkjHTOkIO0-Ybzl6NWqMzw-1
Received: by mail-qv1-f71.google.com with SMTP id ea4-20020ad458a4000000b0049682af0ca8so11954290qvb.21
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 07:40:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=9gl8JtwHu2ieQqvlFlp3IZDIk+riOkODkt1dgMqEPWw=;
        b=6vLTMmVleJC+VMf4lv3wLu0ByQgEN9ty958Sj+sHcjMW4trln/bDBoXbqs/WwKyHjY
         YiAuCTo3ktDNG8Os6a/a/tW+pdydBdXKkTw+502huo6YSYr/asLbXQ5LydS1SR1OO/ZC
         +NhK36szfKdOZXIpIzeLtXDZbJNTOBhiMJ7jnGEl1npvpR94VLBS5lETqs9tSHDyaIZZ
         cBBytubz7GRsLoNNMDtHBbO/Q2OWvRMkXVPkGYvgqRRrYZ44BtycGMO9w+pA+8DIXKIe
         CAzySKMlGjPz8FAUbOGM+niYj2gVN/IqBge4fsO7ERTC8V+GR2D2SW9vxKVwn8xX+cgb
         7BeA==
X-Gm-Message-State: ACgBeo30fGtEB56xSyvoWyo7jUuTbuJjz8e35g5mVZLOKxNMzZv3vRB/
        pgEqBnLh7F8QYOaMRP2ZbFb+hHWumQ5FEvhE9rNa+g5YAfYC8sr454s7m+UN2F8XV5256wP0I+O
        /ZshpN6xSiT5VIn1MsVqe/vEK
X-Received: by 2002:a05:622a:170d:b0:344:646b:73e with SMTP id h13-20020a05622a170d00b00344646b073emr3753335qtk.138.1661438425289;
        Thu, 25 Aug 2022 07:40:25 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7TKKJVMyGiS6bNr+tzF2JYvmP3XOGV8sOgN2jBYX27NWJFP8fCLQ0t520JEVxHIVaRHT/sEQ==
X-Received: by 2002:a05:622a:170d:b0:344:646b:73e with SMTP id h13-20020a05622a170d00b00344646b073emr3753302qtk.138.1661438425022;
        Thu, 25 Aug 2022 07:40:25 -0700 (PDT)
Received: from xz-m1.local (bras-base-aurron9127w-grc-35-70-27-3-10.dsl.bell.ca. [70.27.3.10])
        by smtp.gmail.com with ESMTPSA id j20-20020a05620a411400b006b9a24dc9d7sm17831800qko.7.2022.08.25.07.40.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 07:40:24 -0700 (PDT)
Date:   Thu, 25 Aug 2022 10:40:21 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Alistair Popple <apopple@nvidia.com>
Cc:     "Huang, Ying" <ying.huang@intel.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        huang ying <huang.ying.caritas@gmail.com>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Sierra Guiza, Alejandro (Alex)" <alex.sierra@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        David Hildenbrand <david@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>, Ben Skeggs <bskeggs@redhat.com>,
        Logan Gunthorpe <logang@deltatee.com>, paulus@ozlabs.org,
        linuxppc-dev@lists.ozlabs.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mm/migrate_device.c: Copy pte dirty bit to page
Message-ID: <YweJ1QSChgNQnFyY@xz-m1.local>
References: <87tu6bbaq7.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <1D2FB37E-831B-445E-ADDC-C1D3FF0425C1@gmail.com>
 <Yv1BJKb5he3dOHdC@xz-m1.local>
 <87czcyawl6.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <Yv5QXkS4Bm9pTBeG@xz-m1.local>
 <874jy9aqts.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <87czcqiecd.fsf@nvdebian.thelocal>
 <YwaJSBnp2eyMlkjw@xz-m1.local>
 <YwaOpj54/qUb5fXa@xz-m1.local>
 <87o7w9f7dp.fsf@nvdebian.thelocal>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87o7w9f7dp.fsf@nvdebian.thelocal>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2022 at 10:42:41AM +1000, Alistair Popple wrote:
> 
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Wed, Aug 24, 2022 at 04:25:44PM -0400, Peter Xu wrote:
> >> On Wed, Aug 24, 2022 at 11:56:25AM +1000, Alistair Popple wrote:
> >> > >> Still I don't know whether there'll be any side effect of having stall tlbs
> >> > >> in !present ptes because I'm not familiar enough with the private dev swap
> >> > >> migration code.  But I think having them will be safe, even if redundant.
> >> >
> >> > What side-effect were you thinking of? I don't see any issue with not
> >> > TLB flushing stale device-private TLBs prior to the migration because
> >> > they're not accessible anyway and shouldn't be in any TLB.
> >>
> >> Sorry to be misleading, I never meant we must add them.  As I said it's
> >> just that I don't know the code well so I don't know whether it's safe to
> >> not have it.
> >>
> >> IIUC it's about whether having stall system-ram stall tlb in other
> >> processor would matter or not here.  E.g. some none pte that this code
> >> collected (boosted both "cpages" and "npages" for a none pte) could have
> >> stall tlb in other cores that makes the page writable there.
> >
> > For this one, let me give a more detailed example.
> 
> Thanks, I would have been completely lost about what you were talking
> about without this :-)
> 
> > It's about whether below could happen:
> >
> >        thread 1                thread 2                 thread 3
> >        --------                --------                 --------
> >                           write to page P (data=P1)
> >                             (cached TLB writable)
> >   zap_pte_range()
> >     pgtable lock
> >     clear pte for page P
> >     pgtable unlock
> >     ...
> >                                                      migrate_vma_collect
> >                                                        pte none, npages++, cpages++
> >                                                        allocate device page
> >                                                        copy data (with P1)
> >                                                        map pte as device swap
> >                           write to page P again
> >                           (data updated from P1->P2)
> >   flush tlb
> >
> > Then at last from processor side P should have data P2 but actually from
> > device memory it's P1. Data corrupt.
> 
> In the above scenario migrate_vma_collect_pmd() will observe pte_none.
> This will mark the src_pfn[] array as needing a new zero page which will
> be installed by migrate_vma_pages()->migrate_vma_insert_page().
> 
> So there is no data to be copied hence there can't be any data
> corruption. Remember these are private anonymous pages, so any
> zap_pte_range() indicates the data is no longer needed (eg.
> MADV_DONTNEED).

My bad to have provided an example but invalid. :)

So if the trylock in the function is the only way to migrate this page,
then I agree stall tlb is fine.

> 
> >>
> >> When I said I'm not familiar with the code, it's majorly about one thing I
> >> never figured out myself, in that migrate_vma_collect_pmd() has this
> >> optimization to trylock on the page, collect if it succeeded:
> >>
> >>   /*
> >>    * Optimize for the common case where page is only mapped once
> >>    * in one process. If we can lock the page, then we can safely
> >>    * set up a special migration page table entry now.
> >>    */
> >>    if (trylock_page(page)) {
> >>           ...
> >>    } else {
> >>           put_page(page);
> >>           mpfn = 0;
> >>    }
> >>
> >> But it's kind of against a pure "optimization" in that if trylock failed,
> >> we'll clear the mpfn so the src[i] will be zero at last.  Then will we
> >> directly give up on this page, or will we try to lock_page() again
> >> somewhere?
> 
> That comment is out dated. We used to try locking the page again but
> that was removed by ab09243aa95a ("mm/migrate.c: remove
> MIGRATE_PFN_LOCKED"). See
> https://lkml.kernel.org/r/20211025041608.289017-1-apopple@nvidia.com
> 
> Will post a clean-up for it.

That'll help, thanks.

-- 
Peter Xu

