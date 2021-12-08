Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C945546D70E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 16:33:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236140AbhLHPhN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 10:37:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236132AbhLHPhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 10:37:11 -0500
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66081C0617A1
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 07:33:39 -0800 (PST)
Received: by mail-oo1-xc31.google.com with SMTP id g11-20020a4a754b000000b002c679a02b18so926928oof.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 07:33:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IxIfRX4p1ShqDdqDmnt+bp423Hz8b1BolvUDyPorj8Y=;
        b=qY8ENfN3W0Yf9nuo152oD+q2MbKXXE68D03Y13l/idtVg4tIZ7a/92vuX5iAK6K7fG
         SFzn9Sd3pT+R/9WbKC4mXC4T3kvxIdUHFPKu46QpALXLcNzhIKXq6iRsrB/9RWFqUPif
         T/BoxlDf55/SQd0vvwmfP79E6TyeEowm9AdZu1uVsDaDZ6vOLjRWVKAR5h62CaDuZqWm
         b1Q/31oF0q8Cw6jGkY8zDrCBWaBfIM8O9bkYSjkwT5zVBr/83UPJigeMVkU0+TssuJut
         EUEVYTFyivbXDX7agrCPW49SLBfnhiykSVJ5Fpo9Mp0zgS4KMgqZQ2xflZo+yqiVr8KW
         Pgpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IxIfRX4p1ShqDdqDmnt+bp423Hz8b1BolvUDyPorj8Y=;
        b=UW5mJ+hcj+nLmrrbEYYyNMVnAwuS2OwiqZqg6o5vwuIjtipRY5rXuxEE7OCxnOT/XP
         G/9TxPdhrTxdj5qHFm3tvCvigzzXRq523cP+6Ccebv/WLCQqjgs8uyrb4ARvmQOlk+Fb
         d0oI8udc/cnENwOgJMNfeGTZ4s9vzWgeaEnQfUbYaEhQeKmo3MytIb/rWQqTVso9KgoE
         IX44xf3AbXeXnuGdU5K8pvyEHjpNppPnweNKrNUY1/5GVepiq0A9hj5xFEKNtLUKdAc7
         UqCeoP3pd190N7iS5lS2ZtEh9fJmIem3+Di6dXa6VMfwwyWpYlUknNpAj3aE5OO3FXhW
         eB6g==
X-Gm-Message-State: AOAM530zw/o1K1bOMNsHFpvji1ZmRrHLw+skUYPSfwaVVD+7WA9s+w9M
        703XF8WD2b6mzybo8/kWfYltaDfVF4cFz/EUBEOnsA==
X-Google-Smtp-Source: ABdhPJzxgoA4G0rp+2qsKYM6ma2T0oGdG17NC5ZMmsGAIXxmQb65eoU42AnrhA5/ygmcAsXJZtOV5gXtVSJRg9A0EQg=
X-Received: by 2002:a4a:a5cf:: with SMTP id k15mr160987oom.70.1638977618527;
 Wed, 08 Dec 2021 07:33:38 -0800 (PST)
MIME-Version: 1.0
References: <20211208044808.872554-1-pcc@google.com>
In-Reply-To: <20211208044808.872554-1-pcc@google.com>
From:   Marco Elver <elver@google.com>
Date:   Wed, 8 Dec 2021 16:33:26 +0100
Message-ID: <CANpmjNPsBa=8+Ned03LW_0qUsM6fy-E51dpFKm8ok-vcMQGMmA@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] kernel: introduce uaccess logging
To:     Peter Collingbourne <pcc@google.com>
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

On Wed, 8 Dec 2021 at 05:48, Peter Collingbourne <pcc@google.com> wrote:
[...]
> Peter Collingbourne (6):
>   include: split out uaccess instrumentation into a separate header
>   uaccess-buffer: add core code
>   fs: use copy_from_user_nolog() to copy mount() data
>   uaccess-buffer: add CONFIG_GENERIC_ENTRY support
>   arm64: add support for uaccess logging
>   Documentation: document uaccess logging

I think it needs to be possible to disable the feature via a Kconfig
option. Not all systems want or could even tolerate the additional
overheads -- even though you say they are minimal elsewhere. For
example, some embedded systems most likely have absolutely no use for
this feature, and the increase in .text might be unacceptable. Certain
features that we usually take for granted are no different (see
init/Kconfig: FUTEX, EPOLL, .. etc). If you'd like it enabled by
default, given the overheads are small enough, it can do "default y"
and be configurable only "if EXPERT".

Is it possible to add a kselftest-style test to
tools/testing/selftests? In addition to the basic tests, can certain
non-trivial properties, like masking of signals, also be tested? I
think that'd be extremely valuable, because I'm sure we'd have to
backport this to several older kernels.

Thanks,
-- Marco
