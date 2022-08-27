Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53CFD5A34E1
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 07:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240364AbiH0FnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 01:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234350AbiH0FnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 01:43:12 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE54896FC4
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 22:43:11 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id s31-20020a17090a2f2200b001faaf9d92easo9888256pjd.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 22:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=CtDes6D1Zod3gpBKh/Yi5BXbq7xZZDBkTjW4I2nSQWw=;
        b=FGgwCTd0HSMlBx5pb/8Mqzyj4ZFWZ4cdvj253NkQnyBftD0w/JI4uLWzydivTmcYNi
         kdNOJHm6tA39hZSFyqRKtmghMKUz4w0dCWL0hhSOJ9I0YpEyA+5LYoyZBll50gIHal3s
         IZdnDgpXCS0VO5BhbvYqd/nPWIfG0zooA5iu9jH5L1c5aL66g4JXseqBWk8+uMliy0A/
         SwuqpmPNHT/ZdbwZPskeQi0focenQrfACsAkAkinPy19wP7GMVKl/jTGR9tGWY+YAt2C
         756TjNODgz+NxspuDWgPO+tNNeAoDznbwvv2sQEASnY67LtnwPeesd8BKRIZTZN6+TN/
         G/rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=CtDes6D1Zod3gpBKh/Yi5BXbq7xZZDBkTjW4I2nSQWw=;
        b=ycWF9szt5bo/6ZnQoFPtwjp937pvkPIO8TDBGRO8cwLlaNCIKNMHs0T7FCQg/HS8/U
         TxhCv/N1ph0BFTfoDjhRyTzZwLJfUkB4AMsf97KZZrsVpIyNoRUVnOKzvQAfENhLlHQ0
         IVm5NeS6ffXO7UGrh22OvSLi6ZUjt60ZF3e3OIkFH8oPHgmM5K+BunDFFhw2B9aHJ635
         OYJUSmSDPMTcj3lpc+2XHaBcX/KD9i3MOtJDgUzdUIftFqoMDavs2uZ2uUqcI/DYTzmV
         N0Ce92xM99QMjNqxNcz598q4T1/i1o6jyE/vQtWFGKLEz2ff5bTcsT4zNZNNnx89K18H
         2nMw==
X-Gm-Message-State: ACgBeo1Tt186uk6OS9KRlzxINIjkxaUqdPCEDbB+dJyalsNSBFCzkUzy
        7O6fgpLvmPRKIIz7qmCgX/tA5T0caV8=
X-Google-Smtp-Source: AA6agR77amqJBmpJQNcP8zt+Y2g7SMMDKMTqXDcZuw1SLAoPHfXtKFTdiFJ0KxOjVGomcswe62yWKQ==
X-Received: by 2002:a17:90b:38c4:b0:1fd:7119:1302 with SMTP id nn4-20020a17090b38c400b001fd71191302mr4925528pjb.243.1661578991281;
        Fri, 26 Aug 2022 22:43:11 -0700 (PDT)
Received: from sophie ([89.46.114.37])
        by smtp.gmail.com with ESMTPSA id e17-20020a17090301d100b0016c9e5f290esm2658785plh.10.2022.08.26.22.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 22:43:10 -0700 (PDT)
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Rebecca Mckeever <remckee0@gmail.com>
Subject: [PATCH v3 3/8] memblock tests: add labels to verbose output for generic alloc tests
Date:   Sat, 27 Aug 2022 00:42:45 -0500
Message-Id: <fb76a42253d2a196a7daea29dd8121a69904f58e.1661578349.git.remckee0@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1661578349.git.remckee0@gmail.com>
References: <cover.1661578349.git.remckee0@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Generic tests for memblock_alloc*() functions do not use separate
functions for testing top-down and bottom-up allocation directions.
Therefore, the function name that is displayed in the verbose testing
output does not include the allocation direction.

Add an additional prefix when running generic tests for
memblock_alloc*() functions that indicates which allocation direction is
set. The prefix will be displayed when the tests are run in verbose mode.

Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>
---
 tools/testing/memblock/tests/alloc_api.c      | 36 +++++++------------
 .../memblock/tests/alloc_helpers_api.c        | 12 +++----
 tools/testing/memblock/tests/alloc_nid_api.c  | 36 +++++++------------
 tools/testing/memblock/tests/common.h         | 16 +++++++++
 4 files changed, 44 insertions(+), 56 deletions(-)

diff --git a/tools/testing/memblock/tests/alloc_api.c b/tools/testing/memblock/tests/alloc_api.c
index c97da91a98d6..de3405634f8a 100644
--- a/tools/testing/memblock/tests/alloc_api.c
+++ b/tools/testing/memblock/tests/alloc_api.c
@@ -751,10 +751,8 @@ static int alloc_after_check(void)
 static int alloc_in_between_check(void)
 {
 	test_print("\tRunning %s...\n", __func__);
-	memblock_set_bottom_up(false);
-	alloc_in_between_generic_check();
-	memblock_set_bottom_up(true);
-	alloc_in_between_generic_check();
+	run_top_down(alloc_in_between_generic_check);
+	run_bottom_up(alloc_in_between_generic_check);
 
 	return 0;
 }
@@ -773,10 +771,8 @@ static int alloc_second_fit_check(void)
 static int alloc_small_gaps_check(void)
 {
 	test_print("\tRunning %s...\n", __func__);
-	memblock_set_bottom_up(false);
-	alloc_small_gaps_generic_check();
-	memblock_set_bottom_up(true);
-	alloc_small_gaps_generic_check();
+	run_top_down(alloc_small_gaps_generic_check);
+	run_bottom_up(alloc_small_gaps_generic_check);
 
 	return 0;
 }
@@ -784,10 +780,8 @@ static int alloc_small_gaps_check(void)
 static int alloc_all_reserved_check(void)
 {
 	test_print("\tRunning %s...\n", __func__);
-	memblock_set_bottom_up(false);
-	alloc_all_reserved_generic_check();
-	memblock_set_bottom_up(true);
-	alloc_all_reserved_generic_check();
+	run_top_down(alloc_all_reserved_generic_check);
+	run_bottom_up(alloc_all_reserved_generic_check);
 
 	return 0;
 }
@@ -795,10 +789,8 @@ static int alloc_all_reserved_check(void)
 static int alloc_no_space_check(void)
 {
 	test_print("\tRunning %s...\n", __func__);
-	memblock_set_bottom_up(false);
-	alloc_no_space_generic_check();
-	memblock_set_bottom_up(true);
-	alloc_no_space_generic_check();
+	run_top_down(alloc_no_space_generic_check);
+	run_bottom_up(alloc_no_space_generic_check);
 
 	return 0;
 }
@@ -806,10 +798,8 @@ static int alloc_no_space_check(void)
 static int alloc_limited_space_check(void)
 {
 	test_print("\tRunning %s...\n", __func__);
-	memblock_set_bottom_up(false);
-	alloc_limited_space_generic_check();
-	memblock_set_bottom_up(true);
-	alloc_limited_space_generic_check();
+	run_top_down(alloc_limited_space_generic_check);
+	run_bottom_up(alloc_limited_space_generic_check);
 
 	return 0;
 }
@@ -817,10 +807,8 @@ static int alloc_limited_space_check(void)
 static int alloc_no_memory_check(void)
 {
 	test_print("\tRunning %s...\n", __func__);
-	memblock_set_bottom_up(false);
-	alloc_no_memory_generic_check();
-	memblock_set_bottom_up(true);
-	alloc_no_memory_generic_check();
+	run_top_down(alloc_no_memory_generic_check);
+	run_bottom_up(alloc_no_memory_generic_check);
 
 	return 0;
 }
diff --git a/tools/testing/memblock/tests/alloc_helpers_api.c b/tools/testing/memblock/tests/alloc_helpers_api.c
index f1c7d6f170b6..06577bd0e349 100644
--- a/tools/testing/memblock/tests/alloc_helpers_api.c
+++ b/tools/testing/memblock/tests/alloc_helpers_api.c
@@ -357,10 +357,8 @@ static int alloc_from_bottom_up_min_addr_cap_check(void)
 static int alloc_from_simple_check(void)
 {
 	test_print("\tRunning %s...\n", __func__);
-	memblock_set_bottom_up(false);
-	alloc_from_simple_generic_check();
-	memblock_set_bottom_up(true);
-	alloc_from_simple_generic_check();
+	run_top_down(alloc_from_simple_generic_check);
+	run_bottom_up(alloc_from_simple_generic_check);
 
 	return 0;
 }
@@ -368,10 +366,8 @@ static int alloc_from_simple_check(void)
 static int alloc_from_misaligned_check(void)
 {
 	test_print("\tRunning %s...\n", __func__);
-	memblock_set_bottom_up(false);
-	alloc_from_misaligned_generic_check();
-	memblock_set_bottom_up(true);
-	alloc_from_misaligned_generic_check();
+	run_top_down(alloc_from_misaligned_generic_check);
+	run_bottom_up(alloc_from_misaligned_generic_check);
 
 	return 0;
 }
diff --git a/tools/testing/memblock/tests/alloc_nid_api.c b/tools/testing/memblock/tests/alloc_nid_api.c
index a069534c459e..9324d706ee3a 100644
--- a/tools/testing/memblock/tests/alloc_nid_api.c
+++ b/tools/testing/memblock/tests/alloc_nid_api.c
@@ -1142,10 +1142,8 @@ static int alloc_try_nid_cap_min_check(void)
 static int alloc_try_nid_min_reserved_check(void)
 {
 	test_print("\tRunning %s...\n", __func__);
-	memblock_set_bottom_up(false);
-	alloc_try_nid_min_reserved_generic_check();
-	memblock_set_bottom_up(true);
-	alloc_try_nid_min_reserved_generic_check();
+	run_top_down(alloc_try_nid_min_reserved_generic_check);
+	run_bottom_up(alloc_try_nid_min_reserved_generic_check);
 
 	return 0;
 }
@@ -1153,10 +1151,8 @@ static int alloc_try_nid_min_reserved_check(void)
 static int alloc_try_nid_max_reserved_check(void)
 {
 	test_print("\tRunning %s...\n", __func__);
-	memblock_set_bottom_up(false);
-	alloc_try_nid_max_reserved_generic_check();
-	memblock_set_bottom_up(true);
-	alloc_try_nid_max_reserved_generic_check();
+	run_top_down(alloc_try_nid_max_reserved_generic_check);
+	run_bottom_up(alloc_try_nid_max_reserved_generic_check);
 
 	return 0;
 }
@@ -1164,10 +1160,8 @@ static int alloc_try_nid_max_reserved_check(void)
 static int alloc_try_nid_exact_address_check(void)
 {
 	test_print("\tRunning %s...\n", __func__);
-	memblock_set_bottom_up(false);
-	alloc_try_nid_exact_address_generic_check();
-	memblock_set_bottom_up(true);
-	alloc_try_nid_exact_address_generic_check();
+	run_top_down(alloc_try_nid_exact_address_generic_check);
+	run_bottom_up(alloc_try_nid_exact_address_generic_check);
 
 	return 0;
 }
@@ -1175,10 +1169,8 @@ static int alloc_try_nid_exact_address_check(void)
 static int alloc_try_nid_reserved_full_merge_check(void)
 {
 	test_print("\tRunning %s...\n", __func__);
-	memblock_set_bottom_up(false);
-	alloc_try_nid_reserved_full_merge_generic_check();
-	memblock_set_bottom_up(true);
-	alloc_try_nid_reserved_full_merge_generic_check();
+	run_top_down(alloc_try_nid_reserved_full_merge_generic_check);
+	run_bottom_up(alloc_try_nid_reserved_full_merge_generic_check);
 
 	return 0;
 }
@@ -1186,10 +1178,8 @@ static int alloc_try_nid_reserved_full_merge_check(void)
 static int alloc_try_nid_reserved_all_check(void)
 {
 	test_print("\tRunning %s...\n", __func__);
-	memblock_set_bottom_up(false);
-	alloc_try_nid_reserved_all_generic_check();
-	memblock_set_bottom_up(true);
-	alloc_try_nid_reserved_all_generic_check();
+	run_top_down(alloc_try_nid_reserved_all_generic_check);
+	run_bottom_up(alloc_try_nid_reserved_all_generic_check);
 
 	return 0;
 }
@@ -1197,10 +1187,8 @@ static int alloc_try_nid_reserved_all_check(void)
 static int alloc_try_nid_low_max_check(void)
 {
 	test_print("\tRunning %s...\n", __func__);
-	memblock_set_bottom_up(false);
-	alloc_try_nid_low_max_generic_check();
-	memblock_set_bottom_up(true);
-	alloc_try_nid_low_max_generic_check();
+	run_top_down(alloc_try_nid_low_max_generic_check);
+	run_bottom_up(alloc_try_nid_low_max_generic_check);
 
 	return 0;
 }
diff --git a/tools/testing/memblock/tests/common.h b/tools/testing/memblock/tests/common.h
index 93e559780890..c53f9c365714 100644
--- a/tools/testing/memblock/tests/common.h
+++ b/tools/testing/memblock/tests/common.h
@@ -100,4 +100,20 @@ static inline void test_pass_pop(void)
 	prefix_pop();
 }
 
+static inline void run_top_down(int (*func)())
+{
+	memblock_set_bottom_up(false);
+	prefix_push("top-down");
+	func();
+	prefix_pop();
+}
+
+static inline void run_bottom_up(int (*func)())
+{
+	memblock_set_bottom_up(true);
+	prefix_push("bottom-up");
+	func();
+	prefix_pop();
+}
+
 #endif
-- 
2.25.1

