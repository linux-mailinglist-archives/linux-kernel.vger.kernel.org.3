Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA0DF495E94
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 12:50:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380200AbiAULuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 06:50:05 -0500
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:36995 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239121AbiAULuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 06:50:04 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0V2RJRP6_1642765797;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0V2RJRP6_1642765797)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 21 Jan 2022 19:50:02 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] staging: pi433: using div64_u64() instead of do_div()
Date:   Fri, 21 Jan 2022 19:49:55 +0800
Message-Id: <20220121114955.96979-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean the following coccicheck warning:

./drivers/staging/pi433/rf69.c:286:1-7: WARNING: do_div() does a
64-by-32 division, please consider using div64_u64 instead.

./drivers/staging/pi433/rf69.c:332:1-7: WARNING: do_div() does a
64-by-32 division, please consider using div64_u64 instead.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/staging/pi433/rf69.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/pi433/rf69.c b/drivers/staging/pi433/rf69.c
index d64df072d8e8..ae4adeb00ce1 100644
--- a/drivers/staging/pi433/rf69.c
+++ b/drivers/staging/pi433/rf69.c
@@ -283,7 +283,7 @@ int rf69_set_deviation(struct spi_device *spi, u32 deviation)
 
 	// calculate register settings
 	f_reg = deviation * factor;
-	do_div(f_reg, f_step);
+	div64_u64(f_reg, f_step);
 
 	msb = (f_reg & 0xff00) >> 8;
 	lsb = (f_reg & 0xff);
@@ -329,7 +329,7 @@ int rf69_set_frequency(struct spi_device *spi, u32 frequency)
 
 	// calculate reg settings
 	f_reg = frequency * factor;
-	do_div(f_reg, f_step);
+	div64_u64(f_reg, f_step);
 
 	msb = (f_reg & 0xff0000) >> 16;
 	mid = (f_reg & 0xff00)   >>  8;
-- 
2.20.1.7.g153144c

