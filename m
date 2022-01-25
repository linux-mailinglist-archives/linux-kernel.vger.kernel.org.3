Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB8B49AD9C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 08:31:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445400AbiAYH2L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 02:28:11 -0500
Received: from esa3.hc1455-7.c3s2.iphmx.com ([207.54.90.49]:10542 "EHLO
        esa3.hc1455-7.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1444480AbiAYHV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 02:21:58 -0500
IronPort-SDR: VJQgLN9sZ5VBBcQtL2uqZJOmbSMxvubZ2tASwCu9tlBRFJXzrRLVqo4XJ1XdrpQ+awf7Yshdrw
 WDFvpPuRcc0kdd2KWw6urxveun2Sc71K4OYt9Q2fy1HPNCjlqxTqYdEH4/38C3PwasH5MQuAW0
 LC85huxjN7AK7FUnyYXdHQwIaVxIQwBj/unf1l2H6Ta5j0lzFhZ40yX4DygdFe7B6hq2BAtAm1
 3hNxG3s37HjbpF159Pja3JnBI+8pr6r+booVbjrokLZQQ+5F2qLagDkOuw+gswDufAwiD5mxJE
 i9Nu2y0rQPtsyBmoLGQ6VzBq
X-IronPort-AV: E=McAfee;i="6200,9189,10237"; a="60495849"
X-IronPort-AV: E=Sophos;i="5.88,314,1635174000"; 
   d="scan'208";a="60495849"
Received: from unknown (HELO oym-r1.gw.nic.fujitsu.com) ([210.162.30.89])
  by esa3.hc1455-7.c3s2.iphmx.com with ESMTP; 25 Jan 2022 16:14:37 +0900
Received: from oym-m3.gw.nic.fujitsu.com (oym-nat-oym-m3.gw.nic.fujitsu.com [192.168.87.60])
        by oym-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id E15E8E8FF8
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 16:14:35 +0900 (JST)
Received: from yto-om4.fujitsu.com (yto-om4.o.css.fujitsu.com [10.128.89.165])
        by oym-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 1B36BD95EE
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 16:14:35 +0900 (JST)
Received: from localhost.localdomain (n3235113.np.ts.nmh.cs.fujitsu.co.jp [10.123.235.113])
        by yto-om4.fujitsu.com (Postfix) with ESMTP id C5D25400C1BBD;
        Tue, 25 Jan 2022 16:14:34 +0900 (JST)
From:   Kohei Tarumizu <tarumizu.kohei@fujitsu.com>
To:     catalin.marinas@arm.com, will@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     tarumizu.kohei@fujitsu.com
Subject: [PATCH 5/8] arm64: Create cache sysfs directory without ACPI PPTT for hardware prefetch control
Date:   Tue, 25 Jan 2022 16:14:11 +0900
Message-Id: <20220125071414.811344-6-tarumizu.kohei@fujitsu.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220125071414.811344-1-tarumizu.kohei@fujitsu.com>
References: <20220125071414.811344-1-tarumizu.kohei@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch will create a cache sysfs directory without ACPI PPTT if
the CONFIG_HWPF_CONTROL is true.

Hardware prefetch control driver need cache sysfs directory and cache
level/type information. In ARM processor, these information can be
obtained from the register even without PPTT. Therefore, we set the
cpu_map_populated to true to create cache sysfs directory if the
machine doesn't have PPTT.

Signed-off-by: Kohei Tarumizu <tarumizu.kohei@fujitsu.com>
---
 arch/arm64/kernel/cacheinfo.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm64/kernel/cacheinfo.c b/arch/arm64/kernel/cacheinfo.c
index 587543c6c51c..039ec32d0b3d 100644
--- a/arch/arm64/kernel/cacheinfo.c
+++ b/arch/arm64/kernel/cacheinfo.c
@@ -43,6 +43,21 @@ static void ci_leaf_init(struct cacheinfo *this_leaf,
 	this_leaf->type = type;
 }
 
+#if defined(CONFIG_HWPF_CONTROL)
+static bool acpi_has_pptt(void)
+{
+	struct acpi_table_header *table;
+	acpi_status status;
+
+	status = acpi_get_table(ACPI_SIG_PPTT, 0, &table);
+	if (ACPI_FAILURE(status))
+		return false;
+
+	acpi_put_table(table);
+	return true;
+}
+#endif
+
 int init_cache_level(unsigned int cpu)
 {
 	unsigned int ctype, level, leaves, fw_level;
@@ -95,5 +110,19 @@ int populate_cache_leaves(unsigned int cpu)
 			ci_leaf_init(this_leaf++, type, level);
 		}
 	}
+
+#if defined(CONFIG_HWPF_CONTROL)
+	/*
+	 * Hardware prefetch functions need cache sysfs directory and cache
+	 * level/type information. In ARM processor, these information can be
+	 * obtained from registers even without PPTT. Therefore, we set the
+	 * cpu_map_populated to true to create cache sysfs directory, if the
+	 * machine doesn't have PPTT.
+	 **/
+	if (!acpi_disabled)
+		if (!acpi_has_pptt())
+			this_cpu_ci->cpu_map_populated = true;
+#endif
+
 	return 0;
 }
-- 
2.27.0

