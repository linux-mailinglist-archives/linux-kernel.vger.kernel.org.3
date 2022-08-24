Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60E1A59F89E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 13:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236863AbiHXLbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 07:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235265AbiHXLbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 07:31:35 -0400
Received: from mail.sberdevices.ru (mail.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CFDA7CB53
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 04:31:31 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mail.sberdevices.ru (Postfix) with ESMTP id 174345FD0C;
        Wed, 24 Aug 2022 14:31:28 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1661340688;
        bh=9a3LG75heqpVyPTgK4IjcsiLYbZXVWbG8+l83iknq/U=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=XkmEd4qmaLG7oYQlqb7HPFZS8rXaOic64jmLQU+q7fitA/zKznETHS/WMIV82oGDl
         TZMSyaDc11KMeAUglxMuz+2JYPGgmdVjqpSm2yaICNbpn+yfgCykSBZwDTP3O0tmst
         pX9u3iQKoJDXKYSZWGscL4nr2OgxXflepL1V5MC6t805kqK0EDUaJQFagLKvTk1qyI
         4CAgf6IrIkvaoVI0jfZ2iyp25AsaOzwgGwxgZNSeyBS6OMVXRGiHeWsJr1tbgTdGgm
         QlE919zDf1rYSKOncH4OFggTCyYvLkRfhb44crf5BqGMEsOfZM9Pk2SClFGhmD1pH2
         3+/9/QnCUIHvw==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mail.sberdevices.ru (Postfix) with ESMTP;
        Wed, 24 Aug 2022 14:31:26 +0300 (MSK)
From:   Alexey Romanov <avromanov@sberdevices.ru>
To:     <minchan@kernel.org>, <senozhatsky@chromium.org>,
        <ngupta@vflare.org>, <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <kernel@sberdevices.ru>, Alexey Romanov <avromanov@sberdevices.ru>,
        Dmitry Rokosov <ddrokosov@sberdevices.ru>
Subject: [PATCH v2] zram: don't retry compress incompressible page
Date:   Wed, 24 Aug 2022 14:31:17 +0300
Message-ID: <20220824113117.78849-1-avromanov@sberdevices.ru>
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
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2022/08/24 08:05:00 #20147978
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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

Signed-off-by: Alexey Romanov <avromanov@sberdevices.ru>
Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
---
 drivers/block/zram/zram_drv.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 226ea76cc819..3bd8d5e27041 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1410,9 +1410,19 @@ static int __zram_bvec_write(struct zram *zram, struct bio_vec *bvec,
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
2.25.1

