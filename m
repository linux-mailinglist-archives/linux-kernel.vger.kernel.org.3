Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7AC523DE6
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 21:48:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347198AbiEKTrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 15:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347129AbiEKTrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 15:47:04 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D2AA3BFB3;
        Wed, 11 May 2022 12:47:03 -0700 (PDT)
Date:   Wed, 11 May 2022 19:47:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652298422;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o12jwQqDez/wgOojmi9BvDugT3+38sE2+WoeNF5qJ1c=;
        b=4nSNTsXWYEXMg18ZH6jw4tvRG4Fr9GeBVEM7HelIyIUrKamQ+O8NMS0QquaIvFyESvtvb3
        1VvRn+U0rCnMJjRFdGL9psP2FRN6slvJIWnWvPaEThBdV+g/1mT3Sa+5M/zbcKm8ZAxYth
        xk0YyfWGeTCjb588oOfxxwiIGbQtt6w4xmZ73rknY9R61g+/EnwrM4leYLTR72UQqnXq44
        8L5kBlL5a1eh/6YuBaefe0j8Y6EMmnw7hWeEBALsX+HlBvG65+rAKZjN+bMfB17ocD5npg
        LsyA7dg1A0l7GZ4ZQz3LtvdQdsNAlxpum1gdYwtKRXEAbsq65dQOC7LiOkShwA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652298422;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o12jwQqDez/wgOojmi9BvDugT3+38sE2+WoeNF5qJ1c=;
        b=QKo5Z2UMHfM92MqExB+f3/7S6QuewSLwGRb1YWhrtt/TZhrS5dhMYWJktmVp0LuwHKA2la
        m9pW5N2brT3dONBw==
From:   "tip-bot2 for Ravi Bangoria" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/amd/ibs: Cascade pmu init functions' return value
Cc:     Ravi Bangoria <ravi.bangoria@amd.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220509044914.1473-2-ravi.bangoria@amd.com>
References: <20220509044914.1473-2-ravi.bangoria@amd.com>
MIME-Version: 1.0
Message-ID: <165229842102.4207.5174745133017716315.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     39b2ca75eec8a33e2ffdb8aa0c4840ec3e3b472c
Gitweb:        https://git.kernel.org/tip/39b2ca75eec8a33e2ffdb8aa0c4840ec3e3b472c
Author:        Ravi Bangoria <ravi.bangoria@amd.com>
AuthorDate:    Mon, 09 May 2022 10:19:07 +05:30
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 11 May 2022 16:27:09 +02:00

perf/amd/ibs: Cascade pmu init functions' return value

IBS pmu initialization code ignores return value provided by
callee functions. Fix it.

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20220509044914.1473-2-ravi.bangoria@amd.com
---
 arch/x86/events/amd/ibs.c | 37 +++++++++++++++++++++++++++++--------
 1 file changed, 29 insertions(+), 8 deletions(-)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index 11e8b49..2704ec1 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -777,9 +777,10 @@ static __init int perf_ibs_pmu_init(struct perf_ibs *perf_ibs, char *name)
 	return ret;
 }
 
-static __init void perf_event_ibs_init(void)
+static __init int perf_event_ibs_init(void)
 {
 	struct attribute **attr = ibs_op_format_attrs;
+	int ret;
 
 	/*
 	 * Some chips fail to reset the fetch count when it is written; instead
@@ -791,7 +792,9 @@ static __init void perf_event_ibs_init(void)
 	if (boot_cpu_data.x86 == 0x19 && boot_cpu_data.x86_model < 0x10)
 		perf_ibs_fetch.fetch_ignore_if_zero_rip = 1;
 
-	perf_ibs_pmu_init(&perf_ibs_fetch, "ibs_fetch");
+	ret = perf_ibs_pmu_init(&perf_ibs_fetch, "ibs_fetch");
+	if (ret)
+		return ret;
 
 	if (ibs_caps & IBS_CAPS_OPCNT) {
 		perf_ibs_op.config_mask |= IBS_OP_CNT_CTL;
@@ -804,15 +807,35 @@ static __init void perf_event_ibs_init(void)
 		perf_ibs_op.cnt_mask    |= IBS_OP_MAX_CNT_EXT_MASK;
 	}
 
-	perf_ibs_pmu_init(&perf_ibs_op, "ibs_op");
+	ret = perf_ibs_pmu_init(&perf_ibs_op, "ibs_op");
+	if (ret)
+		goto err_op;
+
+	ret = register_nmi_handler(NMI_LOCAL, perf_ibs_nmi_handler, 0, "perf_ibs");
+	if (ret)
+		goto err_nmi;
 
-	register_nmi_handler(NMI_LOCAL, perf_ibs_nmi_handler, 0, "perf_ibs");
 	pr_info("perf: AMD IBS detected (0x%08x)\n", ibs_caps);
+	return 0;
+
+err_nmi:
+	perf_pmu_unregister(&perf_ibs_op.pmu);
+	free_percpu(perf_ibs_op.pcpu);
+	perf_ibs_op.pcpu = NULL;
+err_op:
+	perf_pmu_unregister(&perf_ibs_fetch.pmu);
+	free_percpu(perf_ibs_fetch.pcpu);
+	perf_ibs_fetch.pcpu = NULL;
+
+	return ret;
 }
 
 #else /* defined(CONFIG_PERF_EVENTS) && defined(CONFIG_CPU_SUP_AMD) */
 
-static __init void perf_event_ibs_init(void) { }
+static __init int perf_event_ibs_init(void)
+{
+	return 0;
+}
 
 #endif
 
@@ -1082,9 +1105,7 @@ static __init int amd_ibs_init(void)
 			  x86_pmu_amd_ibs_starting_cpu,
 			  x86_pmu_amd_ibs_dying_cpu);
 
-	perf_event_ibs_init();
-
-	return 0;
+	return perf_event_ibs_init();
 }
 
 /* Since we need the pci subsystem to init ibs we can't do this earlier: */
