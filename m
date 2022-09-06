Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0F9D5AF035
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 18:19:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232644AbiIFQTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 12:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233857AbiIFQRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 12:17:39 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1696E844C2
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 08:46:40 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id z72so9208701iof.12
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 08:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=01CsnEEQfLK1uOpVQ+HH6686vEI9WQZhnhn7tltGMc4=;
        b=o7ZUoR1kIbCZSNNyLbvrwwtPxnTYEllaZY9cFNDDCCA7TAcp0hkIs2NMKLazX0j/Wb
         AWxxBk+k5G23dVl64yevMX+VdSw/FzkljOCmS/xASd595atoUnaTjkJmrmR9WjiCsxKE
         VuyYGhKnfagDzQZ6sGO0kr/wninknslufsnoLThmyJZSuYTU38KSG2qsTZT0WtI8/TFp
         LX/qK2c50VdG2SVsnEj1+xTC+UMWubZMyMO7uNilERQu9uv4D2aQqwP7+M8bGR8KWyFm
         OnnkvtEInWpmkIYk4qBKTNg02wGwVlJLJMtpY5HIQ1/Z8WKMbLgAbK2PJvysrvsqnBR+
         epoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=01CsnEEQfLK1uOpVQ+HH6686vEI9WQZhnhn7tltGMc4=;
        b=C3Vn3AlmOaG8kCaSHI504DahtzONfrySvP11EhrzZBvNKbUXsPHuBuhBabFwT3qwzW
         kH7DfbPCjTo0nyLrYxN1mRlOtf8hUdTFOsxQ7y3DGljgxzW0RxcK2Y+20JjgoX1/r879
         92YicEu0MxuauuC3Y6H1zCx/x290yEFH9SDKm4Hbe4Q2HM4mcqE7s49c4yzLNWEyj7C1
         1wnUOU7y/6dQdll52N3+t+OtjF75Z97hiqynbK7EPLEIw5rBNBwDGrGg3joGDw1d/0LP
         5cU3O+RkZKgwJZN6RBzM55C0Gs2BwZ6VwVPsOSTzLZSUDiYYctkMOOEwL/AkEWX0eTR3
         IEMA==
X-Gm-Message-State: ACgBeo3fO/MzFJ98j5rhnR3c2K4C0jZpByJjIIW1TJkxhVEIZeXfVX0p
        2rC52KQ5Ae9c29BilnUmKHhsVua7pLDWpjJkaCrThg==
X-Google-Smtp-Source: AA6agR4npg7xYhO3jV9bPgCe/qZLaBiwpkb5NlSVTaZJNdUAJnVvwtlRJpA1bjafBWAWUuAzLEiUFw/4MgDT30cQhzs=
X-Received: by 2002:a05:6638:1492:b0:34c:d42:ac2f with SMTP id
 j18-20020a056638149200b0034c0d42ac2fmr16182031jak.305.1662479199238; Tue, 06
 Sep 2022 08:46:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220901173516.702122-1-surenb@google.com> <YxXsQKoQ0URIRuKi@dhcp22.suse.cz>
 <CAJuCfpG3bMLzNhP5wt8my8j7_9wW=darLegd6WPV6tddtCKGAA@mail.gmail.com> <20220905203503.tqtr36fsfg4guk4j@moria.home.lan>
In-Reply-To: <20220905203503.tqtr36fsfg4guk4j@moria.home.lan>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 6 Sep 2022 08:46:28 -0700
Message-ID: <CAJuCfpF+mmDSsUT87HmXNhpoN=dzpxxx6S9RF8H6uz12hc2bJg@mail.gmail.com>
Subject: Re: [RFC PATCH RESEND 00/28] per-VMA locks proposal
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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

On Mon, Sep 5, 2022 at 1:35 PM Kent Overstreet
<kent.overstreet@linux.dev> wrote:
>
> On Mon, Sep 05, 2022 at 11:32:48AM -0700, Suren Baghdasaryan wrote:
> > On Mon, Sep 5, 2022 at 5:32 AM 'Michal Hocko' via kernel-team
> > <kernel-team@android.com> wrote:
> > >
> > > Unless I am missing something, this is not based on the Maple tree
> > > rewrite, right? Does the change in the data structure makes any
> > > difference to the approach? I remember discussions at LSFMM where it has
> > > been pointed out that some issues with the vma tree are considerably
> > > simpler to handle with the maple tree.
> >
> > Correct, this does not use the Maple tree yet but once Maple tree
> > transition happens and it supports RCU-safe lookups, my code in
> > find_vma_under_rcu() becomes really simple.
> >
> > >
> > > On Thu 01-09-22 10:34:48, Suren Baghdasaryan wrote:
> > > [...]
> > > > One notable way the implementation deviates from the proposal is the way
> > > > VMAs are marked as locked. Because during some of mm updates multiple
> > > > VMAs need to be locked until the end of the update (e.g. vma_merge,
> > > > split_vma, etc).
> > >
> > > I think it would be really helpful to spell out those issues in a greater
> > > detail. Not everybody is aware of those vma related subtleties.
> >
> > Ack. I'll expand the description of the cases when multiple VMAs need
> > to be locked in the same update. The main difficulties are:
> > 1. Multiple VMAs might need to be locked within one
> > mmap_write_lock/mmap_write_unlock session (will call it an update
> > transaction).
> > 2. Figuring out when it's safe to unlock a previously locked VMA is
> > tricky because that might be happening in different functions and at
> > different call levels.
> >
> > So, instead of the usual lock/unlock pattern, the proposed solution
> > marks a VMA as locked and provides an efficient way to:
> > 1. Identify locked VMAs.
> > 2. Unlock all locked VMAs in bulk.
> >
> > We also postpone unlocking the locked VMAs until the end of the update
> > transaction, when we do mmap_write_unlock. Potentially this keeps a
> > VMA locked for longer than is absolutely necessary but it results in a
> > big reduction of code complexity.
>
> Correct me if I'm wrong, but it looks like any time multiple VMAs need to be
> locked we need mmap_lock anyways, which is what makes your approach so sweet.

That is correct. Anytime we need to take VMA's write lock we have to
be holding the write side of the mmap_lock as well. That's what allows
me to skip locking in cases like checking if the VMA is already
locked.

>
> If however we ever want to lock multiple VMAs without taking mmap_lock, then
> deadlock avoidance algorithms aren't that bad - there's the ww_mutex approach,
> which is simple and works well when there isn't much expected contention (the
> advantage of the ww_mutex approach is that it doesn't have to track all held
> locks). I've also written full cycle detection; that approcah gets you fewer
> restarts, at the cost of needing a list of all currently held locks.

Thanks for the tip! I'll take a closer look at ww_mutex.

>
> --
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
>
