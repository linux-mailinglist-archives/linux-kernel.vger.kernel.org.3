Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10F0B47B042
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 16:30:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236835AbhLTPaG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 10:30:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240400AbhLTP3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 10:29:54 -0500
Received: from mail-ed1-x549.google.com (mail-ed1-x549.google.com [IPv6:2a00:1450:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6BD0C03711E
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 07:22:05 -0800 (PST)
Received: by mail-ed1-x549.google.com with SMTP id q15-20020a056402518f00b003f87abf9c37so187404edd.15
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 07:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=DGxWEqDmq2iHcedzGdhHTPdO/cXggHy4vSm/RYyxtTI=;
        b=MtTxOS+NysVzWl1hcf82xmO8+WcmppBTV7X7KDxe9BbOE7l+umvSDgzYgznNGX0TgI
         wCMBnpqP1gHsY1susXNFT3exTkL+yflxeKsVIFEuWrID3+0ZjEYZxDfQsvDvUqE4Limq
         xMQt6KsemJFFMSJ5Gi/rsiK0NRWIEbINblQYYuNLGm0Gx6J1FkjQtB52xGdD+wUnrQfA
         deHCLoobqTQcaOkx1IVvnXVDNzhTEcHiG1Z0WX/WSikkxDUqCiFqPG1VQBcjl1pxsMY9
         md+k+/Rt3phqHLEuN6qJ3KOaVOOxwGIw575utmuZnltfqrCqZAcKUxl5/D3XH27+36ry
         nZKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=DGxWEqDmq2iHcedzGdhHTPdO/cXggHy4vSm/RYyxtTI=;
        b=n72rkem4p+dCKvUoou0ZHsKBUHILvR5MVfdLpId2I2Pi/gN67t7s55DOReBldiVyD2
         1BCURxfyirFBPtj2fTVpDvrmEWJNKhyZntzREKu5HPbTfzzHFxjTHtzNwwPi5es2AKLP
         DvdpgC7VgE7ISeMK1+HDYgbwfRxcbGmoi0FgY5Jgx/ziRyo7F6jDZxbHtS2zT57f57Vv
         J1vy51oEscLVS37PPXHGtlcozwh+Bk9/pYVhEJ6yZhLkS6RK2PE0GzVm+zjr3qOojl1X
         JeV7s3eH+ch3UHpn5CzeLk8I/ftHnbeZYzk82zYwm9aR8Aze1H4h29bAU3r+rh48QwPG
         9inw==
X-Gm-Message-State: AOAM533m6S4MyrUTe5X6miq5Lsa0Xa2UGJWRMjx5LrV1wDRQ5KBSldU6
        DnCCIA9XTJ/evWiScWzXL8ovq9y2yzQ=
X-Google-Smtp-Source: ABdhPJzGvNZo/fBNzO3LTHekXl27euxc2BN9jvyJsCp8BNvheZzUx3U1Mt1m9bt7091M254A9LOc0A/PYuI=
X-Received: from nogikh-hp.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:200d])
 (user=nogikh job=sendgmr) by 2002:a17:907:6e11:: with SMTP id
 sd17mr6030459ejc.143.1640013724229; Mon, 20 Dec 2021 07:22:04 -0800 (PST)
Date:   Mon, 20 Dec 2021 15:21:53 +0000
Message-Id: <20211220152153.910990-1-nogikh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH] kcov: properly handle subsequent mmap calls
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

Subsequent mmaps of the same kcov descriptor currently do not update the
virtual memory of the task and yet return 0 (success). This is
counter-intuitive and may lead to unexpected memory access errors.

Also, this unnecessarily limits the functionality of kcov to only the
simplest usage scenarios. Kcov instances are effectively forever attached
to their first address spaces and it becomes impossible to e.g. reuse the
same kcov handle in forked child processes without mmapping the memory
first. This is exactly what we tried to do in syzkaller and
inadvertently came upon this problem.

Allocate the buffer during KCOV_MODE_INIT in order to untie mmap and
coverage collection. Modify kcov_mmap, so that it can be reliably used
any number of times once KCOV_MODE_INIT has succeeded.

Refactor ioctl processing so that a vmalloc could be executed before the
spin lock is obtained.

These changes to the user-facing interface of the tool only weaken the
preconditions, so all existing user space code should remain compatible
with the new version.

Signed-off-by: Aleksandr Nogikh <nogikh@google.com>
---
 kernel/kcov.c | 94 +++++++++++++++++++++++++++++----------------------
 1 file changed, 53 insertions(+), 41 deletions(-)

diff --git a/kernel/kcov.c b/kernel/kcov.c
index 36ca640c4f8e..49e1fa2b330f 100644
--- a/kernel/kcov.c
+++ b/kernel/kcov.c
@@ -459,37 +459,28 @@ void kcov_task_exit(struct task_struct *t)
 static int kcov_mmap(struct file *filep, struct vm_area_struct *vma)
 {
 	int res = 0;
-	void *area;
 	struct kcov *kcov = vma->vm_file->private_data;
 	unsigned long size, off;
 	struct page *page;
 	unsigned long flags;
 
-	area = vmalloc_user(vma->vm_end - vma->vm_start);
-	if (!area)
-		return -ENOMEM;
-
 	spin_lock_irqsave(&kcov->lock, flags);
 	size = kcov->size * sizeof(unsigned long);
-	if (kcov->mode != KCOV_MODE_INIT || vma->vm_pgoff != 0 ||
+	if (kcov->area == NULL || vma->vm_pgoff != 0 ||
 	    vma->vm_end - vma->vm_start != size) {
 		res = -EINVAL;
 		goto exit;
 	}
-	if (!kcov->area) {
-		kcov->area = area;
-		vma->vm_flags |= VM_DONTEXPAND;
-		spin_unlock_irqrestore(&kcov->lock, flags);
-		for (off = 0; off < size; off += PAGE_SIZE) {
-			page = vmalloc_to_page(kcov->area + off);
-			if (vm_insert_page(vma, vma->vm_start + off, page))
-				WARN_ONCE(1, "vm_insert_page() failed");
-		}
-		return 0;
+	spin_unlock_irqrestore(&kcov->lock, flags);
+	vma->vm_flags |= VM_DONTEXPAND;
+	for (off = 0; off < size; off += PAGE_SIZE) {
+		page = vmalloc_to_page(kcov->area + off);
+		if (vm_insert_page(vma, vma->vm_start + off, page))
+			WARN_ONCE(1, "vm_insert_page() failed");
 	}
+	return 0;
 exit:
 	spin_unlock_irqrestore(&kcov->lock, flags);
-	vfree(area);
 	return res;
 }
 
@@ -564,31 +555,13 @@ static int kcov_ioctl_locked(struct kcov *kcov, unsigned int cmd,
 			     unsigned long arg)
 {
 	struct task_struct *t;
-	unsigned long size, unused;
+	unsigned long unused;
 	int mode, i;
 	struct kcov_remote_arg *remote_arg;
 	struct kcov_remote *remote;
 	unsigned long flags;
 
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
@@ -685,6 +658,49 @@ static int kcov_ioctl_locked(struct kcov *kcov, unsigned int cmd,
 	}
 }
 
+static int kcov_ioctl_unlocked(struct kcov *kcov, unsigned int cmd,
+			     unsigned long arg)
+{
+	unsigned long size, flags;
+	void *area;
+	int res;
+
+	switch (cmd) {
+	case KCOV_INIT_TRACE:
+		/*
+		 * Enable kcov in trace mode and setup buffer size.
+		 * Must happen before anything else.
+		 *
+		 *
+		 * Size must be at least 2 to hold current position and one PC.
+		 */
+		size = arg;
+		if (size < 2 || size > INT_MAX / sizeof(unsigned long))
+			return -EINVAL;
+
+		area = vmalloc_user(size * sizeof(unsigned long));
+		if (area == NULL)
+			return -ENOMEM;
+
+		spin_lock_irqsave(&kcov->lock, flags);
+		if (kcov->mode != KCOV_MODE_DISABLED) {
+			spin_unlock_irqrestore(&kcov->lock, flags);
+			vfree(area);
+			return -EBUSY;
+		}
+		kcov->area = area;
+		kcov->size = size;
+		kcov->mode = KCOV_MODE_INIT;
+		spin_unlock_irqrestore(&kcov->lock, flags);
+		return 0;
+	default:
+		spin_lock_irqsave(&kcov->lock, flags);
+		res = kcov_ioctl_locked(kcov, cmd, arg);
+		spin_unlock_irqrestore(&kcov->lock, flags);
+		return res;
+	}
+}
+
 static long kcov_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
 {
 	struct kcov *kcov;
@@ -692,7 +708,6 @@ static long kcov_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
 	struct kcov_remote_arg *remote_arg = NULL;
 	unsigned int remote_num_handles;
 	unsigned long remote_arg_size;
-	unsigned long flags;
 
 	if (cmd == KCOV_REMOTE_ENABLE) {
 		if (get_user(remote_num_handles, (unsigned __user *)(arg +
@@ -713,10 +728,7 @@ static long kcov_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
 	}
 
 	kcov = filep->private_data;
-	spin_lock_irqsave(&kcov->lock, flags);
-	res = kcov_ioctl_locked(kcov, cmd, arg);
-	spin_unlock_irqrestore(&kcov->lock, flags);
-
+	res = kcov_ioctl_unlocked(kcov, cmd, arg);
 	kfree(remote_arg);
 
 	return res;
-- 
2.34.1.173.g76aa8bc2d0-goog

