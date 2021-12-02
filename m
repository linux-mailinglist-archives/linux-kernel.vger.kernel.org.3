Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABAED466CF7
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 23:35:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377316AbhLBWiE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 17:38:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377466AbhLBWhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 17:37:53 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB09C061399
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 14:33:58 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id y13so3697820edd.13
        for <linux-kernel@vger.kernel.org>; Thu, 02 Dec 2021 14:33:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LKwx+V2AktZno2fWolXVU26gwZuIYd93DrLMeKrtYvE=;
        b=X3l6T614nyuWfhM4V/g1+uAMSRhILIzxXddjQJP51l+3/Qpge1SyBWfsOy1VKonBRG
         /3cNKCLRs7WOLBoEs3znUxJqzdtieJXLSxYSp3RV456MeSwAXmiAQXF7+JwwipVf/wGG
         i9f2L+bmzzwcT81q0P3zBVKuzIcQBjMTNYkfY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LKwx+V2AktZno2fWolXVU26gwZuIYd93DrLMeKrtYvE=;
        b=3EG4GjXeTXR7H3yNAOt8OqrdTxrRcNf3ucRXKi27YOp0ENulB5+eSMOYibv5RPGktS
         bedrS5ZWBOSY9j9IxQ6bw0xYJS03XPHObFU/m/8Zigpe7kNp1uDMbhtRvhO3vg2XWb/D
         MZHhqre1idFuNInAaUVnbrYrAzBrAOcMwLLOIMejlu8VAaZa1+AOQqRMe2woGvNQ6+F0
         JwN85RE1njNqgsLQ3rwLjvIYAKEjVSilUfqk1/H/Ng4nT4mvmDb7cmIza8h8ZFJX8OXA
         K8KHm7PWdGb8DvFYzV1mJ7CNHxDO9xPDS8KrXpLaUhNPlwmt7avKrz1lOVb8huEawUVS
         IL3g==
X-Gm-Message-State: AOAM530XfmivV1Cn7mZ7eBrTUZyYrOumfqAD5EY2DPpjc1GFOwxbXclF
        8FuXA33AgYpgeyl3u9wDD/s3RAnFwD4lu426
X-Google-Smtp-Source: ABdhPJzsKYONN41MHjkIc2S9ia5mHa88/PTBfb66fe15XhVJCzzawzvhxQIbeSzJNVTLKtPPcdN/bw==
X-Received: by 2002:a17:907:6e1a:: with SMTP id sd26mr18474938ejc.529.1638484436401;
        Thu, 02 Dec 2021 14:33:56 -0800 (PST)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com. [209.85.128.43])
        by smtp.gmail.com with ESMTPSA id jz4sm638511ejc.19.2021.12.02.14.33.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Dec 2021 14:33:55 -0800 (PST)
Received: by mail-wm1-f43.google.com with SMTP id p18so891074wmq.5
        for <linux-kernel@vger.kernel.org>; Thu, 02 Dec 2021 14:33:54 -0800 (PST)
X-Received: by 2002:a05:600c:4e4a:: with SMTP id e10mr9972584wmq.155.1638484433843;
 Thu, 02 Dec 2021 14:33:53 -0800 (PST)
MIME-Version: 1.0
References: <20211201231757.332199-1-willy@infradead.org> <CAG48ez3YNCNZB7AktmRoYLsBQjwBdwueRUXbkFgNVMsgjmCTGA@mail.gmail.com>
 <YahHZOnT1Uh41XnP@casper.infradead.org> <CAHk-=wiHpPXjA=i6e=3Pk13frRd-RVXfSrT6=KfU2tg4Pu5MmQ@mail.gmail.com>
 <YaklihoYztAoKfxX@casper.infradead.org>
In-Reply-To: <YaklihoYztAoKfxX@casper.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 2 Dec 2021 14:33:37 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgzk5dTKaciK2pkto=+fz0kAkXxz9g8ekkWfeOKzMR1EQ@mail.gmail.com>
Message-ID: <CAHk-=wgzk5dTKaciK2pkto=+fz0kAkXxz9g8ekkWfeOKzMR1EQ@mail.gmail.com>
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

On Thu, Dec 2, 2021 at 11:59 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> Oh absolutely, it's semantically nonsense.  The only reason it fixes the
> problem is that VM_DENYWRITE VMAs are the only ones considered for the
> RO_THP merging, so they're the only ones which we've seen causing a
> problem.

That would be a semantically meaningful argument, but I think the
reverse isn't true: regular pages in VM_DENYWRITE vmas - that aren't
using the RO_THP thing - are open to the same old "COW wrong way"
issue.

So it's not like VM_DENYWRITE is really meaningful for the
conditional, even if it's perhaps a prerequisite for it being a
problem.

> > I suspect a real fix would be bigger and more invasive.
>
> Darn.  I was hoping you were going to say something like "The real
> problem is follow_trans_huge_pmd() is complete garbage and it should
> just do X, Y and Z".  Or "When we force on FOLL_WRITE, we should also
> force on FOLL_SPLIT_PMD".

Well, maybe that "FOLL_SPLIT_PMD" thing would indeed be a valid thing?

But I _think_ that it shouldn't be too painful to do the
should_force_cow_break() call later, when you actually have the exact
page details, so while not exactly a one-liner, I hope that approach
would end up working out.

I only gave it a quick look, though, I might be missing something.

              Linus
