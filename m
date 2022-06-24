Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C1E655A029
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 20:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232473AbiFXRj0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 13:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232304AbiFXRiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 13:38:02 -0400
Received: from mail-ua1-x94a.google.com (mail-ua1-x94a.google.com [IPv6:2607:f8b0:4864:20::94a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD5E96F4BB
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 10:37:46 -0700 (PDT)
Received: by mail-ua1-x94a.google.com with SMTP id g1-20020ab00e01000000b00379820aee7cso1007801uak.18
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 10:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=u+0c8IGQItY5NCCATolNVsWOPdUIr5MDdbCK/q0TIvo=;
        b=D90ixVslphWwRS1UyK82N/Fu4Pbp7RfYXJAXQqDLm0AYhlK59/wd1jqEmTakmfoAdM
         bCaJEmUAqS6tCX2dak5OsRfQg3/S32jkFNOOv5AhzS6KIq2Y8/bxRLDG5Ynhh7Q4ZWRf
         T28FEgQTuQAmTAzbinSDCUL5FqalKu06/tPW5zgoGnZaHOERoYdGxV1amlIWNDhV6gNx
         Hux7xxh8o8EA2S1TUMwn3Pd1RB6gqb3P03MxNrYVTbnyXFz2pdn7Ecfkw2C38+x5Tq4t
         6G6ZSXt7n/jc3VeCFkh0qVe2rMcVgaPEC639yccX83zFJnO8qJjsZQZj8m3ROTU/7Otn
         uqtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=u+0c8IGQItY5NCCATolNVsWOPdUIr5MDdbCK/q0TIvo=;
        b=x85XUDyONTdTiIquoeP4ANjI8LvZpTxHNSFFghfBWCZ36HTIVF+TSUZk8iPUKb5iqs
         SVEW9ic4LPbROTj1lYbKBJTOZyspEeOvjwFcRS0eKINI1dHEdSqrgesD5P9OJf1J3fXO
         8glJh3xhDpXZqdCW8i5UV8sx6IPq2TFA9foRuTOSNWW/IX85VNeK0Hmx+RUZHMLgF5HL
         VEBQSzOYxqrhSj5veRk0bQSkgxM8+DITfcPl7/J+b9WyClZUddV+IXbU+CvVEPmUsPf2
         9oMpBQHK9065AQc6i6nC9SxveSnJ8BDRfFBZIjMScPRQPBD9k7DY0wSLEZh27d7hN4nT
         xoDA==
X-Gm-Message-State: AJIora9w5RWF9H+KIX/y7YcwgaQgld55rJovXMWQPpksKTPbvf75KWZC
        VvxtPt4Rn8esYMTzvnHsQrLtJ8w/qQP7lOfs
X-Google-Smtp-Source: AGRyM1sXBK2BOgwtHhnCdm6QzU6aNINH2NrcD5ngkogaDCkYiXeckpXlq4vGXhiBI+c1PtjBBhz07CDWB+WagWPT
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a05:6122:1990:b0:36b:f70c:ba55 with
 SMTP id bv16-20020a056122199000b0036bf70cba55mr26413vkb.12.1656092265972;
 Fri, 24 Jun 2022 10:37:45 -0700 (PDT)
Date:   Fri, 24 Jun 2022 17:36:56 +0000
In-Reply-To: <20220624173656.2033256-1-jthoughton@google.com>
Message-Id: <20220624173656.2033256-27-jthoughton@google.com>
Mime-Version: 1.0
References: <20220624173656.2033256-1-jthoughton@google.com>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [RFC PATCH 26/26] selftests: add HugeTLB HGM to KVM demand paging selftest
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

This doesn't address collapsing yet, and it only works with the MINOR
mode (UFFDIO_CONTINUE).

Signed-off-by: James Houghton <jthoughton@google.com>
---
 tools/testing/selftests/kvm/include/test_util.h |  2 ++
 tools/testing/selftests/kvm/lib/kvm_util.c      |  2 +-
 tools/testing/selftests/kvm/lib/test_util.c     | 14 ++++++++++++++
 3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/include/test_util.h b/tools/testing/selftests/kvm/include/test_util.h
index 99e0dcdc923f..6209e44981a7 100644
--- a/tools/testing/selftests/kvm/include/test_util.h
+++ b/tools/testing/selftests/kvm/include/test_util.h
@@ -87,6 +87,7 @@ enum vm_mem_backing_src_type {
 	VM_MEM_SRC_ANONYMOUS_HUGETLB_16GB,
 	VM_MEM_SRC_SHMEM,
 	VM_MEM_SRC_SHARED_HUGETLB,
+	VM_MEM_SRC_SHARED_HUGETLB_HGM,
 	NUM_SRC_TYPES,
 };
 
@@ -105,6 +106,7 @@ size_t get_def_hugetlb_pagesz(void);
 const struct vm_mem_backing_src_alias *vm_mem_backing_src_alias(uint32_t i);
 size_t get_backing_src_pagesz(uint32_t i);
 bool is_backing_src_hugetlb(uint32_t i);
+bool is_backing_src_shared_hugetlb(enum vm_mem_backing_src_type src_type);
 void backing_src_help(const char *flag);
 enum vm_mem_backing_src_type parse_backing_src_type(const char *type_name);
 long get_run_delay(void);
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 1665a220abcb..382f8fb75b7f 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -993,7 +993,7 @@ void vm_userspace_mem_region_add(struct kvm_vm *vm,
 	region->fd = -1;
 	if (backing_src_is_shared(src_type))
 		region->fd = kvm_memfd_alloc(region->mmap_size,
-					     src_type == VM_MEM_SRC_SHARED_HUGETLB);
+				is_backing_src_shared_hugetlb(src_type));
 
 	region->mmap_start = mmap(NULL, region->mmap_size,
 				  PROT_READ | PROT_WRITE,
diff --git a/tools/testing/selftests/kvm/lib/test_util.c b/tools/testing/selftests/kvm/lib/test_util.c
index 6d23878bbfe1..710dc42077fe 100644
--- a/tools/testing/selftests/kvm/lib/test_util.c
+++ b/tools/testing/selftests/kvm/lib/test_util.c
@@ -254,6 +254,13 @@ const struct vm_mem_backing_src_alias *vm_mem_backing_src_alias(uint32_t i)
 			 */
 			.flag = MAP_SHARED,
 		},
+		[VM_MEM_SRC_SHARED_HUGETLB_HGM] = {
+			/*
+			 * Identical to shared_hugetlb except for the name.
+			 */
+			.name = "shared_hugetlb_hgm",
+			.flag = MAP_SHARED,
+		},
 	};
 	_Static_assert(ARRAY_SIZE(aliases) == NUM_SRC_TYPES,
 		       "Missing new backing src types?");
@@ -272,6 +279,7 @@ size_t get_backing_src_pagesz(uint32_t i)
 	switch (i) {
 	case VM_MEM_SRC_ANONYMOUS:
 	case VM_MEM_SRC_SHMEM:
+	case VM_MEM_SRC_SHARED_HUGETLB_HGM:
 		return getpagesize();
 	case VM_MEM_SRC_ANONYMOUS_THP:
 		return get_trans_hugepagesz();
@@ -288,6 +296,12 @@ bool is_backing_src_hugetlb(uint32_t i)
 	return !!(vm_mem_backing_src_alias(i)->flag & MAP_HUGETLB);
 }
 
+bool is_backing_src_shared_hugetlb(enum vm_mem_backing_src_type src_type)
+{
+	return src_type == VM_MEM_SRC_SHARED_HUGETLB ||
+		src_type == VM_MEM_SRC_SHARED_HUGETLB_HGM;
+}
+
 static void print_available_backing_src_types(const char *prefix)
 {
 	int i;
-- 
2.37.0.rc0.161.g10f37bed90-goog

