Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07116586D63
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 17:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232199AbiHAPG5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 11:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbiHAPGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 11:06:54 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D2D320F60
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 08:06:52 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id v16-20020a17090abb9000b001f25244c65dso15576214pjr.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 08:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=yKHuCd6BqJprccn8CQQERwKiRbnRX971q1043XiUJEM=;
        b=VnO7gVf0SjxxjpFyEphkRUFAfmsMnIbnvBfNcJVWPgd9hvURu8cWl1WxxjzHp7ITa5
         X5rwwzr6eYO6YsguYYubhwdCjMUhwqHnUtALKx0UnDLCR2O8uT9MPsEe0Vx1umuXH5H6
         vkQaW0rHahpHZ6sIpls1J+IDO1ZQ3gPw8GKgMxlUsr6EwhDgZKl3vLhsJW+Rhn9RSzqu
         Fmoy0QujvkGV8rdXSCDW5QBsDW+IJm0OWJgSf6YTtO+aZYhIatNt+Mxj+7hsnMY1hmnI
         ogUIWT8hjA3KwyqG0+SQajceN++MLw6JlxK6Xy9jmTVrlb/rZcA7BkNSad1qET9zPrf6
         22kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=yKHuCd6BqJprccn8CQQERwKiRbnRX971q1043XiUJEM=;
        b=FzLyuwifZ+egcCQ1F1kL1qjHip9ZVtKeJnWqDarsTRqir9p+iRCHyZTkbG9i2yjnnX
         UVTKCpwceEmuWLpeoZNzXjSuCo0OsgYYg0+ZWxwlapBV4pNOpNtvoy0FjI78ZZl5p2sp
         3YcA3CK61MUzGqnQWq6pRwUJkJHd024Gt9gW0Lcts1cMKdBOjAXZeSFFRYDxC4JnoUCC
         lxH+OtLqT6rAYPZV0497AjPhSDwFm9q4NoeLagp2VLCIpgAqihEHlE0GuHY2uq8TUZDk
         uwLOAIzMUF0gLV3SAQfC+6R79jpbzSKpPqGK1nBxDjITutyV3fupewULxLr7/m0abJzd
         tg7g==
X-Gm-Message-State: ACgBeo2E4e3fs4jZ86Ud6FSH5s+2B8v3Mym9rA7cXWgvceBrVTyPtldA
        dz+RUswYuYvLcRHEuAzRa9Y=
X-Google-Smtp-Source: AA6agR4N1vy40B5SNUN0ttAaRtkXeCRkZeOEXFUFzwEDI4SqjixxV2GIekJUCdn/qXT/VkS9FaZMUQ==
X-Received: by 2002:a17:90b:3805:b0:1f4:ebfe:558b with SMTP id mq5-20020a17090b380500b001f4ebfe558bmr9502037pjb.48.1659366411834;
        Mon, 01 Aug 2022 08:06:51 -0700 (PDT)
Received: from localhost.localdomain ([61.79.194.208])
        by smtp.googlemail.com with ESMTPSA id jz21-20020a17090b14d500b001f1ef42fd7bsm11961005pjb.36.2022.08.01.08.06.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 08:06:51 -0700 (PDT)
From:   Kangmin Park <l4stpr0gr4m@gmail.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Kees Cook <keescook@chromium.org>, Oleg Nesterov <oleg@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] signal: Remove duplicate code in do_tkill
Date:   Tue,  2 Aug 2022 00:06:47 +0900
Message-Id: <20220801150647.70207-1-l4stpr0gr4m@gmail.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

do_tkill() prepares kernel_siginfo with the same logic as the
prepare_kill_siginfo() except to set si_code.

So, add si_code parameter to the prepare_kill_siginfo(), and call
the function in do_tkill() to remove the duplicate code.

Signed-off-by: Kangmin Park <l4stpr0gr4m@gmail.com>
---
 kernel/signal.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index 6f86fda5e432..a71f4d69dd54 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -3752,12 +3752,12 @@ COMPAT_SYSCALL_DEFINE4(rt_sigtimedwait_time32, compat_sigset_t __user *, uthese,
 #endif
 #endif
 
-static inline void prepare_kill_siginfo(int sig, struct kernel_siginfo *info)
+static inline void prepare_kill_siginfo(int sig, int si_code, struct kernel_siginfo *info)
 {
 	clear_siginfo(info);
 	info->si_signo = sig;
 	info->si_errno = 0;
-	info->si_code = SI_USER;
+	info->si_code = si_code;
 	info->si_pid = task_tgid_vnr(current);
 	info->si_uid = from_kuid_munged(current_user_ns(), current_uid());
 }
@@ -3771,7 +3771,7 @@ SYSCALL_DEFINE2(kill, pid_t, pid, int, sig)
 {
 	struct kernel_siginfo info;
 
-	prepare_kill_siginfo(sig, &info);
+	prepare_kill_siginfo(sig, SI_USER, &info);
 
 	return kill_something_info(sig, &info, pid);
 }
@@ -3884,7 +3884,7 @@ SYSCALL_DEFINE4(pidfd_send_signal, int, pidfd, int, sig,
 		    (kinfo.si_code >= 0 || kinfo.si_code == SI_TKILL))
 			goto err;
 	} else {
-		prepare_kill_siginfo(sig, &kinfo);
+		prepare_kill_siginfo(sig, SI_USER, &kinfo);
 	}
 
 	ret = kill_pid_info(sig, &kinfo, pid);
@@ -3928,12 +3928,7 @@ static int do_tkill(pid_t tgid, pid_t pid, int sig)
 {
 	struct kernel_siginfo info;
 
-	clear_siginfo(&info);
-	info.si_signo = sig;
-	info.si_errno = 0;
-	info.si_code = SI_TKILL;
-	info.si_pid = task_tgid_vnr(current);
-	info.si_uid = from_kuid_munged(current_user_ns(), current_uid());
+	prepare_kill_siginfo(sig, SI_TKILL, &info);
 
 	return do_send_specific(tgid, pid, sig, &info);
 }
-- 
2.26.3

