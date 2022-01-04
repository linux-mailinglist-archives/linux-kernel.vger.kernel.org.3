Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02C2C4842D8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 14:54:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233892AbiADNyG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 08:54:06 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:17325 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233881AbiADNyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 08:54:05 -0500
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4JSvFn6Trrz9rwF;
        Tue,  4 Jan 2022 21:53:01 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Tue, 4 Jan
 2022 21:54:03 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <mezin.alexander@gmail.com>, <jdelvare@suse.com>,
        <linux@roeck-us.net>
CC:     <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] hwmon: (nzxt-smart2) Fix build with CONFIG_PM=n
Date:   Tue, 4 Jan 2022 21:53:28 +0800
Message-ID: <20220104135328.604-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500007.china.huawei.com (7.192.104.62)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/hwmon/nzxt-smart2.c:707:12: error: 'nzxt_smart2_hid_reset_resume' defined but not used [-Werror=unused-function]
  707 | static int nzxt_smart2_hid_reset_resume(struct hid_device *hdev)
      |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~

Move it into #ifdef block to fix this.

Fixes: 0e43f31ee52f ("hwmon: add driver for NZXT RGB&Fan Controller/Smart Device v2.")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/hwmon/nzxt-smart2.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hwmon/nzxt-smart2.c b/drivers/hwmon/nzxt-smart2.c
index 534d39b8908e..4963d630394a 100644
--- a/drivers/hwmon/nzxt-smart2.c
+++ b/drivers/hwmon/nzxt-smart2.c
@@ -704,6 +704,7 @@ static int nzxt_smart2_hid_raw_event(struct hid_device *hdev,
 	return 0;
 }
 
+#ifdef CONFIG_PM
 static int nzxt_smart2_hid_reset_resume(struct hid_device *hdev)
 {
 	struct drvdata *drvdata = hid_get_drvdata(hdev);
@@ -720,6 +721,7 @@ static int nzxt_smart2_hid_reset_resume(struct hid_device *hdev)
 
 	return init_device(drvdata, drvdata->update_interval);
 }
+#endif
 
 static int nzxt_smart2_hid_probe(struct hid_device *hdev,
 				 const struct hid_device_id *id)
-- 
2.17.1

