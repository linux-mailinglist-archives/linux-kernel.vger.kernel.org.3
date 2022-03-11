Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A32B4D5F5D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 11:23:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347852AbiCKKYE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 05:24:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347845AbiCKKXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 05:23:45 -0500
Received: from esa12.hc1455-7.c3s2.iphmx.com (esa12.hc1455-7.c3s2.iphmx.com [139.138.37.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9D5C25E3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 02:22:40 -0800 (PST)
X-IronPort-AV: E=McAfee;i="6200,9189,10282"; a="45621061"
X-IronPort-AV: E=Sophos;i="5.90,173,1643641200"; 
   d="scan'208";a="45621061"
Received: from unknown (HELO yto-r4.gw.nic.fujitsu.com) ([218.44.52.220])
  by esa12.hc1455-7.c3s2.iphmx.com with ESMTP; 11 Mar 2022 19:21:35 +0900
Received: from yto-m2.gw.nic.fujitsu.com (yto-nat-yto-m2.gw.nic.fujitsu.com [192.168.83.65])
        by yto-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 0D870E05CA
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 19:21:35 +0900 (JST)
Received: from yto-om1.fujitsu.com (yto-om1.o.css.fujitsu.com [10.128.89.162])
        by yto-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id E3BF8FD120
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 19:21:33 +0900 (JST)
Received: from cn-r05-10.example.com (n3235113.np.ts.nmh.cs.fujitsu.co.jp [10.123.235.113])
        by yto-om1.fujitsu.com (Postfix) with ESMTP id AA667406139C9;
        Fri, 11 Mar 2022 19:21:33 +0900 (JST)
From:   Kohei Tarumizu <tarumizu.kohei@fujitsu.com>
To:     catalin.marinas@arm.com, will@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     tarumizu.kohei@fujitsu.com
Subject: [PATCH v2 5/8] arm64: Create cache sysfs directory without ACPI PPTT for hardware prefetch control
Date:   Fri, 11 Mar 2022 19:19:37 +0900
Message-Id: <20220311101940.3403607-6-tarumizu.kohei@fujitsu.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220311101940.3403607-1-tarumizu.kohei@fujitsu.com>
References: <20220311101940.3403607-1-tarumizu.kohei@fujitsu.com>
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

This patch create a cache sysfs directory without ACPI PPTT if the
CONFIG_HWPF_CONTROL is true.

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

