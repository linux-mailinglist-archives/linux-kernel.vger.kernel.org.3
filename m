Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F34ED58DF02
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 20:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238674AbiHIS3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 14:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347093AbiHIS0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 14:26:54 -0400
Received: from polaris.svanheule.net (polaris.svanheule.net [84.16.241.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39AD533377
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 11:09:41 -0700 (PDT)
Received: from terra.. (unknown [IPv6:2a02:a03f:eaf9:8401:aa9f:5d01:1b2a:e3cd])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id 2E0DE308D13;
        Tue,  9 Aug 2022 20:09:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1660068557;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Nau94dYsf4y1ti1nlcly5/cLda+IBYo2RljEiam9p0o=;
        b=v0lV/lgiaiGtL8/Ye+KXbvOcve3nWqbXYD5M0ShYPtHuU6PayuRYN7FZgb7Hmt32Umt9uU
        q0uz/8P4N0OOITSReiX740dWxNz5sH/Eljnglsc/kf0CkETxygkwy9g0kh3PANzINvqxkR
        T/unPxXi6bDZTCS322quXtcaC7HYin5KL8DQBEDR7u9qZ+V+QSvzGGHlqzXi0rMaqMSzjQ
        ysOuBaqHRCSIawgnEK0iAr+L1iTtPo38NXLBK6g3i+WaKnHvOoRoF3dxE+eOXM4eUCJ+qj
        136G427/RrGW+QPt/EDwc8wxpHbLjolJPZNPZr3FISO/FI5l7AKJxnY8dmKQ0A==
From:   Sander Vanheule <sander@svanheule.net>
To:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?Ma=C3=ADra=20Canal?= <mairacanal@riseup.net>,
        David Gow <davidgow@google.com>,
        Sander Vanheule <sander@svanheule.net>
Subject: [PATCH v1 4/5] lib/cpumask_kunit: log mask contents
Date:   Tue,  9 Aug 2022 20:08:54 +0200
Message-Id: <1c111f549d3c84a6fa5a96b19b17f89938314265.1660068429.git.sander@svanheule.net>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <cover.1660068429.git.sander@svanheule.net>
References: <cover.1660068429.git.sander@svanheule.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For extra context, log the contents of the masks under test.  This
should help with finding out why a certain test fails.

Link: https://lore.kernel.org/lkml/CABVgOSkPXBc-PWk1zBZRQ_Tt+Sz1ruFHBj3ixojymZF=Vi4tpQ@mail.gmail.com/
Suggested-by: David Gow <davidgow@google.com>
Signed-off-by: Sander Vanheule <sander@svanheule.net>
---
 lib/cpumask_kunit.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/lib/cpumask_kunit.c b/lib/cpumask_kunit.c
index 4d353614d853..0f8059a5e93b 100644
--- a/lib/cpumask_kunit.c
+++ b/lib/cpumask_kunit.c
@@ -51,6 +51,10 @@
 static cpumask_t mask_empty;
 static cpumask_t mask_all;
 
+#define STR_MASK(m)			#m
+#define TEST_CPUMASK_PRINT(test, mask)	\
+	kunit_info(test, "%s = '%*pbl'\n", STR_MASK(mask), nr_cpumask_bits, cpumask_bits(mask))
+
 static void test_cpumask_weight(struct kunit *test)
 {
 	KUNIT_EXPECT_TRUE(test, cpumask_empty(&mask_empty));
@@ -103,6 +107,9 @@ static void test_cpumask_iterators_builtin(struct kunit *test)
 	/* Ensure the dynamic masks are stable while running the tests */
 	cpu_hotplug_disable();
 
+	TEST_CPUMASK_PRINT(test, cpu_online_mask);
+	TEST_CPUMASK_PRINT(test, cpu_present_mask);
+
 	EXPECT_FOR_EACH_CPU_BUILTIN_EQ(test, online);
 	EXPECT_FOR_EACH_CPU_BUILTIN_EQ(test, present);
 
@@ -114,6 +121,9 @@ static int test_cpumask_init(struct kunit *test)
 	cpumask_clear(&mask_empty);
 	cpumask_setall(&mask_all);
 
+	TEST_CPUMASK_PRINT(test, &mask_all);
+	TEST_CPUMASK_PRINT(test, cpu_possible_mask);
+
 	return 0;
 }
 
-- 
2.37.1

