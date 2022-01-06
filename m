Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2FD34861A2
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 09:46:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237035AbiAFIqj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 03:46:39 -0500
Received: from mailgw.kylinos.cn ([123.150.8.42]:28084 "EHLO nksmu.kylinos.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231734AbiAFIqi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 03:46:38 -0500
X-UUID: 1625e98c9b3640ae86d6faa3c6159411-20220106
X-CPASD-INFO: 9ddb1f2e13a74e36aefeeeda5bd59ddd@grSegl6YYJVdU6ODg6h-cIGWlpWWkYS
        wd5yEZWeUkISVhH5xTWJsXVKBfG5QZWNdYVN_eGpQY19gZFB5i3-XblBgXoZgUZB3iKaegmGUYg==
X-CPASD-FEATURE: 0.0
X-CLOUD-ID: 9ddb1f2e13a74e36aefeeeda5bd59ddd
X-CPASD-SUMMARY: SIP:-1,APTIP:-2.0,KEY:0.0,FROMBLOCK:1,EXT:0.0,OB:0.0,URL:-5,T
        VAL:186.0,ESV:0.0,ECOM:-5.0,ML:0.0,FD:1.0,CUTS:92.0,IP:-2.0,MAL:0.0,ATTNUM:0.
        0,PHF:-5.0,PHC:-5.0,SPF:4.0,EDMS:-3,IPLABEL:4480.0,FROMTO:0,AD:0,FFOB:0.0,CFO
        B:0.0,SPC:0.0,SIG:-5,AUF:0,DUF:29551,ACD:155,DCD:258,SL:0,AG:0,CFC:0.285,CFSR
        :0.097,UAT:0,RAF:0,VERSION:2.3.4
X-CPASD-ID: 1625e98c9b3640ae86d6faa3c6159411-20220106
X-CPASD-BLOCK: 1001
X-CPASD-STAGE: 1, 1
X-UUID: 1625e98c9b3640ae86d6faa3c6159411-20220106
X-User: luriwen@kylinos.cn
Received: from localhost.localdomain [(116.128.244.169)] by nksmu.kylinos.cn
        (envelope-from <luriwen@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 1439652963; Thu, 06 Jan 2022 16:59:39 +0800
From:   Riwen Lu <luriwen@kylinos.cn>
To:     a.zummo@towertech.it, alexandre.belloni@bootlin.com, e@80x24.org
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Riwen Lu <luriwen@kylinos.cn>
Subject: [PATCH v1] rtc: cmos: Evaluate century appropriate
Date:   Thu,  6 Jan 2022 16:46:09 +0800
Message-Id: <20220106084609.1223688-1-luriwen@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's limiting the year to 2069. When setting the rtc year to 2070,
reading it returns 1970. Evaluate century starting from 19 to count the
correct year.

$ sudo date -s 20700106
Mon 06 Jan 2070 12:00:00 AM CST
$ sudo hwclock -w
$ sudo hwclock -r
1970-01-06 12:00:49.604968+08:00

Fixes: 2a4daadd4d3e5071 ("rtc: cmos: ignore bogus century byte")

Signed-off-by: Riwen Lu <luriwen@kylinos.cn>
---
 drivers/rtc/rtc-mc146818-lib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-mc146818-lib.c b/drivers/rtc/rtc-mc146818-lib.c
index dcfaf09946ee..2065842f775d 100644
--- a/drivers/rtc/rtc-mc146818-lib.c
+++ b/drivers/rtc/rtc-mc146818-lib.c
@@ -104,7 +104,7 @@ unsigned int mc146818_get_time(struct rtc_time *time)
 	time->tm_year += real_year - 72;
 #endif
 
-	if (century > 20)
+	if (century > 19)
 		time->tm_year += (century - 19) * 100;
 
 	/*
-- 
2.25.1


No virus found
		Checked by Hillstone Network AntiVirus
