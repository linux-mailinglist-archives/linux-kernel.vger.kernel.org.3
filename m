Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 563AD509B04
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 10:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386911AbiDUIve (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 04:51:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386902AbiDUIv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 04:51:26 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D5A615805
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 01:48:37 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KkWQy2zQ3zhY3w;
        Thu, 21 Apr 2022 16:48:26 +0800 (CST)
Received: from localhost.localdomain (10.175.102.38) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 21 Apr 2022 16:48:35 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Wei Yongjun <weiyongjun1@huawei.com>,
        Support Opensource <support.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Adam Ward <Adam.Ward.opensource@diasemi.com>,
        Hulk Robot <hulkci@huawei.com>
Subject: [PATCH] regulator: da9121: Fix uninit-value in da9121_assign_chip_model()
Date:   Thu, 21 Apr 2022 09:03:35 +0000
Message-ID: <20220421090335.1876149-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.102.38]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KASAN report slab-out-of-bounds in __regmap_init as follows:

BUG: KASAN: slab-out-of-bounds in __regmap_init drivers/base/regmap/regmap.c:841
Read of size 1 at addr ffff88803678cdf1 by task xrun/9137

CPU: 0 PID: 9137 Comm: xrun Tainted: G        W         5.18.0-rc2
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x15a lib/dump_stack.c:88
 print_report.cold+0xcd/0x69b mm/kasan/report.c:313
 kasan_report+0x8e/0xc0 mm/kasan/report.c:491
 __regmap_init+0x4540/0x4ba0 drivers/base/regmap/regmap.c:841
 __devm_regmap_init+0x7a/0x100 drivers/base/regmap/regmap.c:1266
 __devm_regmap_init_i2c+0x65/0x80 drivers/base/regmap/regmap-i2c.c:394
 da9121_i2c_probe+0x386/0x6d1 drivers/regulator/da9121-regulator.c:1039
 i2c_device_probe+0x959/0xac0 drivers/i2c/i2c-core-base.c:563

This happend when da9121 device is probe by da9121_i2c_id, but with
invalid dts. Thus, chip->subvariant_id is set to -EINVAL, and later
da9121_assign_chip_model() will access 'regmap' without init it.

Fix it by return -EINVAL from da9121_assign_chip_model() if
'chip->subvariant_id' is invalid.

Fixes: f3fbd5566f6a ("regulator: da9121: Add device variants")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/regulator/da9121-regulator.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/regulator/da9121-regulator.c b/drivers/regulator/da9121-regulator.c
index eb9df485bd8a..76e0e23bf598 100644
--- a/drivers/regulator/da9121-regulator.c
+++ b/drivers/regulator/da9121-regulator.c
@@ -1030,6 +1030,8 @@ static int da9121_assign_chip_model(struct i2c_client *i2c,
 		chip->variant_id = DA9121_TYPE_DA9142;
 		regmap = &da9121_2ch_regmap_config;
 		break;
+	default:
+		return -EINVAL;
 	}
 
 	/* Set these up for of_regulator_match call which may want .of_map_modes */
-- 
2.25.1

