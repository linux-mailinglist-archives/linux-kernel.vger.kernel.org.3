Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2F0F486851
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 18:21:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241710AbiAFRVA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 12:21:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241666AbiAFRUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 12:20:55 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 612D3C061201
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 09:20:55 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id s83-20020a255e56000000b0060c46cc1890so6074767ybb.16
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jan 2022 09:20:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=OXcWrdqzZ/LJa8MsNyqLit5QE2f2wr1XJUDpKBKFn9M=;
        b=kZSdwWIqyPhTSuB53f4VjBfc7Xb76bIC+Is8zxCJcb0bKgm4qXs/pPlLVkozbH0ki+
         YBw/3CbGAfccFjdVnf8cw73rjHtSrXxQFTfF4SMLVgx1u48S4NugDxA2PhtuVmcF4oxB
         S4CJuGgLhtf9zUe44UG//df3smOzAkYjUzh+Z9HFDwUEsdooMHcwLn2BXs13YVHOgXwb
         ocmHFXMGmcXvWinYOJ/okP0BPWAFmfhHU1T4qsqYLozuDfm339uaOPALhg3MU/56ZDGc
         jYFERPu11DuNLCvhx/juf+UYXsO95GlKf0GdLNT82XSYO/5qbVttkUOnz4YFdpWRRgsv
         Z1DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=OXcWrdqzZ/LJa8MsNyqLit5QE2f2wr1XJUDpKBKFn9M=;
        b=yLqVO+D9s+jmm6xz2N9qh+zSHh4d1IHo9D9e0M+82fjhoZDQ6ILgJ9EEPZ7bUx4b6j
         g5/pfwNMsk0oYegO7RFzrOPqDi7FwZNQitzJshicGhPMxNIw1ra7xSNvO411ME3M+ilQ
         aUZlg2vqwJjT1p8AOUFAIBYCpc61OqFNHqtZQkoFGaBTJwB4hnD+2sdtBoS5Ku4NVV2Q
         3dJj7VO+Ic7xOQMQww6zoBE3bxFffaXI3gghLh/cVmNJQIzbwuCJTV6g0DhBLYO83D8F
         WZ88+9uwv2dJ19lofx3D4Q8z8m5Rr+lkI9T5+W+5MJg1d7HErb8Fz0mluAPzuS3F3DfD
         WxiA==
X-Gm-Message-State: AOAM533BjOfhFlbeBYDwRSI7/nTfUjLiBVZbW45Tx6a9aVXJp0w7FMgg
        G4vvx+yvJ8gWaxyKgsM4+02eTBlf
X-Google-Smtp-Source: ABdhPJwoMQLAddFJICdKDWy+ImRQXv8fmsh4pVwQzqlsIgtdlFR7aiM6B3T7Hs9Q3Ig032HhLHTaQzcg
X-Received: from gnomeregan.cam.corp.google.com ([2620:15c:6:412:f130:19b6:8678:c9d1])
 (user=brho job=sendgmr) by 2002:a25:c245:: with SMTP id s66mr32796965ybf.243.1641489654639;
 Thu, 06 Jan 2022 09:20:54 -0800 (PST)
Date:   Thu,  6 Jan 2022 12:20:39 -0500
In-Reply-To: <20220106172041.522167-1-brho@google.com>
Message-Id: <20220106172041.522167-2-brho@google.com>
Mime-Version: 1.0
References: <20220106172041.522167-1-brho@google.com>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
Subject: [PATCH v3 1/3] setpriority: only grab the tasklist_lock for PRIO_PGRP
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

