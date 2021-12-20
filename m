Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11B2447B52F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 22:28:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231284AbhLTV2L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 16:28:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbhLTV17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 16:27:59 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F4E1C061574
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 13:27:59 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id w16so15345899edc.11
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 13:27:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=03tftiEYhqRnEnhYGSXfRSnQjXKVu8uhIKmeLcivayo=;
        b=BlcnCZc5c1t5Dfig8sDq8+kwYqCC5UxX6TKvoHp42AdOCuhs3rMbspFkuXfJmAXJmn
         AGLGLo8y6eS/99X7esXkovRQFwuKpXpaeZOFoeiIWJJaZBHwkF0L6FJ8hQr5zCDB00D4
         Pgj1fWZ4XRAjJ+KB5ZQMvjvAc+FPYlGHucNEs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=03tftiEYhqRnEnhYGSXfRSnQjXKVu8uhIKmeLcivayo=;
        b=WOhGVWAzp/y4Ov5TIE1OrKGb29u6TVltkcDJTNeBxd0F3fGIqI/8ym7dYuD5HbyA8n
         dHGEG5nfDbGhP0Fp9ftDRC3pcieLNsbFyr639+7bsGyH9iiQ3sanede5f8+ZujuzzY9s
         wQfnUlT6nrp73/3ZiLAEd22Y4NxcrwoGQidsA77SFEoDWwpAgnqo5aPaRI91m8Hg49N+
         TmuAsXEIGTuLd+RMuChtBVEqFwBnIoVjUTYOPBfjpHvp6rMS5Pm53V5CyMHbUd2BggiT
         OYgMl/VvSXy1lCpEpuI+E3MtvnhCk/uS959Bj097A6rZNsJNGV1gTDotkRE/Jll3LR9B
         7y+g==
X-Gm-Message-State: AOAM532wU0OoCmawIAksogX5QO5UqRf/SfQkbqfK62hu7kKJf1MTTUbz
        YlWobe++CcOJKvsgShcjSma+jg0KYJyy1kgvaKQ=
X-Google-Smtp-Source: ABdhPJwnjr1wnyaqBf0Y8a6KfnwWc/IRTXQLCVEVylN785vgHuTpUj7OLWhYe0Sjz3QhQsYjNNiDsw==
X-Received: by 2002:a17:907:6d87:: with SMTP id sb7mr89765ejc.220.1640035677569;
        Mon, 20 Dec 2021 13:27:57 -0800 (PST)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com. [209.85.221.41])
        by smtp.gmail.com with ESMTPSA id ht16sm1671944ejc.4.2021.12.20.13.27.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Dec 2021 13:27:56 -0800 (PST)
Received: by mail-wr1-f41.google.com with SMTP id a9so22656282wrr.8
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 13:27:55 -0800 (PST)
X-Received: by 2002:adf:d1a6:: with SMTP id w6mr35633wrc.274.1640035674847;
 Mon, 20 Dec 2021 13:27:54 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wh-ETqwd6EC2PR6JJzCFHVxJgdbUcMpW5MS7gCa76EDsQ@mail.gmail.com>
 <4D97206A-3B32-4818-9980-8F24BC57E289@vmware.com> <CAHk-=whxvVQReBqZeaV41=sAWfT4xTfn6sMSWDfkHKVS3zX85w@mail.gmail.com>
 <5A7D771C-FF95-465E-95F6-CD249FE28381@vmware.com> <CAHk-=wgMuSkumYxeaaxbKFoAbw_gjYo1eRXXSFcBHzNG2xauTA@mail.gmail.com>
 <CAHk-=whYT0Q1F=bxG0yi=LN5gXY64zBwefsbkLoRiP5p598d5A@mail.gmail.com>
 <fca16906-8e7d-5d04-6990-dfa8392bad8b@redhat.com> <Yb+gId/gXocrlJYD@casper.infradead.org>
 <YcDNaoGcGS6ypucg@casper.infradead.org> <CAHk-=wj+HbN0Ai+M2ABBvWnNKd2+J97kYPOsjwJC6o9xRF9jHw@mail.gmail.com>
 <YcDvTMUF3XWKWgSW@casper.infradead.org>
In-Reply-To: <YcDvTMUF3XWKWgSW@casper.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 20 Dec 2021 13:27:38 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgyRg+H6PJkDRr7H0=-GNiNZ+yJ7XEWnue5+Nh6SOyXVQ@mail.gmail.com>
Message-ID: <CAHk-=wgyRg+H6PJkDRr7H0=-GNiNZ+yJ7XEWnue5+Nh6SOyXVQ@mail.gmail.com>
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

On Mon, Dec 20, 2021 at 1:02 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> Hah, that was actually how I did it originally (without actually
> committing at each step, and with a few "Oh, hang on, now we can avoid
> calculating this too" stops and restarts along the way), but I thought
> it all hung together logically as a single change.  It's hard to see
> things from the other person's perspective at times.

In just about any other area, I wouldn't mind one bigger patch that
just removes code that isn't used.

But when it's in the vm code, and it's pretty grotty, I do prefer
seeing three patches that individually are much easier to see that
"yeah, this doesn't actually change anything at all".

The combined patch may be exactly the same thing, it's just much
harder to see that "oh, now it's not used any more".

That was perhaps especially true since a number of the changes also
ended up doing statement simplification when the old layout made no
sense any more with part of the results not used.

So your 3-patch series was much easier to look at and go "Yeah, I
believe each of these patches is a no-op".

So ACK on all those patches.

          Linus
