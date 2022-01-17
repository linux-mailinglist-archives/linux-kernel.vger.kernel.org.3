Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DBB5490B83
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 16:37:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237298AbiAQPhB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 10:37:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240516AbiAQPg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 10:36:59 -0500
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84851C06161C
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 07:36:59 -0800 (PST)
Received: by mail-wm1-x349.google.com with SMTP id p14-20020a1c544e000000b003490705086bso5364694wmi.7
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 07:36:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=7DEaDOOzB1jAF1TPQvu7T4yVYcqfdELQFZk+rb6P+EE=;
        b=gGqm3c743gc+OxwlnzfyzsrMNdp8PEjKXHnHWIAoaPZgRaXyUT9Ka1fMKpsb4K6csI
         pbkCj8YnWSzX5gKSnhTAi9lLIHZaFBOdaJWabL4wd03YyJekI7agFrT9LcwZBqdslvh1
         7cjnP/SpkCkNWy0h6Gfy9ffA7XCgqTrIh0eyAYLzvzcyQzYtiDgRo0xDOxcka4IlhDz8
         ZDPm4mYyFmbGmvWIlPo3WOwVt031r2syrYpDZao2jQjgOsh4+0VKn2NnGwdTRSHR48EJ
         0FrzeKXGxIEWMZdI6125z/+VnO5wAEAD2RtJolFyy55yC+iA44msasVJLnkyyOF+F2EP
         23CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=7DEaDOOzB1jAF1TPQvu7T4yVYcqfdELQFZk+rb6P+EE=;
        b=11YcENv9Nk4JG5/i/UrtICXSjkfUPwcYDXpJ29bhKhTe2wjLVVxjNzuVEF3csOD6dz
         7qV36j3kP73mf+13wM6WU14zGo878cZI/y6t3jYdp83wfAq5z3RBcPOYwuomIoarEmzc
         3JvX9Oe7hThdfCUXEm+I1JP6JeIB98rVDVgXadTmaIUcfkcr2/6PA4Mu83pLeHY/VWo4
         PPGyWBZ+YgmrenrIo/InjZGMCkmsC/TVK2DIvJKQuj1GcW3vc4ZnC6uspg5/NLUXnygX
         4AMohHLKLKssXEs9PGTknSICAOV1kFoOLBaN/hCYJZ97LgiqY9UaZrnKS6WFe/1eJMk5
         JLJA==
X-Gm-Message-State: AOAM533ya2KR/vdccPC1XySGPz5ME6S/H0Mp5fo6T5LICQ4yQIVl26R9
        GNRCjY0TogPPxr/rtgQYPeRi5f1eWWw=
X-Google-Smtp-Source: ABdhPJw94eVN6v05Qb6SLTmmPo9/f2iZyqc3QCp1wgQYcc5H97QS8wStMmt3kP/n6MBaM6ESzadOcsQSA6Y=
X-Received: from nogikh-hp.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:200d])
 (user=nogikh job=sendgmr) by 2002:a05:600c:1908:: with SMTP id
 j8mr6340226wmq.155.1642433817868; Mon, 17 Jan 2022 07:36:57 -0800 (PST)
Date:   Mon, 17 Jan 2022 15:36:33 +0000
In-Reply-To: <20220117153634.150357-1-nogikh@google.com>
Message-Id: <20220117153634.150357-2-nogikh@google.com>
Mime-Version: 1.0
References: <20220117153634.150357-1-nogikh@google.com>
X-Mailer: git-send-email 2.34.1.703.g22d0c6ccf7-goog
Subject: [PATCH v3 1/2] kcov: split ioctl handling into locked and unlocked parts
From:   Aleksandr Nogikh <nogikh@google.com>
To:     kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org
Cc:     dvyukov@google.com, andreyknvl@gmail.com, elver@google.com,
        glider@google.com, tarasmadan@google.com, bigeasy@linutronix.de,
        nogikh@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently all ioctls are de facto processed under a spinlock in order
to serialise them. This, however, prohibits the use of vmalloc and other
memory management functions in the implementations of those ioctls,
unnecessary complicating any further changes to the code.

Let all ioctls first be processed inside the kcov_ioctl() function
which should execute the ones that are not compatible with spinlock
and then pass control to kcov_ioctl_locked() for all other ones.
KCOV_REMOTE_ENABLE is processed both in kcov_ioctl() and
kcov_ioctl_locked() as the steps are easily separable.

Although it is still compatible with a spinlock, move KCOV_INIT_TRACE
handling to kcov_ioctl(), so that the changes from the next commit are
easier to follow.

Signed-off-by: Aleksandr Nogikh <nogikh@google.com>
---
 kernel/kcov.c | 68 ++++++++++++++++++++++++++++-----------------------
 1 file changed, 37 insertions(+), 31 deletions(-)

diff --git a/kernel/kcov.c b/kernel/kcov.c
index 36ca640c4f8e..e1be7301500b 100644
--- a/kernel/kcov.c
+++ b/kernel/kcov.c
@@ -564,31 +564,12 @@ static int kcov_ioctl_locked(struct kcov *kcov, unsigned int cmd,
 			     unsigned long arg)
 {
 	struct task_struct *t;
-	unsigned long size, unused;
+	unsigned long flags, unused;
 	int mode, i;
 	struct kcov_remote_arg *remote_arg;
 	struct kcov_remote *remote;
-	unsigned long flags;
 
 	switch (cmd) {
-	case KCOV_INIT_TRACE:
-		/*
-		 * Enable kcov in trace mode and setup buffer size.
-		 * Must happen before anything else.
-		 */
-		if (kcov->mode != KCOV_MODE_DISABLED)
-			return -EBUSY;
-		/*
-		 * Size must be at least 2 to hold current position and one PC.
-		 * Later we allocate size * sizeof(unsigned long) memory,
-		 * that must not overflow.
-		 */
-		size = arg;
-		if (size < 2 || size > INT_MAX / sizeof(unsigned long))
-			return -EINVAL;
-		kcov->size = size;
-		kcov->mode = KCOV_MODE_INIT;
-		return 0;
 	case KCOV_ENABLE:
 		/*
 		 * Enable coverage for the current task.
@@ -692,9 +673,32 @@ static long kcov_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
 	struct kcov_remote_arg *remote_arg = NULL;
 	unsigned int remote_num_handles;
 	unsigned long remote_arg_size;
-	unsigned long flags;
+	unsigned long size, flags;
 
-	if (cmd == KCOV_REMOTE_ENABLE) {
+	kcov = filep->private_data;
+	switch (cmd) {
+	case KCOV_INIT_TRACE:
+		/*
+		 * Enable kcov in trace mode and setup buffer size.
+		 * Must happen before anything else.
+		 *
+		 * First check the size argument - it must be at least 2
+		 * to hold the current position and one PC. Later we allocate
+		 * size * sizeof(unsigned long) memory, that must not overflow.
+		 */
+		size = arg;
+		if (size < 2 || size > INT_MAX / sizeof(unsigned long))
+			return -EINVAL;
+		spin_lock_irqsave(&kcov->lock, flags);
+		if (kcov->mode != KCOV_MODE_DISABLED) {
+			spin_unlock_irqrestore(&kcov->lock, flags);
+			return -EBUSY;
+		}
+		kcov->size = size;
+		kcov->mode = KCOV_MODE_INIT;
+		spin_unlock_irqrestore(&kcov->lock, flags);
+		return 0;
+	case KCOV_REMOTE_ENABLE:
 		if (get_user(remote_num_handles, (unsigned __user *)(arg +
 				offsetof(struct kcov_remote_arg, num_handles))))
 			return -EFAULT;
@@ -710,16 +714,18 @@ static long kcov_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
 			return -EINVAL;
 		}
 		arg = (unsigned long)remote_arg;
+		fallthrough;
+	default:
+		/*
+		 * All other commands can be normally executed under a spin lock, so we
+		 * obtain and release it here in order to simplify kcov_ioctl_locked().
+		 */
+		spin_lock_irqsave(&kcov->lock, flags);
+		res = kcov_ioctl_locked(kcov, cmd, arg);
+		spin_unlock_irqrestore(&kcov->lock, flags);
+		kfree(remote_arg);
+		return res;
 	}
-
-	kcov = filep->private_data;
-	spin_lock_irqsave(&kcov->lock, flags);
-	res = kcov_ioctl_locked(kcov, cmd, arg);
-	spin_unlock_irqrestore(&kcov->lock, flags);
-
-	kfree(remote_arg);
-
-	return res;
 }
 
 static const struct file_operations kcov_fops = {
-- 
2.34.1.703.g22d0c6ccf7-goog

