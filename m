Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E70F646FB08
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 08:02:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233151AbhLJHGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 02:06:00 -0500
Received: from mailgw.kylinos.cn ([123.150.8.42]:57149 "EHLO nksmu.kylinos.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231180AbhLJHF7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 02:05:59 -0500
X-UUID: d68d56d2c64a422d83f9143d87d3874f-20211210
X-CPASD-INFO: 40e9898ad1144ac78ea5bc36bedf64a2
        @fYCfWWVrZpGQUXOAg6SucViWkWWSj1OFpJ-
        ElmRkjVKVhH5xTWJsXVKBfG5QZWNdYVN_eGpQYl9gZFB5i3-XblBgXoZgUZB3g3KfWWhnaA==
X-CPASD-FEATURE: 0.0
X-CLOUD-ID: 40e9898ad1144ac78ea5bc36bedf64a2
X-CPASD-SUMMARY: SIP:-1,APTIP:-2.0,KEY:0.0,FROMBLOCK:1,EXT:0.0,OB:0.0,URL:-5,T
        VAL:173.0,ESV:0.0,ECOM:-5.0,ML:0.0,FD:0.0,CUTS:74.0,IP:-2.0,MAL:0.0,ATTNUM:0.
        0,PHF:-5.0,PHC:-5.0,SPF:4.0,EDMS:-3,IPLABEL:4488.0,FROMTO:0,AD:0,FFOB:0.0,CFO
        B:0.0,SPC:0.0,SIG:-5,AUF:55,DUF:25822,ACD:128,DCD:230,SL:0,AG:0,CFC:0.587,CFS
        R:0.073,UAT:0,RAF:0,VERSION:2.3.4
X-CPASD-ID: d68d56d2c64a422d83f9143d87d3874f-20211210
X-CPASD-BLOCK: 1000
X-CPASD-STAGE: 1, 1
X-UUID: d68d56d2c64a422d83f9143d87d3874f-20211210
X-User: yinxiujiang@kylinos.cn
Received: from localhost.localdomain [(118.26.139.139)] by nksmu.kylinos.cn
        (envelope-from <yinxiujiang@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 2131694627; Fri, 10 Dec 2021 15:10:33 +0800
From:   Yin Xiujiang <yinxiujiang@kylinos.cn>
To:     hca@linux.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com,
        agordeev@linux.ibm.com
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] s390/3215: fix the array may be out of bounds
Date:   Fri, 10 Dec 2021 15:02:17 +0800
Message-Id: <20211210070217.188697-1-yinxiujiang@kylinos.cn>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

if the variable 'line' is NR_3215,
the 'raw3215[line]' will be invalid

Signed-off-by: Yin Xiujiang <yinxiujiang@kylinos.cn>
---
 drivers/s390/char/con3215.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/s390/char/con3215.c b/drivers/s390/char/con3215.c
index f356607835d8..29409d4ca4d5 100644
--- a/drivers/s390/char/con3215.c
+++ b/drivers/s390/char/con3215.c
@@ -687,7 +687,8 @@ static void raw3215_remove (struct ccw_device *cdev)
 		for (line = 0; line < NR_3215; line++)
 			if (raw3215[line] == raw)
 				break;
-		raw3215[line] = NULL;
+		if (line < NR_3215)
+			raw3215[line] = NULL;
 		spin_unlock(&raw3215_device_lock);
 		dev_set_drvdata(&cdev->dev, NULL);
 		raw3215_free_info(raw);
-- 
2.30.0

