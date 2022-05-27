Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA0BF536867
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 23:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354727AbiE0VQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 17:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354707AbiE0VQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 17:16:43 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5FF1EE20
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 14:16:42 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id w27so171930edl.7
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 14:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i6lPNcDzycIov1mSkrT1DuTIerHURYERHQ0SJ25h8ww=;
        b=SoBDYj9niVpCHTx5kJvkoGyZ8mBE7SuG/84fscSrduUQp5/ePxiInmUat6IaNSgsWR
         ga004ByY6lw6IyWbt1dkH46Wj6IaADkMP3e5Gr3o/YxGu7aLpNsUSeMImlSmPOV5JL9b
         MYZK/V+iUSyuYcIK8JFWFYdacOEe5yZ7LExyb91R0DRWdJAnW9ujXjGT1dN84xF1og+d
         vUZDh5DE6ZhFqolekBXBC9iauZdKhFOKYHdJ9unGcfGmEMYt/yuM1k4r8H/RDsTUx7AN
         isJw5LmdbEKVHxH2uzfveIU92LLMo+YNrBVdUuMQA4ivCIozuBJlQKuiAhEDpc4eXWyg
         xFtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i6lPNcDzycIov1mSkrT1DuTIerHURYERHQ0SJ25h8ww=;
        b=6v3Ewk0j6cd1ryPcLWWqdXCWkvCtWC1PWZ8lXFUH3Hc1y6siAi58f26R+zTaULaV4Q
         cfrMsjxkNEHumMKbCVlIu29VKAMAWlcABK0li6xnFXX4LIT95nOifLWO3PKoiXiXHSYB
         vRCeID3YfuqO465SF5+0axalzY8/ZlJeUcIMDclL5ZDf2T+87wT5LBpEvLhqwv1EcvO5
         cBV64AxVBAQIMWELop67yK+Cuz3uZD9octusn9rfUh3F+F9caeLAR01MBuFOm1vYeKlt
         lz9wgTuVcFVlh7C2fJcp15jQ/ljlYTmJD35UCxvSOofna8c0jhLHmG7obg0SjsiLmKhi
         FPPw==
X-Gm-Message-State: AOAM5301bJVlhPqYc9zS3SExV3M9x1OKBzTw3qRMs6hXFZs60uPMka20
        jGTllXAtIhm2Cjjiuy6yAjA=
X-Google-Smtp-Source: ABdhPJxFAs7eRYdqOiXTG1ydQhgXTOtFZa6dkQhVCr12wsO14FNnGTH7jFVGtNHeUysMTLDZpoIM7Q==
X-Received: by 2002:a05:6402:2071:b0:42b:dfa4:d4e1 with SMTP id bd17-20020a056402207100b0042bdfa4d4e1mr8968698edb.70.1653686201430;
        Fri, 27 May 2022 14:16:41 -0700 (PDT)
Received: from orion.localdomain ([93.99.228.15])
        by smtp.gmail.com with ESMTPSA id o8-20020a1709064f8800b006f3ef214e70sm1746739eju.214.2022.05.27.14.16.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 May 2022 14:16:40 -0700 (PDT)
Received: by orion.localdomain (Postfix, from userid 1003)
        id 14EF4A0019; Fri, 27 May 2022 23:17:10 +0200 (CEST)
From:   =?UTF-8?q?Jakub=20Mat=C4=9Bna?= <matenajakub@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, vbabka@suse.cz, mhocko@kernel.org,
        mgorman@techsingularity.net, willy@infradead.org,
        liam.howlett@oracle.com, hughd@google.com, kirill@shutemov.name,
        riel@surriel.com, rostedt@goodmis.org, peterz@infradead.org,
        =?UTF-8?q?Jakub=20Mat=C4=9Bna?= <matenajakub@gmail.com>
Subject: [PATCH v2 2/2] [PATCH 2/2] mm: add merging after mremap resize
Date:   Fri, 27 May 2022 23:17:08 +0200
Message-Id: <20220527211708.839033-3-matenajakub@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220527211708.839033-1-matenajakub@gmail.com>
References: <20220527211708.839033-1-matenajakub@gmail.com>
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

When mremap call results in expansion, it might be possible to merge the
VMA with the next VMA which might become adjacent. This patch adds
vma_merge call after the expansion is done to try and merge.

Signed-off-by: Jakub Matěna <matenajakub@gmail.com>
---
 mm/mremap.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index 303d3290b938..21dfa15e8200 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -9,6 +9,7 @@
  */
 
 #include <linux/mm.h>
+#include <linux/mm_inline.h>
 #include <linux/hugetlb.h>
 #include <linux/shm.h>
 #include <linux/ksm.h>
@@ -23,6 +24,7 @@
 #include <linux/mmu_notifier.h>
 #include <linux/uaccess.h>
 #include <linux/userfaultfd_k.h>
+#include <linux/mempolicy.h>
 
 #include <asm/cacheflush.h>
 #include <asm/tlb.h>
@@ -1022,8 +1024,11 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
 				}
 			}
 
-			if (vma_adjust(vma, vma->vm_start, addr + new_len,
-				       vma->vm_pgoff, NULL)) {
+			vma = vma_merge(mm, vma, addr + old_len, addr + new_len,
+					vma->vm_flags, vma->anon_vma, vma->vm_file,
+					vma->vm_pgoff + (old_len >> PAGE_SHIFT), vma_policy(vma),
+					vma->vm_userfaultfd_ctx, anon_vma_name(vma));
+			if (!vma) {
 				vm_unacct_memory(pages);
 				ret = -ENOMEM;
 				goto out;
-- 
2.35.1

