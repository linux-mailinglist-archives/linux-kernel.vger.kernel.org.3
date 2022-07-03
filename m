Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 199E4564A96
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 01:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232515AbiGCXbt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 19:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbiGCXbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 19:31:47 -0400
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 607FF60CE
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jul 2022 16:31:46 -0700 (PDT)
Received: by mail-ua1-x92c.google.com with SMTP id l27so2836839uac.10
        for <linux-kernel@vger.kernel.org>; Sun, 03 Jul 2022 16:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oEO3ZAtLSmva9cTvHxOfhLeXKa0Sb2FJy/TH2IplwFs=;
        b=q/yp860yzduw4091UcB3dvkiF4QIOV88L50p9WNSsr9wL+Mm2O5PiqyAB6AgL90g2L
         BVOpVsgPvXDONubZ1BlEa3gMuNwCqz0oPE+DC8wKAvtGTRlqAu6cVduLJdFYpyWMOiNz
         6TZlyML+IEjtvvw8F+Yq39ApNjedtHU+RYtbpd/P0mG6kwwtsxkIi0GnQ4IDBwRXRvDs
         Ek6Qb3S9Jo7aVpqofJ8XCvPrPpkCpcVutBA9gmh2Lq3SgOaaSnTTDZEAw2Z2cQXYRjN0
         9EyPvg7W6HbOu4zHzVRoIo7Hety1a1/dlsmjZT2Af56XDHUF/TyDDbFZp9Qee6CnZNjr
         sq1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oEO3ZAtLSmva9cTvHxOfhLeXKa0Sb2FJy/TH2IplwFs=;
        b=UEe1VJZKYmQ0BUqqE9zMxqFHUDEuaVtqqd5NGmOrHV4euTGVBRHD8SjIO+zi1e4BMR
         SXhdJ9GhpzmRvKxaPcgvoZqcEtCg0ykb5BXbiwLOOkb8DdmmjipZ3QndnVQhZoAFG8E6
         4eaBFYoYizXgOTbQ9OOu4B/ezvxx2P78N6zUyJ/2XydjlBkzeQfV8f7qhsgmoP4v5Ilv
         CLgbb9UCt8APTNCdFt/ioYxYB34+1du0aPcyzfnjfIdg9Pxk7VPrz90xlj9yP0I4oWqH
         tEPVDJA9SzPL7/GGSF3oLIBzVmZLXiCjAlL9EnnRknWo8FxMqDL0IuSNYVAyFbN0s8sE
         g7LQ==
X-Gm-Message-State: AJIora+SGmJzoEvu0nuTmyXGdwSyRh5OwGKfVnvKZaRYuevq+qEj5AyD
        LOneiDuReeZNSTiMTuq57Nw2vLBN+2v9kbpFCz7PQg==
X-Google-Smtp-Source: AGRyM1tYVib0ciKdPLNgy5ux8YG1sr2MoZkycIznHFQlzrvfkvyDn+EngC17+CZieedxeMjYrvqjKxzk3obkgg42m1w=
X-Received: by 2002:ab0:7085:0:b0:382:9454:962 with SMTP id
 m5-20020ab07085000000b0038294540962mr534399ual.113.1656891105246; Sun, 03 Jul
 2022 16:31:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220624125423.6126-1-mgorman@techsingularity.net> <20220703162821.f097d6e4b3e2a0114820a8d9@linux-foundation.org>
In-Reply-To: <20220703162821.f097d6e4b3e2a0114820a8d9@linux-foundation.org>
From:   Yu Zhao <yuzhao@google.com>
Date:   Sun, 3 Jul 2022 17:31:09 -0600
Message-ID: <CAOUHufZj87ewG6_OObmDByxHv51DgbkB-O6oMitw72QF1JrkcQ@mail.gmail.com>
Subject: Re: [PATCH v5 00/7] Drain remote per-cpu directly
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
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

On Sun, Jul 3, 2022 at 5:28 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Fri, 24 Jun 2022 13:54:16 +0100 Mel Gorman <mgorman@techsingularity.net> wrote:
>
> > Some setups, notably NOHZ_FULL CPUs, may be running realtime or
> > latency-sensitive applications that cannot tolerate interference due to
> > per-cpu drain work queued by __drain_all_pages().  Introduce a new
> > mechanism to remotely drain the per-cpu lists. It is made possible by
> > remotely locking 'struct per_cpu_pages' new per-cpu spinlocks.  This has
> > two advantages, the time to drain is more predictable and other unrelated
> > tasks are not interrupted.
> >
> > This series has the same intent as Nicolas' series "mm/page_alloc: Remote
> > per-cpu lists drain support" -- avoid interference of a high priority task
> > due to a workqueue item draining per-cpu page lists.  While many workloads
> > can tolerate a brief interruption, it may cause a real-time task running
> > on a NOHZ_FULL CPU to miss a deadline and at minimum, the draining is
> > non-deterministic.
> >
> > Currently an IRQ-safe local_lock protects the page allocator per-cpu
> > lists. The local_lock on its own prevents migration and the IRQ disabling
> > protects from corruption due to an interrupt arriving while a page
> > allocation is in progress.
> >
> > This series adjusts the locking.  A spinlock is added to struct
> > per_cpu_pages to protect the list contents while local_lock_irq is
> > ultimately replaced by just the spinlock in the final patch.  This allows
> > a remote CPU to safely. Follow-on work should allow the spin_lock_irqsave
> > to be converted to spin_lock to avoid IRQs being disabled/enabled in
> > most cases. The follow-on patch will be one kernel release later as it
> > is relatively high risk and it'll make bisections more clear if there
> > are any problems.
>
> I plan to move this and Mel's fix to [7/7] into mm-stable around July 8.

I've thrown it together with the Maple Tree and passed a series of stress tests.
