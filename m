Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0560455A03B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 20:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232456AbiFXRjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 13:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232204AbiFXRh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 13:37:56 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D60436DB28
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 10:37:42 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id e85-20020a25e758000000b00668ad2fcfdcso2776845ybh.8
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 10:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=fAGdwktIt8KMFEeY6rcBub88vVCunW5aTmCo6YUaLic=;
        b=Vv9tNv7i10/uP/TErfNMavUn+CONiybyM+rrVRU58xqDyKcuGlAEDDrYb4H8klnBqK
         6JRS9rF1Ax96bUDo9E8Q4msDjYxTQRaGDpgp0PfneuVYFjBRZnNER/PyTbYsKCHGqcfZ
         wZWHRDAniodz7pO51uXdkiH13sfi6Axk4M+P3ph2OFO2iVkw+faALWo+6f5rgiVVvomg
         DpY1Vfkw9K59AUl480vwthENZtLgRMWXBf+ShceS/WJ9l4dL6v1IQjWdqA0Jh9uJzr7B
         6UZ1PTjJenNdIGVZeRP15MnVvJZeuiEXKSxtsNuQDFnn+yupWoF7oiY8vsG+FIoUiDIP
         Hx5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=fAGdwktIt8KMFEeY6rcBub88vVCunW5aTmCo6YUaLic=;
        b=29DP/W2ZUO6j5FvloLuOzmHuL+hT6QPOn3T/ewUJbwqNUithCSw67Z1XhPI3pw5mbB
         bBOizCSeuoPP3OIbvLGULkNazts3wMvnxwYU4TYeNU0LX4Uf1DNvDlKfRKHE4+xsQuwf
         QWTeYM9jeRWBnXRGfWWzlkcf1fsHsuFTClVGZQeFXGuktwWXnSHKZzygqnHvF/26bFfZ
         UDt5wyJV3Hy53WI7+/99qeIuJ1cKSEd4hplj2vtT35fRnuOTUTxRwzW+Kxo8If/0m+2d
         rFKvi3WQyqcQ4kxbd6kouYShO5OW5+Oi06Eb/EHcW8S8FbfS1cQq167w5vngimvGnfdY
         bhQQ==
X-Gm-Message-State: AJIora+61CntuQgoeBrWGUTJRe1dLmSEZNSzluujcxR5STHj+iM9OKqP
        OokfuV7sw4lRillueQf6kjRnYo1tKEEAmW6w
X-Google-Smtp-Source: AGRyM1s9InsMUuonAQPM2rPsoKgLt0oAO15w8QDXDBNTwbyi4uqbeJxT6CBZesWu39P67C1HtW9QkiD1Grt/J/X2
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a81:64f:0:b0:318:8841:b44e with SMTP id
 76-20020a81064f000000b003188841b44emr29471ywg.216.1656092262019; Fri, 24 Jun
 2022 10:37:42 -0700 (PDT)
Date:   Fri, 24 Jun 2022 17:36:53 +0000
In-Reply-To: <20220624173656.2033256-1-jthoughton@google.com>
Message-Id: <20220624173656.2033256-24-jthoughton@google.com>
Mime-Version: 1.0
References: <20220624173656.2033256-1-jthoughton@google.com>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [RFC PATCH 23/26] userfaultfd: add UFFD_FEATURE_MINOR_HUGETLBFS_HGM
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

This is so that userspace is aware that their kernel was compiled with
HugeTLB high-granularity mapping and that UFFDIO_CONTINUE down to
PAGE_SIZE-aligned chunks are valid.

Signed-off-by: James Houghton <jthoughton@google.com>
---
 fs/userfaultfd.c                 | 7 ++++++-
 include/uapi/linux/userfaultfd.h | 2 ++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 77c1b8a7d0b9..59bfdb7a67e0 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -1935,10 +1935,15 @@ static int userfaultfd_api(struct userfaultfd_ctx *ctx,
 		goto err_out;
 	/* report all available features and ioctls to userland */
 	uffdio_api.features = UFFD_API_FEATURES;
+
 #ifndef CONFIG_HAVE_ARCH_USERFAULTFD_MINOR
 	uffdio_api.features &=
 		~(UFFD_FEATURE_MINOR_HUGETLBFS | UFFD_FEATURE_MINOR_SHMEM);
-#endif
+#ifndef CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING
+	uffdio_api.features &= ~UFFD_FEATURE_MINOR_HUGETLBFS_HGM;
+#endif  /* CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING */
+#endif  /* CONFIG_HAVE_ARCH_USERFAULTFD_MINOR */
+
 #ifndef CONFIG_HAVE_ARCH_USERFAULTFD_WP
 	uffdio_api.features &= ~UFFD_FEATURE_PAGEFAULT_FLAG_WP;
 #endif
diff --git a/include/uapi/linux/userfaultfd.h b/include/uapi/linux/userfaultfd.h
index 7d32b1e797fb..50fbcb0bcba0 100644
--- a/include/uapi/linux/userfaultfd.h
+++ b/include/uapi/linux/userfaultfd.h
@@ -32,6 +32,7 @@
 			   UFFD_FEATURE_SIGBUS |		\
 			   UFFD_FEATURE_THREAD_ID |		\
 			   UFFD_FEATURE_MINOR_HUGETLBFS |	\
+			   UFFD_FEATURE_MINOR_HUGETLBFS_HGM |	\
 			   UFFD_FEATURE_MINOR_SHMEM |		\
 			   UFFD_FEATURE_EXACT_ADDRESS |		\
 			   UFFD_FEATURE_WP_HUGETLBFS_SHMEM)
@@ -213,6 +214,7 @@ struct uffdio_api {
 #define UFFD_FEATURE_MINOR_SHMEM		(1<<10)
 #define UFFD_FEATURE_EXACT_ADDRESS		(1<<11)
 #define UFFD_FEATURE_WP_HUGETLBFS_SHMEM		(1<<12)
+#define UFFD_FEATURE_MINOR_HUGETLBFS_HGM	(1<<13)
 	__u64 features;
 
 	__u64 ioctls;
-- 
2.37.0.rc0.161.g10f37bed90-goog

