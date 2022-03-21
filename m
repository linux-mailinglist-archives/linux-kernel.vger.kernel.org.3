Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B3AF4E23CA
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 10:58:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346110AbiCUJ7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 05:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346114AbiCUJ7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 05:59:31 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 620192726;
        Mon, 21 Mar 2022 02:58:03 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DAC871042;
        Mon, 21 Mar 2022 02:58:02 -0700 (PDT)
Received: from e123648.arm.com (unknown [10.57.22.222])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0B1823F766;
        Mon, 21 Mar 2022 02:57:59 -0700 (PDT)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     lukasz.luba@arm.com, dietmar.eggemann@arm.com,
        Pierre.Gondois@arm.com, ionela.voinescu@arm.com,
        viresh.kumar@linaro.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, linux-pm@vger.kernel.org,
        mka@chromium.org, nm@ti.com, sboyd@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, cristian.marussi@arm.com,
        sudeep.holla@arm.com, matthias.bgg@gmail.com
Subject: [RESEND][PATCH 5/8] PM: EM: Remove old debugfs files and print all 'flags'
Date:   Mon, 21 Mar 2022 09:57:26 +0000
Message-Id: <20220321095729.20655-6-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220321095729.20655-1-lukasz.luba@arm.com>
References: <20220321095729.20655-1-lukasz.luba@arm.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Energy Model gets more bits used in 'flags'. Avoid adding another
debugfs file just to print what is the status of a new flag. Simply
remove old debugfs files and add one generic which prints all flags
as a hex value.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 kernel/power/energy_model.c | 24 +++++-------------------
 1 file changed, 5 insertions(+), 19 deletions(-)

diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
index babefc72085d..092513575e4e 100644
--- a/kernel/power/energy_model.c
+++ b/kernel/power/energy_model.c
@@ -54,28 +54,15 @@ static int em_debug_cpus_show(struct seq_file *s, void *unused)
 }
 DEFINE_SHOW_ATTRIBUTE(em_debug_cpus);
 
-static int em_debug_units_show(struct seq_file *s, void *unused)
+static int em_debug_flags_show(struct seq_file *s, void *unused)
 {
 	struct em_perf_domain *pd = s->private;
-	char *units = (pd->flags & EM_PERF_DOMAIN_MILLIWATTS) ?
-		"milliWatts" : "bogoWatts";
 
-	seq_printf(s, "%s\n", units);
+	seq_printf(s, "%#lx\n", pd->flags);
 
 	return 0;
 }
-DEFINE_SHOW_ATTRIBUTE(em_debug_units);
-
-static int em_debug_skip_inefficiencies_show(struct seq_file *s, void *unused)
-{
-	struct em_perf_domain *pd = s->private;
-	int enabled = (pd->flags & EM_PERF_DOMAIN_SKIP_INEFFICIENCIES) ? 1 : 0;
-
-	seq_printf(s, "%d\n", enabled);
-
-	return 0;
-}
-DEFINE_SHOW_ATTRIBUTE(em_debug_skip_inefficiencies);
+DEFINE_SHOW_ATTRIBUTE(em_debug_flags);
 
 static void em_debug_create_pd(struct device *dev)
 {
@@ -89,9 +76,8 @@ static void em_debug_create_pd(struct device *dev)
 		debugfs_create_file("cpus", 0444, d, dev->em_pd->cpus,
 				    &em_debug_cpus_fops);
 
-	debugfs_create_file("units", 0444, d, dev->em_pd, &em_debug_units_fops);
-	debugfs_create_file("skip-inefficiencies", 0444, d, dev->em_pd,
-			    &em_debug_skip_inefficiencies_fops);
+	debugfs_create_file("flags", 0444, d, dev->em_pd,
+			    &em_debug_flags_fops);
 
 	/* Create a sub-directory for each performance state */
 	for (i = 0; i < dev->em_pd->nr_perf_states; i++)
-- 
2.17.1

