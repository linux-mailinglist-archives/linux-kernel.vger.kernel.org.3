Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 622F04DC049
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 08:39:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbiCQHlE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 03:41:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230362AbiCQHlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 03:41:02 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68338ABF46
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 00:39:46 -0700 (PDT)
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KJzX663pkzfYqx;
        Thu, 17 Mar 2022 15:38:14 +0800 (CST)
Received: from dggpeml500003.china.huawei.com (7.185.36.200) by
 dggpeml500026.china.huawei.com (7.185.36.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 17 Mar 2022 15:39:43 +0800
Received: from huawei.com (10.175.103.91) by dggpeml500003.china.huawei.com
 (7.185.36.200) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Thu, 17 Mar
 2022 15:39:43 +0800
From:   Yu Liao <liaoyu15@huawei.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <marcel@holtmann.org>, <liaoyu15@huawei.com>, <liwei391@huawei.com>
Subject: [PATCH] Bluetooth: btmtkuart: fix free unallocated memory in mtk_hci_wmt_sync()
Date:   Thu, 17 Mar 2022 15:48:57 +0800
Message-ID: <20220317074857.688388-1-liaoyu15@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500003.china.huawei.com (7.185.36.200)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If 'hlen > 255' is true, jump to 'err_free_skb' label and
free 'wc' that not allocated.
Fix by initializing 'wc' with NULL, as no operation is performed in
kfree().

	if (hlen > 255) {
		err = -EINVAL;
		goto err_free_skb;
	}
	...
	err_free_skb:
		kfree_skb(bdev->evt_skb);
		bdev->evt_skb = NULL;
	err_free_wc:
		kfree(wc);

Fixes: 3e5f2d90c28f ("Bluetooth: btmtkuart: fix a memleak in mtk_hci_wmt_sync")
Signed-off-by: Yu Liao <liaoyu15@huawei.com>
---
 drivers/bluetooth/btmtkuart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btmtkuart.c b/drivers/bluetooth/btmtkuart.c
index 695e1225b08c..4f3b2d3fa941 100644
--- a/drivers/bluetooth/btmtkuart.c
+++ b/drivers/bluetooth/btmtkuart.c
@@ -93,7 +93,7 @@ static int mtk_hci_wmt_sync(struct hci_dev *hdev,
 	struct btmtk_hci_wmt_evt_funcc *wmt_evt_funcc;
 	u32 hlen, status = BTMTK_WMT_INVALID;
 	struct btmtk_hci_wmt_evt *wmt_evt;
-	struct btmtk_hci_wmt_cmd *wc;
+	struct btmtk_hci_wmt_cmd *wc = NULL;
 	struct btmtk_wmt_hdr *hdr;
 	int err;
 
-- 
2.25.1

