Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5C01572B62
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 04:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233998AbiGMClT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 22:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbiGMClS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 22:41:18 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DA37774A0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 19:41:17 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id o31-20020a17090a0a2200b001ef7bd037bbso1394821pjo.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 19:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ug/iYyU8Y2LYfkSANaeOBwHOpsae97E43YefQnjMlgI=;
        b=GuHqHjJoz5lA0Wlh1degTH0DjfZyKQsicqSOdE6pvYhJkdnPCew2bxsrWJQpaS7dFA
         4RqN50W4Jd5IlkR2W319WTv+m9zhQAAxMriFFu4fjDLEL6INd2QEH2XvZC4csPvyPdmN
         w+Epagp0tk29n8uRYUogmpWhCr3TxTbxvq8ZewyyWaYWzs31D/Mzy6O8LRRyMcKCmwsj
         5OMefGEbL9nvgyIUPcg1SbX6hEiAcwVbkTrKq0ADUlEpmk+9SpjO9UtrvFdez1cGThEn
         00/zPbMQ4TWzSyxw3WH4TT1oNoRJyhQU8/1OnZw0/V3DbKTqdpbY3TY0Elg0ghjq5lyp
         K/nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ug/iYyU8Y2LYfkSANaeOBwHOpsae97E43YefQnjMlgI=;
        b=n2gLl3kxxWRXH17CiukjvAFIaWKCHUkz6ApiTA71JZzPmwzGJ1GqYLzse0GT95va3W
         MqrCf9vi3sX/BF7LieNhLauiSH0Y0FmU/KuY7N6YVDH2P33wQZghI7XEJ0TY4TuyNY64
         EtV6+c69bALZkcJ7rC8886t8sv0skd/wHQ4wGPy5uEa7KYm+OiKGL0wIEpGroiJUVKwI
         y9/jLphB8PjGc9GaPAwXF1tX2GiaInaGzp1u1nvYJ/NESCyniPBIPvMjp32loQJ3OAIP
         Kg/J9TKPeBz5oAIOdnIcsLfEy1bO6OIbuvaBZVmzYBP9+0VpAb4LHwNw4UxzqDSWHUKo
         2E7A==
X-Gm-Message-State: AJIora+Xbw6CkMLPUffnex+U1uGQW6xYsJ8nzHrnNzHJm9/e8195Xxd1
        cmIasxVSNHXkQQ4DQV6f3fg=
X-Google-Smtp-Source: AGRyM1uf+07kc+nyIgZjOz7tvF8Xan3hUYQyrAtZn/XW58Uf0z6XPew7fdi78pAG2UjAFAjBdzYrwg==
X-Received: by 2002:a17:902:854a:b0:16b:a3c3:ed8c with SMTP id d10-20020a170902854a00b0016ba3c3ed8cmr1255709plo.167.1657680076962;
        Tue, 12 Jul 2022 19:41:16 -0700 (PDT)
Received: from localhost.localdomain ([122.171.73.195])
        by smtp.gmail.com with ESMTPSA id n30-20020aa7985e000000b00528d41a998csm7724182pfq.15.2022.07.12.19.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 19:41:16 -0700 (PDT)
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Souptick Joarder (HPE)" <jrdr.linux@gmail.com>,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] mm/khugepaged: Avoid possible memory leak in failure path
Date:   Wed, 13 Jul 2022 08:11:09 +0530
Message-Id: <20220713024109.62810-1-jrdr.linux@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
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

From: "Souptick Joarder (HPE)" <jrdr.linux@gmail.com>

smatch warnings:
mm/khugepaged.c:2409 madvise_collapse() warn: possible memory
leak of 'cc'

Avoiding possible memory leak.

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Souptick Joarder (HPE) <jrdr.linux@gmail.com>
---
 mm/khugepaged.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 0207fc0a5b2a..8da9e7467543 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -2397,12 +2397,6 @@ int madvise_collapse(struct vm_area_struct *vma, struct vm_area_struct **prev,
 	BUG_ON(vma->vm_start > start);
 	BUG_ON(vma->vm_end < end);
 
-	cc = kmalloc(sizeof(*cc), GFP_KERNEL);
-	if (!cc)
-		return -ENOMEM;
-	cc->is_khugepaged = false;
-	cc->last_target_node = NUMA_NO_NODE;
-
 	*prev = vma;
 
 	/* TODO: Support file/shmem */
@@ -2415,6 +2409,12 @@ int madvise_collapse(struct vm_area_struct *vma, struct vm_area_struct **prev,
 	if (!hugepage_vma_check(vma, vma->vm_flags, false, false, false))
 		return -EINVAL;
 
+	cc = kmalloc(sizeof(*cc), GFP_KERNEL);
+	if (!cc)
+		return -ENOMEM;
+	cc->is_khugepaged = false;
+	cc->last_target_node = NUMA_NO_NODE;
+
 	mmgrab(mm);
 	lru_add_drain_all();
 
-- 
2.25.1

