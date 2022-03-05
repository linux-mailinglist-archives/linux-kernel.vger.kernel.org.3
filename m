Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29BCE4CE707
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 21:47:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232495AbiCEUr6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Mar 2022 15:47:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231810AbiCEUr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Mar 2022 15:47:56 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0204034B98
        for <linux-kernel@vger.kernel.org>; Sat,  5 Mar 2022 12:47:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646513224;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=2fc8Gxpcx7Zhgatwh3dEBnBzDu9lzxud4zSky9VbbU4=;
        b=K+dAwXe3VgnixLPETYwsefACmb4N8cqKvHw80ggnSiXV8lwNdNsDF0WrpFohEbYM6lDick
        UAsEgCydAH0l2EKD0B50jdUE/ggVo0Mxqi5QTnQ4+z7m/nd5tBBvGaZxzbW2pH7ucMEn2C
        L8opP35PENdJxrvVG0h+setgisBCHos=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-299-3jW-woVDNDmfAZJqpJwgBg-1; Sat, 05 Mar 2022 15:47:02 -0500
X-MC-Unique: 3jW-woVDNDmfAZJqpJwgBg-1
Received: by mail-qv1-f72.google.com with SMTP id u1-20020ad45aa1000000b00435311d5b9fso8028934qvg.19
        for <linux-kernel@vger.kernel.org>; Sat, 05 Mar 2022 12:47:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2fc8Gxpcx7Zhgatwh3dEBnBzDu9lzxud4zSky9VbbU4=;
        b=tDfpY8UCi/zh8OhjPx2gRH9fp8sElagTyH3J+dcBR80+ox74RlYBVjRTMET238CkMa
         PyDp+vBjVupDfqyZa4CkwY0+2TpMKYxZ1SAKVndNCtLQrFYPXCSZ7vzUFuFfnYyqSfxe
         /wTJ3ES8uYSsAQlaIIecrE/KgebDkMUJpyT2SyDhRtjR+cAQlXitnzD7n7j6IdQgq8D+
         r0yOTc1AbEftEA2m1J28opEZt2SXbjwD0PnmfLgvW7vAOYZVNVgguKbkfvvow+IA59Wd
         o7aYae/SLe63JQgNT7E8n4N/92/cju5Xx8pE4vuK7iArlsbFBErs/u9//p1ewUrRhZ/g
         vCQg==
X-Gm-Message-State: AOAM530MJHzn0zRBREUSFFYMtZSyeuswIP9GXq4M1O/P8j3Eo3n3kvMv
        w3c6QcM8oQKhrv1/KY6jymMkuZ4dcx40vELnj9Pg/Z5qAAuJm+Ub3moHjT68KRtu14xL5XxO/BF
        ezO8ucTd8yGYbPs7YVpHYzLCC
X-Received: by 2002:a05:622a:54b:b0:2e0:634d:1136 with SMTP id m11-20020a05622a054b00b002e0634d1136mr709406qtx.494.1646513222393;
        Sat, 05 Mar 2022 12:47:02 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzt8NahR+QVo5aapC9rYWNeYjDAXnxgheZXn0nMcCJ1x55g8uNOvGb7jtcL2ozTXIP+0ODtQw==
X-Received: by 2002:a05:622a:54b:b0:2e0:634d:1136 with SMTP id m11-20020a05622a054b00b002e0634d1136mr709394qtx.494.1646513222159;
        Sat, 05 Mar 2022 12:47:02 -0800 (PST)
Received: from localhost.localdomain.com (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id s11-20020a37a90b000000b005f1806cbfe4sm4206941qke.42.2022.03.05.12.47.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Mar 2022 12:47:01 -0800 (PST)
From:   trix@redhat.com
To:     lizefan.x@bytedance.com, tj@kernel.org, hannes@cmpxchg.org
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] cgroup: cleanup comments
Date:   Sat,  5 Mar 2022 12:46:57 -0800
Message-Id: <20220305204657.707070-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

for spdx, add a space before //

replacements
judgement to judgment
transofrmed to transformed
partitition to partition
histrical to historical
migratecd to migrated

Signed-off-by: Tom Rix <trix@redhat.com>
---
 kernel/cgroup/cpuset.c  | 10 +++++-----
 kernel/cgroup/freezer.c |  2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index ef88cc366bb84..9390bfd9f1cd3 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -71,7 +71,7 @@ DEFINE_STATIC_KEY_FALSE(cpusets_enabled_key);
 
 /*
  * There could be abnormal cpuset configurations for cpu or memory
- * node binding, add this key to provide a quick low-cost judgement
+ * node binding, add this key to provide a quick low-cost judgment
  * of the situation.
  */
 DEFINE_STATIC_KEY_FALSE(cpusets_insane_config_key);
@@ -1181,7 +1181,7 @@ enum subparts_cmd {
  * effective_cpus. The function will return 0 if all the CPUs listed in
  * cpus_allowed can be granted or an error code will be returned.
  *
- * For partcmd_disable, the cpuset is being transofrmed from a partition
+ * For partcmd_disable, the cpuset is being transformed from a partition
  * root back to a non-partition root. Any CPUs in cpus_allowed that are in
  * parent's subparts_cpus will be taken away from that cpumask and put back
  * into parent's effective_cpus. 0 should always be returned.
@@ -2027,7 +2027,7 @@ static int update_flag(cpuset_flagbits_t bit, struct cpuset *cs,
 }
 
 /*
- * update_prstate - update partititon_root_state
+ * update_prstate - update partition_root_state
  * cs: the cpuset to update
  * new_prs: new partition root state
  *
@@ -2879,7 +2879,7 @@ static int cpuset_css_online(struct cgroup_subsys_state *css)
 	/*
 	 * Clone @parent's configuration if CGRP_CPUSET_CLONE_CHILDREN is
 	 * set.  This flag handling is implemented in cgroup core for
-	 * histrical reasons - the flag may be specified during mount.
+	 * historical reasons - the flag may be specified during mount.
 	 *
 	 * Currently, if any sibling cpusets have exclusive cpus or mem, we
 	 * refuse to clone the configuration - thereby refusing the task to
@@ -3076,7 +3076,7 @@ hotplug_update_tasks_legacy(struct cpuset *cs,
 
 	/*
 	 * Don't call update_tasks_cpumask() if the cpuset becomes empty,
-	 * as the tasks will be migratecd to an ancestor.
+	 * as the tasks will be migrated to an ancestor.
 	 */
 	if (cpus_updated && !cpumask_empty(cs->cpus_allowed))
 		update_tasks_cpumask(cs);
diff --git a/kernel/cgroup/freezer.c b/kernel/cgroup/freezer.c
index 3984dd6b8ddbc..617861a547935 100644
--- a/kernel/cgroup/freezer.c
+++ b/kernel/cgroup/freezer.c
@@ -1,4 +1,4 @@
-//SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0
 #include <linux/cgroup.h>
 #include <linux/sched.h>
 #include <linux/sched/task.h>
-- 
2.26.3

