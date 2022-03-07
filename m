Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E66EB4D052C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 18:24:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244422AbiCGRZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 12:25:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233824AbiCGRZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 12:25:44 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 957543FDAD
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 09:24:49 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id z30so19579985ybi.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 09:24:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EGPJ/HBGsghMSfv75dZ55E/modOMRbB4DgUrUtGerYI=;
        b=BPGMtJYOuDSup6ABrw63zKcQcdaRgQA28roFUUiDE807kSYNqXhfS2fkGGTzyBFsTe
         F7BEDShNKTtwy5KDDWo6TLRvUqgxfEOtx4cZDhJkFz7oTxuMTLc5Kba6O8bDjgs/YsoB
         7h2w1k2h+AiczCsVtTzQCizj2ANjF8U3HRfZskUj76Zanf1ydCjILKRbKreFyLrj/wUD
         GhXrPD/s5TFIXs51Z4QgAzQBNZ1F4WVnSwnYfTQkdV4e3tNdIftuS1awIlqbGWIu1u2d
         jUxb+5k0gPlSrAi91wdKchwdLqqs8GJdBEDPH96yWEVSre6gSYOR+2UzAi9BIrErYjQ1
         FNmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EGPJ/HBGsghMSfv75dZ55E/modOMRbB4DgUrUtGerYI=;
        b=C9tc3V0eDA51Rf4aD561Umy64KLHcCnRRZAixXbxa0MfIpDsLV4TSsjISsm97DVhCs
         4QHpD4Pi63vgWU/84IGAJnXvG/LOiUzKNTbgEIjXm5aZ/hegU6KwUc/q0/18NKnWRC5M
         FnpkFE6QgFLVKccB8Znig9cgaxYhBFh6+B7OepJCpEZze0F5ifiCOJeocNIMchq9vgjT
         4WesVWXaS4HWIf0f6G97gj8TXk2BfJ4wzBxtc/ntDDcqivcfkmJrYL/VaoHqxhaX3xB3
         +U5cTSgAGIXKzi1m6GWyGP7Z5nv50WURSSumSN5he2ehDoZwIZ+f9pHhJiCRzPSzIdLe
         3KUQ==
X-Gm-Message-State: AOAM533GrXRJFaQlvP/jwQkJMXXKulcesXNjRbby13w3iWBVs7I73HpG
        OqmxucUMKeiQXd9yuyPGs09vA78gqw/jT7Zzy7cCDA==
X-Google-Smtp-Source: ABdhPJyfn/Hihw6wCA/9To+ztHYEtcwYnDPnZ6vIdFqOoNI/1L+jjcZSq765aEYJ1Zq8fTaKXLdyJxjMvZ5NhfFZi44=
X-Received: by 2002:a25:2bc5:0:b0:628:71cf:99c with SMTP id
 r188-20020a252bc5000000b0062871cf099cmr8836283ybr.553.1646673888520; Mon, 07
 Mar 2022 09:24:48 -0800 (PST)
MIME-Version: 1.0
References: <20220225012819.1807147-1-surenb@google.com> <YiY7K4ftAI3t6km8@dhcp22.suse.cz>
In-Reply-To: <YiY7K4ftAI3t6km8@dhcp22.suse.cz>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Mon, 7 Mar 2022 09:24:37 -0800
Message-ID: <CAJuCfpEt6V+v_FcLsYWpGLA1vwCK01vv0PqNernfKM2GTzNqKg@mail.gmail.com>
Subject: Re: [RFC 1/1] mm: page_alloc: replace mm_percpu_wq with kthreads in drain_all_pages
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Petr Mladek <pmladek@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Tim Murray <timmurray@google.com>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 7, 2022 at 9:04 AM 'Michal Hocko' via kernel-team
<kernel-team@android.com> wrote:
>
> On Thu 24-02-22 17:28:19, Suren Baghdasaryan wrote:
> > Sending as an RFC to confirm if this is the right direction and to
> > clarify if other tasks currently executed on mm_percpu_wq should be
> > also moved to kthreads. The patch seems stable in testing but I want
> > to collect more performance data before submitting a non-RFC version.
> >
> >
> > Currently drain_all_pages uses mm_percpu_wq to drain pages from pcp
> > list during direct reclaim. The tasks on a workqueue can be delayed
> > by other tasks in the workqueues using the same per-cpu worker pool.
> > This results in sizable delays in drain_all_pages when cpus are highly
> > contended.
>
> This is not about cpus being highly contended. It is about too much work
> on the WQ context.

Ack.

>
> > Memory management operations designed to relieve memory pressure should
> > not be allowed to block by other tasks, especially if the task in direct
> > reclaim has higher priority than the blocking tasks.
>
> Agreed here.
>
> > Replace the usage of mm_percpu_wq with per-cpu low priority FIFO
> > kthreads to execute draining tasks.
>
> This looks like a natural thing to do when WQ context is not suitable
> but I am not sure the additional resources is really justified. Large
> machines with a lot of cpus would create a lot of kernel threads. Can we
> do better than that?
>
> Would it be possible to have fewer workers (e.g. 1 or one per numa node)
> and it would perform the work on a dedicated cpu by changing its
> affinity? Or would that introduce an unacceptable overhead?

Not sure but I can try implementing per-node kthreads and measure the
performance of the reclaim path, comparing with the current and with
per-cpu approach.

>
> Or would it be possible to update the existing WQ code to use rescuer
> well before the WQ is completely clogged?
> --
> Michal Hocko
> SUSE Labs
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
>
