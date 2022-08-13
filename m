Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9127E5919B5
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 12:00:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236207AbiHMJ7z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 05:59:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiHMJ7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 05:59:52 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6966F8B9BB;
        Sat, 13 Aug 2022 02:59:50 -0700 (PDT)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4M4bZC6TTXzmVLW;
        Sat, 13 Aug 2022 17:57:39 +0800 (CST)
Received: from dggpemm500005.china.huawei.com (7.185.36.74) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 13 Aug 2022 17:59:47 +0800
Received: from localhost.localdomain (10.67.164.66) by
 dggpemm500005.china.huawei.com (7.185.36.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 13 Aug 2022 17:59:47 +0800
From:   Yang Shen <shenyang39@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <wangzhou1@hisilicon.com>, <liulongfang@huawei.com>
Subject: [PATCH] crypto: hisilicon/zip - optimization for performance
Date:   Sat, 13 Aug 2022 17:57:52 +0800
Message-ID: <20220813095752.39941-1-shenyang39@huawei.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.164.66]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1.Remove some useless steps during doing requests.
2.Adjust the possibility of branch prediction.

Signed-off-by: Yang Shen <shenyang39@huawei.com>
---
 drivers/crypto/hisilicon/zip/zip_crypto.c | 27 +++++++++++------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/crypto/hisilicon/zip/zip_crypto.c b/drivers/crypto/hisilicon/zip/zip_crypto.c
index ad35434a3fdb..12b6d86c54d7 100644
--- a/drivers/crypto/hisilicon/zip/zip_crypto.c
+++ b/drivers/crypto/hisilicon/zip/zip_crypto.c
@@ -183,7 +183,7 @@ static int add_comp_head(struct scatterlist *dst, u8 req_type)
 	int ret;
 
 	ret = sg_copy_from_buffer(dst, sg_nents(dst), head, head_size);
-	if (ret != head_size) {
+	if (unlikely(ret != head_size)) {
 		pr_err("the head size of buffer is wrong (%d)!\n", ret);
 		return -ENOMEM;
 	}
@@ -193,11 +193,11 @@ static int add_comp_head(struct scatterlist *dst, u8 req_type)
 
 static int get_comp_head_size(struct acomp_req *acomp_req, u8 req_type)
 {
-	if (!acomp_req->src || !acomp_req->slen)
+	if (unlikely(!acomp_req->src || !acomp_req->slen))
 		return -EINVAL;
 
-	if (req_type == HZIP_ALG_TYPE_GZIP &&
-	    acomp_req->slen < GZIP_HEAD_FEXTRA_SHIFT)
+	if (unlikely(req_type == HZIP_ALG_TYPE_GZIP &&
+		     acomp_req->slen < GZIP_HEAD_FEXTRA_SHIFT))
 		return -EINVAL;
 
 	switch (req_type) {
@@ -230,6 +230,8 @@ static struct hisi_zip_req *hisi_zip_create_req(struct acomp_req *req,
 	}
 	set_bit(req_id, req_q->req_bitmap);
 
+	write_unlock(&req_q->req_lock);
+
 	req_cache = q + req_id;
 	req_cache->req_id = req_id;
 	req_cache->req = req;
@@ -242,8 +244,6 @@ static struct hisi_zip_req *hisi_zip_create_req(struct acomp_req *req,
 		req_cache->dskip = 0;
 	}
 
-	write_unlock(&req_q->req_lock);
-
 	return req_cache;
 }
 
@@ -254,7 +254,6 @@ static void hisi_zip_remove_req(struct hisi_zip_qp_ctx *qp_ctx,
 
 	write_lock(&req_q->req_lock);
 	clear_bit(req->req_id, req_q->req_bitmap);
-	memset(req, 0, sizeof(struct hisi_zip_req));
 	write_unlock(&req_q->req_lock);
 }
 
@@ -339,7 +338,7 @@ static int hisi_zip_do_work(struct hisi_zip_req *req,
 	struct hisi_zip_sqe zip_sqe;
 	int ret;
 
-	if (!a_req->src || !a_req->slen || !a_req->dst || !a_req->dlen)
+	if (unlikely(!a_req->src || !a_req->slen || !a_req->dst || !a_req->dlen))
 		return -EINVAL;
 
 	req->hw_src = hisi_acc_sg_buf_map_to_hw_sgl(dev, a_req->src, pool,
@@ -365,7 +364,7 @@ static int hisi_zip_do_work(struct hisi_zip_req *req,
 	/* send command to start a task */
 	atomic64_inc(&dfx->send_cnt);
 	ret = hisi_qp_send(qp, &zip_sqe);
-	if (ret < 0) {
+	if (unlikely(ret < 0)) {
 		atomic64_inc(&dfx->send_busy_cnt);
 		ret = -EAGAIN;
 		dev_dbg_ratelimited(dev, "failed to send request!\n");
@@ -417,7 +416,7 @@ static void hisi_zip_acomp_cb(struct hisi_qp *qp, void *data)
 
 	atomic64_inc(&dfx->recv_cnt);
 	status = ops->get_status(sqe);
-	if (status != 0 && status != HZIP_NC_ERR) {
+	if (unlikely(status != 0 && status != HZIP_NC_ERR)) {
 		dev_err(dev, "%scompress fail in qp%u: %u, output: %u\n",
 			(qp->alg_type == 0) ? "" : "de", qp->qp_id, status,
 			sqe->produced);
@@ -450,7 +449,7 @@ static int hisi_zip_acompress(struct acomp_req *acomp_req)
 
 	/* let's output compression head now */
 	head_size = add_comp_head(acomp_req->dst, qp_ctx->qp->req_type);
-	if (head_size < 0) {
+	if (unlikely(head_size < 0)) {
 		dev_err_ratelimited(dev, "failed to add comp head (%d)!\n",
 				    head_size);
 		return head_size;
@@ -461,7 +460,7 @@ static int hisi_zip_acompress(struct acomp_req *acomp_req)
 		return PTR_ERR(req);
 
 	ret = hisi_zip_do_work(req, qp_ctx);
-	if (ret != -EINPROGRESS) {
+	if (unlikely(ret != -EINPROGRESS)) {
 		dev_info_ratelimited(dev, "failed to do compress (%d)!\n", ret);
 		hisi_zip_remove_req(qp_ctx, req);
 	}
@@ -478,7 +477,7 @@ static int hisi_zip_adecompress(struct acomp_req *acomp_req)
 	int head_size, ret;
 
 	head_size = get_comp_head_size(acomp_req, qp_ctx->qp->req_type);
-	if (head_size < 0) {
+	if (unlikely(head_size < 0)) {
 		dev_err_ratelimited(dev, "failed to get comp head size (%d)!\n",
 				    head_size);
 		return head_size;
@@ -489,7 +488,7 @@ static int hisi_zip_adecompress(struct acomp_req *acomp_req)
 		return PTR_ERR(req);
 
 	ret = hisi_zip_do_work(req, qp_ctx);
-	if (ret != -EINPROGRESS) {
+	if (unlikely(ret != -EINPROGRESS)) {
 		dev_info_ratelimited(dev, "failed to do decompress (%d)!\n",
 				     ret);
 		hisi_zip_remove_req(qp_ctx, req);
-- 
2.24.0

