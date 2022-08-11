Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51B48590082
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 17:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236484AbiHKPnz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 11:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236385AbiHKPnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 11:43:41 -0400
Received: from mail.sberdevices.ru (mail.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99AFC9F194
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 08:38:09 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mail.sberdevices.ru (Postfix) with ESMTP id BB5535FD07;
        Thu, 11 Aug 2022 18:38:07 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1660232287;
        bh=0ZPDUCDYt8cTM0IRDWEirHqaXpS1VqLDEtitynBVmKI=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=NleaxToKuULRFvBgPvAtWzSeyDWx7rdHhn5tNxtUwAdMrJnm/hM9t65IeF9pgqkEc
         fWQucu+KVWt7bsECOLUzUDX7RnEqWpaz+BiLUac/KzfaQq/QQlC/9NS5EDkPu964m6
         S4ViXrD4Bg6o1tenEnDT9Sueuk33ypMFhXEiNB6j/SwNRp5lC7mkY9fSlNS3/KqKy8
         TArDFAvt3GEyihgu4iQjVaYbcSRhoBAwSeJ8Ajn6BAV2ygakX4Y5d4HUzwtTQKatPJ
         XJYoxWnTOhV8hh9pQbCuYZdeoDTTijPEiaDcURL4qvMMUbUQFKXCj9ruSjZOMj4971
         itHl/wKsqktXA==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mail.sberdevices.ru (Postfix) with ESMTP;
        Thu, 11 Aug 2022 18:38:07 +0300 (MSK)
From:   Alexey Romanov <avromanov@sberdevices.ru>
To:     <minchan@kernel.org>, <senozhatsky@chromium.org>,
        <ngupta@vflare.org>, <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <kernel@sberdevices.ru>, Alexey Romanov <avromanov@sberdevices.ru>
Subject: [PATCH v1 2/2] zsmalloc: remove unnecessary size_class NULL check
Date:   Thu, 11 Aug 2022 18:37:55 +0300
Message-ID: <20220811153755.16102-3-avromanov@sberdevices.ru>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220811153755.16102-1-avromanov@sberdevices.ru>
References: <20220811153755.16102-1-avromanov@sberdevices.ru>
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
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2022/08/11 13:20:00 #20096813
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
index 5efa8c592193..f3cf0d0925a3 100644
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

