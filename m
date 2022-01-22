Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D261496B71
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 10:36:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231331AbiAVJf4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 04:35:56 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:17360 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbiAVJfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 04:35:53 -0500
Received: from dggpeml500024.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4JgrgH22kmz9rxh;
        Sat, 22 Jan 2022 17:34:35 +0800 (CST)
Received: from dggpeml100012.china.huawei.com (7.185.36.121) by
 dggpeml500024.china.huawei.com (7.185.36.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Sat, 22 Jan 2022 17:35:51 +0800
Received: from huawei.com (10.67.165.24) by dggpeml100012.china.huawei.com
 (7.185.36.121) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Sat, 22 Jan
 2022 17:35:51 +0800
From:   Kai Ye <yekai13@huawei.com>
To:     <herbert@gondor.apana.org.au>
CC:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <wangzhou1@hisilicon.com>, <yekai13@huawei.com>
Subject: [PATCH v2] crypto: hisilicon/qm - cleanup warning in qm_vf_read_qos
Date:   Sat, 22 Jan 2022 17:30:42 +0800
Message-ID: <20220122093042.40131-1-yekai13@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.24]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml100012.china.huawei.com (7.185.36.121)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel test rebot report this warning: Uninitialized variable: ret.
The code flow may return value of ret directly. This value is an
uninitialized variable, here is fix it.

Signed-off-by: Kai Ye <yekai13@huawei.com>
---
changes v1->v2:
	modfiy the comments.

 drivers/crypto/hisilicon/qm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/hisilicon/qm.c b/drivers/crypto/hisilicon/qm.c
index c5b84a5ea350..3b29c8993b8c 100644
--- a/drivers/crypto/hisilicon/qm.c
+++ b/drivers/crypto/hisilicon/qm.c
@@ -4295,7 +4295,7 @@ static void qm_vf_get_qos(struct hisi_qm *qm, u32 fun_num)
 static int qm_vf_read_qos(struct hisi_qm *qm)
 {
 	int cnt = 0;
-	int ret;
+	int ret = -EINVAL;
 
 	/* reset mailbox qos val */
 	qm->mb_qos = 0;
-- 
2.33.0

