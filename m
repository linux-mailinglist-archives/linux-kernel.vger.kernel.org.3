Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1B0850F0F7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 08:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245227AbiDZGdf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 02:33:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245102AbiDZGdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 02:33:22 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED702617F
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 23:30:15 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id y76so1892151ybe.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 23:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xk1fRrXwMY49fkEklzghzXkAbwf3cL6niuJY5FykJaY=;
        b=XKpip720WjbGzHfP5YW9gSB8hFdf4hNkRtU+Adgc2GptypWuimrKfm4d/jTk1AJN2S
         wvD9Q6Sle0BhWy7kUbqvV8S9J14hP2H7Xf0KqXsQ5ogF+LBDqfcEYPCdNRdqYphLhYst
         22mhzSuTfN0lo3t2tx9A3sGF+U1uEyp9clr9Xx3jpUbJiTz+16DdaivMegtOh6JHgpou
         X1AELsmWoTmVvYVEFo3ay4KIKBVJs94KXqylK86UsUPhaTfWV1lgeshVI4fyRf3mURus
         SOGA0Snj1/dFaXKuZs3n2+NlRmHfLxPyes/tTiY6eQBGZM5hOAjIUScfKhZrHCgCDqiq
         8mHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xk1fRrXwMY49fkEklzghzXkAbwf3cL6niuJY5FykJaY=;
        b=prOERVXfwZFreAtj4zwtsTZumAQievtT0IW3iwOLU1XQ5ENn/9LBbqpXwbiiDeVqnr
         Wr6OROL8G1nmVD/wkpnvQEIYT8ioZ8PkgoDDQuyxftIsNIwQqBU3Jw0LWZHBddKxiMGg
         m36o4SDc4aNIgX53pVFa0XgbhV7PjIRKbG2KZgHONXNe9NYROfpFc9aomRE63awq1Sx+
         g9wkhdjZpV4kCCt6uK3bSnWYEmTwRUC4Rh1jsPD54AIy3dRydc51ZPmhsJDLMz9+jdcu
         UnqV1JmdCjOkwFwLjzuRLGH5sJB4/1jGeCLiMxGP5mN7LpcCd3kwG3/JlBPULh0Ri/I0
         Ue2A==
X-Gm-Message-State: AOAM531cy/tuo+KnCr9Bj6S2wGw89J4KeG6h4gAKBMXEfEYcjVO+4Qgo
        odow2vbc+6VanjisN7PYig1WhGO2fgi1pQSqzHi8mexjTnViog==
X-Google-Smtp-Source: ABdhPJxb4B+LcT0jivCZF2yrHw8bSTLtmXMFcK6VBuul7ICiYr9UHhwQS8Dhk2Q4vrNahhA+41kQRQ5ZuNsamNIR9Ec=
X-Received: by 2002:a05:6902:1242:b0:644:c30c:cfcc with SMTP id
 t2-20020a056902124200b00644c30ccfccmr18900379ybu.509.1650954614961; Mon, 25
 Apr 2022 23:30:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220420095906.27349-1-mgorman@techsingularity.net> <CAJuCfpH=U9E-46wZgKEYQZVKjw=2qq_KXDRF=tqDBvqpR+BBbg@mail.gmail.com>
In-Reply-To: <CAJuCfpH=U9E-46wZgKEYQZVKjw=2qq_KXDRF=tqDBvqpR+BBbg@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Mon, 25 Apr 2022 23:30:03 -0700
Message-ID: <CAJuCfpG6fU-AfB+_RfRHwq8-i3=H4RF5UmHeuH+70xz8m61k9g@mail.gmail.com>
Subject: Re: [RFC PATCH 0/6] Drain remote per-cpu directly
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2022 at 7:49 PM Suren Baghdasaryan <surenb@google.com> wrote:
>
> On Wed, Apr 20, 2022 at 2:59 AM Mel Gorman <mgorman@techsingularity.net> wrote:
> >
> > This series has the same intent as Nicolas' series "mm/page_alloc: Remote
> > per-cpu lists drain support" -- avoid interference of a high priority
> > task due to a workqueue item draining per-cpu page lists. While many
> > workloads can tolerate a brief interruption, it may be cause a real-time
> > task runnning on a NOHZ_FULL CPU to miss a deadline and at minimum,
> > the draining in non-deterministic.
> >
> > Currently an IRQ-safe local_lock protects the page allocator per-cpu lists.
> > The local_lock on its own prevents migration and the IRQ disabling protects
> > from corruption due to an interrupt arriving while a page allocation is
> > in progress. The locking is inherently unsafe for remote access unless
> > the CPU is hot-removed.
> >
> > This series adjusts the locking. A spin-lock is added to struct
> > per_cpu_pages to protect the list contents while local_lock_irq continues
> > to prevent migration and IRQ reentry. This allows a remote CPU to safely
> > drain a remote per-cpu list.
> >
> > This series is a partial series. Follow-on work would allow the
> > local_irq_save to be converted to a local_irq to avoid IRQs being
> > disabled/enabled in most cases. However, there are enough corner cases
> > that it deserves a series on its own separated by one kernel release and
> > the priority right now is to avoid interference of high priority tasks.
> >
> > Patch 1 is a cosmetic patch to clarify when page->lru is storing buddy pages
> >         and when it is storing per-cpu pages.
> >
> > Patch 2 shrinks per_cpu_pages to make room for a spin lock. Strictly speaking
> >         this is not necessary but it avoids per_cpu_pages consuming another
> >         cache line.
> >
> > Patch 3 is a preparation patch to avoid code duplication.
> >
> > Patch 4 is a simple micro-optimisation that improves code flow necessary for
> >         a later patch to avoid code duplication.
> >
> > Patch 5 uses a spin_lock to protect the per_cpu_pages contents while still
> >         relying on local_lock to prevent migration, stabilise the pcp
> >         lookup and prevent IRQ reentrancy.
> >
> > Patch 6 remote drains per-cpu pages directly instead of using a workqueue.
>
> This quite possibly solves the issue I was trying to fix in
> https://lore.kernel.org/all/20220225012819.1807147-1-surenb@google.com.
> I will give it a try and see how it looks.

My test shows sizable improvement for the worst case drain_all_pages
duration. Before the change I caught cases when a drain_local_pages_wq
in the workqueue was delayed by 100+ms (not even counting
drain_local_pages_wq execution time itself). With this patchset the
worst time I was able to record for drain_all_pages duration was 17ms.

> Thanks!
>
> >
> >  include/linux/mm_types.h |   5 +
> >  include/linux/mmzone.h   |  12 +-
> >  mm/page_alloc.c          | 333 ++++++++++++++++++++++++---------------
> >  3 files changed, 222 insertions(+), 128 deletions(-)
> >
> > --
> > 2.34.1
> >
> >
