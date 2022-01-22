Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2811496AF9
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 09:18:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232156AbiAVISg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 03:18:36 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:35855 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbiAVISY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 03:18:24 -0500
Received: from dggpeml500025.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4JgpyR3GjKzccWZ;
        Sat, 22 Jan 2022 16:17:35 +0800 (CST)
Received: from dggpeml100012.china.huawei.com (7.185.36.121) by
 dggpeml500025.china.huawei.com (7.185.36.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Sat, 22 Jan 2022 16:18:22 +0800
Received: from huawei.com (10.67.165.24) by dggpeml100012.china.huawei.com
 (7.185.36.121) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Sat, 22 Jan
 2022 16:18:22 +0800
From:   Kai Ye <yekai13@huawei.com>
To:     <herbert@gondor.apana.org.au>
CC:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <wangzhou1@hisilicon.com>, <yekai13@huawei.com>
Subject: [PATCH v3 3/5] crypto: hisilicon/sec - fix the max length of AAD for the CCM mode
Date:   Sat, 22 Jan 2022 16:13:10 +0800
Message-ID: <20220122081312.29121-4-yekai13@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220122081312.29121-1-yekai13@huawei.com>
References: <20220122081312.29121-1-yekai13@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.24]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml100012.china.huawei.com (7.185.36.121)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the maximum length of AAD for the CCM mode due to the hardware limited.

Signed-off-by: Kai Ye <yekai13@huawei.com>
---
 drivers/crypto/hisilicon/sec2/sec_crypto.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/crypto/hisilicon/sec2/sec_crypto.c b/drivers/crypto/hisilicon/sec2/sec_crypto.c
index 48abd3871c0e..8305eee9a3d3 100644
--- a/drivers/crypto/hisilicon/sec2/sec_crypto.c
+++ b/drivers/crypto/hisilicon/sec2/sec_crypto.c
@@ -63,6 +63,7 @@
 #define SEC_AUTH_CIPHER		0x1
 #define SEC_MAX_MAC_LEN		64
 #define SEC_MAX_AAD_LEN		65535
+#define SEC_MAX_CCM_AAD_LEN	65279
 #define SEC_TOTAL_MAC_SZ	(SEC_MAX_MAC_LEN * QM_Q_DEPTH)
 
 #define SEC_PBUF_SZ			512
@@ -2220,6 +2221,10 @@ static int sec_aead_spec_check(struct sec_ctx *ctx, struct sec_req *sreq)
 	}
 
 	if (c_mode == SEC_CMODE_CCM) {
+		if (unlikely(req->assoclen > SEC_MAX_CCM_AAD_LEN)) {
+			dev_err_ratelimited(dev, "CCM input aad parameter is too long!\n");
+			return -EINVAL;
+		}
 		ret = aead_iv_demension_check(req);
 		if (ret) {
 			dev_err(dev, "aead input iv param error!\n");
-- 
2.33.0

