Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94FB94A5D61
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 14:24:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238540AbiBANYx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 08:24:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238435AbiBANYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 08:24:52 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA253C061714
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 05:24:51 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id w81so28603411ybg.12
        for <linux-kernel@vger.kernel.org>; Tue, 01 Feb 2022 05:24:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hqpudM9UJz8DhfMHsGDhXcBoDji6CUdX20qRejGuIlI=;
        b=3x9gy11Oeox0rcgJsM027ayhwHe7JM9DmcdtbSgpNwctG0CV7VJyKhto4UfcyPJX1Q
         hLykpQ2Od4xZdy4o7VTXQW7r+bY9MIU4B8uwiBKM2Yj6ZMw+ROIucztbwR555VbGpauu
         XJXsgXG+Tdd3SEhlBUQVuDfl6BqtMJ529XLHCUrjUXfTPImzR0NYB5ZqNPxDcEKFeByk
         EMl5l+0rzYqQBN4WuMxjVTUqhBxldEWR0nunRJkJKkzrx8cT46GMDSdZBxpkJjF80AyP
         G/NVfODh5PHSS2vb8vGTlvtw34uY0OBPKkU+umpr3xrAdV3gxHeuoHju5ZLYBGObJ9NR
         c34w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hqpudM9UJz8DhfMHsGDhXcBoDji6CUdX20qRejGuIlI=;
        b=1fKW1a50Y4M3rNSI1WIh860BF4NcdYXiMej95aE45B0FdBCPV2kXfEmTLK0uiDLC08
         3QNkVxAgf8MXmudEZgzXjhbhjdZYvfSMczm7hyn+zd8wSsG+R7VtHJn0i5/KWCnuaMvR
         gM27CA8zvL6iJPEsPkGtd2fWZ3szJhGsoqg0aTTZHgMRHRCtql/2uWdVUaLh/HrrvzWx
         7V6gRmYEDMBy1QIBAW7dRM506bb0nPREu9IZeX6OtfV2JlTwOgJRaJSBgLgurttyE3uI
         RDlEUMt4Ucn4qgKpFlCqxhDCfDi7Lw6EvjlCN7kI43a8hXMpAU1te/CioBwrHXNShvWM
         qQVg==
X-Gm-Message-State: AOAM532hqUN0MhBtMcsaAW5yyiGBp3wcYVKY2IDrNfGSesN71xA3jJ7T
        SBJ/s4EljHhuYjDMaEWf+2MgPeK+ejGu5m24sui1EA==
X-Google-Smtp-Source: ABdhPJw1pxurtd45w8gTXxi1nf+fzoGVxQGLkvmNzbsa0qcm/oXG9p/hnUkszP0F97RXEMg8phd27jogNWmncmXBHMY=
X-Received: by 2002:a25:c983:: with SMTP id z125mr37208695ybf.132.1643721890972;
 Tue, 01 Feb 2022 05:24:50 -0800 (PST)
MIME-Version: 1.0
References: <20220131160254.43211-1-songmuchun@bytedance.com> <20220131160254.43211-3-songmuchun@bytedance.com>
In-Reply-To: <20220131160254.43211-3-songmuchun@bytedance.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Tue, 1 Feb 2022 21:24:12 +0800
Message-ID: <CAMZfGtVWZ0toBGFrPqLkx9aGdZW1bWfQxTgBMzM=pRweqE_FHw@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] mm: fix missing cache flush for all tail pages of
 compound page
To:     Andrew Morton <akpm@linux-foundation.org>, zi.yan@cs.rutgers.edu,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Lars Persson <lars.persson@axis.com>,
        Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        Zi Yan <ziy@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 1, 2022 at 12:04 AM Muchun Song <songmuchun@bytedance.com> wrote:
>
> The D-cache maintenance inside move_to_new_page() only consider one page,
> there is still D-cache maintenance issue for tail pages of compound page
> (e.g. THP or HugeTLB).  THP migration is only enabled on x86_64, ARM64
> and powerpc, while powerpc and arm64 need to maintain the consistency
> between I-Cache and D-Cache, which depends on flush_dcache_page() to
> maintain the consistency between I-Cache and D-Cache.  In theory, the
> issue can be found on arm64 and powerpc.

My bad. I have looked at the code closely on arm64 and powerpc.  There
should be no issues since their icache flushing function already considers
the compound pages.  I'll update the commit log in the next version.

> HugeTLB migration is enabled
> on arm, arm64, mips, parisc, powerpc, riscv, s390 and sh, while arm
> has handled the compound page cache flush in flush_dcache_page(), but
> most others do not.  In theory, the issue exists on many architectures.
> Fix this by not using flush_dcache_folio() since it is not backportable.
>
> Fixes: 616b8371539a ("mm: thp: enable thp migration in generic path")

This Fixes tag will be removed in the next version.

> Fixes: 290408d4a250 ("hugetlb: hugepage migration core")
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Reviewed-by: Zi Yan <ziy@nvidia.com>
