Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA0B55A024
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 20:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232273AbiFXRiU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 13:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbiFXRhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 13:37:13 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 596C35DF25
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 10:37:12 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id c10-20020a251c0a000000b00669b463d2e1so2744999ybc.11
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 10:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=0YfnJKuQrbw7pcq3GiMHpIZjYaYv7/J4Psozl7GAbkY=;
        b=rhedzQCKx2wNhVDSGuAJpH9VZYMHroyUpR1McnELZRf5xZDgeN7uNFXQFUQY36oI+V
         sQBZjS3MbDOeENElKNgbkCSeJdkA4KvbvhCfXewwUZV8VRhUz4h9mZPxYQQ152Wr/FN/
         5BdmdPLWcel0PhshC6zVgGbHZJRq7Q7vjb3TkLcOA4+olBP02aOCGQ9Oozydj+ubNW0a
         x/51FkRIRk4fHQ5AYf3+Jpxz4mZgUNsIXL+ynW22YI6IcrDX3OU3vcAglWcWj6mxHBI5
         z3zP8e+fcp3Sh89Okw6YqgR52njYR4st6QIktXU0C0bgCozw42NZ4PuV/5cZ6iJXZUXt
         qYDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=0YfnJKuQrbw7pcq3GiMHpIZjYaYv7/J4Psozl7GAbkY=;
        b=yW0Q1bmgM5aP1SAicqs1tAxGxIYHB33SRoHBYbAShJ8CvecuZbuDd7hfsmV4i/0BEV
         2ffzGnG5ISMSWIBhsVg/PomNNvKcpVtHhWe1prcSMkEeL+vNRUZ2yFp1DybDlKycOIUe
         UNVfUt+XXaGtCV++zOSkZqMF3coVuUoTwkiKDHEtWGHu076S7QLMfJcxNDYMnNJXZMEH
         SlurY9bgu9Z3ohNl/CcZOAaNOrA+2sXxaKJvfnMsaZeK8UuVfVijJfj4eAkTze8DyUoX
         b7gLRmdJhFR0O2ynMm5dQIA3AxeHHMQiRDYLqp8lXs6lHw0KJQxMf2rv+/5ipOFE5ICY
         OvZQ==
X-Gm-Message-State: AJIora+cjaf55RZa3Bj5QdCuV1HXZxridAJALNLKrBybpKnXenGGzLN0
        ePcghfHfVS0IqIs13rVWp6Q/lCYhKfYM3w6e
X-Google-Smtp-Source: AGRyM1s/D7w5lW8rHIOJ8tPXZ//y7BlXl1scm2CvIFSsZAI4asuL+1307Qq/vgDdbLiEG20sjasM/mVp1mTCdeSz
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a0d:f4c5:0:b0:317:7f89:f547 with SMTP
 id d188-20020a0df4c5000000b003177f89f547mr18475ywf.334.1656092231687; Fri, 24
 Jun 2022 10:37:11 -0700 (PDT)
Date:   Fri, 24 Jun 2022 17:36:31 +0000
In-Reply-To: <20220624173656.2033256-1-jthoughton@google.com>
Message-Id: <20220624173656.2033256-2-jthoughton@google.com>
Mime-Version: 1.0
References: <20220624173656.2033256-1-jthoughton@google.com>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [RFC PATCH 01/26] hugetlb: make hstate accessor functions const
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

This is just a const-correctness change so that the new hugetlb_pte
changes can be const-correct too.

Acked-by: David Rientjes <rientjes@google.com>

Signed-off-by: James Houghton <jthoughton@google.com>
---
 include/linux/hugetlb.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index e4cff27d1198..498a4ae3d462 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -715,7 +715,7 @@ static inline struct hstate *hstate_vma(struct vm_area_struct *vma)
 	return hstate_file(vma->vm_file);
 }
 
-static inline unsigned long huge_page_size(struct hstate *h)
+static inline unsigned long huge_page_size(const struct hstate *h)
 {
 	return (unsigned long)PAGE_SIZE << h->order;
 }
@@ -729,27 +729,27 @@ static inline unsigned long huge_page_mask(struct hstate *h)
 	return h->mask;
 }
 
-static inline unsigned int huge_page_order(struct hstate *h)
+static inline unsigned int huge_page_order(const struct hstate *h)
 {
 	return h->order;
 }
 
-static inline unsigned huge_page_shift(struct hstate *h)
+static inline unsigned huge_page_shift(const struct hstate *h)
 {
 	return h->order + PAGE_SHIFT;
 }
 
-static inline bool hstate_is_gigantic(struct hstate *h)
+static inline bool hstate_is_gigantic(const struct hstate *h)
 {
 	return huge_page_order(h) >= MAX_ORDER;
 }
 
-static inline unsigned int pages_per_huge_page(struct hstate *h)
+static inline unsigned int pages_per_huge_page(const struct hstate *h)
 {
 	return 1 << h->order;
 }
 
-static inline unsigned int blocks_per_huge_page(struct hstate *h)
+static inline unsigned int blocks_per_huge_page(const struct hstate *h)
 {
 	return huge_page_size(h) / 512;
 }
-- 
2.37.0.rc0.161.g10f37bed90-goog

