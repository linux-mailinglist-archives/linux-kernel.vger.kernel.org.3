Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59695471398
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 12:29:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230454AbhLKL3F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 06:29:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbhLKL3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 06:29:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 824B2C061714;
        Sat, 11 Dec 2021 03:29:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 369CAB8093B;
        Sat, 11 Dec 2021 11:29:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA068C004DD;
        Sat, 11 Dec 2021 11:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639222140;
        bh=bRzrWnqdaJziN+i3we6kulKgLiTwa5uBJnQvuioHYyw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g7lCQD18OMyO8bYrW59KXLDjIefpUeGbgALxPDiy2+vkvw/ovgpqdOrYHOUAobPP0
         pt49tkCWk5NYASFki/nhg3tf5NAh82iEY1un/bW7lJCWg2PV+JMj1daIiu2rPXGb27
         8hbwtREF8J89dIcSRqx8Ug3mNvSUfshilKQK3gGQps7WS/FFKqQPcm0J8Jx/BUZ9/H
         ia6hC96whPgZdSpl7ml1hIQaa9HesSOKGgQPYfeYp9MbdvNDcyFwd76WhIMnrnttRn
         zZRRRYGigcB6yDxhRaEUP3WjknSsaz1u+o08uyS+d4EB/QhTeJpqQ+uZaFKnOy6oCx
         g7KgvqbDSLrjA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 1A5FB405D8; Sat, 11 Dec 2021 08:28:59 -0300 (-03)
Date:   Sat, 11 Dec 2021 08:28:59 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Alistair Francis <alistair.francis@opensource.wdc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Darren Hart <dvhart@infradead.org>,
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
Subject: Re: [PATCH v5 1/6] perf bench futex: Add support for 32-bit systems
 with 64-bit time_t
Message-ID: <YbSLe1EWglAc592n@kernel.org>
References: <20211209235857.423773-1-alistair.francis@opensource.wdc.com>
 <YbNX3mRT0A9/N2il@kernel.org>
 <YbNZw1/cUXJ8up5b@kernel.org>
 <CAK8P3a05D=fb9stZEL6rUMs7c=S6gJxN5gR7HG_i8RiXAbaB5Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a05D=fb9stZEL6rUMs7c=S6gJxN5gR7HG_i8RiXAbaB5Q@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Dec 10, 2021 at 03:23:42PM +0100, Arnd Bergmann escreveu:
> On Fri, Dec 10, 2021 at 2:44 PM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> > Em Fri, Dec 10, 2021 at 10:36:30AM -0300, Arnaldo Carvalho de Melo escreveu:
> > > Em Fri, Dec 10, 2021 at 09:58:52AM +1000, Alistair Francis escreveu:
> > > > From: Alistair Francis <alistair.francis@wdc.com>

> > > > Some 32-bit architectures (such are 32-bit RISC-V) only have a 64-bit
> > > > time_t and as such don't have the SYS_futex syscall. This patch will
> > > > allow us to use the SYS_futex_time64 syscall on those platforms.

> > > > This also converts the futex calls to be y2038 safe (when built for a
> > > > 5.1+ kernel).

> > > > This is a revert of commit ba4026b09d83acf56c040b6933eac7916c27e728
> > > > "Revert "perf bench futex: Add support for 32-bit systems with 64-bit time_t"".

> > > > The original commit was reverted as including linux/time_types.h would
> > > > fail to compile on older kernels. This commit doesn't include
> > > > linux/time_types.h to avoid this issue.

> > >   10     9.99 alpine:3.12                   : FAIL gcc version 9.3.0 (Alpine 9.3.0)
> > >     In file included from bench/futex-hash.c:29:
> > >     bench/futex.h:37:2: error: unknown type name '__kernel_old_time_t'
> > >        37 |  __kernel_old_time_t tv_sec;  /* seconds */
> > >           |  ^~~~~~~~~~~~~~~~~~~
> > >     In file included from bench/futex-wake.c:25:
 
> It looks like we need to add include/uapi/linux/time_types.h to
> tools/include/linux/ and update tools/include/linux/types.h
> in order to address this.

And make sure it is found before the system ones, yes, that would fix
the issues. I'll try to do it these days.

- Arnaldo
