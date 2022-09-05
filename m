Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 390505AD908
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 20:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231745AbiIESdD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 14:33:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbiIESdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 14:33:01 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C1EA52805
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 11:33:00 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id d68so7282343iof.11
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 11:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=FNv/KEMtf5XOtkND3AyjhcP/3pLjOBMwZm4O4kjr360=;
        b=i5KCDSUH/dFt94fpjc7Fphku0Tn3reBabaBpFtdU+oRbFh+e8Cx/DMlqQivEg1MZjm
         7FbOvlY6Y9f+9LZ9N+zgTB71z3cagQ2sGfp1oudx0Kv1xpUW6Up8K51vig+01CsmnL3L
         C3xCWMqLQrpYBGvHC0UNi+yNQ6XvxIjh2dsHMNd34BBtJz1xyaPEvWMxsK55kusb2lJe
         FYhU7ADU9KYt1l8KwJpBXu48E1hUBJcr2CIqnesgVXkiai+CuNr/V0a+QqiqySxoUimH
         yIvsq78rMCW0kTv83Fiph1I394+CJ8Hgoqi6ZFAZmMb3pGsqLwLA4vfAoG5DeUW7LJqa
         cUpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=FNv/KEMtf5XOtkND3AyjhcP/3pLjOBMwZm4O4kjr360=;
        b=mQ7S+59FA8Qgp/dZvrlb9nu3nGnKIA2zX/5Q8jAyOEKLiZHnLOBYij7ZHAAiZuN7zo
         NmqFXa2JIjs42V0d+DCn3rRgsJpg24Z63QCWIqNFQen2IRE6VxWnRI/Ys9C72bRaBcoG
         TWIf2orifCA/DotlvKs2R2odFLsGqAWZq87JdjlNVD83n+vVIYQH5nOKXAr8r7NZsDCo
         Oyb1057fCsN70WygDRjk43uE1A2ivVO3KuFAUeQnHONLbH+s5swjiMHmDi/dicQPRDgZ
         UVwCciG5QjLe9e93vAM+N8KDrCQwzSB5+xR/z9dVQ0TsDiedsa3CpHW3gcj/JPGav81W
         1Jog==
X-Gm-Message-State: ACgBeo0GlNVBcX0MyxUl3IyEXI0xUV6aosSPKQ4Bsfg2wT0Ww+QxVEJe
        H/tA53i+ENzZDOkaxyplU0Jw74hIs254ClvBMWr6CQ==
X-Google-Smtp-Source: AA6agR7tgjJDEPLfwwS1LRrijFcmlJFxoiqhAebJjxrWU7CYsmX7SoR6nKTNAJ7nNJVYWRRFlsmMoE7vtwAV8983goQ=
X-Received: by 2002:a02:740b:0:b0:349:bcdd:ca20 with SMTP id
 o11-20020a02740b000000b00349bcddca20mr28183219jac.110.1662402779688; Mon, 05
 Sep 2022 11:32:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220901173516.702122-1-surenb@google.com> <YxXsQKoQ0URIRuKi@dhcp22.suse.cz>
In-Reply-To: <YxXsQKoQ0URIRuKi@dhcp22.suse.cz>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Mon, 5 Sep 2022 11:32:48 -0700
Message-ID: <CAJuCfpG3bMLzNhP5wt8my8j7_9wW=darLegd6WPV6tddtCKGAA@mail.gmail.com>
Subject: Re: [RFC PATCH RESEND 00/28] per-VMA locks proposal
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michel Lespinasse <michel@lespinasse.org>,
        Jerome Glisse <jglisse@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@suse.de>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Matthew Wilcox <willy@infradead.org>,
        "Liam R. Howlett" <liam.howlett@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Laurent Dufour <laurent.dufour@fr.ibm.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Song Liu <songliubraving@fb.com>, Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>, dhowells@redhat.com,
        Hugh Dickins <hughd@google.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Kent Overstreet <kent.overstreet@linux.dev>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Minchan Kim <minchan@google.com>,
        kernel-team <kernel-team@android.com>,
        linux-mm <linux-mm@kvack.org>,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>
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

On Mon, Sep 5, 2022 at 5:32 AM 'Michal Hocko' via kernel-team
<kernel-team@android.com> wrote:
>
> Unless I am missing something, this is not based on the Maple tree
> rewrite, right? Does the change in the data structure makes any
> difference to the approach? I remember discussions at LSFMM where it has
> been pointed out that some issues with the vma tree are considerably
> simpler to handle with the maple tree.

Correct, this does not use the Maple tree yet but once Maple tree
transition happens and it supports RCU-safe lookups, my code in
find_vma_under_rcu() becomes really simple.

>
> On Thu 01-09-22 10:34:48, Suren Baghdasaryan wrote:
> [...]
> > One notable way the implementation deviates from the proposal is the way
> > VMAs are marked as locked. Because during some of mm updates multiple
> > VMAs need to be locked until the end of the update (e.g. vma_merge,
> > split_vma, etc).
>
> I think it would be really helpful to spell out those issues in a greater
> detail. Not everybody is aware of those vma related subtleties.

Ack. I'll expand the description of the cases when multiple VMAs need
to be locked in the same update. The main difficulties are:
1. Multiple VMAs might need to be locked within one
mmap_write_lock/mmap_write_unlock session (will call it an update
transaction).
2. Figuring out when it's safe to unlock a previously locked VMA is
tricky because that might be happening in different functions and at
different call levels.

So, instead of the usual lock/unlock pattern, the proposed solution
marks a VMA as locked and provides an efficient way to:
1. Identify locked VMAs.
2. Unlock all locked VMAs in bulk.

We also postpone unlocking the locked VMAs until the end of the update
transaction, when we do mmap_write_unlock. Potentially this keeps a
VMA locked for longer than is absolutely necessary but it results in a
big reduction of code complexity.

>
> Thanks for working on this Suren!

Thanks for reviewing!
Suren.

> --
> Michal Hocko
> SUSE Labs
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
>
