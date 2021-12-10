Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ED834701E6
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 14:37:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242326AbhLJNkv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 08:40:51 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:53186 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242267AbhLJNkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 08:40:10 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4886CB82805;
        Fri, 10 Dec 2021 13:36:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC381C00446;
        Fri, 10 Dec 2021 13:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639143393;
        bh=BIgzNKwn5a+Qf2+x0BULu3MOaPmkyzwvIzGH5LceSnk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vMT4fLCeHiMkKcm5rumE4SU+A+lvFD+KiquycxqekyalPOnWsNiRjX+ALZ+/N+3hE
         DKShBfGT2F/QPwnjmQp6Q8i/ZVcbyyW//fhQQc4WdkHTIujlp72GQDgKOfPr/n60is
         jpSNJ4HF0oRPj6OGXIELJK9EPrIysVr1CXHAtkR7sYEu0oWpo75Dn1RtqSlT16Irke
         w7i1wuBABmXJsRllft4xQfbo3hZTsW8cov8kY+xX6x8DdKlDGHwKASVNZLiUUnhJ8D
         BqsA0pZX8dOGykwx8Ya+Qyq1ABL3nNt7Y/NQemgkBuFvFgYicDahWSghtBC9ek17zK
         l0H7LVCxqoGBw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id EADD5405D8; Fri, 10 Dec 2021 10:36:30 -0300 (-03)
Date:   Fri, 10 Dec 2021 10:36:30 -0300
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
Message-ID: <YbNX3mRT0A9/N2il@kernel.org>
References: <20211209235857.423773-1-alistair.francis@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211209235857.423773-1-alistair.francis@opensource.wdc.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Dec 10, 2021 at 09:58:52AM +1000, Alistair Francis escreveu:
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

  10     9.99 alpine:3.12                   : FAIL gcc version 9.3.0 (Alpine 9.3.0)
    In file included from bench/futex-hash.c:29:
    bench/futex.h:37:2: error: unknown type name '__kernel_old_time_t'
       37 |  __kernel_old_time_t tv_sec;  /* seconds */
          |  ^~~~~~~~~~~~~~~~~~~
    In file included from bench/futex-wake.c:25:
    bench/futex.h:37:2: error: unknown type name '__kernel_old_time_t'
       37 |  __kernel_old_time_t tv_sec;  /* seconds */
          |  ^~~~~~~~~~~~~~~~~~~
    make[3]: *** [/git/perf-5.16.0-rc4/tools/build/Makefile.build:139: bench] Error 2
  11   114.27 alpine:3.13                   : Ok   gcc (Alpine 10.2.1_pre1) 10.2.1 20201203 , Alpine clang version 10.0.1
  12   100.12 alpine:3.14                   : Ok   gcc (Alpine 10.3.1_git20210424) 10.3.1 20210424 , Alpine clang version 11.1.0
  13   101.06 alpine:3.15                   : Ok   gcc (Alpine 10.3.1_git20211027) 10.3.1 20211027 , Alpine clang version 12.0.1
  14   101.96 alpine:edge                   : Ok   gcc (Alpine 11.2.1_git20211128) 11.2.1 20211128 , Alpine clang version 12.0.1
  15     6.98 alt:p8                        : FAIL gcc version 5.3.1 20151207 (ALT p8 5.3.1-alt3.M80P.1) (GCC)
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
    make[3]: *** [bench] Error 2
  16    73.65 alt:p9                        : Ok   x86_64-alt-linux-gcc (GCC) 8.4.1 20200305 (ALT p9 8.4.1-alt0.p9.1) , clang version 10.0.0
  17    72.34 alt:sisyphus                  : Ok   x86_64-alt-linux-gcc (GCC) 11.2.1 20210911 (ALT Sisyphus 11.2.1-alt1) , ALT Linux Team clang version 12.0.1
  18     7.58 amazonlinux:1                 : FAIL gcc version 7.2.1 20170915 (Red Hat 7.2.1-2) (GCC)
    In file included from bench/futex-hash.c:29:0:
    bench/futex.h:37:2: error: unknown type name '__kernel_old_time_t'
      __kernel_old_time_t tv_sec;  /* seconds */
      ^~~~~~~~~~~~~~~~~~~
    In file included from bench/futex-wake.c:25:0:
    bench/futex.h:37:2: error: unknown type name '__kernel_old_time_t'
      __kernel_old_time_t tv_sec;  /* seconds */
      ^~~~~~~~~~~~~~~~~~~
    make[3]: *** [bench] Error 2
  19     8.28 amazonlinux:2                 : FAIL gcc version 7.3.1 20180712 (Red Hat 7.3.1-13) (GCC)
    In file included from bench/futex-hash.c:29:0:
    bench/futex.h:37:2: error: unknown type name '__kernel_old_time_t'
      __kernel_old_time_t tv_sec;  /* seconds */
      ^~~~~~~~~~~~~~~~~~~
    make[3]: *** [bench] Error 2
  20    79.16 centos:8                      : Ok   gcc (GCC) 8.4.1 20200928 (Red Hat 8.4.1-1) , clang version 11.0.1 (Red Hat 11.0.1-1.module_el8.4.0+966+2995ef20)


Still building on the other containers.

- Arnaldo
