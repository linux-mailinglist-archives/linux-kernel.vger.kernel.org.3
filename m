Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB6B3507A8D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 21:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346625AbiDSUCP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 16:02:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240510AbiDSUCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 16:02:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4160426562
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 12:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650398366;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=S7aPPGBaDUbNbBaEN9oGo4CeP1VF+epNol9mo0bOqDU=;
        b=UVZBNQXuAs3jWaULA0DgawKhMu6yvVwwtt7Xq2IKlh0ylN6YoIQ3I8fRHuyVrYmPloCboR
        Dzc48DBPP0PZr8JDgeX9RVLLJGsbqfxoukB56mtOnZPacfpf1wkgJhrtB74tWwH4zryF4u
        2TrELbVAuwHPWgOTfwc0AVsZUnpV7I8=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-359-Gb4GD24FO-qN6j3ntfFrgA-1; Tue, 19 Apr 2022 15:59:24 -0400
X-MC-Unique: Gb4GD24FO-qN6j3ntfFrgA-1
Received: by mail-il1-f197.google.com with SMTP id v14-20020a056e020f8e00b002caa6a5d918so10170870ilo.15
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 12:59:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=S7aPPGBaDUbNbBaEN9oGo4CeP1VF+epNol9mo0bOqDU=;
        b=zb9ytoirsQupsd7qqs2MtW3snJgUw71cWNrJ0EcKqrw7UWEuOC+3uY5QfqUlhR4FRn
         UWLuhzC9A2F1OhF09eKoTqE3GGP2Mub+Hb6O1k2zYDEdMimKlPhXMhmwv+Mc2olkNR++
         GHkKKXprmxcryRaYMFmzILrIaL8G8us6YsfXcwS3f86S10cMM+K/94owL9HABRad7ehy
         KhnBSBGT4fg7hHpUqPdtd/TcJwHtsx6Iwm8yznGvvbLDOPuHiK20CXjHQTC8WXqxvNjb
         uyLpsRomQJMayqXW3bHnBAyf4ZRnmyQSYrnC1lAx+AzU42FutHPc2jjBpUCfgnqkwMIB
         wQFQ==
X-Gm-Message-State: AOAM533Tr5oiBtva7gRZw1TR9KBcLmZl8m+mxdLIazbXojbwRMudJx0k
        xDmTgRsRbsnlbfBGRrMoWJlUg5+fhoq4ZjoofIOpc3QnMzW7tOADkTyyj5IfyDm1YfPRPPdWf6l
        j+K2/DpjRdfj1TO6hUCy1/iiM
X-Received: by 2002:a05:6e02:2162:b0:2cc:2a35:f3c7 with SMTP id s2-20020a056e02216200b002cc2a35f3c7mr4998321ilv.184.1650398364095;
        Tue, 19 Apr 2022 12:59:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxRZ2hcYzocaccI5T4mLAlPr9viJJ8p6Q4kGuzhBEr50gjPumBpL+trrzVZwbyw5BUdGzj5PA==
X-Received: by 2002:a05:6e02:2162:b0:2cc:2a35:f3c7 with SMTP id s2-20020a056e02216200b002cc2a35f3c7mr4998312ilv.184.1650398363826;
        Tue, 19 Apr 2022 12:59:23 -0700 (PDT)
Received: from xz-m1.local (cpec09435e3e0ee-cmc09435e3e0ec.cpe.net.cable.rogers.com. [99.241.198.116])
        by smtp.gmail.com with ESMTPSA id h24-20020a6bfb18000000b006497692016bsm10097741iog.15.2022.04.19.12.59.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 12:59:23 -0700 (PDT)
Date:   Tue, 19 Apr 2022 15:59:21 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Alistair Popple <apopple@nvidia.com>
Subject: Re: [PATCH v8 22/23] mm: Enable PTE markers by default
Message-ID: <Yl8UmWQodLX+JkZ7@xz-m1.local>
References: <20220405014646.13522-1-peterx@redhat.com>
 <20220405014929.15158-1-peterx@redhat.com>
 <Yl7RrKV5mXtNAAzi@cmpxchg.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="VhobxqQN/RYdeTkm"
Content-Disposition: inline
In-Reply-To: <Yl7RrKV5mXtNAAzi@cmpxchg.org>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--VhobxqQN/RYdeTkm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Tue, Apr 19, 2022 at 11:13:48AM -0400, Johannes Weiner wrote:
> Hi Peter,

Hi, Johannes,

> 
> On Mon, Apr 04, 2022 at 09:49:29PM -0400, Peter Xu wrote:
> > Enable PTE markers by default.  On x86_64 it means it'll auto-enable
> > PTE_MARKER_UFFD_WP as well.
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  mm/Kconfig | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/mm/Kconfig b/mm/Kconfig
> > index 6e7c2d59fa96..3eca34c864c5 100644
> > --- a/mm/Kconfig
> > +++ b/mm/Kconfig
> > @@ -911,12 +911,14 @@ config ANON_VMA_NAME
> >  
> >  config PTE_MARKER
> >  	bool "Marker PTEs support"
> > +	default y
> >  
> >  	help
> >  	  Allows to create marker PTEs for file-backed memory.
> 
> make oldconfig just prompted me on these:
> 
> ---
> Marker PTEs support (PTE_MARKER) [Y/n/?] (NEW) ?
> 
> CONFIG_PTE_MARKER:
> 
> Allows to create marker PTEs for file-backed memory.
> 
> Symbol: PTE_MARKER [=y]
> Type  : bool
> Defined at mm/Kconfig:1046
>   Prompt: Marker PTEs support
>   Location:
>     Main menu
>       -> Memory Management options
> ---
> 
> >  config PTE_MARKER_UFFD_WP
> >  	bool "Marker PTEs support for userfaultfd write protection"
> > +	default y
> >  	depends on PTE_MARKER && HAVE_ARCH_USERFAULTFD_WP
> 
> It's not possible to answer them without looking at the code.
> 
> But after looking at the code, I'm still not sure why it asks
> me. Isn't this infrastructure code?
> 
> Wouldn't it make more sense to remove the prompt string and have
> userfaultfd simply select those?
> 
> If this is too experimental to enable per default, a more reasonable
> question for the user would be a "userfaultfd file support" option or
> something, and have *that* select the marker code.

Thanks for raising this question.

Actually it's right now enabled by default, so I kept the options just to
make sure we can always explicitly disable those options when we want.
That's majorly why I kept this patch standalone one so if we want we can
even drop it.

Said that, I fully agree with you that having two options seem to be an
overkill, especially the PTE_MARKER option will be too challenging to be
correctly understood by anyone not familiar with it.

So after a 2nd thought I'm trying to refine what I want to achieve with the
kbuild system on this new feature:

- On supported systems (x86_64), should be by default y with "make
  olddefconfig", but able to turn it off using "make oldconfig" etc., so
  the user will have a choice when they want.

- On not-supported systems (non-x86_64), should be always n without
  any prompt asking, and user won't even see this entry.

- PTE_MARKER option should always be hidden for all archs

I plan to post a patch that is attached (I also reworded the entry to not
mention about pte markers).  Does that look acceptable on your side?

Thanks,

-- 
Peter Xu

--VhobxqQN/RYdeTkm
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment;
	filename="0001-mm-uffd-Hide-PTE_MARKER-option.patch"

From 5d25e9d685bf129a1730caa61c1545fb16c094bb Mon Sep 17 00:00:00 2001
From: Peter Xu <peterx@redhat.com>
Date: Tue, 19 Apr 2022 15:31:12 -0400
Subject: [PATCH] mm/uffd: Hide PTE_MARKER option
Content-type: text/plain

The PTE_MARKER option should not need to be exposed to the kernel builder,
keep it internal and remove the prompt so it won't be seen.

Instead, make the PTE_MARKER_UFFD_WP option to explicitly choose PTE_MARKER
when necessary.

While PTE_MARKER_UFFD_WP will still prompt to user, change the wording so
that it'll not mention PTE_MARKER at all but renaming it to "Userfaultfd
write protection support for shmem/hugetlbfs".

Reported-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/Kconfig | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/Kconfig b/mm/Kconfig
index 3eca34c864c5..d740e1ff3b2f 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -910,16 +910,16 @@ config ANON_VMA_NAME
 	  difference in their name.
 
 config PTE_MARKER
-	bool "Marker PTEs support"
-	default y
+	bool
 
 	help
 	  Allows to create marker PTEs for file-backed memory.
 
 config PTE_MARKER_UFFD_WP
-	bool "Marker PTEs support for userfaultfd write protection"
+	bool "Userfaultfd write protection support for shmem/hugetlbfs"
 	default y
-	depends on PTE_MARKER && HAVE_ARCH_USERFAULTFD_WP
+	depends on HAVE_ARCH_USERFAULTFD_WP
+	select PTE_MARKER
 
 	help
 	  Allows to create marker PTEs for userfaultfd write protection
-- 
2.32.0


--VhobxqQN/RYdeTkm--

