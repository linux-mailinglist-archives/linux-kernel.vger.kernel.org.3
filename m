Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ADB550360F
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 12:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231573AbiDPKy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 06:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231537AbiDPKyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 06:54:20 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 784353AA72;
        Sat, 16 Apr 2022 03:51:49 -0700 (PDT)
Received: from kwepemi100007.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KgVLm33zFzFq0F;
        Sat, 16 Apr 2022 18:49:20 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi100007.china.huawei.com (7.221.188.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 16 Apr 2022 18:51:47 +0800
Received: from localhost.localdomain (10.67.165.24) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 16 Apr 2022 18:51:47 +0800
From:   Weili Qian <qianweili@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <wangzhou1@hisilicon.com>, <liulongfang@huawei.com>,
        Weili Qian <qianweili@huawei.com>
Subject: [PATCH 3/4] crypto: hisilicon/qm - replace hisi_qm_release_qp() with hisi_qm_free_qps()
Date:   Sat, 16 Apr 2022 18:45:58 +0800
Message-ID: <20220416104559.10826-4-qianweili@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220416104559.10826-1-qianweili@huawei.com>
References: <20220416104559.10826-1-qianweili@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.24]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hisi_qm_free_qps() can release multiple queues in one call, and it is
already exported. So, replace hisi_qm_release_qp() with hisi_qm_free_qps()
in zip_crypto.c, and do not export hisi_qm_release_qp() outside qm.c.

Signed-off-by: Weili Qian <qianweili@huawei.com>
---
 drivers/crypto/hisilicon/qm.c             | 3 +--
 drivers/crypto/hisilicon/zip/zip_crypto.c | 2 +-
 include/linux/hisi_acc_qm.h               | 1 -
 3 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/crypto/hisilicon/qm.c b/drivers/crypto/hisilicon/qm.c
index 582220178ec8..f708a632a2f5 100644
--- a/drivers/crypto/hisilicon/qm.c
+++ b/drivers/crypto/hisilicon/qm.c
@@ -2685,7 +2685,7 @@ static struct hisi_qp *hisi_qm_create_qp(struct hisi_qm *qm, u8 alg_type)
  *
  * This function releases the resource of a qp.
  */
-void hisi_qm_release_qp(struct hisi_qp *qp)
+static void hisi_qm_release_qp(struct hisi_qp *qp)
 {
 	struct hisi_qm *qm = qp->qm;
 
@@ -2703,7 +2703,6 @@ void hisi_qm_release_qp(struct hisi_qp *qp)
 
 	qm_pm_put_sync(qm);
 }
-EXPORT_SYMBOL_GPL(hisi_qm_release_qp);
 
 static int qm_sq_ctx_cfg(struct hisi_qp *qp, int qp_id, u32 pasid)
 {
diff --git a/drivers/crypto/hisilicon/zip/zip_crypto.c b/drivers/crypto/hisilicon/zip/zip_crypto.c
index 9520a4113c81..67869513e48c 100644
--- a/drivers/crypto/hisilicon/zip/zip_crypto.c
+++ b/drivers/crypto/hisilicon/zip/zip_crypto.c
@@ -521,7 +521,7 @@ static int hisi_zip_start_qp(struct hisi_qp *qp, struct hisi_zip_qp_ctx *ctx,
 static void hisi_zip_release_qp(struct hisi_zip_qp_ctx *ctx)
 {
 	hisi_qm_stop_qp(ctx->qp);
-	hisi_qm_release_qp(ctx->qp);
+	hisi_qm_free_qps(&ctx->qp, 1);
 }
 
 static const struct hisi_zip_sqe_ops hisi_zip_ops_v1 = {
diff --git a/include/linux/hisi_acc_qm.h b/include/linux/hisi_acc_qm.h
index 6fabfba014dd..46974d641af1 100644
--- a/include/linux/hisi_acc_qm.h
+++ b/include/linux/hisi_acc_qm.h
@@ -435,7 +435,6 @@ int hisi_qm_start(struct hisi_qm *qm);
 int hisi_qm_stop(struct hisi_qm *qm, enum qm_stop_reason r);
 int hisi_qm_start_qp(struct hisi_qp *qp, unsigned long arg);
 int hisi_qm_stop_qp(struct hisi_qp *qp);
-void hisi_qm_release_qp(struct hisi_qp *qp);
 int hisi_qp_send(struct hisi_qp *qp, const void *msg);
 int hisi_qm_get_free_qp_num(struct hisi_qm *qm);
 void hisi_qm_debug_init(struct hisi_qm *qm);
-- 
2.33.0

