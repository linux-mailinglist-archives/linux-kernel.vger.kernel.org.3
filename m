Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F27453507D
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 16:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240546AbiEZOVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 10:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237395AbiEZOVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 10:21:08 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D4F0C5D84
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 07:21:07 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id t144so2263985oie.7
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 07:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MM+qtxGKz879mNqzitALSbMhlKfSORq1ZqH2jijHCJg=;
        b=GaKufx2mI5nXjXtfZt8EMuYuPpNxKih/+2Hxq0kSszmQDMtopaf46iw4BDxPGrsXjf
         I2OKjZGnBi7P4Tp5M2A4oOP6W9J+107aFDjY2JvecinWMStU1NGG0B2hFPpKVMHrwNHm
         jQMIVeKZtabmkemyKyCzklGP11iX2KSGWxWwDFpY5Yx4DsXhgoDvC0UsOULYeLvKuRWZ
         odAe/+gGXFlt5xbzeq9dV4F7GNxCNAz1tKnc97aP4immka0IDbqIUziSCCiBbql6dR2D
         m4tHpxX+48qMLD/LlYDxBeoVFrZkFN8p74wBVn0ULMAJWujoSFxK0wAZqyDXkwGtT9Nl
         oEaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MM+qtxGKz879mNqzitALSbMhlKfSORq1ZqH2jijHCJg=;
        b=h3Km77t7ldtyX/uSHiTPoIzjMytX+9RK0leA4A94AndZjYGpmUJHBwALIdSUvO03vT
         6mImKUN8WEXPFW0L9+GwC2rt8DSpl9sKEgIymvpJPwpeLKeJSATy3tAr4ghf5Z6aYnox
         zWJvX9u48McS4a5Uu23gzC/aDNDYgvbvZzCls26u8FevmlB5CZrC5FWf4lpQZDs42bYc
         GPBnRmvUlcmuBy5in61tBEGBZjGjixVUngijnTOQYD4sURcvXo9wyszdw0QcOVoTowAT
         z9sO+RoyL0SknASv7x9csCcDs9NCj8Kw6VXfPDeq8/Nm/6h9qQVVaypGLkrccPAzjz3C
         BQOw==
X-Gm-Message-State: AOAM531oNLN6t98BVQYqFD4zGkSX8zxWaBM7JzT8jLZYmFe8uYWt6HCX
        evG4QoHDq02dM2rqT4PIOMOTVMoyNkCPOUYphlw=
X-Google-Smtp-Source: ABdhPJyn9uuDHhEo5vOjMv8yt6YVeBekri1NhzBK00Fk3NrSBAJ81qW/8Dvyi9AgHogROUtMsqofNQ==
X-Received: by 2002:a05:6808:230a:b0:32b:aeac:84db with SMTP id bn10-20020a056808230a00b0032baeac84dbmr1253318oib.167.1653574866935;
        Thu, 26 May 2022 07:21:06 -0700 (PDT)
Received: from localhost ([199.180.249.178])
        by smtp.gmail.com with ESMTPSA id t15-20020a9d590f000000b0060603221280sm617402oth.80.2022.05.26.07.21.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 07:21:06 -0700 (PDT)
From:   bh1scw@gmail.com
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>,
        Fanjun Kong <bh1scw@gmail.com>
Subject: [PATCH] x86/mm: use PAGE_ALIGNED instead of IS_ALIGNED
Date:   Thu, 26 May 2022 22:20:39 +0800
Message-Id: <20220526142038.1582839-1-bh1scw@gmail.com>
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

From: Fanjun Kong <bh1scw@gmail.com>

The <linux/mm.h> already provides the PAGE_ALIGNED macro. Let's
use this macro instead of IS_ALIGNED and passing PAGE_SIZE directly.

Signed-off-by: Fanjun Kong <bh1scw@gmail.com>
---
 arch/x86/mm/init_64.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index cb290a2f0747..39c5246964a9 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -1240,8 +1240,8 @@ remove_pagetable(unsigned long start, unsigned long end, bool direct,
 void __ref vmemmap_free(unsigned long start, unsigned long end,
 		struct vmem_altmap *altmap)
 {
-	VM_BUG_ON(!IS_ALIGNED(start, PAGE_SIZE));
-	VM_BUG_ON(!IS_ALIGNED(end, PAGE_SIZE));
+	VM_BUG_ON(!PAGE_ALIGNED(start));
+	VM_BUG_ON(!PAGE_ALIGNED(end));
 
 	remove_pagetable(start, end, false, altmap);
 }
@@ -1605,8 +1605,8 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
 {
 	int err;
 
-	VM_BUG_ON(!IS_ALIGNED(start, PAGE_SIZE));
-	VM_BUG_ON(!IS_ALIGNED(end, PAGE_SIZE));
+	VM_BUG_ON(!PAGE_ALIGNED(start));
+	VM_BUG_ON(!PAGE_ALIGNED(end));
 
 	if (end - start < PAGES_PER_SECTION * sizeof(struct page))
 		err = vmemmap_populate_basepages(start, end, node, NULL);
-- 
2.36.0

