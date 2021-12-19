Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADBEC47A1A3
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Dec 2021 18:45:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233831AbhLSRpC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Dec 2021 12:45:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232418AbhLSRpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Dec 2021 12:45:01 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D5FFC061574
        for <linux-kernel@vger.kernel.org>; Sun, 19 Dec 2021 09:45:01 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id y22so29340107edq.2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Dec 2021 09:45:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=37CNA591iIXmlmMafqkXJhXbVBzDgE9AqG9TjO4gWSk=;
        b=EGjpeBlMwidry0LgAPZByewyzxqi1TxS8Ma+x7tUC7MePHkwhun+ud8sjUPXmbw8lb
         tSNLnq69ftAxYPRofGwjVYV/1gVXtPZQf0iYqC5xHN53fV2Gel87pMwvLJTWstmkmOSx
         eTyb/hZEid7yI9vmpkQVOXMCCcCHMmVfAeXDY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=37CNA591iIXmlmMafqkXJhXbVBzDgE9AqG9TjO4gWSk=;
        b=A3QyAee+SGGE+oJu9EA2eC3mkR6GnF7U8RNhxgq18g6eqvj8RDI2uWwUdz5M0dGEK1
         mlhJqeyd4NqxjNgDKjclMsm+70+pTc5EeLlx0D3xdqB2mweB0YK5Zr7CTB5E3+z4+Aom
         UwxftSoV3ubl3Mcmmme12jCni+JaMBDAxYa195Lm9+jqrsZEYets+bsN5D7JZtKYA1R6
         xcU4c5zq8nEWauh3vr1kWgDdzwuU2lQ5beyloZL/mgnrj/MbjOKDrvcrHbb34vkcazSV
         Gqxi/cRfJVzvOV9biv1OTld4O1REKZXjSyCUBCEk49skbqkuZ9akQfTvAcx8So2ICOrh
         /vhA==
X-Gm-Message-State: AOAM532aoSWq1LO1A1dQrm02mVsXjkynyBNRM3JPVUjSYEX83dPDjEUA
        ncOJJBpeqifp2H4XZegR+gbA3T7EQ/RxdDiP0Po=
X-Google-Smtp-Source: ABdhPJyiIeg//HLli1NpY+ihs2iTo0FKY+FRbk384fUK7EftM76MbLOrGfh/b4WE9ae69mdAVs/GCw==
X-Received: by 2002:a17:907:3e0f:: with SMTP id hp15mr1285743ejc.432.1639935899469;
        Sun, 19 Dec 2021 09:44:59 -0800 (PST)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com. [209.85.221.41])
        by smtp.gmail.com with ESMTPSA id f22sm5939383edf.93.2021.12.19.09.44.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Dec 2021 09:44:58 -0800 (PST)
Received: by mail-wr1-f41.google.com with SMTP id j18so15420023wrd.2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Dec 2021 09:44:58 -0800 (PST)
X-Received: by 2002:adf:f54e:: with SMTP id j14mr10061016wrp.442.1639935898113;
 Sun, 19 Dec 2021 09:44:58 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wgL5u3XMgfUN6BOqVO0OvPx3-LEri1ju-1TW4dFhHQO4g@mail.gmail.com>
 <CAHk-=wgKft6E_EeLA1GnEXcQBA9vu8m2B-M-U7PuiNa0+9gpHA@mail.gmail.com>
 <54c492d7-ddcd-dcd0-7209-efb2847adf7c@redhat.com> <CAHk-=wgjOsHAXttQa=csLG10Cp2hh8Dk8CnNC3_WDpBpTzBESQ@mail.gmail.com>
 <20211217204705.GF6385@nvidia.com> <2E28C79D-F79C-45BE-A16C-43678AD165E9@vmware.com>
 <CAHk-=wgw5bEe8+qifra-aY9fAOf2Pscp1vuXX=f4hESyCK_xLg@mail.gmail.com>
 <20211218030509.GA1432915@nvidia.com> <5C0A673F-8326-4484-B976-DA844298DB29@vmware.com>
 <CAHk-=wj7eSOhbWDeADL_BJKLzdDF5s_5R9v7d-4P3L6v1T3mpQ@mail.gmail.com>
 <20211218184233.GB1432915@nvidia.com> <5CA1D89F-9DDB-4F91-8929-FE29BB79A653@vmware.com>
 <CAHk-=wh-ETqwd6EC2PR6JJzCFHVxJgdbUcMpW5MS7gCa76EDsQ@mail.gmail.com>
 <4D97206A-3B32-4818-9980-8F24BC57E289@vmware.com> <CAHk-=whxvVQReBqZeaV41=sAWfT4xTfn6sMSWDfkHKVS3zX85w@mail.gmail.com>
 <5A7D771C-FF95-465E-95F6-CD249FE28381@vmware.com> <CAHk-=wgMuSkumYxeaaxbKFoAbw_gjYo1eRXXSFcBHzNG2xauTA@mail.gmail.com>
In-Reply-To: <CAHk-=wgMuSkumYxeaaxbKFoAbw_gjYo1eRXXSFcBHzNG2xauTA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 19 Dec 2021 09:44:41 -0800
X-Gmail-Original-Message-ID: <CAHk-=whYT0Q1F=bxG0yi=LN5gXY64zBwefsbkLoRiP5p598d5A@mail.gmail.com>
Message-ID: <CAHk-=whYT0Q1F=bxG0yi=LN5gXY64zBwefsbkLoRiP5p598d5A@mail.gmail.com>
Subject: Re: [PATCH v1 06/11] mm: support GUP-triggered unsharing via
 FAULT_FLAG_UNSHARE (!hugetlb)
To:     Nadav Amit <namit@vmware.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Rik van Riel <riel@surriel.com>,
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

David, you said that you were working on some alternative model. Is it
perhaps along these same lines below?

I was thinking that a bit in the page tables to say "this page is
exclusive to this VM" would be a really simple thing to deal with for
fork() and swapout and friends.

But we don't have such a bit in general, since many architectures have
very limited sets of SW bits, and even when they exist we've spent
them on things like UDDF_WP.,

But the more I think about the "bit doesn't even have to be in the
page tables", the more I think maybe that's the solution.

A bit in the 'struct page' itself.

For hugepages, you'd have to distribute said bit when  you split the hugepage.

But other than that it looks quite simple: anybody who does a virtual
copy will inevitably be messing with the page refcount, so clearing
the "exclusive ownership" bit wouldn't be costly: the 'struct page'
cacheline is already getting dirtied.

Or what was your model you were implying you were thinking about in
your other email? You said

  "I might have had an idea yesterday on how to fix most of the issues
   without relying on the mapcount, doing it similar [..]"

but I didn't then reply to that email because I had just written this
other long email to Nadav.

           Linus

On Sun, Dec 19, 2021 at 9:27 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Adding another bit in the page tables - *purely* to say "this VM owns
> the page outright" - would be fairly powerful. And fairly simple.
>
> Then any COW event will set that bit - because when you actually COW,
> the page you install is *yours*. No questions asked.
>
 [ snip snip ]
>
> Btw, the extra bit doesn't really have to be in the page tables. It
> could be a bit in the page itself. We could add another page bit that
> we just clear when we do the "add ref to page as you make a virtual
> copy during fork() etc".
>
> And no, we can't use "pincount" either, because it's not exact. The
> fact that the page count is so elevated that we think it's pinned is a
> _heuristic_, and that's ok when you have the opposite problem, and ask
> "*might* this page be pinned". You want to never get a false negative,
> but it can get a false positive.
>
>                  Linus
