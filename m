Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E14BC507F4C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 05:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359106AbiDTDGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 23:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359100AbiDTDGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 23:06:16 -0400
Received: from esa8.hc1455-7.c3s2.iphmx.com (esa8.hc1455-7.c3s2.iphmx.com [139.138.61.253])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2D8E396AA
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 20:03:30 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6400,9594,10322"; a="58439831"
X-IronPort-AV: E=Sophos;i="5.90,274,1643641200"; 
   d="scan'208";a="58439831"
Received: from unknown (HELO oym-r2.gw.nic.fujitsu.com) ([210.162.30.90])
  by esa8.hc1455-7.c3s2.iphmx.com with ESMTP; 20 Apr 2022 12:02:25 +0900
Received: from oym-m1.gw.nic.fujitsu.com (oym-nat-oym-m1.gw.nic.fujitsu.com [192.168.87.58])
        by oym-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 10211DB9F6
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 12:02:25 +0900 (JST)
Received: from yto-om1.fujitsu.com (yto-om1.o.css.fujitsu.com [10.128.89.162])
        by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 3B68FD9C6A
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 12:02:24 +0900 (JST)
Received: from cn-r05-10.example.com (n3235113.np.ts.nmh.cs.fujitsu.co.jp [10.123.235.113])
        by yto-om1.fujitsu.com (Postfix) with ESMTP id AB4EE404AFD51;
        Wed, 20 Apr 2022 12:02:23 +0900 (JST)
From:   Kohei Tarumizu <tarumizu.kohei@fujitsu.com>
To:     catalin.marinas@arm.com, will@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        fenghua.yu@intel.com, reinette.chatre@intel.com
Cc:     tarumizu.kohei@fujitsu.com
Subject: [PATCH v3 5/9] arm64: Create cache sysfs directory without ACPI PPTT for hardware prefetch control
Date:   Wed, 20 Apr 2022 12:02:19 +0900
Message-Id: <20220420030223.689259-6-tarumizu.kohei@fujitsu.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220420030223.689259-1-tarumizu.kohei@fujitsu.com>
References: <20220420030223.689259-1-tarumizu.kohei@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch create a cache sysfs directory without ACPI PPTT if the
CONFIG_HWPF_CONTROL is true. This patch use only the level/type
information obtained from CLIDR_EL1, and don't use CCSIDR information.

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

