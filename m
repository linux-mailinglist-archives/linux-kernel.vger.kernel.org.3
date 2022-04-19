Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C746507AF4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 22:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357638AbiDSUbI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 16:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353340AbiDSUbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 16:31:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D33473B027
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 13:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650400100;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OsA60fvdNpmPxi8j6BvsLbDUOJhRAOwM2lIshZoL7PY=;
        b=MdtfFPZAhYKsrbwqjHZNAua1lMAPQvKCZTxb1j+o4rvYDHzctgfx6S3GgIAcMV7jJWEw6u
        axuJmd18bNFlqJbW3p59f+rov63NbhcwYIIRx5/ZNVcFcLRgCKH0//x9KrhjhotldbEJGF
        1KOryL/Fvsvr7JizoKr0YEyCDVoWPXw=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-235-7a4A49XvN3OjPSbd7VEJsg-1; Tue, 19 Apr 2022 16:28:19 -0400
X-MC-Unique: 7a4A49XvN3OjPSbd7VEJsg-1
Received: by mail-io1-f71.google.com with SMTP id x8-20020a056602160800b00654b3a46b66so2753536iow.19
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 13:28:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OsA60fvdNpmPxi8j6BvsLbDUOJhRAOwM2lIshZoL7PY=;
        b=ma8Ggw4VdQkVKaNnvIAyFxAiG2MSQfglmnKHoujb1ypE9f0Sn5bA6ln21q2yC1nsYc
         /jM/5OhPsfXGJhYOvFfraiarL+9EigiwEzhLuNjZ5f6OrHp3uOgn8DJdP3MrGDTpQqjP
         Cw8K61jH5iG3U4fejySF7jAwlOWU3mVM9v8uj2kOi6k67AXQHu1OfEnzQB0RwXKlCHwp
         1KN+xLDFq63PPOe7gHlahBcN8aGfK7Tnv9eyx6pHIq3DbVQ6Wxp+ZX8IAijaZgegLHFB
         cgOIqaql/pHNU1v6tESfMqIYGMNCVQLvwAv1ata2Sen/3AZrAJHS60E9hK898+HindpX
         37rA==
X-Gm-Message-State: AOAM532MVDIl3Xpem+A87uewMN0jEIJZLmacw86gvJCBIzte+e5p0nCT
        vk9BgdK0TIhpaqy8MoMywdRpaccQMg9rEDiXM1GZEnKw7VxKn5qpcpYOKUNLoKhngjzb4t4Q4h+
        Ro3o534xo7+rg0aJHMdaaX30P
X-Received: by 2002:a92:d791:0:b0:2ca:bcb8:9a5a with SMTP id d17-20020a92d791000000b002cabcb89a5amr7687684iln.145.1650400099045;
        Tue, 19 Apr 2022 13:28:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxsVN1a1qwuygonrXe33gOwAiggnDaz58sE6mHuxz4OZx70JBuF6/SjP2EtWHNEQouPdP2hKw==
X-Received: by 2002:a92:d791:0:b0:2ca:bcb8:9a5a with SMTP id d17-20020a92d791000000b002cabcb89a5amr7687675iln.145.1650400098677;
        Tue, 19 Apr 2022 13:28:18 -0700 (PDT)
Received: from xz-m1.local (cpec09435e3e0ee-cmc09435e3e0ec.cpe.net.cable.rogers.com. [99.241.198.116])
        by smtp.gmail.com with ESMTPSA id a3-20020a5ec303000000b006496b4dd21csm10180422iok.5.2022.04.19.13.28.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 13:28:18 -0700 (PDT)
Date:   Tue, 19 Apr 2022 16:28:16 -0400
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
Message-ID: <Yl8bYKOJGW2py7Q0@xz-m1.local>
References: <20220405014646.13522-1-peterx@redhat.com>
 <20220405014929.15158-1-peterx@redhat.com>
 <Yl7RrKV5mXtNAAzi@cmpxchg.org>
 <Yl8UmWQodLX+JkZ7@xz-m1.local>
 <Yl8YE+w+OWz5RNOL@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yl8YE+w+OWz5RNOL@cmpxchg.org>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 19, 2022 at 04:14:11PM -0400, Johannes Weiner wrote:
> Hi Peter,
> 
> On Tue, Apr 19, 2022 at 03:59:21PM -0400, Peter Xu wrote:
> > @@ -910,16 +910,16 @@ config ANON_VMA_NAME
> >  	  difference in their name.
> >  
> >  config PTE_MARKER
> > -	bool "Marker PTEs support"
> > -	default y
> > +	bool
> >  
> >  	help
> >  	  Allows to create marker PTEs for file-backed memory.
> >
> >  config PTE_MARKER_UFFD_WP
> > -	bool "Marker PTEs support for userfaultfd write protection"
> > +	bool "Userfaultfd write protection support for shmem/hugetlbfs"
> >  	default y
> > -	depends on PTE_MARKER && HAVE_ARCH_USERFAULTFD_WP
> > +	depends on HAVE_ARCH_USERFAULTFD_WP
> > +	select PTE_MARKER
> 
> This is much easier to understand, thanks!

Cool!  Sent as a formal patch just now.

> 
> Btw, this doesn't do much without userfaultfd being enabled in
> general, right?

So far yes, but I'm thinking there can be potential other users of
PTE_MARKERS from mm world.  The most close discussion is on the swap read
failures and this patch proposed by Miaohe:

https://lore.kernel.org/lkml/20220416030549.60559-1-linmiaohe@huawei.com/

So I hope we can still keep them around here under mm/ if possible, and
from the gut feeling it really should..

> Would it make sense to have it next to 'config USERFAULTFD' as a
> sub-option?

Yes another good question. :)

IIUC CONFIG_USERFAULTFD resides in init/Kconfig because it introduces a new
syscall.  Same to the rest of the bits for uffd since then, namely:

  - USERFAULTFD_WP
  - USERFAULTFD_MINOR

What I am thinking now is the other way round of your suggestion: whether
we should move most of them out, at least the _WP and _MINOR configs into
mm/?  Because IMHO they are really pure mm ideas and they're irrelevant to
syscalls and init.

Any thoughts?

-- 
Peter Xu

