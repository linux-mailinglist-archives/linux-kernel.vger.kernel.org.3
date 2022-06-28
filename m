Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92EC155D35F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344614AbiF1LsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 07:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345344AbiF1LrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 07:47:24 -0400
Received: from forward501j.mail.yandex.net (forward501j.mail.yandex.net [IPv6:2a02:6b8:0:801:2::111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 708E031502
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 04:46:41 -0700 (PDT)
Received: from vla1-5c8ce23a551e.qloud-c.yandex.net (vla1-5c8ce23a551e.qloud-c.yandex.net [IPv6:2a02:6b8:c0d:400d:0:640:5c8c:e23a])
        by forward501j.mail.yandex.net (Yandex) with ESMTP id B233A6231D1;
        Tue, 28 Jun 2022 14:46:39 +0300 (MSK)
Received: from vla3-178a3f795968.qloud-c.yandex.net (vla3-178a3f795968.qloud-c.yandex.net [2a02:6b8:c15:2584:0:640:178a:3f79])
        by vla1-5c8ce23a551e.qloud-c.yandex.net (mxback/Yandex) with ESMTP id Z9x1a00j1O-kbfO9vfl;
        Tue, 28 Jun 2022 14:46:39 +0300
X-Yandex-Fwd: 2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail; t=1656416799;
        bh=Fj1CfjmfGHqlANTgIcu8cPsR6XcA+gZqUzEuWcIko50=;
        h=In-Reply-To:References:Date:Subject:Cc:To:From:Message-Id;
        b=Iyo0QB+ECzkswea2YaWHcoTNqLb//6FNK9SFNAfsu89FF6hglDxS0NDB3vY6rqhPN
         Q5ZTt2JRerQs7m2c+7/MzTIRUJE3DM/K/tu844WsXJMBcJvwv8FRwtbegry+9Xd1ke
         p3Dt/rtXxuct1+9xXwKrxt9lyV48dvMUbqvFuGck=
Authentication-Results: vla1-5c8ce23a551e.qloud-c.yandex.net; dkim=pass header.i=@maquefel.me
Received: by vla3-178a3f795968.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id s5dKAuvn1y-kZMCIGGq;
        Tue, 28 Jun 2022 14:46:36 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
From:   Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     linux@yadro.com, Genevieve Chan <genevieve.chan@starfivetech.com>,
        =?UTF-8?q?Jo=C3=A3o=20M=C3=A1rio=20Domingos?= 
        <joao.mario@tecnico.ulisboa.pt>,
        Nikita Shubin <n.shubin@yadro.com>,
        Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/4] drivers/perf: riscv_pmu_sbi: perf format
Date:   Tue, 28 Jun 2022 14:45:55 +0300
Message-Id: <20220628114625.166665-2-nikita.shubin@maquefel.me>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220628114625.166665-1-nikita.shubin@maquefel.me>
References: <20220628114625.166665-1-nikita.shubin@maquefel.me>
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

Update driver to export formatting and event information to sysfs so it
can be used by the perf user space tools with the syntaxes:

perf stat -e cpu/event=0x05
perf stat -e cpu/event=0x05,firmware=0x1/

63-bit is used to distinguish hardware events from firmware. Firmware
events are defined by "RISC-V Supervisor Binary Interface
Specification".

perf stat -e cpu/event=0x05,firmware=0x1/

is equivalent to

perf stat -e r8000000000000005

Inspired-by: João Mário Domingos <joao.mario@tecnico.ulisboa.pt>
Signed-off-by: Nikita Shubin <n.shubin@yadro.com>
Link: https://github.com/riscv-non-isa/riscv-sbi-doc/blob/master/riscv-sbi.adoc
---
v4->v5:
- format config is now 48-bit wide
- simply use "config:63"
---
 drivers/perf/riscv_pmu_sbi.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
index dca3537a8dcc..a2a22e35d6ed 100644
--- a/drivers/perf/riscv_pmu_sbi.c
+++ b/drivers/perf/riscv_pmu_sbi.c
@@ -21,6 +21,25 @@
 #include <asm/sbi.h>
 #include <asm/hwcap.h>
 
+PMU_FORMAT_ATTR(event, "config:0-47");
+PMU_FORMAT_ATTR(firmware, "config:63");
+
+static struct attribute *riscv_arch_formats_attr[] = {
+	&format_attr_event.attr,
+	&format_attr_firmware.attr,
+	NULL,
+};
+
+static struct attribute_group riscv_pmu_format_group = {
+	.name = "format",
+	.attrs = riscv_arch_formats_attr,
+};
+
+static const struct attribute_group *riscv_pmu_attr_groups[] = {
+	&riscv_pmu_format_group,
+	NULL,
+};
+
 union sbi_pmu_ctr_info {
 	unsigned long value;
 	struct {
@@ -720,6 +739,7 @@ static int pmu_sbi_device_probe(struct platform_device *pdev)
 		pmu->pmu.capabilities |= PERF_PMU_CAP_NO_INTERRUPT;
 		pmu->pmu.capabilities |= PERF_PMU_CAP_NO_EXCLUDE;
 	}
+	pmu->pmu.attr_groups = riscv_pmu_attr_groups;
 	pmu->num_counters = num_counters;
 	pmu->ctr_start = pmu_sbi_ctr_start;
 	pmu->ctr_stop = pmu_sbi_ctr_stop;
-- 
2.30.2

