Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89DE44860E8
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 08:13:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235128AbiAFHNn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 02:13:43 -0500
Received: from smtp21.cstnet.cn ([159.226.251.21]:45038 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234429AbiAFHNm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 02:13:42 -0500
Received: from localhost.localdomain (unknown [124.16.138.126])
        by APP-01 (Coremail) with SMTP id qwCowAAnvqaOltZhwlThBQ--.28348S2;
        Thu, 06 Jan 2022 15:13:18 +0800 (CST)
From:   Jiasheng Jiang <jiasheng@iscas.ac.cn>
To:     eric.piel@tremplin-utc.net, arnd@arndb.de,
        gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Jiasheng Jiang <jiasheng@iscas.ac.cn>
Subject: [PATCH] drivers/misc/lis3lv02d/lis3lv02d_i2c.c: Check for error return from regulator_bulk_enable in lis3lv02d_i2c_probe
Date:   Thu,  6 Jan 2022 15:13:16 +0800
Message-Id: <20220106071316.2691138-1-jiasheng@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowAAnvqaOltZhwlThBQ--.28348S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Zr45ZFWDtF4DXrWUXrWrZrb_yoW8XFyfpF
        4YvFy3GFy0qFyS939Ivr9xWFyaka18trW293y5Cw1I93sxAwsrtF4rKr1qvFy5XryxJrWU
        GayDKa45Gw18AwUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkm14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY02Avz4vE14v_GF4l
        42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
        WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAK
        I48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r
        4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI
        42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfU8J5oDUUUU
X-Originating-IP: [124.16.138.126]
X-CM-SenderInfo: pmld2xxhqjqxpvfd2hldfou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because of the possible failure of the consumer, the
regulator_bulk_enable() may return error.
Therefore, it should be better to check the return value of the
lis3_reg_ctrl() and return error if fails.

Fixes: ec400c9fab99 ("lis3lv02d: make regulator API usage unconditional")
Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
---
 drivers/misc/lis3lv02d/lis3lv02d_i2c.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/lis3lv02d/lis3lv02d_i2c.c b/drivers/misc/lis3lv02d/lis3lv02d_i2c.c
index 4001e3c0a167..4fe5ff8cacb8 100644
--- a/drivers/misc/lis3lv02d/lis3lv02d_i2c.c
+++ b/drivers/misc/lis3lv02d/lis3lv02d_i2c.c
@@ -105,7 +105,7 @@ MODULE_DEVICE_TABLE(of, lis3lv02d_i2c_dt_ids);
 static int lis3lv02d_i2c_probe(struct i2c_client *client,
 					const struct i2c_device_id *id)
 {
-	int ret = 0;
+	int ret = 0, err;
 	struct lis3lv02d_platform_data *pdata = client->dev.platform_data;
 
 #ifdef CONFIG_OF
@@ -160,11 +160,19 @@ static int lis3lv02d_i2c_probe(struct i2c_client *client,
 	i2c_set_clientdata(client, &lis3_dev);
 
 	/* Provide power over the init call */
-	lis3_reg_ctrl(&lis3_dev, LIS3_REG_ON);
+	err = lis3_reg_ctrl(&lis3_dev, LIS3_REG_ON);
+	if (err) {
+		ret = err;
+		goto fail2;
+	}
 
 	ret = lis3lv02d_init_device(&lis3_dev);
 
-	lis3_reg_ctrl(&lis3_dev, LIS3_REG_OFF);
+	err = lis3_reg_ctrl(&lis3_dev, LIS3_REG_OFF);
+	if (err) {
+		ret = err;
+		goto fail2;
+	}
 
 	if (ret)
 		goto fail2;
-- 
2.25.1

