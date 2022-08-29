Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D91DB5A4CA9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 14:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbiH2M5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 08:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbiH2M42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 08:56:28 -0400
Received: from mail-ej1-x649.google.com (mail-ej1-x649.google.com [IPv6:2a00:1450:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8838277EBA
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 05:48:13 -0700 (PDT)
Received: by mail-ej1-x649.google.com with SMTP id sb14-20020a1709076d8e00b0073d48a10e10so2271094ejc.16
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 05:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc;
        bh=xCb3PCmBWSP36RKUEWOlpZN7hfh85Z1tvKAaYcX0zpk=;
        b=bkzY5qKI18VWd4mlwWM1vsviFVP4q78HrnTxrdtR5mo9H6pfnRG17R5qugpXfL7a3C
         wCeY287TAp6qkMpaEvrmcs8dRYfSWwV8oWll0gU0C2+YoURGAMIxPu5xp4rjPy+bUaaA
         Pe7ln30jJ/atykyMBocwI9/fKS382484rx9GtCgqO1avY7pHIQ5SHOMiGbCVqPIvYzgc
         vum+2/Q5MVS6eBFJN4+hVCuVqfedsJUjTaeXPMQ2Z03LEk0tk/b+PnLwtSM5gTRlKVFJ
         4wj5vAGL/ISBuJFFNcV6QXU/h0GHjtdWdo2nTY8203whs27GL67Jq5Zsc5AZdNjCjL6M
         R2zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=xCb3PCmBWSP36RKUEWOlpZN7hfh85Z1tvKAaYcX0zpk=;
        b=ZG4xkXducKPa/QwTe4V7JnTPoqTkirncfuzEL+QEcKk/dzOJkPopvAXxBGxt+jBpAZ
         OP+zI/YPCY4y+qiZ5fCzMiGcSv1vUGUz4Ok8JMGtiObzvOzwWwuqI/3kBR3PdJ6hH1xe
         XXmDxRKwzr3wqcZ4kquyijSDAcwXwIQ+i5KSclJhXQ6CwNnbdk/bvfGM3AuIPnuj6dsG
         yOL8Tp4cd1vAwpvLA0rqoU19jJ9tDmg4pUACKHDKMNCaEq75wbA6q5/5CN+/nCdkC8ga
         JDpxzi0fLmo3zmk3XVYaXo9vmB545f+GX6c3QNaX/uISRvckdFqzLyuKDg9bPcswbN2r
         2lJQ==
X-Gm-Message-State: ACgBeo000SOUGac7U3Cs3JtH3GD0dweXTAA9r/ENWmZdZu8gGmxmV8At
        pDX/0XpRPkbsgsOYC6IwaFP88CKLYQ==
X-Google-Smtp-Source: AA6agR7i/RJsfaE6+mHqdwn3xeEjB0tlbiv/szuLIYXZ6XN1jxpVHA+uSIe33NebngMb8iQE2cPcnN59JA==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:9c:201:196d:4fc7:fa9c:62e3])
 (user=elver job=sendgmr) by 2002:a17:906:ef90:b0:730:9d18:17b3 with SMTP id
 ze16-20020a170906ef9000b007309d1817b3mr13769351ejb.141.1661777292013; Mon, 29
 Aug 2022 05:48:12 -0700 (PDT)
Date:   Mon, 29 Aug 2022 14:47:10 +0200
In-Reply-To: <20220829124719.675715-1-elver@google.com>
Mime-Version: 1.0
References: <20220829124719.675715-1-elver@google.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Message-ID: <20220829124719.675715-6-elver@google.com>
Subject: [PATCH v4 05/14] perf/hw_breakpoint: Mark data __ro_after_init
From:   Marco Elver <elver@google.com>
To:     elver@google.com, Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-perf-users@vger.kernel.org,
        x86@kernel.org, linux-sh@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark read-only data after initialization as __ro_after_init.

While we are here, turn 'constraints_initialized' into a bool.

Signed-off-by: Marco Elver <elver@google.com>
Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
Acked-by: Ian Rogers <irogers@google.com>
---
 kernel/events/hw_breakpoint.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/events/hw_breakpoint.c b/kernel/events/hw_breakpoint.c
index 6d09edc80d19..7df46b276452 100644
--- a/kernel/events/hw_breakpoint.c
+++ b/kernel/events/hw_breakpoint.c
@@ -46,7 +46,7 @@ struct bp_cpuinfo {
 };
 
 static DEFINE_PER_CPU(struct bp_cpuinfo, bp_cpuinfo[TYPE_MAX]);
-static int nr_slots[TYPE_MAX];
+static int nr_slots[TYPE_MAX] __ro_after_init;
 
 static struct bp_cpuinfo *get_bp_info(int cpu, enum bp_type_idx type)
 {
@@ -62,7 +62,7 @@ static const struct rhashtable_params task_bps_ht_params = {
 	.automatic_shrinking = true,
 };
 
-static int constraints_initialized;
+static bool constraints_initialized __ro_after_init;
 
 /* Gather the number of total pinned and un-pinned bp in a cpuset */
 struct bp_busy_slots {
@@ -739,7 +739,7 @@ int __init init_hw_breakpoint(void)
 	if (ret)
 		goto err;
 
-	constraints_initialized = 1;
+	constraints_initialized = true;
 
 	perf_pmu_register(&perf_breakpoint, "breakpoint", PERF_TYPE_BREAKPOINT);
 
-- 
2.37.2.672.g94769d06f0-goog

