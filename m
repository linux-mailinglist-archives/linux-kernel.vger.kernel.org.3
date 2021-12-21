Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA8247C499
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 18:04:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231590AbhLUREL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 12:04:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230484AbhLUREK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 12:04:10 -0500
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EFDBC061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 09:04:10 -0800 (PST)
Received: by mail-wm1-x349.google.com with SMTP id ay40-20020a05600c1e2800b003458b72e865so1571411wmb.9
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 09:04:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=tAooiWC6s3hGfLWdFjLduilnhzXlkBJTQtprgFsbC0o=;
        b=mt6SflaHttOXMo5IdHfav4XJKjqRUcXV/IcRkPTC2HpPWr0iYXnqGdz7rW8j0B2psQ
         GP9CEXSaVgrXipTdYPzvrEAgxsjSlqI+bUDNQQfTi9knQpEJ4WjL2JrrXnvQ2Vrqy3y6
         UXTQNabhLReAXNgGz6hHPkfBgXmSA+Y54s3e1uoyklmsA4hu+jC6AGY8B3A2xPSoEPTr
         /9Q1ozn0eZlyyI98QfJLshzAqoU/1xcGn9WkBPZFjGolHKzUsPxSh4bOhbWRCkxX8tlT
         ci5IuqhVqtthnxlUWzDj4FtWs3Jk2F4Zs6BcZmOWfTX0sudfkeQ71wfF0tlSuthQI7kG
         unHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=tAooiWC6s3hGfLWdFjLduilnhzXlkBJTQtprgFsbC0o=;
        b=tdU/xxkQWLB4JPJKlZsFdHZG5vKcLOmSIJBHyawUmXtV3MlgRL5qJKAtPX8Wc4Yuey
         lSsiEFv2ks6bKiFcnDlO7N2/0K0O3gevdmkj8rTBl7BTMDZUbW0R2vW0YfDXwVnK+8rm
         t9zHMXBIGk9vcMSKuw8rq/ttNjJnPu8KorRM+fAEBZY2bDJKaqU4aE+Me1B4+zvwtPM7
         ZYza4+y0NBO1egtkgyD6JTFFE27Uh3K3lTOEULFQhSL5iRmd+673VLWYMBZSFelR5Dcq
         6lxVyGj72xQxVSRyOPBArkjEEOLECwXhObt6pxoj7/YedFEWn4CnZxRr3Zn/tHCtX8N4
         D12A==
X-Gm-Message-State: AOAM530lTo1pW56rVijO3wwiLK9Gnq4AzkkMOjZ9lBzaOzI9GCKpiHV9
        5Up2hjS6jyR/HWlhs027hqRmwFYzV/Q=
X-Google-Smtp-Source: ABdhPJxNg3MRDG0w76H+Usw0QGimLPzUV1NQv9ea80h4ZfMx4qSxPKR+9iH0YfFhDc5TGu2K7QANkmWtUFc=
X-Received: from nogikh-hp.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:200d])
 (user=nogikh job=sendgmr) by 2002:a7b:c219:: with SMTP id x25mr67034wmi.1.1640106248480;
 Tue, 21 Dec 2021 09:04:08 -0800 (PST)
Date:   Tue, 21 Dec 2021 17:03:47 +0000
In-Reply-To: <20211221170348.1113266-1-nogikh@google.com>
Message-Id: <20211221170348.1113266-2-nogikh@google.com>
Mime-Version: 1.0
References: <20211221170348.1113266-1-nogikh@google.com>
X-Mailer: git-send-email 2.34.1.307.g9b7440fafd-goog
Subject: [PATCH v2 1/2] kcov: split ioctl handling into locked and unlocked parts
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

Currently all ioctls are de facto processed under a spin lock in order
to serialise them. This, however, prohibits the use of vmalloc and other
memory management functions in the implementation of those ioctls,
unnecessary complicating any further changes.

Let all ioctls first be processed inside the kcov_ioctl_unlocked()
function which should execute the ones that are not compatible with
spinlock and pass control to kcov_ioctl_locked() for all other ones.

Although it is still compatible with a spinlock, move KCOV_INIT_TRACE
handling to kcov_ioctl_unlocked(), so that its planned change is easier
to follow.

Signed-off-by: Aleksandr Nogikh <nogikh@google.com>
---
 kernel/kcov.c | 64 +++++++++++++++++++++++++++++++--------------------
 1 file changed, 39 insertions(+), 25 deletions(-)

diff --git a/kernel/kcov.c b/kernel/kcov.c
index 36ca640c4f8e..5d87b4e0126f 100644
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
@@ -685,6 +666,43 @@ static int kcov_ioctl_locked(struct kcov *kcov, unsigned int cmd,
 	}
 }
 
+static int kcov_ioctl_unlocked(struct kcov *kcov, unsigned int cmd,
+			     unsigned long arg)
+{
+	unsigned long size, flags;
+	int res;
+
+	switch (cmd) {
+	case KCOV_INIT_TRACE:
+		/*
+		 * Enable kcov in trace mode and setup buffer size.
+		 * Must happen before anything else.
+		 */
+		if (kcov->mode != KCOV_MODE_DISABLED)
+			return -EBUSY;
+		/*
+		 * Size must be at least 2 to hold current position and one PC.
+		 * Later we allocate size * sizeof(unsigned long) memory,
+		 * that must not overflow.
+		 */
+		size = arg;
+		if (size < 2 || size > INT_MAX / sizeof(unsigned long))
+			return -EINVAL;
+		kcov->size = size;
+		kcov->mode = KCOV_MODE_INIT;
+		return 0;
+	default:
+		/*
+		 * All other commands can be fully executed under a spin lock, so we
+		 * obtain and release it here to simplify the code of kcov_ioctl_locked().
+		 */
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
@@ -692,7 +710,6 @@ static long kcov_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
 	struct kcov_remote_arg *remote_arg = NULL;
 	unsigned int remote_num_handles;
 	unsigned long remote_arg_size;
-	unsigned long flags;
 
 	if (cmd == KCOV_REMOTE_ENABLE) {
 		if (get_user(remote_num_handles, (unsigned __user *)(arg +
@@ -713,10 +730,7 @@ static long kcov_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
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
2.34.1.307.g9b7440fafd-goog

