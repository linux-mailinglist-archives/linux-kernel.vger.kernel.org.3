Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E3014B0DA1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 13:38:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241617AbiBJMhh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 07:37:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241614AbiBJMhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 07:37:33 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2CB825FB
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 04:37:34 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id h14-20020a17090a130e00b001b88991a305so8352458pja.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 04:37:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kCvGgcRI4BCb4bo+PLBmo+rPOq2UtF9zlalPG6igjOk=;
        b=nk3w1/O8ruce/KxIcFhyUO1pVaNj82bb2o0RtC+Eqn+gFpTDRTDEEO+SUjkKii+bMA
         6/XUIHV6zMhbdvk0KD8AaMfYxOjdrDE/7BPf2Z1eS3SWvotZrlr+0FHt9//kPbH5xExr
         QBMsk7iVC+lbtURShOMph5ee0edzKKy8tr0ltF1A0FHWFQrbjSd6iU3q6WGP9e8BVY17
         9SsD6HPxj3Z6fmn3OcjrV8uLz3kbddDZFxPxIcLS9FKpC8iZfZiXhVY5IdjLNbA2qjSP
         kyJe8qybWut+rnxiXLz/UUmADHvH367cikWiEbu+7LMtZO3nb/X5hv0TeKzr6J8tdMIc
         UEdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kCvGgcRI4BCb4bo+PLBmo+rPOq2UtF9zlalPG6igjOk=;
        b=hSgO4ZRHOdT+o4wIDSZD1PBFnb6iGSytkz0+khDFZ/piI3lekmkj8aoLtkyZ9LteeG
         QN8NBgqSZnOQiurdirscRqm2K9Y3HmiUUo0gGR3X8Mlo+iX70J3aTiT3h5aDVrsJ+gQZ
         9ERyx7RthboDHzhsuLrMgc+qpYcfLup09MmTicA25EjMX0vczLx5Ids4Om0x7EVP00SK
         yM4ikJY/h9vgwHlRP4qA9jwUM1ZzXggAU5csolFwzoz51YKOgNtsUNSDUM3rKe1jdH1t
         db4cLM0uJ+A11Qlft/Sx1L5n/zNAUsHwHqkkBKVSSm9ZkK871LSLY4LxqwoEOGCAtal1
         DQIw==
X-Gm-Message-State: AOAM533+dKXSV04ehEKaLQRwUQHqN/4VNo02u6fTdeme6hV/d4Hgb/ha
        8RcSSvcAiWd3f9WWSlW/jV/bgg==
X-Google-Smtp-Source: ABdhPJydgYDL68pV4tg6C9n6s9P9xqUtx6BfUfSjlx18xcMF5d9QufoEkJRRr1Q5wwnwW+Wqm5H7Zw==
X-Received: by 2002:a17:902:e743:: with SMTP id p3mr1888043plf.152.1644496654350;
        Thu, 10 Feb 2022 04:37:34 -0800 (PST)
Received: from FVFYT0MHHV2J.tiktokcdn.com ([139.177.225.237])
        by smtp.gmail.com with ESMTPSA id i8sm11767812pgf.94.2022.02.10.04.37.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 04:37:34 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     akpm@linux-foundation.org, zi.yan@cs.rutgers.edu,
        kirill.shutemov@linux.intel.com, rientjes@google.com,
        lars.persson@axis.com, mike.kravetz@oracle.com, ziy@nvidia.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v5 3/7] mm: hugetlb: fix missing cache flush in copy_huge_page_from_user()
Date:   Thu, 10 Feb 2022 20:30:54 +0800
Message-Id: <20220210123058.79206-4-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20220210123058.79206-1-songmuchun@bytedance.com>
References: <20220210123058.79206-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The userfaultfd calls copy_huge_page_from_user() which does not do
any cache flushing for the target page.  Then the target page will
be mapped to the user space with a different address (user address),
which might have an alias issue with the kernel address used to copy
the data from the user to.  Fix this issue by flushing dcache in
copy_huge_page_from_user().

Fixes: fa4d75c1de13 ("userfaultfd: hugetlbfs: add copy_huge_page_from_user for hugetlb userfaultfd support")
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/memory.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/memory.c b/mm/memory.c
index e8ce066be5f2..eb027da68aa7 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5405,6 +5405,8 @@ long copy_huge_page_from_user(struct page *dst_page,
 		if (rc)
 			break;
 
+		flush_dcache_page(subpage);
+
 		cond_resched();
 	}
 	return ret_val;
-- 
2.11.0

