Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CA9B58B54E
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 14:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbiHFMFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 08:05:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbiHFMFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 08:05:34 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB513BC2F
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 05:05:32 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id r22so2321350pgm.5
        for <linux-kernel@vger.kernel.org>; Sat, 06 Aug 2022 05:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=YOlS/iS0J/nVVMYG59d7cm+gvfjMBzPJ2apUEsXMO+g=;
        b=qfSdy6v02mjjdS8Q0pT4G9yvbvrNWq2FGR06bdigqXC5PRhi6ELcVQ6S1SnTjj0pAy
         Ka0oHnEZ3uBkv0zaaz0Yr8xzty+mB9YTCxOsYtP2dyLvmayWwo1r/y9fQi6cr+mFak0c
         5/ulIenQioWkccproU3qQN/y3kmPa5xFAjaYHWZ75H2GoQ0bkxiSCjiJ+Dum+zo/AkTo
         RzxPN+haSDPzfGKk3vb5eBc59TaGVz22u9iRv//EH3EmyXqh0yJQYv33lp8YwqsPQ12X
         rQcFX1leHWO9CHu2uKm3Nxu3Hb5tSwKRqXeIvTYYhJwIgvknuPG1kvofz1u+QpwuTgXV
         45XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=YOlS/iS0J/nVVMYG59d7cm+gvfjMBzPJ2apUEsXMO+g=;
        b=vb/qfa4Uv8qDpQ3480v8FuXCJnW951m5kGBtWo/VQ/yziYvYGFcemPl6tkSwPiBZAq
         I1ZxFdBzn8TzEo0VB5AIjVRdgse4UqkxcEZKae4RZK1Xq1HhwlBWdFIQ1UldcQDijxTj
         6IgnjQ+nA+eVBvLBHIddd3M95qCCYMwfSOjjblZeWIl6XGebdto6z4IOE5j7hDE9THZl
         5uG4lE402hGikuANS7jfOWYx3DorU9B9s5TYAiyCIVDQWEf4TVPVUuI8iJ/AtU5Q2XwL
         30w+JsIXD8HgcvTSUCgsiM9sJ+Ql8n15dKRVy6nPSkyv5a4+4Vynif0XNnQCOUqIV3Bc
         Xl9g==
X-Gm-Message-State: ACgBeo1StpBieNjBmwfQXuON1rj1/vwzBnk9uhylJI5pqVwfMcUyVYYf
        XOjIqeyz346uawQ4LmHR0WnrAA==
X-Google-Smtp-Source: AA6agR4Q19KRI9nbznHC8ED3ZwWBdPi2gytzXkoWcJfdWjhH3nz/wh2FttimVj5xAqes0EN4Miur5w==
X-Received: by 2002:a05:6a00:32cb:b0:52e:2756:3558 with SMTP id cl11-20020a056a0032cb00b0052e27563558mr10895099pfb.59.1659787532333;
        Sat, 06 Aug 2022 05:05:32 -0700 (PDT)
Received: from C02G87K0MD6R.bytedance.net ([139.177.225.228])
        by smtp.gmail.com with ESMTPSA id t4-20020a63eb04000000b003db7de758besm3035003pgh.5.2022.08.06.05.05.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Aug 2022 05:05:31 -0700 (PDT)
From:   Hao Jia <jiahao.os@bytedance.com>
To:     mingo@redhat.com, peterz@infradead.org, mingo@kernel.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org, Hao Jia <jiahao.os@bytedance.com>
Subject: [PATCH 1/3] sched/psi: Zero the memory of struct psi_group
Date:   Sat,  6 Aug 2022 20:05:08 +0800
Message-Id: <20220806120510.96131-2-jiahao.os@bytedance.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20220806120510.96131-1-jiahao.os@bytedance.com>
References: <20220806120510.96131-1-jiahao.os@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After commit 5f69a6577bc3 ("psi: dont alloc memory for psi by default"),
the memory used by struct psi_group is no longer allocated and zeroed
in cgroup_create().

Since the memory of struct psi_group is not zeroed, the data in this
memory is random, which will lead to inaccurate psi statistics when
creating a new cgroup.

So we use kzlloc() to allocate and zero the struct psi_group and
remove the redundant zeroing in group_init().

Steps to reproduce:
1. Use cgroup v2 and enable CONFIG_PSI
2. Create a new cgroup, and query psi statistics
mkdir /sys/fs/cgroup/test
cat /sys/fs/cgroup/test/cpu.pressure
some avg10=0.00 avg60=0.00 avg300=47927752200.00 total=12884901
full avg10=561815124.00 avg60=125835394188.00 avg300=1077090462000.00 total=10273561772

cat /sys/fs/cgroup/test/io.pressure
some avg10=1040093132823.95 avg60=1203770351379.21 avg300=3862252669559.46 total=4294967296
full avg10=921884564601.39 avg60=0.00 avg300=1984507298.35 total=442381631

cat /sys/fs/cgroup/test/memory.pressure
some avg10=232476085778.11 avg60=0.00 avg300=0.00 total=0
full avg10=0.00 avg60=0.00 avg300=2585658472280.57 total=12884901

Fixes: commit 5f69a6577bc3 ("psi: dont alloc memory for psi by default")

Signed-off-by: Hao Jia <jiahao.os@bytedance.com>
---
 kernel/sched/psi.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index ec66b40bdd40..5ee615a59fe1 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -190,12 +190,8 @@ static void group_init(struct psi_group *group)
 	/* Init trigger-related members */
 	mutex_init(&group->trigger_lock);
 	INIT_LIST_HEAD(&group->triggers);
-	memset(group->nr_triggers, 0, sizeof(group->nr_triggers));
-	group->poll_states = 0;
 	group->poll_min_period = U32_MAX;
-	memset(group->polling_total, 0, sizeof(group->polling_total));
 	group->polling_next_update = ULLONG_MAX;
-	group->polling_until = 0;
 	init_waitqueue_head(&group->poll_wait);
 	timer_setup(&group->poll_timer, poll_timer_fn, 0);
 	rcu_assign_pointer(group->poll_task, NULL);
@@ -957,7 +953,7 @@ int psi_cgroup_alloc(struct cgroup *cgroup)
 	if (static_branch_likely(&psi_disabled))
 		return 0;
 
-	cgroup->psi = kmalloc(sizeof(struct psi_group), GFP_KERNEL);
+	cgroup->psi = kzalloc(sizeof(struct psi_group), GFP_KERNEL);
 	if (!cgroup->psi)
 		return -ENOMEM;
 
-- 
2.32.0

