Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7543479E19
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Dec 2021 00:12:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231856AbhLRXMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 18:12:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231788AbhLRXMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 18:12:21 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BF23C061574
        for <linux-kernel@vger.kernel.org>; Sat, 18 Dec 2021 15:12:21 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id u22so9368117lju.7
        for <linux-kernel@vger.kernel.org>; Sat, 18 Dec 2021 15:12:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GyKRP/I6esBlhYrEjQLh8BM6N5zOayyRIq/pW8rIAMo=;
        b=fsSA+hM1gQ3dj9V0r6PVdcqg8GIMnU0H2LArYw6UfIkmSDWA7xyVG7fNKpz/dEkoEQ
         SxpEjrlIEqHKNjkl7T6pCX2g5eSPHmzbO0hZDxnUt0UDbVn1IlADDl8KoulkmMpTXprj
         XC5VDGy1beoXsKOs8RdX7NwWeePSeaw8DuiSI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GyKRP/I6esBlhYrEjQLh8BM6N5zOayyRIq/pW8rIAMo=;
        b=6y4O7lWCb6ncg+VIh/sQCmMCbYRvUJym2Po6gtZHcLbq+Z8tly66ufy+z88/qGKFR3
         tI2QVeoofur/Q5VnKFb+NkBqdNzZs7qJWGwYivL6h2dBr0CJ7fL9B2xKTE5y+Nh3R+9D
         VcgxeAm/DYAy/V/6LTtHJ3wEK0SFU0hJelQQkI/bQvpLuZ66MSbye/KsT/Jzwo6LKtBe
         GnOXPp3iRDxSKpWSr0rLD2Y1r2Z8fcfVCMYvIcs3H7ERHU2HSa0w4UAqsXNQxESe0eql
         G59LlAJdw4ZHhaH+WaYOot2ti4JtGZ5iSYGxd2iHDfVqjQkzp405QM1PD2W/yuvHkgij
         iavw==
X-Gm-Message-State: AOAM530M194yVarbc2lrUFTMMX8J8iMxsiYardF9XkfPS64Io6i8T779
        zIG0g7o64VS7VLxO0kmTAoSH9ibvAzYtG/calns=
X-Google-Smtp-Source: ABdhPJypsSw5f9MySOtYGMV+uzUkb4d6keTDaJghutYroRy2AaU9UhVWd7hDPS8fCy4V7ws847pocw==
X-Received: by 2002:a2e:7c16:: with SMTP id x22mr8733683ljc.460.1639869139160;
        Sat, 18 Dec 2021 15:12:19 -0800 (PST)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id g41sm1474700lfv.49.2021.12.18.15.12.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Dec 2021 15:12:19 -0800 (PST)
Received: by mail-lf1-f42.google.com with SMTP id d10so12752660lfg.6
        for <linux-kernel@vger.kernel.org>; Sat, 18 Dec 2021 15:12:18 -0800 (PST)
X-Received: by 2002:adf:f54e:: with SMTP id j14mr7529281wrp.442.1639868771784;
 Sat, 18 Dec 2021 15:06:11 -0800 (PST)
MIME-Version: 1.0
References: <20211217113049.23850-1-david@redhat.com> <20211217113049.23850-7-david@redhat.com>
 <CAHk-=wgL5u3XMgfUN6BOqVO0OvPx3-LEri1ju-1TW4dFhHQO4g@mail.gmail.com>
 <CAHk-=wgKft6E_EeLA1GnEXcQBA9vu8m2B-M-U7PuiNa0+9gpHA@mail.gmail.com>
 <54c492d7-ddcd-dcd0-7209-efb2847adf7c@redhat.com> <CAHk-=wgjOsHAXttQa=csLG10Cp2hh8Dk8CnNC3_WDpBpTzBESQ@mail.gmail.com>
 <17bfb2fd-da51-1264-513f-f9e928ec36c6@redhat.com> <CAHk-=wir5fG_OGe_38nhJZegw0uL5+0oH3k48xWQLcAwc4W0Rg@mail.gmail.com>
 <20211218225211.epa4u6mtjnvgkw4x@box.shutemov.name>
In-Reply-To: <20211218225211.epa4u6mtjnvgkw4x@box.shutemov.name>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 18 Dec 2021 15:05:55 -0800
X-Gmail-Original-Message-ID: <CAHk-=whJWmj70d6yCzYPvrC-6V-6jwkJ4mrVc_p3toy4Lz_nhg@mail.gmail.com>
Message-ID: <CAHk-=whJWmj70d6yCzYPvrC-6V-6jwkJ4mrVc_p3toy4Lz_nhg@mail.gmail.com>
Subject: Re: [PATCH v1 06/11] mm: support GUP-triggered unsharing via
 FAULT_FLAG_UNSHARE (!hugetlb)
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     David Hildenbrand <david@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Nadav Amit <namit@vmware.com>, Rik van Riel <riel@surriel.com>,
        Roman Gushchin <guro@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Donald Dutile <ddutile@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Oleg Nesterov <oleg@redhat.com>, Jan Kara <jack@suse.cz>,
        Linux-MM <linux-mm@kvack.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 18, 2021 at 2:52 PM Kirill A. Shutemov <kirill@shutemov.name> wrote:
>
> So you are saying that if a GUP user wants to see changes made by
> userspace to the page after the GUP it must ask for FOLL_WRITE, even if it
> doesn't have intend to write to the page?

Yup. Put the onus very clearly on GUP.

It's a very special operation, and it's one of the operations that
cause a lot of problems for the VM code. It's by no means the _only_
one - we've got a lot of other things that cause issues - but I think
it's very clear that GUP is very very special, and nobody should say
"I want GUP to do whatever".

There are two cases for GUP:

 - look up the page as it is *NOW*

 - look up the page in order to see any future state on it (and
possibly modify it)

that "any future state" is a fundamentally much heavier operation.
It's the one that really *has* to get rid of any sharing, and it has
to make sure no sharing happens in the future either.

So ii it is an anonymous page, it basically needs to act like a write.
Even if that page is then used only for reading.

Note that here that "if it's anonymous" is kind of a big deal. If it's
a shared file-mapped page, at that point it's "just another
reference". It's potentially problematic even in that case (think of
"truncate()" that tries to force-unmap all pages from VM's), but for
the shared case the answer is "if you truncate it and disassociate the
page from the mapping, it's _your_ problem.

And once it acts as a write, and once it does that COW and we have
exclusive access to it, it might as well be just writable and dirty.
You've done the expensive part already. You've forced it to be private
to that VM.

And this was all triggered by the user doing something very special,
so no amount of "but POSIX" or whatever matters.

GUP is not great. If you use GUP, you get to deal with the downsides.

               Linus
