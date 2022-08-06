Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D952858B54F
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 14:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbiHFMFs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 08:05:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231371AbiHFMFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 08:05:41 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1625ECE18
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 05:05:39 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id c19-20020a17090ae11300b001f2f94ed5c6so9147914pjz.1
        for <linux-kernel@vger.kernel.org>; Sat, 06 Aug 2022 05:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=GsJOX3el/XhuSXmXplhhUR42pn8/C3PI7wN0KJVkot0=;
        b=LGUTxVJQlRarj13waUI3GmEJRxpGMGPhMio6/XdhT2iORKsFt6tN4vHFB2wIQixoy0
         LqvXRyqCg3z78+Cc9SBJ3X10EC2WYllRXA5ReQWNtPMEIIoiFGgs9EAmnClbm+DfNEXc
         fnvjO1OS552q3Bq26C1G+UXslEdJ3A4GoHwIaoHQxc+SnohAMq0Dlhtmmjgmx4bna4kx
         5uyGSezHYXuOhIS4x9BaEN/8Ap8l4UrsnSlt67Yiazh6AllsyKMHgJMA1WFIO7CAw8oM
         7/dsGVXLDJa3CZ3ivFdISoO65Smn4lvHosewG/8AETQfbGSLvIk35OuKS/Zcdp+PjHUa
         ztfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=GsJOX3el/XhuSXmXplhhUR42pn8/C3PI7wN0KJVkot0=;
        b=mB/Qf6wzhlXgzj1JiyxYzH/dGpwEjsJ4SsTcwsJtvytGPpEFQhHvD7AxjV6EVaYh4E
         cvxFuuyq6c/xpYy9sW2UDjGwBqxVogt9KNk2o7Uy20yrxhhY4kJydQ96fFyTW48WRSQt
         fnDtF+5lt/FQQWRPiw/3p+7IOhrh+xunFZa7XFYNmtXMOig+ljoVgjqFANrKr1lqTLy9
         WwpWq/5ZicaUoKoatgIwpxetb/7zqtIO1KQC1pqjym6Kg2/ltfVhglf//YrV1ZkWZgm8
         JDLCQ6IEs8PLmAfOFdxxyzRK6UJ8bXalJ117CtOWmtZe4BFvc1XcCw4HCaSTeH5T7nar
         BFsg==
X-Gm-Message-State: ACgBeo0trcQkAqjDNtpV6bQc6heU+6gzJHrXIcx1gE18gUjciqvhPAVr
        N1ip253aCYRU7YgvZSnf/SGsmQ==
X-Google-Smtp-Source: AA6agR790V4JLywz5U7qHZcN3TfYTFPpJLwuJj0NajxYcBjrn58ILNMtWwXbOKd64FKVC51r4TEkfQ==
X-Received: by 2002:a17:90b:4a8a:b0:1f5:d9a:ac3e with SMTP id lp10-20020a17090b4a8a00b001f50d9aac3emr12067176pjb.241.1659787539385;
        Sat, 06 Aug 2022 05:05:39 -0700 (PDT)
Received: from C02G87K0MD6R.bytedance.net ([139.177.225.228])
        by smtp.gmail.com with ESMTPSA id t4-20020a63eb04000000b003db7de758besm3035003pgh.5.2022.08.06.05.05.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Aug 2022 05:05:38 -0700 (PDT)
From:   Hao Jia <jiahao.os@bytedance.com>
To:     mingo@redhat.com, peterz@infradead.org, mingo@kernel.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org, Hao Jia <jiahao.os@bytedance.com>
Subject: [PATCH 2/3] sched/psi: Remove unused parameter nbytes of psi_trigger_create()
Date:   Sat,  6 Aug 2022 20:05:09 +0800
Message-Id: <20220806120510.96131-3-jiahao.os@bytedance.com>
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

psi_trigger_create()'s 'nbytes' parameter is not used, so we can remove it.

Signed-off-by: Hao Jia <jiahao.os@bytedance.com>
---
 include/linux/psi.h    | 2 +-
 kernel/cgroup/cgroup.c | 2 +-
 kernel/sched/psi.c     | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/psi.h b/include/linux/psi.h
index 89784763d19e..dd74411ac21d 100644
--- a/include/linux/psi.h
+++ b/include/linux/psi.h
@@ -27,7 +27,7 @@ void psi_memstall_leave(unsigned long *flags);
 
 int psi_show(struct seq_file *s, struct psi_group *group, enum psi_res res);
 struct psi_trigger *psi_trigger_create(struct psi_group *group,
-			char *buf, size_t nbytes, enum psi_res res);
+			char *buf, enum psi_res res);
 void psi_trigger_destroy(struct psi_trigger *t);
 
 __poll_t psi_trigger_poll(void **trigger_ptr, struct file *file,
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index ffaccd6373f1..df7df5843b4f 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -3698,7 +3698,7 @@ static ssize_t cgroup_pressure_write(struct kernfs_open_file *of, char *buf,
 	}
 
 	psi = cgroup_ino(cgrp) == 1 ? &psi_system : cgrp->psi;
-	new = psi_trigger_create(psi, buf, nbytes, res);
+	new = psi_trigger_create(psi, buf, res);
 	if (IS_ERR(new)) {
 		cgroup_put(cgrp);
 		return PTR_ERR(new);
diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 5ee615a59fe1..ecb4b4ff4ce0 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -1087,7 +1087,7 @@ int psi_show(struct seq_file *m, struct psi_group *group, enum psi_res res)
 }
 
 struct psi_trigger *psi_trigger_create(struct psi_group *group,
-			char *buf, size_t nbytes, enum psi_res res)
+			char *buf, enum psi_res res)
 {
 	struct psi_trigger *t;
 	enum psi_states state;
@@ -1316,7 +1316,7 @@ static ssize_t psi_write(struct file *file, const char __user *user_buf,
 		return -EBUSY;
 	}
 
-	new = psi_trigger_create(&psi_system, buf, nbytes, res);
+	new = psi_trigger_create(&psi_system, buf, res);
 	if (IS_ERR(new)) {
 		mutex_unlock(&seq->lock);
 		return PTR_ERR(new);
-- 
2.32.0

