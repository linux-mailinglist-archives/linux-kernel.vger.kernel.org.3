Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 698B848FD97
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jan 2022 16:22:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233352AbiAPPW0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jan 2022 10:22:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232438AbiAPPWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jan 2022 10:22:25 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ECF5C061574
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jan 2022 07:22:25 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id c3so17756761pls.5
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jan 2022 07:22:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7BIV0js4UbF8/Y8EYJIpYDkaZzNBpg6RgfMsE41pezQ=;
        b=BOv1G4Lw//e9jAGIFPrDuw7fzdnWMIY6fhuk6tlrDK8z67I4P1+cFov7fTCMzp5SM8
         nFjFSNw79uASgPIC4/1ZCqSKDevHAJtIaUifqEAKAbo9MlsBsGjXmaMGZ1eR8cYn9nmo
         sybKBH3l+EByRA1Gyg0jo0bharfKujVHTXUYgURgygS2xO6u/lgCMtj6rLOOz5m143WC
         803XnVpF9DM2Nb37vw28De7wL0N6aNfcoQbxuVrG0+7zboXb22pmI4R+PTUhUV6jN9bk
         FkLYfy+JlqTig24YyqTKgzaMAgDSoT4EqmkbU8F1Qn3viw2zT9sXZVhbZH0t5gGlkcMV
         aZMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7BIV0js4UbF8/Y8EYJIpYDkaZzNBpg6RgfMsE41pezQ=;
        b=PRtgjOp364jBH5ntEBM5x44UGdxR9QMYHaFQstyudVaj0CqIYi0Wa+9AXv/HMl9gtz
         etLmRwb3682/SXEZQZNOkvHse6cO6wLhHans8TWEpidpwOMI2TLm7G57vr0QFLBXNHUV
         xjvNiZDgEQ1IUDEKIxdtIeD0WF7kW1aX1NgfBcopNI33D6zZSt8KW2vSNb24tePP/Nce
         DA0p4m6iDj4u47tu3J9VdeSf55LXhJw+knm+RuZxabLE1k0X4PR69beVyyn3XFtAc8+p
         cokaWLmU+LizltFO3LMf6HffTITddRIq+T0sdpuDHE9DB4ZKT9ktnWgJ6Ec9VsS2+5TN
         0yLQ==
X-Gm-Message-State: AOAM531/pxSCLZP1Nn4f2ddDAN2Yhzzi2lyKou0w+ZQL/4L7mH7LVt4l
        Bdh3xJ1rKr0OO0IPbSrOTt6cBbOSfaA=
X-Google-Smtp-Source: ABdhPJypzOcki1MvhKG0rkpZAhPTqWajyk7J+SdUpYPjjHEgoO5gWUMjks0wUmKq8VzRXq7eCfBidA==
X-Received: by 2002:a17:90b:1648:: with SMTP id il8mr20944360pjb.227.1642346545096;
        Sun, 16 Jan 2022 07:22:25 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id j11sm10863224pfn.199.2022.01.16.07.22.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jan 2022 07:22:24 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: yang.yang29@zte.com.cn
To:     akpm@linux-foundation.org, hannes@cmpxchg.org, sfr@canb.auug.org.au
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yang Yang <yang.yang29@zte.com.cn>
Subject: [PATCH] psi: Treat ksm swapping in copy as memstall
Date:   Sun, 16 Jan 2022 15:21:51 +0000
Message-Id: <20220116152150.859520-1-yang.yang29@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yang Yang <yang.yang29@zte.com.cn>

When faults in from swap what used to be a ksm page and that page
had been swapped in before, system has to make a copy. Obviously
this kind of copy is related to high memory pressure, so we treat
it as memstall. Although ksm page merging is not because of high
memory pressure.

Information of this new kind of stall will help psi to account
memory pressure more precise.

Signed-off-by: Yang Yang <yang.yang29@zte.com.cn>
---
 mm/ksm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/ksm.c b/mm/ksm.c
index 4a7f8614e57d..d4ec6773f9b8 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -39,6 +39,7 @@
 #include <linux/freezer.h>
 #include <linux/oom.h>
 #include <linux/numa.h>
+#include <linux/psi.h>
 
 #include <asm/tlbflush.h>
 #include "internal.h"
@@ -2569,6 +2570,7 @@ struct page *ksm_might_need_to_copy(struct page *page,
 {
 	struct anon_vma *anon_vma = page_anon_vma(page);
 	struct page *new_page;
+	unsigned long pflags;
 
 	if (PageKsm(page)) {
 		if (page_stable_node(page) &&
@@ -2583,6 +2585,7 @@ struct page *ksm_might_need_to_copy(struct page *page,
 	if (!PageUptodate(page))
 		return page;		/* let do_swap_page report the error */
 
+	psi_memstall_enter(&pflags);
 	new_page = alloc_page_vma(GFP_HIGHUSER_MOVABLE, vma, address);
 	if (new_page &&
 	    mem_cgroup_charge(page_folio(new_page), vma->vm_mm, GFP_KERNEL)) {
@@ -2600,6 +2603,7 @@ struct page *ksm_might_need_to_copy(struct page *page,
 #endif
 	}
 
+	psi_memstall_leave(&pflags);
 	return new_page;
 }
 
-- 
2.25.1

