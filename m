Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7FB51E228
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 01:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444861AbiEFW6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 18:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444521AbiEFW6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 18:58:03 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA4896D384;
        Fri,  6 May 2022 15:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651877659; x=1683413659;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=caep34WgZSvPyz713lBbhCJDWIsKpnx2psF2WpckZJs=;
  b=jJst+hgZp4Pw/pYbeQutuj6KdweELVJhrZI6of/sFzdWDwO/vX+ktjZi
   A4FA2gzmRFLTjGondK0QfBlbDWUFtqDG9UgyjpaHNmHtdH+OtO84z6ngY
   OwV8xX+g2AB27c7BDKPbpJg0XDXGBTc9YC6+J11J/+kYg3SEBcpHjjwaX
   7TKSaJ4lvVUx1GhRV4F0A0oDUDDiSLHzLSeyHTp3k5gA7ywAyhOcfHy+j
   IKa+ATENmy5bAca1yqPz+3lOAtCTbsDhf28wO2bFoRogANE1tF0AODVuU
   ePkY3CArA+BcLNqZZqalG8y5/iiOHNi5QrM9BYJrsGzwawhXY4TEFcPfW
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10339"; a="256080786"
X-IronPort-AV: E=Sophos;i="5.91,205,1647327600"; 
   d="scan'208";a="256080786"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2022 15:54:18 -0700
X-IronPort-AV: E=Sophos;i="5.91,205,1647327600"; 
   d="scan'208";a="695383623"
Received: from agluck-desk3.sc.intel.com ([172.25.222.78])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2022 15:54:18 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     hdegoede@redhat.com, markgross@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        corbet@lwn.net, gregkh@linuxfoundation.org,
        andriy.shevchenko@linux.intel.com, jithu.joseph@intel.com,
        ashok.raj@intel.com, tony.luck@intel.com, rostedt@goodmis.org,
        dan.j.williams@intel.com, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        patches@lists.linux.dev, ravi.v.shankar@intel.com,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v7 03/12] stop_machine: Add stop_core_cpuslocked() for per-core operations
Date:   Fri,  6 May 2022 15:54:01 -0700
Message-Id: <20220506225410.1652287-4-tony.luck@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220506225410.1652287-1-tony.luck@intel.com>
References: <20220506014035.1173578-1-tony.luck@intel.com>
 <20220506225410.1652287-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

Hardware core level testing features require near simultaneous execution
of WRMSR instructions on all threads of a core to initiate a test.

Provide a customized cut down version of stop_machine_cpuslocked() that
just operates on the threads of a single core.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/stop_machine.h | 16 ++++++++++++++++
 kernel/stop_machine.c        | 19 +++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/include/linux/stop_machine.h b/include/linux/stop_machine.h
index 46fb3ebdd16e..ea7a74ea7389 100644
--- a/include/linux/stop_machine.h
+++ b/include/linux/stop_machine.h
@@ -124,6 +124,22 @@ int stop_machine(cpu_stop_fn_t fn, void *data, const struct cpumask *cpus);
  */
 int stop_machine_cpuslocked(cpu_stop_fn_t fn, void *data, const struct cpumask *cpus);
 
+/**
+ * stop_core_cpuslocked: - stop all threads on just one core
+ * @cpu: any cpu in the targeted core
+ * @fn: the function to run
+ * @data: the data ptr for @fn()
+ *
+ * Same as above, but instead of every CPU, only the logical CPUs of a
+ * single core are affected.
+ *
+ * Context: Must be called from within a cpus_read_lock() protected region.
+ *
+ * Return: 0 if all executions of @fn returned 0, any non zero return
+ * value if any returned non zero.
+ */
+int stop_core_cpuslocked(unsigned int cpu, cpu_stop_fn_t fn, void *data);
+
 int stop_machine_from_inactive_cpu(cpu_stop_fn_t fn, void *data,
 				   const struct cpumask *cpus);
 #else	/* CONFIG_SMP || CONFIG_HOTPLUG_CPU */
diff --git a/kernel/stop_machine.c b/kernel/stop_machine.c
index cbc30271ea4d..579761729836 100644
--- a/kernel/stop_machine.c
+++ b/kernel/stop_machine.c
@@ -633,6 +633,25 @@ int stop_machine(cpu_stop_fn_t fn, void *data, const struct cpumask *cpus)
 }
 EXPORT_SYMBOL_GPL(stop_machine);
 
+int stop_core_cpuslocked(unsigned int cpu, cpu_stop_fn_t fn, void *data)
+{
+	const struct cpumask *smt_mask = cpu_smt_mask(cpu);
+
+	struct multi_stop_data msdata = {
+		.fn = fn,
+		.data = data,
+		.num_threads = cpumask_weight(smt_mask),
+		.active_cpus = smt_mask,
+	};
+
+	lockdep_assert_cpus_held();
+
+	/* Set the initial state and stop all online cpus. */
+	set_state(&msdata, MULTI_STOP_PREPARE);
+	return stop_cpus(smt_mask, multi_cpu_stop, &msdata);
+}
+EXPORT_SYMBOL_GPL(stop_core_cpuslocked);
+
 /**
  * stop_machine_from_inactive_cpu - stop_machine() from inactive CPU
  * @fn: the function to run
-- 
2.35.1

