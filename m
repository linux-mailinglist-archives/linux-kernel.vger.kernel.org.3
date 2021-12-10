Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED757470205
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 14:44:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234149AbhLJNsR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 08:48:17 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:56686 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230517AbhLJNsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 08:48:16 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 59DC1B827F6;
        Fri, 10 Dec 2021 13:44:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8CCEC00446;
        Fri, 10 Dec 2021 13:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639143879;
        bh=ogTpvvPSoRRGX2kvnUJLixNpTMkpkk3VjlESJw1Ra4Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=alyTTy2nW0dmERZy9g1co8A1Y/P+9UMjgO7s21wUJ8xZWUd9Avd/wMMLBOKJ5gk9h
         kJ+6wqSXNzfpSseqvb7+AhmBmR53RMq19SIvhyI3IbbWzGjjg+CGsblVL4NrQBaKS6
         L8BktAp8JfDodtYu1odUXOKHAbPZwxm8G6MUEcmYVr519N9Za6dXrGmiVfy8nJVffs
         9Sn6tJXMOwUwiL28J2mYhtqqXr61w/kiTgXTmQzkvp8jtaQqAZj0MlduqkM9ZYRZlV
         IC/2/RGMflE065BzqYlR9mKzxWPKNHje6+Meok/rf2cv4vFdK+MzDBkPIZTp8EWqv4
         Cguiiks0kbKcg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E8F1F405D8; Fri, 10 Dec 2021 10:44:35 -0300 (-03)
Date:   Fri, 10 Dec 2021 10:44:35 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Alistair Francis <alistair.francis@opensource.wdc.com>
Cc:     linux-kernel@vger.kernel.org, dave@stgolabs.net,
        dvhart@infradead.org, arnd@arndb.de, alistair23@gmail.com,
        namhyung@kernel.org, jolsa@redhat.com,
        linux-perf-users@vger.kernel.org,
        alexander.shishkin@linux.intel.com, mark.rutland@arm.com,
        mingo@redhat.com, peterz@infradead.org, tglx@linutronix.de,
        Alistair Francis <alistair.francis@wdc.com>,
        Atish Patra <atish.patra@wdc.com>,
        linux-riscv@lists.infradead.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH v5 1/6] perf bench futex: Add support for 32-bit systems
 with 64-bit time_t
Message-ID: <YbNZw1/cUXJ8up5b@kernel.org>
References: <20211209235857.423773-1-alistair.francis@opensource.wdc.com>
 <YbNX3mRT0A9/N2il@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YbNX3mRT0A9/N2il@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Dec 10, 2021 at 10:36:30AM -0300, Arnaldo Carvalho de Melo escreveu:
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
> 
> 
> Still building on the other containers.

Some more:

  21    94.54 centos:stream                 : Ok   gcc (GCC) 8.5.0 20210514 (Red Hat 8.5.0-3) , clang version 12.0.1 (Red Hat 12.0.1-2.module_el8.6.0+937+1cafe22c)
  22    48.51 clearlinux:latest             : Ok   gcc (Clear Linux OS for Intel Architecture) 11.2.1 20211202 releases/gcc-11.2.0-549-g2d5be1fca0 , clang version 11.1.0
  23     7.38 debian:9                      : FAIL gcc version 6.3.0 20170516 (Debian 6.3.0-18+deb9u1)
    In file included from bench/futex-wake.c:25:0:
    bench/futex.h:37:2: error: unknown type name '__kernel_old_time_t'
      __kernel_old_time_t tv_sec;  /* seconds */
      ^~~~~~~~~~~~~~~~~~~
    In file included from bench/futex-hash.c:29:0:
    bench/futex.h:37:2: error: unknown type name '__kernel_old_time_t'
      __kernel_old_time_t tv_sec;  /* seconds */
      ^~~~~~~~~~~~~~~~~~~
    /git/perf-5.16.0-rc4/tools/build/Makefile.build:139: recipe for target 'bench' failed
    make[3]: *** [bench] Error 2
  24     7.08 debian:10                     : FAIL gcc version 8.3.0 (Debian 8.3.0-6)
    In file included from bench/futex-hash.c:29:
    bench/futex.h:37:2: error: unknown type name '__kernel_old_time_t'
      __kernel_old_time_t tv_sec;  /* seconds */
      ^~~~~~~~~~~~~~~~~~~
    In file included from bench/futex-wake.c:25:
    bench/futex.h:37:2: error: unknown type name '__kernel_old_time_t'
      __kernel_old_time_t tv_sec;  /* seconds */
      ^~~~~~~~~~~~~~~~~~~
    make[3]: *** [/git/perf-5.16.0-rc4/tools/build/Makefile.build:139: bench] Error 2
  25    79.95 debian:11                     : Ok   gcc (Debian 10.2.1-6) 10.2.1 20210110 , Debian clang version 11.0.1-2
