Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A3D0514903
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 14:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358998AbiD2MWC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 08:22:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238748AbiD2MV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 08:21:57 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29991B3C75
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 05:18:39 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id s137so6389971pgs.5
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 05:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Sb7cKusP7HmwEMFLljkRCnuPfmcRLCQDQWff8XX78N4=;
        b=ujf++oGTRkcmvgbJDzD35LqcmXlDmxx9MV7JBsCDJlobs2RrJt7Oin3Tp6YJWZSb4v
         9pD3a81OGs+Rvr9bhGzIguAqbwWgBnZtv6XULJJozikDR56kziPLN1jhnHZTf/HusSzV
         w63qNhi0UKdgf6Q9Fq+cz+V4qw1+H3gfd1FB5CgYLwAD7FKIg+U2A3PKdV62na10dGaP
         uHFViPBg8CIa2xG7vAItmaI0KXTl/Td/1o3ipN73lzlFryjc/F+CyUtsT9v0X6W/1RuW
         a9MOjWqpYGACasXXh7MNQMe9KERCZSJqchBd9Dvm3EvJmQbv8dV4Tg9o5hNkY+lx9T2W
         j4pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Sb7cKusP7HmwEMFLljkRCnuPfmcRLCQDQWff8XX78N4=;
        b=04nGiA+4o4uFBppZ9G/9weE+ZvaJDkgMmMBiiEqGX+fODmFQX02iwiwFFWacm7m5iK
         JlnlThA+F+puUE6BpoVqpSa2QfgqC2mI8261JHL4s/+eH+XojfQCbHVBuLf2tBXKD89r
         mNZhuxch4Isz50CaaoObW7s2UCBPHrN5MGMmSR0hlO8Bdgs94BKfPV1/wHN0oSDt1jpL
         TBV6cGymkTJ9szGE6BO9v7PXvoyW6L2WVSmUY1DBS5726KAPkLnSJK8LLjiVO4rOPpm7
         1D56MF4LPijRGbCYPfcU/H+5G90WOtfKfYWaykA3pn9Mzw6L62ZndPjMDRPwOXYxHq7c
         h4kA==
X-Gm-Message-State: AOAM532h+aoyt0n0rULoJMTfrgpb2LpsbJ+MyW9FlcE3tPaWTFA5s7s8
        fBtJ/wUdqDhmoqCLg4KdMKN+Fg==
X-Google-Smtp-Source: ABdhPJyV4XCJ1uaJg+Pde1nxM1j4YKLXpIc83hyQsnEeiM1URERFxVgDV1/VvFaifwpneZ3ujEuceg==
X-Received: by 2002:a63:d145:0:b0:3c1:4ba0:d890 with SMTP id c5-20020a63d145000000b003c14ba0d890mr10020401pgj.607.1651234718613;
        Fri, 29 Apr 2022 05:18:38 -0700 (PDT)
Received: from FVFYT0MHHV2J.bytedance.net ([139.177.225.239])
        by smtp.gmail.com with ESMTPSA id k11-20020a056a00168b00b004f7e1555538sm3101421pfc.190.2022.04.29.05.18.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 05:18:38 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     corbet@lwn.net, mike.kravetz@oracle.com, akpm@linux-foundation.org,
        mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com,
        osalvador@suse.de, david@redhat.com, masahiroy@kernel.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, duanxiongchun@bytedance.com, smuchun@gmail.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v9 1/4] mm: hugetlb_vmemmap: disable hugetlb_optimize_vmemmap when struct page crosses page boundaries
Date:   Fri, 29 Apr 2022 20:18:13 +0800
Message-Id: <20220429121816.37541-2-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20220429121816.37541-1-songmuchun@bytedance.com>
References: <20220429121816.37541-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the size of "struct page" is not the power of two but with the feature
of minimizing overhead of struct page associated with each HugeTLB is
enabled, then the vmemmap pages of HugeTLB will be corrupted after
remapping (panic is about to happen in theory).  But this only exists when
!CONFIG_MEMCG && !CONFIG_SLUB on x86_64.  However, it is not a conventional
configuration nowadays.  So it is not a real word issue, just the result
of a code review.

But we cannot prevent anyone from configuring that combined configure.
This hugetlb_optimize_vmemmap should be disable in this case to fix this
issue.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/hugetlb_vmemmap.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 29554c6ef2ae..6254bb2d4ae5 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -28,12 +28,6 @@ EXPORT_SYMBOL(hugetlb_optimize_vmemmap_key);
 
 static int __init hugetlb_vmemmap_early_param(char *buf)
 {
-	/* We cannot optimize if a "struct page" crosses page boundaries. */
-	if (!is_power_of_2(sizeof(struct page))) {
-		pr_warn("cannot free vmemmap pages because \"struct page\" crosses page boundaries\n");
-		return 0;
-	}
-
 	if (!buf)
 		return -EINVAL;
 
@@ -119,6 +113,12 @@ void __init hugetlb_vmemmap_init(struct hstate *h)
 	if (!hugetlb_optimize_vmemmap_enabled())
 		return;
 
+	if (!is_power_of_2(sizeof(struct page))) {
+		pr_warn_once("cannot optimize vmemmap pages because \"struct page\" crosses page boundaries\n");
+		static_branch_disable(&hugetlb_optimize_vmemmap_key);
+		return;
+	}
+
 	vmemmap_pages = (nr_pages * sizeof(struct page)) >> PAGE_SHIFT;
 	/*
 	 * The head page is not to be freed to buddy allocator, the other tail
-- 
2.11.0

