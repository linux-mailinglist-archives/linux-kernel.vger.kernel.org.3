Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4053349F288
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 05:35:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346059AbiA1EfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 23:35:14 -0500
Received: from out199-3.us.a.mail.aliyun.com ([47.90.199.3]:25193 "EHLO
        out199-3.us.a.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237463AbiA1EfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 23:35:12 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0V310Omk_1643344504;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0V310Omk_1643344504)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 28 Jan 2022 12:35:08 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] block: fix boolreturn.cocci warning
Date:   Fri, 28 Jan 2022 12:34:54 +0800
Message-Id: <20220128043454.68927-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Return statements in functions returning bool should use true/false
instead of 1/0.

./block/bio.c:1081:9-10: WARNING: return of 0/1 in function
'bio_add_folio' with return type bool.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 block/bio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/bio.c b/block/bio.c
index 03cefe81950f..2e19ca600fcd 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1078,7 +1078,7 @@ bool bio_add_folio(struct bio *bio, struct folio *folio, size_t len,
 		   size_t off)
 {
 	if (len > UINT_MAX || off > UINT_MAX)
-		return 0;
+		return false;
 	return bio_add_page(bio, &folio->page, len, off) > 0;
 }
 
-- 
2.20.1.7.g153144c

