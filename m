Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 789CB58EB3C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 13:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231841AbiHJL3R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 07:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbiHJL3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 07:29:16 -0400
Received: from mail.sberdevices.ru (mail.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 075F961132;
        Wed, 10 Aug 2022 04:29:10 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mail.sberdevices.ru (Postfix) with ESMTP id 73DBF5FD04;
        Wed, 10 Aug 2022 14:29:07 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1660130947;
        bh=3893O+vXqP3xpBy0WTDQBFqvN7inlJEYtIAjlmKsZKc=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=CeQAaVMpSxvKuDiCNpACHwqV+n4SmmwSg/jSowbyYCDkQp6d8xbTwNNF+QO5nAYDp
         WJeI3wV49SAK4EJmW4lpbItA2IXTO7Wb2DeNoo/WVbgJjI0wBDBwFUbviF4PeS/cbJ
         WUKaDWVce8nj/kDo9QxnTcVuA9TzEHBD1FoChC/aQImWeGGtVMfMio2cC3sHZsteTG
         qTuEB1KkAqYfz69q+hkKBqKCkJMwSkKEPQrhxhQAIg+DJ7uoOuYScgbBUoKiNXGJk7
         G4Wnp+GHAKm+kuwtXuVxywRvvk+WMN/xcOBMEcqxLagfaka4i3Z7Db+xuCOiVr9OaM
         PRzojm/yMlLKQ==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mail.sberdevices.ru (Postfix) with ESMTP;
        Wed, 10 Aug 2022 14:29:06 +0300 (MSK)
From:   Alexey Romanov <avromanov@sberdevices.ru>
To:     <minchan@kernel.org>, <ngupta@vflare.org>,
        <senozhatsky@chromium.org>, <linux-block@vger.kernel.org>,
        <axboe@chromium.org>
CC:     <kernel@sberdevices.ru>, <linux-kernel@vger.kernel.org>,
        <mnitenko@gmail.com>, Alexey Romanov <avromanov@sberdevices.ru>,
        Dmitry Rokosov <ddrokosov@sberdevices.ru>
Subject: [PATCH v1] zram: don't retry compress incompressible page
Date:   Wed, 10 Aug 2022 14:28:57 +0300
Message-ID: <20220810112857.90278-1-avromanov@sberdevices.ru>
X-Mailer: git-send-email 2.33.0
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
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2022/08/10 06:38:00 #20089054
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It doesn't make sense for us to retry to compress an uncompressible
page (comp_len == PAGE_SIZE) in zsmalloc slowpath, because we will
be storing it uncompressed anyway. We can avoid wasting time on
another compression attempt. It is enough to take lock
(zcomp_stream_get) and execute the code below.

This patch is made taking into account that commit 
e7be8d1dd983156bbdd22c0319b71119a8fbb697 is reverted.

Signed-off-by: Alexey Romanov <avromanov@sberdevices.ru>
Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
---
 drivers/block/zram/zram_drv.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index e0f850ab43aa..f51277a3aeaa 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1411,9 +1411,20 @@ static int __zram_bvec_write(struct zram *zram, struct bio_vec *bvec,
 		handle = zs_malloc(zram->mem_pool, comp_len,
 				GFP_NOIO | __GFP_HIGHMEM |
 				__GFP_MOVABLE);
-		if (!IS_ERR((void *)handle))
+		if (IS_ERR((void *)handle))
+			return PTR_ERR((void *)handle);
+
+		if (comp_len != PAGE_SIZE)
 			goto compress_again;
-		return PTR_ERR((void *)handle);
+
+		/*
+		 * If the page is not compressible, you need to acquire the lock and
+		 * execute the code below. The zcomp_stream_get() call is needed to
+		 * disable the cpu hotplug and grab the zstrm buffer back.
+		 * It is necessary that the dereferencing of the zstrm variable below
+		 * occurs correctly.
+		 */
+		zstrm = zcomp_stream_get(zram->comp);
 	}
 
 	alloced_pages = zs_get_total_pages(zram->mem_pool);
-- 
2.30.2

