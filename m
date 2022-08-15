Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50C1C592F11
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 14:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242307AbiHOMjz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 08:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241597AbiHOMjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 08:39:45 -0400
Received: from mail.sberdevices.ru (mail.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1DDA23BCF
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 05:39:44 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mail.sberdevices.ru (Postfix) with ESMTP id ACC6F5FD0A;
        Mon, 15 Aug 2022 15:39:42 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1660567182;
        bh=fBVh/aw8QffkdtBHi0zddHljlA6jQjejmkYNw6kN2NU=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=W6VOknYiE5IYltYzNXgPI6YDTGjf9Pz4s+WTaXdrUJTeS6ZbTyo/KOrNPKf2cHqwl
         DvUEQKY5gsuzsnQiUpOs09qy0/gR/nldMGgYBTZPmm9Ba0BgbkEUVnsqzQJl/MkHqQ
         CjXx0CarpjLWka7xXPo2vzxaNJ5KSg67drV35clpl7W2u1S/98NNztTavbmkziLFKe
         qbdTK0juTk8JBmsgis8VNflZ8oLmyXly+ZZR+eeTfyAawwQtoOPklg8BBxzy72bCGF
         DBnJ7JakXmumIcgtniCCXbMsMGkEfHhrL79mWGQEdQp06Ftf3K4aNIdLy5jRMADms1
         EEtnHBdv0XVag==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mail.sberdevices.ru (Postfix) with ESMTP;
        Mon, 15 Aug 2022 15:39:42 +0300 (MSK)
From:   Alexey Romanov <avromanov@sberdevices.ru>
To:     <minchan@kernel.org>, <senozhatsky@chromium.org>,
        <ngupta@vflare.org>, <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <kernel@sberdevices.ru>, Alexey Romanov <avromanov@sberdevices.ru>
Subject: [PATCH v2 2/2] zsmalloc: remove unnecessary size_class NULL check
Date:   Mon, 15 Aug 2022 15:39:30 +0300
Message-ID: <20220815123930.37736-3-avromanov@sberdevices.ru>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220815123930.37736-1-avromanov@sberdevices.ru>
References: <20220815123930.37736-1-avromanov@sberdevices.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH01.sberdevices.ru (172.16.1.4) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2022/08/15 08:42:00 #20120161
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pool->size_class array elements can't be NULL, so this check
is not needed.

In the whole code, we assign pool->size_class[i] values that are
not NULL. Releasing memory for these values occurs in the
zs_destroy_pool() function, which also releases and destroys the pool.

In addition, in the zs_stats_size_show() and async_free_zspage(),
with similar iterations over the array, we don't check it for NULL
pointer.

Signed-off-by: Alexey Romanov <avromanov@sberdevices.ru>
---
 mm/zsmalloc.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index df381ba891ea..d064ce32e7b9 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -2154,8 +2154,6 @@ unsigned long zs_compact(struct zs_pool *pool)
 
 	for (i = ZS_SIZE_CLASSES - 1; i >= 0; i--) {
 		class = pool->size_class[i];
-		if (!class)
-			continue;
 		if (class->index != i)
 			continue;
 		pages_freed += __zs_compact(pool, class);
@@ -2200,8 +2198,6 @@ static unsigned long zs_shrinker_count(struct shrinker *shrinker,
 
 	for (i = ZS_SIZE_CLASSES - 1; i >= 0; i--) {
 		class = pool->size_class[i];
-		if (!class)
-			continue;
 		if (class->index != i)
 			continue;
 
@@ -2361,9 +2357,6 @@ void zs_destroy_pool(struct zs_pool *pool)
 		int fg;
 		struct size_class *class = pool->size_class[i];
 
-		if (!class)
-			continue;
-
 		if (class->index != i)
 			continue;
 
-- 
2.30.1

