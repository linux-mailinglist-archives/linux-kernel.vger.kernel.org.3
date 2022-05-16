Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48AAB5284BC
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 14:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243475AbiEPMyj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 08:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243584AbiEPMyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 08:54:20 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8185C3A1B3
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 05:53:47 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id p5-20020a1c2905000000b003970dd5404dso920277wmp.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 05:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0Z8unS+I3KC7HgCSi3Sa8z96pMNRd1BvZvnwNMD3WTs=;
        b=A3Dlgex7+DnOnYZLaF9FBzoiuQTihhx3vEfDIIJp3ykd3bn66AKO/ul3Gml8GQK9jh
         f3hwwjHkZCiJ9DgKTkGT62t+28fyu4fPeH6rpjIS14P866udo2QEa/nNiX3bv362z4Bl
         rpJU+Bj6Cff+nP2ncVPO9oJ0cnBIsdpRo4ftBVxKQfEBRJFiWMtRksBNCkEDEZkQczGR
         WvnhZx97jd08S63rv/lP1ZWpwI8Mt8hiY5Uqjse+zT5wigM7wz3Athcrzf2qZgpS8z3H
         uysUaWSpR4Co9Q6TEPdesUrO5VMOoIu23/e7zZZGR04IZ88yHXaeQq1cL7Oqi10OAYTH
         IeVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0Z8unS+I3KC7HgCSi3Sa8z96pMNRd1BvZvnwNMD3WTs=;
        b=xxoMCr6Uj09NlDq+kSU6VrH8B26Z5wcJbyWMU6aCS6RgCYQSbv9svHYMELm944cNsQ
         oglKkyo9lOxOtjnBh0izqt3Bo7PEjpSyo6embL9X9yRN97KG7qy+SJ2A8u1p7by3ecLz
         iiWLjo2/RPDuJ8gysKUsJ7c5a6FE6KvZwtSN/r5bpadMluDihGRI5idyKse6xQUwUwQv
         m6tUk6res+0YUKfELCh+66fycET6x//xW7g1vPeVKq0ksMwYowyfU81t6oMVs8IxHl8p
         MdWn1s2CeIyoeo622FoQYE8MsgSYtFyW9johqJWO5tKKVSaxPI72Z5A/hsADsuAHXqCu
         GLkw==
X-Gm-Message-State: AOAM532MP/yYsffyAPlEGz02N/ncdo3EhvzMTBFSU+VvzR7hqg5U+5D6
        vGDylIkKfEzzwBcJNz0da5ZZ1M57Y/X3xbU/
X-Google-Smtp-Source: ABdhPJzV07JC9Mg9zVfcWX1VUOyPfRogVK8bD1F7lIrfsaUsrqugDWj/POWQV+HHzB0bOOI1Q6XAQg==
X-Received: by 2002:a05:600c:1da5:b0:395:baf7:ca4c with SMTP id p37-20020a05600c1da500b00395baf7ca4cmr16782305wms.99.1652705625778;
        Mon, 16 May 2022 05:53:45 -0700 (PDT)
Received: from orion.localdomain ([93.99.228.15])
        by smtp.gmail.com with ESMTPSA id p15-20020a7bcdef000000b00394517e7d98sm10372100wmj.25.2022.05.16.05.53.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 05:53:45 -0700 (PDT)
Received: by orion.localdomain (Postfix, from userid 1003)
        id 8F349A0E77; Mon, 16 May 2022 14:54:07 +0200 (CEST)
From:   =?UTF-8?q?Jakub=20Mat=C4=9Bna?= <matenajakub@gmail.com>
To:     linux-mm@kvack.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        vbabka@suse.cz, mhocko@kernel.org, mgorman@techsingularity.net,
        willy@infradead.org, liam.howlett@oracle.com, hughd@google.com,
        kirill@shutemov.name, riel@surriel.com, rostedt@goodmis.org,
        peterz@infradead.org, david@redhat.com,
        =?UTF-8?q?Jakub=20Mat=C4=9Bna?= <matenajakub@gmail.com>
Subject: [RFC PATCH v3 2/6] [PATCH 2/6] mm: add merging after mremap resize
Date:   Mon, 16 May 2022 14:54:01 +0200
Message-Id: <20220516125405.1675-3-matenajakub@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220516125405.1675-1-matenajakub@gmail.com>
References: <20220516125405.1675-1-matenajakub@gmail.com>
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
 mm/mremap.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index 303d3290b938..75cda854ec58 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -9,6 +9,7 @@
  */
 
 #include <linux/mm.h>
+#include <linux/mm_inline.h>
 #include <linux/hugetlb.h>
 #include <linux/shm.h>
 #include <linux/ksm.h>
@@ -1022,8 +1023,10 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
 				}
 			}
 
-			if (vma_adjust(vma, vma->vm_start, addr + new_len,
-				       vma->vm_pgoff, NULL)) {
+			if (!vma_merge(mm, vma, addr + old_len, addr + new_len,
+					vma->vm_flags, vma->anon_vma, vma->vm_file,
+					vma->vm_pgoff + (old_len >> PAGE_SHIFT), vma_policy(vma),
+					vma->vm_userfaultfd_ctx, anon_vma_name(vma))) {
 				vm_unacct_memory(pages);
 				ret = -ENOMEM;
 				goto out;
-- 
2.35.1

