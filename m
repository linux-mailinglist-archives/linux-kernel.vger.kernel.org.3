Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80CB554A089
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 22:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350341AbiFMU5B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 16:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352082AbiFMUyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 16:54:09 -0400
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26A5A29812
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 13:19:46 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1655151584;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xD+jOMbc8v/VbHqobo7HTP4Hy7ebCjo8HGnwIkjNmQg=;
        b=uV4k7v6j0gg2WNGE2AGUi+jftnP6i13EVs8rWhI+Mznu6bMnCcoEx7t6dQvsOLijyruwRb
        Bnb/ljj+Y/69/ZVheqbQ8nWo1Q2aQYKgjsxn4fv64f2dR7RxPtUroYLFBAZjgai+byrc3O
        hJnu05PzYAADy2CUt5i3GARZUN+wHes=
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
Subject: [PATCH 26/32] kasan: simplify print_report
Date:   Mon, 13 Jun 2022 22:14:17 +0200
Message-Id: <6920a74ae141ec8f45f19c8ebf3622910d10a5ed.1655150842.git.andreyknvl@google.com>
In-Reply-To: <cover.1655150842.git.andreyknvl@google.com>
References: <cover.1655150842.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Konovalov <andreyknvl@google.com>

To simplify reading the implementation of print_report(), remove the
tagged_addr variable and rename untagged_addr to addr.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/kasan/report.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index f3ec6f86b199..cc35c8c1a367 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -391,17 +391,16 @@ static void print_memory_metadata(const void *addr)
 
 static void print_report(struct kasan_report_info *info)
 {
-	void *tagged_addr = info->access_addr;
-	void *untagged_addr = kasan_reset_tag(tagged_addr);
-	u8 tag = get_tag(tagged_addr);
+	void *addr = kasan_reset_tag(info->access_addr);
+	u8 tag = get_tag(info->access_addr);
 
 	print_error_description(info);
-	if (addr_has_metadata(untagged_addr))
+	if (addr_has_metadata(addr))
 		kasan_print_tags(tag, info->first_bad_addr);
 	pr_err("\n");
 
-	if (addr_has_metadata(untagged_addr)) {
-		print_address_description(untagged_addr, tag);
+	if (addr_has_metadata(addr)) {
+		print_address_description(addr, tag);
 		print_memory_metadata(info->first_bad_addr);
 	} else {
 		dump_stack_lvl(KERN_ERR);
-- 
2.25.1

