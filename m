Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE36C466A15
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 19:55:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356364AbhLBS6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 13:58:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230310AbhLBS6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 13:58:30 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24E57C06174A
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 10:55:07 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id x15so2026351edv.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Dec 2021 10:55:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wlXPuRCS5SZXwAna2myr2eIpOdms2NoVczMkpa6V1g8=;
        b=LenNyinBQKeqV5X3XeNTM53RyLEtQeirQ1yDIfILWW3kwgTTeTctVzezihAEDeGb3d
         9+Po1UrUNEpwDiDgbQ5HGMTfbogzk47IXX3ALWN52yFHAZWZqvTS8aJhJ4IseBTLZUBB
         wXi4Dxjts8G+rj5jPB9q90DTN7rwvgM7A/bDA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wlXPuRCS5SZXwAna2myr2eIpOdms2NoVczMkpa6V1g8=;
        b=yq0QeHuB7dwO06sRyc15gzm1rFfJwG6FHPMdzRMYUDkOZ+8eqcM2SvALs+ATVtDnxv
         bbsYFkBviOI+tj9heJdn0tndFCDqR/sHKSv/29vscPgV6C4SuQQhhTDchjWFJUi8H2wf
         B+ySbPKu1Z/gQ3nOifT308OoF2DQSNY9K83Pxzljt4iPzpPuB8ITSu+5TQ1uRfp2+F1z
         ww1zSqLGqEQXwnCtCHhldhgFg3AAHU/1RY+0yiOFy6v18lGtRjcwgl5QB4BcCI7czpWN
         H0iHa04zDbHWyvQ404w+6ACQX+5QiZw2zDZrKlBGJOlyGYSlVsUv4GwpQJk1kX2tDE+f
         VxGA==
X-Gm-Message-State: AOAM531ZuAxNpHwlZAE2vPE/cAUMQ7icjxJqQnBYdUJJHcSUF4xb32Ka
        NnN+cA6LGqfQfEg9UmFiCMliOSXk9QCiTRLY
X-Google-Smtp-Source: ABdhPJw1TQBL6cTQMIM2u0glcEL6GbdKKaCL64dOxx/Dbrx89RDHGNIsIPrIRjgbXC7k+JnbHQY7Xg==
X-Received: by 2002:a17:907:7e91:: with SMTP id qb17mr17821670ejc.449.1638471305482;
        Thu, 02 Dec 2021 10:55:05 -0800 (PST)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com. [209.85.221.49])
        by smtp.gmail.com with ESMTPSA id jx10sm370578ejc.102.2021.12.02.10.55.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Dec 2021 10:55:05 -0800 (PST)
Received: by mail-wr1-f49.google.com with SMTP id a9so736100wrr.8
        for <linux-kernel@vger.kernel.org>; Thu, 02 Dec 2021 10:55:04 -0800 (PST)
X-Received: by 2002:adf:9d88:: with SMTP id p8mr16929352wre.140.1638471304383;
 Thu, 02 Dec 2021 10:55:04 -0800 (PST)
MIME-Version: 1.0
References: <20211201231757.332199-1-willy@infradead.org> <CAG48ez3YNCNZB7AktmRoYLsBQjwBdwueRUXbkFgNVMsgjmCTGA@mail.gmail.com>
 <YahHZOnT1Uh41XnP@casper.infradead.org>
In-Reply-To: <YahHZOnT1Uh41XnP@casper.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 2 Dec 2021 10:54:48 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiHpPXjA=i6e=3Pk13frRd-RVXfSrT6=KfU2tg4Pu5MmQ@mail.gmail.com>
Message-ID: <CAHk-=wiHpPXjA=i6e=3Pk13frRd-RVXfSrT6=KfU2tg4Pu5MmQ@mail.gmail.com>
Subject: Re: [5.4 PATCH] mm/gup: Do not force a COW break on file-backed memory
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jann Horn <jannh@google.com>, Jan Kara <jack@suse.cz>,
        Kirill Shutemov <kirill@shutemov.name>,
        Oleg Nesterov <oleg@redhat.com>,
        Christoph Hellwig <hch@lst.de>, Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 1, 2021 at 8:11 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> The other patch we've been kicking around (and works) is:
>
>  static inline bool should_force_cow_break(struct vm_area_struct *vma, unsigned
> int flags)
>  {
> -       return is_cow_mapping(vma->vm_flags) && (flags & FOLL_GET);
> +       return is_cow_mapping(vma->vm_flags) &&
> +               (!(vma->vm_flags & VM_DENYWRITE)) && (flags & FOLL_GET);
>  }

That patch makes no sense to me.

It may "work", but it doesn't actually do anything sensible or really
fix the problem that I can tell.

I suspect a real fix would be bigger and more invasive.

If the answer is not to backport all the other changes (and they were
_really_ invasive), I think one answer may be to simply move the
"should_force_cow_break()" down to below the point where you've looked
up the page.

Then you can actually look at "is this a file mapped page", and say
"if so, that's ok, we can return it as-is".

Otherwise, you do something like

        foll_flags |= FOLL_WRITE;
        free_page(page);
        goto repeat;

to repeat the loop (now with FOLL_WRITE).

So the patch is bigger and more involved, because you would have done
the page lookup (for reading) and now notice "Oh, I need it for
writing instead" so you need to undo and re-do).

But at least - unlike backporting everything else - it would be
limited to that one __get_user_pages() function.

Hmm?

(And you'd need to handle that follow_hugetlb_page() case too), not
just the follow_page_mask() one)

             Linus
