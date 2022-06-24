Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB97559E15
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 18:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbiFXQCo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 12:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbiFXQCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 12:02:38 -0400
Received: from forward500p.mail.yandex.net (forward500p.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b7:110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76CFC52E75
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 09:02:36 -0700 (PDT)
Received: from myt6-e228e91c65dd.qloud-c.yandex.net (myt6-e228e91c65dd.qloud-c.yandex.net [IPv6:2a02:6b8:c12:42a5:0:640:e228:e91c])
        by forward500p.mail.yandex.net (Yandex) with ESMTP id AD567F04F2E;
        Fri, 24 Jun 2022 19:01:26 +0300 (MSK)
Received: from myt5-ca5ec8faf378.qloud-c.yandex.net (myt5-ca5ec8faf378.qloud-c.yandex.net [2a02:6b8:c12:2514:0:640:ca5e:c8fa])
        by myt6-e228e91c65dd.qloud-c.yandex.net (mxback/Yandex) with ESMTP id Cpu7h3Tut9-1PgmlxSt;
        Fri, 24 Jun 2022 19:01:26 +0300
X-Yandex-Fwd: 2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail; t=1656086486;
        bh=Od97yBVEB4xl89bfu7RN4gha8Ggf6tred2IKE8Y/ikg=;
        h=In-Reply-To:References:Date:Subject:Cc:To:From:Message-Id;
        b=d974ooxfFUysBu9E+rf/JT1jxMMbkAAQqTLxQpILPVr9Qa6L16K+LVoLCZhdEkGq3
         Sgww9ZUHNRO1wBhf6vDXPQl3LynbA+blqByd1VF43/AMSL3z24qbA91j5DHb6GezGx
         ZA3EHvYAYCNujbvd9CCfdBQXnVkJWN86e9+5FoaQ=
Authentication-Results: myt6-e228e91c65dd.qloud-c.yandex.net; dkim=pass header.i=@maquefel.me
Received: by myt5-ca5ec8faf378.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id iVUkuL8Azf-1PMKOJDi;
        Fri, 24 Jun 2022 19:01:25 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
From:   Nikita Shubin <nikita.shubin@maquefel.me>
To:     Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>
Cc:     =?UTF-8?q?Jo=C3=A3o=20M=C3=A1rio=20Domingos?= 
        <joao.mario@tecnico.ulisboa.pt>, linux@yadro.com,
        Nikita Shubin <n.shubin@yadro.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/5] drivers/perf: riscv_pmu_sbi: perf format
Date:   Fri, 24 Jun 2022 19:00:51 +0300
Message-Id: <20220624160117.3206-2-nikita.shubin@maquefel.me>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220624160117.3206-1-nikita.shubin@maquefel.me>
References: <20220624160117.3206-1-nikita.shubin@maquefel.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
 drivers/perf/riscv_pmu_sbi.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
index dca3537a8dcc..2b5861a10d8e 100644
--- a/drivers/perf/riscv_pmu_sbi.c
+++ b/drivers/perf/riscv_pmu_sbi.c
@@ -21,6 +21,25 @@
 #include <asm/sbi.h>
 #include <asm/hwcap.h>
 
+PMU_FORMAT_ATTR(event, "config:0-62");
+PMU_FORMAT_ATTR(firmware, "config:63-63");
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
2.35.1

