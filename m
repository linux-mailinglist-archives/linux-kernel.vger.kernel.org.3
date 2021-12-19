Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAE0647A292
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Dec 2021 23:12:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236765AbhLSWM0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Dec 2021 17:12:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233594AbhLSWMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Dec 2021 17:12:25 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B061FC061574
        for <linux-kernel@vger.kernel.org>; Sun, 19 Dec 2021 14:12:24 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id bm14so17994317edb.5
        for <linux-kernel@vger.kernel.org>; Sun, 19 Dec 2021 14:12:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z1EeGlidL5zxbN8lavZvrIotlPnJ2iSVy9AUU7Sk+Ag=;
        b=NdJgcvEjsZfkR59wZEXSS0eAS2OrzVKVMrHaeDy2k3yG7QDmcSTrqgVUsjoRTxYAYZ
         vCIPJCJjuPYvuxe2TKemOH14PEfxj7KcsAVyY5LORM9MPvai7r31koyJWODlLOnNa1hM
         YVOo44slRSUgIgcV41XWNlfxShfEvbw6SoJH0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z1EeGlidL5zxbN8lavZvrIotlPnJ2iSVy9AUU7Sk+Ag=;
        b=N26IcpZo/wTbIdATjLfkv6/VZH05K0UWOEZKMflEnm+jHBPi7a1Bm4JtJuyZ4Zeij6
         dCSs0uHld693Op+5WIABLrEekcCqK0Edcw8zngc7lnbvMicm/zBR2XAu5X2K/0qfTHAv
         13qGp6cYSmXSXyT92JccZ+0F/rosEQjMtT6hkkaZI78PNyfeUnfzQHlWA3Artd/9DbjN
         UuB6b8JJDaAN8HxVoBnr+KE9vER5fupgs7RkJPxV5xFi5K3EKkNXxB8SeGe5ZT6LxaxK
         tfiY1D/sYqU2Iinqfv01N31C5jz0mqKMm3NdMHTo7JK1EIMwFT6bF7nwKwD0YnCI0al1
         Y9Kw==
X-Gm-Message-State: AOAM532bNgwQzEG5tXgIPgg0IXJ8GvGohW7V2A6TQeidUWTlgR5tMcFJ
        PrYZr7VaVr2WnlW5ZPNW4YBmxkZmCMpp79iEJLA=
X-Google-Smtp-Source: ABdhPJy0VToFOL5a3p+lnpxzASUXb/a/Z6sVpc/zBH+y7iacMt3nzKmtR/jK9vCzTf6BNipmsk0gtA==
X-Received: by 2002:a17:906:dc94:: with SMTP id cs20mr7372125ejc.316.1639951943152;
        Sun, 19 Dec 2021 14:12:23 -0800 (PST)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com. [209.85.128.52])
        by smtp.gmail.com with ESMTPSA id jt4sm2776437ejb.105.2021.12.19.14.12.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Dec 2021 14:12:21 -0800 (PST)
Received: by mail-wm1-f52.google.com with SMTP id b73so5716172wmd.0
        for <linux-kernel@vger.kernel.org>; Sun, 19 Dec 2021 14:12:20 -0800 (PST)
X-Received: by 2002:a05:600c:1e01:: with SMTP id ay1mr9481320wmb.152.1639951940498;
 Sun, 19 Dec 2021 14:12:20 -0800 (PST)
MIME-Version: 1.0
References: <4D97206A-3B32-4818-9980-8F24BC57E289@vmware.com>
 <CAHk-=whxvVQReBqZeaV41=sAWfT4xTfn6sMSWDfkHKVS3zX85w@mail.gmail.com>
 <5A7D771C-FF95-465E-95F6-CD249FE28381@vmware.com> <CAHk-=wgMuSkumYxeaaxbKFoAbw_gjYo1eRXXSFcBHzNG2xauTA@mail.gmail.com>
 <CAHk-=whYT0Q1F=bxG0yi=LN5gXY64zBwefsbkLoRiP5p598d5A@mail.gmail.com>
 <fca16906-8e7d-5d04-6990-dfa8392bad8b@redhat.com> <Yb+gId/gXocrlJYD@casper.infradead.org>
 <CAHk-=wiAzmB-jiHvF+EZ1-b0X3ts4LAYHaVhzpzXEjmC0X95eg@mail.gmail.com>
 <Yb+oi8fg1dJe1uBm@casper.infradead.org> <CAHk-=wgLLRT_KeM5Se1AxGcf-g5MkCS-JmPy169Rpdeky_YkXg@mail.gmail.com>
 <Yb+r2W6RCKhO5toC@casper.infradead.org>
In-Reply-To: <Yb+r2W6RCKhO5toC@casper.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 19 Dec 2021 14:12:04 -0800
X-Gmail-Original-Message-ID: <CAHk-=wibQevWUPb4V67gs0FsUBKO+bSMvp9tpOU3PM4Mg_4i4Q@mail.gmail.com>
Message-ID: <CAHk-=wibQevWUPb4V67gs0FsUBKO+bSMvp9tpOU3PM4Mg_4i4Q@mail.gmail.com>
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

On Sun, Dec 19, 2021 at 2:02 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> I'd like to get rid of ->mapcount for file pages too.  And those are
> definitely never mapped in the majority of cases.

Fair enough.

You'd probably be better off checking "is this mapping mapped" though.
Because otherwise you have to get the page lock to serialize each
page.

               Linus
