Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38A28578F0B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 02:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236266AbiGSANp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 20:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236615AbiGSANj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 20:13:39 -0400
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3928F33E03
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 17:13:37 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1658189616;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ewIngwsCZaE/TDWKEzevD/ov9nRjvr0Ni51fNvRF6vM=;
        b=Ez4NK3MJ+4tuDDIgHgxsu4MiYUaqGfY5VOiQUKIwGvQBUsYJ7GKoPfKXc55qtCSds5QjTg
        zAvcXssV/9wWlJajGb7voWZ66ktaEQqD9D8S7tuhDWKIDHvuAmrTGk1WZ8B5A2lVn8f5Am
        9EtvJhAOrXSt/GHEyuJMYKNsxpPcuR4=
From:   andrey.konovalov@linux.dev
To:     Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com, Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Florian Mayer <fmayer@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH mm v2 21/33] kasan: cosmetic changes in report.c
Date:   Tue, 19 Jul 2022 02:10:01 +0200
Message-Id: <7b5f4b94b922c1753190886d0b6984bc1c16828f.1658189199.git.andreyknvl@google.com>
In-Reply-To: <cover.1658189199.git.andreyknvl@google.com>
References: <cover.1658189199.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Konovalov <andreyknvl@google.com>

Do a few non-functional style fixes for the code in report.c.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/kasan/report.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index 5d225d7d9c4c..83f420a28c0b 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -200,25 +200,22 @@ static void print_error_description(struct kasan_report_info *info)
 static void print_track(struct kasan_track *track, const char *prefix)
 {
 	pr_err("%s by task %u:\n", prefix, track->pid);
-	if (track->stack) {
+	if (track->stack)
 		stack_depot_print(track->stack);
-	} else {
+	else
 		pr_err("(stack is not available)\n");
-	}
 }
 
 struct page *kasan_addr_to_page(const void *addr)
 {
-	if ((addr >= (void *)PAGE_OFFSET) &&
-			(addr < high_memory))
+	if ((addr >= (void *)PAGE_OFFSET) && (addr < high_memory))
 		return virt_to_head_page(addr);
 	return NULL;
 }
 
 struct slab *kasan_addr_to_slab(const void *addr)
 {
-	if ((addr >= (void *)PAGE_OFFSET) &&
-			(addr < high_memory))
+	if ((addr >= (void *)PAGE_OFFSET) && (addr < high_memory))
 		return virt_to_slab(addr);
 	return NULL;
 }
-- 
2.25.1

