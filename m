Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C78614B78B8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:52:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244138AbiBOUnZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 15:43:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235246AbiBOUnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 15:43:24 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7B40C0853
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 12:43:13 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id x5so256079edd.11
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 12:43:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rYoNECFRoRtax9v4q/DTnJhRR8GgYNqcEGSi/x+S4/4=;
        b=HSGN1Qz3/q4thBI8gOdJ0RT71yBpAQe79qVf9e/dXJwrZk9vf5/5YipxDtEVkP3bmz
         4xQOxbHjEkSKagCovzrIIMLgBW9o4cZuGJ3+boShVcyJVXBfhqFqTafuQtyk3CA5zKv4
         cKMyd2c+H8B/cfHlWx/5R95jHN2aOk5yEVKwCjHt8RjKGR7cxN46wCghPsQLwujqihyF
         fWc6XByXXblP3eeFk65coACYet9qAjRVq6M6RMeqT3cFzInC1PqjqdHBd65WjejtFYgd
         4BYvV1oq4pFFnPAMf+G0zv42wlRYZ4Ax+oeYsMTbEPsdCi+PM0LouLRlAdEgKmdAWqPf
         f3yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rYoNECFRoRtax9v4q/DTnJhRR8GgYNqcEGSi/x+S4/4=;
        b=SOitNGONz1xZT2nMifVr4/3IyUJGxMCQUPUYfumXDsCxGaQ9rmW57W0oVgOaxCDMex
         nB+vk1wtXewI+4vyXzqq2WYtBLBLDxvDyMoNZ2UDZ9auZP+1iZzCFy4Xzftcep7o84Eq
         5MVoLI2UzigT6eIsSidIoFR+Lf/qSrvI/obyBSK2T4x1yiZWOIGkE8yWmhBslymGdO5Y
         D3XwHSwYtpWsZ14FL6X6rk2wuw3NbzfrsMbNienv7U3Fys25wBK5B2E2+P8Hl/9Uw9QD
         X0nOjYlaO35u1PcdWrxS3svgfMWZOHJyucnFkNDo0ekEw0Y4a4wPwlKrHZXKke9O17i0
         2o5A==
X-Gm-Message-State: AOAM533llCgUUtePHu/NrdLn5/Q4U081c4m4Ecs9nYWWsbTOEogtVOJg
        om2T+6Fnj+45o4j7fDoaumG+VdMeHuQlv24saPo=
X-Google-Smtp-Source: ABdhPJyIMhG3qG68E9rODDqrvW4Bq400rqiW0xGzAZedQHNppZXM1A6rToO/9gTqM3ZOBvkciUHhCUwr/coD4jULxmc=
X-Received: by 2002:a05:6402:3492:: with SMTP id v18mr716105edc.345.1644957792512;
 Tue, 15 Feb 2022 12:43:12 -0800 (PST)
MIME-Version: 1.0
References: <20220215201922.1908156-1-surenb@google.com>
In-Reply-To: <20220215201922.1908156-1-surenb@google.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 15 Feb 2022 12:42:59 -0800
Message-ID: <CAHbLzkoeCP-ONBNsDB-y63chxWCZejeQKXg6zc2AAQWCixjxQA@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm: fix use-after-free bug when mm->mmap is reused
 after being freed
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan@kernel.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Andrea Arcangeli <aarcange@redhat.com>, brauner@kernel.org,
        christian@brauner.io, Christoph Hellwig <hch@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Jann Horn <jannh@google.com>,
        Shakeel Butt <shakeelb@google.com>, luto@kernel.org,
        christian.brauner@ubuntu.com, fweimer@redhat.com, jengelh@inai.de,
        timmurray@google.com, Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-team@android.com,
        syzbot+2ccf63a4bd07cf39cab0@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 15, 2022 at 12:19 PM Suren Baghdasaryan <surenb@google.com> wrote:
>
> After exit_mmap frees all vmas in the mm, mm->mmap needs to be reset,
> otherwise it points to a vma that was freed and when reused leads to
> a use-after-free bug.
>
> Reported-by: syzbot+2ccf63a4bd07cf39cab0@syzkaller.appspotmail.com
> Suggested-by: Michal Hocko <mhocko@suse.com>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

Looks good to me. Reviewed-by: Yang Shi <shy828301@gmail.com>

> ---
>  mm/mmap.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 1e8fdb0b51ed..d445c1b9d606 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -3186,6 +3186,7 @@ void exit_mmap(struct mm_struct *mm)
>                 vma = remove_vma(vma);
>                 cond_resched();
>         }
> +       mm->mmap = NULL;
>         mmap_write_unlock(mm);
>         vm_unacct_memory(nr_accounted);
>  }
> --
> 2.35.1.265.g69c8d7142f-goog
>
