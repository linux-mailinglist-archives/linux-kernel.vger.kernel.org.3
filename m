Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 050EA559FE6
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 20:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232343AbiFXRiI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 13:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231162AbiFXRhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 13:37:14 -0400
Received: from mail-ua1-x949.google.com (mail-ua1-x949.google.com [IPv6:2607:f8b0:4864:20::949])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0F73609CA
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 10:37:13 -0700 (PDT)
Received: by mail-ua1-x949.google.com with SMTP id v19-20020ab05593000000b0037ed9894dfbso1008709uaa.19
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 10:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=cBo7lIiy2jlsdOG5qT1oBCHlWVvIiK17uVsMNAgjZEA=;
        b=NJEF0grG6xcnUMzJ7Xx8DncxrM3Dg/CCXuZcQoPGVS8RMCRW7OVDsyTMq2msiIkgR3
         QD3rc43cPJSTJK/tuSyrg1IgeA7F7F0rpMnzeXl2raeM1+E+9KIbYlUZ6X/l+oQ1o3X8
         FetdG0D5zD5JUcSef1agw+Hok5ZWwdiJaZLaL/pl4egaQHqe4C6GaU0IcgckBRNz/QIi
         XvX1VQlmkldTFcvliG4NEQiL7t+Leo3XWSFsPzela+hWWv2mTwnOC5NDGzw04gi1JEMx
         Hu59PBmYCm43RJHjH32Pik1VWkbEEt2CtqEMLAHbbH1gUokwIOPzG/lqTGqFU3e6iia/
         o9Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=cBo7lIiy2jlsdOG5qT1oBCHlWVvIiK17uVsMNAgjZEA=;
        b=2v9179SbMHcLuxNtYpgOaD7B6pkjArD/My5tHiQq89JV94ZTez4gTxEAvQA3GIfm5L
         4+JzF5iE/eoPvg3uHihzEV5ASB3a8++izognLZi82iaGQNg/7+nddf6qBRIJc3WTBUxC
         WtW8M8duMfd3gZMHkdcjrCBCnNaNTX9l80IP4MyqOHdtWHA+bf0YaczYJShaBNFaO4w/
         YPLl4sJcJTNaJFBLjKQE4NmKXTTtrVX64B72XWOdMCdVKsSFHxHeubh3ZUhaDHc/6Cf+
         iXBvRykGMkJVyDLdgGAzxH1h21vS3HI6HtaJ1BlwM1xaLgPlRK+9UwAZZlnlU2iZTiyc
         HE0A==
X-Gm-Message-State: AJIora+bsCbYhOIReLGBKvmOEenSrvNjT9x7NXE73t7HeVMIy5Y2gGZ9
        V1e5zHLrFHf3mYtoVHIOTDL8d/8BR/hfo0nL
X-Google-Smtp-Source: AGRyM1uKLxV44YzBDP/q42+n2ejxUvrdr7EuCEClIr+ZyRlO8QyvjxzdjM1m0/iYLEcLM71c8MSRgqLgbnEZ/vLa
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a05:6122:25b:b0:36c:5f1a:d94b with SMTP
 id t27-20020a056122025b00b0036c5f1ad94bmr11908478vko.31.1656092233083; Fri,
 24 Jun 2022 10:37:13 -0700 (PDT)
Date:   Fri, 24 Jun 2022 17:36:32 +0000
In-Reply-To: <20220624173656.2033256-1-jthoughton@google.com>
Message-Id: <20220624173656.2033256-3-jthoughton@google.com>
Mime-Version: 1.0
References: <20220624173656.2033256-1-jthoughton@google.com>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [RFC PATCH 02/26] hugetlb: sort hstates in hugetlb_init_hstates
From:   James Houghton <jthoughton@google.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>
Cc:     David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Jue Wang <juew@google.com>,
        Manish Mishra <manish.mishra@nutanix.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        James Houghton <jthoughton@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When using HugeTLB high-granularity mapping, we need to go through the
supported hugepage sizes in decreasing order so that we pick the largest
size that works. Consider the case where we're faulting in a 1G hugepage
for the first time: we want hugetlb_fault/hugetlb_no_page to map it with
a PUD. By going through the sizes in decreasing order, we will find that
PUD_SIZE works before finding out that PMD_SIZE or PAGE_SIZE work too.

Signed-off-by: James Houghton <jthoughton@google.com>
---
 mm/hugetlb.c | 40 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 37 insertions(+), 3 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index a57e1be41401..5df838d86f32 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -33,6 +33,7 @@
 #include <linux/migrate.h>
 #include <linux/nospec.h>
 #include <linux/delayacct.h>
+#include <linux/sort.h>
 
 #include <asm/page.h>
 #include <asm/pgalloc.h>
@@ -48,6 +49,10 @@
 
 int hugetlb_max_hstate __read_mostly;
 unsigned int default_hstate_idx;
+/*
+ * After hugetlb_init_hstates is called, hstates will be sorted from largest
+ * to smallest.
+ */
 struct hstate hstates[HUGE_MAX_HSTATE];
 
 #ifdef CONFIG_CMA
@@ -3144,14 +3149,43 @@ static void __init hugetlb_hstate_alloc_pages(struct hstate *h)
 	kfree(node_alloc_noretry);
 }
 
+static int compare_hstates_decreasing(const void *a, const void *b)
+{
+	const int shift_a = huge_page_shift((const struct hstate *)a);
+	const int shift_b = huge_page_shift((const struct hstate *)b);
+
+	if (shift_a < shift_b)
+		return 1;
+	if (shift_a > shift_b)
+		return -1;
+	return 0;
+}
+
+static void sort_hstates(void)
+{
+	unsigned long default_hstate_sz = huge_page_size(&default_hstate);
+
+	/* Sort from largest to smallest. */
+	sort(hstates, hugetlb_max_hstate, sizeof(*hstates),
+	     compare_hstates_decreasing, NULL);
+
+	/*
+	 * We may have changed the location of the default hstate, so we need to
+	 * update it.
+	 */
+	default_hstate_idx = hstate_index(size_to_hstate(default_hstate_sz));
+}
+
 static void __init hugetlb_init_hstates(void)
 {
 	struct hstate *h, *h2;
 
-	for_each_hstate(h) {
-		if (minimum_order > huge_page_order(h))
-			minimum_order = huge_page_order(h);
+	sort_hstates();
 
+	/* The last hstate is now the smallest. */
+	minimum_order = huge_page_order(&hstates[hugetlb_max_hstate - 1]);
+
+	for_each_hstate(h) {
 		/* oversize hugepages were init'ed in early boot */
 		if (!hstate_is_gigantic(h))
 			hugetlb_hstate_alloc_pages(h);
-- 
2.37.0.rc0.161.g10f37bed90-goog

