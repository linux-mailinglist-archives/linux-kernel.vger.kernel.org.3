Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAA01592FC3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 15:23:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242465AbiHONXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 09:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241526AbiHONXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 09:23:00 -0400
Received: from forward105j.mail.yandex.net (forward105j.mail.yandex.net [5.45.198.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80B5818B0E;
        Mon, 15 Aug 2022 06:22:58 -0700 (PDT)
Received: from iva1-dcde80888020.qloud-c.yandex.net (iva1-dcde80888020.qloud-c.yandex.net [IPv6:2a02:6b8:c0c:7695:0:640:dcde:8088])
        by forward105j.mail.yandex.net (Yandex) with ESMTP id DE9444EC8F72;
        Mon, 15 Aug 2022 16:22:54 +0300 (MSK)
Received: by iva1-dcde80888020.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id BL0XdiM9S6-Mpi4xxLF;
        Mon, 15 Aug 2022 16:22:53 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail; t=1660569773;
        bh=nIVrrngh255xQlyPNLMT0qsuvgBZKO7rCfvaAHKtXx0=;
        h=Message-Id:Date:Cc:Subject:To:From;
        b=c4RdYZOP23tRHPJkalribKDnE7knA0o8myJU9Heo9WbK55Q0IiPlvF4QVPkXlYTi+
         AOo/KMX5aOKQxXUn8hztaBWOP6bTGhW1eMn3+6dmJnM0l3ZMYDac1fQKGSSHpZp0xl
         cNyIsiBpsRdkojnXyj7yxukIpsGu0hGkU0bIjmYE=
Authentication-Results: iva1-dcde80888020.qloud-c.yandex.net; dkim=pass header.i=@maquefel.me
From:   Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     linux@yadro.com, Anup Patel <anup@brainfault.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Nikita Shubin <n.shubin@yadro.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v6 0/3] RISC-V: Create unique identification for SoC PMU
Date:   Mon, 15 Aug 2022 16:22:37 +0300
Message-Id: <20220815132251.25702-1-nikita.shubin@maquefel.me>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_VALIDITY_RPBL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
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

Also added SBI firmware events pretty names, as any firmware that supports SBI PMU
should also support firmare events [1].

Series depends on patch by Anup Patel, exposing mvendor, marchid and mimpid
to "/proc/cpuinfo" [2].

[1] https://github.com/riscv-non-isa/riscv-sbi-doc/blob/master/riscv-sbi.adoc
[2] https://lkml.org/lkml/2022/7/27/23

Link to previous version:
https://patchwork.kernel.org/project/linux-riscv/list/?series=653649

See original cover letter by João Mário Domingos:
https://patchwork.kernel.org/project/linux-riscv/cover/20211116154812.17008-1-joao.mario@tecnico.ulisboa.pt/

Tested with the following OpenSBI device tree bindings:

```
pmu {
        compatible = "riscv,pmu";
        riscv,event-to-mhpmcounters =
                <0x03 0x06 0x18
                0x10001 0x10002 0x18
                0x10009 0x10009 0x18
                0x10011 0x10011 0x18
                0x10019 0x10019 0x18
                0x10021 0x10021 0x18>;
        riscv,event-to-mhpmevent =
                <0x03 0x00000000 0x1801
                0x04 0x00000000 0x0302
                0x05 0x00000000 0x4000
                0x06 0x00000000 0x6001
                0x10001 0x00000000 0x0202
                0x10002 0x00000000 0x0402
                0x10009 0x00000000 0x0102
                0x10011 0x00000000 0x2002
                0x10019 0x00000000 0x1002
                0x10021 0x00000000 0x0802>;
        riscv,raw-event-to-mhpmcounters =
                <0x00000000 0x03ffff00 0x0 0x0 0x18
                0x00000000 0x0007ff01 0x0 0x1 0x18
                0x00000000 0x00003f02 0x0 0x2 0x18>;
};
```
---
v5->v6:
Will Deacon:
	- dropped first patch from v5 series it has been merged into master
Mayuresh Chitale:
	- fixed FW_SFENCE_VMA_SENT event code

- added Tested-by tags
---

Nikita Shubin (3):
  perf arch events: riscv sbi firmware std event files
  perf vendor events riscv: add Sifive U74 JSON file
  RISC-V: Added Syntacore SCR7 PMU events

 tools/perf/pmu-events/arch/riscv/mapfile.csv  |  18 +++
 .../arch/riscv/riscv-sbi-firmware.json        | 134 ++++++++++++++++++
 .../arch/riscv/sifive/u74/firmware.json       |  68 +++++++++
 .../arch/riscv/sifive/u74/instructions.json   |  92 ++++++++++++
 .../arch/riscv/sifive/u74/memory.json         |  32 +++++
 .../arch/riscv/sifive/u74/microarch.json      |  57 ++++++++
 .../arch/riscv/syntacore/scr7/L1D_cache.json  | 102 +++++++++++++
 .../arch/riscv/syntacore/scr7/L1I_cache.json  |  67 +++++++++
 .../arch/riscv/syntacore/scr7/exceptions.json |  67 +++++++++
 .../arch/riscv/syntacore/scr7/execution.json  |  97 +++++++++++++
 .../arch/riscv/syntacore/scr7/firmware.json   |  68 +++++++++
 .../arch/riscv/syntacore/scr7/general.json    |  47 ++++++
 .../arch/riscv/syntacore/scr7/interrupts.json |  32 +++++
 .../arch/riscv/syntacore/scr7/prediction.json |  52 +++++++
 14 files changed, 933 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/riscv/mapfile.csv
 create mode 100644 tools/perf/pmu-events/arch/riscv/riscv-sbi-firmware.json
 create mode 100644 tools/perf/pmu-events/arch/riscv/sifive/u74/firmware.json
 create mode 100644 tools/perf/pmu-events/arch/riscv/sifive/u74/instructions.json
 create mode 100644 tools/perf/pmu-events/arch/riscv/sifive/u74/memory.json
 create mode 100644 tools/perf/pmu-events/arch/riscv/sifive/u74/microarch.json
 create mode 100644 tools/perf/pmu-events/arch/riscv/syntacore/scr7/L1D_cache.json
 create mode 100644 tools/perf/pmu-events/arch/riscv/syntacore/scr7/L1I_cache.json
 create mode 100644 tools/perf/pmu-events/arch/riscv/syntacore/scr7/exceptions.json
 create mode 100644 tools/perf/pmu-events/arch/riscv/syntacore/scr7/execution.json
 create mode 100644 tools/perf/pmu-events/arch/riscv/syntacore/scr7/firmware.json
 create mode 100644 tools/perf/pmu-events/arch/riscv/syntacore/scr7/general.json
 create mode 100644 tools/perf/pmu-events/arch/riscv/syntacore/scr7/interrupts.json
 create mode 100644 tools/perf/pmu-events/arch/riscv/syntacore/scr7/prediction.json

-- 
2.35.1

