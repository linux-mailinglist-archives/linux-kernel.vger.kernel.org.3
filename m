Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66F3852B27C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 08:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231613AbiERGdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 02:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231447AbiERGbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 02:31:33 -0400
Received: from esa9.hc1455-7.c3s2.iphmx.com (esa9.hc1455-7.c3s2.iphmx.com [139.138.36.223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43647AE59
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 23:31:31 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6400,9594,10350"; a="61256574"
X-IronPort-AV: E=Sophos;i="5.91,234,1647270000"; 
   d="scan'208";a="61256574"
Received: from unknown (HELO oym-r3.gw.nic.fujitsu.com) ([210.162.30.91])
  by esa9.hc1455-7.c3s2.iphmx.com with ESMTP; 18 May 2022 15:31:30 +0900
Received: from oym-m1.gw.nic.fujitsu.com (oym-nat-oym-m1.gw.nic.fujitsu.com [192.168.87.58])
        by oym-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id B9C1BD646F
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 15:31:30 +0900 (JST)
Received: from yto-om4.fujitsu.com (yto-om4.o.css.fujitsu.com [10.128.89.165])
        by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id E21E7D99EF
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 15:31:29 +0900 (JST)
Received: from cn-r05-10.example.com (n3235113.np.ts.nmh.cs.fujitsu.co.jp [10.123.235.113])
        by yto-om4.fujitsu.com (Postfix) with ESMTP id 5CE9C400D500B;
        Wed, 18 May 2022 15:31:29 +0900 (JST)
From:   Kohei Tarumizu <tarumizu.kohei@fujitsu.com>
To:     catalin.marinas@arm.com, will@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, gregkh@linuxfoundation.org,
        rafael@kernel.org, mchehab+huawei@kernel.org, eugenis@google.com,
        tony.luck@intel.com, pcc@google.com, peterz@infradead.org,
        marcos@orca.pet, conor.dooley@microchip.com,
        nicolas.ferre@microchip.com, marcan@marcan.st,
        linus.walleij@linaro.org, arnd@arndb.de,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     tarumizu.kohei@fujitsu.com
Subject: [PATCH v4 5/8] arm64: Create cache sysfs directory without ACPI PPTT for hardware prefetch control
Date:   Wed, 18 May 2022 15:30:29 +0900
Message-Id: <20220518063032.2377351-6-tarumizu.kohei@fujitsu.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220518063032.2377351-1-tarumizu.kohei@fujitsu.com>
References: <20220518063032.2377351-1-tarumizu.kohei@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create a cache sysfs directory without ACPI PPTT if the
CONFIG_HWPF_CONTROL is true.

Hardware prefetch control driver need cache sysfs directory and cache
level/type information. In ARM processor, these information can be
obtained from the register even without PPTT.

This patch set the cpu_map_populated to true if the machine doesn't
have PPTT. It use only the level/type information obtained from
CLIDR_EL1, and don't use CCSIDR information.

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

