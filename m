Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AA51515579
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 22:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380641AbiD2UZq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 16:25:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380572AbiD2UZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 16:25:42 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEC04A27D9
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 13:22:22 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id b6-20020a253406000000b006484c081280so8368584yba.5
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 13:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=mLZo4rWRmYeOPsqZc8LV+VyHA05NOry17ZGo2E64vgY=;
        b=UbXY0tidHP24IsTejBXuf1oTmpnczNzA42umqngD3FKepeMY53OUU1A4dF3GHPGslE
         uNyeYu04aJ9a9HAFbtJ0VK8fu01Uj5yxPrnJf82S1ebP7y/wjsyUPMPiaqF8vzy5oQKY
         5/zVFP6BESRwuoM/kHNtbeCqx8bTzrN/5PD01E5L8+Hspn/yDaTjzffMXnD1x2kRB6VE
         TkKHj7nGeNO9UBdJ+uuo5vb6ee0jDHgiNncHsTGzqevmxstujYiW2B6R3ZKwVfAcXRV1
         pFgSf3S/P2cJpL3d7+bmfwHbNVl3/RsiLfVTtm3FoMt7vF99R2AtbkQh3SIrjvaZ4p/1
         oPzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=mLZo4rWRmYeOPsqZc8LV+VyHA05NOry17ZGo2E64vgY=;
        b=e8aE4sZhPkUgiU66VQ6bPJx3kr7YeACiA/Ggmp9Ri2MqEdxIs6tkPZjwlcgxm0ELZi
         JrrKsktMPLD8uVOfeCFyshHrzuZRQd4w1L0OLXGozNhztdF0MCZ4XaU35hCvQgjespD+
         mwE8QSMrKY0rfubrDW8fiSJ41PDVAoon+9fSwy77sasgI3BtF9/oPiQt/Nm9s0A1rdDO
         LbLLHtpT6Nubokqdcg8JSYYNAL71F4znhaRpqykoe3AONl6/LrtbXaz9EL6aBBfuoEZ5
         qMjqk4vvkoGL7vNgSfE6R9HowWVVGrMLd/tybkAGLFjLyJj3CXY0V4a8qrzHlItJUVYl
         Qu8g==
X-Gm-Message-State: AOAM5337gD8eZdZ8yTUL7qc94gR5CY3dpzkOPij70B+FlyG/3rSsXKKX
        jWg5kKoWLkrEVd1k9KQ+hNFkHOkq0NhaVrSV2Q==
X-Google-Smtp-Source: ABdhPJwzU+/Sy4engQgcYH8rZhziuNRgIvjPjCG18m1I8hY/SqEHVmaTb3QNRHltsoMtIljV85bXyLsJd5CgOE9jVw==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2cd:202:99d8:b58f:87d2:80f3])
 (user=almasrymina job=sendgmr) by 2002:a25:938d:0:b0:648:c0cd:3339 with SMTP
 id a13-20020a25938d000000b00648c0cd3339mr1220850ybm.336.1651263741916; Fri,
 29 Apr 2022 13:22:21 -0700 (PDT)
Date:   Fri, 29 Apr 2022 13:22:06 -0700
Message-Id: <20220429202207.3045-1-almasrymina@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
Subject: [PATCH v1] hugetlbfs: fix hugetlbfs_statfs() locking
From:   Mina Almasry <almasrymina@google.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Michal Hocko <mhocko@suse.com>
Cc:     Mina Almasry <almasrymina@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After commit db71ef79b59b ("hugetlb: make free_huge_page irq safe"),
the subpool lock should be locked with spin_lock_irq() and all call
sites was modified as such, except for the ones in hugetlbfs_statfs().

Fixes: db71ef79b59b ("hugetlb: make free_huge_page irq safe")
Signed-Off-By: Mina Almasry <almasrymina@google.com>
---
 fs/hugetlbfs/inode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index dd3a088db11d..591599829e2a 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -1048,12 +1048,12 @@ static int hugetlbfs_statfs(struct dentry *dentry, struct kstatfs *buf)
 		if (sbinfo->spool) {
 			long free_pages;

-			spin_lock(&sbinfo->spool->lock);
+			spin_lock_irq(&sbinfo->spool->lock);
 			buf->f_blocks = sbinfo->spool->max_hpages;
 			free_pages = sbinfo->spool->max_hpages
 				- sbinfo->spool->used_hpages;
 			buf->f_bavail = buf->f_bfree = free_pages;
-			spin_unlock(&sbinfo->spool->lock);
+			spin_unlock_irq(&sbinfo->spool->lock);
 			buf->f_files = sbinfo->max_inodes;
 			buf->f_ffree = sbinfo->free_inodes;
 		}
--
2.36.0.464.gb9c8b46e94-goog
