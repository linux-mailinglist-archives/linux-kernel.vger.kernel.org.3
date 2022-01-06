Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5937E4869DC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 19:27:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242883AbiAFS07 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 13:26:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243061AbiAFS0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 13:26:13 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D6FEC034004
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 10:26:13 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id s6so4247278ioj.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jan 2022 10:26:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cEePo0A7WHWrnyag19ujaD72v/1Fwgdi8AhN3U4zmn4=;
        b=GyONKi3dyoK/bVjT7TNjaddSrAe2FBg0MqkBT5V1RNvfLIheuspaUVLyX2nBLBwzHC
         g4J36kOL48BzfrJdH+erkzTnrB4AN933FO5MSkGZeHyni0TyRsXBa4nppQLfouWscgFD
         Xyuka+7riIsoXfxLxDIci0wVDm9Yw+eddCZQiTCHOzFBaLLrByo98ilp1bRjeMtdAuz5
         GWKNLdXt2//PqeQvBijCD5i9q2jxWm97gC8yC8GCyzZQGX66wOM8SN/TZXdns2AsPEyD
         xuAmCbdLMKm3f1vlsf9yWJU+91XTGe+3IRXOcbIHSidnVdME7Pb0svmTLOouWzd8jcr5
         n01A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cEePo0A7WHWrnyag19ujaD72v/1Fwgdi8AhN3U4zmn4=;
        b=Ze+G32WLfQ1UGcuKGDe9O8I7n1RYNxUzQcxciFvIT99gAzffbWvDRWcZCIiMbDUOLX
         m0Q3hZiSakKijbpAsdd9/nMNfEQU2KTQp6WNoUpdWREh6YKbusySFoxmWvCllpl/B95O
         A1PtCai6r97kiQYzT6Xbf0p9Gj3xiIhIJpiC2u7xJSeswKBl2s8eqXtvVP2LQ5kZaOHQ
         PZFw3qRxCDuyuFyhdxzQJFCPzNTlMyMQO5Uo16kby2Aq3ywI+1+FcH3Pox5JGYvbrXy4
         3pcP5oUYeuaxejvkuFGZgI8lCHmvn1r6wT9zP5r95QyuJcr55ob3tw/N85LfnY5NKDjw
         0ZMA==
X-Gm-Message-State: AOAM530pEyhNqIJTakoKUQn70azW6CKFX2tkn8EAbD/xLb8kWYO29HN3
        C9bGT9tQ84DbKXsBAaGwk85sOSG/WJJF2g2BX0Zing==
X-Google-Smtp-Source: ABdhPJwpqiavJjQnNN1lJnXMEuQDSftQJ9vHHePZDWQzyx8IJ0gLnhDIsC/JAPTri4EYrttHy8cHs9V+Y/M5sOIgpaQ=
X-Received: by 2002:a02:b384:: with SMTP id p4mr26804990jan.167.1641493572689;
 Thu, 06 Jan 2022 10:26:12 -0800 (PST)
MIME-Version: 1.0
References: <20220104021729.111006-1-mike.kravetz@oracle.com>
 <CAJHvVci5sSC-1TEiCBKe8uKQ=0uwCsoBJT_fsG1Rfq6ffy6Obg@mail.gmail.com>
 <20220105155613.45d7dcb81e19bd42deefab79@linux-foundation.org> <92ad1cf1-cd73-c3f8-44b6-6eb917b94693@oracle.com>
In-Reply-To: <92ad1cf1-cd73-c3f8-44b6-6eb917b94693@oracle.com>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Thu, 6 Jan 2022 10:25:36 -0800
Message-ID: <CAJHvVchqFiYMAvTkYZpQ0j6CYFRdzOgBB=CESf06NUbongPbEw@mail.gmail.com>
Subject: Re: [PATCH] userfaultfd/selftests: clean up hugetlb allocation code
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>, Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mina Almasry <almasrymina@google.com>,
        Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 6, 2022 at 9:43 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> On 1/5/22 15:56, Andrew Morton wrote:
> > On Tue, 4 Jan 2022 14:35:34 -0800 Axel Rasmussen <axelrasmussen@google.com> wrote:
> >
> >> On Mon, Jan 3, 2022 at 6:17 PM Mike Kravetz <mike.kravetz@oracle.com> wrote:
> >>>
> >>> The message for commit f5c73297181c ("userfaultfd/selftests: fix hugetlb
> >>> area allocations") says there is no need to create a hugetlb file in the
> >>> non-shared testing case.  However, the commit did not actually change
> >>> the code to prevent creation of the file.
> >>>
> >>> While it is technically true that there is no need to create and use a
> >>> hugetlb file in the case of non-shared-testing, it is useful.  This is
> >>> because 'hole punching' of a hugetlb file has the potentially incorrect
> >>> side effect of also removing pages from private mappings.  The
> >>> userfaultfd test relies on this side effect for removing pages from the
> >>> destination buffer during rounds of stress testing.
> >>>
> >>> Remove the incomplete code that was added to deal with no hugetlb file.
> >>> Just keep the code that prevents reserves from being created for the
> >>> destination area.
> >>>
> >>>         *alloc_area = mmap(NULL, nr_pages * page_size, PROT_READ | PROT_WRITE,
> >>> -                          map_shared ? MAP_SHARED :
> >>> -                          MAP_PRIVATE | MAP_HUGETLB |
> >>> +                          (map_shared ? MAP_SHARED : MAP_PRIVATE) |
> >>> +                          MAP_HUGETLB |
> >>>                            (*alloc_area == area_src ? 0 : MAP_NORESERVE),
> >>> -                          huge_fd,
> >>> -                          *alloc_area == area_src ? 0 : nr_pages * page_size);
> >>> +                          huge_fd, *alloc_area == area_src ? 0 :
> >>> +                          nr_pages * page_size);
> >>
> >> Sorry to nitpick, but I think it was slightly more readable when the
> >> ternary was all on one line.
> >
> > When you have that many arguments I think it's clearer to put one per
> > line, viz.
> >
> >       *alloc_area = mmap(NULL,
> >                          nr_pages * page_size,
> >                          PROT_READ | PROT_WRITE,
> >                          (map_shared ? MAP_SHARED : MAP_PRIVATE) |
> >                               MAP_HUGETLB |
> >                               (*alloc_area == area_src ? 0 : MAP_NORESERVE),
> >                          huge_fd,
> >                          *alloc_area == area_src ? 0 : nr_pages * page_size);
> >
> >
> > But whatever...
> I agree, and also agree with Axel's comment about keeping the ternary all on
> one line.  However, there are examples of breaking both these conventions throughout the file.

For what it's worth, I don't at all mind Andrew's way either, where
the two "outcomes" of the ternary are indented a bit.

Not a big deal though, whatever you'd prefer is fine. :)

>
> My intention here was just to clean up the mess I created with the previous
> patch.  As such, I would prefer to leave this patch as is.  If someone really
> wants this modified, I will.  However, IMO if we make this one call easier
> to read, we should use the same convention throughout the file.  I can do that
> as well, but would prefer to first try to enable using mremap with hugetlb
> within the test.

+1, sounds like a good plan.

> --
> Mike Kravetz
