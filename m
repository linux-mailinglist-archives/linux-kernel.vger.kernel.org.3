Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC5575A230A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 10:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245622AbiHZIcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 04:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbiHZIb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 04:31:59 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12504B4430
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 01:31:58 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id x14-20020a17090a8a8e00b001fb61a71d99so7407653pjn.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 01:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc;
        bh=ejcX4jVEjPdrkU9dU00T+efoVTYJPy0kG3uinoXmHSo=;
        b=qmSn+U7UOMfTh5bJbldCWYQMzI8jk/xzz6l13VdM0yIJu1bSu8OsRNo2qulPeCCNAE
         Y00MCO5PftrGLKUObBZ/e7EznloXzjELQF0h0VjTIlYi+yLgKcMbBbp2uSsGziQqoJ5U
         DW7IzctU9Lg3yglf2WxCdGP9mXZvjKHwhF7R7lk4xyKZ1T+giTLS6f8ZDlnyhG2fRQIA
         Y0trohdcerSE6/8mrUQ2cFRqMqTBokAtcP0r8rLA6pCqnfWR6R3oJ1ToIjsUYux7coTo
         oP8+1qk4szSRMwEHcYN8CPpOvOuoJlAnh62wTWL+Aa891nAF0k7zVoSKxY6VWVjRynnT
         NZ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc;
        bh=ejcX4jVEjPdrkU9dU00T+efoVTYJPy0kG3uinoXmHSo=;
        b=XMVR15018BJiTf7wiDby+hnLnx9dwG/a4aPkOgNXLJvaodcM6WtGDVLgi0utdNfSqG
         3CVPYe28rA4Pp0ftrtTJSlAtFVKxT3+71OFgz9T/SBI6O+yOOiUrgLKDSQ5Akgj0ZgNU
         x04PWnB3pqugF5Nv2kjvS/NM/hJ3sCzGxnXDnCuc1FfCCGbliaypQvB0Jd+PWuFGmlCV
         ZO91MzEMEqV8gP6Bxw5j9BVRe67majDA4SxSBsOVmqaKg9W/vZGTCp1LsjJNuJSU4swA
         izrJX0dCPoZaT9Az6U6MGDsxdQo2wBHE2UHBakQWc43C63C49aVE1tQ/adRVIg8+SYa8
         UDBg==
X-Gm-Message-State: ACgBeo0+mFgEDBkz3b3/plY49KzhshlmS36Zq7A+xIRqk/hLf2l8uxO9
        nIukUqp0ZK3VuB9I1XffNg==
X-Google-Smtp-Source: AA6agR6IsHxv+NS3WcRPeGsCLiGaj9g0DHrOHdXBhcNVEf8r/Z+LHIF4VAngJkDr1WU/jvOjrx+44Q==
X-Received: by 2002:a17:902:cf43:b0:172:86f3:586a with SMTP id e3-20020a170902cf4300b0017286f3586amr2703089plg.71.1661502717626;
        Fri, 26 Aug 2022 01:31:57 -0700 (PDT)
Received: from localhost.localdomain ([43.132.141.8])
        by smtp.gmail.com with ESMTPSA id u2-20020a170902714200b0016f1ef2cd44sm934953plm.154.2022.08.26.01.31.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Aug 2022 01:31:56 -0700 (PDT)
From:   xiakaixu1987@gmail.com
X-Google-Original-From: kaixuxia@tencent.com
To:     sj@kernel.org, akpm@linux-foundation.org
Cc:     damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Kaixu Xia <kaixuxia@tencent.com>
Subject: [PATCH 1/2] mm/damon: simplify the parameter passing for 'check_accesses'
Date:   Fri, 26 Aug 2022 16:31:17 +0800
Message-Id: <1661502678-19336-2-git-send-email-kaixuxia@tencent.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1661502678-19336-1-git-send-email-kaixuxia@tencent.com>
References: <1661502678-19336-1-git-send-email-kaixuxia@tencent.com>
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

The parameter 'struct damon_ctx *ctx' is unnecessary in damon
'check_accesses' callback operation, so we can remove it.

Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>
---
 mm/damon/paddr.c | 5 ++---
 mm/damon/vaddr.c | 5 ++---
 2 files changed, 4 insertions(+), 6 deletions(-)

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
index 3c7b9d6dca95..c8c2f306bb6d 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -532,8 +532,7 @@ static bool damon_va_young(struct mm_struct *mm, unsigned long addr,
  * mm	'mm_struct' for the given virtual address space
  * r	the region to be checked
  */
-static void __damon_va_check_access(struct damon_ctx *ctx,
-			       struct mm_struct *mm, struct damon_region *r)
+static void __damon_va_check_access(struct mm_struct *mm, struct damon_region *r)
 {
 	static struct mm_struct *last_mm;
 	static unsigned long last_addr;
@@ -568,7 +567,7 @@ static unsigned int damon_va_check_accesses(struct damon_ctx *ctx)
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

