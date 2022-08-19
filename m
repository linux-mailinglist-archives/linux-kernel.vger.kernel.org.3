Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D91D55997B4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 10:49:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347594AbiHSIoI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 04:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347451AbiHSIoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 04:44:03 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FB8E6DFAB
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 01:44:02 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id w18so2838054qki.8
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 01:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=/AuZh6/EXSH4csd9kXJqbNQ5qfX/45Zmq2NrwoQlhOA=;
        b=UQp6NnGxVUdhiACYjgNV9DX95HS5blr4xke/sutLdPm+vXMaThK7VmVkT6mWU4Ch7p
         49BrJhLa5Z5xG+kGpMfwmWkqSmhtkaFoXXjXxIMLLqnwCFQPFkUnH/Qr/bh1n8seqksr
         O7Jk1yuvfCp5R6B1P1P25I+w5EOVDm10mqlg6cs2Sr2OsjwEP+yuCSZOxntOu6jeQdW0
         iz+/eWus/uOVZ4PqkosN2ja1fXKHazn1WyUhSIsDe0Tlq4m8eOd6th+TjcIxZqmxMrub
         Y3AUvBRRlhR7mTZKNJXqQ/D4KekqRe2VB/jxkGxep1YNtYtKlgllph4XtIlVOyfVfSpI
         vR/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=/AuZh6/EXSH4csd9kXJqbNQ5qfX/45Zmq2NrwoQlhOA=;
        b=kk+zdH7oxjlJaHRhux4aSGcXvWoqN5u+EdzZ5HK/0t1gFkIzWocWeSsecDgQ1VsrY2
         QqfZQNX+DxXtAegDiNI2F7HgR2GqiDU2Fm5jjeFYjVHuXmj+JrrahCaGFuRzyrxMD+yb
         gX1qa0Ta8VDqytQX7LMch9Z9+Yl11/n7A3HoksIXQwGzPzfExW6IcmnMCK0veYMnfESI
         77cQNPrOZTa08kcRJ3edRCy+5fXs1+HUL52uMQhOtfWahaWobzpc+vCbtu//igvIfL1P
         dTIBnJTc2YqbnLsbzhoGMdjgm3SERgxWINreDEerBiwy14ks1Hp9LXhmMrK4Nu0Pruyk
         kvLg==
X-Gm-Message-State: ACgBeo38ZRSy7YWecVCI931WHbGCw/BYgZbeZLuBtYWehPinyJ7t/rIn
        eZ/8aTECUVoCvLtSHAktzNI=
X-Google-Smtp-Source: AA6agR6mMCUz+yGW+fRODy/h7mLgQjqFYADzX2efdHIXyhGeBpHCWvxfi3CqauZM+dU6X51Dal0vrg==
X-Received: by 2002:a05:620a:4588:b0:6bb:50d4:7f7d with SMTP id bp8-20020a05620a458800b006bb50d47f7dmr4424643qkb.244.1660898641587;
        Fri, 19 Aug 2022 01:44:01 -0700 (PDT)
Received: from sophie ([89.46.62.64])
        by smtp.gmail.com with ESMTPSA id s13-20020a05620a254d00b006b633dc839esm3464833qko.66.2022.08.19.01.44.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 01:44:01 -0700 (PDT)
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Rebecca Mckeever <remckee0@gmail.com>
Subject: [PATCH v2 3/8] memblock tests: add labels to verbose output for generic alloc tests
Date:   Fri, 19 Aug 2022 01:34:51 -0700
Message-Id: <b68f49313bb64305b23168953a2802f27878f953.1660897732.git.remckee0@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1660897732.git.remckee0@gmail.com>
References: <cover.1660897732.git.remckee0@gmail.com>
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

Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>
---
 tools/testing/memblock/tests/alloc_api.c      | 36 +++++++------------
 .../memblock/tests/alloc_helpers_api.c        | 12 +++----
 tools/testing/memblock/tests/alloc_nid_api.c  | 36 +++++++------------
 tools/testing/memblock/tests/common.h         | 16 +++++++++
 4 files changed, 44 insertions(+), 56 deletions(-)

diff --git a/tools/testing/memblock/tests/alloc_api.c b/tools/testing/memblock/tests/alloc_api.c
index aefb67557de9..6a9c8e788cac 100644
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
index 796527cf3bd2..1ccf02639ad6 100644
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
index 71b7beb35526..82fa8ea36320 100644
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
index 29756e652e3e..58f84bf2c9ae 100644
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

