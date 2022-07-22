Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF34657D8BE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 04:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234199AbiGVCqQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 22:46:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231768AbiGVCqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 22:46:13 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05AAA1706C;
        Thu, 21 Jul 2022 19:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658457971; x=1689993971;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=kZruc0Eurt8MDfbaeLpfrOBl5EnpGijDalH8rviQon4=;
  b=hRx+gZqMk4Kk7/6ixbOISVF1XiU0zHY6Si5hXuEIkAJLpEIfJKPlefC8
   c41aGhEGOqIV0AphvGaT74V4XR4nVv7SYZG/s0F4tHIwWee9WscyEDgPx
   F6WSyep8OWjosWbDyH6MbV99q72HSgoB7wzXrC9ugh2PmVPAv5VSCP/VR
   SkgfqLLKBSRDaA1HrCDvsrASwIjN0J7+Qo7O0tJSHhmSUnahqBgNI7Hem
   waui6ouOKGJyldAU2Np/uHOIvCI0gSYPUuWMuhwwwB0HAdRWhxRaCmmZa
   oTu/rLT09rPUVmzdw/P+RxTs0XgdMPYV8ufPzAKZcqWAowOF5wgLe+LVm
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10415"; a="267618616"
X-IronPort-AV: E=Sophos;i="5.93,184,1654585200"; 
   d="scan'208";a="267618616"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2022 19:46:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,184,1654585200"; 
   d="scan'208";a="725274937"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.132])
  by orsmga004.jf.intel.com with ESMTP; 21 Jul 2022 19:46:08 -0700
From:   Zhao Liu <zhao1.liu@linux.intel.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        trivial@kernel.org, Rusty Russell <rusty@rustcorp.com.au>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhao Liu <zhao1.liu@intel.com>,
        Zhao Liu <zhao1.liu@linux.intel.com>
Subject: [patch] cpufreq: ondemand: Use cpumask_var_t for on-stack cpu mask
Date:   Fri, 22 Jul 2022 10:50:24 +0800
Message-Id: <20220722025024.454626-1-zhao1.liu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A cpumask structure on the stack can cause a warning with
CONFIG_NR_CPUS=8192 (e.g. Ubuntu 22.04 uses this):

drivers/cpufreq/cpufreq_ondemand.c: In function 'od_set_powersave_bias':
drivers/cpufreq/cpufreq_ondemand.c:449:1: warning: the frame size of
	1032 bytes is larger than 1024 bytes [-Wframe-larger-than=]
  449 | }
      | ^

CONFIG_CPUMASK_OFFSTACK=y is enabled by default for most distros, and
hence we can work around the warning by using cpumask_var_t.

Signed-off-by: Zhao Liu <zhao1.liu@linux.intel.com>
---
 drivers/cpufreq/cpufreq_ondemand.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_ondemand.c b/drivers/cpufreq/cpufreq_ondemand.c
index e8fbf970ff07..c52d19d67557 100644
--- a/drivers/cpufreq/cpufreq_ondemand.c
+++ b/drivers/cpufreq/cpufreq_ondemand.c
@@ -416,10 +416,13 @@ static struct dbs_governor od_dbs_gov = {
 static void od_set_powersave_bias(unsigned int powersave_bias)
 {
 	unsigned int cpu;
-	cpumask_t done;
+	cpumask_var_t done;
+
+	if (!alloc_cpumask_var(&done, GFP_KERNEL))
+		return;
 
 	default_powersave_bias = powersave_bias;
-	cpumask_clear(&done);
+	cpumask_clear(done);
 
 	cpus_read_lock();
 	for_each_online_cpu(cpu) {
@@ -428,7 +431,7 @@ static void od_set_powersave_bias(unsigned int powersave_bias)
 		struct dbs_data *dbs_data;
 		struct od_dbs_tuners *od_tuners;
 
-		if (cpumask_test_cpu(cpu, &done))
+		if (cpumask_test_cpu(cpu, done))
 			continue;
 
 		policy = cpufreq_cpu_get_raw(cpu);
@@ -439,13 +442,15 @@ static void od_set_powersave_bias(unsigned int powersave_bias)
 		if (!policy_dbs)
 			continue;
 
-		cpumask_or(&done, &done, policy->cpus);
+		cpumask_or(done, done, policy->cpus);
 
 		dbs_data = policy_dbs->dbs_data;
 		od_tuners = dbs_data->tuners;
 		od_tuners->powersave_bias = default_powersave_bias;
 	}
 	cpus_read_unlock();
+
+	free_cpumask_var(done);
 }
 
 void od_register_powersave_bias_handler(unsigned int (*f)
-- 
2.34.1

