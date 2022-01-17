Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67CFE490B84
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 16:37:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240523AbiAQPhE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 10:37:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237296AbiAQPhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 10:37:02 -0500
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FE20C061574
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 07:37:02 -0800 (PST)
Received: by mail-wm1-x349.google.com with SMTP id w5-20020a1cf605000000b0034b8cb1f55eso5190179wmc.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 07:37:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=1thsq464ntZ1Q6hN1oNhhbpxlas4Ufptak2u+5NaEgg=;
        b=Mu/4nG9MsWYJC0F8RgjvHauRdNem04cKRH+xztrPCTh8xwBL3zS9lULs+kndSOLPeg
         DCY1B7EiOfqzKPw5+gzRCFB/kqf1/Et/m0GCDDjCDo1KKkYmkFqlBfmhol/1RO4PGsFX
         vQy2wtJu4HzXh/XG1T88ibpsyL3WkYqxxDegotZDOkoy4Kuo+Q4JUBj+xxxXkDXHX8o+
         oWmfg+Ou3VNd9Rwlk6zCBxYsLyi+l7Fhn9N7jhCWMHMNVN0/Nf7Hicrr+Jjb7sRWm/oZ
         to02tjLEO5wgUISZBZwXTyP6AzT4h6LjKeNTeIQqlHAStRY89nm5+gNWCHzz6wdtjpBe
         RPtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=1thsq464ntZ1Q6hN1oNhhbpxlas4Ufptak2u+5NaEgg=;
        b=E8z51Rzyggk9LxFrArQ1TzxrAW9wyZV5G+QxH5WSy/vtPuuHzDVhhUWZLRI2oPfgsn
         tp7df144i/V5Nti5xwE7SKLq3LQwceni+yEhklMbEFGVNE2GbI9SrQNgdZR2I8Y4Y4UA
         zqWKo6SMHPLEPdM0af5qsbRRvABwCFO6ng/SZ614DZUwmsLjOLOnbzJGgligbgRLc/gz
         VboT8hH+C9mR7etUELI2/h1HuH3Px8/oL35LE8Tug+SFv37ju0r4CoZqrmNe4EDHJvMy
         itR9Zw6ElOfT/7hAdVk2OmdrL7iC56pp/sb0YVNIAFCO/rLygejXvZOKpQx/cE63BzsN
         Cu2A==
X-Gm-Message-State: AOAM533+mJmYQzdHYNBLJCtykqczJVSUxY+t6H7h7BQMyJBE21uCmzSK
        lvYRWple/6mRSU9z6zv/rp10d32Er9A=
X-Google-Smtp-Source: ABdhPJyeOOYVbaUb669nA1YMRKxEqaGjPJjSEmytoc6GRzTaslfSLpD5JOlE0QEasuDhzg3ORCJRsiGtLYc=
X-Received: from nogikh-hp.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:200d])
 (user=nogikh job=sendgmr) by 2002:a05:600c:33a7:: with SMTP id
 o39mr20091461wmp.6.1642433820772; Mon, 17 Jan 2022 07:37:00 -0800 (PST)
Date:   Mon, 17 Jan 2022 15:36:34 +0000
In-Reply-To: <20220117153634.150357-1-nogikh@google.com>
Message-Id: <20220117153634.150357-3-nogikh@google.com>
Mime-Version: 1.0
References: <20220117153634.150357-1-nogikh@google.com>
X-Mailer: git-send-email 2.34.1.703.g22d0c6ccf7-goog
Subject: [PATCH v3 2/2] kcov: properly handle subsequent mmap calls
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
 kernel/kcov.c | 34 +++++++++++++++-------------------
 1 file changed, 15 insertions(+), 19 deletions(-)

diff --git a/kernel/kcov.c b/kernel/kcov.c
index e1be7301500b..475524bd900a 100644
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
 
@@ -674,6 +665,7 @@ static long kcov_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
 	unsigned int remote_num_handles;
 	unsigned long remote_arg_size;
 	unsigned long size, flags;
+	void *area;
 
 	kcov = filep->private_data;
 	switch (cmd) {
@@ -683,17 +675,21 @@ static long kcov_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
 		 * Must happen before anything else.
 		 *
 		 * First check the size argument - it must be at least 2
-		 * to hold the current position and one PC. Later we allocate
-		 * size * sizeof(unsigned long) memory, that must not overflow.
+		 * to hold the current position and one PC.
 		 */
 		size = arg;
 		if (size < 2 || size > INT_MAX / sizeof(unsigned long))
 			return -EINVAL;
+		area = vmalloc_user(size * sizeof(unsigned long));
+		if (area == NULL)
+			return -ENOMEM;
 		spin_lock_irqsave(&kcov->lock, flags);
 		if (kcov->mode != KCOV_MODE_DISABLED) {
 			spin_unlock_irqrestore(&kcov->lock, flags);
+			vfree(area);
 			return -EBUSY;
 		}
+		kcov->area = area;
 		kcov->size = size;
 		kcov->mode = KCOV_MODE_INIT;
 		spin_unlock_irqrestore(&kcov->lock, flags);
-- 
2.34.1.703.g22d0c6ccf7-goog

