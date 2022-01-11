Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CBA248AF60
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 15:21:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241788AbiAKOVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 09:21:12 -0500
Received: from forward103o.mail.yandex.net ([37.140.190.177]:40200 "EHLO
        forward103o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241698AbiAKOVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 09:21:06 -0500
Received: from sas1-cf895df4fa0e.qloud-c.yandex.net (sas1-cf895df4fa0e.qloud-c.yandex.net [IPv6:2a02:6b8:c14:390f:0:640:cf89:5df4])
        by forward103o.mail.yandex.net (Yandex) with ESMTP id 2221610A8BD9;
        Tue, 11 Jan 2022 17:20:58 +0300 (MSK)
Received: from sas1-37da021029ee.qloud-c.yandex.net (sas1-37da021029ee.qloud-c.yandex.net [2a02:6b8:c08:1612:0:640:37da:210])
        by sas1-cf895df4fa0e.qloud-c.yandex.net (mxback/Yandex) with ESMTP id VROTXavEds-Kuf4kE1q;
        Tue, 11 Jan 2022 17:20:58 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail; t=1641910858;
        bh=8UNetPbQ/mXpqTJYoL+hQG1SQunMszfpEUYRAI8PqrY=;
        h=Date:Subject:To:From:Message-Id:Cc;
        b=fFeTodt48DledIFE0xodTCXNeCMmxtdO0v6hYyp1uog5+kd8BA0ekQiDjXYlWoSF5
         is205IGWWL6ubGmZSgssgMXCzWgUxO753aBmFLpQ/nXWVpA2J/FItM5eFDJTV8Am7d
         W6U5aF8IukIZNhTN6Wa4AFx+ZBo/nwRxgZiWgSRc=
Authentication-Results: sas1-cf895df4fa0e.qloud-c.yandex.net; dkim=pass header.i=@maquefel.me
Received: by sas1-37da021029ee.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id l3U269SIUy-KsPqUEcG;
        Tue, 11 Jan 2022 17:20:55 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
X-Yandex-Fwd: 2
From:   Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Atish Patra <atishp@rivosinc.com>, linux-riscv@lists.infradead.org,
        linux@yadro.com, Nikita Shubin <n.shubin@yadro.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Kajol Jain <kjain@linux.ibm.com>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>,
        John Garry <john.garry@huawei.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Song Liu <song@kernel.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/1] perf tools: Add 'm' event modifier for counting
Date:   Tue, 11 Jan 2022 17:20:47 +0300
Message-Id: <20220111142054.18733-1-nikita.shubin@maquefel.me>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nikita Shubin <n.shubin@yadro.com>

This patch is a proposal to add Machine Mode modifier that is currently 
available only for RISC-V for perf tool.

We don't currently have a level that is lower than kernel, so i don't 
see we can reuse something existing for this purpose.

The exclude_machine bit seems harmless to as no one will proccess it apart 
of riscv.

Patch depends on Atish Patra PMU series:
https://lwn.net/Articles/879905/
 + some modifications to pass execlude event to SBI PMU extension

Tested with qemu.

Nikita Shubin (1):
  perf tools: Add 'm' event modifier for counting machine

 include/uapi/linux/perf_event.h        |  3 ++-
 tools/include/uapi/linux/perf_event.h  |  3 ++-
 tools/perf/Documentation/perf-list.txt |  1 +
 tools/perf/tests/parse-events.c        | 18 ++++++++++++++++++
 tools/perf/util/evsel.c                |  4 +++-
 tools/perf/util/parse-events.c         | 18 +++++++++++++-----
 tools/perf/util/parse-events.l         |  2 +-
 7 files changed, 40 insertions(+), 9 deletions(-)

-- 
2.31.1

