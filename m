Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52D07497AC4
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 09:55:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242475AbiAXIyv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 03:54:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:35053 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242485AbiAXIyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 03:54:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643014479;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5OVepNS05vWemruw80HMvgP2Cce0RvFNyMp9MhW0PGU=;
        b=Nk9kjGexxMeNXCZfWPUKtHtKyWa0MtLX3ZzHh7wpT1pnQlTxJHNdMILa8w/L18h1NoJ+NP
        Ux+RzyV5L6r+r10DhzraGOoXxv3CimR2RG+usQddFZsjmJEiLfNr9aEXc8HcWWZfcjWwUb
        exOTW7Nuc5xaPVa7Mt+GjhUVOQscSdY=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-391-bQWxZoHbN5OYtupEACcEpQ-1; Mon, 24 Jan 2022 03:54:37 -0500
X-MC-Unique: bQWxZoHbN5OYtupEACcEpQ-1
Received: by mail-pf1-f198.google.com with SMTP id f24-20020aa782d8000000b004bc00caa4c0so8902733pfn.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 00:54:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5OVepNS05vWemruw80HMvgP2Cce0RvFNyMp9MhW0PGU=;
        b=Fm0UGeL0M5zl9JpDEfs2QRTcA4Dwm7Urw/H66jAhuoE4wQNZboigvea13IhWagWdYo
         Cyo/ONtbKUzuGqF3Ag3QwPD343C6wSuutsgoQNASkEg81VsJor/LfgjSdeajDbmT2H6W
         mWH0pmCZ7sJS7KKs6biuha7gadeGgsQjHh/dmsx23FJuEw2ZGKUKAKi+PdhkRu8mKJe2
         2Vp3TgUv8y+It4nKLUWc4dwranRTyWE9qz8vOSCjoB31TbWcPDgidHsrn7UjgERCztHW
         lFgsFPAxsNLITrYBN0StA+PYYkLZU7Fdlt4L3m2Kq8HH9qdYxJjSwcOdZCs0twwo1WFO
         xZJg==
X-Gm-Message-State: AOAM533C+NVwapIZp0oV7s/vp76VrIeu1MAE8hyOyOyvHNCG00/7p63D
        O+YFNvEIhiQ4LuaOHuDufDLUEF93uOy5/m20IxXRxKnIfYMaK2aB0VfcSTCNX6GpQZFwmuieU+8
        v5F1ArFEqYFnBYIbfT62Vg0gm
X-Received: by 2002:a63:9044:: with SMTP id a65mr11395418pge.552.1643014476623;
        Mon, 24 Jan 2022 00:54:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyVMGkl2qG/CyPTPJJcywYWbLzejBTKWESJbfEVMgtqVEjJmtr72g+99laInA7PB78pKKgtRA==
X-Received: by 2002:a63:9044:: with SMTP id a65mr11395404pge.552.1643014476338;
        Mon, 24 Jan 2022 00:54:36 -0800 (PST)
Received: from xz-m1.local ([94.177.118.73])
        by smtp.gmail.com with ESMTPSA id x18sm3639230pfc.123.2022.01.24.00.54.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 00:54:36 -0800 (PST)
Date:   Mon, 24 Jan 2022 16:54:29 +0800
From:   Peter Xu <peterx@redhat.com>
To:     Hugh Dickins <hughd@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Yang Shi <shy828301@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alistair Popple <apopple@nvidia.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH RFC v2 1/2] mm: Don't skip swap entry even if zap_details
 specified
Message-ID: <Ye5pRQNRv53HWmSZ@xz-m1.local>
References: <20211115134951.85286-1-peterx@redhat.com>
 <20211115134951.85286-2-peterx@redhat.com>
 <9937aaa-d9ab-2839-b0b7-691d85c9141@google.com>
 <Yd7VEXI+/Lu8MVOo@xz-m1.local>
 <Yd7W6ndSPkXQjurY@xz-m1.local>
 <391aa58d-ce84-9d4-d68d-d98a9c533255@google.com>
 <Yek6PaW8fAXY4Bft@xz-m1.local>
 <93dd745c-5e8b-a50-4ec5-b3f3728ad8b@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <93dd745c-5e8b-a50-4ec5-b3f3728ad8b@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 23, 2022 at 10:29:40PM -0800, Hugh Dickins wrote:
> > However, as I stated before, all these use cases always have another step to
> > take the lock and redo the range.  Then even if some migration entry got
> > wrongly skipped it'll always be fixed.  What we need to find is some caller
> > that calls zap_pte_range() without later taking the page lock and redo that.
> > That's the only possibility to trigger a real issue on the shmem accounting.
> 
> I agree that the fallback "if (folio_mapped() unmap_mapping_folio()",
> while holding folio lock, ensures that there cannot be a migration entry
> substituted for present pte at that time, so no problem if migration entry
> was wrongly skipped on the earlier unlocked pass.
> 
> But you're forgetting the complementary mistake: that the earlier unlocked
> pass might have zapped a migration entry (corresponding to an anon COWed
> page) when it should have skipped it (while punching a hole).

IMHO we won't wrongly zap a migration entry because when it's file backed we've
got non-NULL zap_details, so we'll skip all migration entries.  IOW, we can
only wrongly skip some entries, not wrongly zap some.

But I get your point, and thanks for pointing out what I missed - I think I
forgot the private mappings completely somehow when writting that up..

I have a quick idea on reproducer now (perhaps file size shrinking on private
pages being swapped out), I'll try to write a real reproducer and update later.

[...]

> I did not understand what you were asking there; but in your followup
> mail, I think you came to understand what I meant better.  Yes, I
> believe you could safely replace struct address_space *zap_mapping
> by a more understandable boolean (skip_cows? its inverse would be
> easier to understand, but we don't want almost everyone to have to
> pass a zap_details initialized to true there).

The only even_cows==true for zap_details is with unmap_mapping_range(), where
its caller passed over even_cows==true as parameter.  So IMHO that helper
helped to construct the zap_details anyway.

I'll try it out starting with naming it zap_details.even_cows; I'll make it the
last patch as a cleanup.

> > > > > > >  			rss[mm_counter(page)]--;
> > > > > > >  		}
> > > 
> > > I have given no thought as to whether more "else"s are needed there.
> > 
> > It's hwpoison that's in the else.  Nothing else should.
> > 
> > I didn't mention it probably because I forgot.  I did think about it when
> > drafting, and IMHO we should simply zap that hwpoison entry because:
> > 
> >   (1) Zap means the user knows this data is meaningless, so at least we
> >       shouldn't SIGBUS for that anymore.
> > 
> >   (2) If we keep it there, it could errornously trigger SIGBUS later if the
> >       guest accessed that pte again somehow.
> > 
> > I plan to mention that in the commit message, but I can also add some comments
> > directly into the code.  Let me know your thoughts.
> 
> It's comes down, again, to what punching a hole in a file should do
> to the private data that has been COWed from it.  Strictly, it should
> not interfere with it, even when the COWed page has become poisonous:
> the entry should be left in to generate SIGBUS.  Whereas ordinary
> unmapping or truncating or MADV_DONTNEEDing would zap it.

Makes sense, I'll take care of that in the new version too.  Thanks,

-- 
Peter Xu

