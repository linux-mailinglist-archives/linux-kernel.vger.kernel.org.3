Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D53D509CCE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 11:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387948AbiDUJ4j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 05:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387935AbiDUJ4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 05:56:30 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23A7825C47
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 02:53:38 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4KkXsG3Xphz1J9xb;
        Thu, 21 Apr 2022 17:52:50 +0800 (CST)
Received: from localhost.localdomain (10.175.102.38) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 21 Apr 2022 17:53:36 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     Corey Minyard <minyard@acm.org>
CC:     Wei Yongjun <weiyongjun1@huawei.com>,
        <openipmi-developer@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, Hulk Robot <hulkci@huawei.com>
Subject: [PATCH] ipmi: ipmi_ipmb: Fix null-ptr-deref in ipmi_unregister_smi()
Date:   Thu, 21 Apr 2022 10:08:35 +0000
Message-ID: <20220421100835.1942677-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.102.38]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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

KASAN report null-ptr-deref as follows:

KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
RIP: 0010:ipmi_unregister_smi+0x7d/0xd50 drivers/char/ipmi/ipmi_msghandler.c:3680
Call Trace:
 ipmi_ipmb_remove+0x138/0x1a0 drivers/char/ipmi/ipmi_ipmb.c:443
 ipmi_ipmb_probe+0x409/0xda1 drivers/char/ipmi/ipmi_ipmb.c:548
 i2c_device_probe+0x959/0xac0 drivers/i2c/i2c-core-base.c:563
 really_probe+0x3f3/0xa70 drivers/base/dd.c:541

In ipmi_ipmb_probe(), 'iidev->intf' is not set before ipmi_register_smi() success.
And in the error handling case, ipmi_ipmb_remove() is called to release resources,
ipmi_unregister_smi() is called without check 'iidev->intf', this will cause KASAN
null-ptr-deref issue.

Fix by adding NULL check prior to calling ipmi_unregister_smi().

Fixes: 57c9e3c9a374 ("ipmi:ipmi_ipmb: Unregister the SMI on remove")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/char/ipmi/ipmi_ipmb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/char/ipmi/ipmi_ipmb.c b/drivers/char/ipmi/ipmi_ipmb.c
index b81b862532fb..ea8fdb5ecfc9 100644
--- a/drivers/char/ipmi/ipmi_ipmb.c
+++ b/drivers/char/ipmi/ipmi_ipmb.c
@@ -437,7 +437,8 @@ static int ipmi_ipmb_remove(struct i2c_client *client)
 	iidev->client = NULL;
 	ipmi_ipmb_stop_thread(iidev);
 
-	ipmi_unregister_smi(iidev->intf);
+	if (iidev->intf)
+		ipmi_unregister_smi(iidev->intf);
 
 	return 0;
 }
-- 
2.25.1

