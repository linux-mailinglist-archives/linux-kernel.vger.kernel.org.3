Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC63247B38C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 20:15:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240688AbhLTTPf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 14:15:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234420AbhLTTPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 14:15:33 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B877C061574
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 11:15:33 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id f5so19411219edq.6
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 11:15:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XOYpkeAZ4lS3WnEUy/1la113N2UrQqSbbd4SmFdrc3c=;
        b=VFuYtAogQUUW1la4HqjicPNsqrgCWU4/5xCFL72zEN7r69TP/+ggb7YvA4E4nU7A0V
         PG6BDVDx9pa0XqFL6wSv9je24PF6AL3JtvSqJZAgHX9NpbG1f/CgePslYfGcEk8jq04L
         M+drnq/DXH4piOVaDEvFA5qWefrgkDK6VCuZY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XOYpkeAZ4lS3WnEUy/1la113N2UrQqSbbd4SmFdrc3c=;
        b=NXzmNkA/783AyeL4waCER7EOWWXexzadPlRZGbbyauT2Tawe7S8Xxs3fbIE6T4O3tw
         HuwqkunZ3pRRVspYp5y9gMZxMOupK0nlzTSDERORu+1zqbCzLhjtqoF6RdhXVNlkYNOV
         VGuZEg5CoBcrFZtjwKkN9zmtlyqu3NzHChn3rinB8zMOiLsHlMgAw46a1j9ofxmoH/bj
         dbyGiaLm50erwOFDcbBC02gjjGdQQ+aeaNrChfnsdBlWN0u9c0xCkFg/t3o+tp7Gtlmk
         jcvQG+BVo/avGv4Ese6819B4GH3QPHfmxg/X+avhNBBGKPySXvCg6LV897Ie77XaVHyt
         XqCQ==
X-Gm-Message-State: AOAM5309yLgPmi+1ZR2jjx9JAwicIN/r0G2KRT/GFisYr/UIy4I5qSVL
        TBX2PHRIEKTCV4oO/+LnajI28A0Y0jWR7U/dw6A=
X-Google-Smtp-Source: ABdhPJxGURxxoksqlBxNy/oR+kqitnTEAOdvsxRTzDjY5GXXYDMYKabqcZxN9JES2K98p5NadLoIxA==
X-Received: by 2002:a05:6402:11cb:: with SMTP id j11mr17971348edw.38.1640027731807;
        Mon, 20 Dec 2021 11:15:31 -0800 (PST)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com. [209.85.221.46])
        by smtp.gmail.com with ESMTPSA id mp26sm5606084ejc.61.2021.12.20.11.15.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Dec 2021 11:15:31 -0800 (PST)
Received: by mail-wr1-f46.google.com with SMTP id v7so14790465wrv.12
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 11:15:30 -0800 (PST)
X-Received: by 2002:a5d:6211:: with SMTP id y17mr2491550wru.97.1640027730630;
 Mon, 20 Dec 2021 11:15:30 -0800 (PST)
MIME-Version: 1.0
References: <20211218184233.GB1432915@nvidia.com> <5CA1D89F-9DDB-4F91-8929-FE29BB79A653@vmware.com>
 <CAHk-=wh-ETqwd6EC2PR6JJzCFHVxJgdbUcMpW5MS7gCa76EDsQ@mail.gmail.com>
 <4D97206A-3B32-4818-9980-8F24BC57E289@vmware.com> <CAHk-=whxvVQReBqZeaV41=sAWfT4xTfn6sMSWDfkHKVS3zX85w@mail.gmail.com>
 <5A7D771C-FF95-465E-95F6-CD249FE28381@vmware.com> <CAHk-=wgMuSkumYxeaaxbKFoAbw_gjYo1eRXXSFcBHzNG2xauTA@mail.gmail.com>
 <CAHk-=whYT0Q1F=bxG0yi=LN5gXY64zBwefsbkLoRiP5p598d5A@mail.gmail.com>
 <fca16906-8e7d-5d04-6990-dfa8392bad8b@redhat.com> <Yb+gId/gXocrlJYD@casper.infradead.org>
 <YcDNaoGcGS6ypucg@casper.infradead.org>
In-Reply-To: <YcDNaoGcGS6ypucg@casper.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 20 Dec 2021 11:15:14 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj+HbN0Ai+M2ABBvWnNKd2+J97kYPOsjwJC6o9xRF9jHw@mail.gmail.com>
Message-ID: <CAHk-=wj+HbN0Ai+M2ABBvWnNKd2+J97kYPOsjwJC6o9xRF9jHw@mail.gmail.com>
Subject: Re: [PATCH v1 06/11] mm: support GUP-triggered unsharing via
 FAULT_FLAG_UNSHARE (!hugetlb)
To:     Matthew Wilcox <willy@infradead.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Nadav Amit <namit@vmware.com>,
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

On Mon, Dec 20, 2021 at 10:37 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> This might be a step in the right direction?
>
> Subject: [PATCH] mm: reuse_swap_page() no longer needs to return map_swapcount

Well, that patch seems to be a no-op removal of dead code, so absolutely yes.

That said, I think it would be good to split it up. I looked at that
patch and went "is that really a no-op" to the point of recreating it.

I think it would be good to make it multiple patches that are each
individally trivial. IOW, start with

 (1) remove second argument to reuse_swap_page() that is always NULL,
without making any other changes

 (2) that now made 'total_mapcount' unused in reuse_swap_page(),
remove it as an argument from page_trans_huge_map_swapcount()

 (3) that now made 'total_mapcount' unused in
page_trans_huge_mapcount(), remove it as an argument there too.

because as it stands, that patch of yours looks like it is changing a
lot of things, and I think it would be clearer to remove one thign at
a time as it becomes obviously not used.

Hmm?

           Linus
