Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAF504807CE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 10:27:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235943AbhL1J1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 04:27:14 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:52776 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229617AbhL1J1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 04:27:13 -0500
X-UUID: c683a1efdd1d4df1857fcdcb731043b0-20211228
X-UUID: c683a1efdd1d4df1857fcdcb731043b0-20211228
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <mark-pk.tsai@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 160455497; Tue, 28 Dec 2021 17:27:11 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 28 Dec 2021 17:27:09 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 28 Dec 2021 17:27:09 +0800
From:   Mark-PK Tsai <mark-pk.tsai@mediatek.com>
To:     <gregkh@linuxfoundation.org>, <rafael@kernel.org>
CC:     <matthias.bgg@gmail.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <mark-pk.tsai@mediatek.com>,
        <yj.chiang@mediatek.com>
Subject: [PATCH] driver core: Simplify async probe test code by using ktime_ms_delta()
Date:   Tue, 28 Dec 2021 17:27:07 +0800
Message-ID: <20211228092707.29987-1-mark-pk.tsai@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify async probe test code by using ktime_ms_delta().

Signed-off-by: Mark-PK Tsai <mark-pk.tsai@mediatek.com>
---
 drivers/base/test/test_async_driver_probe.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/base/test/test_async_driver_probe.c b/drivers/base/test/test_async_driver_probe.c
index 3bb7beb127a9..4d1976ca5072 100644
--- a/drivers/base/test/test_async_driver_probe.c
+++ b/drivers/base/test/test_async_driver_probe.c
@@ -104,7 +104,7 @@ static int __init test_async_probe_init(void)
 	struct platform_device **pdev = NULL;
 	int async_id = 0, sync_id = 0;
 	unsigned long long duration;
-	ktime_t calltime, delta;
+	ktime_t calltime;
 	int err, nid, cpu;
 
 	pr_info("registering first set of asynchronous devices...\n");
@@ -133,8 +133,7 @@ static int __init test_async_probe_init(void)
 		goto err_unregister_async_devs;
 	}
 
-	delta = ktime_sub(ktime_get(), calltime);
-	duration = (unsigned long long) ktime_to_ms(delta);
+	duration = (unsigned long long)ktime_ms_delta(ktime_get(), calltime);
 	pr_info("registration took %lld msecs\n", duration);
 	if (duration > TEST_PROBE_THRESHOLD) {
 		pr_err("test failed: probe took too long\n");
@@ -161,8 +160,7 @@ static int __init test_async_probe_init(void)
 		async_id++;
 	}
 
-	delta = ktime_sub(ktime_get(), calltime);
-	duration = (unsigned long long) ktime_to_ms(delta);
+	duration = (unsigned long long)ktime_ms_delta(ktime_get(), calltime);
 	dev_info(&(*pdev)->dev,
 		 "registration took %lld msecs\n", duration);
 	if (duration > TEST_PROBE_THRESHOLD) {
@@ -197,8 +195,7 @@ static int __init test_async_probe_init(void)
 		goto err_unregister_sync_devs;
 	}
 
-	delta = ktime_sub(ktime_get(), calltime);
-	duration = (unsigned long long) ktime_to_ms(delta);
+	duration = (unsigned long long)ktime_ms_delta(ktime_get(), calltime);
 	pr_info("registration took %lld msecs\n", duration);
 	if (duration < TEST_PROBE_THRESHOLD) {
 		dev_err(&(*pdev)->dev,
@@ -223,8 +220,7 @@ static int __init test_async_probe_init(void)
 
 	sync_id++;
 
-	delta = ktime_sub(ktime_get(), calltime);
-	duration = (unsigned long long) ktime_to_ms(delta);
+	duration = (unsigned long long)ktime_ms_delta(ktime_get(), calltime);
 	dev_info(&(*pdev)->dev,
 		 "registration took %lld msecs\n", duration);
 	if (duration < TEST_PROBE_THRESHOLD) {
-- 
2.18.0

