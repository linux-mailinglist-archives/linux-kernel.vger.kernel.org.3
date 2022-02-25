Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA414C3E0B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 06:52:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237639AbiBYFvm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 00:51:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237644AbiBYFvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 00:51:39 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D8861F03B4
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 21:51:07 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id v186so3885438ybg.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 21:51:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9Girgga9Ci+5xd+8kHR+4MAPMnZRC/qWzFHzhTjkouU=;
        b=APbEdw9DCoq4YO9CPnVxJaCcGKIrX5WNvB8CrAqLgW+g9afQj3tz1pMqKsE7u7rh7h
         0UDFDhDrmI5J7WRYMtG6H+2tUzTSpk8XSYa5DMqtnvxRNb6qLNLxct/uP31Kfc7VPOCY
         c/wAxEXw0nNmvElPJL52UhKlpywF0hxptGEbE8YjqhZjJd89+enNUTK63m7plns1Bk5R
         EE252+R7LSROnt1LAG7IJwOK5ysyLmIhQHZgBE1nYxkJvrlHhH6ERS7u0FQjak2Gkfe+
         +DpeMk9dZ+9Xzileze/aRznlewvT/WmgWaaGEg0yGybKNuX60TmW0AL7lmBwkTYDPqSy
         AOaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9Girgga9Ci+5xd+8kHR+4MAPMnZRC/qWzFHzhTjkouU=;
        b=HX3K8/M38GOxz7MBaV8SQMK2kX30ZW3LfyRq0IGJqoWQxiTrdOyI4vVpFIvoGnVDYl
         Sita8epPuiWOSj+PtXY9DXEjhyUdtgBfyhXXWr9IeuzCYXzWFIjb9RcL3TdUBbh9N01m
         zczEttR130Rcv7gub4X10AwpiBB9f+p8Tn+Wex/a2/XrekNU4yzRxIiNhxA49Yb+fhnp
         RD08pYc1vCNJekdpczSIfvVOTdLe7pRM//V/HQRLjJX6rwnJ0QKC7f51WFjSb2lN1Py+
         hBtUbH6RU4pjUWibbKu9Uf9CiOaE19QQ9rUFsZJmz+mHAiWvn+LWQGzgOBLFhowOthLp
         VzHg==
X-Gm-Message-State: AOAM532uF5OhT1yKWgoL+2BM2LGx1lcWrIB/EUyWRP/UIrgzlLjCOo6m
        aw4j98S2/sAv6la6/3ZkUl1vUFuFXDCZKQlzgFd1nQ==
X-Google-Smtp-Source: ABdhPJyg1MamSYunzsREevAh9ocOCGsMKrLpiB38putz2JxBhuE88oIZqQN7LkJKrDAj1wsPekXhQPxtDa0vVMN/crY=
X-Received: by 2002:a25:da47:0:b0:61d:9af4:c834 with SMTP id
 n68-20020a25da47000000b0061d9af4c834mr5853645ybf.441.1645768266299; Thu, 24
 Feb 2022 21:51:06 -0800 (PST)
MIME-Version: 1.0
References: <20220215201922.1908156-1-surenb@google.com> <20220224201859.a38299b6c9d52cb51e6738ea@linux-foundation.org>
 <YhhZsv+czqQPKvvN@casper.infradead.org>
In-Reply-To: <YhhZsv+czqQPKvvN@casper.infradead.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 24 Feb 2022 21:50:54 -0800
Message-ID: <CAJuCfpEUro2jxmx-AB2A-mVcNxz6s3oAyow1sEXY5RyPP+83dA@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm: fix use-after-free bug when mm->mmap is reused
 after being freed
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, mhocko@kernel.org,
        mhocko@suse.com, shy828301@gmail.com, rientjes@google.com,
        hannes@cmpxchg.org, guro@fb.com, riel@surriel.com,
        minchan@kernel.org, kirill@shutemov.name, aarcange@redhat.com,
        brauner@kernel.org, christian@brauner.io, hch@infradead.org,
        oleg@redhat.com, david@redhat.com, jannh@google.com,
        shakeelb@google.com, luto@kernel.org, christian.brauner@ubuntu.com,
        fweimer@redhat.com, jengelh@inai.de, timmurray@google.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com,
        syzbot+2ccf63a4bd07cf39cab0@syzkaller.appspotmail.com,
        Liam Howlett <liam.howlett@oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2022 at 8:23 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Thu, Feb 24, 2022 at 08:18:59PM -0800, Andrew Morton wrote:
> > On Tue, 15 Feb 2022 12:19:22 -0800 Suren Baghdasaryan <surenb@google.com> wrote:
> >
> > > After exit_mmap frees all vmas in the mm, mm->mmap needs to be reset,
> > > otherwise it points to a vma that was freed and when reused leads to
> > > a use-after-free bug.
> > >
> > > ...
> > >
> > > --- a/mm/mmap.c
> > > +++ b/mm/mmap.c
> > > @@ -3186,6 +3186,7 @@ void exit_mmap(struct mm_struct *mm)
> > >             vma = remove_vma(vma);
> > >             cond_resched();
> > >     }
> > > +   mm->mmap = NULL;
> > >     mmap_write_unlock(mm);
> > >     vm_unacct_memory(nr_accounted);
> > >  }
> >
> > After the Maple tree patches, mm_struct.mmap doesn't exist.  So I'll
> > revert this fix as part of merging the maple-tree parts of linux-next.
> > I'll be sending this fix to Linus this week.
> >
> > All of which means that the thusly-resolved Maple tree patches might
> > reintroduce this use-after-free bug.
>
> I don't think so?  The problem is that VMAs are (currently) part of
> two data structures -- the rbtree and the linked list.  remove_vma()
> only removes VMAs from the rbtree; it doesn't set mm->mmap to NULL.
>
> With maple tree, the linked list goes away.  remove_vma() removes VMAs
> from the maple tree.  So anyone looking to iterate over all VMAs has to
> go and look in the maple tree for them ... and there's nothing there.

Yes, I think you are right. With maple trees we don't need this fix.

>
> But maybe I misunderstood the bug that's being solved here.
