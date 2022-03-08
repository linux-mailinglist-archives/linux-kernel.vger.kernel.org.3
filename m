Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81BCD4D1DCF
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 17:54:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345049AbiCHQzV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 11:55:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232531AbiCHQzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 11:55:18 -0500
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CEEB4EA31
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 08:54:21 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1646758459;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=eqmkPSBm5WulTOgzZAJ0UbU+BwECVBvh4ECQqxckohA=;
        b=hJpgRdv8RgK9TlJiH3MjGiK4Cru06lqcFR6RrRaYZt1MQUfUFyKgz4IdNr171CRW6piMNv
        zwkyhl317eMF0enuZ+CJEViDwRjhzahLVbSPbQ6nfMBLo8PQxTxX2vk+cYrIH09lrNsGNC
        jrTIV4Dcy0XINDnxRqu7SeS+GKs2khU=
From:   andrey.konovalov@linux.dev
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com, Vasily Gorbik <gor@linux.ibm.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH mm] fix for "kasan, vmalloc: only tag normal vmalloc allocations"
Date:   Tue,  8 Mar 2022 17:54:17 +0100
Message-Id: <de4587d6a719232e83c760113e46ed2d4d8da61e.1646757322.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Konovalov <andreyknvl@google.com>

"kasan, vmalloc: only tag normal vmalloc allocations" unintentionally
disabled poisoning of executable memory for the Generic mode. Fix it.

Reported-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/kasan/shadow.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/kasan/shadow.c b/mm/kasan/shadow.c
index 7272e248db87..a4f07de21771 100644
--- a/mm/kasan/shadow.c
+++ b/mm/kasan/shadow.c
@@ -489,10 +489,11 @@ void *__kasan_unpoison_vmalloc(const void *start, unsigned long size,
 		return (void *)start;
 
 	/*
-	 * Don't tag executable memory.
+	 * Don't tag executable memory with the tag-based mode.
 	 * The kernel doesn't tolerate having the PC register tagged.
 	 */
-	if (!(flags & KASAN_VMALLOC_PROT_NORMAL))
+	if (IS_ENABLED(CONFIG_KASAN_SW_TAGS) &&
+	    !(flags & KASAN_VMALLOC_PROT_NORMAL))
 		return (void *)start;
 
 	start = set_tag(start, kasan_random_tag());
-- 
2.25.1

