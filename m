Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD696591E8F
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 07:54:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239676AbiHNFyZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 01:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbiHNFyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 01:54:14 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80FA357253
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 22:54:13 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id b142so902073iof.10
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 22:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=ILkgh0s9flepsTVscJySAOnLBbfijO6Q0jsQRVlYp2g=;
        b=Vmr56r0E5Gp4w6hx+69k1/OoBNKL31qc26DEssO6j746fCOQeaXJ1y7eR35X6Lu+iR
         yLPsywCQjNweOfw3f60pBB3KT+swWKNgHIb9M2JKyws27ADmuBF3vQ5EGrDBCFOvp94n
         8Mrmgtymaeqmp9K+3ADADVJVQYB6DMku1TfojSy9tYj9tErA7UfUNcXGu8NANCVlm3gg
         eUyfyGfE+gDOkmfSWkuV07OFR0OdRoXIrImM/2edpDVK7jgvUUmjGaX87eFHO9TWkhwt
         bcbjpdDnO7WqNixSsr1Pm9NJ+1yZdSV7RoNvmCsnI9iDPvA52xW1cGxnrTt6X2Q8vSPG
         Fxkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=ILkgh0s9flepsTVscJySAOnLBbfijO6Q0jsQRVlYp2g=;
        b=cahB49qf98uMNPXpIWL2L3Zw028JtpukFa6rxsXDfhaL2YB+UymuLuTPdIWiBW1W+f
         CQXiUjvJE6xwYtmWhqzeXg35DQOURG0HjRmOYNHKFdBKtzPs2injUkD4HTO0Vhp1YZbP
         NtOQ1COihn8tBnGe34jFVpVzaUwVX46pwOsyaDQmpHnbBNnJ8x0DOxgVngiICoLcpQ8y
         VVpXAexXFplv57xoWsHcHgtBV25KMmJegRsoDBx4NVVZGlVqTJLk8uI76IxO0y6UjbG/
         cvt06qt4rbHBxySOPp2WFXRBWOU096MRihM09h4JWNRO5lURquznk/iqZljN8P3xEuIf
         zQyQ==
X-Gm-Message-State: ACgBeo3xvUOFXXkv4Bf6sTjvcuFfkG6imFl1DFqfUnu1XOx758/q8HoO
        gWVHuhinkWSvWQomkhRMbMA=
X-Google-Smtp-Source: AA6agR5fSwtKF6fFIiIsxq3c073b8Pn8UpWGkfynSd8Toy4ruDAyb4ubeD7yMxLK1FxRc9MmfARtoA==
X-Received: by 2002:a05:6638:250d:b0:340:4915:263 with SMTP id v13-20020a056638250d00b0034049150263mr4792485jat.17.1660456452707;
        Sat, 13 Aug 2022 22:54:12 -0700 (PDT)
Received: from sophie (static-198-54-128-70.cust.tzulo.com. [198.54.128.70])
        by smtp.gmail.com with ESMTPSA id x7-20020a056602160700b0067be3f195bcsm3197871iow.5.2022.08.13.22.54.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Aug 2022 22:54:12 -0700 (PDT)
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Rebecca Mckeever <remckee0@gmail.com>
Subject: [PATCH 3/8] memblock tests: add labels to verbose output for generic alloc tests
Date:   Sun, 14 Aug 2022 00:53:55 -0500
Message-Id: <d4d2a848668f92dbea697402eeaced3a9c7785ba.1660454730.git.remckee0@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1660454730.git.remckee0@gmail.com>
References: <cover.1660454730.git.remckee0@gmail.com>
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
index 71c89cb9b2a8..73c2c43e702a 100644
--- a/tools/testing/memblock/tests/alloc_api.c
+++ b/tools/testing/memblock/tests/alloc_api.c
@@ -752,10 +752,8 @@ static int alloc_after_check(void)
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
@@ -774,10 +772,8 @@ static int alloc_second_fit_check(void)
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
@@ -785,10 +781,8 @@ static int alloc_small_gaps_check(void)
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
@@ -796,10 +790,8 @@ static int alloc_all_reserved_check(void)
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
@@ -807,10 +799,8 @@ static int alloc_no_space_check(void)
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
@@ -818,10 +808,8 @@ static int alloc_limited_space_check(void)
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
index 7a16a7dc8f2c..e0dd5b410099 100644
--- a/tools/testing/memblock/tests/common.h
+++ b/tools/testing/memblock/tests/common.h
@@ -101,4 +101,20 @@ static inline void test_pass_pop(void)
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

