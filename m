Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4060053FFF9
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 15:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244668AbiFGNZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 09:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243473AbiFGNZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 09:25:28 -0400
X-Greylist: delayed 487 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 07 Jun 2022 06:25:24 PDT
Received: from forward501o.mail.yandex.net (forward501o.mail.yandex.net [37.140.190.203])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF7F6BE154
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 06:25:24 -0700 (PDT)
Received: from myt6-26f37b5fec36.qloud-c.yandex.net (myt6-26f37b5fec36.qloud-c.yandex.net [IPv6:2a02:6b8:c12:5527:0:640:26f3:7b5f])
        by forward501o.mail.yandex.net (Yandex) with ESMTP id 5183B45C4E6C;
        Tue,  7 Jun 2022 16:16:56 +0300 (MSK)
Received: from myt6-654ec0a0ab93.qloud-c.yandex.net (myt6-654ec0a0ab93.qloud-c.yandex.net [2a02:6b8:c12:1d80:0:640:654e:c0a0])
        by myt6-26f37b5fec36.qloud-c.yandex.net (mxback/Yandex) with ESMTP id smaqJmKSH2-GtfeQLwf;
        Tue, 07 Jun 2022 16:16:56 +0300
X-Yandex-Fwd: 2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail; t=1654607816;
        bh=JvNF2tl4VACbLjlnTM0H4TIIrNNoBngMOz0q/FiVjZc=;
        h=In-Reply-To:References:Date:Subject:Cc:To:From:Message-Id;
        b=GwKizgbQ3nskMntGKiwqljCR4wdHj/+4vKGtzccxpe1C/zu43jeu6N0Z3YY5QLCNE
         uWEItwdNbsgAJmICe+XDiErcvn3CS65MmNoFUGN0PfOcQSFjUzRzFl72WtYX3ApqD+
         camc4PT2YMpr77TN4A0atwWhVWkaHMLY0zq6/QmQ=
Authentication-Results: myt6-26f37b5fec36.qloud-c.yandex.net; dkim=pass header.i=@maquefel.me
Received: by myt6-654ec0a0ab93.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id sOXgg17Zrk-GrM4PiLo;
        Tue, 07 Jun 2022 16:16:53 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
From:   Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Genevieve Chan <genevieve.chan@starfivetech.com>,
        =?UTF-8?q?Jo=C3=A3o=20M=C3=A1rio=20Domingos?= 
        <joao.mario@tecnico.ulisboa.pt>,
        Nikita Shubin <n.shubin@yadro.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-riscv@lists.infradead.org (open list:RISC-V ARCHITECTURE),
        linux-kernel@vger.kernel.org (open list),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM PMU PROFILING
        AND DEBUGGING)
Subject: [PATCH v3 1/4] RISC-V: Create unique identification for SoC PMU
Date:   Tue,  7 Jun 2022 16:16:44 +0300
Message-Id: <20220607131648.29439-2-nikita.shubin@maquefel.me>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220607131648.29439-1-nikita.shubin@maquefel.me>
References: <20220607131648.29439-1-nikita.shubin@maquefel.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: João Mário Domingos <joao.mario@tecnico.ulisboa.pt>

The SBI PMU platform driver did not provide any identification for
perf events matching. This patch introduces a new sysfs file inside the
platform device (soc:pmu/id) for pmu identification.

The identification is a 64-bit value generated as:
[63-32]: mvendorid;
[31]: marchid[MSB];
[30-16]: marchid[15-0];
[15-0]: mimpid[15MSBs];

The CSRs are detailed in the RISC-V privileged spec [1].
The marchid is split in MSB + 15LSBs, due to the MSB being used for
open-source architecture identification.

[1] https://github.com/riscv/riscv-isa-manual

Signed-off-by: João Mário Domingos <joao.mario@tecnico.ulisboa.pt>
Tested-by: Nikita Shubin <n.shubin@yadro.com>
---
 arch/riscv/kernel/sbi.c      |  3 +++
 drivers/perf/riscv_pmu_sbi.c | 47 ++++++++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+)

diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
index 775d3322b422..50dd9b6ecc9e 100644
--- a/arch/riscv/kernel/sbi.c
+++ b/arch/riscv/kernel/sbi.c
@@ -627,16 +627,19 @@ long sbi_get_mvendorid(void)
 {
 	return __sbi_base_ecall(SBI_EXT_BASE_GET_MVENDORID);
 }
+EXPORT_SYMBOL(sbi_get_mvendorid);
 
 long sbi_get_marchid(void)
 {
 	return __sbi_base_ecall(SBI_EXT_BASE_GET_MARCHID);
 }
+EXPORT_SYMBOL(sbi_get_marchid);
 
 long sbi_get_mimpid(void)
 {
 	return __sbi_base_ecall(SBI_EXT_BASE_GET_MIMPID);
 }
+EXPORT_SYMBOL(sbi_get_mimpid);
 
 static void sbi_send_cpumask_ipi(const struct cpumask *target)
 {
diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
index a1317a483512..15ab3dc68e7a 100644
--- a/drivers/perf/riscv_pmu_sbi.c
+++ b/drivers/perf/riscv_pmu_sbi.c
@@ -693,6 +693,46 @@ static int pmu_sbi_setup_irqs(struct riscv_pmu *pmu, struct platform_device *pde
 	return 0;
 }
 
+static uint64_t pmu_sbi_get_pmu_id(void)
+{
+	union sbi_pmu_id {
+		uint64_t value;
+		struct {
+			uint16_t imp:16;
+			uint16_t arch:16;
+			uint32_t vendor:32;
+		};
+	} pmuid;
+
+	pmuid.value = 0;
+	pmuid.vendor = (uint32_t) sbi_get_mvendorid();
+	pmuid.arch = (sbi_get_marchid() >> (63 - 15) & (1 << 15)) | (sbi_get_marchid() & 0x7FFF);
+	pmuid.imp = (sbi_get_mimpid() >> 16);
+
+	return pmuid.value;
+}
+
+static ssize_t pmu_sbi_id_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	int len;
+
+	len = sprintf(buf, "0x%llx\n", pmu_sbi_get_pmu_id());
+	if (len <= 0)
+		dev_err(dev, "mydrv: Invalid sprintf len: %dn", len);
+
+	return len;
+}
+
+static DEVICE_ATTR(id, S_IRUGO | S_IWUSR, pmu_sbi_id_show, 0);
+
+static struct attribute *pmu_sbi_attrs[] = {
+	&dev_attr_id.attr,
+	NULL
+};
+
+ATTRIBUTE_GROUPS(pmu_sbi);
+
 static int pmu_sbi_device_probe(struct platform_device *pdev)
 {
 	struct riscv_pmu *pmu = NULL;
@@ -729,6 +769,13 @@ static int pmu_sbi_device_probe(struct platform_device *pdev)
 	pmu->ctr_clear_idx = pmu_sbi_ctr_clear_idx;
 	pmu->ctr_read = pmu_sbi_ctr_read;
 
+	ret = sysfs_create_group(&pdev->dev.kobj, &pmu_sbi_group);
+	if (ret) {
+		dev_err(&pdev->dev, "sysfs creation failed\n");
+		return ret;
+	}
+	pdev->dev.groups = pmu_sbi_groups;
+
 	ret = cpuhp_state_add_instance(CPUHP_AP_PERF_RISCV_STARTING, &pmu->node);
 	if (ret)
 		return ret;
-- 
2.35.1

