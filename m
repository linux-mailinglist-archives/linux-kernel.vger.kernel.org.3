Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A5A74B872C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 12:54:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232721AbiBPLyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 06:54:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231184AbiBPLyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 06:54:41 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81D7D655D
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 03:54:28 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id l5so2081434oii.13
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 03:54:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FJZjGDju8hSsKhP/VhlP81+WbZ1yJelYHgylNq0yMyk=;
        b=teX6kkgTsyLgEJ5eWiL/Ngm4EECZ8vlUaxGzu9ia2tFUvvuSdhyWAJiPzyeubDxHj8
         Vh/3X7nz35aVY5/st7EfyPdYdSGniOTie31RzpV4jGveykAd8WL/kVY53saHvtwnX03K
         D7GfM1SFldIHq7PXe2tOxtsHOB+T0a58XX6F2HH6TJorBA8lPN2KoXUvFWwC3DtavBmp
         lW2V4Uvwr+y8GBNkjeedgqOGvkTY2vhe4/i6ZYSDcsYaf4l3Qd/5DkI8efKYO9v1e8QR
         swYxn7QgcE19i65KlVBcURs9NVYh4saqj7LdFEQV3o3IQJ52wMTXBSsGAT2Ff5DjqtgL
         h7vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FJZjGDju8hSsKhP/VhlP81+WbZ1yJelYHgylNq0yMyk=;
        b=XWStC4LyC2kZIEsRQwPOJHNXAmQ6g3xixAMVpv1wbune2GjOucjU5sXWTaUIjmii3M
         Zy055XxshsF4aCpLSRcEJNueyqEV5HnLzbX+/n3wMq6d/1RDO9QrGrDnAPmbJoPfuC2Q
         asPdb+IYKP9M5lU+3/dXiJ4DwyYIPHJDM3lgRSRjFHBH0lzQniBO7hedBS6RJRT56I78
         FKGw41FZj+E29mLNPGl7KQTuXz5uqdkTdRW3y0JVlUv155PFHBO8LC+IMMdfsPn2JneM
         AfTH4YmrXMTgCX5MLFAnAlver6ft1/nach70qMt3vpl9kk20bkVIYJEnNhurl8xO7OoK
         EnPw==
X-Gm-Message-State: AOAM531UK3xUwwPGGt08LiKDr0B37KxvqbWQ7ohAX7TawpWCi2Ojd8/0
        pGwbHzErmgi5h5Nt2s3/J1EpqXJwHP1208z5coJikg==
X-Google-Smtp-Source: ABdhPJx1IrLsRmdr6QJw/3uv3szDLQBczkS3taO9y4Eio4eBeYFrlAgpq8eEjhO8fgru5f0EWLrIJO/y+lCgQTVvyS4=
X-Received: by 2002:a05:6808:3021:b0:2d4:40f3:6b30 with SMTP id
 ay33-20020a056808302100b002d440f36b30mr443999oib.31.1645012467493; Wed, 16
 Feb 2022 03:54:27 -0800 (PST)
MIME-Version: 1.0
References: <20211216151454.752066-1-tmricht@linux.ibm.com>
 <CANpmjNNMWtjcKa961SjEvRbbPXyw5M5SkrXbb3tnyL3_XyniCw@mail.gmail.com>
 <90efb5a9-612a-919e-cf2f-c528692d61e2@huawei.com> <20220118091827.GA98966@leoy-ThinkPad-X240s>
 <CANpmjNMPoU+1b1fKFuYDYwisW2YfjQHxGt5hgLp1tioG7C2jmg@mail.gmail.com>
 <20220118124343.GC98966@leoy-ThinkPad-X240s> <bfa0af18-04ac-857d-d3d8-ad9290f912c8@huawei.com>
 <06412caf-42e4-5c4b-c9b3-9691075405bd@huawei.com> <20220215143459.GB7592@willie-the-truck>
 <8c582e45-0954-a2ea-764a-4dd78a464988@huawei.com>
In-Reply-To: <8c582e45-0954-a2ea-764a-4dd78a464988@huawei.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 16 Feb 2022 12:54:16 +0100
Message-ID: <CACT4Y+Z8pKXw=8nwVtdo2W=hu_rBk1ws-Q=7-tBkLGTcD85NaA@mail.gmail.com>
Subject: Re: Test 73 Sig_trap fails on arm64 (was Re: [PATCH] perf test: Test
 73 Sig_trap fails on s390)
To:     John Garry <john.garry@huawei.com>
Cc:     Will Deacon <will@kernel.org>, Leo Yan <leo.yan@linaro.org>,
        Marco Elver <elver@google.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, svens@linux.ibm.com, gor@linux.ibm.com,
        sumanthk@linux.ibm.com, hca@linux.ibm.com,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Feb 2022 at 12:47, John Garry <john.garry@huawei.com> wrote:
>
> Hi Will,
>
> > Sorry, I haven't had time to look at this (or the thousands of other mails
> > in my inbox) lately.
> >
>
> Thanks
>
> > I don't recall all of the details, but basically hw_breakpoint really
> > doesn't work well on arm/arm64 -- the sticking points are around handling
> > the stepping and whether to step into or over exceptions. Sadly, our ptrace
> > interface (which is what is used by GDB) is built on top of hw_breakpoint,
> > so we can't just rip it out and any significant changes are pretty risky.
> >
> > What I would like to happen is that we rework our debug exception handling
> > as outlined by [1] so that kernel debug is better defined and the ptrace
> > interface can interact directly with the debug architecture instead of being
> > funnelled through hw_breakpoint. Once we have that, I think we could try to
> > improve hw_breakpoint much more comfortably (or at least defeature it
> > considerably without having to worry about breaking GDB). I started this a
> > couple of years ago, but I haven't found time to get back to it for ages.
> >
> > Anyway, to this specific test...
> >
> > When we hit a break/watchpoint the faulting PC points at the instruction
> > which faulted and the exception is reported before the instruction has had
> > any other side-effects (e.g. if a watchpoint triggers on a store, then
> > memory will not have been updated when the watchpoint handler runs), so if
> > we were to return as usual after reporting the exception to perf then we
> > would just hit the same break/watchpoint again and we'd get stuck. GDB
> > handles stepping over the faulting instruction, but for perf (and assumedly
> > these tests), the kernel is expected to handle the step. This handling
> > amounts to disabling the break/watchpoint which we think we hit and then
> > attempting a hardware single-step. During the step we could run into more
> > break/watchpoints on the same instruction, so we'll keep disabling things
> > until we eventually manage to complete the step, which is signalled by a
> > specific type of debug exception. At this point, we re-enable the
> > break/watchpoints and we're good.
> >
> > Signals make this messy, as the step logic will step_into_  the signal
> > handler -- we have to do this, otherwise we would miss break/watchpoints
> > triggered by the signal handler if we had disabled them for the step.
> > However, it means that when we return back from the signal handler we will
> > run back into the break/watchpoint which we initially stepped over. When
> > perf uses SIGTRAP to notify userspace that we hit a break/watchpoint,
> > then we'll get stuck because we'll step into the handler every time.
> >
> > Hopefully that clears things up a bit. Ideally, the kernel wouldn't
> > pretend to handle this stepping at all for arm64 as it adds a bunch of
> > complexity, overhead to our context-switch and I don't think the current
> > behaviour is particularly useful.
> >
>
> Right, so what I am hearing altogether is that for now we should just
> skip this test.
>
> And since the kernel does not seem to advertise this capability we need
> to disable for specific architectures.

It does and fwiw I am just trying to use it. Things work only on x86 so far.
