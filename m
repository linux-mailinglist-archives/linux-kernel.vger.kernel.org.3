Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86376537725
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 10:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233438AbiE3IOg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 04:14:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233371AbiE3IOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 04:14:04 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4C5AC74DDD;
        Mon, 30 May 2022 01:13:57 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C630C113E;
        Mon, 30 May 2022 01:13:56 -0700 (PDT)
Received: from pierre123.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 97FA83F73D;
        Mon, 30 May 2022 01:13:54 -0700 (PDT)
From:   Pierre Gondois <pierre.gondois@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ionela.Voinescu@arm.com, Dietmar.Eggemann@arm.com,
        Pierre Gondois <pierre.gondois@arm.com>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Pierre Gondois <Pierre.Gondois@arm.com>,
        linux-pm@vger.kernel.org
Subject: [PATCH v1] cpufreq: CPPC: Fix unused-function warning
Date:   Mon, 30 May 2022 10:12:36 +0200
Message-Id: <20220530081236.40728-1-pierre.gondois@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Building the cppc_cpufreq driver with for arm64 with
CONFIG_ENERGY_MODEL=n triggers the following warnings:
 drivers/cpufreq/cppc_cpufreq.c:550:12: error: ‘cppc_get_cpu_cost’ defined but not used
[-Werror=unused-function]
   550 | static int cppc_get_cpu_cost(struct device *cpu_dev, unsigned long KHz,
       |            ^~~~~~~~~~~~~~~~~
 drivers/cpufreq/cppc_cpufreq.c:481:12: error: ‘cppc_get_cpu_power’ defined but not used
[-Werror=unused-function]
   481 | static int cppc_get_cpu_power(struct device *cpu_dev,
       |            ^~~~~~~~~~~~~~~~~~

Fixes: 740fcdc2c20e ("cpufreq: CPPC: Register EM based on efficiency class information")
Reported-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
---
 drivers/cpufreq/cppc_cpufreq.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index d092c9bb4ba3..ecd0d3ee48c5 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -478,7 +478,7 @@ static inline unsigned long compute_cost(int cpu, int step)
 			step * CPPC_EM_COST_STEP;
 }
 
-static int cppc_get_cpu_power(struct device *cpu_dev,
+static __maybe_unused int cppc_get_cpu_power(struct device *cpu_dev,
 		unsigned long *power, unsigned long *KHz)
 {
 	unsigned long perf_step, perf_prev, perf, perf_check;
@@ -547,8 +547,8 @@ static int cppc_get_cpu_power(struct device *cpu_dev,
 	return 0;
 }
 
-static int cppc_get_cpu_cost(struct device *cpu_dev, unsigned long KHz,
-		unsigned long *cost)
+static __maybe_unused int cppc_get_cpu_cost(struct device *cpu_dev,
+		unsigned long KHz, unsigned long *cost)
 {
 	unsigned long perf_step, perf_prev;
 	struct cppc_perf_caps *perf_caps;
-- 
2.25.1

