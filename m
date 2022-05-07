Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4E9A51E5F5
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 11:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383867AbiEGJUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 05:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383843AbiEGJT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 05:19:57 -0400
Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 491E75712C;
        Sat,  7 May 2022 02:16:11 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VCWHKSC_1651914966;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0VCWHKSC_1651914966)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 07 May 2022 17:16:08 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     tim@cyberelk.net
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH 1/2] paride: clean up some inconsistent indenting
Date:   Sat,  7 May 2022 17:15:36 +0800
Message-Id: <20220507091536.32211-2-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
In-Reply-To: <20220507091536.32211-1-jiapeng.chong@linux.alibaba.com>
References: <20220507091536.32211-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eliminate the follow smatch warning:

drivers/block/paride/on26.c:158 on26_test_port() warn: inconsistent
indenting.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/block/paride/on26.c | 85 +++++++++++++++++++------------------
 1 file changed, 44 insertions(+), 41 deletions(-)

diff --git a/drivers/block/paride/on26.c b/drivers/block/paride/on26.c
index 95ba256921f2..d2ee74dbee29 100644
--- a/drivers/block/paride/on26.c
+++ b/drivers/block/paride/on26.c
@@ -125,61 +125,64 @@ static void on26_disconnect ( PIA *pi )
 #define	RESET_WAIT  200
 
 static int on26_test_port( PIA *pi)  /* hard reset */
+{
+	int i, m, d, x = 0, y = 0;
 
-{       int     i, m, d, x=0, y=0;
-
-        pi->saved_r0 = r0();
-        pi->saved_r2 = r2();
+	pi->saved_r0 = r0();
+	pi->saved_r2 = r2();
 
-        d = pi->delay;
-        m = pi->mode;
-        pi->delay = 5;
-        pi->mode = 0;
+	d = pi->delay;
+	m = pi->mode;
+	pi->delay = 5;
+	pi->mode = 0;
 
-        w2(0xc);
+	w2(0xc);
 
-        CCP(0x30); CCP(0); 
+	CCP(0x30); CCP(0);
 
-        w0(0xfe);w0(0xaa);w0(0x55);w0(0);w0(0xff);
-        i = ((r1() & 0xf0) << 4); w0(0x87);
-        i |= (r1() & 0xf0); w0(0x78);
-        w0(0x20);w2(4);w2(5);
-        i |= ((r1() & 0xf0) >> 4);
-        w2(4);w0(0xff);
+	w0(0xfe); w0(0xaa); w0(0x55); w0(0); w0(0xff);
+	i = ((r1() & 0xf0) << 4); w0(0x87);
+	i |= (r1() & 0xf0); w0(0x78);
+	w0(0x20); w2(4); w2(5);
+	i |= ((r1() & 0xf0) >> 4);
+	w2(4); w0(0xff);
 
-        if (i == 0xb5f) {
+	if (i == 0xb5f) {
 
-            w0(2); P1; w0(0);   P2;
-            w0(3); P1; w0(0);   P2;
-            w0(2); P1; w0(8);   P2; udelay(100);
-            w0(2); P1; w0(0xa); P2; udelay(100);
-            w0(2); P1; w0(8);   P2; udelay(1000);
+		w0(2); P1; w0(0);   P2;
+		w0(3); P1; w0(0);   P2;
+		w0(2); P1; w0(8);   P2; udelay(100);
+		w0(2); P1; w0(0xa); P2; udelay(100);
+		w0(2); P1; w0(8);   P2; udelay(1000);
             
-            on26_write_regr(pi,0,6,0xa0);
+		on26_write_regr(pi, 0, 6, 0xa0);
 
-            for (i=0;i<RESET_WAIT;i++) {
-                on26_write_regr(pi,0,6,0xa0);
-                x = on26_read_regr(pi,0,7);
-                on26_write_regr(pi,0,6,0xb0);
-                y = on26_read_regr(pi,0,7);
-                if (!((x&0x80)||(y&0x80))) break;
-                mdelay(100);
-            }
+		for (i = 0; i < RESET_WAIT; i++) {
+			on26_write_regr(pi, 0, 6, 0xa0);
+			x = on26_read_regr(pi, 0, 7);
 
-	    if (i == RESET_WAIT) 
-		printk("on26: Device reset failed (%x,%x)\n",x,y);
+			on26_write_regr(pi, 0, 6, 0xb0);
+			y = on26_read_regr(pi, 0, 7);
 
-            w0(4); P1; w0(4); P1;
-        }
+			if (!((x & 0x80) || (y & 0x80)))
+				break;
+			mdelay(100);
+		}
 
-        CCP(0x30);
+		if (i == RESET_WAIT)
+			printk("on26: Device reset failed (%x,%x)\n", x, y);
 
-        pi->delay = d;
-        pi->mode = m;
-        w0(pi->saved_r0);
-        w2(pi->saved_r2);
+		w0(4); P1; w0(4); P1;
+	}
+
+	CCP(0x30);
+
+	pi->delay = d;
+	pi->mode = m;
+	w0(pi->saved_r0);
+	w2(pi->saved_r2);
 
-        return 5;
+	return 5;
 }
 
 
-- 
2.20.1.7.g153144c

