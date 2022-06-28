Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B46F55C12A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:44:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344559AbiF1Lr6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 07:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345340AbiF1LrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 07:47:23 -0400
Received: from forward105p.mail.yandex.net (forward105p.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b7:108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2755931347;
        Tue, 28 Jun 2022 04:46:36 -0700 (PDT)
Received: from forward100q.mail.yandex.net (forward100q.mail.yandex.net [IPv6:2a02:6b8:c0e:4b:0:640:4012:bb97])
        by forward105p.mail.yandex.net (Yandex) with ESMTP id 10FC62FD96EB;
        Tue, 28 Jun 2022 14:46:35 +0300 (MSK)
Received: from vla1-af84b0e8a1e8.qloud-c.yandex.net (vla1-af84b0e8a1e8.qloud-c.yandex.net [IPv6:2a02:6b8:c0d:991:0:640:af84:b0e8])
        by forward100q.mail.yandex.net (Yandex) with ESMTP id 0B7C56F40B16;
        Tue, 28 Jun 2022 14:46:35 +0300 (MSK)
Received: from vla3-178a3f795968.qloud-c.yandex.net (vla3-178a3f795968.qloud-c.yandex.net [2a02:6b8:c15:2584:0:640:178a:3f79])
        by vla1-af84b0e8a1e8.qloud-c.yandex.net (mxback/Yandex) with ESMTP id TR9ypVqcip-kXfqs477;
        Tue, 28 Jun 2022 14:46:35 +0300
X-Yandex-Fwd: 2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail; t=1656416795;
        bh=KmAhe3GOyQCf3f/h40/f2dj9cqeEBZpz3rTHjKTlv1g=;
        h=Date:Subject:Cc:To:From:Message-Id;
        b=ie+vRnDuLEVcB3Leq2RJql7tFz8orUklnEO1RQQVkpZgB1NvgMxDqT8OOjwuzlJ7V
         vEHfzMwgts0oBX26/NmR5WkPi90VbAXLOE3cDq3XRr2mVO3nAAXYSF04cCYtkcRkRM
         Qio3zqOQ9qOYPvsfCeuVykXpMqwb+x87Rc5jY+CU=
Authentication-Results: vla1-af84b0e8a1e8.qloud-c.yandex.net; dkim=pass header.i=@maquefel.me
Received: by vla3-178a3f795968.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id s5dKAuvn1y-kVMCLslW;
        Tue, 28 Jun 2022 14:46:32 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
From:   Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     linux@yadro.com, Genevieve Chan <genevieve.chan@starfivetech.com>,
        =?UTF-8?q?Jo=C3=A3o=20M=C3=A1rio=20Domingos?= 
        <joao.mario@tecnico.ulisboa.pt>,
        Nikita Shubin <n.shubin@yadro.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Anup Patel <anup@brainfault.org>, Jiri Olsa <jolsa@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH v5 0/4] RISC-V: Create unique identification for SoC PMU
Date:   Tue, 28 Jun 2022 14:45:54 +0300
Message-Id: <20220628114625.166665-1-nikita.shubin@maquefel.me>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nikita Shubin <n.shubin@yadro.com>

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
[2] https://lkml.org/lkml/2022/6/20/498

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
v4->v5:
Atish Patra:
	- dropped cycle, time instret std arch events
	- format config is now 48-bit wide
Arnaldo Carvalho de Melo:
	- fixed cpuid leakage
	- no "if" before free
Will Deacon:
	- simply use "config:63"
---
Nikita Shubin (4):
  drivers/perf: riscv_pmu_sbi: perf format
  perf tools riscv: Add support for get_cpuid_str function
  perf arch events: riscv sbi firmware std event files
  perf vendor events riscv: add Sifive U74 JSON file

 drivers/perf/riscv_pmu_sbi.c                  |  20 +++
 tools/perf/arch/riscv/util/Build              |   1 +
 tools/perf/arch/riscv/util/header.c           | 106 ++++++++++++++
 tools/perf/pmu-events/arch/riscv/mapfile.csv  |  17 +++
 .../arch/riscv/riscv-sbi-firmware.json        | 134 ++++++++++++++++++
 .../arch/riscv/sifive/u74/firmware.json       |  68 +++++++++
 .../arch/riscv/sifive/u74/instructions.json   |  92 ++++++++++++
 .../arch/riscv/sifive/u74/memory.json         |  32 +++++
 .../arch/riscv/sifive/u74/microarch.json      |  57 ++++++++
 9 files changed, 527 insertions(+)
 create mode 100644 tools/perf/arch/riscv/util/header.c
 create mode 100644 tools/perf/pmu-events/arch/riscv/mapfile.csv
 create mode 100644 tools/perf/pmu-events/arch/riscv/riscv-sbi-firmware.json
 create mode 100644 tools/perf/pmu-events/arch/riscv/sifive/u74/firmware.json
 create mode 100644 tools/perf/pmu-events/arch/riscv/sifive/u74/instructions.json
 create mode 100644 tools/perf/pmu-events/arch/riscv/sifive/u74/memory.json
 create mode 100644 tools/perf/pmu-events/arch/riscv/sifive/u74/microarch.json

-- 
2.30.2

