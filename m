Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8463E465D2A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 04:52:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344674AbhLBDzl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 22:55:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235730AbhLBDzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 22:55:37 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2748C061574
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 19:52:15 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id f18so68227999lfv.6
        for <linux-kernel@vger.kernel.org>; Wed, 01 Dec 2021 19:52:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=drQK4psebq0QJ6AjkRP87K0UP25BX0tUwNPI2Mxwh1Y=;
        b=DO1aq2LgHHFFhGcOWvX2pTGyIdhqCHQwSBeoglKvAhlR2yUspI1rAptPS2yqvbx3OA
         cmjFmtDdOlYtai8nQhY+DfSQECbgNeoCtLylICuye7Ym5APn5f2FN1Xxp2jcEZqb4fWa
         ePAIi+MqssKlG9EgdHomV615N2VTdu+xzL+IZl2XpyCg+9r3w/B4J6AG4ap7YA5QDxg1
         nIbJUOl+H1puHtu1dLJtZCGHSL45g75Un+AjaUCnP6zBY+V+RP4s8kA9ocvmyn5XLeCe
         uX6p+iIw5OiLlFYBBr4qvQ6MVDeQLo99UAplja6WXiJXjySa64JDy2lj2VOhhW315xSa
         okbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=drQK4psebq0QJ6AjkRP87K0UP25BX0tUwNPI2Mxwh1Y=;
        b=gJcK4I4jXr7hGm6TA5UeKrDC1/WYcN+lFby5dXGVTx/r+FcnifXaZLWI9O9zINfz8V
         1PbG0tI/h4Ap5OBz0s8DaonOWsNEZmscCS6dUBUjjX08BxBld7+O5BQSoN26o38WGGwN
         K5EmTK1zVXuB5RPY/LGeVKRu5cHeErxkVDNUNNWWN4+veMge7Xs9fS8tZOcbX37aRTvx
         4sCnWLKeGU3HjlVX5C6p72PeH6uxkMGghDR4HyQGvqsjYq1L1W7sZyfmDupFI/zfMk5n
         R83WjeNEUcyX7/VEjL8C++Yke2qsTf80xDR2x9xTJW5Zyi8ggH4M/f1h4qHYCv4x8u/Z
         0D1w==
X-Gm-Message-State: AOAM533WS2egWeyB+pHt5jzlaqSJIa+OTkQC/S1eEziGsMV7Q7oV1ulE
        EW7rc7REGeaZlUInuvp9VGvvkjSi1TUC//AT5+plnw==
X-Google-Smtp-Source: ABdhPJwq8a6alRqcdlos5TuK1YQUxzZdMEuWGyWRQof/6My/8vp03KglHtkzDhbFfaNlU3kgVQMGKRo2giHcFZLNleM=
X-Received: by 2002:ac2:418f:: with SMTP id z15mr8929431lfh.213.1638417134025;
 Wed, 01 Dec 2021 19:52:14 -0800 (PST)
MIME-Version: 1.0
References: <20211201231757.332199-1-willy@infradead.org>
In-Reply-To: <20211201231757.332199-1-willy@infradead.org>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 2 Dec 2021 04:51:47 +0100
Message-ID: <CAG48ez3YNCNZB7AktmRoYLsBQjwBdwueRUXbkFgNVMsgjmCTGA@mail.gmail.com>
Subject: Re: [5.4 PATCH] mm/gup: Do not force a COW break on file-backed memory
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jan Kara <jack@suse.cz>,
        Kirill Shutemov <kirill@shutemov.name>,
        Oleg Nesterov <oleg@redhat.com>,
        Christoph Hellwig <hch@lst.de>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Mike Kravetz <mike.kravetz@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 2, 2021 at 12:18 AM Matthew Wilcox (Oracle)
<willy@infradead.org> wrote:
> Commit 17839856fd58 ("gup: document and work around "COW can break either
> way" issue") forces a COW break, even for read-only GUP.  This interacts
> badly with CONFIG_READ_ONLY_THP_FOR_FS as it tries to write to a read-only
> PMD and follow_trans_huge_pmd() returns NULL which induces an endless
> loop as __get_user_pages() interprets that as page-not-present, tries
> to fault it in and retries the follow_page_mask().
>
> The issues fixed by 17839856fd58 don't apply to files.  We know which way
> the COW breaks; the page cache keeps the original and any modifications
> are private to that process.  There's no optimisation that allows a
> process to reuse a file-backed MAP_PRIVATE page.  So we can skip the
> breaking of the COW for file-backed mappings.
>
> This problem only exists in v5.4.y; other stable kernels either predate
> CONFIG_READ_ONLY_THP_FOR_FS or they include commit a308c71bf1e6 ("mm/gup:
> Remove enfornced COW mechanism").
>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  mm/gup.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/mm/gup.c b/mm/gup.c
> index 3ef769529548..d55e02411010 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -176,7 +176,8 @@ static inline bool can_follow_write_pte(pte_t pte, unsigned int flags)
>   */
>  static inline bool should_force_cow_break(struct vm_area_struct *vma, unsigned int flags)
>  {
> -       return is_cow_mapping(vma->vm_flags) && (flags & FOLL_GET);
> +       return is_cow_mapping(vma->vm_flags) && vma_is_anonymous(vma) &&
> +               (flags & FOLL_GET);
>  }

To be fully correct, the check would have to check for PageAnon(), not
whether the mapping is anonymous, right? Since a private file mapping
can still contain anonymous pages from a prior CoW?
