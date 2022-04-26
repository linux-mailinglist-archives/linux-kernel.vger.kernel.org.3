Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D05D2510AAD
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 22:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355091AbiDZUmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 16:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355071AbiDZUmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 16:42:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF30C7A9B5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 13:38:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B3DCAB82327
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 20:38:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E726FC385AF;
        Tue, 26 Apr 2022 20:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651005531;
        bh=HHKeB02EgCdGBUKl47/DzUNIx/8bb6mqSCa+8N53rZQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Qk42HV6BFB3rbtCUB0gZoaOgEHm2n/PzxA7mbTRQdb+6IXCrRCSIU8hs23vE3A0Eh
         8hLcjBP4FM4RstTEKPg+EX64pqapRr1LRpRt4x5QrWboE46evIra21scwK3jlSAeeV
         af6ur9taHVDHjUlk4kol/MjKP01cl8GvcwNmhvQdY1agWS5hYKr/bpWkQLtnpxNem2
         D81bb7JC8sc+pvEhmX+ocrHA+iBIODe2P/GszZPjc7JMR7mHBfvDJ2LO8INUUGf0gL
         Uyc3+jl8Fay45kn08CSiuVOenaOszzpi64Ps0x7igL2YY9FAawqc6Nu3qouAm+QV7g
         vXk1L8doaCtBw==
From:   sj@kernel.org
To:     akpm@linux-foundation.org
Cc:     linux-damon@amazon.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sj@kernel.org>
Subject: [PATCH 1/4] mm/damon/core: add a function for damon_operations registration checks
Date:   Tue, 26 Apr 2022 20:38:40 +0000
Message-Id: <20220426203843.45238-2-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220426203843.45238-1-sj@kernel.org>
References: <20220426203843.45238-1-sj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sj@kernel.org>

To know if a specific 'damon_operations' is registered, users need to
check the kernel config or try 'damon_select_ops()' with the ops of the
question, and then see if it successes.  In the latter case, the user
should also revert the change.  To make the process simple and
convenient, this commit adds a function for checking if a specific
'damon_operations' is registered or not.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h |  1 +
 mm/damon/core.c       | 24 +++++++++++++++++++++---
 2 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index f23cbfa4248d..73ff0e2d2a4d 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -509,6 +509,7 @@ int damon_set_attrs(struct damon_ctx *ctx, unsigned long sample_int,
 int damon_set_schemes(struct damon_ctx *ctx,
 			struct damos **schemes, ssize_t nr_schemes);
 int damon_nr_running_ctxs(void);
+bool damon_is_registered_ops(enum damon_ops_id id);
 int damon_register_ops(struct damon_operations *ops);
 int damon_select_ops(struct damon_ctx *ctx, enum damon_ops_id id);
 
diff --git a/mm/damon/core.c b/mm/damon/core.c
index ca6124eb6516..5c1331f93c2e 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -30,7 +30,7 @@ static DEFINE_MUTEX(damon_ops_lock);
 static struct damon_operations damon_registered_ops[NR_DAMON_OPS];
 
 /* Should be called under damon_ops_lock with id smaller than NR_DAMON_OPS */
-static bool damon_registered_ops_id(enum damon_ops_id id)
+static bool __damon_is_registered_ops(enum damon_ops_id id)
 {
 	struct damon_operations empty_ops = {};
 
@@ -39,6 +39,24 @@ static bool damon_registered_ops_id(enum damon_ops_id id)
 	return true;
 }
 
+/**
+ * damon_is_registered_ops() - Check if a given damon_operations is registered.
+ * @id:	Id of the damon_operations to check if registered.
+ *
+ * Return: true if the ops is set, false otherwise.
+ */
+bool damon_is_registered_ops(enum damon_ops_id id)
+{
+	bool registered;
+
+	if (id >= NR_DAMON_OPS)
+		return false;
+	mutex_lock(&damon_ops_lock);
+	registered = __damon_is_registered_ops(id);
+	mutex_unlock(&damon_ops_lock);
+	return registered;
+}
+
 /**
  * damon_register_ops() - Register a monitoring operations set to DAMON.
  * @ops:	monitoring operations set to register.
@@ -56,7 +74,7 @@ int damon_register_ops(struct damon_operations *ops)
 		return -EINVAL;
 	mutex_lock(&damon_ops_lock);
 	/* Fail for already registered ops */
-	if (damon_registered_ops_id(ops->id)) {
+	if (__damon_is_registered_ops(ops->id)) {
 		err = -EINVAL;
 		goto out;
 	}
@@ -84,7 +102,7 @@ int damon_select_ops(struct damon_ctx *ctx, enum damon_ops_id id)
 		return -EINVAL;
 
 	mutex_lock(&damon_ops_lock);
-	if (!damon_registered_ops_id(id))
+	if (!__damon_is_registered_ops(id))
 		err = -EINVAL;
 	else
 		ctx->ops = damon_registered_ops[id];
-- 
2.25.1

