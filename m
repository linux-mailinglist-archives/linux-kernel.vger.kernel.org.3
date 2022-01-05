Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36FD3485AA2
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 22:31:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244453AbiAEVbe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 16:31:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244426AbiAEVb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 16:31:29 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B569FC061201
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 13:31:29 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id e137-20020a25378f000000b0060c1f2f4939so1232442yba.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jan 2022 13:31:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=OXcWrdqzZ/LJa8MsNyqLit5QE2f2wr1XJUDpKBKFn9M=;
        b=k3hEATgcFTjuowvt9G4NvFYfAZjtw9yYqDQ5sEX9rEwss6AjrhomFWXG4FZYaewvrx
         4V64TcMjowwztsnK0+hSjXm+0uKlEhkSCoowr50//xgN7o3g1CD1qR/EaFf2DTXfvi2j
         h4VF/GsbVO+s/WeCU3YvcaqHIjFUyWsQUDlbndnnJe2ho9S4lSs+sjPo9RNJwlszBhjk
         F2UWvKRdxMSr6t8o/rDdW1DLzncOTkpY6b/UqWftfdp+QgOfDbwW05+3VyPGwL6h1+Aw
         lMEJc2yknlR8baEKk7/lfrYoBQ59g4BdTCgoF5kQ6dNSz/XB9EYH4SHjJxB7woKt+I1d
         zQHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=OXcWrdqzZ/LJa8MsNyqLit5QE2f2wr1XJUDpKBKFn9M=;
        b=SG5FwH95j8wqo7qs3FOGsndGo1zWnxE5+cuijO0k3d0GIgTZCWR76RMvr/U6CM3AKy
         V1a/huORRogL1wEb/lPTgoD368TzZMz+ZDBSEHh1ahG0CusJErQV50wuZQjc/nt7e28V
         FHwNdE8iOhSeaGsqtxk0UNfOz5+Vj0kv+db/HPfwNf68gr4DFpDvkepSDACMm9MQJqZQ
         FnfjzJ7Cyc7s75N0LUTrl0I9QpDBjjtnbD9/glVjEfFZ94FbUvxhHG2g74RLHd6O4OZK
         cyoY2bRiNR7HHQCKYX4HtOPW8oDIPTxUx1WP0E/EgHS8qDib4WxBeGd/wkJtHDOVxjAk
         8sgg==
X-Gm-Message-State: AOAM531YUYu32vtDHFM7DD0InHhv93Zg9+r65x2hVSJZR0o1qdLeWhd7
        D8gj3gLE6vO1+IeLXGggvnXCTS1g
X-Google-Smtp-Source: ABdhPJwk8/Y5JYC+V7mDVIU826YiSllixU9D0FiG854iq5FSVYplFs8FDFRg3eOicPrSA9zsN2U/nnuU
X-Received: from gnomeregan.cam.corp.google.com ([2620:15c:6:412:3ab7:a23:e07a:5e22])
 (user=brho job=sendgmr) by 2002:a25:40d7:: with SMTP id n206mr55266535yba.466.1641418289003;
 Wed, 05 Jan 2022 13:31:29 -0800 (PST)
Date:   Wed,  5 Jan 2022 16:28:26 -0500
In-Reply-To: <20220105212828.197013-1-brho@google.com>
Message-Id: <20220105212828.197013-2-brho@google.com>
Mime-Version: 1.0
References: <20220105212828.197013-1-brho@google.com>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
Subject: [PATCH v2 1/3] setpriority: only grab the tasklist_lock for PRIO_PGRP
From:   Barret Rhoden <brho@google.com>
To:     ebiederm@xmission.com
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Gladkov <legion@kernel.org>,
        William Cohen <wcohen@redhat.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Chris Hyser <chris.hyser@oracle.com>,
        Peter Collingbourne <pcc@google.com>,
        Xiaofeng Cao <caoxiaofeng@yulong.com>,
        David Hildenbrand <david@redhat.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The tasklist_lock is necessary only for PRIO_PGRP for both setpriority()
and getpriority().

Unnecessarily grabbing the tasklist_lock can be a scalability bottleneck
for workloads that also must grab the tasklist_lock for waiting,
killing, and cloning.

This change resulted in a 12% speedup on a microbenchmark where parents
kill and wait on their children, and children getpriority, setpriority,
and getrlimit.

Signed-off-by: Barret Rhoden <brho@google.com>
---
 kernel/sys.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/sys.c b/kernel/sys.c
index 8fdac0d90504..558e52fa5bbd 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -220,7 +220,6 @@ SYSCALL_DEFINE3(setpriority, int, which, int, who, int, niceval)
 		niceval = MAX_NICE;
 
 	rcu_read_lock();
-	read_lock(&tasklist_lock);
 	switch (which) {
 	case PRIO_PROCESS:
 		if (who)
@@ -231,6 +230,7 @@ SYSCALL_DEFINE3(setpriority, int, which, int, who, int, niceval)
 			error = set_one_prio(p, niceval, error);
 		break;
 	case PRIO_PGRP:
+		read_lock(&tasklist_lock);
 		if (who)
 			pgrp = find_vpid(who);
 		else
@@ -238,6 +238,7 @@ SYSCALL_DEFINE3(setpriority, int, which, int, who, int, niceval)
 		do_each_pid_thread(pgrp, PIDTYPE_PGID, p) {
 			error = set_one_prio(p, niceval, error);
 		} while_each_pid_thread(pgrp, PIDTYPE_PGID, p);
+		read_unlock(&tasklist_lock);
 		break;
 	case PRIO_USER:
 		uid = make_kuid(cred->user_ns, who);
@@ -258,7 +259,6 @@ SYSCALL_DEFINE3(setpriority, int, which, int, who, int, niceval)
 		break;
 	}
 out_unlock:
-	read_unlock(&tasklist_lock);
 	rcu_read_unlock();
 out:
 	return error;
@@ -283,7 +283,6 @@ SYSCALL_DEFINE2(getpriority, int, which, int, who)
 		return -EINVAL;
 
 	rcu_read_lock();
-	read_lock(&tasklist_lock);
 	switch (which) {
 	case PRIO_PROCESS:
 		if (who)
@@ -297,6 +296,7 @@ SYSCALL_DEFINE2(getpriority, int, which, int, who)
 		}
 		break;
 	case PRIO_PGRP:
+		read_lock(&tasklist_lock);
 		if (who)
 			pgrp = find_vpid(who);
 		else
@@ -306,6 +306,7 @@ SYSCALL_DEFINE2(getpriority, int, which, int, who)
 			if (niceval > retval)
 				retval = niceval;
 		} while_each_pid_thread(pgrp, PIDTYPE_PGID, p);
+		read_unlock(&tasklist_lock);
 		break;
 	case PRIO_USER:
 		uid = make_kuid(cred->user_ns, who);
@@ -329,7 +330,6 @@ SYSCALL_DEFINE2(getpriority, int, which, int, who)
 		break;
 	}
 out_unlock:
-	read_unlock(&tasklist_lock);
 	rcu_read_unlock();
 
 	return retval;
-- 
2.34.1.448.ga2b2bfdf31-goog

