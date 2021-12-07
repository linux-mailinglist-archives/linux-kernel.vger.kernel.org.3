Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB8146B019
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 02:54:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236479AbhLGB6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 20:58:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236365AbhLGB54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 20:57:56 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50066C0613FE
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 17:54:27 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id z26so15181428iod.10
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 17:54:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8GCfs3UIWYheIdOcXQxitSGok4TtBWFHvnOhGvwh4LU=;
        b=EJPgQEgeubJfZbHmJT+ml4muCB9PM20VpdG8wGJniHE0bGeY3FD0kxAK49lCQDtaN/
         c9RubZAQFKlfJft+x9GcWe2k8R4GLCJw8aC+uWAZujXFa+FQ2OHp6/GVBGyMoeDyOaxh
         YbQgyFIGjS0Kv9cK2z8rBcaH5o950iDBlH4BPFCdBi8Y/z4n6uAQQXyXln5423emXYaY
         WXtWlcablEGXFLzbJzWiKvlmC7bWD756LZ/7FPR/+YyEin0MNq45sHiiSHH3DKg9Bhuu
         IGOkO2r0avMCnseKZx7Gu8jEZ3D5IIVeT0tRml2C3G6f6cRQPz7nqLWuEntfYpz2S1TK
         l2VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8GCfs3UIWYheIdOcXQxitSGok4TtBWFHvnOhGvwh4LU=;
        b=kn+LdAlf9aT3CXgyQaY05lTYXNSIrmKX+/OZahJ0QWHsdpX5hnqNxt6FYc9q5HHKdf
         1rnKl1+wN0Jn8ItksXL0RhQo50i0nL5zD5AnuG6xqmwQWtHjUzrunT7tSvqrDSR/maIw
         SaqemQvNcQhIA7u88qS3+emqZSofqWDnWtsifVrjLKNZOGMJN/l24dswve67kp3rhlOJ
         5IBUcRnfDxKFTJiQUQVAeCiniv4LQbeCK1NKRHmKspfotK1Qg1HjPC7XB8ppXM6FMKAH
         e5UB2wx4WF9D2X6xM/T9s/6OAWhni308swEr2vyShGwB2joCYH3bAuD8itfERANadsuc
         UPuw==
X-Gm-Message-State: AOAM530W8b3XC3aKBJUY62JesxIRHZY+1oIXHM31Tj0oQThZooXZ+amj
        jiy5251JBG1p0zBgpMfshU4C7ecgVw9gCen4s2RPJw==
X-Google-Smtp-Source: ABdhPJyQjwGuVEpanwRxhs05NMKibfDWQCJJpGsPeH8foH3M53khXDQmMTwCV/a+WLqELyEiS/7cVz+m5Tuka3bF1/w=
X-Received: by 2002:a6b:ea0a:: with SMTP id m10mr36636252ioc.91.1638842066584;
 Mon, 06 Dec 2021 17:54:26 -0800 (PST)
MIME-Version: 1.0
References: <20211203065647.2819707-1-keescook@chromium.org>
In-Reply-To: <20211203065647.2819707-1-keescook@chromium.org>
From:   Mina Almasry <almasrymina@google.com>
Date:   Mon, 6 Dec 2021 17:54:15 -0800
Message-ID: <CAHS8izMqjZqK9h42pXaAxfD=Spdwem8PEAgErDhXSBtLBO8eCA@mail.gmail.com>
Subject: Re: [PATCH] hugetlb/cgroup: Fix copy/paste array assignment
To:     Kees Cook <keescook@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 2, 2021 at 10:56 PM Kees Cook <keescook@chromium.org> wrote:
>
> Fix mismatched array assignment, reported by an -Warray-bounds build:
>
> mm/hugetlb_cgroup.c: In function '__hugetlb_cgroup_file_legacy_init':
> mm/hugetlb_cgroup.c:850:35: error: array subscript 8 is above array bounds of 'struct cftype[8]' [-Werror=array-bounds ]
>   850 |         cft = &h->cgroup_files_dfl[8];
>       |                ~~~~~~~~~~~~~~~~~~~^~~
> In file included from mm/hugetlb_cgroup.c:23:
> ./include/linux/hugetlb.h:625:23: note: while referencing 'cgroup_files_dfl'
>   625 |         struct cftype cgroup_files_dfl[8];
>       |                       ^~~~~~~~~~~~~~~~
>
> Fixes: e45f4726bcad ("hugetlb: add hugetlb.*.numa_stat file")
> Signed-off-by: Kees Cook <keescook@chromium.org>

Sorry about that and thanks for the fix!

Reviewed-by: Mina Almasry <almasrymina@google.com>

> ---
>  mm/hugetlb_cgroup.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/hugetlb_cgroup.c b/mm/hugetlb_cgroup.c
> index 9eebe8df3c39..f9942841df18 100644
> --- a/mm/hugetlb_cgroup.c
> +++ b/mm/hugetlb_cgroup.c
> @@ -847,7 +847,7 @@ static void __init __hugetlb_cgroup_file_legacy_init(int idx)
>         cft->read_u64 = hugetlb_cgroup_read_u64;
>
>         /* Add the numa stat file */
> -       cft = &h->cgroup_files_dfl[8];
> +       cft = &h->cgroup_files_legacy[8];
>         snprintf(cft->name, MAX_CFTYPE_NAME, "%s.numa_stat", buf);
>         cft->private = MEMFILE_PRIVATE(idx, 1);
>         cft->seq_show = hugetlb_cgroup_read_numa_stat;
> --
> 2.30.2
>
