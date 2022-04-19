Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F5C4506C3F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 14:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352248AbiDSMZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 08:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236037AbiDSMZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 08:25:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EACF2A245
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 05:22:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AD717614F4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 12:22:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FBFDC385A7;
        Tue, 19 Apr 2022 12:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650370955;
        bh=dJPTLzgLBC9vMmTemXXBEDuiK/EVQA9bANSfzdNMn88=;
        h=From:To:Cc:Subject:Date:From;
        b=iYWsE0DDylqFD8v4bb036izvswIpFHFtuW/CRlISTdTMSIzmPb1Yvr8pZvpdxe8QM
         T/wLzwDXgtqbr6GZpcFK6YXFb9DxKb4PLt4qW2V22NC/KRXd0gDxJHna6MRlUHkbKz
         l2BYWH4T5GAB6z7/bvxUaJchObIZ3qc3oFtdP2dU2OK9BgJBqoUpw6/WGfjcgeHbdZ
         p2C2yGWDfn6DYYKLFsfXDjOAGHiP+Uj9aIzysQVxWBZtWv8cqJkqcZurIqxdiu55Jq
         QIN9iEwMfmVPe9Ga9xjMOyVarbVtZafzRWXbSykQSdRjzSjXNuFNqVfdLCEll0vv0u
         TWrAEeKOdZRCg==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     brendanhiggins@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sj@kernel.org>
Subject: [PATCH] mm/damon/core-test: Add a kunit test case for ops registration
Date:   Tue, 19 Apr 2022 12:22:25 +0000
Message-Id: <20220419122225.290518-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds a simple kunit test case for DAMON operations
registration feature.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core-test.h | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/mm/damon/core-test.h b/mm/damon/core-test.h
index b4085deb9fa0..573669566f84 100644
--- a/mm/damon/core-test.h
+++ b/mm/damon/core-test.h
@@ -232,6 +232,41 @@ static void damon_test_split_regions_of(struct kunit *test)
 	damon_destroy_ctx(c);
 }
 
+static void damon_test_ops_registration(struct kunit *test)
+{
+	struct damon_ctx *c = damon_new_ctx();
+	struct damon_operations ops, bak;
+
+	/* DAMON_OPS_{V,P}ADDR are registered on subsys_initcall */
+	KUNIT_EXPECT_EQ(test, damon_select_ops(c, DAMON_OPS_VADDR), 0);
+	KUNIT_EXPECT_EQ(test, damon_select_ops(c, DAMON_OPS_PADDR), 0);
+
+	/* Double-registration is prohibited */
+	ops.id = DAMON_OPS_VADDR;
+	KUNIT_EXPECT_EQ(test, damon_register_ops(&ops), -EINVAL);
+	ops.id = DAMON_OPS_PADDR;
+	KUNIT_EXPECT_EQ(test, damon_register_ops(&ops), -EINVAL);
+
+	/* Unknown ops id cannot be registered */
+	KUNIT_EXPECT_EQ(test, damon_select_ops(c, NR_DAMON_OPS), -EINVAL);
+
+	/* Registration should success after unregistration */
+	mutex_lock(&damon_ops_lock);
+	bak = damon_registered_ops[DAMON_OPS_VADDR];
+	damon_registered_ops[DAMON_OPS_VADDR] = (struct damon_operations){};
+	mutex_unlock(&damon_ops_lock);
+
+	ops.id = DAMON_OPS_VADDR;
+	KUNIT_EXPECT_EQ(test, damon_register_ops(&ops), 0);
+
+	mutex_lock(&damon_ops_lock);
+	damon_registered_ops[DAMON_OPS_VADDR] = bak;
+	mutex_unlock(&damon_ops_lock);
+
+	/* Check double-registration failure again */
+	KUNIT_EXPECT_EQ(test, damon_register_ops(&ops), -EINVAL);
+}
+
 static struct kunit_case damon_test_cases[] = {
 	KUNIT_CASE(damon_test_target),
 	KUNIT_CASE(damon_test_regions),
@@ -240,6 +275,7 @@ static struct kunit_case damon_test_cases[] = {
 	KUNIT_CASE(damon_test_merge_two),
 	KUNIT_CASE(damon_test_merge_regions_of),
 	KUNIT_CASE(damon_test_split_regions_of),
+	KUNIT_CASE(damon_test_ops_registration),
 	{},
 };
 
-- 
2.25.1

