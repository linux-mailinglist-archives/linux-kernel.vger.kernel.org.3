Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C32D3464AD7
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 10:44:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348320AbhLAJrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 04:47:19 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:28209 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346106AbhLAJrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 04:47:17 -0500
Received: from dggpeml500025.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4J3vHn1FSkz8vlR;
        Wed,  1 Dec 2021 17:41:57 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggpeml500025.china.huawei.com (7.185.36.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 1 Dec 2021 17:43:55 +0800
Received: from huawei.com (10.175.103.91) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Wed, 1 Dec
 2021 17:43:55 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-staging@lists.linux.dev>
CC:     <gregkh@linuxfoundation.org>, <paskripkin@gmail.com>,
        <dan.carpenter@oracle.com>
Subject: [PATCH -next 2/3] staging: rtl8192e: rtllib_module: fix error handle case in alloc_rtllib()
Date:   Wed, 1 Dec 2021 17:50:35 +0800
Message-ID: <20211201095036.1763163-3-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211201095036.1763163-1-yangyingliang@huawei.com>
References: <20211201095036.1763163-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some variables are leaked in the error handling in alloc_rtllib(), free
the variables in the error path.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/staging/rtl8192e/rtllib_module.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_module.c b/drivers/staging/rtl8192e/rtllib_module.c
index 64d9feee1f39..a3c74fa25cfa 100644
--- a/drivers/staging/rtl8192e/rtllib_module.c
+++ b/drivers/staging/rtl8192e/rtllib_module.c
@@ -88,7 +88,7 @@ struct net_device *alloc_rtllib(int sizeof_priv)
 	err = rtllib_networks_allocate(ieee);
 	if (err) {
 		pr_err("Unable to allocate beacon storage: %d\n", err);
-		goto failed;
+		goto free_netdev;
 	}
 	rtllib_networks_initialize(ieee);
 
@@ -121,11 +121,13 @@ struct net_device *alloc_rtllib(int sizeof_priv)
 	ieee->hwsec_active = 0;
 
 	memset(ieee->swcamtable, 0, sizeof(struct sw_cam_table) * 32);
-	rtllib_softmac_init(ieee);
+	err = rtllib_softmac_init(ieee);
+	if (err)
+		goto free_networks;
 
 	ieee->pHTInfo = kzalloc(sizeof(struct rt_hi_throughput), GFP_KERNEL);
 	if (!ieee->pHTInfo)
-		return NULL;
+		goto free_softmac;
 
 	HTUpdateDefaultSetting(ieee);
 	HTInitializeHTInfo(ieee);
@@ -141,8 +143,14 @@ struct net_device *alloc_rtllib(int sizeof_priv)
 
 	return dev;
 
- failed:
+free_softmac:
+	rtllib_softmac_free(ieee);
+	lib80211_crypt_info_free(&ieee->crypt_info);
+free_networks:
+	rtllib_networks_free(ieee);
+free_netdev:
 	free_netdev(dev);
+
 	return NULL;
 }
 EXPORT_SYMBOL(alloc_rtllib);
-- 
2.25.1

