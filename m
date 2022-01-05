Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9239A484C8E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 03:37:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237125AbiAEChF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 21:37:05 -0500
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:47330 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236989AbiAEChE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 21:37:04 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0V1-t5Gh_1641350221;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0V1-t5Gh_1641350221)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 05 Jan 2022 10:37:02 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     t.schramm@manjaro.org
Cc:     sre@kernel.org, linus.walleij@linaro.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] power: supply_core: fix application of sizeof to pointer
Date:   Wed,  5 Jan 2022 10:37:00 +0800
Message-Id: <20220105023700.10966-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The coccinelle check report:
./drivers/power/supply/cw2015_battery.c:692:12-18: ERROR: application of
sizeof to pointer

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Fixes: 25fd330370ac ("power: supply_core: Pass pointer to battery info")
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/power/supply/cw2015_battery.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/cw2015_battery.c b/drivers/power/supply/cw2015_battery.c
index 0c87ad0dbf71..728e2a6cc9c3 100644
--- a/drivers/power/supply/cw2015_battery.c
+++ b/drivers/power/supply/cw2015_battery.c
@@ -689,7 +689,7 @@ static int cw_bat_probe(struct i2c_client *client)
 	if (ret) {
 		/* Allocate an empty battery */
 		cw_bat->battery = devm_kzalloc(&client->dev,
-					       sizeof(cw_bat->battery),
+					       sizeof(*cw_bat->battery),
 					       GFP_KERNEL);
 		if (!cw_bat->battery)
 			return -ENOMEM;
-- 
2.20.1.7.g153144c

