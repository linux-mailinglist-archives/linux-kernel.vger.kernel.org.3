Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE9D44EF9CE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 20:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350465AbiDAS1M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 14:27:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350401AbiDAS1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 14:27:08 -0400
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F3E41A847E
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 11:25:18 -0700 (PDT)
Received: by mail-wm1-x349.google.com with SMTP id r203-20020a1c44d4000000b0038c15a1ed8cso494613wma.7
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 11:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=zbS7FZD4vfmPvNMcqFqSr87xT5C2GWUmtECcKw2k5VU=;
        b=CGE4/xLWrrtLkQAyvLbuvTN/ZlbyBFVpKF65hjermfjg2wf4LLYyyt8KpB3XEXcTtu
         3MJwkhFOQZhtvJBeB/2yJ2nQ4LLvVLDPCDfP6oM4SPHvDmkEx4ZvxGanK1qJlweCC8+a
         XOk/IDc+7sSSpxbGAlKXD0p0u5F8xDLcK6ECNF940pOP90vEYL7AeXWxlhBms0Ock8dA
         l9Jqayln8tPr636kuKKPD1n85ov8qGI3RHTIpInXaPipHmivvAnkWaWM1ncsiAEizudo
         KRaf+FmRUjphJIaAtDqGeBBf4YKr8x6pb/mBhbMoZqkijmfUYVNmPnJi7zua6zYEwAM9
         VEWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=zbS7FZD4vfmPvNMcqFqSr87xT5C2GWUmtECcKw2k5VU=;
        b=13OgjjhS1lK4brUkGDZDMAGC0ywNJj6R8ZUtGA1rZHgKhRfkK1DcDk7fO6vMm3c363
         iU0r3X0rMTQbGYs5VEjv1Dj1+LtYjTSVpQUVjHU8RgebEphzGaduHBQRX2TxkFF2UBr/
         VHsaITn1eHiI9C+/6vuygOMvRkk8/DjTOpiDasvYqa9FSNDzg6rPTkbfCm/7n+DuWCc6
         I7IHSGNAmwfqI2oBljAzYrL3JxevwSWrWE8/y4A9DxbXbog0WbcPOrvrrEGKsD4vXMdT
         6R2QAZCMNvBuC8PhQ1sxw3W4+9CjS1k8nqs80J85eBvbpGuivAWq/yFwM3W+KILgjOCO
         OW7A==
X-Gm-Message-State: AOAM532fazwTAO8TiV1toohl+Y6TsNgMph8RiY0vJZOi8U+YM5t5Wvz7
        BlXbwpaWDFpJCFK9T0Sg76Okjq6kFNM=
X-Google-Smtp-Source: ABdhPJxAo0fTZrW+3cwtO5aIlhQBn9998yojLFNd5gKNuSI8iikH3IwbkxXrIxp09nl3LvO/mmRyPh06Onc=
X-Received: from nogikh-hp.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:200d])
 (user=nogikh job=sendgmr) by 2002:a7b:c844:0:b0:37b:b986:7726 with SMTP id
 c4-20020a7bc844000000b0037bb9867726mr10199318wml.160.1648837516835; Fri, 01
 Apr 2022 11:25:16 -0700 (PDT)
Date:   Fri,  1 Apr 2022 18:25:12 +0000
Message-Id: <20220401182512.249282-1-nogikh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.1094.g7c7d902a7c-goog
Subject: [PATCH v3] kcov: don't generate a warning on vm_insert_page()'s failure
From:   Aleksandr Nogikh <nogikh@google.com>
To:     kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org
Cc:     dvyukov@google.com, andreyknvl@gmail.com, elver@google.com,
        glider@google.com, tarasmadan@google.com, bigeasy@linutronix.de,
        nogikh@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vm_insert_page()'s failure is not an unexpected condition, so don't do
WARN_ONCE() in such a case.

Instead, print a kernel message and just return an error code.

Signed-off-by: Aleksandr Nogikh <nogikh@google.com>
Acked-by: Marco Elver <elver@google.com>
---
PATCH v3:
* Adjusted the patch format.

PATCH v2:
* Added a newline at the end of pr_warn_once().
https://lore.kernel.org/all/20220401084333.85616-1-nogikh@google.com/

PATCH v1:
https://lore.kernel.org/all/20220331180501.4130549-1-nogikh@google.com/
---
 kernel/kcov.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/kcov.c b/kernel/kcov.c
index 475524bd900a..b3732b210593 100644
--- a/kernel/kcov.c
+++ b/kernel/kcov.c
@@ -475,8 +475,11 @@ static int kcov_mmap(struct file *filep, struct vm_area_struct *vma)
 	vma->vm_flags |= VM_DONTEXPAND;
 	for (off = 0; off < size; off += PAGE_SIZE) {
 		page = vmalloc_to_page(kcov->area + off);
-		if (vm_insert_page(vma, vma->vm_start + off, page))
-			WARN_ONCE(1, "vm_insert_page() failed");
+		res = vm_insert_page(vma, vma->vm_start + off, page);
+		if (res) {
+			pr_warn_once("kcov: vm_insert_page() failed\n");
+			return res;
+		}
 	}
 	return 0;
 exit:
-- 
2.35.1.1094.g7c7d902a7c-goog

