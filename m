Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE9E47C72C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 20:06:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241677AbhLUTGh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 14:06:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232879AbhLUTGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 14:06:36 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF1DAC061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 11:06:35 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id bm14so43031257edb.5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 11:06:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uSk5VvDYQsZZcaVaJlmVspcVDu3v4JssNYlR5otPJd8=;
        b=L0bWadFfaqA46PbcjZuYpBZ2kmMk5OH+dN7TlMlE8TpSSS6Wc3H8L6rr8vSayRRMnd
         nwOKt4bpcsJBVBwIopwedchXVmYOMPNTwupzZeQIbR5GFhrlNsEIY+AZA0NmQrvb5J0W
         S/x1LVFT4naoo3sVe0dEbJThlFDOiCtk087iE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uSk5VvDYQsZZcaVaJlmVspcVDu3v4JssNYlR5otPJd8=;
        b=4u2LDw+/Z3XGIpcyGDmXzclWVsZe9Asjik02twbh0AA2adsR7ntQujeqCatIKvQBO4
         ZF2NBhNg1vImg3bazTC1gc4XhyDIvTu42Xjmm1b7XOhXyFM8Yb66wimr+Cal6wEgbQZ1
         p9JzjHhQBZ8UxYqqkBcR39yS1wUMDQxpBPnaqdrGnSC+/EmDE9HJWE8IjbNuz5LG/CEo
         N/XwPCXb/c7NbwWd4GIiN04qUKIjJHSsfxz9S5Qvp7mq/T3lLUIyFK8HMDOxsP6omn2H
         o79uHN/WKGmN5m3nCvoli0u8o9Suk3QokMJ3Ht8ZyZ3qTNIpespV4DgO5GzkP1N52PN9
         0Mcg==
X-Gm-Message-State: AOAM533nBLxU5PwmtQJ1Y/jIUKILupv2dlIAVYd2Yvk019klFaG8njPW
        Hq7jOU/DNd1eT8oA7Vlh2Q16d7j/0A3uQpg5puo=
X-Google-Smtp-Source: ABdhPJzbP9NwpJf2fECzTWNiaeYU4psJTRfsbdUsXLVvDcS6lwTdJywz8yTfWPIZmrOiYJoaq9Dy/g==
X-Received: by 2002:aa7:cd8a:: with SMTP id x10mr4740648edv.3.1640113594202;
        Tue, 21 Dec 2021 11:06:34 -0800 (PST)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id v16sm1846507edc.4.2021.12.21.11.06.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Dec 2021 11:06:34 -0800 (PST)
Received: by mail-ed1-f54.google.com with SMTP id z29so55769105edl.7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 11:06:34 -0800 (PST)
X-Received: by 2002:adf:8b0e:: with SMTP id n14mr3650177wra.281.1640113138726;
 Tue, 21 Dec 2021 10:58:58 -0800 (PST)
MIME-Version: 1.0
References: <4D97206A-3B32-4818-9980-8F24BC57E289@vmware.com>
 <CAHk-=whxvVQReBqZeaV41=sAWfT4xTfn6sMSWDfkHKVS3zX85w@mail.gmail.com>
 <5A7D771C-FF95-465E-95F6-CD249FE28381@vmware.com> <CAHk-=wgMuSkumYxeaaxbKFoAbw_gjYo1eRXXSFcBHzNG2xauTA@mail.gmail.com>
 <CAHk-=whYT0Q1F=bxG0yi=LN5gXY64zBwefsbkLoRiP5p598d5A@mail.gmail.com>
 <fca16906-8e7d-5d04-6990-dfa8392bad8b@redhat.com> <20211221010312.GC1432915@nvidia.com>
 <fd7e3195-4f36-3804-1793-d453d5bd3e9f@redhat.com> <CAHk-=wgQq3H6wfkW7+MmduVgBOqHeiXQN97yCMd+m1mM-1xCLQ@mail.gmail.com>
 <900b7d4a-a5dc-5c7b-a374-c4a8cc149232@redhat.com> <20211221180705.GA32603@quack2.suse.cz>
 <CAHk-=wiyxQ==vnHFHW99S_OPwA=u1Qrfg2OGr_6zPcBAuhQY2w@mail.gmail.com> <d23ede12-5df7-2f28-00fd-ea58d85ae400@redhat.com>
In-Reply-To: <d23ede12-5df7-2f28-00fd-ea58d85ae400@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 21 Dec 2021 10:58:42 -0800
X-Gmail-Original-Message-ID: <CAHk-=whJeoncgYjzfLOR_dQbJUyOiE1NxE753m1mvAtXZ00tMw@mail.gmail.com>
Message-ID: <CAHk-=whJeoncgYjzfLOR_dQbJUyOiE1NxE753m1mvAtXZ00tMw@mail.gmail.com>
Subject: Re: [PATCH v1 06/11] mm: support GUP-triggered unsharing via
 FAULT_FLAG_UNSHARE (!hugetlb)
To:     David Hildenbrand <david@redhat.com>
Cc:     Jan Kara <jack@suse.cz>, Jason Gunthorpe <jgg@nvidia.com>,
        Nadav Amit <namit@vmware.com>,
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
        Oleg Nesterov <oleg@redhat.com>, Linux-MM <linux-mm@kvack.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 21, 2021 at 10:51 AM David Hildenbrand <david@redhat.com> wrote:
>
> For that purpose the pincount would already kind-off work. Not precise,
> but at least something ("this page cannot possibly have been pinned").

That part actually exists already, ie put_page_refs() has this:

  #ifdef CONFIG_DEBUG_VM
        if (VM_WARN_ON_ONCE_PAGE(page_ref_count(page) < refs, page))
                return;
  #endif

And yeah, it shouldn't have that '#ifdef CONFIG_DEBUG_VM' there, but I
think it's because the non-CONFIG_DEBUG_VM #define for
VM_WARN_ON_ONCE_PAGE() is broken, and doesn't return 0.

                   Linus
