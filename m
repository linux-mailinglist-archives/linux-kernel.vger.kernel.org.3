Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A86650D143
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 12:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239191AbiDXKtN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 06:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239046AbiDXKtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 06:49:02 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17B8B22B04
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 03:45:50 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id u7so5429900plg.13
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 03:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=apUEf+EzBMbf1428+G4F3xeQ1aPIlddSTbIvkpGqC5w=;
        b=FngY3yqrzabvD/vuacUhlAn1J8NpUUinNeZzIt2T5wCHW3Sy0Kl/Y409vF0FIFNTpi
         +0YfeS3OYwpHT45QBeS1QieVSkwbA5ObJAhlJEDaOrPDz0J4Kb9oC+aipahZLqKivlPv
         gmC+Kh0UN8n64HPsLZSJ1b4KJConLmGm/ZveTvYn91MiubkNeua8hmNjC5AFsugCbMqU
         NdxPNI4HAABL7KoLWYoWp9oPkmKZ3OE9KOC1IYhHUY3JC3ikEq94R3B//HhoVzD7JK7U
         SkQPoD6yfGJDszULVthoNJgtuvvs1nIjRu7PnCvXl/AxrBCMY4fAUSP1PLkqv8+vDrEF
         1OTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=apUEf+EzBMbf1428+G4F3xeQ1aPIlddSTbIvkpGqC5w=;
        b=bdThP+A5mZi+ahFpEIPTUtHEV0V3qIBnqPuEVRDCUq5gJymk7X2e+9OLhKQn/bdqrc
         TzJuggnQP5971NVONM5xWJhDnCcA0PM3R33GZ88VhXoSu8X3bsRSmKRsvuAH0WPoHS9Y
         ouon0PCWG4oR+JKtoFuxNr4ntUvIoGQCe0goGFNm0Ihdtj5rCyLGDCBqFNwkyWOP4NKg
         8o52QX0bXwARDkAkPRxQwqk4kiELhwO0S4Q0TvwUEhLeIsfqrRxQdafik8IYOQ8b+gd0
         MRvoG5At2rHawH/tOsxWbIZDpjoLRFqhixPfhBi/wunuvIuargWdYq8FQjF63cEOQdkb
         N79Q==
X-Gm-Message-State: AOAM531XrNQQQ81Kwz2vL/d6vkHE0ig3+Oc6SrzvYp6+t8PfyQ9q76wK
        PDvH6avdZd3e97zyi1GEc7ox0w==
X-Google-Smtp-Source: ABdhPJw5tSMenUvXwvNJ2sg0MUqVtoTzn/dzDU3c5kJs4cn50ytjtpzIU9gIGra6dulic/qFQbW2RQ==
X-Received: by 2002:a17:902:f787:b0:152:157:eb7 with SMTP id q7-20020a170902f78700b0015201570eb7mr12677644pln.109.1650797149603;
        Sun, 24 Apr 2022 03:45:49 -0700 (PDT)
Received: from always-x1.bytedance.net ([61.120.150.70])
        by smtp.gmail.com with ESMTPSA id y2-20020a056a00190200b004fa865d1fd3sm8287295pfi.86.2022.04.24.03.45.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Apr 2022 03:45:49 -0700 (PDT)
From:   zhenwei pi <pizhenwei@bytedance.com>
To:     arei.gonglei@huawei.com, mst@redhat.com, jasowang@redhat.com
Cc:     herbert@gondor.apana.org.au, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-crypto@vger.kernel.org, helei.sig11@bytedance.com,
        davem@davemloft.net, zhenwei pi <pizhenwei@bytedance.com>
Subject: [PATCH v4 3/5] virtio-crypto: wait ctrl queue instead of busy polling
Date:   Sun, 24 Apr 2022 18:41:38 +0800
Message-Id: <20220424104140.44841-4-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220424104140.44841-1-pizhenwei@bytedance.com>
References: <20220424104140.44841-1-pizhenwei@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Originally, after submitting request into virtio crypto control
queue, the guest side polls the result from the virt queue. This
works like following:
    CPU0   CPU1               ...             CPUx  CPUy
     |      |                                  |     |
     \      \                                  /     /
      \--------spin_lock(&vcrypto->ctrl_lock)-------/
                           |
                 virtqueue add & kick
                           |
                  busy poll virtqueue
                           |
              spin_unlock(&vcrypto->ctrl_lock)
                          ...

There are two problems:
1, The queue depth is always 1, the performance of a virtio crypto
   device gets limited. Multi user processes share a single control
   queue, and hit spin lock race from control queue. Test on Intel
   Platinum 8260, a single worker gets ~35K/s create/close session
   operations, and 8 workers get ~40K/s operations with 800% CPU
   utilization.
2, The control request is supposed to get handled immediately, but
   in the current implementation of QEMU(v6.2), the vCPU thread kicks
   another thread to do this work, the latency also gets unstable.
   Tracking latency of virtio_crypto_alg_akcipher_close_session in 5s:
        usecs               : count     distribution
         0 -> 1          : 0        |                        |
         2 -> 3          : 7        |                        |
         4 -> 7          : 72       |                        |
         8 -> 15         : 186485   |************************|
        16 -> 31         : 687      |                        |
        32 -> 63         : 5        |                        |
        64 -> 127        : 3        |                        |
       128 -> 255        : 1        |                        |
       256 -> 511        : 0        |                        |
       512 -> 1023       : 0        |                        |
      1024 -> 2047       : 0        |                        |
      2048 -> 4095       : 0        |                        |
      4096 -> 8191       : 0        |                        |
      8192 -> 16383      : 2        |                        |
This means that a CPU may hold vcrypto->ctrl_lock as long as 8192~16383us.

To improve the performance of control queue, a request on control queue
waits completion instead of busy polling to reduce lock racing, and gets
completed by control queue callback.
    CPU0   CPU1               ...             CPUx  CPUy
     |      |                                  |     |
     \      \                                  /     /
      \--------spin_lock(&vcrypto->ctrl_lock)-------/
                           |
                 virtqueue add & kick
                           |
      ---------spin_unlock(&vcrypto->ctrl_lock)------
     /      /                                  \     \
     |      |                                  |     |
    wait   wait                               wait  wait

Test this patch, the guest side get ~200K/s operations with 300% CPU
utilization.

Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Gonglei <arei.gonglei@huawei.com>
Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 .../virtio/virtio_crypto_akcipher_algs.c      | 29 ++---------
 drivers/crypto/virtio/virtio_crypto_common.h  |  4 ++
 drivers/crypto/virtio/virtio_crypto_core.c    | 52 ++++++++++++++++++-
 .../virtio/virtio_crypto_skcipher_algs.c      | 34 ++----------
 4 files changed, 64 insertions(+), 55 deletions(-)

diff --git a/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c b/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
index 509884e8b201..1e98502830cf 100644
--- a/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
+++ b/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
@@ -103,7 +103,6 @@ static int virtio_crypto_alg_akcipher_init_session(struct virtio_crypto_akcipher
 	struct scatterlist outhdr_sg, key_sg, inhdr_sg, *sgs[3];
 	struct virtio_crypto *vcrypto = ctx->vcrypto;
 	uint8_t *pkey;
-	unsigned int inlen;
 	int err;
 	unsigned int num_out = 0, num_in = 0;
 	struct virtio_crypto_op_ctrl_req *ctrl;
@@ -135,18 +134,9 @@ static int virtio_crypto_alg_akcipher_init_session(struct virtio_crypto_akcipher
 	sg_init_one(&inhdr_sg, input, sizeof(*input));
 	sgs[num_out + num_in++] = &inhdr_sg;
 
-	spin_lock(&vcrypto->ctrl_lock);
-	err = virtqueue_add_sgs(vcrypto->ctrl_vq, sgs, num_out, num_in, vcrypto, GFP_ATOMIC);
-	if (err < 0) {
-		spin_unlock(&vcrypto->ctrl_lock);
+	err = virtio_crypto_ctrl_vq_request(vcrypto, sgs, num_out, num_in, vc_ctrl_req);
+	if (err < 0)
 		goto out;
-	}
-
-	virtqueue_kick(vcrypto->ctrl_vq);
-	while (!virtqueue_get_buf(vcrypto->ctrl_vq, &inlen) &&
-	       !virtqueue_is_broken(vcrypto->ctrl_vq))
-		cpu_relax();
-	spin_unlock(&vcrypto->ctrl_lock);
 
 	if (le32_to_cpu(input->status) != VIRTIO_CRYPTO_OK) {
 		err = -EINVAL;
@@ -173,7 +163,7 @@ static int virtio_crypto_alg_akcipher_close_session(struct virtio_crypto_akciphe
 	struct scatterlist outhdr_sg, inhdr_sg, *sgs[2];
 	struct virtio_crypto_destroy_session_req *destroy_session;
 	struct virtio_crypto *vcrypto = ctx->vcrypto;
-	unsigned int num_out = 0, num_in = 0, inlen;
+	unsigned int num_out = 0, num_in = 0;
 	int err;
 	struct virtio_crypto_op_ctrl_req *ctrl;
 	struct virtio_crypto_inhdr *ctrl_status;
@@ -205,18 +195,9 @@ static int virtio_crypto_alg_akcipher_close_session(struct virtio_crypto_akciphe
 	sg_init_one(&inhdr_sg, &ctrl_status->status, sizeof(ctrl_status->status));
 	sgs[num_out + num_in++] = &inhdr_sg;
 
-	spin_lock(&vcrypto->ctrl_lock);
-	err = virtqueue_add_sgs(vcrypto->ctrl_vq, sgs, num_out, num_in, vcrypto, GFP_ATOMIC);
-	if (err < 0) {
-		spin_unlock(&vcrypto->ctrl_lock);
+	err = virtio_crypto_ctrl_vq_request(vcrypto, sgs, num_out, num_in, vc_ctrl_req);
+	if (err < 0)
 		goto out;
-	}
-
-	virtqueue_kick(vcrypto->ctrl_vq);
-	while (!virtqueue_get_buf(vcrypto->ctrl_vq, &inlen) &&
-	       !virtqueue_is_broken(vcrypto->ctrl_vq))
-		cpu_relax();
-	spin_unlock(&vcrypto->ctrl_lock);
 
 	if (ctrl_status->status != VIRTIO_CRYPTO_OK) {
 		err = -EINVAL;
diff --git a/drivers/crypto/virtio/virtio_crypto_common.h b/drivers/crypto/virtio/virtio_crypto_common.h
index 2422237ec4e6..59a4c0259456 100644
--- a/drivers/crypto/virtio/virtio_crypto_common.h
+++ b/drivers/crypto/virtio/virtio_crypto_common.h
@@ -90,6 +90,7 @@ struct virtio_crypto_ctrl_request {
 	struct virtio_crypto_op_ctrl_req ctrl;
 	struct virtio_crypto_session_input input;
 	struct virtio_crypto_inhdr ctrl_status;
+	struct completion compl;
 };
 
 struct virtio_crypto_request;
@@ -141,5 +142,8 @@ int virtio_crypto_skcipher_algs_register(struct virtio_crypto *vcrypto);
 void virtio_crypto_skcipher_algs_unregister(struct virtio_crypto *vcrypto);
 int virtio_crypto_akcipher_algs_register(struct virtio_crypto *vcrypto);
 void virtio_crypto_akcipher_algs_unregister(struct virtio_crypto *vcrypto);
+int virtio_crypto_ctrl_vq_request(struct virtio_crypto *vcrypto, struct scatterlist *sgs[],
+				  unsigned int out_sgs, unsigned int in_sgs,
+				  struct virtio_crypto_ctrl_request *vc_ctrl_req);
 
 #endif /* _VIRTIO_CRYPTO_COMMON_H */
diff --git a/drivers/crypto/virtio/virtio_crypto_core.c b/drivers/crypto/virtio/virtio_crypto_core.c
index c6f482db0bc0..60490ffa3df1 100644
--- a/drivers/crypto/virtio/virtio_crypto_core.c
+++ b/drivers/crypto/virtio/virtio_crypto_core.c
@@ -22,6 +22,56 @@ virtcrypto_clear_request(struct virtio_crypto_request *vc_req)
 	}
 }
 
+static void virtio_crypto_ctrlq_callback(struct virtio_crypto_ctrl_request *vc_ctrl_req)
+{
+	complete(&vc_ctrl_req->compl);
+}
+
+static void virtcrypto_ctrlq_callback(struct virtqueue *vq)
+{
+	struct virtio_crypto *vcrypto = vq->vdev->priv;
+	struct virtio_crypto_ctrl_request *vc_ctrl_req;
+	unsigned long flags;
+	unsigned int len;
+
+	spin_lock_irqsave(&vcrypto->ctrl_lock, flags);
+	do {
+		virtqueue_disable_cb(vq);
+		while ((vc_ctrl_req = virtqueue_get_buf(vq, &len)) != NULL) {
+			spin_unlock_irqrestore(&vcrypto->ctrl_lock, flags);
+			virtio_crypto_ctrlq_callback(vc_ctrl_req);
+			spin_lock_irqsave(&vcrypto->ctrl_lock, flags);
+		}
+		if (unlikely(virtqueue_is_broken(vq)))
+			break;
+	} while (!virtqueue_enable_cb(vq));
+	spin_unlock_irqrestore(&vcrypto->ctrl_lock, flags);
+}
+
+int virtio_crypto_ctrl_vq_request(struct virtio_crypto *vcrypto, struct scatterlist *sgs[],
+		unsigned int out_sgs, unsigned int in_sgs,
+		struct virtio_crypto_ctrl_request *vc_ctrl_req)
+{
+	int err;
+	unsigned long flags;
+
+	init_completion(&vc_ctrl_req->compl);
+
+	spin_lock_irqsave(&vcrypto->ctrl_lock, flags);
+	err = virtqueue_add_sgs(vcrypto->ctrl_vq, sgs, out_sgs, in_sgs, vc_ctrl_req, GFP_ATOMIC);
+	if (err < 0) {
+		spin_unlock_irqrestore(&vcrypto->ctrl_lock, flags);
+		return err;
+	}
+
+	virtqueue_kick(vcrypto->ctrl_vq);
+	spin_unlock_irqrestore(&vcrypto->ctrl_lock, flags);
+
+	wait_for_completion(&vc_ctrl_req->compl);
+
+	return 0;
+}
+
 static void virtcrypto_dataq_callback(struct virtqueue *vq)
 {
 	struct virtio_crypto *vcrypto = vq->vdev->priv;
@@ -73,7 +123,7 @@ static int virtcrypto_find_vqs(struct virtio_crypto *vi)
 		goto err_names;
 
 	/* Parameters for control virtqueue */
-	callbacks[total_vqs - 1] = NULL;
+	callbacks[total_vqs - 1] = virtcrypto_ctrlq_callback;
 	names[total_vqs - 1] = "controlq";
 
 	/* Allocate/initialize parameters for data virtqueues */
diff --git a/drivers/crypto/virtio/virtio_crypto_skcipher_algs.c b/drivers/crypto/virtio/virtio_crypto_skcipher_algs.c
index 6aaf0869b211..e553ccadbcbc 100644
--- a/drivers/crypto/virtio/virtio_crypto_skcipher_algs.c
+++ b/drivers/crypto/virtio/virtio_crypto_skcipher_algs.c
@@ -118,7 +118,6 @@ static int virtio_crypto_alg_skcipher_init_session(
 		int encrypt)
 {
 	struct scatterlist outhdr, key_sg, inhdr, *sgs[3];
-	unsigned int tmp;
 	struct virtio_crypto *vcrypto = ctx->vcrypto;
 	int op = encrypt ? VIRTIO_CRYPTO_OP_ENCRYPT : VIRTIO_CRYPTO_OP_DECRYPT;
 	int err;
@@ -170,23 +169,9 @@ static int virtio_crypto_alg_skcipher_init_session(
 	sg_init_one(&inhdr, input, sizeof(*input));
 	sgs[num_out + num_in++] = &inhdr;
 
-	spin_lock(&vcrypto->ctrl_lock);
-	err = virtqueue_add_sgs(vcrypto->ctrl_vq, sgs, num_out,
-				num_in, vcrypto, GFP_ATOMIC);
-	if (err < 0) {
-		spin_unlock(&vcrypto->ctrl_lock);
+	err = virtio_crypto_ctrl_vq_request(vcrypto, sgs, num_out, num_in, vc_ctrl_req);
+	if (err < 0)
 		goto out;
-	}
-	virtqueue_kick(vcrypto->ctrl_vq);
-
-	/*
-	 * Trapping into the hypervisor, so the request should be
-	 * handled immediately.
-	 */
-	while (!virtqueue_get_buf(vcrypto->ctrl_vq, &tmp) &&
-	       !virtqueue_is_broken(vcrypto->ctrl_vq))
-		cpu_relax();
-	spin_unlock(&vcrypto->ctrl_lock);
 
 	if (le32_to_cpu(input->status) != VIRTIO_CRYPTO_OK) {
 		pr_err("virtio_crypto: Create session failed status: %u\n",
@@ -212,7 +197,6 @@ static int virtio_crypto_alg_skcipher_close_session(
 		int encrypt)
 {
 	struct scatterlist outhdr, status_sg, *sgs[2];
-	unsigned int tmp;
 	struct virtio_crypto_destroy_session_req *destroy_session;
 	struct virtio_crypto *vcrypto = ctx->vcrypto;
 	int err;
@@ -247,19 +231,9 @@ static int virtio_crypto_alg_skcipher_close_session(
 	sg_init_one(&status_sg, &ctrl_status->status, sizeof(ctrl_status->status));
 	sgs[num_out + num_in++] = &status_sg;
 
-	spin_lock(&vcrypto->ctrl_lock);
-	err = virtqueue_add_sgs(vcrypto->ctrl_vq, sgs, num_out,
-			num_in, vcrypto, GFP_ATOMIC);
-	if (err < 0) {
-		spin_unlock(&vcrypto->ctrl_lock);
+	err = virtio_crypto_ctrl_vq_request(vcrypto, sgs, num_out, num_in, vc_ctrl_req);
+	if (err < 0)
 		goto out;
-	}
-	virtqueue_kick(vcrypto->ctrl_vq);
-
-	while (!virtqueue_get_buf(vcrypto->ctrl_vq, &tmp) &&
-	       !virtqueue_is_broken(vcrypto->ctrl_vq))
-		cpu_relax();
-	spin_unlock(&vcrypto->ctrl_lock);
 
 	if (ctrl_status->status != VIRTIO_CRYPTO_OK) {
 		pr_err("virtio_crypto: Close session failed status: %u, session_id: 0x%llx\n",
-- 
2.20.1

