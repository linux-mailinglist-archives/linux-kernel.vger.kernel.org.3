Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97778473730
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 23:04:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243211AbhLMWEK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 17:04:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237196AbhLMWEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 17:04:09 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 609D1C061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 14:04:09 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id t184-20020a2546c1000000b006008b13c80bso32975274yba.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 14:04:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to;
        bh=vPUizE+pHXS+jDaiWEOrq3f78poFiz2E/gTDlblt2Xs=;
        b=cnDaFIPUp7Z9nfqJDzUdyNkSfWkL6b+d9+Ci73/XOs1oG6yxuC6B4/Vf+I/yAFwcfe
         DtylpwWq8aRZEuGY558+dUsSS+Oqy4AOsmV6NLwk5RyVrucdrlcDGlb4MszrL5de7lR1
         MqFdiSrSb3mdwhngGdUuCy6YvHcOTf6x7I4/DjSWonhDsS4Duik0xgk6moSeolV3V412
         XLp6TqSTYsoBGevn1KnP0HxyqTAgCtWkJKgX+yjERnDh27nhvwpQv4cjie4nB7DnHLmT
         eI60L+nRbFN3plnNjYvDkZRe9mrslxwH4PQo7qGjHRXTlDD2mPZb1FHaeP/31Y/HcIHf
         urEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to;
        bh=vPUizE+pHXS+jDaiWEOrq3f78poFiz2E/gTDlblt2Xs=;
        b=wtxpHUSvjmJFKCkoaFJPGLV+essVMUGGMIT3AF+oxY0tOni9n05ltY5Ss66VU0JaX1
         r6baPmHDS3Y+SfW+I2++7Z8+WsJFJvg2rVx4YJDr6QkBC4MzFTgCpQi/uJO1f/XGSksp
         W3htyaU6a8FfYGf7o1ZLvrr4WygurFBD8gIyuWDshtGWGkkSGeZSwa3W/fHRyzn7RVx7
         BHEcPHtfDU//IMX9AMvmfWYqgHd1mzaf1N8LHnJhWaGySngejuuNz4KyWIvtMLFwE9dl
         /KiY0LeQKuP7uIIVijtbBg0EKqfCRF6rLXv9lTQWv08KupEw5sY3ojAXwDc70egiuEgY
         qKsw==
X-Gm-Message-State: AOAM532OsYKrY41jiF4hnVhFZ/pGHef+O5Ga33k0gcqw9UI2VGDLH2L6
        +g7c1OGax2zAA32DA4oANNdLdzvf
X-Google-Smtp-Source: ABdhPJza09MgbMQa8HF5koDtQ5f4n/AFQZ39gAA+LwBUrx/jaVvBW9dJDf5BS1LljokHs55Q3pJ0gAnc
X-Received: from gnomeregan.cam.corp.google.com ([2620:15c:6:412:1712:4a63:4cd1:9a15])
 (user=brho job=sendgmr) by 2002:a25:8205:: with SMTP id q5mr1462960ybk.256.1639433048480;
 Mon, 13 Dec 2021 14:04:08 -0800 (PST)
Date:   Mon, 13 Dec 2021 17:04:01 -0500
Message-Id: <20211213220401.1039578-1-brho@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH] rlimits: do not grab tasklist_lock for do_prlimit on current
From:   Barret Rhoden <brho@google.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
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

The tasklist_lock can be a scalability bottleneck.  For current tasks,
we don't need the tasklist_lock to protect tsk->sighand or tsk->signal.
If non-current callers become a bottleneck, we could use
lock_task_sighand().

Signed-off-by: Barret Rhoden <brho@google.com>
---
 kernel/sys.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/sys.c b/kernel/sys.c
index 8fdac0d90504..e56d1ae910af 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -1576,7 +1576,8 @@ int do_prlimit(struct task_struct *tsk, unsigned int resource,
 	}
 
 	/* protect tsk->signal and tsk->sighand from disappearing */
-	read_lock(&tasklist_lock);
+	if (tsk != current)
+		read_lock(&tasklist_lock);
 	if (!tsk->sighand) {
 		retval = -ESRCH;
 		goto out;
@@ -1611,7 +1612,8 @@ int do_prlimit(struct task_struct *tsk, unsigned int resource,
 	     IS_ENABLED(CONFIG_POSIX_TIMERS))
 		update_rlimit_cpu(tsk, new_rlim->rlim_cur);
 out:
-	read_unlock(&tasklist_lock);
+	if (tsk != current)
+		read_unlock(&tasklist_lock);
 	return retval;
 }
 
-- 
2.34.1.173.g76aa8bc2d0-goog

