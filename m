Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C424446E0D0
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 03:17:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbhLICVD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 21:21:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbhLICVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 21:21:03 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FA5CC061746;
        Wed,  8 Dec 2021 18:17:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4aUXBeHiOjhDLfMcvdGJ+eMnajheA/MncO3IxA/riwA=; b=TOdkoaTePicaBkWsS3oqOnXuke
        YtJpOJKcfFUmkV/aN7Emqe5RV5EYrASnfNnrGzV4qauKM/qn6YuVkDBCOJVxZvc8hzUqvSw9fhm+Y
        FgZ/Jpu+LfNaBWw9fR6xtuZVTQM7TZP+I4VrhHsTJlO2RIIQ7f+gBhMqGcgZpd4ACuxvmnEE+x2ht
        EX8Ad7OAn2af1XUsWgB953DAn5qlgkKuWHNI0dA3EL8dSCkQ8PirjUsbX53SFvIrBzLnLP1WllolY
        halaa7GAtso0ZUTUkj5IJUifuKo9bh6RKqsqH6P8fM5ktHlJA2DrjtFMwQKfVkhIuUN+0/JFWaQ/R
        KyKX93Zw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mv8zq-008xK1-2D; Thu, 09 Dec 2021 02:17:22 +0000
Date:   Thu, 9 Dec 2021 02:17:22 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Pasha Tatashin <pasha.tatashin@soleen.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        linux-m68k@lists.linux-m68k.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        william.kucharski@oracle.com,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        schmitzmic@gmail.com, Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>,
        Muchun Song <songmuchun@bytedance.com>, weixugc@google.com,
        Greg Thelen <gthelen@google.com>,
        David Rientjes <rientjes@google.com>,
        Paul Turner <pjt@google.com>
Subject: Re: [PATCH 01/10] mm: page_ref_add_unless() does not trace 'u'
 argument
Message-ID: <YbFnMnVxftnsxoF5@casper.infradead.org>
References: <20211208203544.2297121-1-pasha.tatashin@soleen.com>
 <20211208203544.2297121-2-pasha.tatashin@soleen.com>
 <YbEbvwU81QKK/wUu@casper.infradead.org>
 <CA+CK2bCLkMoJXooxGw-z+-qz20YtE96JxmDYPYM8N0f0eFb52w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+CK2bCLkMoJXooxGw-z+-qz20YtE96JxmDYPYM8N0f0eFb52w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 08, 2021 at 08:25:22PM -0500, Pasha Tatashin wrote:
> On Wed, Dec 8, 2021 at 3:55 PM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Wed, Dec 08, 2021 at 08:35:35PM +0000, Pasha Tatashin wrote:
> > > In other page_ref_* functions all arguments and returns are traced, but
> > > in page_ref_add_unless the 'u' argument which stands for unless boolean
> > > is not traced. However, what is more confusing is that in the tracing
> > > routine:
> > >       __page_ref_mod_unless(struct page *page, int v, int u);
> > >
> > > The 'u' argument present, but instead a return value is passed into
> > > this argument.
> > >
> > > Add a new template specific for page_ref_add_unless(), and trace all
> > > arguments and the return value.
> >
> > The special casing of '1' for device pages is going away, so NAK
> > to this user-visible change.
> 
> I can drop this patch, as it really intended to fix existing oddities
> and missing info. However, I do not really understand your NAK reason.
> Can you please explain about the special casing of "1" for device
> pages?

$ git grep page_ref_add_unless
include/linux/mm.h:     return page_ref_add_unless(page, 1, 0);
include/linux/page_ref.h:static inline bool page_ref_add_unless(struct page *page, int nr, int u)
include/linux/page_ref.h:       return page_ref_add_unless(&folio->page, nr, u);
mm/memcontrol.c:                if (!page_ref_add_unless(page, 1, 1))

'u' is always 0, except for the caller in mm/memcontrol.c:

        if (is_device_private_entry(ent)) {
                page = pfn_swap_entry_to_page(ent);
                /*
                 * MEMORY_DEVICE_PRIVATE means ZONE_DEVICE page and which have
                 * a refcount of 1 when free (unlike normal page)
                 */
                if (!page_ref_add_unless(page, 1, 1))
                        return NULL;
                return page;
        }

That special casing of ZONE_DEVICE pages is being fixed, so 'u' will
soon always be 0, and I'm sure we'll delete it as an argument.  So
there's no point in tracing what it 'used to be'.
