Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7086F5AF5C4
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 22:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbiIFUXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 16:23:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231213AbiIFUWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 16:22:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C8978A1FD
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 13:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662495755;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6rfQm3A/tm7Sj95hHoCuXpvQKcgb4WAgDh0q01aC4qg=;
        b=U1rT34XtVUrh0NF8Jjv898YADzbCIC+Hb08Uh1C+CvdQsRecl1AkBLR91CdJjMGrX4LC4+
        pL4bpYs2gA8IyKA/5RXAku+sSkbZEj6JvOw1+cEcRS/uLYBgnYyjJERma5aQW/q0v++5od
        pG2Qb9h7No06oBULPM55mB50NjPoTvc=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-172-hDz4yw1dPimUvrIP4nodVg-1; Tue, 06 Sep 2022 16:22:34 -0400
X-MC-Unique: hDz4yw1dPimUvrIP4nodVg-1
Received: by mail-qv1-f69.google.com with SMTP id li18-20020a0562145e1200b004a7963a772cso4181231qvb.23
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 13:22:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=6rfQm3A/tm7Sj95hHoCuXpvQKcgb4WAgDh0q01aC4qg=;
        b=DjA1w7uDo5t3oTSmYcWnRsDYO3kYWMpvMc1dC9GE1k2vGDml4ifSl9NtJtuwjelAfi
         udWlK/avBwXQ+5D2/Awx57mh9VB7IofhYOqJVlylEI0UKDBT9WElF63MVryW4b26+cCx
         GKzbkQ05YdziVjv1VK9reKzrAj2EhpP+LQtXWyDc1Je6tOwvFcpGL0WQQhfzkOjXnPWN
         +0kvf/4rdM8+y32wqUHrUvHZ3MzKUGQrGl1Di03j/6zcfumf2qdqqEfIZvZlEw7xf7xf
         rf3b9/wEWwgtf6s9KGb5lsAruaOseQsRgqEwrXb8VBe5ScOeFSR7w+RG4Wx1KepFkxpx
         qMIQ==
X-Gm-Message-State: ACgBeo2xP8AquARLsjjxfpmdXW3GounDXp/O032uu4EAxkjE857v+U3y
        COhlfnpQPvRfjlkBN9EgEVTqmMvd0I5PWbkreKP6vBKWKDn1V79ENFqnrqqvzhS3WymB7bu8l7n
        CM/iXIypagowq4ywMsDkNNXiq
X-Received: by 2002:ad4:5ccc:0:b0:49a:87e:b21c with SMTP id iu12-20020ad45ccc000000b0049a087eb21cmr58585qvb.28.1662495753498;
        Tue, 06 Sep 2022 13:22:33 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7HlEu+ZPwHInX004FIRhAcDe0jim1kS8RlEBcZxWCkXVNVfHqCq7f5i8MgInHqpj8yvoLXLQ==
X-Received: by 2002:ad4:5ccc:0:b0:49a:87e:b21c with SMTP id iu12-20020ad45ccc000000b0049a087eb21cmr58555qvb.28.1662495753193;
        Tue, 06 Sep 2022 13:22:33 -0700 (PDT)
Received: from xz-m1.local (bras-base-aurron9127w-grc-35-70-27-3-10.dsl.bell.ca. [70.27.3.10])
        by smtp.gmail.com with ESMTPSA id u14-20020a05622a14ce00b00341a807ed21sm2137489qtx.72.2022.09.06.13.22.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 13:22:32 -0700 (PDT)
Date:   Tue, 6 Sep 2022 16:22:30 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michel Lespinasse <michel@lespinasse.org>,
        Jerome Glisse <jglisse@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@suse.de>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Matthew Wilcox <willy@infradead.org>,
        "Liam R. Howlett" <liam.howlett@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Laurent Dufour <laurent.dufour@fr.ibm.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        David Hildenbrand <david@redhat.com>, dhowells@redhat.com,
        Hugh Dickins <hughd@google.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Kent Overstreet <kent.overstreet@linux.dev>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Minchan Kim <minchan@google.com>,
        kernel-team <kernel-team@android.com>,
        linux-mm <linux-mm@kvack.org>,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH RESEND 19/28] mm: disallow do_swap_page to handle
 page faults under VMA lock
Message-ID: <YxesBqZ+L+oeQv5e@xz-m1.local>
References: <20220901173516.702122-1-surenb@google.com>
 <20220901173516.702122-20-surenb@google.com>
 <YxeiB2la/9fZEzLO@xz-m1.local>
 <CAJuCfpHkjHAAmKAJH=cxhFmwMawUDQJccwKa8k=xXNZZ1knT7g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJuCfpHkjHAAmKAJH=cxhFmwMawUDQJccwKa8k=xXNZZ1knT7g@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 06, 2022 at 01:08:10PM -0700, Suren Baghdasaryan wrote:
> On Tue, Sep 6, 2022 at 12:39 PM Peter Xu <peterx@redhat.com> wrote:
> >
> > On Thu, Sep 01, 2022 at 10:35:07AM -0700, Suren Baghdasaryan wrote:
> > > Due to the possibility of do_swap_page dropping mmap_lock, abort fault
> > > handling under VMA lock and retry holding mmap_lock. This can be handled
> > > more gracefully in the future.
> > >
> > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > > ---
> > >  mm/memory.c | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > >
> > > diff --git a/mm/memory.c b/mm/memory.c
> > > index 9ac9944e8c62..29d2f49f922a 100644
> > > --- a/mm/memory.c
> > > +++ b/mm/memory.c
> > > @@ -3738,6 +3738,11 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> > >       vm_fault_t ret = 0;
> > >       void *shadow = NULL;
> > >
> > > +     if (vmf->flags & FAULT_FLAG_VMA_LOCK) {
> > > +             ret = VM_FAULT_RETRY;
> > > +             goto out;
> > > +     }
> > > +
> >
> > May want to fail early similarly for handle_userfault() too for similar
> > reason.  Thanks,
> 
> I wasn't aware of a similar issue there. Will have a closer look. Thanks!

Sure.

Just in case this would be anything helpful - handle_userfault() will both
assert at the entry (mmap_assert_locked) and will in most cases release
read lock along the way when waiting for page fault resolutions.

And userfaultfd should work on anonymous memory for either missing mode or
write protect mode.

Thanks,

-- 
Peter Xu

