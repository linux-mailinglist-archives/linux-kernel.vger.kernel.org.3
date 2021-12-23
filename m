Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3BF547E121
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 11:11:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347624AbhLWKLX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 05:11:23 -0500
Received: from smtp21.cstnet.cn ([159.226.251.21]:37280 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242964AbhLWKLW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 05:11:22 -0500
Received: from localhost.localdomain (unknown [124.16.138.126])
        by APP-01 (Coremail) with SMTP id qwCowADn71ctS8RhuY7nBA--.3389S2;
        Thu, 23 Dec 2021 18:10:54 +0800 (CST)
From:   Jiasheng Jiang <jiasheng@iscas.ac.cn>
To:     a.zummo@towertech.it, alexandre.belloni@bootlin.com
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>
Subject: [PATCH] rtc: m41t80: Check failure of i2c_transfer
Date:   Thu, 23 Dec 2021 18:10:52 +0800
Message-Id: <20211223101052.1283277-1-jiasheng@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowADn71ctS8RhuY7nBA--.3389S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KF17uFW5GFWxWF4kAw4DXFb_yoW8WFyUpa
        1qkr13CFnYq3Wv9a1xGw1DuF45t3s3J343KayfW3sav3ZxJa48Grs5Ka4UtFn7JrWrWr12
        vrWqy3W5CFW7tw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkq14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
        0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
        jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
        1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkIecxEwVAFwVW8twCF
        04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r
        18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vI
        r41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr
        1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAI
        cVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUboKZJUUUUU==
X-Originating-IP: [124.16.138.126]
X-CM-SenderInfo: pmld2xxhqjqxpvfd2hldfou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because the i2c_transfer could be failure and return nagative code or
other number but not the right number of messages executed.
Therefore, it should be better to check the return value and deal with
it.
This time, for the sake of convenience, I only fix one as an example.
If the patch is right, I will submit a new version including others,
like wdt_disable().

Fixes: 617780d290bd ("rtc: watchdog support for rtc-m41t80 driver")
Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
---
 drivers/rtc/rtc-m41t80.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-m41t80.c b/drivers/rtc/rtc-m41t80.c
index 89128fc29ccc..1efb689dc6a6 100644
--- a/drivers/rtc/rtc-m41t80.c
+++ b/drivers/rtc/rtc-m41t80.c
@@ -604,8 +604,9 @@ static int boot_flag;
  *	Reload counter one with the watchdog timeout. We don't bother reloading
  *	the cascade counter.
  */
-static void wdt_ping(void)
+static int wdt_ping(void)
 {
+	int ret;
 	unsigned char i2c_data[2];
 	struct i2c_msg msgs1[1] = {
 		{
@@ -634,7 +635,12 @@ static void wdt_ping(void)
 	if (clientdata->features & M41T80_FEATURE_WD)
 		i2c_data[1] &= ~M41T80_WATCHDOG_RB2;
 
-	i2c_transfer(save_client->adapter, msgs1, 1);
+	ret = i2c_transfer(save_client->adapter, msgs1, 1);
+	if (ret == 1)
+		return 0;
+	if (ret < 0)
+		return ret;
+	return -EIO;
 }
 
 /**
@@ -689,8 +695,12 @@ static void wdt_disable(void)
 static ssize_t wdt_write(struct file *file, const char __user *buf,
 			 size_t count, loff_t *ppos)
 {
+	int ret;
 	if (count) {
-		wdt_ping();
+		ret = wdt_ping();
+		if (ret)
+			return 0;
+
 		return 1;
 	}
 	return 0;
-- 
2.25.1

