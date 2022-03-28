Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 452B54EA323
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 00:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbiC1WnQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 18:43:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbiC1WnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 18:43:08 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 404234C780
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 15:41:26 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id r23so18676553edb.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 15:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GRHi/OtSBCt6i9Ze3XsHhAvhKrkQLsqtf5JkZ46TIHw=;
        b=HC3lZA2030sel7eGzQjzeZTPKD/T77jFt1fOvPEvsEAuc7OhlOUqkVzEzA0b8Ej10v
         wriueMjHJ4pRyy6UyfoovIaMG6xAUmXLcFa9tFBN/AasMC5OkBA3oBHgwy3b4sZChiew
         5Uc7H3K/oaIQsha0zZeKqzL1CKJ3WPQhB3jYk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GRHi/OtSBCt6i9Ze3XsHhAvhKrkQLsqtf5JkZ46TIHw=;
        b=L1LQWP72vxsHn6vhvYvuJtkOGS4y/67XSs44xWfdpKKsRtGts8zmNzOqqf8BaT3319
         RJX1IjifmkaAcRCw50ZIU+mvgTnuOhj3V5DLpOVSweHyz/2bByg3MtecGO2AUI6gRNZ9
         e2qJtyrcRdtPyUoHBwqASX4TfAxRf2zJThQ8m5mYEUhWH3zUk+lJ0UPXetc0X05VZr8G
         /Cx4sSkciQJW0FNUbO1VZ3+lqaJ5UGYGGS+PY8JLQFzyZFSvCqXsqNBpj0IwV+ny25M4
         O0dr0v9jh4kmnnzeYrM+2vih4opVDuawhyH3tAJIKS/pvdM0Af9fgM2hqSWyMryygiOj
         DaKQ==
X-Gm-Message-State: AOAM530NDlLzLsNIQ96y7ZvhQkGj0OMZwjV9aM1oPC7QlTnMvPMY9xgJ
        LWdxexXuZb8Qiezsq4FZ1lIoAA==
X-Google-Smtp-Source: ABdhPJz1iHXplqU3W3ScsxqAOHyjo8Am2H1kbpVvalbCw35xSFWOUtD/st0DdaumqwmPIshy+lF5sA==
X-Received: by 2002:a05:6402:42c6:b0:419:276c:4a64 with SMTP id i6-20020a05640242c600b00419276c4a64mr179904edc.119.1648507284839;
        Mon, 28 Mar 2022 15:41:24 -0700 (PDT)
Received: from localhost.localdomain ([80.208.64.233])
        by smtp.gmail.com with ESMTPSA id m3-20020a17090679c300b006cf9ce53354sm6392714ejo.190.2022.03.28.15.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 15:41:24 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andy@kernel.org>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] lib/test_string.c: add strspn and strcspn tests
Date:   Tue, 29 Mar 2022 00:41:18 +0200
Message-Id: <20220328224119.3003834-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before refactoring strspn() and strcspn(), add some simple test cases.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 lib/test_string.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/lib/test_string.c b/lib/test_string.c
index 9dfd6f52de92..c5cb92fb710e 100644
--- a/lib/test_string.c
+++ b/lib/test_string.c
@@ -179,6 +179,34 @@ static __init int strnchr_selftest(void)
 	return 0;
 }
 
+static __init int strspn_selftest(void)
+{
+	static const struct strspn_test {
+		const char str[16];
+		const char accept[16];
+		const char reject[16];
+		unsigned a;
+		unsigned r;
+	} tests[] __initconst = {
+		{ "foobar", "", "", 0, 6 },
+		{ "abba", "abc", "ABBA", 4, 4 },
+		{ "abba", "a", "b", 1, 1 },
+		{ "", "abc", "abc", 0, 0},
+	};
+	const struct strspn_test *s = tests;
+	size_t i, res;
+
+	for (i = 0; i < ARRAY_SIZE(tests); ++i, ++s) {
+		res = strspn(s->str, s->accept);
+		if (res != s->a)
+			return 0x100 + 2*i;
+		res = strcspn(s->str, s->reject);
+		if (res != s->r)
+			return 0x100 + 2*i + 1;
+	}
+	return 0;
+}
+
 static __exit void string_selftest_remove(void)
 {
 }
@@ -212,6 +240,11 @@ static __init int string_selftest_init(void)
 	if (subtest)
 		goto fail;
 
+	test = 6;
+	subtest = strspn_selftest();
+	if (subtest)
+		goto fail;
+
 	pr_info("String selftests succeeded\n");
 	return 0;
 fail:
-- 
2.31.1

