Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FCCB4A6547
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 21:02:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234977AbiBAUCC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 15:02:02 -0500
Received: from mail-lf1-f51.google.com ([209.85.167.51]:34434 "EHLO
        mail-lf1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234665AbiBAUCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 15:02:01 -0500
Received: by mail-lf1-f51.google.com with SMTP id p27so36203515lfa.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Feb 2022 12:02:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v6FMf2eJSEGsi+8SBS2ozN59klWZb5hsA929bkPzCfQ=;
        b=3goaKCHzZCli4wCk4XslloVJc3hZyx8tpPgqMJ3YOIApe+GmNVTbMqycr1FTAD/NDK
         XXZ7U6RUekEcKbQ5T9YGbtmA6Y9ZT82oPH+pYG8EPXoAhucvPUX2QC/pcljqdLwrCdiC
         6Qiya1izYIjpJcbrIljLX0JdeK5TZW+EfZzWnTy9UBF4QtJc/O+Gj8EFrhVnQy+gXC5n
         ZvuQT5hl77PbB1auZM9IvxZeWdwyFd4d1ghy+x4e86GSuuA1p5FeFLJkDJVAb0169GGl
         KEjbdrYsZuXHUU9KC2hIQk3BHj0fvt1Ruj86Js8F9JVHtbzFQMa1PlCLpJd5T+w9BpjN
         V9Vg==
X-Gm-Message-State: AOAM533z772jQPwAuZfdMUq3kEn2lDKnE+DRbt2g5pvyO5/pklgQUXpD
        m2TOtGeVOa+2ibjxGhmN2tsWVM45tUw3uPOmbfg=
X-Google-Smtp-Source: ABdhPJxZ+JP5tT/NWsTIoeods89D1TOizT7rG3ewudn4gANR5Lwa9gIC1HSqZtkmTA19iuXP/e8pE167RxgYG+r9nk4=
X-Received: by 2002:a05:6512:ba4:: with SMTP id b36mr8717947lfv.481.1643745720259;
 Tue, 01 Feb 2022 12:02:00 -0800 (PST)
MIME-Version: 1.0
References: <20220128203950.3371061-1-namhyung@kernel.org> <2db9fab4-0aff-b8b0-5012-13556ea496af@linux.intel.com>
In-Reply-To: <2db9fab4-0aff-b8b0-5012-13556ea496af@linux.intel.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 1 Feb 2022 12:01:49 -0800
Message-ID: <CAM9d7ciUqaZ02AV4xiknhyAKx0U-4GYKNGJWCa0P=5_CdpxoLg@mail.gmail.com>
Subject: Re: [PATCH 0/3] Handle chroot tasks properly (v1)
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andi,

On Mon, Jan 31, 2022 at 5:16 PM Andi Kleen <ak@linux.intel.com> wrote:
>
>
> On 1/28/2022 12:39 PM, Namhyung Kim wrote:
> > Hello,
> >
> > I found that perf tools don't work well with tasks in a chroot.  The
> > filenames in MMAP record are from the root directory of the task so
> > it's different than what it sees from outside.
>
>
> While that's a real problem, and for chroot it can be fixed, it's much
> more complicated for the more complex container namespace case with
> custom mounts, including loop back, etc.

Probably.  Note that perf tool can handle namespaces (to some extent)
but missed chroot support.  I have a bug report because of this issue.
Let's fix the simple case first.

>
> It seems it really need some kind of agent to handle all cases. For
> example the agent could understand container metadata formats and then
> do the right thing.

Sounds like a good idea for a long term solution.

Thanks,
Namhyung
