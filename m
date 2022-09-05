Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 361145ADAB8
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 23:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232613AbiIEVKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 17:10:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238019AbiIEVJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 17:09:25 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 267FE5A2C5
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 14:09:12 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1662412150;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Xrez/vnZo/oxjqNbdHGgKzELApXd1vkR10PWPCg0Dhs=;
        b=t2jE6p9pbIiCRjPA2WBL+FZYraE6CBckmhhN4Cf/51LN/hl6voMskq7f/VkL5sRQMtYRy9
        vKvG6NU3QM+X1gzNvv4IUjJfzu/gkOptUVyM3BsBm/BhPUsHIUZ666j4Aaxgm3J08E+nGQ
        NlFYZ4xU1iPLPZ3E+rTMpoPhF2tdcHk=
From:   andrey.konovalov@linux.dev
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com, Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Florian Mayer <fmayer@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH mm v3 21/34] kasan: cosmetic changes in report.c
Date:   Mon,  5 Sep 2022 23:05:36 +0200
Message-Id: <b728eae71f3ea505a885449724de21cf3f476a7b.1662411799.git.andreyknvl@google.com>
In-Reply-To: <cover.1662411799.git.andreyknvl@google.com>
References: <cover.1662411799.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Konovalov <andreyknvl@google.com>

Do a few non-functional style fixes for the code in report.c.

Reviewed-by: Marco Elver <elver@google.com>
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

