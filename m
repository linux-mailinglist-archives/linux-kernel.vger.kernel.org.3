Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 750BD4B7840
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:51:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243212AbiBOSq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 13:46:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233912AbiBOSqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 13:46:51 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CAE32B1BA
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 10:46:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B3A9B61686
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 18:46:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0F86C340EC;
        Tue, 15 Feb 2022 18:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644950800;
        bh=AxnbO0uNmq3XAyTYYIhSWm/tXyJR3KLtDqV4YrpqgG4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NtlRdCapi8bHoDNqbL5gqE2Cskucm55p+rh4cz/gyh4wXmjdxWNu+guDCAu6lfnoc
         ZIAtU+BfSa9pg3dYXdyPNEO6T8TVcFhIRlneaFSKrXecQjkb4YRtURlC1Wuo7fLeTz
         OX+ZK0gjikz9x9IrB0ih5lmYGTRejcANx/HYlDQESvb7vLUBOPeEw62LUyIc01Afc4
         GhwuyPnu6C9uYQlBy/uPWl+W7d7pCcQDE4emOI8JZvIAlZCeaXRY4dkcpthpED06q1
         JuSDNXDGeSqOeSuhGdLxlOr4fdFXCmsoMtj3wCz0j16gD6fj5EZSIN/JZZo2OOd1ym
         Op9Xwo0Edz/6w==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     xhao@linux.alibaba.com, rientjes@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sj@kernel.org>
Subject: [PATCH 3/8] mm/damon/paddr,vaddr: Register themselves to DAMON in subsys_initcall
Date:   Tue, 15 Feb 2022 18:45:58 +0000
Message-Id: <20220215184603.1479-4-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220215184603.1479-1-sj@kernel.org>
References: <20220215184603.1479-1-sj@kernel.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit makes the monitoring operations for the physical address
space and virtual address spaces register themselves to DAMON in the
subsys_initcall step.  Later, in-kernel DAMON user code can use them via
damon_select_ops() without have to unnecessarily depend on all possible
monitoring operations implementations.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/paddr.c | 20 ++++++++++++++++++++
 mm/damon/vaddr.c | 20 ++++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 9f0abd0369bc..d968bb38bd5d 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -273,3 +273,23 @@ void damon_pa_set_operations(struct damon_ctx *ctx)
 	ctx->ops.apply_scheme = damon_pa_apply_scheme;
 	ctx->ops.get_scheme_score = damon_pa_scheme_score;
 }
+
+static int __init damon_pa_initcall(void)
+{
+	struct damon_operations ops = {
+		.id = DAMON_OPS_PADDR,
+		.init = NULL,
+		.update = NULL,
+		.prepare_access_checks = damon_pa_prepare_access_checks,
+		.check_accesses = damon_pa_check_accesses,
+		.reset_aggregated = NULL,
+		.target_valid = damon_pa_target_valid,
+		.cleanup = NULL,
+		.apply_scheme = damon_pa_apply_scheme,
+		.get_scheme_score = damon_pa_scheme_score,
+	};
+
+	return damon_register_ops(&ops);
+};
+
+subsys_initcall(damon_pa_initcall);
diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index c0eb32025f9b..87475ba37bec 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -752,4 +752,24 @@ void damon_va_set_operations(struct damon_ctx *ctx)
 	ctx->ops.get_scheme_score = damon_va_scheme_score;
 }
 
+static int __init damon_va_initcall(void)
+{
+	struct damon_operations ops = {
+		.id = DAMON_OPS_VADDR,
+		.init = damon_va_init,
+		.update = damon_va_update,
+		.prepare_access_checks = damon_va_prepare_access_checks,
+		.check_accesses = damon_va_check_accesses,
+		.reset_aggregated = NULL,
+		.target_valid = damon_va_target_valid,
+		.cleanup = NULL,
+		.apply_scheme = damon_va_apply_scheme,
+		.get_scheme_score = damon_va_scheme_score,
+	};
+
+	return damon_register_ops(&ops);
+};
+
+subsys_initcall(damon_va_initcall);
+
 #include "vaddr-test.h"
-- 
2.17.1

