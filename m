Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DE17546CA6
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 20:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350139AbiFJSnH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 14:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347495AbiFJSnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 14:43:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9A9B0185CB6
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 11:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654886583;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Xh/bWsVeAHoWwIT5afnfeNS7HA2TjLceMmohCiFQ+fg=;
        b=TFtjbdG1QgoLcGX83tH1thxg24pMDmqx/8JwL/xWSL8CPAkPTSPRCVIlyDut4okhJrGwCU
        RBMe2BmWTl5nLa1Pr/cjRldfdaQz/eQN3ZncPpBO08zc+xFZVtTWfhVs79Aic/fT54P3So
        SvSDCGQjyjYkGvlog+eyVoe59jRj9cU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-460-ee17L72OOvG3s_teYF-Vdw-1; Fri, 10 Jun 2022 14:43:00 -0400
X-MC-Unique: ee17L72OOvG3s_teYF-Vdw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F2DC180013E;
        Fri, 10 Jun 2022 18:42:59 +0000 (UTC)
Received: from llong.com (unknown [10.22.34.253])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 571B0404E4BD;
        Fri, 10 Jun 2022 18:42:59 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH] rcu-tasks: Delay rcu_tasks_verify_self_tests() to avoid missed callbacks
Date:   Fri, 10 Jun 2022 14:42:12 -0400
Message-Id: <20220610184212.822113-1-longman@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Even though rcu_tasks selftest is initiated early in the boot process,
the verification done at late initcall time may not be late enough to
catch all the callbacks especially on systems with just a few cpus and
small memory.

After 12 bootup's On a s390x system, 1 of them had failed rcu_tasks
verification test.

[    8.183013] call_rcu_tasks() has been failed.
[    8.183041] WARNING: CPU: 0 PID: 1 at kernel/rcu/tasks.h:1696 rcu_tasks_verify_self_tests+0x64/0xd0
[    8.203246] Callback from call_rcu_tasks() invoked.

In this particular case, the callback missed the check by about
20ms. Similar rcu_tasks selftest failures are also seen in ppc64le
systems.

[    0.313391] call_rcu_tasks() has been failed.
[    0.313407] WARNING: CPU: 0 PID: 1 at kernel/rcu/tasks.h:1696 rcu_tasks_verify_self_tests+0x5c/0xa0
[    0.335569] Callback from call_rcu_tasks() invoked.

Avoid this missed callback by delaying the verification using
delayed_work. The delay is set to be about 0.1s which hopefully will
be long enough to catch all the callbacks on systems with few cpus and
small memory.

Fixes: bfba7ed084f8 ("rcu-tasks: Add RCU-tasks self tests")
Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/rcu/tasks.h | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 3925e32159b5..25f964a671ba 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -1735,7 +1735,7 @@ static void rcu_tasks_initiate_self_tests(void)
 #endif
 }
 
-static int rcu_tasks_verify_self_tests(void)
+static void rcu_tasks_verify_self_tests(struct work_struct *work __maybe_unused)
 {
 	int ret = 0;
 	int i;
@@ -1749,10 +1749,23 @@ static int rcu_tasks_verify_self_tests(void)
 
 	if (ret)
 		WARN_ON(1);
+}
+
+static struct delayed_work rcu_tasks_verify_work;
 
-	return ret;
+/*
+ * The rcu_tasks verification is done indirectly via the work queue to
+ * introduce an additional 0.1s delay to catch all the callbacks before
+ * the verification is done as late_initcall time may not be late enough
+ * to have all the callbacks fired.
+ */
+static int rcu_tasks_verify_schedule_work(void)
+{
+	INIT_DELAYED_WORK(&rcu_tasks_verify_work, rcu_tasks_verify_self_tests);
+	schedule_delayed_work(&rcu_tasks_verify_work, HZ/10);
+	return 0;
 }
-late_initcall(rcu_tasks_verify_self_tests);
+late_initcall(rcu_tasks_verify_schedule_work);
 #else /* #ifdef CONFIG_PROVE_RCU */
 static void rcu_tasks_initiate_self_tests(void) { }
 #endif /* #else #ifdef CONFIG_PROVE_RCU */
-- 
2.31.1

