Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 262CF47CC76
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 06:23:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232045AbhLVFW7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 00:22:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbhLVFW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 00:22:58 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E588C061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 21:22:57 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id b19so1841095ljr.12
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 21:22:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EHKD0zz0A17naK/vAZ2p+fvykUPrLdG+ZC/fRc2M8Rk=;
        b=RgtzbRu1yhWdXkg5X6WGFXigULqaULk18s9V4nZYjsURhJ5trBAGr2z4/USfLOjAay
         fu/VJ/8RERdZTu+MHkGuXlmjOsLTgtNizjOC3O0pnOcDxbx0CfPtrxABMO03fN+L5iug
         b+q8qwF3JuzTrU2U+qYxRBzHd4+fzJK5yH0jp1s3keJET0weBQ5VqGgPcs3l/1T+JETo
         t4C5oOhYg62xLdLOBk0uOWwX0PmHM11YWxkh30xMFCNi7frpdsZkjT8UjdIVXPmJe5g7
         AveMIMyQZ756dicvMPvOvITZt4hbItsMcKj6bgPZcFFxC0mYzHyP1nj6QsuEsj6/tvkI
         qocA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EHKD0zz0A17naK/vAZ2p+fvykUPrLdG+ZC/fRc2M8Rk=;
        b=AdQGImejvBYbckX2iDYlYZkJkNLjfi3KXLSHG4xwhphxpQdrkvg31M6eRvq5xm6QR5
         irkVB+xAmjY2jS5TZMDxJ06+tM+wssC4LxlOkJOBFvQTqnN/LHFoRe8dL8KeVkS8ZcQ4
         0MiP1u/BOgv+BERzNZLYQmLR6w10acotkfOCWVmJ1kRTnoRpQPUUIfr8YteWA86wuM/v
         c3/ZpyXp4Zbf5BTCvzx7wgCkIA5jv/PvhHQesS8FR4D/5yh7XwvHTNMziiVSHlhf5FCh
         8yvsyWYRtc1fVgcKge449wz/j8w2zaJDy0NqfkTACU/s+sHNDqSYjlHaDMRXqIby6nTq
         4P5g==
X-Gm-Message-State: AOAM530s2TEo4es95wONYF2tS/+PitPnm7mixQI6eg7PMOT6YOxq2dlY
        1F9g/ytP/O6tg7QYgU8sqihtkbJO4hQVg1dNAAVKIPgLc9g=
X-Google-Smtp-Source: ABdhPJxHLPnFrFhk4CFndt8TB4F2p8chAbA4z7J9E5E8t/rD5nNLWBr2GeHEkLtXMA025lY3mvreAmjg/X8R4nTlVuM=
X-Received: by 2002:a2e:a314:: with SMTP id l20mr1186583lje.86.1640150575496;
 Tue, 21 Dec 2021 21:22:55 -0800 (PST)
MIME-Version: 1.0
References: <20211221215336.1922823-1-shakeelb@google.com> <CAMZfGtVddf8Zqk2rvbb4VXpsOB-hXxeXfkjT3GVQJGc2W_qyGg@mail.gmail.com>
In-Reply-To: <CAMZfGtVddf8Zqk2rvbb4VXpsOB-hXxeXfkjT3GVQJGc2W_qyGg@mail.gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 21 Dec 2021 21:22:43 -0800
Message-ID: <CALvZod45V_1RaZ2t27VNYFZorR-WoO=Q3_pvY0UOoK0bgyL2ew@mail.gmail.com>
Subject: Re: [PATCH] memcg: add per-memcg vmalloc stat
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 21, 2021 at 8:15 PM Muchun Song <songmuchun@bytedance.com> wrote:
>
[...]
> > +static inline void mod_memcg_page_state(struct page *page,
> > +                                       int idx, int val)
> > +{
> > +       struct mem_cgroup *memcg = page_memcg(page);
> > +
> > +       if (!mem_cgroup_disabled() && memcg)
> > +               mod_memcg_state(memcg, idx, val);
>
> It's not safe to access @memcg throughout mod_memcg_state() for the
> kmem charged through objcg infrastructure. It's supposed to be safe
> to access @memcg under rcu read lock. Otherwise, it looks good to
> me.

Indeed you are right. v2 coming.
