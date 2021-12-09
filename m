Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDF8F46F690
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 23:12:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233254AbhLIWPu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 17:15:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231400AbhLIWPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 17:15:49 -0500
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADEB1C061746
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 14:12:15 -0800 (PST)
Received: by mail-il1-x135.google.com with SMTP id j7so6725553ilk.13
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 14:12:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AWAKuXQQZs0oznfLfQs0AFaN2nVnY5XSlb+MhTaLU2Y=;
        b=C3JWuHDUWBQoTlfUY1BPDT9pe4Etr+pH+IF2dDkhqztwCVL0aACdP0f+J0gaqoOKEv
         wJxhNMet0+rSDGI8qwMa2qWbPVFlEbv4Ai/48miM4+3TNTXZfPXkIsF3s0E7GMf5CwqJ
         +NIBbTs7O+9o8kUbb1r0gEUGDMdP6Fzmn6ns9if4tHwL/UxLYqtcf2TwCsNWYXu599mL
         /34VJG+2lFyn9ZV+jWfkLYDOgZdzn/7V8tC7Z7Mo27CuumPRKnVEwFc+Ofy/OwffDPT5
         rsmDt748ZmcrrODdBVuDMo+ATkTxd0BYtOa4cqCuCD59Kx2sHhdbIkXx4QhAO4boCjo+
         6x/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AWAKuXQQZs0oznfLfQs0AFaN2nVnY5XSlb+MhTaLU2Y=;
        b=1y5mFveUOMUnZH9cxzRrAMoyu6BO/AdWCirUXSP9bpr7JahmBZENwnYwjmbjxPUfY3
         fetneDSeFqlaSvm6OQDap7IvNMP5CmBlq5tSyhRXuI1fbfj1AKO9xFL5nT9JkyqURkQo
         bBRS9xZCXg3koXP7p1Z6D2ZMPPLELvu7EZnYwP5uFiqmLFZbM858TazPH5Z6Nd2p5Ww8
         xszlrAH0Pk7hrYyWMHXCCA4BenlSLIAay/rwhyng+wr40vdpR4GG5DXpmquNir7pJTlt
         0H3JJlx0ahepgowflsbK7IFl+llqCZxPsvHyy7KZJCz5/7cEaY9xOnCY6+jVkCyefLGY
         XLbA==
X-Gm-Message-State: AOAM532PDFBPggF8MYGh9n08xswHCocDu31U1+CpN9oVxz4EyIpXbLoz
        6HU7CtjWenlUuLXMY4Pu9inLtA58rLnDN0Z07Gb0ww==
X-Google-Smtp-Source: ABdhPJzlY9YDLh0totC8ugENOCT56NYOMeo31+uLroh0vkpgErft/xx/kzKtBJmoj4J/LgYFHYiNcexaxwFVzqw4VU8=
X-Received: by 2002:a05:6e02:1586:: with SMTP id m6mr17812795ilu.146.1639087934449;
 Thu, 09 Dec 2021 14:12:14 -0800 (PST)
MIME-Version: 1.0
References: <20211208044808.872554-1-pcc@google.com> <CANpmjNPsBa=8+Ned03LW_0qUsM6fy-E51dpFKm8ok-vcMQGMmA@mail.gmail.com>
In-Reply-To: <CANpmjNPsBa=8+Ned03LW_0qUsM6fy-E51dpFKm8ok-vcMQGMmA@mail.gmail.com>
From:   Peter Collingbourne <pcc@google.com>
Date:   Thu, 9 Dec 2021 14:12:03 -0800
Message-ID: <CAMn1gO4=8ovgRs5fpmP_4d-xqEXsR32SWHJT8YmXwZGmdWyfbg@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] kernel: introduce uaccess logging
To:     Marco Elver <elver@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        YiFei Zhu <yifeifz2@illinois.edu>,
        Mark Rutland <mark.rutland@arm.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Chris Hyser <chris.hyser@oracle.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Dmitry Vyukov <dvyukov@google.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Alexey Gladkov <legion@kernel.org>,
        Ran Xiaokai <ran.xiaokai@zte.com.cn>,
        David Hildenbrand <david@redhat.com>,
        Xiaofeng Cao <caoxiaofeng@yulong.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Thomas Cedeno <thomascedeno@google.com>,
        Alexander Potapenko <glider@google.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Evgenii Stepanov <eugenis@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 8, 2021 at 7:33 AM Marco Elver <elver@google.com> wrote:
>
> On Wed, 8 Dec 2021 at 05:48, Peter Collingbourne <pcc@google.com> wrote:
> [...]
> > Peter Collingbourne (6):
> >   include: split out uaccess instrumentation into a separate header
> >   uaccess-buffer: add core code
> >   fs: use copy_from_user_nolog() to copy mount() data
> >   uaccess-buffer: add CONFIG_GENERIC_ENTRY support
> >   arm64: add support for uaccess logging
> >   Documentation: document uaccess logging
>
> I think it needs to be possible to disable the feature via a Kconfig
> option. Not all systems want or could even tolerate the additional
> overheads -- even though you say they are minimal elsewhere. For
> example, some embedded systems most likely have absolutely no use for
> this feature, and the increase in .text might be unacceptable. Certain
> features that we usually take for granted are no different (see
> init/Kconfig: FUTEX, EPOLL, .. etc). If you'd like it enabled by
> default, given the overheads are small enough, it can do "default y"
> and be configurable only "if EXPERT".

Okay, done.

> Is it possible to add a kselftest-style test to
> tools/testing/selftests? In addition to the basic tests, can certain
> non-trivial properties, like masking of signals, also be tested? I
> think that'd be extremely valuable, because I'm sure we'd have to
> backport this to several older kernels.

Yes, I've added a new patch with a kselftest. (Good thing I did,
because it (together with DEBUG_PREEMPT) uncovered a bug in the
pre/post-exit-loop code. Fixed in v4.)

Peter
