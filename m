Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4E6047C49A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 18:04:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231777AbhLUREQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 12:04:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231747AbhLUREN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 12:04:13 -0500
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D435AC061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 09:04:12 -0800 (PST)
Received: by mail-wr1-x44a.google.com with SMTP id h7-20020adfaa87000000b001885269a937so4886430wrc.17
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 09:04:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=E92eP/emmd4tPCtN84LURrU10uCO5laN21sGBPTutAE=;
        b=rwpDUr7BTlt54xIChNSmy2vthIyUPwepgykcLhAy0Tqh6ftXSTZ/GU2wZdiVYKH08q
         qlSOPn5txoRbNT7LCL8O7qHChumewLMumnMW+8Nmo+KPjs1Ic9CeT6Kip/bt1ynTn41n
         76P2uFig+Iz7hVjf76TDD4MfC4k37Tyqjfug663hsm2+PpKw1YpwM2dvlKmAGX4Ud5S6
         8Uz5E3KA+xcUdh7nwoqwFoy146IBa7rYSH3ewx+EcUcWQ7aEJagBL5GigJNuOwuJL72J
         py64vabHgkeBqKjTCs4E+NgfvQzhDC2CXrS8y+vrVJ5/LtG6IWP/4qRMo91Z8NtkYyfW
         H8aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=E92eP/emmd4tPCtN84LURrU10uCO5laN21sGBPTutAE=;
        b=elmNKSzjHUSx6fcy3zH5iZt1G71uKpQI4+0hW6jvzHZTyYbirxYLeUQpya72olKwqf
         EjQ6OG8ZpYXwk9RVc7IUc/C38NsnWBQSXvuzsVba9v2gOqiaCLc/eUAy66HBizDNN+Ow
         IVLRUvk/ADfQtv1QPeV/uVTQCuXGhsvIWdUKxRzi4CdZGtmL/BINghkvd4WEyd/egYVB
         9TlZPskyenrbUT3RoQ3A1w+t+ZPHkfq6uWTWra+Kwh+hZhS0s9fH5xQThQFe/D2fb+La
         Wu+FulKqPO+rNkLHLhPjV8XWrLarYMXe8vPdYz9vo2xMXHHruULeyMhzPZQp2cBn5hPm
         1lrA==
X-Gm-Message-State: AOAM5336PFcYz7m7brMMCmbj4h2WJ8VQaySLKiB/kTXb9xgvoMdEMR1h
        Efgb+vr/KmDwJ9yxIjymt3Yfq6cCfEY=
X-Google-Smtp-Source: ABdhPJyLn8mGeU7bn6CPz7Aiqz1oL/fzfhyHRcntGAJO1GMZpfrwge/x6XsHlSdfv7OZ2HE5m/brWxjkYHs=
X-Received: from nogikh-hp.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:200d])
 (user=nogikh job=sendgmr) by 2002:a1c:9dc7:: with SMTP id g190mr3701479wme.56.1640106251428;
 Tue, 21 Dec 2021 09:04:11 -0800 (PST)
Date:   Tue, 21 Dec 2021 17:03:48 +0000
In-Reply-To: <20211221170348.1113266-1-nogikh@google.com>
Message-Id: <20211221170348.1113266-3-nogikh@google.com>
Mime-Version: 1.0
References: <20211221170348.1113266-1-nogikh@google.com>
X-Mailer: git-send-email 2.34.1.307.g9b7440fafd-goog
Subject: [PATCH v2 2/2] kcov: properly handle subsequent mmap calls
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

Allocate the kcov buffer during KCOV_MODE_INIT in order to untie mmapping
of a kcov instance and the actual coverage collection process. Modify
kcov_mmap, so that it can be reliably used any number of times once
KCOV_MODE_INIT has succeeded.

These changes to the user-facing interface of the tool only weaken the
preconditions, so all existing user space code should remain compatible
with the new version.

Signed-off-by: Aleksandr Nogikh <nogikh@google.com>
---
 kernel/kcov.c | 49 +++++++++++++++++++++++++------------------------
 1 file changed, 25 insertions(+), 24 deletions(-)

diff --git a/kernel/kcov.c b/kernel/kcov.c
index 5d87b4e0126f..d6a522fc6f36 100644
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
 
@@ -671,25 +662,35 @@ static int kcov_ioctl_unlocked(struct kcov *kcov, unsigned int cmd,
 {
 	unsigned long size, flags;
 	int res;
+	void *area;
 
 	switch (cmd) {
 	case KCOV_INIT_TRACE:
 		/*
 		 * Enable kcov in trace mode and setup buffer size.
 		 * Must happen before anything else.
-		 */
-		if (kcov->mode != KCOV_MODE_DISABLED)
-			return -EBUSY;
-		/*
-		 * Size must be at least 2 to hold current position and one PC.
-		 * Later we allocate size * sizeof(unsigned long) memory,
-		 * that must not overflow.
+		 *
+		 * First check the size argument - it must be at least 2
+		 * to hold the current position and one PC.
 		 */
 		size = arg;
 		if (size < 2 || size > INT_MAX / sizeof(unsigned long))
 			return -EINVAL;
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
 		kcov->size = size;
 		kcov->mode = KCOV_MODE_INIT;
+		spin_unlock_irqrestore(&kcov->lock, flags);
 		return 0;
 	default:
 		/*
-- 
2.34.1.307.g9b7440fafd-goog

