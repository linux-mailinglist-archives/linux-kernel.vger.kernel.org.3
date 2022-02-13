Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03A1D4B3C56
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 18:00:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237164AbiBMQ6q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 11:58:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233353AbiBMQ6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 11:58:43 -0500
Received: from conuserg-10.nifty.com (conuserg-10.nifty.com [210.131.2.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B8885BD1D
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 08:58:37 -0800 (PST)
Received: from grover.. (133-32-232-101.west.xps.vectant.ne.jp [133.32.232.101]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id 21DGvOv1024736;
        Mon, 14 Feb 2022 01:57:26 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 21DGvOv1024736
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1644771446;
        bh=hIVC4AhxMlJhMCnHKtzcF7VW11ouoZYw9CyOXVqFAR8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oht/7x5KxG+eahVPm43ZlsHSN22/C+TyujYyGMhv+t1y0u/uYg8kawlz6jmXnyZkc
         gZSYZ0zpA5pBLxHS/GVmKsa8MZftDovzVAdaOIlCbZnZnivTGNR15SnyPgREhxB//P
         3JiyzEvBmfFG5wrKzwWwHSKLFTBjcCQPDbzZt6jHiXpbE1Z1THaFxB2EWFY0qb0Z6Q
         W8mfWmvMjsk67UeKOR1hJ81Ioeaa/aBuxlKPMfmPbCnbY5JypeOOy0olXZF+QDFzKV
         YBcVc5DsqWb6649NkV24oeBS+TOL1won/JFgUuxEjlxKe9hNYvHhGjQT3l7KbKWBzs
         pUR83ji9ulzkg==
X-Nifty-SrcIP: [133.32.232.101]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Jason Baron <jbaron@akamai.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH 2/2] jump_label: refactor #ifdef of struct static_key
Date:   Mon, 14 Feb 2022 01:57:17 +0900
Message-Id: <20220213165717.2354046-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220213165717.2354046-1-masahiroy@kernel.org>
References: <20220213165717.2354046-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move #ifdef CONFIG_JUMP_LABEL inside the struct static_key.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 include/linux/jump_label.h | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/include/linux/jump_label.h b/include/linux/jump_label.h
index 6924e6837e6d..107751cc047b 100644
--- a/include/linux/jump_label.h
+++ b/include/linux/jump_label.h
@@ -82,10 +82,9 @@ extern bool static_key_initialized;
 				    "%s(): static key '%pS' used before call to jump_label_init()", \
 				    __func__, (key))
 
-#ifdef CONFIG_JUMP_LABEL
-
 struct static_key {
 	atomic_t enabled;
+#ifdef CONFIG_JUMP_LABEL
 /*
  * Note:
  *   To make anonymous unions work with old compilers, the static
@@ -104,13 +103,9 @@ struct static_key {
 		struct jump_entry *entries;
 		struct static_key_mod *next;
 	};
+#endif	/* CONFIG_JUMP_LABEL */
 };
 
-#else
-struct static_key {
-	atomic_t enabled;
-};
-#endif	/* CONFIG_JUMP_LABEL */
 #endif /* __ASSEMBLY__ */
 
 #ifdef CONFIG_JUMP_LABEL
-- 
2.32.0

