Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F25F0539984
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 00:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348417AbiEaWaE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 18:30:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244800AbiEaW3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 18:29:55 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02F2C9D4F1
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 15:29:55 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id s188so319676oie.4
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 15:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Pbw+0jsKWhRJki7yieC0UBF0GyCIgfnjgJoaKW5BNB8=;
        b=jPZNNPJCCS1Mp8YIDlUrMaG7kRuMY3eFi28K1eoc2Rk2Y8VjGLCypDCYsf8I7ndblT
         im+c+e83B610XfZ5QztkzD3/C/D/fAWJjnT+ePBZFaz16N/3AUP+EAxW0g4X4e2obbqg
         PX1OYw2HLADr7Gr5YwippHswKmp/6QzrCTTxLm3uAsMZ4CuxOS2vjqU6nsRdCpC3wjCD
         I/6e/XjxU1hYW+AYpFWDBdoTRhDIbWGybJGJuKz59NeO71/tBloQ9GM9YrdfaAOmiNOG
         yFAMq13PziPvpcuOWuw3nw+Lor9aGb5jwjkiT58umtDQAev3gB61FdMy3smwANqomPME
         3epA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=Pbw+0jsKWhRJki7yieC0UBF0GyCIgfnjgJoaKW5BNB8=;
        b=gGgfyZlxuIJ4PLDYU+NU/npGz5uX/fq/fOtEy1WqhBhipksmYJNl7PpIkObHgrYqUC
         B4/rU1jE53i2PAkYcKAzq0ISluFFAWPdaBfpMQh8fqTmElUKFTQUH6te5EL3q/2Ak7g+
         p8e/Vstwv6OfUz0j1a1SgteKAFquz3MnD46+/dyx6Ir96411S6w2VNk0xhDXVDHNZlby
         bSCWkSLIccubXQHQOOHuHx+bicMG7UMOjBGAyrYvUWtxuBD5jvD5fCLoYo+LSBR/yKmF
         wL/nbyKuNpAKx/KEteAFJRJSuA84vB4IeOLHapbksHmzOHoHXRReoGaNsEaR0335A943
         +iFQ==
X-Gm-Message-State: AOAM530x9HTtxdBh6tiK+xARWis9lQUEQE5KlHGZ9CruC4jVittYd6hy
        ZY10lnyOtRwZkPQ0tshYDNKie5wWj00=
X-Google-Smtp-Source: ABdhPJwsSqoPfBxudtRP+82vlvVUbSr+vavGOO2krfCdLJtITblyPUlCAJSc3gcg1crKcMyARqm8SQ==
X-Received: by 2002:a05:6808:1187:b0:322:2756:e23b with SMTP id j7-20020a056808118700b003222756e23bmr13683957oil.211.1654036194360;
        Tue, 31 May 2022 15:29:54 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c11-20020a4aaccb000000b0035eb4e5a6bbsm76185oon.17.2022.05.31.15.29.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 15:29:53 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] lib/list_debug.c: Detect uninitialized lists
Date:   Tue, 31 May 2022 15:29:51 -0700
Message-Id: <20220531222951.92073-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some circumstances, attempts are made to add entries to or to remove
entries from an uninitialized list. A prime example is
amdgpu_bo_vm_destroy(): It is indirectly called from ttm_bo_init_reserved()
if that function fails, and tries to remove an entry from a list. However,
that list is only initialized in amdgpu_bo_create_vm() after the call to
ttm_bo_init_reserved() returned success. This results in crashes such as

 BUG: kernel NULL pointer dereference, address: 0000000000000000
 #PF: supervisor read access in kernel mode
 #PF: error_code(0x0000) - not-present page
 PGD 0 P4D 0
 Oops: 0000 [#1] PREEMPT SMP NOPTI
 CPU: 1 PID: 1479 Comm: chrome Not tainted 5.10.110-15768-g29a72e65dae5
 Hardware name: Google Grunt/Grunt, BIOS Google_Grunt.11031.149.0 07/15/2020
 RIP: 0010:__list_del_entry_valid+0x26/0x7d
 ...
 Call Trace:
  amdgpu_bo_vm_destroy+0x48/0x8b
  ttm_bo_init_reserved+0x1d7/0x1e0
  amdgpu_bo_create+0x212/0x476
  ? amdgpu_bo_user_destroy+0x23/0x23
  ? kmem_cache_alloc+0x60/0x271
  amdgpu_bo_create_vm+0x40/0x7d
  amdgpu_vm_pt_create+0xe8/0x24b
 ...

Check if the list's prev and next pointers are NULL to catch such problems.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 lib/list_debug.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/lib/list_debug.c b/lib/list_debug.c
index 9daa3fb9d1cd..d98d43f80958 100644
--- a/lib/list_debug.c
+++ b/lib/list_debug.c
@@ -20,7 +20,11 @@
 bool __list_add_valid(struct list_head *new, struct list_head *prev,
 		      struct list_head *next)
 {
-	if (CHECK_DATA_CORRUPTION(next->prev != prev,
+	if (CHECK_DATA_CORRUPTION(prev == NULL,
+			"list_add corruption. prev is NULL.\n") ||
+	    CHECK_DATA_CORRUPTION(next == NULL,
+			"list_add corruption. next is NULL.\n") ||
+	    CHECK_DATA_CORRUPTION(next->prev != prev,
 			"list_add corruption. next->prev should be prev (%px), but was %px. (next=%px).\n",
 			prev, next->prev, next) ||
 	    CHECK_DATA_CORRUPTION(prev->next != next,
@@ -42,7 +46,11 @@ bool __list_del_entry_valid(struct list_head *entry)
 	prev = entry->prev;
 	next = entry->next;
 
-	if (CHECK_DATA_CORRUPTION(next == LIST_POISON1,
+	if (CHECK_DATA_CORRUPTION(next == NULL,
+			"list_del corruption, %px->next is NULL\n", entry) ||
+	    CHECK_DATA_CORRUPTION(prev == NULL,
+			"list_del corruption, %px->prev is NULL\n", entry) ||
+	    CHECK_DATA_CORRUPTION(next == LIST_POISON1,
 			"list_del corruption, %px->next is LIST_POISON1 (%px)\n",
 			entry, LIST_POISON1) ||
 	    CHECK_DATA_CORRUPTION(prev == LIST_POISON2,
-- 
2.35.1

