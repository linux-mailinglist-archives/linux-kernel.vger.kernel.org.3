Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87B864C55B1
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 12:47:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231531AbiBZLr7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 06:47:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbiBZLr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 06:47:56 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 130122510D5;
        Sat, 26 Feb 2022 03:47:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6A520B81C12;
        Sat, 26 Feb 2022 11:47:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34021C340E8;
        Sat, 26 Feb 2022 11:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645876034;
        bh=f9nMSPctgTiyiss0x6y6Z5CkHMAlVi10SXgqwX5juFE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GjuCww/WySNEJr7qbTFfZZddaZWAmT28Lc+tmzN30ABrmdtFQbWNVq/u3aa6H7dN0
         xybjW27oIodYrbD0yHz6WquXeSzaK/b3KZRFbyFZYK7tZtkXS3suY8JlW+TF+yBEvk
         Ow/UmF8eN9AvcfnU0apOWFXY76Sa6GsfgjgV25/w/Li7pMDNhc297k3ks0qfr5BBkF
         jf9NsIBgzkYhecPeWepw+UxsCT/LKM4uVeH2EWBwkXhaXwiu92RzxpRtNOi9TrVYuN
         JmpnwcxGSR3EaXJxh+wR7jwV5au2hoABsiv/uIDiFe+QkJCqjp8D1SGWmjxy30N+e7
         euwMBbwrKAHfA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id CC8AC403C8; Sat, 26 Feb 2022 08:47:10 -0300 (-03)
Date:   Sat, 26 Feb 2022 08:47:10 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Alistair Francis <alistair.francis@opensource.wdc.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de, arnd@arndb.de,
        namhyung@kernel.org, peterz@infradead.org, alistair23@gmail.com,
        jolsa@redhat.com, dave@stgolabs.net, mingo@redhat.com,
        dvhart@infradead.org, linux-perf-users@vger.kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        Alistair Francis <alistair.francis@wdc.com>,
        Atish Patra <atish.patra@wdc.com>,
        linux-riscv@lists.infradead.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH v3 1/6] perf bench futex: Add support for 32-bit systems
 with 64-bit time_t
Message-ID: <YhoTPvUgZ0oIxDQz@kernel.org>
References: <20211126060024.3290177-1-alistair.francis@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211126060024.3290177-1-alistair.francis@opensource.wdc.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Nov 26, 2021 at 04:00:19PM +1000, Alistair Francis escreveu:
> From: Alistair Francis <alistair.francis@wdc.com>
> 
> Some 32-bit architectures (such are 32-bit RISC-V) only have a 64-bit
> time_t and as such don't have the SYS_futex syscall. This patch will
> allow us to use the SYS_futex_time64 syscall on those platforms.
> 
> This also converts the futex calls to be y2038 safe (when built for a
> 5.1+ kernel).
> 
> This is a revert of commit ba4026b09d83acf56c040b6933eac7916c27e728
> "Revert "perf bench futex: Add support for 32-bit systems with 64-bit time_t"".
> 
> The original commit was reverted as including linux/time_types.h would
> fail to compile on older kernels. This commit doesn't include
> linux/time_types.h to avoid this issue.

With this patch:

   1   101.45 almalinux:8                   : Ok   gcc (GCC) 8.5.0 20210514 (Red Hat 8.5.0-4) , clang version 12.0.1 (Red Hat 12.0.1-4.module_el8.5.0+1025+93159d6c)
   2     8.51 alpine:3.4                    : FAIL gcc version 5.3.0 (Alpine 5.3.0) 
    In file included from bench/futex-hash.c:29:0:
    bench/futex.h:37:2: error: unknown type name '__kernel_old_time_t'
      __kernel_old_time_t tv_sec;  /* seconds */
      ^
    In file included from bench/futex-wake.c:25:0:
    bench/futex.h:37:2: error: unknown type name '__kernel_old_time_t'
      __kernel_old_time_t tv_sec;  /* seconds */
      ^
    /git/perf-5.17.0-rc4/tools/build/Makefile.build:139: recipe for target 'bench' failed
    make[3]: *** [bench] Error 2
   3    15.02 alpine:3.5                    : FAIL gcc version 6.2.1 20160822 (Alpine 6.2.1) 
    In file included from bench/futex-hash.c:29:0:
    bench/futex.h:37:2: error: unknown type name '__kernel_old_time_t'
      __kernel_old_time_t tv_sec;  /* seconds */
      ^~~~~~~~~~~~~~~~~~~
    In file included from bench/futex-wake.c:25:0:
    bench/futex.h:37:2: error: unknown type name '__kernel_old_time_t'
      __kernel_old_time_t tv_sec;  /* seconds */
      ^~~~~~~~~~~~~~~~~~~
    In file included from bench/futex-wake-parallel.c:31:0:
    bench/futex.h:37:2: error: unknown type name '__kernel_old_time_t'
      __kernel_old_time_t tv_sec;  /* seconds */
      ^~~~~~~~~~~~~~~~~~~
    make[3]: *** [/git/perf-5.17.0-rc4/tools/build/Makefile.build:139: bench] Error 2
   4     9.00 alpine:3.6                    : FAIL gcc version 6.3.0 (Alpine 6.3.0) 
    In file included from bench/futex-hash.c:29:0:
    bench/futex.h:37:2: error: unknown type name '__kernel_old_time_t'
      __kernel_old_time_t tv_sec;  /* seconds */
      ^~~~~~~~~~~~~~~~~~~
    In file included from bench/futex-wake.c:25:0:
    bench/futex.h:37:2: error: unknown type name '__kernel_old_time_t'
      __kernel_old_time_t tv_sec;  /* seconds */
      ^~~~~~~~~~~~~~~~~~~
    In file included from bench/futex-wake-parallel.c:31:0:
    bench/futex.h:37:2: error: unknown type name '__kernel_old_time_t'
      __kernel_old_time_t tv_sec;  /* seconds */
      ^~~~~~~~~~~~~~~~~~~
    make[3]: *** [/git/perf-5.17.0-rc4/tools/build/Makefile.build:139: bench] Error 2
   5     9.01 alpine:3.7                    : FAIL gcc version 6.4.0 (Alpine 6.4.0) 
    In file included from bench/futex-hash.c:29:0:
    bench/futex.h:37:2: error: unknown type name '__kernel_old_time_t'
      __kernel_old_time_t tv_sec;  /* seconds */
      ^~~~~~~~~~~~~~~~~~~
    make[3]: *** [/git/perf-5.17.0-rc4/tools/build/Makefile.build:139: bench] Error 2
   6     8.80 alpine:3.8                    : FAIL gcc version 6.4.0 (Alpine 6.4.0) 
    In file included from bench/futex-hash.c:29:0:
    bench/futex.h:37:2: error: unknown type name '__kernel_old_time_t'
      __kernel_old_time_t tv_sec;  /* seconds */
      ^~~~~~~~~~~~~~~~~~~
    make[3]: *** [/git/perf-5.17.0-rc4/tools/build/Makefile.build:139: bench] Error 2
   7     9.81 alpine:3.9                    : FAIL gcc version 8.3.0 (Alpine 8.3.0) 
    In file included from bench/futex-hash.c:29:
    bench/futex.h:37:2: error: unknown type name '__kernel_old_time_t'
      __kernel_old_time_t tv_sec;  /* seconds */
      ^~~~~~~~~~~~~~~~~~~
    make[3]: *** [/git/perf-5.17.0-rc4/tools/build/Makefile.build:139: bench] Error 2
   8     9.80 alpine:3.10                   : FAIL gcc version 8.3.0 (Alpine 8.3.0) 
    In file included from bench/futex-hash.c:29:
    bench/futex.h:37:2: error: unknown type name '__kernel_old_time_t'
      __kernel_old_time_t tv_sec;  /* seconds */
      ^~~~~~~~~~~~~~~~~~~
    make[3]: *** [/git/perf-5.17.0-rc4/tools/build/Makefile.build:139: bench] Error 2
   9    10.81 alpine:3.11                   : FAIL gcc version 9.3.0 (Alpine 9.3.0) 
    In file included from bench/futex-hash.c:29:
    bench/futex.h:37:2: error: unknown type name '__kernel_old_time_t'
       37 |  __kernel_old_time_t tv_sec;  /* seconds */
          |  ^~~~~~~~~~~~~~~~~~~
    In file included from bench/futex-wake.c:25:
    bench/futex.h:37:2: error: unknown type name '__kernel_old_time_t'
       37 |  __kernel_old_time_t tv_sec;  /* seconds */
          |  ^~~~~~~~~~~~~~~~~~~
    make[3]: *** [/git/perf-5.17.0-rc4/tools/build/Makefile.build:139: bench] Error 2
  10    10.21 alpine:3.12                   : FAIL gcc version 9.3.0 (Alpine 9.3.0) 
    In file included from bench/futex-hash.c:29:
    bench/futex.h:37:2: error: unknown type name '__kernel_old_time_t'
       37 |  __kernel_old_time_t tv_sec;  /* seconds */
          |  ^~~~~~~~~~~~~~~~~~~
    make[3]: *** [/git/perf-5.17.0-rc4/tools/build/Makefile.build:139: bench] Error 2
  11   120.31 alpine:3.13                   : Ok   gcc (Alpine 10.2.1_pre1) 10.2.1 20201203 , Alpine clang version 10.0.1 
  12   107.68 alpine:3.14                   : Ok   gcc (Alpine 10.3.1_git20210424) 10.3.1 20210424 , Alpine clang version 11.1.0
  13   107.06 alpine:3.15                   : Ok   gcc (Alpine 10.3.1_git20211027) 10.3.1 20211027 , Alpine clang version 12.0.1
  14   108.78 alpine:edge                   : Ok   gcc (Alpine 11.2.1_git20211128) 11.2.1 20211128 , Alpine clang version 12.0.1
  15     7.79 alt:p8                        : FAIL gcc version 5.3.1 20151207 (ALT p8 5.3.1-alt3.M80P.1) (GCC) 
    In file included from bench/futex-hash.c:29:0:
    bench/futex.h:37:2: error: unknown type name '__kernel_old_time_t'
      __kernel_old_time_t tv_sec;  /* seconds */
      ^
    In file included from bench/futex-wake.c:25:0:
    bench/futex.h:37:2: error: unknown type name '__kernel_old_time_t'
      __kernel_old_time_t tv_sec;  /* seconds */
      ^
    make[3]: *** [bench] Error 2
  16    80.88 alt:p9                        : Ok   x86_64-alt-linux-gcc (GCC) 8.4.1 20200305 (ALT p9 8.4.1-alt0.p9.1) , clang version 10.0.0 
  17    79.87 alt:p10                       : Ok   x86_64-alt-linux-gcc (GCC) 10.3.1 20210703 (ALT Sisyphus 10.3.1-alt2) , clang version 11.0.1
  18    79.18 alt:sisyphus                  : Ok   x86_64-alt-linux-gcc (GCC) 11.2.1 20211202 (ALT Sisyphus 11.2.1-alt2) , ALT Linux Team clang version 12.0.1
  19     8.39 amazonlinux:1                 : FAIL gcc version 7.2.1 20170915 (Red Hat 7.2.1-2) (GCC) 
    In file included from bench/futex-hash.c:29:0:
    bench/futex.h:37:2: error: unknown type name '__kernel_old_time_t'
      __kernel_old_time_t tv_sec;  /* seconds */
      ^~~~~~~~~~~~~~~~~~~
    In file included from bench/futex-wake.c:25:0:
    bench/futex.h:37:2: error: unknown type name '__kernel_old_time_t'
      __kernel_old_time_t tv_sec;  /* seconds */
      ^~~~~~~~~~~~~~~~~~~
    In file included from bench/futex-wake-parallel.c:31:0:
    bench/futex.h:37:2: error: unknown type name '__kernel_old_time_t'
      __kernel_old_time_t tv_sec;  /* seconds */
      ^~~~~~~~~~~~~~~~~~~
    make[3]: *** [bench] Error 2
  20     9.10 amazonlinux:2                 : FAIL gcc version 7.3.1 20180712 (Red Hat 7.3.1-13) (GCC) 
    In file included from bench/futex-hash.c:29:0:
    bench/futex.h:37:2: error: unknown type name '__kernel_old_time_t'
      __kernel_old_time_t tv_sec;  /* seconds */
      ^~~~~~~~~~~~~~~~~~~
    In file included from bench/futex-wake.c:25:0:
    bench/futex.h:37:2: error: unknown type name '__kernel_old_time_t'
      __kernel_old_time_t tv_sec;  /* seconds */
      ^~~~~~~~~~~~~~~~~~~
    make[3]: *** [bench] Error 2
  21    81.17 archlinux:base                : Ok   gcc (GCC) 11.1.0 , clang version 13.0.0
  22    84.48 centos:8                      : Ok   gcc (GCC) 8.4.1 20200928 (Red Hat 8.4.1-1) , clang version 11.0.1 (Red Hat 11.0.1-1.module_el8.4.0+966+2995ef20)
  23    91.62 centos:stream                 : Ok   gcc (GCC) 8.5.0 20210514 (Red Hat 8.5.0-10) , clang version 13.0.0 (Red Hat 13.0.0-3.module_el8.6.0+1074+380cef3f)
  24    50.63 clearlinux:latest             : Ok   gcc (Clear Linux OS for Intel Architecture) 11.2.1 20220215 releases/gcc-11.2.0-770-g2c9485a496 , clang version 13.0.0
  25     7.70 debian:9                      : FAIL gcc version 6.3.0 20170516 (Debian 6.3.0-18+deb9u1) 
    In file included from bench/futex-hash.c:29:0:
    bench/futex.h:37:2: error: unknown type name '__kernel_old_time_t'
      __kernel_old_time_t tv_sec;  /* seconds */
      ^~~~~~~~~~~~~~~~~~~
    /git/perf-5.17.0-rc4/tools/build/Makefile.build:139: recipe for target 'bench' failed
    make[3]: *** [bench] Error 2
  26    18.76 debian:10                     : FAIL gcc version 8.3.0 (Debian 8.3.0-6) 
    In file included from bench/futex-wake.c:25:
    bench/futex.h:37:2: error: unknown type name '__kernel_old_time_t'
      __kernel_old_time_t tv_sec;  /* seconds */
      ^~~~~~~~~~~~~~~~~~~
    In file included from bench/futex-hash.c:29:
    bench/futex.h:37:2: error: unknown type name '__kernel_old_time_t'
      __kernel_old_time_t tv_sec;  /* seconds */
      ^~~~~~~~~~~~~~~~~~~
    In file included from bench/futex-wake-parallel.c:31:
    bench/futex.h:37:2: error: unknown type name '__kernel_old_time_t'
      __kernel_old_time_t tv_sec;  /* seconds */
      ^~~~~~~~~~~~~~~~~~~
    make[3]: *** [/git/perf-5.17.0-rc4/tools/build/Makefile.build:139: bench] Error 2
  27    88.71 debian:11                     : Ok   gcc (Debian 10.2.1-6) 10.2.1 20210110 , Debian clang version 11.0.1-2
  28   102.77 debian:experimental           : Ok   gcc (Debian 11.2.0-14) 11.2.0 , Debian clang version 13.0.1-+rc3-1~exp1+b1
  29    24.47 debian:experimental-x-arm64   : Ok   aarch64-linux-gnu-gcc (Debian 11.2.0-9) 11.2.0 
  30    20.15 debian:experimental-x-mips    : Ok   mips-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110 
  31    22.26 debian:experimental-x-mips64  : Ok   mips64-linux-gnuabi64-gcc (Debian 10.2.1-6) 10.2.1 20210110 
  32    23.07 debian:experimental-x-mipsel  : Ok   mipsel-linux-gnu-gcc (Debian 11.2.0-9) 11.2.0 
  33     8.50 fedora:22                     : FAIL gcc version 5.3.1 20160406 (Red Hat 5.3.1-6) (GCC) 
    In file included from bench/futex-hash.c:29:0:
    bench/futex.h:37:2: error: unknown type name '__kernel_old_time_t'
      __kernel_old_time_t tv_sec;  /* seconds */
      ^
    /git/perf-5.17.0-rc4/tools/build/Makefile.build:139: recipe for target 'bench' failed
    make[3]: *** [bench] Error 2
  34     8.50 fedora:23                     : FAIL gcc version 5.3.1 20160406 (Red Hat 5.3.1-6) (GCC) 
    In file included from bench/futex-hash.c:29:0:
    bench/futex.h:37:2: error: unknown type name '__kernel_old_time_t'
      __kernel_old_time_t tv_sec;  /* seconds */
      ^
    In file included from bench/futex-wake.c:25:0:
    bench/futex.h:37:2: error: unknown type name '__kernel_old_time_t'
      __kernel_old_time_t tv_sec;  /* seconds */
      ^
    /git/perf-5.17.0-rc4/tools/build/Makefile.build:139: recipe for target 'bench' failed
    make[3]: *** [bench] Error 2
  35     8.90 fedora:24                     : FAIL gcc version 6.3.1 20161221 (Red Hat 6.3.1-1) (GCC) 
    In file included from bench/futex-hash.c:29:0:
    bench/futex.h:37:2: error: unknown type name '__kernel_old_time_t'
      __kernel_old_time_t tv_sec;  /* seconds */
      ^~~~~~~~~~~~~~~~~~~
    In file included from bench/futex-wake.c:25:0:
    bench/futex.h:37:2: error: unknown type name '__kernel_old_time_t'
      __kernel_old_time_t tv_sec;  /* seconds */
      ^~~~~~~~~~~~~~~~~~~
    In file included from bench/futex-wake-parallel.c:31:0:
    bench/futex.h:37:2: error: unknown type name '__kernel_old_time_t'
      __kernel_old_time_t tv_sec;  /* seconds */
      ^~~~~~~~~~~~~~~~~~~
    /git/perf-5.17.0-rc4/tools/build/Makefile.build:139: recipe for target 'bench' failed
    make[3]: *** [bench] Error 2
  36    11.51 fedora:24-x-ARC-uClibc        : FAIL gcc version 7.1.1 20170710 (ARCompact ISA Linux uClibc toolchain 2017.09-rc2) 
    In file included from bench/futex-hash.c:29:0:
    bench/futex.h:37:2: error: unknown type name '__kernel_old_time_t'
      __kernel_old_time_t tv_sec;  /* seconds */
      ^~~~~~~~~~~~~~~~~~~
    In file included from bench/futex-wake.c:25:0:
    bench/futex.h:37:2: error: unknown type name '__kernel_old_time_t'
      __kernel_old_time_t tv_sec;  /* seconds */
      ^~~~~~~~~~~~~~~~~~~
    In file included from bench/futex-wake-parallel.c:31:0:
    bench/futex.h:37:2: error: unknown type name '__kernel_old_time_t'
      __kernel_old_time_t tv_sec;  /* seconds */
      ^~~~~~~~~~~~~~~~~~~
    In file included from bench/futex-requeue.c:26:0:
    bench/futex.h:37:2: error: unknown type name '__kernel_old_time_t'
      __kernel_old_time_t tv_sec;  /* seconds */
      ^~~~~~~~~~~~~~~~~~~
    /git/perf-5.17.0-rc4/tools/build/Makefile.build:139: recipe for target 'bench' failed
    make[3]: *** [bench] Error 2
  37     9.00 fedora:25                     : FAIL gcc version 6.4.1 20170727 (Red Hat 6.4.1-1) (GCC) 
    In file included from bench/futex-hash.c:29:0:
    bench/futex.h:37:2: error: unknown type name '__kernel_old_time_t'
      __kernel_old_time_t tv_sec;  /* seconds */
      ^~~~~~~~~~~~~~~~~~~
    In file included from bench/futex-wake.c:25:0:
    bench/futex.h:37:2: error: unknown type name '__kernel_old_time_t'
      __kernel_old_time_t tv_sec;  /* seconds */
      ^~~~~~~~~~~~~~~~~~~
    /git/perf-5.17.0-rc4/tools/build/Makefile.build:139: recipe for target 'bench' failed
    make[3]: *** [bench] Error 2
  38     9.31 fedora:26                     : FAIL gcc version 7.3.1 20180130 (Red Hat 7.3.1-2) (GCC) 
    In file included from bench/futex-wake.c:25:0:
    bench/futex.h:37:2: error: unknown type name '__kernel_old_time_t'
      __kernel_old_time_t tv_sec;  /* seconds */
      ^~~~~~~~~~~~~~~~~~~
    In file included from bench/futex-hash.c:29:0:
    bench/futex.h:37:2: error: unknown type name '__kernel_old_time_t'
      __kernel_old_time_t tv_sec;  /* seconds */
      ^~~~~~~~~~~~~~~~~~~
    In file included from bench/futex-wake-parallel.c:31:0:
    bench/futex.h:37:2: error: unknown type name '__kernel_old_time_t'
      __kernel_old_time_t tv_sec;  /* seconds */
      ^~~~~~~~~~~~~~~~~~~
    make[3]: *** [/git/perf-5.17.0-rc4/tools/build/Makefile.build:139: bench] Error 2
  39     9.20 fedora:27                     : FAIL gcc version 7.3.1 20180712 (Red Hat 7.3.1-6) (GCC) 
    In file included from bench/futex-hash.c:29:0:
    bench/futex.h:37:2: error: unknown type name '__kernel_old_time_t'
      __kernel_old_time_t tv_sec;  /* seconds */
      ^~~~~~~~~~~~~~~~~~~
    In file included from bench/futex-wake.c:25:0:
    bench/futex.h:37:2: error: unknown type name '__kernel_old_time_t'
      __kernel_old_time_t tv_sec;  /* seconds */
      ^~~~~~~~~~~~~~~~~~~
    In file included from bench/futex-requeue.c:26:0:
    bench/futex.h:37:2: error: unknown type name '__kernel_old_time_t'
      __kernel_old_time_t tv_sec;  /* seconds */
      ^~~~~~~~~~~~~~~~~~~
    In file included from bench/futex-wake-parallel.c:31:0:
    bench/futex.h:37:2: error: unknown type name '__kernel_old_time_t'
      __kernel_old_time_t tv_sec;  /* seconds */
      ^~~~~~~~~~~~~~~~~~~
    make[3]: *** [/git/perf-5.17.0-rc4/tools/build/Makefile.build:139: bench] Error 2
  40     9.60 fedora:28                     : FAIL gcc version 8.3.1 20190223 (Red Hat 8.3.1-2) (GCC) 
    In file included from bench/futex-hash.c:29:
    bench/futex.h:37:2: error: unknown type name '__kernel_old_time_t'
      __kernel_old_time_t tv_sec;  /* seconds */
      ^~~~~~~~~~~~~~~~~~~
    In file included from bench/futex-wake.c:25:
    bench/futex.h:37:2: error: unknown type name '__kernel_old_time_t'
      __kernel_old_time_t tv_sec;  /* seconds */
      ^~~~~~~~~~~~~~~~~~~
    make[3]: *** [/git/perf-5.17.0-rc4/tools/build/Makefile.build:139: bench] Error 2
  41    10.11 fedora:29                     : FAIL gcc version 8.3.1 20190223 (Red Hat 8.3.1-2) (GCC) 
    In file included from bench/futex-hash.c:29:
    bench/futex.h:37:2: error: unknown type name '__kernel_old_time_t'
      __kernel_old_time_t tv_sec;  /* seconds */
      ^~~~~~~~~~~~~~~~~~~
    make[3]: *** [/git/perf-5.17.0-rc4/tools/build/Makefile.build:139: bench] Error 2
  42   104.33 fedora:30                     : Ok   gcc (GCC) 9.3.1 20200408 (Red Hat 9.3.1-2) , clang version 8.0.0 (Fedora 8.0.0-3.fc30)
  43    96.30 fedora:31                     : Ok   gcc (GCC) 9.3.1 20200408 (Red Hat 9.3.1-2) , clang version 9.0.1 (Fedora 9.0.1-4.fc31)
  44    90.41 fedora:32                     : Ok   gcc (GCC) 10.3.1 20210422 (Red Hat 10.3.1-1) , clang version 10.0.1 (Fedora 10.0.1-3.fc32)
  45    89.81 fedora:33                     : Ok   gcc (GCC) 10.3.1 20210422 (Red Hat 10.3.1-1) , clang version 11.0.0 (Fedora 11.0.0-3.fc33)
  46    92.32 fedora:34                     : Ok   gcc (GCC) 11.2.1 20210728 (Red Hat 11.2.1-1) , clang version 12.0.1 (Fedora 12.0.1-1.fc34)
  47     7.20 fedora:34-x-ARC-glibc         : FAIL gcc version 8.3.1 20190225 (ARC HS GNU/Linux glibc toolchain 2019.03-rc1) 
    In file included from bench/futex-hash.c:29:
    bench/futex.h:37:2: error: unknown type name '__kernel_old_time_t'
      __kernel_old_time_t tv_sec;  /* seconds */
      ^~~~~~~~~~~~~~~~~~~
    In file included from bench/futex-wake.c:25:
    bench/futex.h:37:2: error: unknown type name '__kernel_old_time_t'
      __kernel_old_time_t tv_sec;  /* seconds */
      ^~~~~~~~~~~~~~~~~~~
    In file included from bench/futex-wake-parallel.c:31:
    bench/futex.h:37:2: error: unknown type name '__kernel_old_time_t'
      __kernel_old_time_t tv_sec;  /* seconds */
      ^~~~~~~~~~~~~~~~~~~
    make[3]: *** [/git/perf-5.17.0-rc4/tools/build/Makefile.build:139: bench] Error 2
  48     6.39 fedora:34-x-ARC-uClibc        : FAIL gcc version 8.3.1 20190225 (ARCv2 ISA Linux uClibc toolchain 2019.03-rc1) 
    In file included from bench/futex-hash.c:29:
    bench/futex.h:37:2: error: unknown type name '__kernel_old_time_t'
      __kernel_old_time_t tv_sec;  /* seconds */
      ^~~~~~~~~~~~~~~~~~~
    In file included from bench/futex-wake.c:25:
    bench/futex.h:37:2: error: unknown type name '__kernel_old_time_t'
      __kernel_old_time_t tv_sec;  /* seconds */
      ^~~~~~~~~~~~~~~~~~~
    In file included from bench/futex-wake-parallel.c:31:
    bench/futex.h:37:2: error: unknown type name '__kernel_old_time_t'
      __kernel_old_time_t tv_sec;  /* seconds */
      ^~~~~~~~~~~~~~~~~~~
    In file included from bench/futex-requeue.c:26:
    bench/futex.h:37:2: error: unknown type name '__kernel_old_time_t'
      __kernel_old_time_t tv_sec;  /* seconds */
      ^~~~~~~~~~~~~~~~~~~
    In file included from bench/futex-lock-pi.c:19:
    bench/futex.h:37:2: error: unknown type name '__kernel_old_time_t'
      __kernel_old_time_t tv_sec;  /* seconds */
      ^~~~~~~~~~~~~~~~~~~
    make[3]: *** [/git/perf-5.17.0-rc4/tools/build/Makefile.build:139: bench] Error 2
  49    95.94 fedora:35                     : Ok   gcc (GCC) 11.2.1 20211203 (Red Hat 11.2.1-7) , clang version 13.0.0 (Fedora 13.0.0-3.fc35)
  50   107.18 fedora:rawhide                : Ok   gcc (GCC) 12.0.1 20220205 (Red Hat 12.0.1-0) , clang version 13.0.0 (Fedora 13.0.0-5.fc36)
  51    83.10 gentoo-stage3:latest          : Ok   gcc (Gentoo 11.2.0 p1) 11.2.0 , clang version 13.0.0
  52     9.41 mageia:6                      : FAIL gcc version 5.5.0 (Mageia 5.5.0-1.mga6) 
    In file included from bench/futex-hash.c:29:0:
    bench/futex.h:37:2: error: unknown type name '__kernel_old_time_t'
      __kernel_old_time_t tv_sec;  /* seconds */
      ^
    In file included from bench/futex-wake.c:25:0:
    bench/futex.h:37:2: error: unknown type name '__kernel_old_time_t'
      __kernel_old_time_t tv_sec;  /* seconds */
      ^
    /git/perf-5.17.0-rc4/tools/build/Makefile.build:139: recipe for target 'bench' failed
    make[3]: *** [bench] Error 2
  53    40.71 mageia:7                      : FAIL clang version 8.0.0 (Mageia 8.0.0-1.mga7)
          yychar = yylex (&yylval, &yylloc, scanner);
                   ^
    #define yylex           parse_events_lex
                            ^
    1 error generated.
    make[3]: *** [/git/perf-5.17.0-rc4/tools/build/Makefile.build:139: util] Error 2
  54    92.83 manjaro:base                  : Ok   gcc (GCC) 11.1.0 , clang version 13.0.0
  55     6.49 openmandriva:4.2              : FAIL gcc version 11.2.0 20210728 (OpenMandriva) (GCC) 
    In file included from builtin-bench.c:22:
    bench/bench.h:66:19: error: conflicting types for 'pthread_attr_setaffinity_np'; have 'int(pthread_attr_t *, size_t,  cpu_set_t *)' {aka 'int(pthread_attr_t *, long unsigned int,  cpu_set_t *)'}
       66 | static inline int pthread_attr_setaffinity_np(pthread_attr_t *attr __maybe_unused,
          |                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~
    In file included from bench/bench.h:64,
                     from builtin-bench.c:22:
    /usr/include/pthread.h:394:12: note: previous declaration of 'pthread_attr_setaffinity_np' with type 'int(pthread_attr_t *, size_t,  const cpu_set_t *)' {aka 'int(pthread_attr_t *, long unsigned int,  const cpu_set_t *)'}
      394 | extern int pthread_attr_setaffinity_np (pthread_attr_t *__attr,
          |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~
    ld: warning: -r and --gc-sections may not be used together, disabling --gc-sections
    ld: warning: -r and --icf may not be used together, disabling --icf
    ld: warning: -r and --gc-sections may not be used together, disabling --gc-sections
    ld: warning: -r and --icf may not be used together, disabling --icf
    ld: warning: -r and --gc-sections may not be used together, disabling --gc-sections
    ld: warning: -r and --icf may not be used together, disabling --icf
  56     6.18 openmandriva:cooker           : FAIL gcc version 11.2.0 20210728 (OpenMandriva) (GCC) 
    In file included from builtin-bench.c:22:
    bench/bench.h:66:19: error: conflicting types for 'pthread_attr_setaffinity_np'; have 'int(pthread_attr_t *, size_t,  cpu_set_t *)' {aka 'int(pthread_attr_t *, long unsigned int,  cpu_set_t *)'}
       66 | static inline int pthread_attr_setaffinity_np(pthread_attr_t *attr __maybe_unused,
          |                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~
    In file included from bench/bench.h:64,
                     from builtin-bench.c:22:
    /usr/include/pthread.h:394:12: note: previous declaration of 'pthread_attr_setaffinity_np' with type 'int(pthread_attr_t *, size_t,  const cpu_set_t *)' {aka 'int(pthread_attr_t *, long unsigned int,  const cpu_set_t *)'}
      394 | extern int pthread_attr_setaffinity_np (pthread_attr_t *__attr,
          |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~
    ld: warning: -r and --gc-sections may not be used together, disabling --gc-sections
    ld: warning: -r and --icf may not be used together, disabling --icf
    ld: warning: -r and --gc-sections may not be used together, disabling --gc-sections
    ld: warning: -r and --icf may not be used together, disabling --icf
  57    12.82 opensuse:15.0                 : FAIL gcc version 7.4.1 20190905 [gcc-7-branch revision 275407] (SUSE Linux) 
    Makefile.config:1005: No libbabeltrace found, disables 'perf data' CTF format support, please install libbabeltrace-dev[el]/libbabeltrace-ctf-dev
    update-alternatives: error: no alternatives for java
    update-alternatives: error: no alternatives for java
    Makefile.config:1052: No openjdk development package found, please install JDK package, e.g. openjdk-8-jdk, java-1.8.0-openjdk-devel
    
    Auto-detecting system features:
    ...                         dwarf: [ on  ]
    ...            dwarf_getlocations: [ on  ]
    ...                         glibc: [ on  ]
    ...                        libbfd: [ OFF ]
    ...                libbfd-buildid: [ OFF ]
    ...                        libcap: [ on  ]
    ...                        libelf: [ on  ]
    ...                       libnuma: [ on  ]
    ...        numa_num_possible_cpus: [ on  ]
    ...                       libperl: [ on  ]
    ...                     libpython: [ on  ]
    ...                     libcrypto: [ on  ]
    ...                     libunwind: [ on  ]
    ...            libdw-dwarf-unwind: [ on  ]
    ...                          zlib: [ on  ]
    ...                          lzma: [ on  ]
    ...                     get_cpuid: [ on  ]
    ...                           bpf: [ on  ]
    ...                        libaio: [ on  ]
    ...                       libzstd: [ on  ]
    ...        disassembler-four-args: [ on  ]
    
    
      PERF_VERSION = 5.17.rc4.gec9389ea0661
      GEN     perf-archive
      GEN     perf-with-kcore
      GEN     perf-iostat
    --
    In file included from bench/futex-hash.c:29:0:
    bench/futex.h:37:2: error: unknown type name '__kernel_old_time_t'
      __kernel_old_time_t tv_sec;  /* seconds */
      ^~~~~~~~~~~~~~~~~~~
    make[3]: *** [/git/perf-5.17.0-rc4/tools/build/Makefile.build:139: bench] Error 2
  58    13.11 opensuse:15.1                 : FAIL gcc version 7.5.0 (SUSE Linux) 
    Makefile.config:1005: No libbabeltrace found, disables 'perf data' CTF format support, please install libbabeltrace-dev[el]/libbabeltrace-ctf-dev
    update-alternatives: error: no alternatives for java
    update-alternatives: error: no alternatives for java
    Makefile.config:1052: No openjdk development package found, please install JDK package, e.g. openjdk-8-jdk, java-1.8.0-openjdk-devel
    
    Auto-detecting system features:
    ...                         dwarf: [ on  ]
    ...            dwarf_getlocations: [ on  ]
    ...                         glibc: [ on  ]
    ...                        libbfd: [ OFF ]
    ...                libbfd-buildid: [ OFF ]
    ...                        libcap: [ on  ]
    ...                        libelf: [ on  ]
    ...                       libnuma: [ on  ]
    ...        numa_num_possible_cpus: [ on  ]
    ...                       libperl: [ on  ]
    ...                     libpython: [ on  ]
    ...                     libcrypto: [ on  ]
    ...                     libunwind: [ on  ]
    ...            libdw-dwarf-unwind: [ on  ]
    ...                          zlib: [ on  ]
    ...                          lzma: [ on  ]
    ...                     get_cpuid: [ on  ]
    ...                           bpf: [ on  ]
    ...                        libaio: [ on  ]
    ...                       libzstd: [ on  ]
    ...        disassembler-four-args: [ on  ]
    
    
      PERF_VERSION = 5.17.rc4.gec9389ea0661
      GEN     perf-archive
      GEN     perf-with-kcore
      GEN     perf-iostat
    --
    In file included from bench/futex-hash.c:29:0:
    bench/futex.h:37:2: error: unknown type name '__kernel_old_time_t'
      __kernel_old_time_t tv_sec;  /* seconds */
      ^~~~~~~~~~~~~~~~~~~
    make[3]: *** [/git/perf-5.17.0-rc4/tools/build/Makefile.build:139: bench] Error 2
  59    13.21 opensuse:15.2                 : FAIL gcc version 7.5.0 (SUSE Linux) 
    Makefile.config:1005: No libbabeltrace found, disables 'perf data' CTF format support, please install libbabeltrace-dev[el]/libbabeltrace-ctf-dev
    update-alternatives: error: no alternatives for java
    update-alternatives: error: no alternatives for java
    Makefile.config:1052: No openjdk development package found, please install JDK package, e.g. openjdk-8-jdk, java-1.8.0-openjdk-devel
    
    Auto-detecting system features:
    ...                         dwarf: [ on  ]
    ...            dwarf_getlocations: [ on  ]
    ...                         glibc: [ on  ]
    ...                        libbfd: [ OFF ]
    ...                libbfd-buildid: [ OFF ]
    ...                        libcap: [ on  ]
    ...                        libelf: [ on  ]
    ...                       libnuma: [ on  ]
    ...        numa_num_possible_cpus: [ on  ]
    ...                       libperl: [ on  ]
    ...                     libpython: [ on  ]
    ...                     libcrypto: [ on  ]
    ...                     libunwind: [ on  ]
    ...            libdw-dwarf-unwind: [ on  ]
    ...                          zlib: [ on  ]
    ...                          lzma: [ on  ]
    ...                     get_cpuid: [ on  ]
    ...                           bpf: [ on  ]
    ...                        libaio: [ on  ]
    ...                       libzstd: [ on  ]
    ...        disassembler-four-args: [ on  ]
    
    
      PERF_VERSION = 5.17.rc4.gec9389ea0661
      GEN     perf-archive
      GEN     perf-with-kcore
      GEN     perf-iostat
    --
    In file included from bench/futex-hash.c:29:0:
    bench/futex.h:37:2: error: unknown type name '__kernel_old_time_t'
      __kernel_old_time_t tv_sec;  /* seconds */
      ^~~~~~~~~~~~~~~~~~~
    In file included from bench/futex-wake.c:25:0:
    bench/futex.h:37:2: error: unknown type name '__kernel_old_time_t'
      __kernel_old_time_t tv_sec;  /* seconds */
      ^~~~~~~~~~~~~~~~~~~
    In file included from bench/futex-wake-parallel.c:31:0:
    bench/futex.h:37:2: error: unknown type name '__kernel_old_time_t'
      __kernel_old_time_t tv_sec;  /* seconds */
      ^~~~~~~~~~~~~~~~~~~
    make[3]: *** [/git/perf-5.17.0-rc4/tools/build/Makefile.build:139: bench] Error 2
  60    14.42 opensuse:15.3                 : FAIL gcc version 7.5.0 (SUSE Linux) 
    Makefile.config:1005: No libbabeltrace found, disables 'perf data' CTF format support, please install libbabeltrace-dev[el]/libbabeltrace-ctf-dev
    update-alternatives: error: no alternatives for java
    update-alternatives: error: no alternatives for java
    Makefile.config:1052: No openjdk development package found, please install JDK package, e.g. openjdk-8-jdk, java-1.8.0-openjdk-devel
    
    Auto-detecting system features:
    ...                         dwarf: [ on  ]
    ...            dwarf_getlocations: [ on  ]
    ...                         glibc: [ on  ]
    ...                        libbfd: [ OFF ]
    ...                libbfd-buildid: [ OFF ]
    ...                        libcap: [ on  ]
    ...                        libelf: [ on  ]
    ...                       libnuma: [ on  ]
    ...        numa_num_possible_cpus: [ on  ]
    ...                       libperl: [ on  ]
    ...                     libpython: [ on  ]
    ...                     libcrypto: [ on  ]
    ...                     libunwind: [ on  ]
    ...            libdw-dwarf-unwind: [ on  ]
    ...                          zlib: [ on  ]
    ...                          lzma: [ on  ]
    ...                     get_cpuid: [ on  ]
    ...                           bpf: [ on  ]
    ...                        libaio: [ on  ]
    ...                       libzstd: [ on  ]
    ...        disassembler-four-args: [ on  ]
    
    
      PERF_VERSION = 5.17.rc4.gec9389ea0661
      GEN     perf-archive
      GEN     perf-with-kcore
      GEN     perf-iostat
    --
    In file included from bench/futex-hash.c:29:0:
    bench/futex.h:37:2: error: unknown type name '__kernel_old_time_t'
      __kernel_old_time_t tv_sec;  /* seconds */
      ^~~~~~~~~~~~~~~~~~~
    In file included from bench/futex-wake.c:25:0:
    bench/futex.h:37:2: error: unknown type name '__kernel_old_time_t'
      __kernel_old_time_t tv_sec;  /* seconds */
      ^~~~~~~~~~~~~~~~~~~
    In file included from bench/futex-requeue.c:26:0:
    bench/futex.h:37:2: error: unknown type name '__kernel_old_time_t'
      __kernel_old_time_t tv_sec;  /* seconds */
      ^~~~~~~~~~~~~~~~~~~
    In file included from bench/futex-lock-pi.c:19:0:
    bench/futex.h:37:2: error: unknown type name '__kernel_old_time_t'
      __kernel_old_time_t tv_sec;  /* seconds */
      ^~~~~~~~~~~~~~~~~~~
    In file included from bench/futex-wake-parallel.c:31:0:
    bench/futex.h:37:2: error: unknown type name '__kernel_old_time_t'
      __kernel_old_time_t tv_sec;  /* seconds */
      ^~~~~~~~~~~~~~~~~~~
    make[3]: *** [/git/perf-5.17.0-rc4/tools/build/Makefile.build:139: bench] Error 2
  61   120.78 opensuse:15.4                 : Ok   gcc (SUSE Linux) 7.5.0 , clang version 11.0.1
  62   137.24 opensuse:tumbleweed           : Ok   gcc (SUSE Linux) 11.2.1 20211124 [revision 7510c23c1ec53aa4a62705f0384079661342ff7b] , clang version 13.0.0
  63    99.03 oraclelinux:8                 : Ok   gcc (GCC) 8.5.0 20210514 (Red Hat 8.5.0-4.0.1) , clang version 12.0.1 (Red Hat 12.0.1-4.0.1.module+el8.5.0+20428+2b4ecd47)
  64   100.63 rockylinux:8                  : Ok   gcc (GCC) 8.5.0 20210514 (Red Hat 8.5.0-4) , clang version 12.0.1 (Red Hat 12.0.1-4.module+el8.5.0+715+58f51d49)
  65     8.40 ubuntu:16.04                  : FAIL gcc version 5.4.0 20160609 (Ubuntu 5.4.0-6ubuntu1~16.04.12) 
    In file included from bench/futex-hash.c:29:0:
    bench/futex.h:37:2: error: unknown type name '__kernel_old_time_t'
      __kernel_old_time_t tv_sec;  /* seconds */
      ^
    In file included from bench/futex-wake.c:25:0:
    bench/futex.h:37:2: error: unknown type name '__kernel_old_time_t'
      __kernel_old_time_t tv_sec;  /* seconds */
      ^
    /git/perf-5.17.0-rc4/tools/build/Makefile.build:139: recipe for target 'bench' failed
    make[3]: *** [bench] Error 2
  66     7.10 ubuntu:16.04-x-arm            : FAIL gcc version 5.4.0 20160609 (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9) 
    In file included from bench/futex-hash.c:29:0:
    bench/futex.h:37:2: error: unknown type name '__kernel_old_time_t'
      __kernel_old_time_t tv_sec;  /* seconds */
      ^
    In file included from bench/futex-wake.c:25:0:
    bench/futex.h:37:2: error: unknown type name '__kernel_old_time_t'
      __kernel_old_time_t tv_sec;  /* seconds */
      ^
    /git/perf-5.17.0-rc4/tools/build/Makefile.build:139: recipe for target 'bench' failed
    make[3]: *** [bench] Error 2
  67     7.20 ubuntu:16.04-x-arm64          : FAIL gcc version 5.4.0 20160609 (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9) 
    In file included from bench/futex-hash.c:29:0:
    bench/futex.h:37:2: error: unknown type name '__kernel_old_time_t'
      __kernel_old_time_t tv_sec;  /* seconds */
      ^
    In file included from bench/futex-wake.c:25:0:
    bench/futex.h:37:2: error: unknown type name '__kernel_old_time_t'
      __kernel_old_time_t tv_sec;  /* seconds */
      ^
    /git/perf-5.17.0-rc4/tools/build/Makefile.build:139: recipe for target 'bench' failed
    make[3]: *** [bench] Error 2
  68     7.10 ubuntu:16.04-x-powerpc        : FAIL gcc version 5.4.0 20160609 (Ubuntu 5.4.0-6ubuntu1~16.04.9) 
    In file included from bench/futex-hash.c:29:0:
    bench/futex.h:37:2: error: unknown type name '__kernel_old_time_t'
      __kernel_old_time_t tv_sec;  /* seconds */
      ^
    In file included from bench/futex-wake.c:25:0:
    bench/futex.h:37:2: error: unknown type name '__kernel_old_time_t'
      __kernel_old_time_t tv_sec;  /* seconds */
      ^
    In file included from bench/futex-wake-parallel.c:31:0:
    bench/futex.h:37:2: error: unknown type name '__kernel_old_time_t'
      __kernel_old_time_t tv_sec;  /* seconds */
      ^
    /git/perf-5.17.0-rc4/tools/build/Makefile.build:139: recipe for target 'bench' failed
    make[3]: *** [bench] Error 2
  69     7.30 ubuntu:16.04-x-powerpc64      : FAIL gcc version 5.4.0 20160609 (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.9) 
    In file included from bench/futex-hash.c:29:0:
    bench/futex.h:37:2: error: unknown type name '__kernel_old_time_t'
      __kernel_old_time_t tv_sec;  /* seconds */
      ^
    /git/perf-5.17.0-rc4/tools/build/Makefile.build:139: recipe for target 'bench' failed
    make[3]: *** [bench] Error 2
  70     7.00 ubuntu:16.04-x-powerpc64el    : FAIL gcc version 5.4.0 20160609 (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.9) 
    In file included from bench/futex-hash.c:29:0:
    bench/futex.h:37:2: error: unknown type name '__kernel_old_time_t'
      __kernel_old_time_t tv_sec;  /* seconds */
      ^
    /git/perf-5.17.0-rc4/tools/build/Makefile.build:139: recipe for target 'bench' failed
    make[3]: *** [bench] Error 2
  71     6.70 ubuntu:16.04-x-s390           : FAIL gcc version 5.4.0 20160609 (Ubuntu 5.4.0-6ubuntu1~16.04.9) 
    In file included from bench/futex-hash.c:29:0:
    bench/futex.h:37:2: error: unknown type name '__kernel_old_time_t'
      __kernel_old_time_t tv_sec;  /* seconds */
      ^
    /git/perf-5.17.0-rc4/tools/build/Makefile.build:139: recipe for target 'bench' failed
    make[3]: *** [bench] Error 2
  72     9.00 ubuntu:18.04                  : FAIL gcc version 7.5.0 (Ubuntu 7.5.0-3ubuntu1~18.04) 
    In file included from bench/futex-hash.c:29:0:
    bench/futex.h:37:2: error: unknown type name '__kernel_old_time_t'
      __kernel_old_time_t tv_sec;  /* seconds */
      ^~~~~~~~~~~~~~~~~~~
    In file included from bench/futex-wake.c:25:0:
    bench/futex.h:37:2: error: unknown type name '__kernel_old_time_t'
      __kernel_old_time_t tv_sec;  /* seconds */
      ^~~~~~~~~~~~~~~~~~~
    /git/perf-5.17.0-rc4/tools/build/Makefile.build:139: recipe for target 'bench' failed
    make[3]: *** [bench] Error 2
  73     7.60 ubuntu:18.04-x-arm            : FAIL gcc version 7.5.0 (Ubuntu/Linaro 7.5.0-3ubuntu1~18.04) 
    In file included from bench/futex-hash.c:29:0:
    bench/futex.h:37:2: error: unknown type name '__kernel_old_time_t'
      __kernel_old_time_t tv_sec;  /* seconds */
      ^~~~~~~~~~~~~~~~~~~
    In file included from bench/futex-wake.c:25:0:
    bench/futex.h:37:2: error: unknown type name '__kernel_old_time_t'
      __kernel_old_time_t tv_sec;  /* seconds */
      ^~~~~~~~~~~~~~~~~~~
    /git/perf-5.17.0-rc4/tools/build/Makefile.build:139: recipe for target 'bench' failed
    make[3]: *** [bench] Error 2
  74     7.70 ubuntu:18.04-x-arm64          : FAIL gcc version 7.5.0 (Ubuntu/Linaro 7.5.0-3ubuntu1~18.04) 
    In file included from bench/futex-hash.c:29:0:
    bench/futex.h:37:2: error: unknown type name '__kernel_old_time_t'
      __kernel_old_time_t tv_sec;  /* seconds */
      ^~~~~~~~~~~~~~~~~~~
    In file included from bench/futex-wake.c:25:0:
    bench/futex.h:37:2: error: unknown type name '__kernel_old_time_t'
      __kernel_old_time_t tv_sec;  /* seconds */
      ^~~~~~~~~~~~~~~~~~~
    In file included from bench/futex-wake-parallel.c:31:0:
    bench/futex.h:37:2: error: unknown type name '__kernel_old_time_t'
      __kernel_old_time_t tv_sec;  /* seconds */
      ^~~~~~~~~~~~~~~~~~~
    /git/perf-5.17.0-rc4/tools/build/Makefile.build:139: recipe for target 'bench' failed
    make[3]: *** [bench] Error 2
  75     6.39 ubuntu:18.04-x-m68k           : FAIL gcc version 7.5.0 (Ubuntu 7.5.0-3ubuntu1~18.04) 
    In file included from bench/futex-hash.c:29:0:
    bench/futex.h:37:2: error: unknown type name '__kernel_old_time_t'
      __kernel_old_time_t tv_sec;  /* seconds */
      ^~~~~~~~~~~~~~~~~~~
    In file included from bench/futex-wake.c:25:0:
    bench/futex.h:37:2: error: unknown type name '__kernel_old_time_t'
      __kernel_old_time_t tv_sec;  /* seconds */
      ^~~~~~~~~~~~~~~~~~~
    In file included from bench/futex-wake-parallel.c:31:0:
    bench/futex.h:37:2: error: unknown type name '__kernel_old_time_t'
      __kernel_old_time_t tv_sec;  /* seconds */
      ^~~~~~~~~~~~~~~~~~~
    /git/perf-5.17.0-rc4/tools/build/Makefile.build:139: recipe for target 'bench' failed
    make[3]: *** [bench] Error 2
  76     7.50 ubuntu:18.04-x-powerpc        : FAIL gcc version 7.5.0 (Ubuntu 7.5.0-3ubuntu1~18.04) 
    In file included from bench/futex-hash.c:29:0:
    bench/futex.h:37:2: error: unknown type name '__kernel_old_time_t'
      __kernel_old_time_t tv_sec;  /* seconds */
      ^~~~~~~~~~~~~~~~~~~
    /git/perf-5.17.0-rc4/tools/build/Makefile.build:139: recipe for target 'bench' failed
    make[3]: *** [bench] Error 2
  77     8.10 ubuntu:18.04-x-powerpc64      : FAIL gcc version 7.5.0 (Ubuntu 7.5.0-3ubuntu1~18.04) 
    In file included from bench/futex-hash.c:29:0:
    bench/futex.h:37:2: error: unknown type name '__kernel_old_time_t'
      __kernel_old_time_t tv_sec;  /* seconds */
      ^~~~~~~~~~~~~~~~~~~
    In file included from bench/futex-wake.c:25:0:
    bench/futex.h:37:2: error: unknown type name '__kernel_old_time_t'
      __kernel_old_time_t tv_sec;  /* seconds */
      ^~~~~~~~~~~~~~~~~~~
    In file included from bench/futex-wake-parallel.c:31:0:
    bench/futex.h:37:2: error: unknown type name '__kernel_old_time_t'
      __kernel_old_time_t tv_sec;  /* seconds */
      ^~~~~~~~~~~~~~~~~~~
    /git/perf-5.17.0-rc4/tools/build/Makefile.build:139: recipe for target 'bench' failed
    make[3]: *** [bench] Error 2
  78     8.10 ubuntu:18.04-x-powerpc64el    : FAIL gcc version 7.5.0 (Ubuntu 7.5.0-3ubuntu1~18.04) 
    In file included from bench/futex-wake.c:25:0:
    bench/futex.h:37:2: error: unknown type name '__kernel_old_time_t'
      __kernel_old_time_t tv_sec;  /* seconds */
      ^~~~~~~~~~~~~~~~~~~
    In file included from bench/futex-hash.c:29:0:
    bench/futex.h:37:2: error: unknown type name '__kernel_old_time_t'
      __kernel_old_time_t tv_sec;  /* seconds */
      ^~~~~~~~~~~~~~~~~~~
    /git/perf-5.17.0-rc4/tools/build/Makefile.build:139: recipe for target 'bench' failed
    make[3]: *** [bench] Error 2
  79     7.09 ubuntu:18.04-x-riscv64        : FAIL gcc version 7.5.0 (Ubuntu 7.5.0-3ubuntu1~18.04) 
    In file included from bench/futex-hash.c:29:0:
    bench/futex.h:37:2: error: unknown type name '__kernel_old_time_t'
      __kernel_old_time_t tv_sec;  /* seconds */
      ^~~~~~~~~~~~~~~~~~~
    In file included from bench/futex-wake.c:25:0:
    bench/futex.h:37:2: error: unknown type name '__kernel_old_time_t'
      __kernel_old_time_t tv_sec;  /* seconds */
      ^~~~~~~~~~~~~~~~~~~
    /git/perf-5.17.0-rc4/tools/build/Makefile.build:139: recipe for target 'bench' failed
    make[3]: *** [bench] Error 2
  80     6.99 ubuntu:18.04-x-s390           : FAIL gcc version 7.5.0 (Ubuntu 7.5.0-3ubuntu1~18.04) 
    In file included from bench/futex-hash.c:29:0:
    bench/futex.h:37:2: error: unknown type name '__kernel_old_time_t'
      __kernel_old_time_t tv_sec;  /* seconds */
      ^~~~~~~~~~~~~~~~~~~
    /git/perf-5.17.0-rc4/tools/build/Makefile.build:139: recipe for target 'bench' failed
    make[3]: *** [bench] Error 2
  81     7.40 ubuntu:18.04-x-sh4            : FAIL gcc version 7.5.0 (Ubuntu 7.5.0-3ubuntu1~18.04) 
    In file included from bench/futex-hash.c:29:0:
    bench/futex.h:37:2: error: unknown type name '__kernel_old_time_t'
      __kernel_old_time_t tv_sec;  /* seconds */
      ^~~~~~~~~~~~~~~~~~~
    In file included from bench/futex-wake.c:25:0:
    bench/futex.h:37:2: error: unknown type name '__kernel_old_time_t'
      __kernel_old_time_t tv_sec;  /* seconds */
      ^~~~~~~~~~~~~~~~~~~
    /git/perf-5.17.0-rc4/tools/build/Makefile.build:139: recipe for target 'bench' failed
    make[3]: *** [bench] Error 2
  82     7.00 ubuntu:18.04-x-sparc64        : FAIL gcc version 7.5.0 (Ubuntu 7.5.0-3ubuntu1~18.04) 
    In file included from bench/futex-hash.c:29:0:
    bench/futex.h:37:2: error: unknown type name '__kernel_old_time_t'
      __kernel_old_time_t tv_sec;  /* seconds */
      ^~~~~~~~~~~~~~~~~~~
    /git/perf-5.17.0-rc4/tools/build/Makefile.build:139: recipe for target 'bench' failed
    make[3]: *** [bench] Error 2
  83     8.21 ubuntu:20.04                  : FAIL gcc version 9.3.0 (Ubuntu 9.3.0-17ubuntu1~20.04) 
    In file included from bench/futex-hash.c:29:
    bench/futex.h:37:2: error: unknown type name '__kernel_old_time_t'
       37 |  __kernel_old_time_t tv_sec;  /* seconds */
          |  ^~~~~~~~~~~~~~~~~~~
    make[3]: *** [/git/perf-5.17.0-rc4/tools/build/Makefile.build:139: bench] Error 2
  84     8.30 ubuntu:20.04-x-powerpc64el    : FAIL gcc version 10.3.0 (Ubuntu 10.3.0-1ubuntu1~20.04) 
    In file included from bench/futex-hash.c:29:
    bench/futex.h:37:2: error: unknown type name '__kernel_old_time_t'
       37 |  __kernel_old_time_t tv_sec;  /* seconds */
          |  ^~~~~~~~~~~~~~~~~~~
    make[3]: *** [/git/perf-5.17.0-rc4/tools/build/Makefile.build:139: bench] Error 2
  85    76.05 ubuntu:20.10                  : Ok   gcc (Ubuntu 10.3.0-1ubuntu1~20.10) 10.3.0 , Ubuntu clang version 11.0.0-2
  86    86.69 ubuntu:21.04                  : Ok   gcc (Ubuntu 10.3.0-1ubuntu1) 10.3.0 , Ubuntu clang version 12.0.0-3ubuntu1~21.04.2
  87    90.71 ubuntu:21.10                  : Ok   gcc (Ubuntu 11.2.0-7ubuntu2) 11.2.0 , Ubuntu clang version 13.0.0-2
  88   112.18 ubuntu:22.04                  : Ok   gcc (Ubuntu 11.2.0-14ubuntu1) 11.2.0 , Ubuntu clang version 13.0.0-9
BUILD_TARBALL_HEAD=ec9389ea066166f6807722b48bbc7cd128660cd1
