Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 823F954CFE1
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 19:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357241AbiFORaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 13:30:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242396AbiFOR3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 13:29:38 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27A8E34BB3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 10:29:38 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id k5-20020a17090a404500b001e8875e6242so2670938pjg.5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 10:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WrF836BhqYoAAQYNFMJen23eOl+F6zz51fEhzRe3ck4=;
        b=jNiMa1EClCZmNoxHFwK9zkQt71WNj8eQXx1AtJzkARohOhJSxbNe9g9wKpdtMdMiFM
         JUylBaxwrEsHZe9FDtW/ty8pZHqkoiXrCVnIf4XeVJdT7glhN+11Co4GX3RF1sUTcydf
         V3HfSNZro9f+AcdFfuHK+L4B6g8H28LVBK/7P7o1JiWQR01uO+wBiMM/9HiCPM6SAMQx
         d2a2Sz0T524tVIKdzfkdECmzkPJH8aXQXrXRWCyPKVJHg489kISeCmxjam/lwp9uY3TL
         eupQy8+iv/QTL3N+W5Rklt4NRIJ/YA5TCnZRDnOfKJw5G4UK28mGTOs/faVfewTqkG2c
         Oztw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WrF836BhqYoAAQYNFMJen23eOl+F6zz51fEhzRe3ck4=;
        b=6GYxj8c4efxyDZuscsY6CuorXXB84ETMOEBLdVV1kEfn5THX4LIApMSmxSldSNHzCL
         jcDl5nRr7TtdklXetfpymE9/Q8hTBz3/Wj6/FoBI2asWQCRpgVQyJc8Naa6jbnfyQ6q6
         S6VYnJkRkciARry/XywJCwX+ZA0YPSGguv6XRPwm/24zKwUwbzP9AR+oSbT+tpZMr7lo
         YwNJXVZbhqxqxPKhCjOttyEScMvqJnFJ99z5bHduf147yh7JcGZrwuYZnWoXh7V4vRic
         09o71ybsIq4PwuYHyt6RVDOgkCZWAR3DQMZsbt/fZpiyYepFes8+Nek3fZ7dwhrrDLWX
         udCg==
X-Gm-Message-State: AJIora8EZIxG179JGHE+y54cQzOYOGZZU7sdFmx8xeRM5pqQho6YwGRW
        ItLWJHvCGzUjaaXeq9E99Z8=
X-Google-Smtp-Source: AGRyM1vRDq5qAc7St9qdLuZS57haehWUHZEdEiVLV8l2rTbRMydreLZ77f4O354sxk37OOZMcG9tJw==
X-Received: by 2002:a17:90b:4c4c:b0:1e8:6f9a:b642 with SMTP id np12-20020a17090b4c4c00b001e86f9ab642mr11434299pjb.21.1655314177666;
        Wed, 15 Jun 2022 10:29:37 -0700 (PDT)
Received: from localhost.localdomain (c-67-174-241-145.hsd1.ca.comcast.net. [67.174.241.145])
        by smtp.gmail.com with ESMTPSA id w14-20020a1709029a8e00b001676f87473fsm9552244plp.302.2022.06.15.10.29.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 10:29:37 -0700 (PDT)
From:   Yang Shi <shy828301@gmail.com>
To:     vbabka@suse.cz, kirill.shutemov@linux.intel.com,
        willy@infradead.org, zokeefe@google.com, linmiaohe@huawei.com,
        akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [v4 PATCH 3/7] mm: khugepaged: better comments for anon vma check in hugepage_vma_revalidate
Date:   Wed, 15 Jun 2022 10:29:22 -0700
Message-Id: <20220615172926.546974-4-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20220615172926.546974-1-shy828301@gmail.com>
References: <20220615172926.546974-1-shy828301@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hugepage_vma_revalidate() needs to check if the vma is still
anonymous vma or not since the address may be unmapped then remapped to
file before khugepaged reaquired the mmap_lock.

The old comment is not quite helpful, elaborate this with better
comment.

Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 mm/khugepaged.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index db0b334a7d1f..5baa394e34c8 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -960,7 +960,13 @@ static int hugepage_vma_revalidate(struct mm_struct *mm, unsigned long address,
 		return SCAN_ADDRESS_RANGE;
 	if (!hugepage_vma_check(vma, vma->vm_flags))
 		return SCAN_VMA_CHECK;
-	/* Anon VMA expected */
+	/*
+	 * Anon VMA expected, the address may be unmapped then
+	 * remapped to file after khugepaged reaquired the mmap_lock.
+	 *
+	 * hugepage_vma_check may return true for qualified file
+	 * vmas.
+	 */
 	if (!vma->anon_vma || !vma_is_anonymous(vma))
 		return SCAN_VMA_CHECK;
 	return 0;
-- 
2.26.3

