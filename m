Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0A9050B6DB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 14:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447309AbiDVMLA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 08:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384839AbiDVMK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 08:10:58 -0400
X-Greylist: delayed 467 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 22 Apr 2022 05:08:03 PDT
Received: from mail.sberdevices.ru (mail.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65A0C56435;
        Fri, 22 Apr 2022 05:08:03 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mail.sberdevices.ru (Postfix) with ESMTP id 36B415FD02;
        Fri, 22 Apr 2022 15:00:13 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1650628813;
        bh=WGcfw8+jkSEDAp7PzGBXGL+KYgoLrJlmcpYGAiTjh9c=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=mWKkDqU9zd+6jMn6LF34ds5F5QWus3BbqYxRfe++y7ule4ejyYTRNq1Zsq3rIguMn
         uum8aHOz75sbkv2eU1+w7t8IIFScyB3urtkSkeaxpKhYSvG5jumJHtGhdgJOujBF0z
         zvufrnkAmB1A9qxtFzjL7QyQtdeJ2h7mY/JU2+QIWrDD+W6c+xyL+XGoaCdSh57nRw
         Sw6EcfbCtAUD7cm0uu8o0wy/W0ep607QASvT3HtndHd5Rw8WEB6jPIemFOua/Dy76t
         iA6mGyepFswjQhpJBlF1Wa/xwufbfzEAEuehOu8bwAKYInvr3nnMBKHGiiqtwPVwad
         x7eadFKcsfqqg==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mail.sberdevices.ru (Postfix) with ESMTP;
        Fri, 22 Apr 2022 15:00:12 +0300 (MSK)
From:   Alexey Romanov <avromanov@sberdevices.ru>
To:     <minchan@kernel.org>, <ngupta@vflare.org>,
        <senozhatsky@chromium.org>, <linux-block@vger.kernel.org>
CC:     <axboe@chromium.org>, <kernel@sberdevices.ru>,
        <linux-kernel@vger.kernel.org>, <mnitenko@gmail.com>,
        Alexey Romanov <avromanov@sberdevices.ru>,
        Dmitry Rokosov <ddrokosov@sberdevices.ru>
Subject: [PATCH v1] zram: don't retry compress incompressible page
Date:   Fri, 22 Apr 2022 14:59:59 +0300
Message-ID: <20220422115959.3313-1-avromanov@sberdevices.ru>
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
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2022/04/22 06:12:00 #19330442
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/block/zram/zram_drv.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index cb253d80d72b..bb9dd8b64176 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1413,9 +1413,20 @@ static int __zram_bvec_write(struct zram *zram, struct bio_vec *bvec,
 		handle = zs_malloc(zram->mem_pool, comp_len,
 				GFP_NOIO | __GFP_HIGHMEM |
 				__GFP_MOVABLE);
-		if (handle)
+		if (!handle)
+			return -ENOMEM;
+
+		if (comp_len != PAGE_SIZE)
 			goto compress_again;
-		return -ENOMEM;
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
2.30.1

