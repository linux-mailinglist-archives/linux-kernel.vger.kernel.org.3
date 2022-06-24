Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2452555A038
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 20:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232357AbiFXRiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 13:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231302AbiFXRhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 13:37:15 -0400
Received: from mail-ua1-x94a.google.com (mail-ua1-x94a.google.com [IPv6:2607:f8b0:4864:20::94a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C6D5DF3E
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 10:37:14 -0700 (PDT)
Received: by mail-ua1-x94a.google.com with SMTP id v14-20020ab0768e000000b0037efa637aeeso1006779uaq.23
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 10:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=t5KTYrM6ct0JWom4isvAtP154HT/fkrm8rvSO1JL/WI=;
        b=M7hxU1278b0Lh3tABv6L9l9qZ4Alxa0YOqUCt2BED4X975N8JVezOpIosUzb1pRlq1
         SX94qvz3QX67rX7o3GZ8S0leLb7FFHhNK9SdbX2Rb4HmWbI4dwX/Y22ct/UwPlrwOYgo
         BEGkS4HWHIzpNKTgxCJfh6kCkdYmxrPG3Nl2ni6y2MM4kjfXPF2tIOcXuallnel4T3/F
         /EtqJ7IGlIBOBHTK/RDkilRjqZ1ZMgNfsJXOMiaLWaQMYD1+JF22Fefkl8MXbu5xw4Co
         KYFTD830ASsGDKWn3Fb3Id7J7wa0mQKCv+6AwRNyDerpkb98fQtJVbUhtnQtE3T/QsCS
         4F8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=t5KTYrM6ct0JWom4isvAtP154HT/fkrm8rvSO1JL/WI=;
        b=rqUrsJQuZjyUOBwFPG2890L4K0ZBl462ceA2rY/YFWvQVwL83hXKBegJZHMy9SMAmU
         FahSB3eSDP2qR+8oF736APaCgbgcFlVr1uQ7WFLtAejI/2qkwF2zyO+LXKUBBQttzdIq
         Us/tIWyKg7v/JtNQTc1EP4SkxeWUxGfoxO0CWGvakw23lqmaoZTq+r6ZS0qMl29V3wL+
         LrMRWJhbYQo+VKhvKnYESB3VOZ3XKI8CBP/ETeA97kfPnaRsbRkqxHSt8JelWUuWNNvW
         /pFaXzjHXji2MdVbWwYn4P7cZJoXfui93w2LoDffW1A9toOEY1JCjwEiMjxDqVhSHfi6
         KAkA==
X-Gm-Message-State: AJIora9juRgUJvWvmm5yTOlSwE3F2zUFA9+DgTUiFAP3j7WyzvE5LNJd
        y9FLEeB4OhDZhD16ns6jycl7z8GRH5osuIY8
X-Google-Smtp-Source: AGRyM1s3Rhw53YqM2sURrEy49E22RRF/1tHTOyTtY+rHKd8zIb/K3DKzbqQUo9FnKORpPjSO3ZnTjnoOojVZvhpT
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a05:6102:3ec8:b0:335:d67e:7535 with
 SMTP id n8-20020a0561023ec800b00335d67e7535mr71521vsv.47.1656092234176; Fri,
 24 Jun 2022 10:37:14 -0700 (PDT)
Date:   Fri, 24 Jun 2022 17:36:33 +0000
In-Reply-To: <20220624173656.2033256-1-jthoughton@google.com>
Message-Id: <20220624173656.2033256-4-jthoughton@google.com>
Mime-Version: 1.0
References: <20220624173656.2033256-1-jthoughton@google.com>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [RFC PATCH 03/26] hugetlb: add make_huge_pte_with_shift
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

This allows us to make huge PTEs at shifts other than the hstate shift,
which will be necessary for high-granularity mappings.

Signed-off-by: James Houghton <jthoughton@google.com>
---
 mm/hugetlb.c | 33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 5df838d86f32..0eec34edf3b2 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4686,23 +4686,30 @@ const struct vm_operations_struct hugetlb_vm_ops = {
 	.pagesize = hugetlb_vm_op_pagesize,
 };
 
+static pte_t make_huge_pte_with_shift(struct vm_area_struct *vma,
+				      struct page *page, int writable,
+				      int shift)
+{
+	bool huge = shift > PAGE_SHIFT;
+	pte_t entry = huge ? mk_huge_pte(page, vma->vm_page_prot)
+			   : mk_pte(page, vma->vm_page_prot);
+
+	if (writable)
+		entry = huge ? huge_pte_mkwrite(entry) : pte_mkwrite(entry);
+	else
+		entry = huge ? huge_pte_wrprotect(entry) : pte_wrprotect(entry);
+	pte_mkyoung(entry);
+	if (huge)
+		entry = arch_make_huge_pte(entry, shift, vma->vm_flags);
+	return entry;
+}
+
 static pte_t make_huge_pte(struct vm_area_struct *vma, struct page *page,
-				int writable)
+			   int writable)
 {
-	pte_t entry;
 	unsigned int shift = huge_page_shift(hstate_vma(vma));
 
-	if (writable) {
-		entry = huge_pte_mkwrite(huge_pte_mkdirty(mk_huge_pte(page,
-					 vma->vm_page_prot)));
-	} else {
-		entry = huge_pte_wrprotect(mk_huge_pte(page,
-					   vma->vm_page_prot));
-	}
-	entry = pte_mkyoung(entry);
-	entry = arch_make_huge_pte(entry, shift, vma->vm_flags);
-
-	return entry;
+	return make_huge_pte_with_shift(vma, page, writable, shift);
 }
 
 static void set_huge_ptep_writable(struct vm_area_struct *vma,
-- 
2.37.0.rc0.161.g10f37bed90-goog

