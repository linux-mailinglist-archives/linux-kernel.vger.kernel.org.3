Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ABD35A3625
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 11:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233223AbiH0JDm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 05:03:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233786AbiH0JDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 05:03:17 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E423227FD0
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 02:03:16 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id f4so3430508pgc.12
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 02:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc;
        bh=d1f8nUkF5t5cqSm1uy6aZjuA2/Q1MZyp0rZYnQGPqp0=;
        b=ADjlqlLIinapEBKNHJvPolEuOZOLX5jS2yCniDir0S71XSJNsvfMC3q6GUuAFzuJqR
         8vplwGxKNX2EsG9DemkIS31tmJaa8urq6d9dQPAoSQfovgGR1RKD8BYEryyzG3AJG/dm
         nG1Hy5RBSbbVJIPOfm9dxB1H/nLD7X0PGfE6nOpZntMCl/OIiy7dvNBflhCnnZlgjQIV
         nuh2nT0+/QE5gOvY/YEECvTlajluTepx43UDivJKpw+BuV2uonfE7Mlc/mAfNIDC7vo4
         SIX0MT+I90XyCiC1VW+mvtuFzDkQDeFK68kD3JdlI5G8HPDdUtlklTfqy/k+gVgiUb7A
         Ut/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc;
        bh=d1f8nUkF5t5cqSm1uy6aZjuA2/Q1MZyp0rZYnQGPqp0=;
        b=3D6k7aHzsYJ/be8G7DSgCSAq7EFSIiQcUkNJDiElzc2N50ZsrI7wublLVLszEGYkLe
         J21+mz+bUUEMIDZHOgQYxMrKzg5+VSOHGnOFWAHVMc4HA/DvsoUKZx9P829t9KD7+kyR
         eMZ+r6gb9pt6xVmc2pzovaKH5ko+TBH7m1cFToS/h0U3znkDE14QQEnwLf0etFVNKKgx
         41lA6xkDjeKGEELpK+R20FmFd3QUeghC7lPS5MKyuru0CEJL/ybmexomWjWOcYHsEOmA
         whZQknWOGsCWKPPMyqm0yLcpi95oKstufq0zVXyoWiGzOkN25uhyzyUHk39fFnfel4r8
         gCXQ==
X-Gm-Message-State: ACgBeo0mj0VNBrHvgtWsqZlNUpqqtCCKrLzPtYYESIApJ6VMrOHbsFP5
        sjbH/IN/5KYQCUFcCqW4gvpJNGd4K5VL
X-Google-Smtp-Source: AA6agR5q+qB4j7NKYCCupMsiap0S5orWPGACxAjLmCltEPdsahEoARsCXsq2ScHJmpUnXiH+R4HNCg==
X-Received: by 2002:a63:5d4e:0:b0:41d:dcc3:aa85 with SMTP id o14-20020a635d4e000000b0041ddcc3aa85mr6342951pgm.324.1661590995694;
        Sat, 27 Aug 2022 02:03:15 -0700 (PDT)
Received: from localhost.localdomain ([43.132.141.8])
        by smtp.gmail.com with ESMTPSA id s88-20020a17090a69e100b001fb09316a26sm2943332pjj.43.2022.08.27.02.03.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Aug 2022 02:03:14 -0700 (PDT)
From:   xiakaixu1987@gmail.com
X-Google-Original-From: kaixuxia@tencent.com
To:     sj@kernel.org, akpm@linux-foundation.org
Cc:     damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Kaixu Xia <kaixuxia@tencent.com>
Subject: [PATCH v2 1/2] mm/damon: simplify the parameter passing for 'check_accesses'
Date:   Sat, 27 Aug 2022 17:02:50 +0800
Message-Id: <1661590971-20893-2-git-send-email-kaixuxia@tencent.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1661590971-20893-1-git-send-email-kaixuxia@tencent.com>
References: <1661590971-20893-1-git-send-email-kaixuxia@tencent.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kaixu Xia <kaixuxia@tencent.com>

The parameter 'struct damon_ctx *ctx' isn't used in the functions
__damon_{p,v}a_check_access(), so we can remove it and simplify the
parameter passing.

Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>
---
 mm/damon/paddr.c | 5 ++---
 mm/damon/vaddr.c | 6 +++---
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index dc131c6a5403..6b0d9e6aa677 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -166,8 +166,7 @@ static bool damon_pa_young(unsigned long paddr, unsigned long *page_sz)
 	return result.accessed;
 }
 
-static void __damon_pa_check_access(struct damon_ctx *ctx,
-				    struct damon_region *r)
+static void __damon_pa_check_access(struct damon_region *r)
 {
 	static unsigned long last_addr;
 	static unsigned long last_page_sz = PAGE_SIZE;
@@ -196,7 +195,7 @@ static unsigned int damon_pa_check_accesses(struct damon_ctx *ctx)
 
 	damon_for_each_target(t, ctx) {
 		damon_for_each_region(r, t) {
-			__damon_pa_check_access(ctx, r);
+			__damon_pa_check_access(r);
 			max_nr_accesses = max(r->nr_accesses, max_nr_accesses);
 		}
 	}
diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 3c7b9d6dca95..e481f81c3efb 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -532,8 +532,8 @@ static bool damon_va_young(struct mm_struct *mm, unsigned long addr,
  * mm	'mm_struct' for the given virtual address space
  * r	the region to be checked
  */
-static void __damon_va_check_access(struct damon_ctx *ctx,
-			       struct mm_struct *mm, struct damon_region *r)
+static void __damon_va_check_access(struct mm_struct *mm,
+				struct damon_region *r)
 {
 	static struct mm_struct *last_mm;
 	static unsigned long last_addr;
@@ -568,7 +568,7 @@ static unsigned int damon_va_check_accesses(struct damon_ctx *ctx)
 		if (!mm)
 			continue;
 		damon_for_each_region(r, t) {
-			__damon_va_check_access(ctx, mm, r);
+			__damon_va_check_access(mm, r);
 			max_nr_accesses = max(r->nr_accesses, max_nr_accesses);
 		}
 		mmput(mm);
-- 
2.27.0

