Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B579483902
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 00:24:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230467AbiACXY0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 18:24:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbiACXY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 18:24:26 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6F1BC061761
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jan 2022 15:24:25 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id x6so41914271iol.13
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jan 2022 15:24:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pfY4CYaCxT/bzhy5bd6mYSPSnYV2+E2FjR1LRJPFKEo=;
        b=p+bkBTgnD80yWHm3oMefR12duX+nv+HCzBfy99zB61YgImOZah8rpNTDhdkqoc6/a0
         +TlxqsnTDiVVURHcSOqN4wHexSlCX74OGd/lMwETIh33r3D6xUyivcmb8MLfpKYQpL5L
         9I5dI/kHX1iWGEeWLSJnlhxV8C7i3o+yd4QVnSNnRN/biFh8K753VLlVJ4qTzXKuOOJM
         jIiHRtK156q7Vue9T6Ptx8pKabjGrpRLh/FuDAm0/gLu46VuYDkbbA3vsXwJlhWuuPom
         nIyS74ObpDJJ/b/VPT3a8C+RUKjBnbY98YN5axa5/3dmuAdnV34ub6LQMYHQmsuTeg/W
         LZfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pfY4CYaCxT/bzhy5bd6mYSPSnYV2+E2FjR1LRJPFKEo=;
        b=B+FB/GnB/AHoephRMFgdYFUfR+vyY1bAzmoKYS7cUcIMdcOPlAxCNxiEu58nVS72ci
         kmX+JuLSfhBAtoITbskBQDhN7ttqhIRH1SXY6P9v75rxVqPgLky5aHp7KSbGYLFtz/wE
         BXlF+x28AJZ6WlWdJz8G6t1q9CnpbYhB+nXIed7vVpZ0UGhPTRbU1esHgBif5bkbnMc3
         IKxVuGlr7Xyqpwm6K3/TCrvzJaexcR3T45gpTJTr3vdzdoNaGsu5Kb9RweTnBiVQF2Mg
         2dYJkkK7DVsnlghwbJam2zWmjMgwH39yV21dpTmb3Poe9bWZd8wpzGEYXUmE3atCHijD
         K9jw==
X-Gm-Message-State: AOAM530uZBxGzKT4nt/o2HWP5AJyCbo7/Dm0hrEMc6mmJ2L0GmhFFz0G
        FKuENa5D8GMONCm3BB7hKDyCd7Grb8erD05Xyh6h4Q==
X-Google-Smtp-Source: ABdhPJx5H+R1H5dtKWkbsoZAFIkTWSGsLvkM6frCAEe3MBNMVOdoCdTjI2dhTehCc4DPfhUx/2kdfT0zrywmNhp9w50=
X-Received: by 2002:a6b:f31a:: with SMTP id m26mr20893141ioh.184.1641252265166;
 Mon, 03 Jan 2022 15:24:25 -0800 (PST)
MIME-Version: 1.0
References: <20211210210229.2991238-1-eranian@google.com> <20211210210229.2991238-4-eranian@google.com>
 <9c8d02ff-74a6-b8ba-c19b-9ee20da9af12@gmail.com>
In-Reply-To: <9c8d02ff-74a6-b8ba-c19b-9ee20da9af12@gmail.com>
From:   Stephane Eranian <eranian@google.com>
Date:   Mon, 3 Jan 2022 15:24:13 -0800
Message-ID: <CABPqkBTHYBujEzPDBwGub3oD5arNpGdZKwJqyLzFFwkhgpqgzQ@mail.gmail.com>
Subject: Re: [PATCH v4 03/14] perf/x86/amd: add AMD Fam19h Branch Sampling support
To:     Like Xu <like.xu.linux@gmail.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        kim.phillips@amd.com, acme@redhat.com, jolsa@redhat.com,
        songliubraving@fb.com, mpe@ellerman.id.au, maddy@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 29, 2021 at 1:54 AM Like Xu <like.xu.linux@gmail.com> wrote:
>
> Hi Stephane,
>
> On 11/12/2021 5:02 am, Stephane Eranian wrote:
> > + * The BRS counter could be any counter, but there is no constraint on Fam19h,
> > + * therefore all counters are equal and thus we pick the first one: PMC0
>
> Are you assuming that no other counters can be enabled (guaranteed by the
> patched perf context) when BRS is enabled ? Otherwise the hard-coding of
> PMC0 may destroy scheduling freedom. Can we relax this condition?
>
You can use the other counters for any events. The BRS hardware is
programmed to watch PMC0. If
you activate BRS the event in PMC0 is the one triggering BRS capture.
When you do:
$ perf record -b -e cpu/branch-brs/,cycles ....

Given how perf record operates, it will force branch sampling on the two events.
And because branch sampling is coupled with PMC0, you will get multiplexing.
If you wanted to say use branch sampling on branch-brs, but not on
cycles, you would
not be able to do it with perf record, though the syscall interface supports it.

On AMD,  there are no event constraints, so forcing events using BRS
on PMC0 does not prevent
other events from being scheduled.

Hope this helps.
