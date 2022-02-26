Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDA804C54E4
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 10:28:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbiBZJ2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 04:28:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbiBZJ2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 04:28:11 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA0A8443F8;
        Sat, 26 Feb 2022 01:27:29 -0800 (PST)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4K5Lmr4Y5Xz9sJF;
        Sat, 26 Feb 2022 17:23:56 +0800 (CST)
Received: from localhost.localdomain (10.175.102.38) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Sat, 26 Feb 2022 17:27:26 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     <weiyongjun1@huawei.com>, Theodore Ts'o <tytso@mit.edu>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
CC:     <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        Hulk Robot <hulkci@huawei.com>
Subject: [PATCH -next] virt: vmgenid: fix return value check in vmgenid_acpi_add()
Date:   Sat, 26 Feb 2022 09:43:31 +0000
Message-ID: <20220226094331.3268683-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.102.38]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case of error, the function devm_memremap() returns ERR_PTR()
and never returns NULL. The NULL test in the return value check
should be replaced with IS_ERR().

Fixes: d54207b61470 ("virt: vmgenid: introduce driver for reinitializing RNG on VM fork")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/virt/vmgenid.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/virt/vmgenid.c b/drivers/virt/vmgenid.c
index b503c210c2d7..344f6fcc01da 100644
--- a/drivers/virt/vmgenid.c
+++ b/drivers/virt/vmgenid.c
@@ -50,8 +50,8 @@ static int vmgenid_acpi_add(struct acpi_device *device)
 	phys_addr = (obj->package.elements[0].integer.value << 0) |
 		    (obj->package.elements[1].integer.value << 32);
 	state->next_id = devm_memremap(&device->dev, phys_addr, VMGENID_SIZE, MEMREMAP_WB);
-	if (!state->next_id) {
-		ret = -ENOMEM;
+	if (IS_ERR(state->next_id)) {
+		ret = PTR_ERR(state->next_id);
 		goto out;
 	}
 

