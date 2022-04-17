Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35B34504837
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Apr 2022 17:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234331AbiDQPoy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 11:44:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234317AbiDQPov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 11:44:51 -0400
Received: from ha.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 95FFF13F6B
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 08:42:14 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by ha.nfschina.com (Postfix) with ESMTP id 58F271E80CDD;
        Sun, 17 Apr 2022 23:40:16 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from ha.nfschina.com ([127.0.0.1])
        by localhost (ha.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id rku_9j_bI3yW; Sun, 17 Apr 2022 23:40:13 +0800 (CST)
Received: from localhost.localdomain (unknown [180.167.10.98])
        (Authenticated sender: liqiong@nfschina.com)
        by ha.nfschina.com (Postfix) with ESMTPA id 47D2B1E80CDC;
        Sun, 17 Apr 2022 23:40:13 +0800 (CST)
From:   liqiong <liqiong@nfschina.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, yuzhe@nfschina.com,
        renyu@nfschina.com, liqiong <liqiong@nfschina.com>
Subject: [PATCH] arch/x86: use 'NULL' insteadof '0' as null pointer
Date:   Sun, 17 Apr 2022 23:41:48 +0800
Message-Id: <20220417154148.541485-1-liqiong@nfschina.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sparse warns: "Using plain integer as NULL pointer".
Use 'NULL' as null pointer.

Signed-off-by: liqiong <liqiong@nfschina.com>
---
 arch/x86/events/rapl.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index 77e3a47af5ad..7d70690fded5 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -537,11 +537,11 @@ static struct perf_msr intel_rapl_spr_msrs[] = {
  * - want to use same event codes across both architectures
  */
 static struct perf_msr amd_rapl_msrs[] = {
-	[PERF_RAPL_PP0]  = { 0, &rapl_events_cores_group, 0, false, 0 },
+	[PERF_RAPL_PP0]  = { 0, &rapl_events_cores_group, NULL, false, 0 },
 	[PERF_RAPL_PKG]  = { MSR_AMD_PKG_ENERGY_STATUS,  &rapl_events_pkg_group,   test_msr, false, RAPL_MSR_MASK },
-	[PERF_RAPL_RAM]  = { 0, &rapl_events_ram_group,   0, false, 0 },
-	[PERF_RAPL_PP1]  = { 0, &rapl_events_gpu_group,   0, false, 0 },
-	[PERF_RAPL_PSYS] = { 0, &rapl_events_psys_group,  0, false, 0 },
+	[PERF_RAPL_RAM]  = { 0, &rapl_events_ram_group,   NULL, false, 0 },
+	[PERF_RAPL_PP1]  = { 0, &rapl_events_gpu_group,   NULL, false, 0 },
+	[PERF_RAPL_PSYS] = { 0, &rapl_events_psys_group,  NULL, false, 0 },
 };
 
 static int rapl_cpu_offline(unsigned int cpu)
-- 
2.25.1

