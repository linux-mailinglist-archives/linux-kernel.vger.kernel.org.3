Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DDDD4702BE
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 15:24:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241946AbhLJO1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 09:27:35 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:56313 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbhLJO1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 09:27:34 -0500
Received: from mail-wr1-f50.google.com ([209.85.221.50]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MNtny-1nB2rm2KTI-00OD1G; Fri, 10 Dec 2021 15:23:58 +0100
Received: by mail-wr1-f50.google.com with SMTP id o13so15149661wrs.12;
        Fri, 10 Dec 2021 06:23:58 -0800 (PST)
X-Gm-Message-State: AOAM533wz7XECtJUX0ESB+KBsca0DDoWI7X1qj4Si7uAZ8jsPildWC2y
        eMfhbZfbqILDUzDO1HuL6rAfYb1OAHYwVBMebJ0=
X-Google-Smtp-Source: ABdhPJwpNfkCK35q4J84bet4qsNK0G78Iv/Ey+WuTXxUs4+UKKI6lcSJU/n3x5OpVFEpmYRVEt/ijnGMwe5NdNQgfZA=
X-Received: by 2002:a5d:4107:: with SMTP id l7mr14337051wrp.209.1639146238200;
 Fri, 10 Dec 2021 06:23:58 -0800 (PST)
MIME-Version: 1.0
References: <20211209235857.423773-1-alistair.francis@opensource.wdc.com>
 <YbNX3mRT0A9/N2il@kernel.org> <YbNZw1/cUXJ8up5b@kernel.org>
In-Reply-To: <YbNZw1/cUXJ8up5b@kernel.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 10 Dec 2021 15:23:42 +0100
X-Gmail-Original-Message-ID: <CAK8P3a05D=fb9stZEL6rUMs7c=S6gJxN5gR7HG_i8RiXAbaB5Q@mail.gmail.com>
Message-ID: <CAK8P3a05D=fb9stZEL6rUMs7c=S6gJxN5gR7HG_i8RiXAbaB5Q@mail.gmail.com>
Subject: Re: [PATCH v5 1/6] perf bench futex: Add support for 32-bit systems
 with 64-bit time_t
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Alistair Francis <alistair.francis@opensource.wdc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Darren Hart <dvhart@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Alistair Francis <alistair23@gmail.com>,
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
X-Provags-ID: V03:K1:fHc4RHHMJlxTeV0sv7QOsI/dozLNE2nXidF5V+81PW8jjqqb8YU
 OHwS3jBq+dqYNcJF4eYcF9dt9P8F7dweGbvaMuQIfOgYCnqVWAJ1OLb6+t5f3al6jbaix0m
 BBTrsjX4ztFXyox4mFgqIrVuXcqKUFj+bK1MaJt1a/8ziCkblY0z0i7fnazY1ZfIukowJba
 Nxku9SydqXjS8UOdlCtbQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:HYNBLUA0EkQ=:87xE//JIGnXIIGQ+lNti3q
 aSCxqlDeXddY5j+a+wZsKB+nA8a+2DEvLk+SA0sqkzB6qQ0Ys7Y+PFTky1yXoTav2WM9k5lc/
 FmcCjBdoPz8XFuaDppnRCZ/vsUasxbxwfuUGLNlTZT5F/rSgiIH6sjrkdi6Sby7sPT4bWZQM0
 F38nepKtgRLfKKq/fp7x1kAinOLtEkrxxeJDc1ROihNOoJLiekvye2kD/s5iJi20a+CRSH2dJ
 1rQhZUCPLKn64h+ZMLtOcqaGo/sjyCy3wvOrN/AluWfjdeL+L6cVTAXJrY+dOgvUVaTnMTlrT
 ccu1zEko+3B1v19gaPFj4p0O4oIzO3ZvJqQXvjsn1TCMH4FpSveL0AFWbhM9ARYcoGjV86MGi
 Mp3Pk//pImnDWphTW+I0PieibISh6OFanQ5u9fy01LY33aY00WnagR5f0yzk+ODdEMgDdiBa0
 NNqfOBOrakYMIzH9kmjEYleTRNRVTkMQj+iuzClLIpWB75un5qedK6lP+RSP7MqLntgO5QlqX
 3s2X4oBl+ngn5VwoI+qCsWaYd/mA+wSWEHXsjL85XCHwMJ1An7bS1wRCpt3ygClVdF4r84e12
 oApGLn1J15g0bqXuN6xYTakddbbPPByBCDwNo9pNOCrKMOn8qdAcLAKwVOVgWNmOcTfqFdo5p
 +H93VW0rUY6IwGHdSbB3/FfWpo75xNFRpYnvAtYc6khUJ0gSwzzQLU+yD+5GClm0PDuU=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 10, 2021 at 2:44 PM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
> Em Fri, Dec 10, 2021 at 10:36:30AM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Fri, Dec 10, 2021 at 09:58:52AM +1000, Alistair Francis escreveu:
> > > From: Alistair Francis <alistair.francis@wdc.com>
> > >
> > > Some 32-bit architectures (such are 32-bit RISC-V) only have a 64-bit
> > > time_t and as such don't have the SYS_futex syscall. This patch will
> > > allow us to use the SYS_futex_time64 syscall on those platforms.
> > >
> > > This also converts the futex calls to be y2038 safe (when built for a
> > > 5.1+ kernel).
> > >
> > > This is a revert of commit ba4026b09d83acf56c040b6933eac7916c27e728
> > > "Revert "perf bench futex: Add support for 32-bit systems with 64-bit time_t"".
> > >
> > > The original commit was reverted as including linux/time_types.h would
> > > fail to compile on older kernels. This commit doesn't include
> > > linux/time_types.h to avoid this issue.
> >
> >   10     9.99 alpine:3.12                   : FAIL gcc version 9.3.0 (Alpine 9.3.0)
> >     In file included from bench/futex-hash.c:29:
> >     bench/futex.h:37:2: error: unknown type name '__kernel_old_time_t'
> >        37 |  __kernel_old_time_t tv_sec;  /* seconds */
> >           |  ^~~~~~~~~~~~~~~~~~~
> >     In file included from bench/futex-wake.c:25:

It looks like we need to add include/uapi/linux/time_types.h to
tools/include/linux/ and update tools/include/linux/types.h
in order to address this.

         Arnd
