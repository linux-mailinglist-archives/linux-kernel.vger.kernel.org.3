Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC27F4C9C46
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 04:42:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239405AbiCBDn1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 22:43:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239404AbiCBDnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 22:43:23 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67FCD2F034
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 19:42:34 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id c9so500995pll.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 19:42:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nCa39vbSo+Q0Jw8Hg2S+6dQC35GshG3osfsPxAWyjrE=;
        b=cyTbCBUHJ1cJ+dRbzSSqfBHVI4U9q/CESCnvubYqF87aNh432De1bYCKwgSK6IdxF9
         XUlBuR0pa3mkEiODMRrKuBw3Th3mELh8v4MBvNyOPvO7M7OJGprmsoN0EWpFEvq4Qdvi
         qBsEIiJD9z+J0bqbgJqa7NmMMFandsoZgTsyqQdY4RVYngkAvOl7jPnmXkk1XS/Hr/ly
         ListSaBgwyexK4K8Tat1HoFe591vEq/d7c2inWmCo7nLANZmbwVbjqRa0jeCzzHN1Rse
         nu7oCybtK+UoId72dejMSLlav3ylhI8gEfr2A3l7vRPeAMMzKdRlM14Q/a3r1HoNWAwI
         pPhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nCa39vbSo+Q0Jw8Hg2S+6dQC35GshG3osfsPxAWyjrE=;
        b=aNSqbILHXqVwHHnoRo33c43Dijbz9N7Yxv8+JBKhLWQYKQIjg/Wl7fnbd3v/OrEBoJ
         RdYBY8mBh2ZtBbGxRX33cbdCOAEuCmioCtN4KPaaF6YNdcClHy7dVRHlIOXFIYkF2HlD
         6Rtwg7XOHaQ24/9BA0tS8o7wrPqwCtsWmNdIloxNWNzC/Rtod9u1qiDcbRyFAfnplH3z
         v901AkAYMCYRTX+2SLlIpnoVIIxO/AUO+UUoQhujUaj4XBdkmAl2yaMaG0mYix++4m1s
         zewHPvVVIpGvgfwbOPbM9Q5BDHUk7XbW6wp4+VfjBfoAZGW7g3z33Ecjg28yTofRlhnh
         GkNg==
X-Gm-Message-State: AOAM531aE+RAKzWR4KsqxIiqpW/H/VEQaySHVbz3gAiRpg78vAWlvt6Q
        n4JZgL6huYyBsH55dG5qiY81RA==
X-Google-Smtp-Source: ABdhPJzjomWX55CzjSNAm7mW98lcSABv9KSsWJpy1jtDQOwEGZj4I4eI8BsIbnkOqbjYcCH5+L/Uww==
X-Received: by 2002:a17:902:cf12:b0:14f:e0c2:1515 with SMTP id i18-20020a170902cf1200b0014fe0c21515mr29215448plg.4.1646192553760;
        Tue, 01 Mar 2022 19:42:33 -0800 (PST)
Received: from always-x1.bytedance.net ([61.120.150.76])
        by smtp.gmail.com with ESMTPSA id gz13-20020a17090b0ecd00b001bc5defa657sm3358585pjb.11.2022.03.01.19.42.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 19:42:33 -0800 (PST)
From:   zhenwei pi <pizhenwei@bytedance.com>
To:     arei.gonglei@huawei.com, mst@redhat.com
Cc:     jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        herbert@gondor.apana.org.au, helei.sig11@bytedance.com,
        zhenwei pi <pizhenwei@bytedance.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v3 3/4] virtio-crypto: implement RSA algorithm
Date:   Wed,  2 Mar 2022 11:39:16 +0800
Message-Id: <20220302033917.1295334-4-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220302033917.1295334-1-pizhenwei@bytedance.com>
References: <20220302033917.1295334-1-pizhenwei@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support rsa & pkcs1pad(rsa,sha1) with priority 150.

Test with QEMU built-in backend, it works fine.
1, The self-test framework of crypto layer works fine in guest kernel
2, Test with Linux guest(with asym support), the following script
test(note that pkey_XXX is supported only in a newer version of keyutils):
  - both public key & private key
  - create/close session
  - encrypt/decrypt/sign/verify basic driver operation
  - also test with kernel crypto layer(pkey add/query)

All the cases work fine.

rm -rf *.der *.pem *.pfx
modprobe pkcs8_key_parser # if CONFIG_PKCS8_PRIVATE_KEY_PARSER=m
rm -rf /tmp/data
dd if=/dev/random of=/tmp/data count=1 bs=226

openssl req -nodes -x509 -newkey rsa:2048 -keyout key.pem -out cert.pem -subj "/C=CN/ST=BJ/L=HD/O=qemu/OU=dev/CN=qemu/emailAddress=qemu@qemu.org"
openssl pkcs8 -in key.pem -topk8 -nocrypt -outform DER -out key.der
openssl x509 -in cert.pem -inform PEM -outform DER -out cert.der

PRIV_KEY_ID=`cat key.der | keyctl padd asymmetric test_priv_key @s`
echo "priv key id = "$PRIV_KEY_ID
PUB_KEY_ID=`cat cert.der | keyctl padd asymmetric test_pub_key @s`
echo "pub key id = "$PUB_KEY_ID

keyctl pkey_query $PRIV_KEY_ID 0
keyctl pkey_query $PUB_KEY_ID 0

echo "Enc with priv key..."
keyctl pkey_encrypt $PRIV_KEY_ID 0 /tmp/data enc=pkcs1 >/tmp/enc.priv
echo "Dec with pub key..."
keyctl pkey_decrypt $PRIV_KEY_ID 0 /tmp/enc.priv enc=pkcs1 >/tmp/dec
cmp /tmp/data /tmp/dec

echo "Sign with priv key..."
keyctl pkey_sign $PRIV_KEY_ID 0 /tmp/data enc=pkcs1 hash=sha1 > /tmp/sig
echo "Verify with pub key..."
keyctl pkey_verify $PRIV_KEY_ID 0 /tmp/data /tmp/sig enc=pkcs1 hash=sha1

echo "Enc with pub key..."
keyctl pkey_encrypt $PUB_KEY_ID 0 /tmp/data enc=pkcs1 >/tmp/enc.pub
echo "Dec with priv key..."
keyctl pkey_decrypt $PRIV_KEY_ID 0 /tmp/enc.pub enc=pkcs1 >/tmp/dec
cmp /tmp/data /tmp/dec

echo "Verify with pub key..."
keyctl pkey_verify $PUB_KEY_ID 0 /tmp/data /tmp/sig enc=pkcs1 hash=sha1

[1 compiling warning during development]
Reported-by: kernel test robot <lkp@intel.com>

Co-developed-by: lei he <helei.sig11@bytedance.com>
Signed-off-by: lei he <helei.sig11@bytedance.com>
Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 drivers/crypto/virtio/Makefile                |   1 +
 .../virtio/virtio_crypto_akcipher_algs.c      | 585 ++++++++++++++++++
 drivers/crypto/virtio/virtio_crypto_common.h  |   3 +
 drivers/crypto/virtio/virtio_crypto_core.c    |   6 +-
 drivers/crypto/virtio/virtio_crypto_mgr.c     |  11 +
 5 files changed, 605 insertions(+), 1 deletion(-)
 create mode 100644 drivers/crypto/virtio/virtio_crypto_akcipher_algs.c

diff --git a/drivers/crypto/virtio/Makefile b/drivers/crypto/virtio/Makefile
index cbfccccfa135..f2b839473d61 100644
--- a/drivers/crypto/virtio/Makefile
+++ b/drivers/crypto/virtio/Makefile
@@ -2,5 +2,6 @@
 obj-$(CONFIG_CRYPTO_DEV_VIRTIO) += virtio_crypto.o
 virtio_crypto-objs := \
 	virtio_crypto_algs.o \
+	virtio_crypto_akcipher_algs.o \
 	virtio_crypto_mgr.o \
 	virtio_crypto_core.o
diff --git a/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c b/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
new file mode 100644
index 000000000000..f3ec9420215e
--- /dev/null
+++ b/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
@@ -0,0 +1,585 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+ /* Asymmetric algorithms supported by virtio crypto device
+  *
+  * Authors: zhenwei pi <pizhenwei@bytedance.com>
+  *          lei he <helei.sig11@bytedance.com>
+  *
+  * Copyright 2022 Bytedance CO., LTD.
+  */
+
+#include <linux/mpi.h>
+#include <linux/scatterlist.h>
+#include <crypto/algapi.h>
+#include <crypto/internal/akcipher.h>
+#include <crypto/internal/rsa.h>
+#include <linux/err.h>
+#include <crypto/scatterwalk.h>
+#include <linux/atomic.h>
+
+#include <uapi/linux/virtio_crypto.h>
+#include "virtio_crypto_common.h"
+
+struct virtio_crypto_rsa_ctx {
+	MPI n;
+};
+
+struct virtio_crypto_akcipher_ctx {
+	struct crypto_engine_ctx enginectx;
+	struct virtio_crypto *vcrypto;
+	struct crypto_akcipher *tfm;
+	bool session_valid;
+	__u64 session_id;
+	union {
+		struct virtio_crypto_rsa_ctx rsa_ctx;
+	};
+};
+
+struct virtio_crypto_akcipher_request {
+	struct virtio_crypto_request base;
+	struct virtio_crypto_akcipher_ctx *akcipher_ctx;
+	struct akcipher_request *akcipher_req;
+	void *src_buf;
+	void *dst_buf;
+	uint32_t opcode;
+};
+
+struct virtio_crypto_akcipher_algo {
+	uint32_t algonum;
+	uint32_t service;
+	unsigned int active_devs;
+	struct akcipher_alg algo;
+};
+
+static DEFINE_MUTEX(algs_lock);
+
+static void virtio_crypto_akcipher_finalize_req(
+	struct virtio_crypto_akcipher_request *vc_akcipher_req,
+	struct akcipher_request *req, int err)
+{
+	virtcrypto_clear_request(&vc_akcipher_req->base);
+
+	crypto_finalize_akcipher_request(vc_akcipher_req->base.dataq->engine, req, err);
+}
+
+static void virtio_crypto_dataq_akcipher_callback(struct virtio_crypto_request *vc_req, int len)
+{
+	struct virtio_crypto_akcipher_request *vc_akcipher_req =
+		container_of(vc_req, struct virtio_crypto_akcipher_request, base);
+	struct akcipher_request *akcipher_req;
+	int error;
+
+	switch (vc_req->status) {
+	case VIRTIO_CRYPTO_OK:
+		error = 0;
+		break;
+	case VIRTIO_CRYPTO_INVSESS:
+	case VIRTIO_CRYPTO_ERR:
+		error = -EINVAL;
+		break;
+	case VIRTIO_CRYPTO_BADMSG:
+		error = -EBADMSG;
+		break;
+
+	case VIRTIO_CRYPTO_KEY_REJECTED:
+		error = -EKEYREJECTED;
+		break;
+
+	default:
+		error = -EIO;
+		break;
+	}
+
+	akcipher_req = vc_akcipher_req->akcipher_req;
+	if (vc_akcipher_req->opcode != VIRTIO_CRYPTO_AKCIPHER_VERIFY)
+		sg_copy_from_buffer(akcipher_req->dst, sg_nents(akcipher_req->dst),
+				    vc_akcipher_req->dst_buf, akcipher_req->dst_len);
+	virtio_crypto_akcipher_finalize_req(vc_akcipher_req, akcipher_req, error);
+}
+
+static int virtio_crypto_alg_akcipher_init_session(struct virtio_crypto_akcipher_ctx *ctx,
+		struct virtio_crypto_ctrl_header *header, void *para,
+		const uint8_t *key, unsigned int keylen)
+{
+	struct scatterlist outhdr_sg, key_sg, inhdr_sg, *sgs[3];
+	struct virtio_crypto *vcrypto = ctx->vcrypto;
+	uint8_t *pkey;
+	unsigned int inlen;
+	int err;
+	unsigned int num_out = 0, num_in = 0;
+
+	pkey = kmemdup(key, keylen, GFP_ATOMIC);
+	if (!pkey)
+		return -ENOMEM;
+
+	spin_lock(&vcrypto->ctrl_lock);
+	memcpy(&vcrypto->ctrl.header, header, sizeof(vcrypto->ctrl.header));
+	memcpy(&vcrypto->ctrl.u, para, sizeof(vcrypto->ctrl.u));
+	vcrypto->input.status = cpu_to_le32(VIRTIO_CRYPTO_ERR);
+
+	sg_init_one(&outhdr_sg, &vcrypto->ctrl, sizeof(vcrypto->ctrl));
+	sgs[num_out++] = &outhdr_sg;
+
+	sg_init_one(&key_sg, pkey, keylen);
+	sgs[num_out++] = &key_sg;
+
+	sg_init_one(&inhdr_sg, &vcrypto->input, sizeof(vcrypto->input));
+	sgs[num_out + num_in++] = &inhdr_sg;
+
+	err = virtqueue_add_sgs(vcrypto->ctrl_vq, sgs, num_out, num_in, vcrypto, GFP_ATOMIC);
+	if (err < 0)
+		goto out;
+
+	virtqueue_kick(vcrypto->ctrl_vq);
+	while (!virtqueue_get_buf(vcrypto->ctrl_vq, &inlen) &&
+	       !virtqueue_is_broken(vcrypto->ctrl_vq))
+		cpu_relax();
+
+	if (le32_to_cpu(vcrypto->input.status) != VIRTIO_CRYPTO_OK) {
+		err = -EINVAL;
+		goto out;
+	}
+
+	ctx->session_id = le64_to_cpu(vcrypto->input.session_id);
+	ctx->session_valid = true;
+	err = 0;
+
+out:
+	spin_unlock(&vcrypto->ctrl_lock);
+	kfree_sensitive(pkey);
+
+	if (err < 0)
+		pr_err("virtio_crypto: Create session failed status: %u\n",
+			le32_to_cpu(vcrypto->input.status));
+
+	return err;
+}
+
+static int virtio_crypto_alg_akcipher_close_session(struct virtio_crypto_akcipher_ctx *ctx)
+{
+	struct scatterlist outhdr_sg, inhdr_sg, *sgs[2];
+	struct virtio_crypto_destroy_session_req *destroy_session;
+	struct virtio_crypto *vcrypto = ctx->vcrypto;
+	unsigned int num_out = 0, num_in = 0, inlen;
+	int err;
+
+	spin_lock(&vcrypto->ctrl_lock);
+	if (!ctx->session_valid) {
+		err = 0;
+		goto out;
+	}
+	vcrypto->ctrl_status.status = VIRTIO_CRYPTO_ERR;
+	vcrypto->ctrl.header.opcode = cpu_to_le32(VIRTIO_CRYPTO_AKCIPHER_DESTROY_SESSION);
+	vcrypto->ctrl.header.queue_id = 0;
+
+	destroy_session = &vcrypto->ctrl.u.destroy_session;
+	destroy_session->session_id = cpu_to_le64(ctx->session_id);
+
+	sg_init_one(&outhdr_sg, &vcrypto->ctrl, sizeof(vcrypto->ctrl));
+	sgs[num_out++] = &outhdr_sg;
+
+	sg_init_one(&inhdr_sg, &vcrypto->ctrl_status.status, sizeof(vcrypto->ctrl_status.status));
+	sgs[num_out + num_in++] = &inhdr_sg;
+
+	err = virtqueue_add_sgs(vcrypto->ctrl_vq, sgs, num_out, num_in, vcrypto, GFP_ATOMIC);
+	if (err < 0)
+		goto out;
+
+	virtqueue_kick(vcrypto->ctrl_vq);
+	while (!virtqueue_get_buf(vcrypto->ctrl_vq, &inlen) &&
+	       !virtqueue_is_broken(vcrypto->ctrl_vq))
+		cpu_relax();
+
+	if (vcrypto->ctrl_status.status != VIRTIO_CRYPTO_OK) {
+		err = -EINVAL;
+		goto out;
+	}
+
+	err = 0;
+	ctx->session_valid = false;
+
+out:
+	spin_unlock(&vcrypto->ctrl_lock);
+	if (err < 0) {
+		pr_err("virtio_crypto: Close session failed status: %u, session_id: 0x%llx\n",
+			vcrypto->ctrl_status.status, destroy_session->session_id);
+	}
+
+	return err;
+}
+
+static int __virtio_crypto_akcipher_do_req(struct virtio_crypto_akcipher_request *vc_akcipher_req,
+		struct akcipher_request *req, struct data_queue *data_vq)
+{
+	struct virtio_crypto_akcipher_ctx *ctx = vc_akcipher_req->akcipher_ctx;
+	struct virtio_crypto_request *vc_req = &vc_akcipher_req->base;
+	struct virtio_crypto *vcrypto = ctx->vcrypto;
+	struct virtio_crypto_op_data_req *req_data = vc_req->req_data;
+	struct scatterlist *sgs[4], outhdr_sg, inhdr_sg, srcdata_sg, dstdata_sg;
+	void *src_buf = NULL, *dst_buf = NULL;
+	unsigned int num_out = 0, num_in = 0;
+	int node = dev_to_node(&vcrypto->vdev->dev);
+	unsigned long flags;
+	int ret = -ENOMEM;
+	bool verify = vc_akcipher_req->opcode == VIRTIO_CRYPTO_AKCIPHER_VERIFY;
+	unsigned int src_len = verify ? req->src_len + req->dst_len : req->src_len;
+
+	/* out header */
+	sg_init_one(&outhdr_sg, req_data, sizeof(*req_data));
+	sgs[num_out++] = &outhdr_sg;
+
+	/* src data */
+	src_buf = kcalloc_node(src_len, 1, GFP_KERNEL, node);
+	if (!src_buf)
+		goto err;
+
+	if (verify) {
+		/* for verify operation, both src and dst data work as OUT direction */
+		sg_copy_to_buffer(req->src, sg_nents(req->src), src_buf, src_len);
+		sg_init_one(&srcdata_sg, src_buf, src_len);
+		sgs[num_out++] = &srcdata_sg;
+	} else {
+		sg_copy_to_buffer(req->src, sg_nents(req->src), src_buf, src_len);
+		sg_init_one(&srcdata_sg, src_buf, src_len);
+		sgs[num_out++] = &srcdata_sg;
+
+		/* dst data */
+		dst_buf = kcalloc_node(req->dst_len, 1, GFP_KERNEL, node);
+		if (!dst_buf)
+			goto err;
+
+		sg_init_one(&dstdata_sg, dst_buf, req->dst_len);
+		sgs[num_out + num_in++] = &dstdata_sg;
+	}
+
+	vc_akcipher_req->src_buf = src_buf;
+	vc_akcipher_req->dst_buf = dst_buf;
+
+	/* in header */
+	sg_init_one(&inhdr_sg, &vc_req->status, sizeof(vc_req->status));
+	sgs[num_out + num_in++] = &inhdr_sg;
+
+	spin_lock_irqsave(&data_vq->lock, flags);
+	ret = virtqueue_add_sgs(data_vq->vq, sgs, num_out, num_in, vc_req, GFP_ATOMIC);
+	virtqueue_kick(data_vq->vq);
+	spin_unlock_irqrestore(&data_vq->lock, flags);
+	if (ret)
+		goto err;
+
+	return 0;
+
+err:
+	kfree(src_buf);
+	kfree(dst_buf);
+
+	return -ENOMEM;
+}
+
+static int virtio_crypto_rsa_do_req(struct crypto_engine *engine, void *vreq)
+{
+	struct akcipher_request *req = container_of(vreq, struct akcipher_request, base);
+	struct virtio_crypto_akcipher_request *vc_akcipher_req = akcipher_request_ctx(req);
+	struct virtio_crypto_request *vc_req = &vc_akcipher_req->base;
+	struct virtio_crypto_akcipher_ctx *ctx = vc_akcipher_req->akcipher_ctx;
+	struct virtio_crypto *vcrypto = ctx->vcrypto;
+	struct data_queue *data_vq = vc_req->dataq;
+	struct virtio_crypto_op_header *header;
+	struct virtio_crypto_akcipher_data_req *akcipher_req;
+	int ret;
+
+	vc_req->sgs = NULL;
+	vc_req->req_data = kzalloc_node(sizeof(*vc_req->req_data),
+		GFP_KERNEL, dev_to_node(&vcrypto->vdev->dev));
+	if (!vc_req->req_data)
+		return -ENOMEM;
+
+	/* build request header */
+	header = &vc_req->req_data->header;
+	header->opcode = cpu_to_le32(vc_akcipher_req->opcode);
+	header->algo = cpu_to_le32(VIRTIO_CRYPTO_AKCIPHER_RSA);
+	header->session_id = cpu_to_le64(ctx->session_id);
+
+	/* build request akcipher data */
+	akcipher_req = &vc_req->req_data->u.akcipher_req;
+	akcipher_req->para.src_data_len = cpu_to_le32(req->src_len);
+	akcipher_req->para.dst_data_len = cpu_to_le32(req->dst_len);
+
+	ret = __virtio_crypto_akcipher_do_req(vc_akcipher_req, req, data_vq);
+	if (ret < 0) {
+		kfree_sensitive(vc_req->req_data);
+		vc_req->req_data = NULL;
+		return ret;
+	}
+
+	return 0;
+}
+
+static int virtio_crypto_rsa_req(struct akcipher_request *req, uint32_t opcode)
+{
+	struct crypto_akcipher *atfm = crypto_akcipher_reqtfm(req);
+	struct virtio_crypto_akcipher_ctx *ctx = akcipher_tfm_ctx(atfm);
+	struct virtio_crypto_akcipher_request *vc_akcipher_req = akcipher_request_ctx(req);
+	struct virtio_crypto_request *vc_req = &vc_akcipher_req->base;
+	struct virtio_crypto *vcrypto = ctx->vcrypto;
+	/* Use the first data virtqueue as default */
+	struct data_queue *data_vq = &vcrypto->data_vq[0];
+
+	vc_req->dataq = data_vq;
+	vc_req->alg_cb = virtio_crypto_dataq_akcipher_callback;
+	vc_akcipher_req->akcipher_ctx = ctx;
+	vc_akcipher_req->akcipher_req = req;
+	vc_akcipher_req->opcode = opcode;
+
+	return crypto_transfer_akcipher_request_to_engine(data_vq->engine, req);
+}
+
+static int virtio_crypto_rsa_encrypt(struct akcipher_request *req)
+{
+	return virtio_crypto_rsa_req(req, VIRTIO_CRYPTO_AKCIPHER_ENCRYPT);
+}
+
+static int virtio_crypto_rsa_decrypt(struct akcipher_request *req)
+{
+	return virtio_crypto_rsa_req(req, VIRTIO_CRYPTO_AKCIPHER_DECRYPT);
+}
+
+static int virtio_crypto_rsa_sign(struct akcipher_request *req)
+{
+	return virtio_crypto_rsa_req(req, VIRTIO_CRYPTO_AKCIPHER_SIGN);
+}
+
+static int virtio_crypto_rsa_verify(struct akcipher_request *req)
+{
+	return virtio_crypto_rsa_req(req, VIRTIO_CRYPTO_AKCIPHER_VERIFY);
+}
+
+static int virtio_crypto_rsa_set_key(struct crypto_akcipher *tfm,
+				     const void *key,
+				     unsigned int keylen,
+				     bool private,
+				     int padding_algo,
+				     int hash_algo)
+{
+	struct virtio_crypto_akcipher_ctx *ctx = akcipher_tfm_ctx(tfm);
+	struct virtio_crypto_rsa_ctx *rsa_ctx = &ctx->rsa_ctx;
+	struct virtio_crypto *vcrypto;
+	struct virtio_crypto_ctrl_header header;
+	struct virtio_crypto_akcipher_session_para para;
+	struct rsa_key rsa_key = {0};
+	int node = virtio_crypto_get_current_node();
+	uint32_t keytype;
+	int ret;
+
+	/* mpi_free will test n, just free it. */
+	mpi_free(rsa_ctx->n);
+	rsa_ctx->n = NULL;
+
+	if (private) {
+		keytype = VIRTIO_CRYPTO_AKCIPHER_KEY_TYPE_PRIVATE;
+		ret = rsa_parse_priv_key(&rsa_key, key, keylen);
+	} else {
+		keytype = VIRTIO_CRYPTO_AKCIPHER_KEY_TYPE_PUBLIC;
+		ret = rsa_parse_pub_key(&rsa_key, key, keylen);
+	}
+
+	if (ret)
+		return ret;
+
+	rsa_ctx->n = mpi_read_raw_data(rsa_key.n, rsa_key.n_sz);
+	if (!rsa_ctx->n)
+		return -ENOMEM;
+
+	if (!ctx->vcrypto) {
+		vcrypto = virtcrypto_get_dev_node(node, VIRTIO_CRYPTO_SERVICE_AKCIPHER,
+						VIRTIO_CRYPTO_AKCIPHER_RSA);
+		if (!vcrypto) {
+			pr_err("virtio_crypto: Could not find a virtio device in the system or unsupported algo\n");
+			return -ENODEV;
+		}
+
+		ctx->vcrypto = vcrypto;
+	} else {
+		virtio_crypto_alg_akcipher_close_session(ctx);
+	}
+
+	/* set ctrl header */
+	header.opcode =	cpu_to_le32(VIRTIO_CRYPTO_AKCIPHER_CREATE_SESSION);
+	header.algo = cpu_to_le32(VIRTIO_CRYPTO_AKCIPHER_RSA);
+	header.queue_id = 0;
+
+	/* set RSA para */
+	para.algo = cpu_to_le32(VIRTIO_CRYPTO_AKCIPHER_RSA);
+	para.keytype = cpu_to_le32(keytype);
+	para.keylen = cpu_to_le32(keylen);
+	para.u.rsa.padding_algo = cpu_to_le32(padding_algo);
+	para.u.rsa.hash_algo = cpu_to_le32(hash_algo);
+
+	return virtio_crypto_alg_akcipher_init_session(ctx, &header, &para, key, keylen);
+}
+
+static int virtio_crypto_rsa_raw_set_priv_key(struct crypto_akcipher *tfm,
+					      const void *key,
+					      unsigned int keylen)
+{
+	return virtio_crypto_rsa_set_key(tfm, key, keylen, 1,
+					 VIRTIO_CRYPTO_RSA_RAW_PADDING,
+					 VIRTIO_CRYPTO_RSA_NO_HASH);
+}
+
+
+static int virtio_crypto_p1pad_rsa_sha1_set_priv_key(struct crypto_akcipher *tfm,
+						     const void *key,
+						     unsigned int keylen)
+{
+	return virtio_crypto_rsa_set_key(tfm, key, keylen, 1,
+					 VIRTIO_CRYPTO_RSA_PKCS1_PADDING,
+					 VIRTIO_CRYPTO_RSA_SHA1);
+}
+
+static int virtio_crypto_rsa_raw_set_pub_key(struct crypto_akcipher *tfm,
+					     const void *key,
+					     unsigned int keylen)
+{
+	return virtio_crypto_rsa_set_key(tfm, key, keylen, 0,
+					 VIRTIO_CRYPTO_RSA_RAW_PADDING,
+					 VIRTIO_CRYPTO_RSA_NO_HASH);
+}
+
+static int virtio_crypto_p1pad_rsa_sha1_set_pub_key(struct crypto_akcipher *tfm,
+						    const void *key,
+						    unsigned int keylen)
+{
+	return virtio_crypto_rsa_set_key(tfm, key, keylen, 0,
+					 VIRTIO_CRYPTO_RSA_PKCS1_PADDING,
+					 VIRTIO_CRYPTO_RSA_SHA1);
+}
+
+static unsigned int virtio_crypto_rsa_max_size(struct crypto_akcipher *tfm)
+{
+	struct virtio_crypto_akcipher_ctx *ctx = akcipher_tfm_ctx(tfm);
+	struct virtio_crypto_rsa_ctx *rsa_ctx = &ctx->rsa_ctx;
+
+	return mpi_get_size(rsa_ctx->n);
+}
+
+static int virtio_crypto_rsa_init_tfm(struct crypto_akcipher *tfm)
+{
+	struct virtio_crypto_akcipher_ctx *ctx = akcipher_tfm_ctx(tfm);
+
+	ctx->tfm = tfm;
+	ctx->enginectx.op.do_one_request = virtio_crypto_rsa_do_req;
+	ctx->enginectx.op.prepare_request = NULL;
+	ctx->enginectx.op.unprepare_request = NULL;
+
+	return 0;
+}
+
+static void virtio_crypto_rsa_exit_tfm(struct crypto_akcipher *tfm)
+{
+	struct virtio_crypto_akcipher_ctx *ctx = akcipher_tfm_ctx(tfm);
+	struct virtio_crypto_rsa_ctx *rsa_ctx = &ctx->rsa_ctx;
+
+	virtio_crypto_alg_akcipher_close_session(ctx);
+	virtcrypto_dev_put(ctx->vcrypto);
+	mpi_free(rsa_ctx->n);
+	rsa_ctx->n = NULL;
+}
+
+static struct virtio_crypto_akcipher_algo virtio_crypto_akcipher_algs[] = {
+	{
+		.algonum = VIRTIO_CRYPTO_AKCIPHER_RSA,
+		.service = VIRTIO_CRYPTO_SERVICE_AKCIPHER,
+		.algo = {
+			.encrypt = virtio_crypto_rsa_encrypt,
+			.decrypt = virtio_crypto_rsa_decrypt,
+			.set_pub_key = virtio_crypto_rsa_raw_set_pub_key,
+			.set_priv_key = virtio_crypto_rsa_raw_set_priv_key,
+			.max_size = virtio_crypto_rsa_max_size,
+			.init = virtio_crypto_rsa_init_tfm,
+			.exit = virtio_crypto_rsa_exit_tfm,
+			.reqsize = sizeof(struct virtio_crypto_akcipher_request),
+			.base = {
+				.cra_name = "rsa",
+				.cra_driver_name = "virtio-crypto-rsa",
+				.cra_priority = 150,
+				.cra_module = THIS_MODULE,
+				.cra_ctxsize = sizeof(struct virtio_crypto_akcipher_ctx),
+			},
+		},
+	},
+	{
+		.algonum = VIRTIO_CRYPTO_AKCIPHER_RSA,
+		.service = VIRTIO_CRYPTO_SERVICE_AKCIPHER,
+		.algo = {
+			.encrypt = virtio_crypto_rsa_encrypt,
+			.decrypt = virtio_crypto_rsa_decrypt,
+			.sign = virtio_crypto_rsa_sign,
+			.verify = virtio_crypto_rsa_verify,
+			.set_pub_key = virtio_crypto_p1pad_rsa_sha1_set_pub_key,
+			.set_priv_key = virtio_crypto_p1pad_rsa_sha1_set_priv_key,
+			.max_size = virtio_crypto_rsa_max_size,
+			.init = virtio_crypto_rsa_init_tfm,
+			.exit = virtio_crypto_rsa_exit_tfm,
+			.reqsize = sizeof(struct virtio_crypto_akcipher_request),
+			.base = {
+				.cra_name = "pkcs1pad(rsa,sha1)",
+				.cra_driver_name = "virtio-pkcs1-rsa-with-sha1",
+				.cra_priority = 150,
+				.cra_module = THIS_MODULE,
+				.cra_ctxsize = sizeof(struct virtio_crypto_akcipher_ctx),
+			},
+		},
+	},
+};
+
+int virtio_crypto_akcipher_algs_register(struct virtio_crypto *vcrypto)
+{
+	int ret = 0;
+	int i = 0;
+
+	mutex_lock(&algs_lock);
+
+	for (i = 0; i < ARRAY_SIZE(virtio_crypto_akcipher_algs); i++) {
+		uint32_t service = virtio_crypto_akcipher_algs[i].service;
+		uint32_t algonum = virtio_crypto_akcipher_algs[i].algonum;
+
+		if (!virtcrypto_algo_is_supported(vcrypto, service, algonum))
+			continue;
+
+		if (virtio_crypto_akcipher_algs[i].active_devs == 0) {
+			ret = crypto_register_akcipher(&virtio_crypto_akcipher_algs[i].algo);
+			if (ret)
+				goto unlock;
+		}
+
+		virtio_crypto_akcipher_algs[i].active_devs++;
+		dev_info(&vcrypto->vdev->dev, "Registered akcipher algo %s\n",
+			 virtio_crypto_akcipher_algs[i].algo.base.cra_name);
+	}
+
+unlock:
+	mutex_unlock(&algs_lock);
+	return ret;
+}
+
+void virtio_crypto_akcipher_algs_unregister(struct virtio_crypto *vcrypto)
+{
+	int i = 0;
+
+	mutex_lock(&algs_lock);
+
+	for (i = 0; i < ARRAY_SIZE(virtio_crypto_akcipher_algs); i++) {
+		uint32_t service = virtio_crypto_akcipher_algs[i].service;
+		uint32_t algonum = virtio_crypto_akcipher_algs[i].algonum;
+
+		if (virtio_crypto_akcipher_algs[i].active_devs == 0 ||
+		    !virtcrypto_algo_is_supported(vcrypto, service, algonum))
+			continue;
+
+		if (virtio_crypto_akcipher_algs[i].active_devs == 1)
+			crypto_unregister_akcipher(&virtio_crypto_akcipher_algs[i].algo);
+
+		virtio_crypto_akcipher_algs[i].active_devs--;
+	}
+
+	mutex_unlock(&algs_lock);
+}
diff --git a/drivers/crypto/virtio/virtio_crypto_common.h b/drivers/crypto/virtio/virtio_crypto_common.h
index a24f85c589e7..214f9a6fcf84 100644
--- a/drivers/crypto/virtio/virtio_crypto_common.h
+++ b/drivers/crypto/virtio/virtio_crypto_common.h
@@ -56,6 +56,7 @@ struct virtio_crypto {
 	u32 mac_algo_l;
 	u32 mac_algo_h;
 	u32 aead_algo;
+	u32 akcipher_algo;
 
 	/* Maximum length of cipher key */
 	u32 max_cipher_key_len;
@@ -131,5 +132,7 @@ static inline int virtio_crypto_get_current_node(void)
 
 int virtio_crypto_algs_register(struct virtio_crypto *vcrypto);
 void virtio_crypto_algs_unregister(struct virtio_crypto *vcrypto);
+int virtio_crypto_akcipher_algs_register(struct virtio_crypto *vcrypto);
+void virtio_crypto_akcipher_algs_unregister(struct virtio_crypto *vcrypto);
 
 #endif /* _VIRTIO_CRYPTO_COMMON_H */
diff --git a/drivers/crypto/virtio/virtio_crypto_core.c b/drivers/crypto/virtio/virtio_crypto_core.c
index 8e977b7627cb..c6f482db0bc0 100644
--- a/drivers/crypto/virtio/virtio_crypto_core.c
+++ b/drivers/crypto/virtio/virtio_crypto_core.c
@@ -297,6 +297,7 @@ static int virtcrypto_probe(struct virtio_device *vdev)
 	u32 mac_algo_l = 0;
 	u32 mac_algo_h = 0;
 	u32 aead_algo = 0;
+	u32 akcipher_algo = 0;
 	u32 crypto_services = 0;
 
 	if (!virtio_has_feature(vdev, VIRTIO_F_VERSION_1))
@@ -348,6 +349,9 @@ static int virtcrypto_probe(struct virtio_device *vdev)
 			mac_algo_h, &mac_algo_h);
 	virtio_cread_le(vdev, struct virtio_crypto_config,
 			aead_algo, &aead_algo);
+	if (crypto_services & (1 << VIRTIO_CRYPTO_SERVICE_AKCIPHER))
+		virtio_cread_le(vdev, struct virtio_crypto_config,
+				akcipher_algo, &akcipher_algo);
 
 	/* Add virtio crypto device to global table */
 	err = virtcrypto_devmgr_add_dev(vcrypto);
@@ -374,7 +378,7 @@ static int virtcrypto_probe(struct virtio_device *vdev)
 	vcrypto->mac_algo_h = mac_algo_h;
 	vcrypto->hash_algo = hash_algo;
 	vcrypto->aead_algo = aead_algo;
-
+	vcrypto->akcipher_algo = akcipher_algo;
 
 	dev_info(&vdev->dev,
 		"max_queues: %u, max_cipher_key_len: %u, max_auth_key_len: %u, max_size 0x%llx\n",
diff --git a/drivers/crypto/virtio/virtio_crypto_mgr.c b/drivers/crypto/virtio/virtio_crypto_mgr.c
index 6860f8180c7c..1cb92418b321 100644
--- a/drivers/crypto/virtio/virtio_crypto_mgr.c
+++ b/drivers/crypto/virtio/virtio_crypto_mgr.c
@@ -242,6 +242,12 @@ int virtcrypto_dev_start(struct virtio_crypto *vcrypto)
 		return -EFAULT;
 	}
 
+	if (virtio_crypto_akcipher_algs_register(vcrypto)) {
+		pr_err("virtio_crypto: Failed to register crypto akcipher algs\n");
+		virtio_crypto_algs_unregister(vcrypto);
+		return -EFAULT;
+	}
+
 	return 0;
 }
 
@@ -258,6 +264,7 @@ int virtcrypto_dev_start(struct virtio_crypto *vcrypto)
 void virtcrypto_dev_stop(struct virtio_crypto *vcrypto)
 {
 	virtio_crypto_algs_unregister(vcrypto);
+	virtio_crypto_akcipher_algs_unregister(vcrypto);
 }
 
 /*
@@ -312,6 +319,10 @@ bool virtcrypto_algo_is_supported(struct virtio_crypto *vcrypto,
 	case VIRTIO_CRYPTO_SERVICE_AEAD:
 		algo_mask = vcrypto->aead_algo;
 		break;
+
+	case VIRTIO_CRYPTO_SERVICE_AKCIPHER:
+		algo_mask = vcrypto->akcipher_algo;
+		break;
 	}
 
 	if (!(algo_mask & (1u << algo)))
-- 
2.20.1

