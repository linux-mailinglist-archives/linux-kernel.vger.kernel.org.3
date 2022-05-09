Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA7A951FABF
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 13:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231777AbiEILF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 07:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231643AbiEILFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 07:05:13 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B7C5226880
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 04:01:15 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id n8so13515183plh.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 May 2022 04:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t0KsZv2R4FmOpyzJ37nNuFGF3hEBVQUSZOEw7FIgU2A=;
        b=yjtzA8SItPH7R6S1S+OGpTA8lpujjgtHSpoSwPxtQUypZnh+LhhkrVjtjaxYiSIVAp
         iVo3fIPQGwplTUrHyLZm+y+PW7GyXKOyGCa/Mk5TpRRWgY8ampXvMrn3BYumiT5GRlHB
         BAPwL6edGJN/fGAQUqu92vb6/tAVD3lhNQBVMpBoHpI0a8/1mEJZcCGlQmMGNkMSwbsr
         17l7fH1SLbbetWfYC50CRYmCDeskVHYFWSZYWmXLz1WuvE0MByPEXHTARY5dFhTICCxG
         mR3NVxFDYHIgork84g9o9A8HXp9wLBJY+kZqiVmveHEhPszocewvWXXDYls9OOPHvKg2
         7ZLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t0KsZv2R4FmOpyzJ37nNuFGF3hEBVQUSZOEw7FIgU2A=;
        b=VaVi7y01ySUK0yNenjjGG8biIKinbKbvVQrwF1dbVk1RhRs7NaGoD7MGvEH0lo9Qnd
         LehuExYc8hgAQ5Qwvyde4k1ix9rqkVKjbYhKYnFtGn8u0+Uq2kJ9fUwHLpd9u22/qTvb
         yfTpzGLbfS623jGqVx/NGdO7RozaWQ5sEw5VoshzayEJV0Xuk7S8mfX7HQQoGDy3rlXo
         iuHFQuxzLbziyQq7x4s25yKlDdykmZxwzMn6CkCdbiCI9sr0dg9DqkhBWcGNFRkd3nZY
         zFYOuYzjBY3SucpIfR4flNs3KraHKroxaRA+NyFwfzmFwHpvo07HYPGelZUyy0qEFfHz
         Yxvw==
X-Gm-Message-State: AOAM533zugyPyRByOwGHZ8KuoSV8c0Bn5uJGu+XQuOwWg1JkmL5dkXYd
        ZfYXDuTjXoPiLjF2BwWbpbiWcAqe9X53xg==
X-Google-Smtp-Source: ABdhPJx/WzlB7PylnxnAdFCim/SskrKr0osvOo6sFRdb5OtHidyhPLSUg7ojKRvRf81iZeBPIyd+DQ==
X-Received: by 2002:a17:90a:f2ce:b0:1d9:a18f:87f3 with SMTP id gt14-20020a17090af2ce00b001d9a18f87f3mr25860804pjb.213.1652094074838;
        Mon, 09 May 2022 04:01:14 -0700 (PDT)
Received: from always-x1.www.tendawifi.com ([139.177.225.239])
        by smtp.gmail.com with ESMTPSA id n12-20020a170902968c00b0015e8d4eb244sm6813303plp.142.2022.05.09.04.01.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 04:01:14 -0700 (PDT)
From:   zhenwei pi <pizhenwei@bytedance.com>
To:     akpm@linux-foundation.org, naoya.horiguchi@nec.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        zhenwei pi <pizhenwei@bytedance.com>
Subject: [PATCH v2 5/5] mm/memory-failure.c: simplify num_poisoned_pages_inc/dec
Date:   Mon,  9 May 2022 18:56:41 +0800
Message-Id: <20220509105641.491313-6-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220509105641.491313-1-pizhenwei@bytedance.com>
References: <20220509105641.491313-1-pizhenwei@bytedance.com>
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

Originally, do num_poisoned_pages_inc() in memory failure routine,
use num_poisoned_pages_dec() to rollback the number if filtered/
cancelled.

Suggested by Naoya, do num_poisoned_pages_inc() only in
action_result(), this make this clear and simple.

Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 mm/memory-failure.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index ed280ef5473d..2d590cba412c 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1133,6 +1133,7 @@ static void action_result(unsigned long pfn, enum mf_action_page_type type,
 {
 	trace_memory_failure_event(pfn, type, result);
 
+	num_poisoned_pages_inc();
 	pr_err("Memory failure: %#lx: recovery action for %s: %s\n",
 		pfn, action_page_types[type], action_name[result]);
 }
@@ -1588,8 +1589,6 @@ static int try_memory_failure_hugetlb(unsigned long pfn, int flags, int *hugetlb
 		goto out;
 	}
 
-	num_poisoned_pages_inc();
-
 	/*
 	 * Handling free hugepage.  The possible race with hugepage allocation
 	 * or demotion can be prevented by PageHWPoison flag.
@@ -1815,7 +1814,6 @@ int memory_failure(unsigned long pfn, int flags)
 	}
 
 	hpage = compound_head(p);
-	num_poisoned_pages_inc();
 
 	/*
 	 * We need/can do nothing about count=0 pages.
@@ -1839,7 +1837,6 @@ int memory_failure(unsigned long pfn, int flags)
 					/* We lost the race, try again */
 					if (retry) {
 						ClearPageHWPoison(p);
-						num_poisoned_pages_dec();
 						retry = false;
 						goto try_again;
 					}
@@ -1915,8 +1912,7 @@ int memory_failure(unsigned long pfn, int flags)
 	 */
 	if (PageCompound(p)) {
 		if (retry) {
-			if (TestClearPageHWPoison(p))
-				num_poisoned_pages_dec();
+			ClearPageHWPoison(p);
 			unlock_page(p);
 			put_page(p);
 			flags &= ~MF_COUNT_INCREASED;
@@ -1938,8 +1934,7 @@ int memory_failure(unsigned long pfn, int flags)
 	page_flags = p->flags;
 
 	if (hwpoison_filter(p)) {
-		if (TestClearPageHWPoison(p))
-			num_poisoned_pages_dec();
+		TestClearPageHWPoison(p);
 		unlock_page(p);
 		put_page(p);
 		res = -EOPNOTSUPP;
-- 
2.20.1

