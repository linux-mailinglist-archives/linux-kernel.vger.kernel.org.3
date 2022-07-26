Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A750580929
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 03:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236740AbiGZBp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 21:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbiGZBp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 21:45:56 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00017DF9E;
        Mon, 25 Jul 2022 18:45:54 -0700 (PDT)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4LsKRp0RY0z1M8MN;
        Tue, 26 Jul 2022 09:43:02 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (7.193.23.202) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 26 Jul 2022 09:45:52 +0800
Received: from ubuntu1804.huawei.com (10.67.174.149) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 26 Jul 2022 09:45:51 +0800
From:   Ye Weihua <yeweihua4@huawei.com>
To:     <wangzhou1@hisilicon.com>, <herbert@gondor.apana.org.au>,
        <davem@davemloft.net>
CC:     <tanshukun1@huawei.com>, <linux-crypto@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <zhangjinhao2@huawei.com>
Subject: [PATCH] drivers: hisilicon: fix mismatch in get/set sgl_sge_nr
Date:   Tue, 26 Jul 2022 09:43:10 +0800
Message-ID: <20220726014310.234760-1-yeweihua4@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.149]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KASAN reported this Bug:

	[17619.659757] BUG: KASAN: global-out-of-bounds in param_get_int+0x34/0x60
	[17619.673193] Read of size 4 at addr fffff01332d7ed00 by task read_all/1507958
	...
	[17619.698934] The buggy address belongs to the variable:
	[17619.708371]  sgl_sge_nr+0x0/0xffffffffffffa300 [hisi_zip]

There is a mismatch in hisi_zip when get/set the variable sgl_sge_nr.
The type of sgl_sge_nr is u16, and get/set sgl_sge_nr by
param_get/set_int.

Replacing param_get/set_int to param_get/set_ushort can fix this bug.

Fixes: f081fda293ffb ("crypto: hisilicon - add sgl_sge_nr module param for zip")
Signed-off-by: Ye Weihua <yeweihua4@huawei.com>
---
 drivers/crypto/hisilicon/zip/zip_crypto.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/hisilicon/zip/zip_crypto.c b/drivers/crypto/hisilicon/zip/zip_crypto.c
index 9520a4113c81..a91e6e0e9c69 100644
--- a/drivers/crypto/hisilicon/zip/zip_crypto.c
+++ b/drivers/crypto/hisilicon/zip/zip_crypto.c
@@ -122,12 +122,12 @@ static int sgl_sge_nr_set(const char *val, const struct kernel_param *kp)
 	if (ret || n == 0 || n > HISI_ACC_SGL_SGE_NR_MAX)
 		return -EINVAL;
 
-	return param_set_int(val, kp);
+	return param_set_ushort(val, kp);
 }
 
 static const struct kernel_param_ops sgl_sge_nr_ops = {
 	.set = sgl_sge_nr_set,
-	.get = param_get_int,
+	.get = param_get_ushort,
 };
 
 static u16 sgl_sge_nr = HZIP_SGL_SGE_NR;
-- 
2.17.1

