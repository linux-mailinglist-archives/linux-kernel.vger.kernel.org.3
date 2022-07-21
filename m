Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26A4157C32D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 06:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231963AbiGUEGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 00:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231810AbiGUEF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 00:05:27 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31E5719029
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 21:05:25 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id g12so649305pfb.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 21:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XAbsx4z61PDmKxVrG+hWql1tanJuLJy0FXV+SbeVNSE=;
        b=n3xRXJ18Eab7FaOtwX3iQ8M5Fy8jiqky4vI6yYmrue1hP+DLKahrynn7eC45oq8pwv
         Rzb4EDX1fZFqqRvmOKFgP/BR33FOpvxGhPiKXyDA59rd8GTuagmsSEN4m/r2JxeZdcRZ
         m4vrsmTlWy1bdAyu70rUvXfq/7GqBOf61jVfLd3wsd+b8A+Wfrbj18dnl8slpV268XN7
         KprkkPcc+QRurpYYTV3ecrMQlGjoFWfs5Fk3SX+DRQwqW3d4CUUkHwSCwE+tuN3eXOVk
         NF3+BfTJt2R2yBh3NVJ3knbcNeIoqjdDdd4qcM1Q5aEnNtD/XFHRN7T6vt+6EAvJE/1H
         k+AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XAbsx4z61PDmKxVrG+hWql1tanJuLJy0FXV+SbeVNSE=;
        b=vho8DLw7XCzCuWT0TqQF7dOSpozXkYS1X/lfcfjVbe6+SH3AclEbFj1nat8MhaXp1M
         Kxs3cemQ51cTPT2+JQECn8OQSVpIqMUoi/NeO14SFoG9Q3t8eMyo/sWZajHK6nENimq6
         LCXYlFncYpTehzjjDj0jTB4HbMZe7meNMYNyDndSyA0Pu+p/8meyf/vbGqQAbDXuxw41
         k+2YvcsJvJj6J8lfZThXVxW6xqWnS7XFC85RK0/ZSELuDZUI4Rb8ppg5SRPKeH9rmhGy
         x1QOB88VdC6Lbhv/lqhV5qUuxIu6whAB6nin9XfCPgZ8b1Q4Z3oNAtblsdEr6LFj5eh4
         zqXw==
X-Gm-Message-State: AJIora9FSyVqEPfuLT898ITq7RycVLdlaGo670i5AGYcU4VR/UvFE/0C
        sklyht685FGOVjouuDfT6fXVvg==
X-Google-Smtp-Source: AGRyM1t1b8tjCTGsXmfFwxPrKRYVz+vLBtMewzagJZyz+HIiUE8b0Jq9QUpdHQd4dl7IWbKIm0soVw==
X-Received: by 2002:a65:6e41:0:b0:412:4c1f:9936 with SMTP id be1-20020a656e41000000b004124c1f9936mr37332444pgb.455.1658376324638;
        Wed, 20 Jul 2022 21:05:24 -0700 (PDT)
Received: from C02CV1DAMD6P.bytedance.net ([139.177.225.228])
        by smtp.gmail.com with ESMTPSA id f4-20020a170902684400b0016bdf0032b9sm384368pln.110.2022.07.20.21.05.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 21:05:24 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     hannes@cmpxchg.org, surenb@google.com, mingo@redhat.com,
        peterz@infradead.org, tj@kernel.org, corbet@lwn.net,
        akpm@linux-foundation.org, rdunlap@infradead.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        songmuchun@bytedance.com, cgroups@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH 6/9] sched/psi: save percpu memory when !psi_cgroups_enabled
Date:   Thu, 21 Jul 2022 12:04:36 +0800
Message-Id: <20220721040439.2651-7-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220721040439.2651-1-zhouchengming@bytedance.com>
References: <20220721040439.2651-1-zhouchengming@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We won't use cgroup psi_group when !psi_cgroups_enabled, so don't
bother to alloc percpu memory and init for it.

Also don't need to migrate task PSI stats between cgroups in
cgroup_move_task().

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 kernel/sched/psi.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 6ba159fe2a4f..aa40bf888102 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -205,6 +205,7 @@ void __init psi_init(void)
 {
 	if (!psi_enable) {
 		static_branch_enable(&psi_disabled);
+		static_branch_disable(&psi_cgroups_enabled);
 		return;
 	}
 
@@ -952,7 +953,7 @@ void psi_memstall_leave(unsigned long *flags)
 #ifdef CONFIG_CGROUPS
 int psi_cgroup_alloc(struct cgroup *cgroup)
 {
-	if (static_branch_likely(&psi_disabled))
+	if (!static_branch_likely(&psi_cgroups_enabled))
 		return 0;
 
 	cgroup->psi.pcpu = alloc_percpu(struct psi_group_cpu);
@@ -964,7 +965,7 @@ int psi_cgroup_alloc(struct cgroup *cgroup)
 
 void psi_cgroup_free(struct cgroup *cgroup)
 {
-	if (static_branch_likely(&psi_disabled))
+	if (!static_branch_likely(&psi_cgroups_enabled))
 		return;
 
 	cancel_delayed_work_sync(&cgroup->psi.avgs_work);
@@ -991,7 +992,7 @@ void cgroup_move_task(struct task_struct *task, struct css_set *to)
 	struct rq_flags rf;
 	struct rq *rq;
 
-	if (static_branch_likely(&psi_disabled)) {
+	if (!static_branch_likely(&psi_cgroups_enabled)) {
 		/*
 		 * Lame to do this here, but the scheduler cannot be locked
 		 * from the outside, so we move cgroups from inside sched/.
-- 
2.36.1

