Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A605550A09
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 13:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236133AbiFSLLf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 07:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236076AbiFSLL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 07:11:26 -0400
Received: from forward501j.mail.yandex.net (forward501j.mail.yandex.net [IPv6:2a02:6b8:0:801:2::111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64DB31116D
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 04:11:25 -0700 (PDT)
Received: from vla5-415927531403.qloud-c.yandex.net (vla5-415927531403.qloud-c.yandex.net [IPv6:2a02:6b8:c18:3522:0:640:4159:2753])
        by forward501j.mail.yandex.net (Yandex) with ESMTP id 7CC47623458;
        Sun, 19 Jun 2022 14:11:23 +0300 (MSK)
Received: from vla1-62318bfe5573.qloud-c.yandex.net (vla1-62318bfe5573.qloud-c.yandex.net [2a02:6b8:c0d:3819:0:640:6231:8bfe])
        by vla5-415927531403.qloud-c.yandex.net (mxback/Yandex) with ESMTP id K896SngN5y-BMf8djv8;
        Sun, 19 Jun 2022 14:11:23 +0300
X-Yandex-Fwd: 2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail; t=1655637083;
        bh=Jjeli4ZyFrXVeI42kTpuwxGd5nkH6f77Wv0sKvtGi84=;
        h=In-Reply-To:References:Date:Subject:Cc:To:From:Message-Id;
        b=JFIFiWzm+eghbjkmivE0AtW0zhySyhFwEP7RqYCfeCPnTpiRnrZUzgcJXKeiymxrt
         zOJuGq0GJO2GmzBZ8+mYEknP2B/RX60ssMHGDZnSy4gvEkY+dnc5sRUG1DVz4xCFLV
         0FsP8kljDrcmrTDoSgAYjt+G7WBks0EseSafTgNE=
Authentication-Results: vla5-415927531403.qloud-c.yandex.net; dkim=pass header.i=@maquefel.me
Received: by vla1-62318bfe5573.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id VrXAFig42r-BLNq9rsj;
        Sun, 19 Jun 2022 14:11:21 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
From:   Nikita Shubin <nikita.shubin@maquefel.me>
To:     Atish Patra <atishp@atishpatra.org>, Will Deacon <will@kernel.org>,
        Sunil V L <sunilvl@ventanamicro.com>
Cc:     =?UTF-8?q?Jo=C3=A3o=20M=C3=A1rio=20Domingos?= 
        <joao.mario@tecnico.ulisboa.pt>, linux@yadro.com,
        Nikita Shubin <n.shubin@yadro.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 1/1] RISC-V: Create unique identification for SoC PMU
Date:   Sun, 19 Jun 2022 14:11:11 +0300
Message-Id: <20220619111115.6354-2-nikita.shubin@maquefel.me>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220619111115.6354-1-nikita.shubin@maquefel.me>
References: <20220619111115.6354-1-nikita.shubin@maquefel.me>
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

Provide RISC-V SBI PMU id to distinguish different cores or SoCs via
"devices/platform/riscv-pmu/id" sysfs entry.

The identification is generated as string of marchid, mimpid, mvendorid
in hex format separated by coma - "0x70032,0x70032,0x0".

The CSRs are detailed in the RISC-V privileged spec [1].
[1] https://github.com/riscv/riscv-isa-manual

Inspired-by: João Mário Domingos <joao.mario@tecnico.ulisboa.pt>
Signed-off-by: Nikita Shubin <n.shubin@yadro.com>
---
v3->v4:
- use string for pmuid
- rename pmu_sbi_id_show to id_show
- fix error print message in id_show
- fix DEVICE_ATTR to use octal permissions
---
 arch/riscv/kernel/sbi.c        |  3 +++
 drivers/perf/riscv_pmu_sbi.c   | 41 ++++++++++++++++++++++++++++++++++
 include/linux/perf/riscv_pmu.h |  1 +
 3 files changed, 45 insertions(+)

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
index dca3537a8dcc..be812f855617 100644
--- a/drivers/perf/riscv_pmu_sbi.c
+++ b/drivers/perf/riscv_pmu_sbi.c
@@ -693,6 +693,28 @@ static int pmu_sbi_setup_irqs(struct riscv_pmu *pmu, struct platform_device *pde
 	return 0;
 }
 
+static ssize_t id_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	int len;
+	struct riscv_pmu *pmu = container_of(dev_get_drvdata(dev), struct riscv_pmu, pmu);
+
+	len = sprintf(buf, "%s\n", pmu->pmuid);
+	if (len <= 0)
+		dev_err(dev, "invalid sprintf len: %d\n", len);
+
+	return len;
+}
+
+static DEVICE_ATTR(id, 0644, id_show, NULL);
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
@@ -714,6 +736,14 @@ static int pmu_sbi_device_probe(struct platform_device *pdev)
 	if (pmu_sbi_get_ctrinfo(num_counters))
 		goto out_free;
 
+	/* fill pmuid */
+	pmu->pmuid = kasprintf(GFP_KERNEL, "0x%lx,0x%lx,0x%lx",
+			       sbi_get_marchid(),
+			       sbi_get_mimpid(),
+			       sbi_get_mvendorid());
+	if (!pmu->pmuid)
+		goto out_free_pmuid;
+
 	ret = pmu_sbi_setup_irqs(pmu, pdev);
 	if (ret < 0) {
 		pr_info("Perf sampling/filtering is not supported as sscof extension is not available\n");
@@ -739,8 +769,19 @@ static int pmu_sbi_device_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	ret = sysfs_create_group(&pdev->dev.kobj, &pmu_sbi_group);
+	if (ret) {
+		dev_err(&pdev->dev, "sysfs creation failed\n");
+		return ret;
+	}
+
+	pdev->dev.groups = pmu_sbi_groups;
+	dev_set_drvdata(&pdev->dev, pmu);
+
 	return 0;
 
+out_free_pmuid:
+	kfree(pmu->pmuid);
 out_free:
 	kfree(pmu);
 	return ret;
diff --git a/include/linux/perf/riscv_pmu.h b/include/linux/perf/riscv_pmu.h
index 46f9b6fe306e..cf3557b77fb8 100644
--- a/include/linux/perf/riscv_pmu.h
+++ b/include/linux/perf/riscv_pmu.h
@@ -42,6 +42,7 @@ struct cpu_hw_events {
 struct riscv_pmu {
 	struct pmu	pmu;
 	char		*name;
+	char		*pmuid;
 
 	irqreturn_t	(*handle_irq)(int irq_num, void *dev);
 
-- 
2.35.1

