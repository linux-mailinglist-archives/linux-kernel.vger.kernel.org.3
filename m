Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11E534A56FB
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 06:37:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232016AbiBAFhw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 00:37:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbiBAFhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 00:37:50 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE41AC061714;
        Mon, 31 Jan 2022 21:37:50 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id y84so19926169iof.0;
        Mon, 31 Jan 2022 21:37:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HaH4YYFQUGYgJm+BChmNqccqpH4G/GlGC8W4GeH5Y7s=;
        b=ek90t6PLRiryoISkxPbRM2CkM1aeFIDR54hPh8p2tPqh3IRwwA5RFr21jNosMYPbRA
         MEQThNMibttROc5jLYq10u7/MxJ13RELBMj4mL13BFFBWUUN9nLUAWV2XZoTaiedlFXV
         vIqZWpR/bwqH2+aWTpjx/GMDmf6g1sx3MRO1KCEZjpsZExj/GaPlHw5iT+z4Cx+IxpHC
         OQYG6sy4mGCh+Ok9M6XD5zmtvhNQNFKjS9QSzAOSqazoVWNJFfeWJDLReT9n/hguNGTM
         thum/I0sEzmXKEGXIHGXPL2XXXXuq+gvl/AQE5cqbJGc3Xw5c/pVtkA7IYnMeegLXtip
         VLbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HaH4YYFQUGYgJm+BChmNqccqpH4G/GlGC8W4GeH5Y7s=;
        b=Qs4z1xx/TUwrjM4Qmd1BUiqAdDgmn7mQ3saiESsdgbyUuxLoKfaqkcS26oRer1jUOm
         7/r0VIkXccYnH0N1O5uMSwdkvEy7AWQwp62GC40yi0h5Ny/7e7+EmIasbYe3Lp5Zd53C
         fV8NtTXETno9Wm1NQXvfbxiOpGE4QxEGr9qOYsX+PV1rNS7ligtOMHDYxoI0s4POx76d
         6XudpWoU71VctS7IdiNGo7KEGXr7pRdwnPF6KCATOLGirSXVQKPUs7LGoCTl4/mCEcel
         0Gh6xeE5iJL7cMwvm7VVdtbHqUQ9btPkpAScpqts8w0m5xQqRB80MYnj9RoUjJ34hXpH
         O7MQ==
X-Gm-Message-State: AOAM5318+PmmwJmoBc/zwUN+FySJTEo/qvJzx+gCiLTJWxQOws/vNRO9
        Po7QC4QMRzS50XriQsn+r2RXZlC/PtkBrz9rHHY=
X-Google-Smtp-Source: ABdhPJzwM6mUguBtwoWwo4q/nFsH4dB5BMq1zKQG9sN0wLToTQqNN6r6wPd4Nr4rL4eQfyyeQPi5tD0EN5Ti+LQuN+U=
X-Received: by 2002:a05:6638:1028:: with SMTP id n8mr12605683jan.318.1643693870129;
 Mon, 31 Jan 2022 21:37:50 -0800 (PST)
MIME-Version: 1.0
References: <20211209235857.423773-1-alistair.francis@opensource.wdc.com> <YbNX3mRT0A9/N2il@kernel.org>
In-Reply-To: <YbNX3mRT0A9/N2il@kernel.org>
From:   Alistair Francis <alistair23@gmail.com>
Date:   Tue, 1 Feb 2022 15:37:23 +1000
Message-ID: <CAKmqyKNMJCHHMo01aCiyJRx926jYXz+sPgVwwZ7Kr1x0w81R2Q@mail.gmail.com>
Subject: Re: [PATCH v5 1/6] perf bench futex: Add support for 32-bit systems
 with 64-bit time_t
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Alistair Francis <alistair.francis@opensource.wdc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Darren Hart <dvhart@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, linux-perf-users@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alistair Francis <alistair.francis@wdc.com>,
        Atish Patra <atish.patra@wdc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 10, 2021 at 11:36 PM Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
> Em Fri, Dec 10, 2021 at 09:58:52AM +1000, Alistair Francis escreveu:
> > From: Alistair Francis <alistair.francis@wdc.com>
> >
> > Some 32-bit architectures (such are 32-bit RISC-V) only have a 64-bit
> > time_t and as such don't have the SYS_futex syscall. This patch will
> > allow us to use the SYS_futex_time64 syscall on those platforms.
> >
> > This also converts the futex calls to be y2038 safe (when built for a
> > 5.1+ kernel).
> >
> > This is a revert of commit ba4026b09d83acf56c040b6933eac7916c27e728
> > "Revert "perf bench futex: Add support for 32-bit systems with 64-bit time_t"".
> >
> > The original commit was reverted as including linux/time_types.h would
> > fail to compile on older kernels. This commit doesn't include
> > linux/time_types.h to avoid this issue.
>
>   10     9.99 alpine:3.12                   : FAIL gcc version 9.3.0 (Alpine 9.3.0)
>     In file included from bench/futex-hash.c:29:
>     bench/futex.h:37:2: error: unknown type name '__kernel_old_time_t'
>        37 |  __kernel_old_time_t tv_sec;  /* seconds */
>           |  ^~~~~~~~~~~~~~~~~~~
>     In file included from bench/futex-wake.c:25:
>     bench/futex.h:37:2: error: unknown type name '__kernel_old_time_t'
>        37 |  __kernel_old_time_t tv_sec;  /* seconds */
>           |  ^~~~~~~~~~~~~~~~~~~
>     make[3]: *** [/git/perf-5.16.0-rc4/tools/build/Makefile.build:139: bench] Error 2
>   11   114.27 alpine:3.13                   : Ok   gcc (Alpine 10.2.1_pre1) 10.2.1 20201203 , Alpine clang version 10.0.1
>   12   100.12 alpine:3.14                   : Ok   gcc (Alpine 10.3.1_git20210424) 10.3.1 20210424 , Alpine clang version 11.1.0
>   13   101.06 alpine:3.15                   : Ok   gcc (Alpine 10.3.1_git20211027) 10.3.1 20211027 , Alpine clang version 12.0.1
>   14   101.96 alpine:edge                   : Ok   gcc (Alpine 11.2.1_git20211128) 11.2.1 20211128 , Alpine clang version 12.0.1
>   15     6.98 alt:p8                        : FAIL gcc version 5.3.1 20151207 (ALT p8 5.3.1-alt3.M80P.1) (GCC)
>     In file included from bench/futex-hash.c:29:0:
>     bench/futex.h:37:2: error: unknown type name '__kernel_old_time_t'
>       __kernel_old_time_t tv_sec;  /* seconds */
>       ^
>     In file included from bench/futex-wake.c:25:0:
>     bench/futex.h:37:2: error: unknown type name '__kernel_old_time_t'
>       __kernel_old_time_t tv_sec;  /* seconds */
>       ^
>     In file included from bench/futex-wake-parallel.c:31:0:
>     bench/futex.h:37:2: error: unknown type name '__kernel_old_time_t'
>       __kernel_old_time_t tv_sec;  /* seconds */
>       ^
>     make[3]: *** [bench] Error 2
>   16    73.65 alt:p9                        : Ok   x86_64-alt-linux-gcc (GCC) 8.4.1 20200305 (ALT p9 8.4.1-alt0.p9.1) , clang version 10.0.0
>   17    72.34 alt:sisyphus                  : Ok   x86_64-alt-linux-gcc (GCC) 11.2.1 20210911 (ALT Sisyphus 11.2.1-alt1) , ALT Linux Team clang version 12.0.1
>   18     7.58 amazonlinux:1                 : FAIL gcc version 7.2.1 20170915 (Red Hat 7.2.1-2) (GCC)
>     In file included from bench/futex-hash.c:29:0:
>     bench/futex.h:37:2: error: unknown type name '__kernel_old_time_t'
>       __kernel_old_time_t tv_sec;  /* seconds */
>       ^~~~~~~~~~~~~~~~~~~
>     In file included from bench/futex-wake.c:25:0:
>     bench/futex.h:37:2: error: unknown type name '__kernel_old_time_t'
>       __kernel_old_time_t tv_sec;  /* seconds */
>       ^~~~~~~~~~~~~~~~~~~
>     make[3]: *** [bench] Error 2
>   19     8.28 amazonlinux:2                 : FAIL gcc version 7.3.1 20180712 (Red Hat 7.3.1-13) (GCC)
>     In file included from bench/futex-hash.c:29:0:
>     bench/futex.h:37:2: error: unknown type name '__kernel_old_time_t'
>       __kernel_old_time_t tv_sec;  /* seconds */
>       ^~~~~~~~~~~~~~~~~~~
>     make[3]: *** [bench] Error 2
>   20    79.16 centos:8                      : Ok   gcc (GCC) 8.4.1 20200928 (Red Hat 8.4.1-1) , clang version 11.0.1 (Red Hat 11.0.1-1.module_el8.4.0+966+2995ef20)

Is there a way I can reproduce this failure?

Alistair

>
>
> Still building on the other containers.
>
> - Arnaldo
