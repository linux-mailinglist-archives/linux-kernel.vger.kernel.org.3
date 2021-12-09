Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33D4046F0BC
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 18:07:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233550AbhLIRKp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 12:10:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242353AbhLIRKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 12:10:38 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8975BC061746
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 09:07:04 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id e136so15218334ybc.4
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 09:07:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fas2OWMrEaheu82JOXqt70D3AeQezFvpYTzImSBS/qY=;
        b=gaeFt1NOo2R3rPoTUL4NXG3WetKKF/4voae7kqnSTwu5/Oa54m3cTMAvkdYj3BjXC7
         SSYU+o6eGjvsXbnG/Fiw4C793liazSyIuuFV3JSIb+fNzdpZP8hysLDUoRZ0HPGA0Oig
         8EhwXW73IF+savB0+TtglCxyFS47NWbRtkKwOV4i6dP3KrHAd/nDxF1cWDbvYymgAY6S
         6Sw1JLrIjG0AmJDP0gsrBYtv3z4u/tQTFd9hfpzoSEGlFNLrJip/GlhTqERq/FGKgDI6
         EOAE8Wu2e3TTCD4vdz1YM7A6qHKGLFhq4EnpsUD5gY3bF9HDFR3pTKi8bzTJ8ukwLmcN
         1Ang==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fas2OWMrEaheu82JOXqt70D3AeQezFvpYTzImSBS/qY=;
        b=n7R7EGQZ9z+750Bp+H8mqRCS1PD4fFjQpAlRfKUzmXa4spXvms6HtjBDJEIhJC+H5k
         EHOuusDc+FXdET+u3HNZWGYnow+2lc2GJqVkwFhyeo/fVM6YYCW8IWzII9Cu/D+2T3lI
         lCCoq0BMiDhtyqkBwHCFxXVFS7LaYmPILmCr4CO/OJbTSCcJ4x9rTBYMKanFPf4nkQUY
         8Ui6YaJoSo9h7JB/Q1c+jFGDzXS4zVQZKBwVLswNmqT8NsfcsNzTfd6/yOUNGgHz3WyQ
         YNs2JJa7J56g1GsI0lggYzP6vPvfG6eu83eLrSURrK/LGoagzuCu1W0Whs2KyvcYJ0pI
         dHcQ==
X-Gm-Message-State: AOAM532+zPJJORdYXsBdUR5I5+HRLlsaFS3vJ5ZskkrkjgRnT7XIES2h
        X/P4V2NDKbjmNIV6onHs/rdQT4iLuLMfb5bBvkg9nQ==
X-Google-Smtp-Source: ABdhPJzSDMYSsNJU7k1O7prmBk6Nzch3NJj0ufS7Gs+gRAZosiipYNoXtYSkHAZcAfPmrJJMzr9W8/pf9MOYCMlXntE=
X-Received: by 2002:a25:610d:: with SMTP id v13mr7164166ybb.1.1639069623555;
 Thu, 09 Dec 2021 09:07:03 -0800 (PST)
MIME-Version: 1.0
References: <20211208212211.2860249-1-surenb@google.com> <YbHIaq9a0CtqRulE@dhcp22.suse.cz>
 <CAJuCfpHwNS8RFPF9nzaSB8Br8Jah5_dcnQeatRZp60vmX5n6Vg@mail.gmail.com> <YbIzOR13uPOI5EMB@dhcp22.suse.cz>
In-Reply-To: <YbIzOR13uPOI5EMB@dhcp22.suse.cz>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 9 Dec 2021 09:06:52 -0800
Message-ID: <CAJuCfpHs_25TQ7pHDhPXghA46jmXa5N2OOeBByE-sn+dQ-aM2w@mail.gmail.com>
Subject: Re: [PATCH 4/3] mm: drop MMF_OOM_SKIP from exit_mmap
To:     Michal Hocko <mhocko@suse.com>
Cc:     akpm@linux-foundation.org, rientjes@google.com,
        willy@infradead.org, hannes@cmpxchg.org, guro@fb.com,
        riel@surriel.com, minchan@kernel.org, kirill@shutemov.name,
        aarcange@redhat.com, christian@brauner.io, hch@infradead.org,
        oleg@redhat.com, david@redhat.com, jannh@google.com,
        shakeelb@google.com, luto@kernel.org, christian.brauner@ubuntu.com,
        fweimer@redhat.com, jengelh@inai.de, timmurray@google.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 9, 2021 at 8:47 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Thu 09-12-21 08:24:04, Suren Baghdasaryan wrote:
> > On Thu, Dec 9, 2021 at 1:12 AM Michal Hocko <mhocko@suse.com> wrote:
> > >
> > > Do we want this on top?
> >
> > As we discussed in this thread
> > https://lore.kernel.org/all/YY4snVzZZZYhbigV@dhcp22.suse.cz,
> > __oom_reap_task_mm in exit_mmap allows oom-reaper/process_mrelease to
> > unmap pages in parallel with exit_mmap without blocking each other.
> > Removal of __oom_reap_task_mm from exit_mmap prevents this parallelism
> > and has a negative impact on performance. So the conclusion of that
> > thread I thought was to keep that part. My understanding is that we
> > also wanted to remove MMF_OOM_SKIP as a follow-up patch but
> > __oom_reap_task_mm would stay.
>
> OK, then we were talking past each other, I am afraid. I really wanted
> to get rid of this oom specific stuff from exit_mmap. It was there out
> of necessity. With a proper locking we can finally get rid of the crud.
> As I've said previously oom reaping has never been a hot path.
>
> If we really want to optimize this path then I would much rather see a
> generic solution which would allow to move the write lock down after
> unmap_vmas. That would require oom reaper to be able to handle mlocked
> memory.

Ok, let's work on that and when that's done we can get rid of the oom
stuff in exit_mmap. I'll look into this over the weekend and will
likely be back with questions.
Thanks!

> --
> Michal Hocko
> SUSE Labs
