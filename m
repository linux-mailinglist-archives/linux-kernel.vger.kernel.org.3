Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 920515A9E62
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 19:45:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232517AbiIARoh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 13:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235344AbiIARoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 13:44:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F23C19C2D1
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 10:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662054124;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FJJ0qYVRnAgLcuZMSjxbZMetNdfRSF7eNDaKLQRRUXM=;
        b=MIijdwWQ31c0lq/foijMuAfxc6oc9tVOn5CuKmwGUAu0P9CBLeQc7Pwmh9KwJ2nk1J3Yru
        bbkuscGb+1nxmURRbXv8Wcv4lp6VldH3ZLnTRXJPCvoBtH+uEQPkzQR+yTFwi1hwOJue7S
        oSxpp6WRuH1g6oqHaoCb/CtLnSqCtCM=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-277-R4Sym7V7MhqQ6XX_5IDeFg-1; Thu, 01 Sep 2022 13:42:03 -0400
X-MC-Unique: R4Sym7V7MhqQ6XX_5IDeFg-1
Received: by mail-qk1-f198.google.com with SMTP id r14-20020a05620a298e00b006be796b6164so11367002qkp.19
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 10:42:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=FJJ0qYVRnAgLcuZMSjxbZMetNdfRSF7eNDaKLQRRUXM=;
        b=SJXXsbVn+38oYOVVEor6pGUzoGSlXF7iJYwMrYt5JyqClvXnk4cELdKjFZ+gbOUkDo
         xh2jQDkUj+cwzoob4JuD9F90+HUvwJ4JiFW3pNzSBORh+bP3v4oL4BEoBwsoKGlTHbj/
         OI/FcwW8YcoX8aW+VGikJTXkQ4ClrL2RIKMBRSW5g31CJ9Vss9Ie8cpgOu/75B06tV9A
         t6H11OTxSxzzixApd8GZZgUxMgYBZIiIIdjLIjXz0kerE9uZEcsY60cO6bs9i7GO+YEH
         8m8V+q0Uulhqj6/aYeHhCb9QVne5XAiTU3M8fUmJIXrVF1TwibdkNcb56EBPNBvdFfRC
         RbJQ==
X-Gm-Message-State: ACgBeo0O0TOwNk2cZUVL6kELx+gEWG/QbD3YCeoH+ij6FUG/KIT20N4M
        4kqMaUzwek3Nxq0IPnoRRUHH8HJB66ydr1GyZEeq8trM0Cz5gG0FT3UXahATP8oJ1FxWxkkg32t
        gF1V0BczcHIR5slglCr1At42y
X-Received: by 2002:ae9:e64a:0:b0:6ba:e284:2102 with SMTP id x10-20020ae9e64a000000b006bae2842102mr21448788qkl.739.1662054122493;
        Thu, 01 Sep 2022 10:42:02 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7/AqLBwvxgQGrjag8RZdp9bkMzn6qTQ+vkvLkjwrJcY9zLuSyHBMu7nrPruXvlxE+Ugo1WQw==
X-Received: by 2002:ae9:e64a:0:b0:6ba:e284:2102 with SMTP id x10-20020ae9e64a000000b006bae2842102mr21448756qkl.739.1662054122209;
        Thu, 01 Sep 2022 10:42:02 -0700 (PDT)
Received: from xz-m1.local (bras-base-aurron9127w-grc-35-70-27-3-10.dsl.bell.ca. [70.27.3.10])
        by smtp.gmail.com with ESMTPSA id hj12-20020a05622a620c00b0031ea864d3b2sm10393509qtb.30.2022.09.01.10.42.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 10:42:01 -0700 (PDT)
Date:   Thu, 1 Sep 2022 13:41:59 -0400
From:   Peter Xu <peterx@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Sasha Levin <sasha.levin@oracle.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Jerome Marchand <jmarchan@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Yang Shi <shy828301@gmail.com>
Subject: Re: [PATCH v1] mm/gup: adjust stale comment for RCU GUP-fast
Message-ID: <YxDu51TQTz8lhIPP@xz-m1.local>
References: <20220901072119.37588-1-david@redhat.com>
 <YxDdycTur733hMgt@xz-m1.local>
 <fa0bb4b1-3edd-eb5a-7ad6-dff785d88d8f@redhat.com>
 <YxDghv54uHYMGCfG@xz-m1.local>
 <c9dc3f22-4a72-9b9d-7a74-ad77fe4f3b6e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c9dc3f22-4a72-9b9d-7a74-ad77fe4f3b6e@redhat.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2022 at 06:46:13PM +0200, David Hildenbrand wrote:
> On 01.09.22 18:40, Peter Xu wrote:
> > On Thu, Sep 01, 2022 at 06:34:41PM +0200, David Hildenbrand wrote:
> >> On 01.09.22 18:28, Peter Xu wrote:
> >>> On Thu, Sep 01, 2022 at 09:21:19AM +0200, David Hildenbrand wrote:
> >>>> commit 4b471e8898c3 ("mm, thp: remove infrastructure for handling splitting
> >>>> PMDs") didn't remove all details about the THP split requirements for
> >>>> RCU GUP-fast.
> >>>>
> >>>> IPI broeadcasts on THP split are no longer required.
> >>>>
> >>>> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> >>>> Cc: Sasha Levin <sasha.levin@oracle.com>
> >>>> Cc: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> >>>> Cc: Vlastimil Babka <vbabka@suse.cz>
> >>>> Cc: Jerome Marchand <jmarchan@redhat.com>
> >>>> Cc: Andrea Arcangeli <aarcange@redhat.com>
> >>>> Cc: Hugh Dickins <hughd@google.com>
> >>>> Cc: Jason Gunthorpe <jgg@nvidia.com>
> >>>> Cc: John Hubbard <jhubbard@nvidia.com>
> >>>> Cc: Peter Xu <peterx@redhat.com>
> >>>> Cc: Yang Shi <shy828301@gmail.com>
> >>>> Signed-off-by: David Hildenbrand <david@redhat.com>
> >>>> ---
> >>>>  mm/gup.c | 5 ++---
> >>>>  1 file changed, 2 insertions(+), 3 deletions(-)
> >>>>
> >>>> diff --git a/mm/gup.c b/mm/gup.c
> >>>> index 5abdaf487460..cfe71f422787 100644
> >>>> --- a/mm/gup.c
> >>>> +++ b/mm/gup.c
> >>>> @@ -2309,9 +2309,8 @@ EXPORT_SYMBOL(get_user_pages_unlocked);
> >>>>   *
> >>>>   * Another way to achieve this is to batch up page table containing pages
> >>>>   * belonging to more than one mm_user, then rcu_sched a callback to free those
> >>>> - * pages. Disabling interrupts will allow the fast_gup walker to both block
> >>>> - * the rcu_sched callback, and an IPI that we broadcast for splitting THPs
> >>>> - * (which is a relatively rare event). The code below adopts this strategy.
> >>>> + * pages. Disabling interrupts will allow the fast_gup walker to block the
> >>>> + * rcu_sched callback.
> >>>
> >>> This is the comment for fast-gup in general but not only for thp split.
> >>
> >> "an IPI that we broadcast for splitting THP" is about splitting THP.
> > 
> > Ah OK.  Shall we still keep some "IPI broadcast" information here if we're
> > modifying it?  Otherwise it gives a feeling that none needs the IPIs.
> 
> I guess that's the end goal -- and we forgot about the PMD collapse case.
> 
> Are we aware of any other case that needs an IPI? I'd rather avoid
> documenting something that's no longer true.

I'm not aware of any.

> 
> > 
> > It can be dropped later if you want to rework the thp collapse side and
> > finally remove IPI dependency on fast-gup, but so far it seems to me it's
> > still needed.  Or just drop this patch until that rework happens?
> 
> The doc as is is obviously stale, why drop this patch?
> 
> We should see a fix for the THP collapse issue very soon I guess. Most
> probably this patch will go upstream after that fix.

No objection to have this patch alone as the removal statement is only
about "thp split".  But IMHO this patch alone didn't really help a great
lot, especially if you plan to have more to come that is very relevant to
this, so it'll be clearer to put them together.  Your call.

> 
> > 
> >>
> >>>
> >>> I can understand that we don't need IPI for thp split, but isn't the IPIs
> >>> still needed for thp collapse (aka pmdp_collapse_flush)?
> >>
> >> That was, unfortunately, never documented -- and as discussed in the
> >> other thread, arm64 doesn't do that IPI before collapse and might need
> >> fixing. We'll most probably end up getting rid of that
> >> (undocumented/forgotten) IPI requirement and fix it in GUP-fast by
> >> re-rechecking if the PMD changed.
> > 
> > Yeah from an initial thought that looks valid to me.  It'll also allow
> > pmdp_collapse_flush() to be dropped too, am I right?
> 
> I think the magic about pmdp_collapse_flush() is not only the IPIs, but
> that we don't perform an ordinary PMD flush but we logically flush "all
> PTEs in that range".

Yes there's a difference, good to learn that, thanks.

-- 
Peter Xu

