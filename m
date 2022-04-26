Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 006E250FBB8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 13:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349392AbiDZLMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 07:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240024AbiDZLM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 07:12:27 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 368433B3C5;
        Tue, 26 Apr 2022 04:09:19 -0700 (PDT)
Received: from dggpeml500024.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KnfJx3RflzhYs4;
        Tue, 26 Apr 2022 19:09:05 +0800 (CST)
Received: from huawei.com (10.175.112.208) by dggpeml500024.china.huawei.com
 (7.185.36.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 26 Apr
 2022 19:09:17 +0800
From:   Yuan Can <yuancan@huawei.com>
To:     <linux-rtc@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <a.zummo@towertech.it>,
        <alexandre.belloni@bootlin.com>, <yuancan@huawei.com>
Subject: [PATCH -next] rtc: gamecube: Add missing iounmap in gamecube_rtc_read_offset_from_sram
Date:   Tue, 26 Apr 2022 11:05:13 +0000
Message-ID: <20220426110513.49575-1-yuancan@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.208]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500024.china.huawei.com (7.185.36.10)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hw_srnprot needs to be unmapped when gamecube_rtc_read_offset_from_sram returns.

Fixs: 86559400b3ef9d (rtc: gamecube: Add a RTC driver for the GameCube, Wii and Wii U)
Signed-off-by: Yuan Can <yuancan@huawei.com>
---
 drivers/rtc/rtc-gamecube.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/rtc/rtc-gamecube.c b/drivers/rtc/rtc-gamecube.c
index 18ca3b38b2d0..c2717bb52b2b 100644
--- a/drivers/rtc/rtc-gamecube.c
+++ b/drivers/rtc/rtc-gamecube.c
@@ -267,6 +267,7 @@ static int gamecube_rtc_read_offset_from_sram(struct priv *d)
 	ret = regmap_read(d->regmap, RTC_SRAM_BIAS, &d->rtc_bias);
 	if (ret) {
 		pr_err("failed to get the RTC bias\n");
+		iounmap(hw_srnprot);
 		return -1;
 	}
 
-- 
2.17.1

