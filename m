Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C086B49C90E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 12:49:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234274AbiAZLtA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 06:49:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232111AbiAZLs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 06:48:59 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F49C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 03:48:58 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id z19so25841718lfq.13
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 03:48:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8ZZvVwoKjlAsaqSxtK4fQe4yK7eYFTBEgmc8sINCg78=;
        b=X6aKr0fMqQPTsLVZwB/htoJ9UO/IbyIRUdV/qXdYpLy0MU2rm5LgmNuRIXGDnLc284
         N2KNzz9uaXR446/RX3vbnM2v8mAbnKG17fPesrLsSJIOYY7Sm7JljX7Mly7kI7fbQ1nU
         w8Y3F5keHKCzciOhwm9YabBt0S06kRim5XzikIaZ+rPPFt7YOQLzuhXecmdZXYS2tUUM
         ZFMNtRDuaAdtKiLI+UXAP/FTYsSLci4egde7rRUle8+xxSB7uoJ3xIYsXZb+gv7hEOmE
         mbPTBmk6lQhoGYP+W/9G5i73WLJy8+K6Qy601L0MJJNsS2qnooiaWyGv9UaQbe6ol8D0
         lfWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8ZZvVwoKjlAsaqSxtK4fQe4yK7eYFTBEgmc8sINCg78=;
        b=3Gv2JXjXF6gyfN8OCGEi7M2sxRVOQSA55vgqgRuwvEN4W5Q7+48APbpcXCN3oM+l16
         Qz9Z7k43Fq4KCEoVucqG2q9R/HlZKBZDt2pNUo6UtrAP2uUhrvS2I1i5diBV6Zz2qodI
         axHebl2KfYthg/6SZph6sbIRjKgLTRkJHMd4Q1TN7k5X8z7vqJyPZSnS6IpLA+Mb4MJC
         9asi8i36YWdHEh6Z3qKD434DlYtbMi2CShTCUGD0s/bDs6dcwgy9YXz6w3sPSpRQyu1e
         p6AAtIBthJqBmhGtYaQMG9APNT/ezOUlgi+sHnjBLqOtNlzYvUnT/Bpq2exfRtNMHmPP
         5qcQ==
X-Gm-Message-State: AOAM532os484DvJi8ytMhIxWzKaYsDhL7QAQjvUOOOe0CQCrqbSis3um
        f1fSPGP98ZTcjD9WQ6Ha9eC4bIBejR2anDmv0CAuFA==
X-Google-Smtp-Source: ABdhPJziD07+eMnW4rLwOuYDFVWZHuCUdhswCuRCWSHJWbdITLdwopbQOQ/llqE1eiGY374+vaHv5tuFoZPkxX6LTJA=
X-Received: by 2002:a05:6512:3d12:: with SMTP id d18mr20141777lfv.213.1643197736980;
 Wed, 26 Jan 2022 03:48:56 -0800 (PST)
MIME-Version: 1.0
References: <20220120202805.3369-1-shy828301@gmail.com> <af603cbe-4a38-9947-5e6d-9a9328b473fb@redhat.com>
 <CAG48ez1xuZdELb=5ed1i0ruoFu5kAaWsf0LgRXEGhrDAcHz8fw@mail.gmail.com> <f7f82234-7599-9e39-1108-f8fbe2c1efc9@redhat.com>
In-Reply-To: <f7f82234-7599-9e39-1108-f8fbe2c1efc9@redhat.com>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 26 Jan 2022 12:48:29 +0100
Message-ID: <CAG48ez17d3p53tSfuDTNCaANyes8RNNU-2i+eFMqkMwuAbRT4Q@mail.gmail.com>
Subject: Re: [v2 PATCH] fs/proc: task_mmu.c: don't read mapcount for migration entry
To:     David Hildenbrand <david@redhat.com>
Cc:     Yang Shi <shy828301@gmail.com>, kirill.shutemov@linux.intel.com,
        willy@infradead.org, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2022 at 12:38 PM David Hildenbrand <david@redhat.com> wrote:
> On 26.01.22 12:29, Jann Horn wrote:
> > On Wed, Jan 26, 2022 at 11:51 AM David Hildenbrand <david@redhat.com> wrote:
> >> On 20.01.22 21:28, Yang Shi wrote:
> >>> The syzbot reported the below BUG:
> >>>
> >>> kernel BUG at include/linux/page-flags.h:785!
[...]
> >>> RIP: 0010:PageDoubleMap include/linux/page-flags.h:785 [inline]
> >>> RIP: 0010:__page_mapcount+0x2d2/0x350 mm/util.c:744
[...]
> >> Does this point at the bigger issue that reading the mapcount without
> >> having the page locked is completely unstable?
> >
> > (See also https://lore.kernel.org/all/CAG48ez0M=iwJu=Q8yUQHD-+eZDg6ZF8QCF86Sb=CN1petP=Y0Q@mail.gmail.com/
> > for context.)
>
> Thanks for the pointer.
>
> >
> > I'm not sure what you mean by "unstable". Do you mean "the result is
> > not guaranteed to still be valid when the call returns", "the result
> > might not have ever been valid", or "the call might crash because the
> > page's state as a compound page is unstable"?
>
> A little bit of everything :)
[...]
> > In case you mean "the result might not have ever been valid":
> > Yes, even with this patch applied, in theory concurrent THP splits
> > could cause us to count some page mappings twice. Arguably that's not
> > entirely correct.
>
> Yes, the snapshot is not atomic and, thereby, unreliable. That what I
> mostly meant as "unstable".
>
> >
> > In case you mean "the call might crash because the page's state as a
> > compound page could concurrently change":
>
> I think that's just a side-product of the snapshot not being "correct",
> right?

I guess you could see it that way? The way I look at it is that
page_mapcount() is designed to return a number that's at least as high
as the number of mappings (rarely higher due to races), and using
page_mapcount() on an unlocked page is legitimate if you're fine with
the rare double-counting of references. In my view, the problem here
is:

There are different types of references to "struct page" - some of
them allow you to call page_mapcount(), some don't. And in particular,
get_page() doesn't give you a reference that can be used with
page_mapcount(), but locking a (real, non-migration) PTE pointing to
the page does give you such a reference.

This concept of "different types of references" is the same as you
e.g. get with mmgrab() vs mmget() - they both give references to the
same object, but those references have different usage restrictions.
