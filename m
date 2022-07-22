Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F89957DF2F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 12:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236560AbiGVJiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 05:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236462AbiGVJhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 05:37:51 -0400
Received: from m12-16.163.com (m12-16.163.com [220.181.12.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 032B79FE38;
        Fri, 22 Jul 2022 02:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=bAwmZ
        Pcw9Ip68eN1muAO0vCpAobhqxq1FA0dWqWMz4M=; b=S+PE6JNTOR4sI/+m4u8dZ
        yzRbkx7r0sjunArheVbc6aJM2UPWAHQZuHzJZv6ikvOXds3fSWP6GRQtj1plSBCA
        3AfH44Ek9G5Sd5fo9hUOI/FHRNRQLvF43adp0LEISRTCQcTHyzGo0TSpSyUm5L98
        cvry8+AnEatg25l1oIZtnA=
Received: from localhost.localdomain (unknown [123.58.221.99])
        by smtp12 (Coremail) with SMTP id EMCowABXXZXwbNpiSfPbCw--.10S2;
        Fri, 22 Jul 2022 17:25:11 +0800 (CST)
From:   williamsukatube@163.com
To:     wim@linux-watchdog.org, linux@roeck-us.net,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     William Dean <williamsukatube@gmail.com>,
        Hacash Robot <hacashRobot@santino.com>
Subject: [PATCH] watchdog: f71808e_wdt: Add check for platform_driver_register
Date:   Fri, 22 Jul 2022 17:25:03 +0800
Message-Id: <20220722092503.2938544-1-williamsukatube@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: EMCowABXXZXwbNpiSfPbCw--.10S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Jr4DCF47Gry3ZFyDur15urg_yoWDArc_ur
        y7WF47urWkKF47KF15t3Wavw129F1rAFykuw4ktrWak3yxJFyUWr4DZF1jgw1kAr90vrWD
        twn8Jr1Skry3GjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU5XYFtUUUUU==
X-Originating-IP: [123.58.221.99]
X-CM-SenderInfo: xzlozx5dpv3yxdwxuvi6rwjhhfrp/xtbB6AdGg2BHJoY4tQABsh
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: William Dean <williamsukatube@gmail.com>

As platform_driver_register() could fail, it should be better
to deal with the return value in order to maintain the code
consisitency.

Fixes: 27e0fe00a5c61 ("watchdog: f71808e_wdt: refactor to platform device/driver pair")
Reported-by: Hacash Robot <hacashRobot@santino.com>
Signed-off-by: William Dean <williamsukatube@gmail.com>
---
 drivers/watchdog/f71808e_wdt.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/watchdog/f71808e_wdt.c b/drivers/watchdog/f71808e_wdt.c
index 7f59c680de25..6a16d3d0bb1e 100644
--- a/drivers/watchdog/f71808e_wdt.c
+++ b/drivers/watchdog/f71808e_wdt.c
@@ -634,7 +634,9 @@ static int __init fintek_wdt_init(void)
 
 	pdata.type = ret;
 
-	platform_driver_register(&fintek_wdt_driver);
+	ret = platform_driver_register(&fintek_wdt_driver);
+	if (ret)
+		return ret;
 
 	wdt_res.name = "superio port";
 	wdt_res.flags = IORESOURCE_IO;
-- 
2.25.1

