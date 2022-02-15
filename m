Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 976F44B79D7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 22:50:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234203AbiBOVij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 16:38:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244467AbiBOVih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 16:38:37 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72106F747E
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 13:38:24 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id m25so9374qka.9
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 13:38:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=J1afD2UuA2twxlw8ZzYufWhFKO6wr/3kutM+ZjyetLk=;
        b=Wcl7oY9fxL+v3oPFd1xJprCDBFPC/SUL0s385FIv9KvKn7xQn+INxXiqJqW1x8EuFK
         7F3FLwEtLULlwb0dFj1iPOckU4U+s4WbW5s2R5XHL24xywKiiuJ50feMlNcrr3xKzU80
         4ckWEYm2nGOh3ZFkrH/7ajWwCHGBfW6v4bdyJLj/PLx6TMItmI6xrQ64wW6XEWUtLkV+
         xoValrFu7CWuxwnvIC3AGYTuWz9HTpBrk2HvxgS/7CEbc67DYyznj9+agowFE6ShYp9R
         yURG3NrplLpz7e9vOZ90uF6zp9+zUhUeGBb81PjGwmUk4HJKYJ3zsddSR9OVYYC1Awu3
         P5wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=J1afD2UuA2twxlw8ZzYufWhFKO6wr/3kutM+ZjyetLk=;
        b=HoEkwA5/nkR1RM3B/gpvGjAQ87Qsm6lCVlukqYC2Ht200pjrpxl3ZDZHTzZuoiJZrJ
         VbBc+MbNAe1CDjkFJ88D23xVNdoLPsD3PrkTGhbD+2QZnnAZvoG+1g/LMsxr+qkOGm8B
         k0QmzNwK8OwW0FWrFyfSQBWdy1mGdn45JXD+6jn0WVgbALFzS3YHETsCP5yp4BeRFGhB
         h+XOOEDF04LL00IcdjbN7dKWlhzYG58TG9pyVuyyTzBQaRusWo4SBMJHQGXBj7GJEeQq
         RFkpkmPYprJ7NK7X88EzA0pXzAA9LfKjBd4sDBXXsQ/4jCS8Gr262/ca6HzmOhGTLS9C
         JuIw==
X-Gm-Message-State: AOAM532PAHc8tK3oF385NmdFMTvd/wMBjN10ASRT66y5Gb5lzTw0ympz
        W0PD2kJ4t8XhQ+v4MONyZi3tKg==
X-Google-Smtp-Source: ABdhPJwSnmcbyCFnLifXS/yn/JrFTpEWFiC13xTSxk+iFYmllr+zSaMVP3leFQFjySBg2IBVEq4+gA==
X-Received: by 2002:ae9:ddc1:: with SMTP id r184mr607603qkf.549.1644961103396;
        Tue, 15 Feb 2022 13:38:23 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id o81sm427231qke.134.2022.02.15.13.38.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 13:38:22 -0800 (PST)
Date:   Tue, 15 Feb 2022 13:38:20 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Matthew Wilcox <willy@infradead.org>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        David Hildenbrand <david@redhat.com>,
        Alistair Popple <apopple@nvidia.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Rik van Riel <riel@surriel.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Yu Zhao <yuzhao@google.com>, Greg Thelen <gthelen@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Yang Li <yang.lee@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 04/13] mm/munlock: rmap call mlock_vma_page()
 munlock_vma_page()
In-Reply-To: <YgvFMjWPITbD1o64@casper.infradead.org>
Message-ID: <3c6097a7-df8c-f39c-36e8-8b5410e76c8a@google.com>
References: <55a49083-37f9-3766-1de9-9feea7428ac@google.com> <501673c-a5a-6c5f-ab65-38545dfb723d@google.com> <YgvFMjWPITbD1o64@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Tue, 15 Feb 2022, Matthew Wilcox wrote:
> On Mon, Feb 14, 2022 at 06:26:39PM -0800, Hugh Dickins wrote:
> > Add vma argument to mlock_vma_page() and munlock_vma_page(), make them
> > inline functions which check (vma->vm_flags & VM_LOCKED) before calling
> > mlock_page() and munlock_page() in mm/mlock.c.
> > 
> > Add bool compound to mlock_vma_page() and munlock_vma_page(): this is
> > because we have understandable difficulty in accounting pte maps of THPs,
> > and if passed a PageHead page, mlock_page() and munlock_page() cannot
> > tell whether it's a pmd map to be counted or a pte map to be ignored.
> > 
> [...]
> > 
> > Mlock accounting on THPs has been hard to define, differed between anon
> > and file, involved PageDoubleMap in some places and not others, required
> > clear_page_mlock() at some points.  Keep it simple now: just count the
> > pmds and ignore the ptes, there is no reason for ptes to undo pmd mlocks.
> 
> How would you suggest we handle the accounting for folios which are
> intermediate in size between PMDs and PTEs?  eg, an order-4 page?
> Would it make sense to increment mlock_count by HUGE_PMD_NR for
> each PMD mapping and by 1 for each PTE mapping?

I think you're asking the wrong question here, but perhaps you've
already decided there's only one satisfactory answer to the right question.

To answer what you've asked: it doesn't matter at all how you count them
in mlock_count, just so long as they are counted up and down consistently.
Since it's simplest just to count 1 in mlock_count for each pmd or pte,
I prefer that (as I did with THPs); but if you prefer to count pmds up
and down by HUGE_PMD_NR, that works too.

Though, reading again, you're asking about a PMD mapping of an order-4
page?  I don't understand how that could be allowed (except on some
non-x86 architecture where the page table fits only 16 pages).

The question I thought you should be asking is about how to count them
in Mlocked.  That's tough; but I take it for granted that you would not
want per-subpage flags and counts involved (or not unless forced to do
so by some regression that turns out to matter).  And I think the only
satisfactory answer is to count the whole compound_nr() as Mlocked
when any part of it (a single pte, a series of ptes, a pmd) is mlocked;
and (try to) move folio to Unevictable whenever any part of it is mlocked.

That differs from what Kirill decided for THPs (which I cannot
confidently describe, but something like count pmd as Mlocked, don't count
ptes as Mlocked, but uncount pmd if any ptes), and what I simplified it to
in the mm/munlock series (count pmd as Mlocked, ignore ptes), and will
tend to show larger numbers for Mlocked than before; but alternatives
seem unworkable to me.

Hugh
