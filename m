Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F2B655C395
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344237AbiF1JYv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 05:24:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344184AbiF1JYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 05:24:16 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8103227FF8
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 02:24:11 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id r66so11648526pgr.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 02:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tKsl/FyBMuyoLwv1dbdkul0HUkyTRTbta9GTd/qg648=;
        b=kmlXP3rmTBXz5+4TJo//hmT2jB4MxmfWPs8iGQkHOlQBg+rsoPITThmujE5oZlqSyG
         fWu7CtFdyuxFIJPn+ajdlR9dCr4S51oy4WvnwewRQZdfq7E+j0mQSwzwRjSgIvguexqG
         fk3Qt+5y38+wp9WNkk+LMSBP0nc8nXemI+xT/4laLfvG8cccB66V1pbT2qVRKK9w1/7z
         UOZnxF6q0kGOYIWB/RFeprJs1fGdcR+PEaOaKE3JNBOyceQycTM2BgCSUGxmZLe99u1C
         xX95JGCPjlHlauI6BtduVriW4yYgE9uvq9xJq+thJNgUvkPEcXuFCutJkJYjKCnMEGKi
         LBKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tKsl/FyBMuyoLwv1dbdkul0HUkyTRTbta9GTd/qg648=;
        b=iWgwWiT9CF5DU7dMuZve8Z75K49m0vmDrPzmxwJLUGOFZ7xDI9FsFtrKxlKs7BCjXe
         gqkhNXXiRAavRer8U4WI4PXMOLeEmINiWg7SCNbugLCWgM+/VC/wxO2++0pjQsgqSCm9
         kYKADxXzXfdLmK61cepjkxPfrtAXuUtJcvf0MW2V0qiUNx1npFhiKtVpwBNjCnEbbi+K
         ssNLU8tXVjamMwUnCCNFuw0SD07N1NLLn+KCtBO3conL0Cg1no94QAka6wjuIbO8pGGJ
         ChLl88fAismrdqRKpRRmr0K5cSgmxh+x9akNzNEyAklVE28/Br7wonJSNC/ok3uBCJJE
         GvWA==
X-Gm-Message-State: AJIora84oWEoyF/zFC9ePsBWXYHnzZPQtNqRNGXXLo2ZKLtA/cxcnLLv
        RK04+1PIba8/hKDvYrrAINfa6Q==
X-Google-Smtp-Source: AGRyM1tM8i7pH8lTHkass0ZEXT2Z2SMP+f0quLdvC0M1TlAQly/dZen+wWI1RJzBbMXck8L6xsm+yg==
X-Received: by 2002:a63:a748:0:b0:40c:9a36:ff9a with SMTP id w8-20020a63a748000000b0040c9a36ff9amr16326337pgo.545.1656408251045;
        Tue, 28 Jun 2022 02:24:11 -0700 (PDT)
Received: from FVFYT0MHHV2J.bytedance.net ([139.177.225.245])
        by smtp.gmail.com with ESMTPSA id mm9-20020a17090b358900b001ec729d4f08sm8780463pjb.54.2022.06.28.02.24.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 02:24:10 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     mike.kravetz@oracle.com, david@redhat.com,
        akpm@linux-foundation.org, corbet@lwn.net
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, duanxiongchun@bytedance.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v2 5/8] mm: hugetlb_vmemmap: replace early_param() with core_param()
Date:   Tue, 28 Jun 2022 17:22:32 +0800
Message-Id: <20220628092235.91270-6-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.1 (Apple Git-133)
In-Reply-To: <20220628092235.91270-1-songmuchun@bytedance.com>
References: <20220628092235.91270-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After the following commit:

  78f39084b41d ("mm: hugetlb_vmemmap: add hugetlb_optimize_vmemmap sysctl")

There is no order requirement between the parameter of "hugetlb_free_vmemmap"
and "hugepages" since we have removed the check of whether HVO is enabled
from hugetlb_vmemmap_init(). Therefore we can safely replace early_param()
with core_param() to simplify the code.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/hugetlb_vmemmap.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 4d404d10c682..b55be6d93f92 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -423,14 +423,8 @@ static int vmemmap_remap_alloc(unsigned long start, unsigned long end,
 DEFINE_STATIC_KEY_FALSE(hugetlb_optimize_vmemmap_key);
 EXPORT_SYMBOL(hugetlb_optimize_vmemmap_key);
 
-static bool vmemmap_optimize_enabled =
-	IS_ENABLED(CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON);
-
-static int __init hugetlb_vmemmap_early_param(char *buf)
-{
-	return kstrtobool(buf, &vmemmap_optimize_enabled);
-}
-early_param("hugetlb_free_vmemmap", hugetlb_vmemmap_early_param);
+static bool vmemmap_optimize_enabled = IS_ENABLED(CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON);
+core_param(hugetlb_free_vmemmap, vmemmap_optimize_enabled, bool, 0);
 
 /*
  * Previously discarded vmemmap pages will be allocated and remapping
-- 
2.11.0

