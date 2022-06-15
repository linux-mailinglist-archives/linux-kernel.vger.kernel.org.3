Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D075654C826
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 14:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241474AbiFOMJk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 08:09:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235822AbiFOMJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 08:09:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FB5946B10
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 05:09:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 36018B81D93
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 12:09:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5A62C341C0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 12:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655294975;
        bh=wkqJ/T68k9r2Oy7BU+HQ4jeUyx1IPklxlT7PijJ0qno=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hBt3Uo2tvXWSIPqwv/rcfFfzw4wpkZe0NdighutShKy/XFepXHmGKfhpOAhcrLwE+
         taYYa+aQMG0lR76MSX8kXzT/y0AXI3zot9Q+2g6exppRyo0EIkqVCoXZCZLf9DivHG
         ljYfN30qUa6XOe65EtlPkcEaFvgUH0d5ZH1XHzhi2g/wH7ayjFNkBZNkEkcK6tgBnk
         jEAmuctIBOBzAK2CPoRWUKHbJdaWIYFbmSxpYykG0IZwYNjX5zJjeO1Q5o1njuFv8D
         WGQfXh0ytS8hRUveyO4X8+SU2LMi0T0QjKGzu3ZniBGrTdoGj19NJ7SRXaIMBiEYy/
         ZWVl+MGVwqjKA==
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-313a8a8b95aso58822797b3.5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 05:09:35 -0700 (PDT)
X-Gm-Message-State: AJIora/GPXjX4QRVk+0lIjTHMGux60RHkBiMjGHkCT1m0ITq9YtW+z79
        /UrUzAQM4a96FlSna+YCR7IT6BNPWzcYmNbQ9vQ=
X-Google-Smtp-Source: AGRyM1v1gZhuyIQo1km9VW5YHgE9Bpwhdz8KfSM7SWxOvp4o1BPT2oLt9iJz8J4qcgAqPHbKBgqAXKr5A03/M/GsKic=
X-Received: by 2002:a0d:d84d:0:b0:314:2bfd:ddf3 with SMTP id
 a74-20020a0dd84d000000b003142bfdddf3mr11531420ywe.347.1655294974785; Wed, 15
 Jun 2022 05:09:34 -0700 (PDT)
MIME-Version: 1.0
References: <CAFJhRnoEifeo0Tr2qfKD031C=9jYZ7oP3zSR9hFUmFp86Og7+Q@mail.gmail.com>
 <CAK8P3a1RVKLFT0aX38fJoFejgrq7VCz7auHjtsBB9W0rwnedCw@mail.gmail.com>
 <20220607163053.GD7074@brightrain.aerifal.cx> <CAFJhRnrWPC6pk67Xo9A9EeHFhoJCkE2PfwS4wFUep2JS3D9ujQ@mail.gmail.com>
 <CAK8P3a04TcLnhEE+MmQGOLU_AcVD5Rb+8vCKFSRF-zg33161ig@mail.gmail.com>
 <20220614170013.GH7074@brightrain.aerifal.cx> <CAK8P3a0d9hOuv+RiN_eQZtmfc7DCbJe6nEhL+W1AU2kFjiDZWw@mail.gmail.com>
 <20220614204900.GI7074@brightrain.aerifal.cx> <CAK8P3a0jk736rPueff--Uor=tHmicHZgoikrAsjp0DHxmkaiWg@mail.gmail.com>
 <20220614232826.GJ7074@brightrain.aerifal.cx>
In-Reply-To: <20220614232826.GJ7074@brightrain.aerifal.cx>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Wed, 15 Jun 2022 14:09:16 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3WZB81QqAJF1zi0Lp0n2vKhjKhiCS4vcOoVi8jt-Y3aA@mail.gmail.com>
Message-ID: <CAK8P3a3WZB81QqAJF1zi0Lp0n2vKhjKhiCS4vcOoVi8jt-Y3aA@mail.gmail.com>
Subject: Re: [musl] Question about musl's time() implementation in time.c
To:     musl@lists.openwall.com
Cc:     John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Adhemerval Zanella <adhemerval.zanella@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 15, 2022 at 1:28 AM Rich Felker <dalias@libc.org> wrote:
> On Tue, Jun 14, 2022 at 11:11:32PM +0200, Arnd Bergmann wrote:
> >
> > The thing is that a lot of file systems would still behave the same way
> > because they round times down to a filesystem specific resolution,
> > often one microsecond or one second, while the kernel time accounting
> > is in nanoseconds. There have been discussions about an interface
> > to find out what the actual resolution on a given mount point is (similar
> > to clock_getres), but that never made it in. The guarantees that you
> > get from file systems at the moment are:
>
> It's normal that they may be rounded down the the filesystem timestamp
> granularity. I thought what was going on here was worse.

It gets rounded down twice: first down to the start of the current
timer tick, which is at an arbitrary nanosecond value in the past 10ms,
and then to the resolution of the file system. The result is that the
file timestamp can point to a slightly earlier value, up to max(timer tick
cycle, fs resolution) before the actual nanosecond value. We don't
advertise the granule of the file system though, so I would expect
this to be within the expected behavior.

> OK, the time syscall doing the wrong thing here (using a different
> clock that's not correctly ordered with respect to CLOCK_REALTIME)
> seems to be the worst problem here -- if I'm understanding it right.
> The filesystem issue might be a non-issue if it's truly equivalent to
> just having coarser fs timestamp granularity, which is allowed.

Adding the kernel timekeeping maintainers to Cc. I think this is a
reasonable argument, but it goes against the current behavior.

We have four implementations of the time() syscall that one would
commonly encounter:

- The kernel syscall, using (effectively) CLOCK_REALTIME_COARSE
- The kernel vdso, using (effectively) CLOCK_REALTIME_COARSE
- The glibc interface, calling __clock_gettime64(CLOCK_REALTIME_COARSE, ...)
- The musl interface, calling __clock_gettime64(CLOCK_REALTIME, ...)

So even if everyone agrees that the musl implementation is the
correct one, I think both linux and glibc are more likely to stick with
the traditional behavior to avoid breaking user space code such as the
libc-test case that Zev brought up initially. At least Adhemerval's
time() implementation in glibc[1] appears to have done this intentionally,
while the Linux implementation has simply never changed this in an
incompatible way since Linux-0.01 added time() and 0.99.13k added
the high-resolution gettimeofday().

       Arnd

[1] https://sourceware.org/git/?p=glibc.git;a=commitdiff;h=0d56378349
