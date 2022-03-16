Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB6904DBB66
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 00:52:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353268AbiCPXyA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 19:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353063AbiCPXxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 19:53:55 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 824901AF2F;
        Wed, 16 Mar 2022 16:52:39 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 479B01476;
        Wed, 16 Mar 2022 16:52:39 -0700 (PDT)
Received: from e123648.arm.com (unknown [10.57.19.225])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 662E33F766;
        Wed, 16 Mar 2022 16:52:36 -0700 (PDT)
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
Subject: [[PATCH 5/8] PM: EM: Remove old debugfs files and print all 'flags'
Date:   Wed, 16 Mar 2022 23:52:08 +0000
Message-Id: <20220316235211.29370-6-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220316235211.29370-1-lukasz.luba@arm.com>
References: <20220316235211.29370-1-lukasz.luba@arm.com>
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

