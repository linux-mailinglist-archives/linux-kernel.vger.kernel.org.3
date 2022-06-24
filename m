Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55BDA559E27
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 18:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbiFXQBi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 12:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbiFXQBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 12:01:31 -0400
Received: from forward101p.mail.yandex.net (forward101p.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b7:101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9854E5251F
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 09:01:27 -0700 (PDT)
Received: from myt5-36442628f0be.qloud-c.yandex.net (myt5-36442628f0be.qloud-c.yandex.net [IPv6:2a02:6b8:c12:1c0c:0:640:3644:2628])
        by forward101p.mail.yandex.net (Yandex) with ESMTP id E74B059D0609;
        Fri, 24 Jun 2022 19:01:24 +0300 (MSK)
Received: from myt5-ca5ec8faf378.qloud-c.yandex.net (myt5-ca5ec8faf378.qloud-c.yandex.net [2a02:6b8:c12:2514:0:640:ca5e:c8fa])
        by myt5-36442628f0be.qloud-c.yandex.net (mxback/Yandex) with ESMTP id 2Fyt6Hhqj2-1MfK7rLK;
        Fri, 24 Jun 2022 19:01:24 +0300
X-Yandex-Fwd: 2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail; t=1656086484;
        bh=V2FI//aX/fY8Jc2kwGxZThRsM9F7hvj3YMlPdBRYyS8=;
        h=Date:Subject:Cc:To:From:Message-Id;
        b=QwQN4xN62UdWVzVipm9XF6FMGLsXU4unzPCWkMLbgtbOO9GD0BgOvdKPvbUNueeSj
         Nvmgzcoy4deQU9Q+eS+S/CVwkJlDWH6FBk8zFDH5la+3PJzBGm0gmYVAiK+GgWt5Nf
         UIrvp3ChDrB9NGAnjkhEYA6NgZMPMcaqhZ6FYSq4=
Authentication-Results: myt5-36442628f0be.qloud-c.yandex.net; dkim=pass header.i=@maquefel.me
Received: by myt5-ca5ec8faf378.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id iVUkuL8Azf-1LMKbASM;
        Fri, 24 Jun 2022 19:01:21 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
From:   Nikita Shubin <nikita.shubin@maquefel.me>
To:     Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>
Cc:     =?UTF-8?q?Jo=C3=A3o=20M=C3=A1rio=20Domingos?= 
        <joao.mario@tecnico.ulisboa.pt>, linux@yadro.com,
        Nikita Shubin <n.shubin@yadro.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>
Subject: [PATCH v4 0/5] RISC-V: Create unique identification for SoC PMU
Date:   Fri, 24 Jun 2022 19:00:50 +0300
Message-Id: <20220624160117.3206-1-nikita.shubin@maquefel.me>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nikita Shubin <n.shubin@yadro.com>

This series aims to provide matching vendor SoC with corresponded JSON bindings.

The ID string is proposed to be in form of MVENDORID-MARCHID-MIMPID, for example 
for Sifive Unmatched the corresponding string will be:

0x489-0x8000000000000007-0x[[:xdigit:]]+,v1,sifive/u74,core

Where MIMPID can vary as all impl supported the same number of events, this might not 
be true for all future SoC however.

Also added 3 counters which are standart for all RISC-V implementations and SBI firmware 
events prerry names, as any firmware that supports SBI PMU should also support firmare 
events.

Link: https://github.com/riscv-non-isa/riscv-sbi-doc/blob/master/riscv-sbi.adoc
Link: https://patchwork.kernel.org/project/linux-riscv/list/?series=648017
---
v3->v4:
- drop pmuid in riscv_pmu_sbi, we are using /proc/cpuinfo
- rework util/header.c to use /proc/cpuinfo
- add SBI firmware events
- add firmware and std arch events to U74 pmu bindings
- change U74 id string and description in mapfile.csv
---
Nikita Shubin (5):
  drivers/perf: riscv_pmu_sbi: perf format
  perf tools riscv: Add support for get_cpuid_str function
  perf arch events: riscv arch std event files
  perf arch events: riscv sbi firmare std event files
  perf vendor events riscv: add Sifive U74 JSON file

 drivers/perf/riscv_pmu_sbi.c                  |  20 +++
 tools/perf/arch/riscv/util/Build              |   1 +
 tools/perf/arch/riscv/util/header.c           | 109 ++++++++++++++
 tools/perf/pmu-events/arch/riscv/mapfile.csv  |  17 +++
 .../pmu-events/arch/riscv/riscv-generic.json  |  20 +++
 .../arch/riscv/riscv-sbi-firmware.json        | 134 ++++++++++++++++++
 .../arch/riscv/sifive/u74/firmware.json       |  68 +++++++++
 .../arch/riscv/sifive/u74/generic.json        |  11 ++
 .../arch/riscv/sifive/u74/instructions.json   |  92 ++++++++++++
 .../arch/riscv/sifive/u74/memory.json         |  32 +++++
 .../arch/riscv/sifive/u74/microarch.json      |  57 ++++++++
 11 files changed, 561 insertions(+)
 create mode 100644 tools/perf/arch/riscv/util/header.c
 create mode 100644 tools/perf/pmu-events/arch/riscv/mapfile.csv
 create mode 100644 tools/perf/pmu-events/arch/riscv/riscv-generic.json
 create mode 100644 tools/perf/pmu-events/arch/riscv/riscv-sbi-firmware.json
 create mode 100644 tools/perf/pmu-events/arch/riscv/sifive/u74/firmware.json
 create mode 100644 tools/perf/pmu-events/arch/riscv/sifive/u74/generic.json
 create mode 100644 tools/perf/pmu-events/arch/riscv/sifive/u74/instructions.json
 create mode 100644 tools/perf/pmu-events/arch/riscv/sifive/u74/memory.json
 create mode 100644 tools/perf/pmu-events/arch/riscv/sifive/u74/microarch.json

-- 
2.35.1

