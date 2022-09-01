Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6CED5AA2C3
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 00:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235191AbiIAWTZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 18:19:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234779AbiIAWST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 18:18:19 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 723995809E
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 15:18:08 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id cb8so281045qtb.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 15:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=3vWNR1lOZ3nlNpU4UUmxfmJYajX79MfO1ObVeBbomlg=;
        b=W9V/oqA+OZMtsddIG83NBCyyox5x44+ormS/AjYTPNmA6tq1LLUSu1mTv373zuQAmL
         stXAk/bY0nw2tv3MorrBWKQVz0OdcObvezxEjnW0fZHXmStt0csE5tLilyFNZXZtzQ7e
         hZ35XQl1bl0u/iHRILvxndSITlzXxbNnrQw8k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=3vWNR1lOZ3nlNpU4UUmxfmJYajX79MfO1ObVeBbomlg=;
        b=YSwBhQGXsFr3c7HzdnDCs3XvM9v18yOP9pVDjSaewIhoroEHKWjRd6tSCHTUVhfF9M
         WYCwNGPA4Qfulx5tY2jvztWREoWyQyGo3pyk1MsAYX27YO0dhu0VSi7kebZLf+WTFVD/
         fHz9J/VpNkNDxYiR1aYGP62Y2BRYYMz6T3VqlYFAwZ6IiVI6kBPcf4xooYCnANVUJL8M
         r5aHTlq3iAEUtUVW5LY7eX5uGSL8j4fg0a3pZ8WENoK1RgD/tXCex1ThtZelNYYOE6IV
         b+zZKukM7Kg0E9rabWvq419W6f0q13vfPop8unNhoIZOGFRo5x2SAH2U4jtJjaWH91MP
         oDpA==
X-Gm-Message-State: ACgBeo3poCL+QVpdhqj/dLPaGtkgU1Qf32e1JcNf1pDoyh0FqYaoNDEC
        HXAAMc/BNoCcqvXh5nIvfljFyA==
X-Google-Smtp-Source: AA6agR7Md6xYqwWArMXYWwgIpGr8i6bhrZ317pWwHfXCZUjbF4/68mUbJbpxMEPOI/zS/oZi2CAc+g==
X-Received: by 2002:ac8:5786:0:b0:343:3051:170d with SMTP id v6-20020ac85786000000b003433051170dmr25646460qta.429.1662070688111;
        Thu, 01 Sep 2022 15:18:08 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id s16-20020ac85290000000b0034305a91aaesm11060794qtn.83.2022.09.01.15.18.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 15:18:07 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, rushikesh.s.kadam@intel.com,
        urezki@gmail.com, neeraj.iitr10@gmail.com, frederic@kernel.org,
        paulmck@kernel.org, rostedt@goodmis.org, vineeth@bitbyteword.org,
        boqun.feng@gmail.com,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [PATCH v5 15/18] kernel: Move various core kernel usages to call_rcu_lazy()
Date:   Thu,  1 Sep 2022 22:17:17 +0000
Message-Id: <20220901221720.1105021-16-joel@joelfernandes.org>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
In-Reply-To: <20220901221720.1105021-1-joel@joelfernandes.org>
References: <20220901221720.1105021-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/exit.c              | 2 +-
 kernel/pid.c               | 2 +-
 kernel/time/posix-timers.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/exit.c b/kernel/exit.c
index 84021b24f79e..b2a96356980a 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -180,7 +180,7 @@ static void delayed_put_task_struct(struct rcu_head *rhp)
 void put_task_struct_rcu_user(struct task_struct *task)
 {
 	if (refcount_dec_and_test(&task->rcu_users))
-		call_rcu(&task->rcu, delayed_put_task_struct);
+		call_rcu_lazy(&task->rcu, delayed_put_task_struct);
 }
 
 void release_task(struct task_struct *p)
diff --git a/kernel/pid.c b/kernel/pid.c
index 2fc0a16ec77b..5a5144519d70 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -153,7 +153,7 @@ void free_pid(struct pid *pid)
 	}
 	spin_unlock_irqrestore(&pidmap_lock, flags);
 
-	call_rcu(&pid->rcu, delayed_put_pid);
+	call_rcu_lazy(&pid->rcu, delayed_put_pid);
 }
 
 struct pid *alloc_pid(struct pid_namespace *ns, pid_t *set_tid,
diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index 5dead89308b7..660daa427b41 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -485,7 +485,7 @@ static void release_posix_timer(struct k_itimer *tmr, int it_id_set)
 	}
 	put_pid(tmr->it_pid);
 	sigqueue_free(tmr->sigq);
-	call_rcu(&tmr->rcu, k_itimer_rcu_free);
+	call_rcu_lazy(&tmr->rcu, k_itimer_rcu_free);
 }
 
 static int common_timer_create(struct k_itimer *new_timer)
-- 
2.37.2.789.g6183377224-goog

