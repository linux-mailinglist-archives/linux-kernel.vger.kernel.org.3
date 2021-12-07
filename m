Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D49BE46BCCC
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 14:44:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233033AbhLGNrx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 08:47:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231515AbhLGNrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 08:47:51 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C4BAC061574;
        Tue,  7 Dec 2021 05:44:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 50403CE1AAA;
        Tue,  7 Dec 2021 13:44:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02EEAC341C1;
        Tue,  7 Dec 2021 13:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638884657;
        bh=m0QY6eSd4eysjx/pplZv/DlOFo4cx2m1MJtbgBhtqXM=;
        h=From:To:Cc:Subject:Date:From;
        b=sHHl4sPA2McLdK52IJCzumvrG3pmmWluycbBov9vSm5rPFmQG0FWmqCRcfhwH1L86
         IusS81Kl5kZ98sy8K1t/+FE1xn1znZ+HWuxWbNt1P0vYi7rA5A0eYNLb/4he483Dof
         prQipeY4UgHBsAm7wI0MNcUZ6QmJZHYAcXlbmPR02eOm33RIEwOH0oyvZJ379ZaJFz
         TR/chxCdnv4smzKFBu92B/pr/lOy4WqOW7ze2Mmue62LAxE0xTEtAUA81Vk5FSvuHO
         N9gZcMmoFWFFlACouR02nepB+4JxYGaQeIFNUsHFUZK3nBVYtb3y8mqZqGNkUXuNsH
         q4MXvx1SYmZtA==
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        Kate Carcia <kcarcia@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Ian Rogers <irogers@google.com>,
        Song Liu <songliubraving@fb.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [GIT PULL] perf tools fixes for v5.16: 2nd batch
Date:   Tue,  7 Dec 2021 10:44:07 -0300
Message-Id: <20211207134407.297788-1-acme@kernel.org>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

	Please consider pulling,

Best regards,

- Arnaldo

The following changes since commit cd8c917a56f20f48748dd43d9ae3caff51d5b987:

  Makefile: Do not quote value for CONFIG_CC_IMPLICIT_FALLTHROUGH (2021-12-06 16:42:47 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-for-v5.16-2021-12-07

for you to fetch changes up to 5a897531e00243cebbcc4dbe4ab06cd559ccf53f:

  perf bpf_skel: Do not use typedef to avoid error on old clang (2021-12-06 21:57:53 -0300)

----------------------------------------------------------------
perf tools fixes for v5.16: 2nd batch

- Fix SMT detection fast read path on sysfs.

- Fix memory leaks when processing feature headers in perf.data files.

- Fix 'Simple expression parser' 'perf test' on arch without CPU die topology
  info, such as s/390.

- Fix building perf with BUILD_BPF_SKEL=1.

- Fix 'perf bench' by reverting "perf bench: Fix two memory leaks detected with ASan".

- Fix itrace space allowed for new attributes in 'perf script'.

- Fix the build feature detection fast path, that was always failing on systems
  with python3 development packages, speeding up the build.

- Reset shadow counts before loading, fixing metrics using duration_time.

- Sync more kernel headers changed by the new futex_waitv syscall: s390 and powerpc.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Adrian Hunter (1):
      perf inject: Fix itrace space allowed for new attributes

Arnaldo Carvalho de Melo (3):
      tools headers UAPI: Sync s390 syscall table file changed by new futex_waitv syscall
      tools headers UAPI: Sync powerpc syscall table file changed by new futex_waitv syscall
      tools build: Remove needless libpython-version feature check that breaks test-all fast path

Ian Rogers (3):
      perf tools: Fix SMT detection fast read path
      perf test: Reset shadow counts before loading
      perf header: Fix memory leaks when processing feature headers

Jiri Olsa (1):
      Revert "perf bench: Fix two memory leaks detected with ASan"

Song Liu (2):
      perf bpf: Fix building perf with BUILD_BPF_SKEL=1 by default in more distros
      perf bpf_skel: Do not use typedef to avoid error on old clang

Thomas Richter (1):
      perf test: Fix 'Simple expression parser' test on arch without CPU die topology info

 tools/build/Makefile.feature                       |  1 -
 tools/build/feature/Makefile                       |  4 ----
 tools/build/feature/test-all.c                     |  5 -----
 tools/build/feature/test-libpython-version.c       | 11 -----------
 tools/perf/Makefile.config                         |  2 --
 tools/perf/arch/powerpc/entry/syscalls/syscall.tbl |  1 +
 tools/perf/arch/s390/entry/syscalls/syscall.tbl    |  1 +
 tools/perf/bench/sched-messaging.c                 |  4 ----
 tools/perf/builtin-inject.c                        |  2 +-
 tools/perf/tests/expr.c                            |  4 +++-
 tools/perf/tests/parse-metric.c                    |  1 +
 tools/perf/util/bpf_skel/bperf.h                   | 14 --------------
 tools/perf/util/bpf_skel/bperf_follower.bpf.c      | 19 ++++++++++++++-----
 tools/perf/util/bpf_skel/bperf_leader.bpf.c        | 19 ++++++++++++++-----
 tools/perf/util/bpf_skel/bpf_prog_profiler.bpf.c   |  2 +-
 tools/perf/util/header.c                           | 15 ++++++++++-----
 tools/perf/util/smt.c                              |  2 +-
 17 files changed, 47 insertions(+), 60 deletions(-)
 delete mode 100644 tools/build/feature/test-libpython-version.c
 delete mode 100644 tools/perf/util/bpf_skel/bperf.h
