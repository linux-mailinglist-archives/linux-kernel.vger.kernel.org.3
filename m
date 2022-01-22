Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2830C496AFA
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 09:18:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232757AbiAVISi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 03:18:38 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:31113 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbiAVISY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 03:18:24 -0500
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Jgptw6yCsz1FCYK;
        Sat, 22 Jan 2022 16:14:32 +0800 (CST)
Received: from dggpeml100012.china.huawei.com (7.185.36.121) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Sat, 22 Jan 2022 16:18:22 +0800
Received: from huawei.com (10.67.165.24) by dggpeml100012.china.huawei.com
 (7.185.36.121) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Sat, 22 Jan
 2022 16:18:21 +0800
From:   Kai Ye <yekai13@huawei.com>
To:     <herbert@gondor.apana.org.au>
CC:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <wangzhou1@hisilicon.com>, <yekai13@huawei.com>
Subject: [PATCH v3 1/5] crypto: hisilicon/sec - fixup icv checking enabled on Kunpeng 930
Date:   Sat, 22 Jan 2022 16:13:08 +0800
Message-ID: <20220122081312.29121-2-yekai13@huawei.com>
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

Fixup icv(integrity check value) checking enabled wrong on
Kunpeng 930

Signed-off-by: Kai Ye <yekai13@huawei.com>
---
 drivers/crypto/hisilicon/sec2/sec_crypto.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/hisilicon/sec2/sec_crypto.c b/drivers/crypto/hisilicon/sec2/sec_crypto.c
index 6a45bd23b363..bf93c9847365 100644
--- a/drivers/crypto/hisilicon/sec2/sec_crypto.c
+++ b/drivers/crypto/hisilicon/sec2/sec_crypto.c
@@ -1614,7 +1614,7 @@ static void sec_auth_bd_fill_ex_v3(struct sec_auth_ctx *ctx, int dir,
 		sqe3->auth_mac_key |= cpu_to_le32((u32)SEC_AUTH_TYPE1);
 		sqe3->huk_iv_seq &= SEC_CIPHER_AUTH_V3;
 	} else {
-		sqe3->auth_mac_key |= cpu_to_le32((u32)SEC_AUTH_TYPE1);
+		sqe3->auth_mac_key |= cpu_to_le32((u32)SEC_AUTH_TYPE2);
 		sqe3->huk_iv_seq |= SEC_AUTH_CIPHER_V3;
 	}
 	sqe3->a_len_key = cpu_to_le32(c_req->c_len + aq->assoclen);
-- 
2.33.0

