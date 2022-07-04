Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB4AC5651F9
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 12:18:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234399AbiGDKR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 06:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233303AbiGDKQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 06:16:34 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ED747DFA9
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 03:16:33 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 11E5C23A;
        Mon,  4 Jul 2022 03:16:34 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DB9EC3F792;
        Mon,  4 Jul 2022 03:16:31 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>, conor.dooley@microchip.com,
        valentina.fernandezalanis@microchip.com,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Qing Wang <wangqing@vivo.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Pierre Gondois <pierre.gondois@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, Gavin Shan <gshan@redhat.com>
Subject: [PATCH v6 09/21] arch_topology: Add support to parse and detect cache attributes
Date:   Mon,  4 Jul 2022 11:15:53 +0100
Message-Id: <20220704101605.1318280-10-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220704101605.1318280-1-sudeep.holla@arm.com>
References: <20220704101605.1318280-1-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently ACPI populates just the minimum information about the last
level cache from PPTT in order to feed the same to build sched_domains.
Similar support for DT platforms is not present.

In order to enable the same, the entire cache hierarchy information can
be built as part of CPU topoplogy parsing both on ACPI and DT platforms.

Note that this change builds the cacheinfo early even on ACPI systems,
but the current mechanism of building llc_sibling mask remains unchanged.

Tested-by: Ionela Voinescu <ionela.voinescu@arm.com>
Reviewed-by: Gavin Shan <gshan@redhat.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/base/arch_topology.c | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index 579c851a2bd7..e2f7d9ea558e 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/acpi.h>
+#include <linux/cacheinfo.h>
 #include <linux/cpu.h>
 #include <linux/cpufreq.h>
 #include <linux/device.h>
@@ -780,15 +781,28 @@ __weak int __init parse_acpi_topology(void)
 #if defined(CONFIG_ARM64) || defined(CONFIG_RISCV)
 void __init init_cpu_topology(void)
 {
+	int ret, cpu;
+
 	reset_cpu_topology();
+	ret = parse_acpi_topology();
+	if (!ret)
+		ret = of_have_populated_dt() && parse_dt_topology();
 
-	/*
-	 * Discard anything that was parsed if we hit an error so we
-	 * don't use partial information.
-	 */
-	if (parse_acpi_topology())
-		reset_cpu_topology();
-	else if (of_have_populated_dt() && parse_dt_topology())
+	if (ret) {
+		/*
+		 * Discard anything that was parsed if we hit an error so we
+		 * don't use partial information.
+		 */
 		reset_cpu_topology();
+		return;
+	}
+
+	for_each_possible_cpu(cpu) {
+		ret = detect_cache_attributes(cpu);
+		if (ret) {
+			pr_info("Early cacheinfo failed, ret = %d\n", ret);
+			break;
+		}
+	}
 }
 #endif
-- 
2.37.0

