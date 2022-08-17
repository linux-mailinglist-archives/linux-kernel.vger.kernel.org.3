Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFD73596A92
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 09:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233559AbiHQHps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 03:45:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233272AbiHQHpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 03:45:33 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 303D079EE2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 00:45:32 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4M70PL3qVHzhXWh;
        Wed, 17 Aug 2022 15:43:18 +0800 (CST)
Received: from CHINA (10.175.102.38) by canpemm500009.china.huawei.com
 (7.192.105.203) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 17 Aug
 2022 15:45:29 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     Akinobu Mita <akinobu.mita@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Isabella Basso <isabbasso@riseup.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
CC:     Wei Yongjun <weiyongjun1@huawei.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 4/4 -next] fault-injection: make stacktrace filter works as expected
Date:   Wed, 17 Aug 2022 08:03:32 +0000
Message-ID: <20220817080332.1052710-5-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220817080332.1052710-1-weiyongjun1@huawei.com>
References: <20220817080332.1052710-1-weiyongjun1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.102.38]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

stacktrace filter is checked after others, such as fail-nth,
interval and probability. This make it doesn't work well as
expected.

Fix to running stacktrace filter before other filters. It will
speed up fault inject testing for driver modules.

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 lib/fault-inject.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/lib/fault-inject.c b/lib/fault-inject.c
index deca05e7c9b3..9dd1dd1d2610 100644
--- a/lib/fault-inject.c
+++ b/lib/fault-inject.c
@@ -105,10 +105,16 @@ static inline bool fail_stacktrace(struct fault_attr *attr)
 
 bool should_fail(struct fault_attr *attr, ssize_t size)
 {
+	bool stack_checked = false;
+
 	if (in_task()) {
 		unsigned int fail_nth = READ_ONCE(current->fail_nth);
 
 		if (fail_nth) {
+			if (!fail_stacktrace(attr))
+				return false;
+
+			stack_checked = true;
 			fail_nth--;
 			WRITE_ONCE(current->fail_nth, fail_nth);
 			if (!fail_nth)
@@ -128,6 +134,9 @@ bool should_fail(struct fault_attr *attr, ssize_t size)
 	if (atomic_read(&attr->times) == 0)
 		return false;
 
+	if (!stack_checked && !fail_stacktrace(attr))
+		return false;
+
 	if (atomic_read(&attr->space) > size) {
 		atomic_sub(size, &attr->space);
 		return false;
@@ -142,9 +151,6 @@ bool should_fail(struct fault_attr *attr, ssize_t size)
 	if (attr->probability <= prandom_u32() % 100)
 		return false;
 
-	if (!fail_stacktrace(attr))
-		return false;
-
 fail:
 	fail_dump(attr);
 
-- 
2.34.1

