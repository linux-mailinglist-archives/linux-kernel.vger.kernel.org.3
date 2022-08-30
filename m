Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C03E65A58F0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 03:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbiH3BoP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 21:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbiH3BoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 21:44:12 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76CD47C305
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 18:44:11 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id f12so9505914plb.11
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 18:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=kOzfBRq5yYox21NuVDXabEwbFujCa1I2u3nF6XVE7w8=;
        b=pALGE31EpvVdTowSCgZZehs0ki4m1NmuCM1sr1es6ml8MaL/52724cy15yzQP5whVd
         68iSA+kCAF7QSWQ8LXV+4CzxQqrURBMQenvhYTGAM/j50cvmQNQ95O8FsnDsCJQWUUZS
         7P2P8i2loOMvXPBVzMF74+5w+460YR5fCMLiv0XbwLl3HCPQH0Chk3kpoEcFDYiCgZx0
         cza7/UTXI3BO++IJY5iQ23tjCRotz1pY96OVtp+OjRZah694J+9f+oGtKCZNz1YOQlJW
         kd/vsmHxHbKU1nyf+tHWvvmDX7xPvEqhbDPGafupJVsrUAvmMQvBUkTDo3mqPE9OXOyE
         kzyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=kOzfBRq5yYox21NuVDXabEwbFujCa1I2u3nF6XVE7w8=;
        b=T2B/r9Zs5go9iSD2qEyCRHfExXRBdSZ8a6inyVgKYIMaUwcoZsbfSmS+FdbWFAoiEX
         V6a5yiAlwXE7pmZO4QWrodKnMhIJzajx7Rjj6D2tqHHA1zRBtqJ1JKbSEWXp/rUjk4zX
         /zJWXiH8WdoSxOM5hcsWHCvepVN67BSoFxS0+cBjVl76nazt9YCR9bOEsIyGtDdU08f+
         XRz1/Ex2eyWuppqclsyAsJ1jFhr9PVvv6FI+JlifR19vuc2di5tUCDJKUnB4xTE8T7Fq
         HONz5cfCNsJqnbi1Xj8Ko4r+aQzCr0BO8WT4kzDnZGHZUjFuAYA+Pd7CLpUCyklnS82K
         +mPQ==
X-Gm-Message-State: ACgBeo22Qz3RoHZkhbDVC2b4JH6UliItxQ9BegEMRVh2+CfqwmyDOxIL
        l6eDiT5eH1RjWNh/uOrwQOPDkCEte58=
X-Google-Smtp-Source: AA6agR7QiP0eFqOebRee1dD781w80C77xiKWy9iQB4xkY+dihUOKld3Mgvzh8S9FY+JhrkhghWbuVg==
X-Received: by 2002:a17:90a:cb14:b0:1fd:c964:f708 with SMTP id z20-20020a17090acb1400b001fdc964f708mr8311210pjt.62.1661823849855;
        Mon, 29 Aug 2022 18:44:09 -0700 (PDT)
Received: from laptop.hsd1.wa.comcast.net ([2601:600:8500:5f14:d627:c51e:516e:a105])
        by smtp.gmail.com with ESMTPSA id v14-20020aa799ce000000b00535faa9d6f2sm7976038pfi.53.2022.08.29.18.44.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 18:44:09 -0700 (PDT)
From:   Andrei Vagin <avagin@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andrei Vagin <avagin@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Christian Brauner <brauner@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Oskolkov <posk@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tycho Andersen <tycho@tycho.pizza>,
        Will Drewry <wad@chromium.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 4/4] seccomp: add the synchronous mode for seccomp_unotify
Date:   Mon, 29 Aug 2022 18:43:56 -0700
Message-Id: <20220830014356.5364-5-avagin@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220830014356.5364-1-avagin@gmail.com>
References: <20220830014356.5364-1-avagin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

seccomp_unotify allows more privileged processes does actions on behalf
of less privileged processes.

In many cases, the workflow is fully synchronous. It means a target
process triggers a system call and passes controls to a supervisor
process that handles the system call and returns controls to the target
process. In this context, "synchronous" means that only one process is
running and another one is waiting.

There is the WF_CURRENT_CPU flag that is used to advise the scheduler to
move the wakee to the current CPU. For such synchronous workflows, it
makes context switches a few times faster.

Right now, each interaction takes 12µs. With this patch, it takes about
3µs.

This change introduce the SECCOMP_USER_NOTIF_FD_SYNC_WAKE_UP flag that
it used to enable the sync mode.

Signed-off-by: Andrei Vagin <avagin@gmail.com>
---
 include/uapi/linux/seccomp.h |  4 ++++
 kernel/seccomp.c             | 35 +++++++++++++++++++++++++++++++++--
 2 files changed, 37 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/seccomp.h b/include/uapi/linux/seccomp.h
index 0fdc6ef02b94..dbfc9b37fcae 100644
--- a/include/uapi/linux/seccomp.h
+++ b/include/uapi/linux/seccomp.h
@@ -115,6 +115,8 @@ struct seccomp_notif_resp {
 	__u32 flags;
 };
 
+#define SECCOMP_USER_NOTIF_FD_SYNC_WAKE_UP (1UL << 0)
+
 /* valid flags for seccomp_notif_addfd */
 #define SECCOMP_ADDFD_FLAG_SETFD	(1UL << 0) /* Specify remote fd */
 #define SECCOMP_ADDFD_FLAG_SEND		(1UL << 1) /* Addfd and return it, atomically */
@@ -150,4 +152,6 @@ struct seccomp_notif_addfd {
 #define SECCOMP_IOCTL_NOTIF_ADDFD	SECCOMP_IOW(3, \
 						struct seccomp_notif_addfd)
 
+#define SECCOMP_IOCTL_NOTIF_SET_FLAGS	SECCOMP_IOW(4, __u64)
+
 #endif /* _UAPI_LINUX_SECCOMP_H */
diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index 667fd2d89464..c24900eb8ced 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -143,11 +143,14 @@ struct seccomp_kaddfd {
  *           filter->notify_lock.
  * @next_id: The id of the next request.
  * @notifications: A list of struct seccomp_knotif elements.
+ * @flags: A set of SECCOMP_USER_NOTIF_FD_* flags.
  */
+
 struct notification {
 	atomic_t requests;
 	u64 next_id;
 	struct list_head notifications;
+	int flags;
 };
 
 #ifdef SECCOMP_ARCH_NATIVE
@@ -1117,7 +1120,10 @@ static int seccomp_do_user_notification(int this_syscall,
 	INIT_LIST_HEAD(&n.addfd);
 
 	atomic_add(1, &match->notif->requests);
-	wake_up_poll(&match->wqh, EPOLLIN | EPOLLRDNORM);
+	if (match->notif->flags & SECCOMP_USER_NOTIF_FD_SYNC_WAKE_UP)
+		wake_up_poll_on_current_cpu(&match->wqh, EPOLLIN | EPOLLRDNORM);
+	else
+		wake_up_poll(&match->wqh, EPOLLIN | EPOLLRDNORM);
 
 	/*
 	 * This is where we wait for a reply from userspace.
@@ -1574,7 +1580,10 @@ static long seccomp_notify_send(struct seccomp_filter *filter,
 	knotif->error = resp.error;
 	knotif->val = resp.val;
 	knotif->flags = resp.flags;
-	complete(&knotif->ready);
+	if (filter->notif->flags & SECCOMP_USER_NOTIF_FD_SYNC_WAKE_UP)
+		complete_on_current_cpu(&knotif->ready);
+	else
+		complete(&knotif->ready);
 out:
 	mutex_unlock(&filter->notify_lock);
 	return ret;
@@ -1604,6 +1613,26 @@ static long seccomp_notify_id_valid(struct seccomp_filter *filter,
 	return ret;
 }
 
+static long seccomp_notify_set_flags(struct seccomp_filter *filter,
+				    void __user *buf)
+{
+	u64 flags;
+	long ret;
+
+	if (copy_from_user(&flags, buf, sizeof(flags)))
+		return -EFAULT;
+
+	if (flags & ~SECCOMP_USER_NOTIF_FD_SYNC_WAKE_UP)
+		return -EINVAL;
+
+	ret = mutex_lock_interruptible(&filter->notify_lock);
+	if (ret < 0)
+		return ret;
+	filter->notif->flags = flags;
+	mutex_unlock(&filter->notify_lock);
+	return ret;
+}
+
 static long seccomp_notify_addfd(struct seccomp_filter *filter,
 				 struct seccomp_notif_addfd __user *uaddfd,
 				 unsigned int size)
@@ -1733,6 +1762,8 @@ static long seccomp_notify_ioctl(struct file *file, unsigned int cmd,
 	case SECCOMP_IOCTL_NOTIF_ID_VALID_WRONG_DIR:
 	case SECCOMP_IOCTL_NOTIF_ID_VALID:
 		return seccomp_notify_id_valid(filter, buf);
+	case SECCOMP_IOCTL_NOTIF_SET_FLAGS:
+		return seccomp_notify_set_flags(filter, buf);
 	}
 
 	/* Extensible Argument ioctls */
-- 
2.37.2

