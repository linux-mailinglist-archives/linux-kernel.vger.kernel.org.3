Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E26F65025D7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 08:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350722AbiDOGsL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 02:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350656AbiDOGrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 02:47:51 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A4D7B0A4B
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 23:45:24 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id l127so4935398pfl.6
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 23:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HIfkyA0kHsUAS/WiTZijAfUV1CeLSCyZNaoBawxM4dQ=;
        b=bRNhcDrRB4NS8pkIyJ0hmHz8NeqERb22Ss/1ljlGJ1GB7zLBKH9J4g7Q6f6Fy9tDKB
         GVozb8zX2giAR9+DvLMs7bmzTzrFTUwNoNkT+uOLZaiDlcMYge25ogOzrdkN+K3EAmP8
         sQLk25OzbV4bjfS9mTvknf0xWdLd2xCTXnQqG455z+v66utPUCXAhgywZzMjKfUesuVG
         bLYhYFJaj7IePr9CME3+lYjMKRcCFrQQvOFPvE59Pg3wuFK37O3mJzuHslF95TJKtdEe
         pyrWeNT8Nd9b77qtm/fRf6WPvlz2uhClm8PB+XiPfov6ea0fM1jcfTdpfGHs210PA1lV
         V9Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HIfkyA0kHsUAS/WiTZijAfUV1CeLSCyZNaoBawxM4dQ=;
        b=tfpdsvsKXgkO/aB9wPm62TAkzfm4zgzAkL9RJTDMRFg51iz8zUXhH8U6tQYxeg6Feu
         BKyfatoCeJipF2+9wIAC+BqtKktZqkuhLurdAgUG1ZTgBLxpNcy6oV4MbvQ+ssaP6xxw
         RqmYq65YincvDRJZ7qD4lHwRfHlEvFtK9QB/Y47AAdN8GHEC/dRc2z54IBua2iongMap
         sm9zz7fYyumgBr0mJhMCT4tT2OKvxB6Jshm87pAgWL7ohW/KlE/A8kr+BiItnZ+BbSDt
         n06fxMmNypQ1r5+1nZZFs/znNrm/XRt0PwUNHpunAnQaiy8fvgud0o5qws8aizBepNKZ
         SKlQ==
X-Gm-Message-State: AOAM530aKzGT9h2RGYjkx17rHaMT5mJDFCxOxDaVP2PIaa5Z+/EJaUsN
        NRghx6H5wIjB7YtHyGA8R2eaiw==
X-Google-Smtp-Source: ABdhPJxL1fEBgglkis/EMPLSlJi9UALXaNzImIYVN25Au5p37RRe+JGZt7QPDDzenL0BV+xqlxWkGA==
X-Received: by 2002:a05:6a00:1788:b0:508:70fe:4e62 with SMTP id s8-20020a056a00178800b0050870fe4e62mr4175773pfg.70.1650005123188;
        Thu, 14 Apr 2022 23:45:23 -0700 (PDT)
Received: from always-x1.bytedance.net ([61.120.150.70])
        by smtp.gmail.com with ESMTPSA id d8-20020a056a00198800b004fab740dbe6sm1867385pfl.15.2022.04.14.23.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 23:45:22 -0700 (PDT)
From:   zhenwei pi <pizhenwei@bytedance.com>
To:     arei.gonglei@huawei.com, mst@redhat.com
Cc:     jasowang@redhat.com, herbert@gondor.apana.org.au,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-crypto@vger.kernel.org, helei.sig11@bytedance.com,
        davem@davemloft.net, zhenwei pi <pizhenwei@bytedance.com>
Subject: [PATCH 2/4] virtio-crypto: move helpers into virtio_crypto_common.c
Date:   Fri, 15 Apr 2022 14:41:34 +0800
Message-Id: <20220415064136.304661-3-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220415064136.304661-1-pizhenwei@bytedance.com>
References: <20220415064136.304661-1-pizhenwei@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move virtcrypto_clear_request and virtcrypto_dataq_callback into
virtio_crypto_common.c to make code clear. Then the xx_core.c
supports:
  - probe/remove/irq affinity seting for a virtio device
  - basic virtio related operations

xx_common.c supports:
  - common helpers/functions for algos

Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 drivers/crypto/virtio/virtio_crypto_common.c | 31 +++++++++++++++++++
 drivers/crypto/virtio/virtio_crypto_common.h |  2 ++
 drivers/crypto/virtio/virtio_crypto_core.c   | 32 --------------------
 3 files changed, 33 insertions(+), 32 deletions(-)

diff --git a/drivers/crypto/virtio/virtio_crypto_common.c b/drivers/crypto/virtio/virtio_crypto_common.c
index 93df73c40dd3..4a23524896fe 100644
--- a/drivers/crypto/virtio/virtio_crypto_common.c
+++ b/drivers/crypto/virtio/virtio_crypto_common.c
@@ -8,6 +8,14 @@
 
 #include "virtio_crypto_common.h"
 
+void virtcrypto_clear_request(struct virtio_crypto_request *vc_req)
+{
+	if (vc_req) {
+		kfree_sensitive(vc_req->req_data);
+		kfree(vc_req->sgs);
+	}
+}
+
 static void virtio_crypto_ctrlq_callback(struct virtio_crypto_ctrl_request *vc_ctrl_req)
 {
 	complete(&vc_ctrl_req->compl);
@@ -59,3 +67,26 @@ void virtcrypto_ctrlq_callback(struct virtqueue *vq)
 	} while (!virtqueue_enable_cb(vq));
 	spin_unlock_irqrestore(&vcrypto->ctrl_lock, flags);
 }
+
+void virtcrypto_dataq_callback(struct virtqueue *vq)
+{
+	struct virtio_crypto *vcrypto = vq->vdev->priv;
+	struct virtio_crypto_request *vc_req;
+	unsigned long flags;
+	unsigned int len;
+	unsigned int qid = vq->index;
+
+	spin_lock_irqsave(&vcrypto->data_vq[qid].lock, flags);
+	do {
+		virtqueue_disable_cb(vq);
+		while ((vc_req = virtqueue_get_buf(vq, &len)) != NULL) {
+			spin_unlock_irqrestore(
+				&vcrypto->data_vq[qid].lock, flags);
+			if (vc_req->alg_cb)
+				vc_req->alg_cb(vc_req, len);
+			spin_lock_irqsave(
+				&vcrypto->data_vq[qid].lock, flags);
+		}
+	} while (!virtqueue_enable_cb(vq));
+	spin_unlock_irqrestore(&vcrypto->data_vq[qid].lock, flags);
+}
diff --git a/drivers/crypto/virtio/virtio_crypto_common.h b/drivers/crypto/virtio/virtio_crypto_common.h
index 125ad2300b83..a003935f91a9 100644
--- a/drivers/crypto/virtio/virtio_crypto_common.h
+++ b/drivers/crypto/virtio/virtio_crypto_common.h
@@ -148,4 +148,6 @@ int virtio_crypto_ctrl_vq_request(struct virtio_crypto *vcrypto, struct scatterl
 				  unsigned int out_sgs, unsigned int in_sgs,
 				  struct virtio_crypto_ctrl_request *vc_ctrl_req);
 
+void virtcrypto_dataq_callback(struct virtqueue *vq);
+
 #endif /* _VIRTIO_CRYPTO_COMMON_H */
diff --git a/drivers/crypto/virtio/virtio_crypto_core.c b/drivers/crypto/virtio/virtio_crypto_core.c
index e668d4b1bc6a..d8edefcb966c 100644
--- a/drivers/crypto/virtio/virtio_crypto_core.c
+++ b/drivers/crypto/virtio/virtio_crypto_core.c
@@ -13,38 +13,6 @@
 #include "virtio_crypto_common.h"
 
 
-void
-virtcrypto_clear_request(struct virtio_crypto_request *vc_req)
-{
-	if (vc_req) {
-		kfree_sensitive(vc_req->req_data);
-		kfree(vc_req->sgs);
-	}
-}
-
-static void virtcrypto_dataq_callback(struct virtqueue *vq)
-{
-	struct virtio_crypto *vcrypto = vq->vdev->priv;
-	struct virtio_crypto_request *vc_req;
-	unsigned long flags;
-	unsigned int len;
-	unsigned int qid = vq->index;
-
-	spin_lock_irqsave(&vcrypto->data_vq[qid].lock, flags);
-	do {
-		virtqueue_disable_cb(vq);
-		while ((vc_req = virtqueue_get_buf(vq, &len)) != NULL) {
-			spin_unlock_irqrestore(
-				&vcrypto->data_vq[qid].lock, flags);
-			if (vc_req->alg_cb)
-				vc_req->alg_cb(vc_req, len);
-			spin_lock_irqsave(
-				&vcrypto->data_vq[qid].lock, flags);
-		}
-	} while (!virtqueue_enable_cb(vq));
-	spin_unlock_irqrestore(&vcrypto->data_vq[qid].lock, flags);
-}
-
 static int virtcrypto_find_vqs(struct virtio_crypto *vi)
 {
 	vq_callback_t **callbacks;
-- 
2.20.1

