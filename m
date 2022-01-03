Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B850448383F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 22:16:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbiACVQl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 16:16:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbiACVQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 16:16:40 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA2B9C061761
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jan 2022 13:16:39 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id i130so31880670qke.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jan 2022 13:16:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=IgE4Y9narcMfazyaDnHrAVWWzxVf/uT3sO6TNKsvhEk=;
        b=L+9pvrMMQyz9fAI+A1ud4equp8na2HiVjvkk6TfkpsLliNR7UJDTyqIMj+r6C+EixK
         VLnE6F5Md0rdSyvuu5MTVir9w2RYcnHwkjfalZg9BVNjoA6saj9PJttQU6XOJbnnDLIc
         4zMNAQ/3NXi0Vv8M+bTf/6/BNA6JTZ+p1+zKG9SOVQA0+GRq9mJUXubC8oX5HwTajHUG
         ILN+7eUpHynbuN7jESnbFKwDVoZ8RY+zMmnthxcq0SVpcD0zJl6XNnX9ra5Mt8wkqhXd
         Y0UXcjPxi7oHVlBZsFuCtrgbY3hQJUHvIpfCxVSI/Wa9ZaaINQjN5fPNOhHNjlSyLqzJ
         Zrtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=IgE4Y9narcMfazyaDnHrAVWWzxVf/uT3sO6TNKsvhEk=;
        b=H11PIOJd/0d9AlCgCmbgqhsUtHOWy350UdBsiLvKUZlXbLgRFCzWKolpmp+uepBUHH
         LJTof+//jdiy5mQ39tT7WaOdgBfXbzywfSGgnP7HSqOjK9GagUD9m015DMnl/NQv0IXI
         L0+7LqbRjutdb90RZMTJ3qrY/GwgMJpurw7ukCQvB4dFSWijXYQ98hI7QezNVxypYQiU
         B8jdSlFrpmv7JzkT58Bsh48xEOgavpMXmSni+3J6RXCa+SQf1U0Sw0Ke/fsLcAWSdKZ7
         oeIYz5Jc6JaZrxWEwVGNzw03s2VjgVPHWVtGcKrl5NaZ4QpSoHUcU3Y/+IfGN3thU+70
         NZqA==
X-Gm-Message-State: AOAM533YHOiD59R0jwhnxuQQUBk2YafwyHPnu1VdYcS+gUrY79W0k6UA
        ay/6a3tujxwtAKb7BNEjjJq5Wg==
X-Google-Smtp-Source: ABdhPJxqVMRiiuHjyxINWD3rKKMpOEq4qSwUnWdLV54j60eUkY1UFaDK5GfWaHoLSKvVpSO1apDkGQ==
X-Received: by 2002:a37:790:: with SMTP id 138mr33314462qkh.638.1641244598895;
        Mon, 03 Jan 2022 13:16:38 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id b2sm28272827qtq.95.2022.01.03.13.16.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jan 2022 13:16:37 -0800 (PST)
Date:   Mon, 3 Jan 2022 13:16:21 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Michal Hocko <mhocko@suse.com>
cc:     Suren Baghdasaryan <surenb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Roman Gushchin <guro@fb.com>, Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan@kernel.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Christian Brauner <christian@brauner.io>,
        Christoph Hellwig <hch@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Jann Horn <jannh@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Florian Weimer <fweimer@redhat.com>,
        Jan Engelhardt <jengelh@inai.de>,
        Tim Murray <timmurray@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>
Subject: Re: [PATCH 4/3] mm: drop MMF_OOM_SKIP from exit_mmap
In-Reply-To: <YdLn+192/0HfNJyl@dhcp22.suse.cz>
Message-ID: <35c340a6-96f-28a0-2b7b-2f9fbddc01f@google.com>
References: <YbHIaq9a0CtqRulE@dhcp22.suse.cz> <CAJuCfpHwNS8RFPF9nzaSB8Br8Jah5_dcnQeatRZp60vmX5n6Vg@mail.gmail.com> <YbIzOR13uPOI5EMB@dhcp22.suse.cz> <CAJuCfpHs_25TQ7pHDhPXghA46jmXa5N2OOeBByE-sn+dQ-aM2w@mail.gmail.com> <CAJuCfpHZOojVXCDXPOA7kgrZqNWw_BzRmbKQXz3FOCHwa-LopQ@mail.gmail.com>
 <Ybsn2hJZXRofwuv+@cmpxchg.org> <CAJuCfpGMTcyVikNrQR7Y1E54JAjgs5zFBry=DTDidJmD1YWpUg@mail.gmail.com> <CAJuCfpEHJTqG+PkAPJknf5_41ZKFqjk8pY=gTg_VZgsfY-=9Tg@mail.gmail.com> <Yc1spBeXal373b4A@dhcp22.suse.cz> <CAJuCfpGNCX=Z=Bi0N7DAj=CXdLqJOqQ_8kq_HQNaLhAvA5tjPw@mail.gmail.com>
 <YdLn+192/0HfNJyl@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Jan 2022, Michal Hocko wrote:
> On Thu 30-12-21 09:29:40, Suren Baghdasaryan wrote:
> > On Thu, Dec 30, 2021 at 12:24 AM Michal Hocko <mhocko@suse.com> wrote:
> > >
> > > It would be really great to make unlock_range oom reaper aware IMHO.
> > 
> > What exactly do you envision? Say unlock_range() knows that it's
> > racing with __oom_reap_task_mm() and that calling follow_page() is
> > unsafe without locking, what should it do?
> 
> My original plan was to make the page lock conditional and use
> trylocking from the oom reaper (aka lockless context). It is OK to
> simply bail out and leave some mlocked memory behind if there is a
> contention on a specific page. The overall objective is to free as much
> memory as possible, not all of it.
> 
> IIRC Hugh was not a fan of this approach and he has mentioned that the
> lock might not be even really needed and that the area would benefit
> from a clean up rather than oom reaper specific hacks. I do tend to
> agree with that. I just never managed to find any spare time for that
> though and heavily mlocked oom victims tend to be really rare.

I forget when that was, and what I had in mind at that time.
But yes, by now I am very sure that munlocking needs a cleanup.

And I do have that cleanup (against a much older tree), but never
the time to rebase or post or shepherd it through N revisions.

It was 22 files changed, 464 insertions, 706 deletions:
which is too much to help with this immediate oom reaper question.

I'd better not drive this discussion further off-course; but it pains
me to see munlock_vma_pages obstructing, knowing there's a better way.

I wonder: what if I were to steal time and promise to post a
rebased series against 5.17-rc1 or rc2: not support it thereafter,
but might there be someone to pick it up and shepherd it through?
But there's no answer to that, without you seeing what it's like.

Hugh
