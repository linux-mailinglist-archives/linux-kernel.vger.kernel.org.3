Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F08B947E6DE
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 18:25:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349448AbhLWRZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 12:25:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233445AbhLWRZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 12:25:24 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C2FDC061401
        for <linux-kernel@vger.kernel.org>; Thu, 23 Dec 2021 09:25:24 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id b13so23996404edd.8
        for <linux-kernel@vger.kernel.org>; Thu, 23 Dec 2021 09:25:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ebjUMYzb2XXAsYOtaVdHIf1waqFUxp5nurVKmzFPze0=;
        b=D0oqXy2kl+rC2TLn8MKJW942+MXJlhDcqQRLu5xkE2CWygIZz0D4Zmm57+murcYldK
         4UEQf7kPQlmt/Zu9Vj8PzCJx+hTrF4iTZEz/Zlq2tQY1GdPH6ixD2hrlPiPyOOyxDpjC
         UUPQ6ggzhSxleoC62OuTXUWCgqwRkw7Rjw6Ng=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ebjUMYzb2XXAsYOtaVdHIf1waqFUxp5nurVKmzFPze0=;
        b=QHPFAn/AQbHWbvfWlVHhbiTo12k1mMYf9tr6H9TWRoc6bkZBJkqEpohZ9elORJo0/3
         ZKURRdneo+3BfljnHihPmqYWD7w7Jfs7NfUmKXi7hrixZz8qXOeO2RFG8kL1bOPBa0zC
         A/YilJ0ZDond1pSW8xbXcC+Fr6H5xL4TOpL9UkN22dfYV45m+ZYskgosnm/HBd8iTp9O
         DR+REF6LrEmFQqsvipT0hTkd+YArdInuzHOGUO/gdTea+Y2quvwsOpBRXrhgmdML4k8M
         l0wHT/MoP1SSiZA578vfQ6MpzXxeSUsqbhbNFyT+7v0pVN7bRzxa67MZDumQqxvJI+FC
         ECmQ==
X-Gm-Message-State: AOAM532U2bQ/jwtZ6zISqyUiVxTiKECggTMYmE/hUw/wcTZLC4f/5Cbw
        o6uaPrsERYu312GRjow75JTD0MWGZND17Kt/KHI=
X-Google-Smtp-Source: ABdhPJyKxl8q6bqeLEnT3H30jkvHAkvW9hoMa4eimVj8W2VP1GMZ95UBzD8At0VlYu8Gw5W18ZevsQ==
X-Received: by 2002:a05:6402:231a:: with SMTP id l26mr2794386eda.175.1640280322947;
        Thu, 23 Dec 2021 09:25:22 -0800 (PST)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id s3sm1952705ejs.145.2021.12.23.09.25.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Dec 2021 09:25:22 -0800 (PST)
Received: by mail-ed1-f49.google.com with SMTP id x15so24134666edv.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Dec 2021 09:25:22 -0800 (PST)
X-Received: by 2002:a5d:6c68:: with SMTP id r8mr1878218wrz.281.1640279923027;
 Thu, 23 Dec 2021 09:18:43 -0800 (PST)
MIME-Version: 1.0
References: <900b7d4a-a5dc-5c7b-a374-c4a8cc149232@redhat.com>
 <20211221190706.GG1432915@nvidia.com> <3e0868e6-c714-1bf8-163f-389989bf5189@redhat.com>
 <dfe1c8d5-6fac-9040-0272-6d77bafa6a16@redhat.com> <20211222124141.GA685@quack2.suse.cz>
 <4a28e8a0-2efa-8b5e-10b5-38f1fc143a98@redhat.com> <20211222144255.GE685@quack2.suse.cz>
 <505d3d0f-23ee-0eec-0571-8058b8eedb97@redhat.com> <20211222160846.GH685@quack2.suse.cz>
 <CAHk-=wjUeCUo7dRkzTeqGMJ5-NE4=Xj09mMB0HCkCnMFxsbmwA@mail.gmail.com> <20211223125438.GA19129@quack2.suse.cz>
In-Reply-To: <20211223125438.GA19129@quack2.suse.cz>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 23 Dec 2021 09:18:27 -0800
X-Gmail-Original-Message-ID: <CAHk-=whUEZC2skXPUWy93DpNmC0VF=t2EwmEgWGx8aPstTmWYA@mail.gmail.com>
Message-ID: <CAHk-=whUEZC2skXPUWy93DpNmC0VF=t2EwmEgWGx8aPstTmWYA@mail.gmail.com>
Subject: Re: [PATCH v1 06/11] mm: support GUP-triggered unsharing via
 FAULT_FLAG_UNSHARE (!hugetlb)
To:     Jan Kara <jack@suse.cz>
Cc:     David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
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

On Thu, Dec 23, 2021 at 4:54 AM Jan Kara <jack@suse.cz> wrote:
>
> So forcing pinning for O_DIRECT reads is IMO mandatory.

I don't disagree.

And I do think the eventual aim should be to do it for writes too even
if they don't necessarily require it (since they write _from_ the VM
data, not _to_ the VM data - the "read-vs-write direction has always
been confusing when it comes to GUP").

Partly just for consistency in the IO paths - I think people want to
share as much as possible in there - but also just to make sure that
we're all done with the "wrong-way-cow" kind of issues for good.

If we get to the point where the legacy GUP is used only for very
special things (looking up physical pages for debug and trace purposes
etc), I think that would be lovely.

That may be a pretty long-range goal, though.

              Linus
