Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71FDF496AFB
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 09:18:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232916AbiAVISk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 03:18:40 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:31177 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbiAVISY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 03:18:24 -0500
Received: from dggpeml500020.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Jgpw13ldyz8wNQ;
        Sat, 22 Jan 2022 16:15:29 +0800 (CST)
Received: from dggpeml100012.china.huawei.com (7.185.36.121) by
 dggpeml500020.china.huawei.com (7.185.36.88) with Microsoft SMTP Server
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
Subject: [PATCH v3 4/5] crypto: hisilicon/sec - fix the CTR mode BD configuration
Date:   Sat, 22 Jan 2022 16:13:11 +0800
Message-ID: <20220122081312.29121-5-yekai13@huawei.com>
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

The CTR counter is 32bit rollover default on the BD.
But the NIST standard is 128bit rollover. it cause the
testing failed, so need to fix the BD configuration.

Signed-off-by: Kai Ye <yekai13@huawei.com>
---
 drivers/crypto/hisilicon/sec2/sec_crypto.c | 6 ++++++
 drivers/crypto/hisilicon/sec2/sec_crypto.h | 6 ++++--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/hisilicon/sec2/sec_crypto.c b/drivers/crypto/hisilicon/sec2/sec_crypto.c
index 8305eee9a3d3..7013272134b2 100644
--- a/drivers/crypto/hisilicon/sec2/sec_crypto.c
+++ b/drivers/crypto/hisilicon/sec2/sec_crypto.c
@@ -42,6 +42,8 @@
 #define SEC_DE_OFFSET_V3		9
 #define SEC_SCENE_OFFSET_V3	5
 #define SEC_CKEY_OFFSET_V3	13
+#define SEC_CTR_CNT_OFFSET	25
+#define SEC_CTR_CNT_ROLLOVER	2
 #define SEC_SRC_SGL_OFFSET_V3	11
 #define SEC_DST_SGL_OFFSET_V3	14
 #define SEC_CALG_OFFSET_V3	4
@@ -1303,6 +1305,10 @@ static int sec_skcipher_bd_fill_v3(struct sec_ctx *ctx, struct sec_req *req)
 		cipher = SEC_CIPHER_DEC;
 	sec_sqe3->c_icv_key |= cpu_to_le16(cipher);
 
+	/* Set the CTR counter mode is 128bit rollover */
+	sec_sqe3->auth_mac_key = cpu_to_le32((u32)SEC_CTR_CNT_ROLLOVER <<
+					SEC_CTR_CNT_OFFSET);
+
 	if (req->use_pbuf) {
 		bd_param |= SEC_PBUF << SEC_SRC_SGL_OFFSET_V3;
 		bd_param |= SEC_PBUF << SEC_DST_SGL_OFFSET_V3;
diff --git a/drivers/crypto/hisilicon/sec2/sec_crypto.h b/drivers/crypto/hisilicon/sec2/sec_crypto.h
index 9f71c358a6d3..5e039b50e9d4 100644
--- a/drivers/crypto/hisilicon/sec2/sec_crypto.h
+++ b/drivers/crypto/hisilicon/sec2/sec_crypto.h
@@ -354,8 +354,10 @@ struct sec_sqe3 {
 	 * akey_len: 9~14 bits
 	 * a_alg: 15~20 bits
 	 * key_sel: 21~24 bits
-	 * updata_key: 25 bits
-	 * reserved: 26~31 bits
+	 * ctr_count_mode/sm4_xts: 25~26 bits
+	 * sva_prefetch: 27 bits
+	 * key_wrap_num: 28~30 bits
+	 * update_key: 31 bits
 	 */
 	__le32 auth_mac_key;
 	__le32 salt;
-- 
2.33.0

