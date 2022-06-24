Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C617559FDD
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 20:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232587AbiFXRjX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 13:39:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232267AbiFXRiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 13:38:01 -0400
Received: from mail-ua1-x94a.google.com (mail-ua1-x94a.google.com [IPv6:2607:f8b0:4864:20::94a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8753D6E78B
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 10:37:45 -0700 (PDT)
Received: by mail-ua1-x94a.google.com with SMTP id z7-20020ab05647000000b003793ef68061so1035728uaa.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 10:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=SIBOH6opXUz/XwGM5Y6ya4CpHP7LmoYYYTh8F0m81no=;
        b=Pbkkfo9sSsWByEA3MDQOtz+Q2704OLexkMuoEPgStT8U3UpSblQ3IEPUJoumDhRsCS
         KF3OzIl1hpNYAOnJFSoAUINBxdMD3KyitvNSBwfbQwAIVinkxf2E5fS++Nptgx5omNHK
         MhGNV51KMhOAPw8/F/4bz6597P0y0Tjf0Quez0cg4ldgJsyCR4bIHrUcoZUbXkNnkJTy
         Y9FpzlIt/V/d7jDwUfIW+aYewo3REz+w4TXtV8Ubu/W8DxnbGVsCZKID9paL3I07nVHN
         ibi7C91OOK5NPVkKxk8pfTxCZhen97wIWN591SFKIs0pk37m97cZ299uot1663T0JWat
         EJYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=SIBOH6opXUz/XwGM5Y6ya4CpHP7LmoYYYTh8F0m81no=;
        b=qvS6OtBijubS8v2ngaFhB+5jIF4ShAXD8SyOUIi0XhovLu9L+OD7EKb7PL2JGCVshH
         xU1Bs/xrbdrgaURxxdUtRn7YA0pxGErpVjSO/F80WIm44zD3LxIa4qcShtgUt852xxDW
         cBoSRJFulbMr015EPlj9Gz9cf6TskBq+7c6z6K5xRUx4AGklQoMVRZskeAWClR+k6F8B
         UgKNn91UGm/Dujkzdsj8cruJZHyhfr3/mX6bW600OSxXHCSUDL1IH+8AFWwYrxoCKL/S
         oJCchd1PcxWoHJ7lpiDi5arNnBD/PHOVAWXjZkrL9K9Dk+klLkS+UAnvYOvkHQlpF44O
         1f+g==
X-Gm-Message-State: AJIora/HFGS+95nWCQeo416g7++GXIESYBFuDVd3rdjWsctxXnL6xOi2
        0b8htdzTelKxv3ka0MU267R2caXa78RxBJuc
X-Google-Smtp-Source: AGRyM1vSDDKOe0+ex+JDy0gPJ7CNOXQ1Vy1CORyh/oXQDqJ/7aNJp/5naeafubXWqtHGG6rbV8KIUOgKlN+dxbOo
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a05:6102:d4:b0:356:1e42:b3d8 with SMTP
 id u20-20020a05610200d400b003561e42b3d8mr1691552vsp.82.1656092264711; Fri, 24
 Jun 2022 10:37:44 -0700 (PDT)
Date:   Fri, 24 Jun 2022 17:36:55 +0000
In-Reply-To: <20220624173656.2033256-1-jthoughton@google.com>
Message-Id: <20220624173656.2033256-26-jthoughton@google.com>
Mime-Version: 1.0
References: <20220624173656.2033256-1-jthoughton@google.com>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [RFC PATCH 25/26] selftests: add HugeTLB HGM to userfaultfd selftest
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

It behaves just like the regular shared HugeTLB configuration, except
that it uses 4K instead of hugepages.

This doesn't test collapsing yet. I'll add a test for that for v1.

Signed-off-by: James Houghton <jthoughton@google.com>
---
 tools/testing/selftests/vm/userfaultfd.c | 61 ++++++++++++++++++++----
 1 file changed, 51 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
index 0bdfc1955229..9cbb959519a6 100644
--- a/tools/testing/selftests/vm/userfaultfd.c
+++ b/tools/testing/selftests/vm/userfaultfd.c
@@ -64,7 +64,7 @@
 
 #ifdef __NR_userfaultfd
 
-static unsigned long nr_cpus, nr_pages, nr_pages_per_cpu, page_size;
+static unsigned long nr_cpus, nr_pages, nr_pages_per_cpu, page_size, hpage_size;
 
 #define BOUNCE_RANDOM		(1<<0)
 #define BOUNCE_RACINGFAULTS	(1<<1)
@@ -72,9 +72,10 @@ static unsigned long nr_cpus, nr_pages, nr_pages_per_cpu, page_size;
 #define BOUNCE_POLL		(1<<3)
 static int bounces;
 
-#define TEST_ANON	1
-#define TEST_HUGETLB	2
-#define TEST_SHMEM	3
+#define TEST_ANON		1
+#define TEST_HUGETLB		2
+#define TEST_HUGETLB_HGM	3
+#define TEST_SHMEM		4
 static int test_type;
 
 /* exercise the test_uffdio_*_eexist every ALARM_INTERVAL_SECS */
@@ -85,6 +86,7 @@ static volatile bool test_uffdio_zeropage_eexist = true;
 static bool test_uffdio_wp = true;
 /* Whether to test uffd minor faults */
 static bool test_uffdio_minor = false;
+static bool test_uffdio_copy = true;
 
 static bool map_shared;
 static int shm_fd;
@@ -140,12 +142,17 @@ static void usage(void)
 	fprintf(stderr, "\nUsage: ./userfaultfd <test type> <MiB> <bounces> "
 		"[hugetlbfs_file]\n\n");
 	fprintf(stderr, "Supported <test type>: anon, hugetlb, "
-		"hugetlb_shared, shmem\n\n");
+		"hugetlb_shared, hugetlb_shared_hgm, shmem\n\n");
 	fprintf(stderr, "Examples:\n\n");
 	fprintf(stderr, "%s", examples);
 	exit(1);
 }
 
+static bool test_is_hugetlb(void)
+{
+	return test_type == TEST_HUGETLB || test_type == TEST_HUGETLB_HGM;
+}
+
 #define _err(fmt, ...)						\
 	do {							\
 		int ret = errno;				\
@@ -348,7 +355,7 @@ static struct uffd_test_ops *uffd_test_ops;
 
 static inline uint64_t uffd_minor_feature(void)
 {
-	if (test_type == TEST_HUGETLB && map_shared)
+	if (test_is_hugetlb() && map_shared)
 		return UFFD_FEATURE_MINOR_HUGETLBFS;
 	else if (test_type == TEST_SHMEM)
 		return UFFD_FEATURE_MINOR_SHMEM;
@@ -360,7 +367,7 @@ static uint64_t get_expected_ioctls(uint64_t mode)
 {
 	uint64_t ioctls = UFFD_API_RANGE_IOCTLS;
 
-	if (test_type == TEST_HUGETLB)
+	if (test_is_hugetlb())
 		ioctls &= ~(1 << _UFFDIO_ZEROPAGE);
 
 	if (!((mode & UFFDIO_REGISTER_MODE_WP) && test_uffdio_wp))
@@ -1116,6 +1123,12 @@ static int userfaultfd_events_test(void)
 	char c;
 	struct uffd_stats stats = { 0 };
 
+	if (!test_uffdio_copy) {
+		printf("Skipping userfaultfd events test "
+			"(test_uffdio_copy=false)\n");
+		return 0;
+	}
+
 	printf("testing events (fork, remap, remove): ");
 	fflush(stdout);
 
@@ -1169,6 +1182,12 @@ static int userfaultfd_sig_test(void)
 	char c;
 	struct uffd_stats stats = { 0 };
 
+	if (!test_uffdio_copy) {
+		printf("Skipping userfaultfd signal test "
+			"(test_uffdio_copy=false)\n");
+		return 0;
+	}
+
 	printf("testing signal delivery: ");
 	fflush(stdout);
 
@@ -1438,6 +1457,12 @@ static int userfaultfd_stress(void)
 	pthread_attr_init(&attr);
 	pthread_attr_setstacksize(&attr, 16*1024*1024);
 
+	if (!test_uffdio_copy) {
+		printf("Skipping userfaultfd stress test "
+			"(test_uffdio_copy=false)\n");
+		bounces = 0;
+	}
+
 	while (bounces--) {
 		printf("bounces: %d, mode:", bounces);
 		if (bounces & BOUNCE_RANDOM)
@@ -1598,6 +1623,13 @@ static void set_test_type(const char *type)
 		uffd_test_ops = &hugetlb_uffd_test_ops;
 		/* Minor faults require shared hugetlb; only enable here. */
 		test_uffdio_minor = true;
+	} else if (!strcmp(type, "hugetlb_shared_hgm")) {
+		map_shared = true;
+		test_type = TEST_HUGETLB_HGM;
+		uffd_test_ops = &hugetlb_uffd_test_ops;
+		/* Minor faults require shared hugetlb; only enable here. */
+		test_uffdio_minor = true;
+		test_uffdio_copy = false;
 	} else if (!strcmp(type, "shmem")) {
 		map_shared = true;
 		test_type = TEST_SHMEM;
@@ -1607,8 +1639,10 @@ static void set_test_type(const char *type)
 		err("Unknown test type: %s", type);
 	}
 
+	hpage_size = default_huge_page_size();
 	if (test_type == TEST_HUGETLB)
-		page_size = default_huge_page_size();
+		// TEST_HUGETLB_HGM gets small pages.
+		page_size = hpage_size;
 	else
 		page_size = sysconf(_SC_PAGE_SIZE);
 
@@ -1658,19 +1692,26 @@ int main(int argc, char **argv)
 	nr_cpus = sysconf(_SC_NPROCESSORS_ONLN);
 	nr_pages_per_cpu = atol(argv[2]) * 1024*1024 / page_size /
 		nr_cpus;
+	if (test_type == TEST_HUGETLB_HGM)
+		/*
+		 * `page_size` refers to the page_size we can use in
+		 * UFFDIO_CONTINUE. We still need nr_pages to be appropriately
+		 * aligned, so align it here.
+		 */
+		nr_pages_per_cpu -= nr_pages_per_cpu % (hpage_size / page_size);
 	if (!nr_pages_per_cpu) {
 		_err("invalid MiB");
 		usage();
 	}
+	nr_pages = nr_pages_per_cpu * nr_cpus;
 
 	bounces = atoi(argv[3]);
 	if (bounces <= 0) {
 		_err("invalid bounces");
 		usage();
 	}
-	nr_pages = nr_pages_per_cpu * nr_cpus;
 
-	if (test_type == TEST_HUGETLB && map_shared) {
+	if (test_is_hugetlb() && map_shared) {
 		if (argc < 5)
 			usage();
 		huge_fd = open(argv[4], O_CREAT | O_RDWR, 0755);
-- 
2.37.0.rc0.161.g10f37bed90-goog

