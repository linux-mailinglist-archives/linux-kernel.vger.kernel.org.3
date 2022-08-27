Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43F9B5A396C
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 20:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbiH0SRJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 14:17:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiH0SRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 14:17:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69113CEB11;
        Sat, 27 Aug 2022 11:17:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 03C2BB80966;
        Sat, 27 Aug 2022 18:17:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EC26C433C1;
        Sat, 27 Aug 2022 18:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661624223;
        bh=wT/bJMPMaWT/N+KIlfrP2TdLyTC5KnPrUm8pbZpJJJ8=;
        h=From:To:Cc:Subject:Date:From;
        b=PsFwtIasgjlbdGANRINQdd30B/47vuTUgDk5yYWXXZzwwLuVcvgIMnQXfRLDMjxs+
         5FT9wZctXXJAvx4AX0XI09q+pk0uOYei1kJ7B/oBMIgh7SCP6426e49GG6ULVDhvGu
         Qbtz+gOLZBWEKRQMMSy79lu+2E5GvXG+ZCZ3RbW0oxk5sXQCVIv6rJNYKvp27S6vn3
         p6a0Cr4msGFNd94ywW0+MTcPL6k6GaoajL+UXLSpJ/Gr16jsZpDW3M7GWrg3wAxqk0
         VGOgK0rqScSQs+F5wvHJ758mbEP6GcJJhOlbgDawMnVHHtk1z126DwOUmxy38WNa5E
         U4zhdSdKuDG4g==
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
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        James Clark <james.clark@arm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [GIT PULL] perf tools fixes for v6.0: 2nd batch
Date:   Sat, 27 Aug 2022 15:16:55 -0300
Message-Id: <20220827181655.406024-1-acme@kernel.org>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

	Please consider pulling,

Best regards,

- Arnaldo

Test results at the end of this message, as usual.

The following changes since commit e022620b5d056e822e42eb9bc0f24fcb97389d86:

  Merge tag 'arm64-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux (2022-08-26 11:32:53 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-for-v6.0-2022-08-27

for you to fetch changes up to 48648548ef764dcb1f6ffc9c9f9057f7c610caa4:

  perf stat: Capitalize topdown metrics' names (2022-08-27 11:55:17 -0300)

----------------------------------------------------------------
perf tools fixes for v6.0: 2nd batch

- Fixup setup of weak groups when using 'perf stat --repeat', add a
  'perf test' for it.

- Fix memory leaks in 'perf sched record' detected with -fsanitize=address.

- Fix build when PYTHON_CONFIG is user supplied.

- Capitalize topdown metrics' names in 'perf stat', so that the output,
  sometimes parsed, matches the Intel SDM docs.

- Make sure the documentation for the save_type filter about Intel
  systems with Arch LBR support (12th-Gen+ client or 4th-Gen Xeon+
  server) reflects recent related kernel changes.

- Fix 'perf record' man page formatting of description of support to hybrid systems.

- Update arm64´s  KVM header from the kernel sources.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Andi Kleen (1):
      perf record: Fix manpage formatting of description of support to hybrid systems

Arnaldo Carvalho de Melo (1):
      tools kvm headers arm64: Update KVM header from the kernel sources

Ian Rogers (3):
      perf stat: Clear evsel->reset_group for each stat run
      perf test: Stat test for repeat with a weak group
      perf sched: Fix memory leaks in __cmd_record detected with -fsanitize=address

James Clark (1):
      perf python: Fix build when PYTHON_CONFIG is user supplied

Kan Liang (1):
      perf docs: Update the documentation for the save_type filter

Zhengjun Xing (1):
      perf stat: Capitalize topdown metrics' names

 tools/arch/arm64/include/uapi/asm/kvm.h   |  6 ++++--
 tools/perf/Documentation/intel-hybrid.txt | 10 ----------
 tools/perf/Documentation/perf-record.txt  |  7 +++++--
 tools/perf/Makefile.config                |  2 +-
 tools/perf/builtin-sched.c                | 24 +++++++++++++++++++-----
 tools/perf/builtin-stat.c                 |  1 +
 tools/perf/tests/shell/stat.sh            | 19 +++++++++++++++++++
 tools/perf/util/stat-shadow.c             | 24 ++++++++++++------------
 8 files changed, 61 insertions(+), 32 deletions(-)
