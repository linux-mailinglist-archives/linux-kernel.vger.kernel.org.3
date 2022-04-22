Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0876450B1E8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 09:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444988AbiDVHon (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 03:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444953AbiDVHoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 03:44:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9D9AE517D2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 00:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650613305;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pdKLtwZK5Sd17EXPwwL/D1E/z7xr4keMdDdXRl8/G4Q=;
        b=f+0CpOKW9ZIL1HsFOPEek2xIYr85pS1Z8fswS52XoekKtFTyQg2Y7r84KGqqPS+f8wpuLL
        /2D7jcqZHOXIg2gkloK1MfvTJRfLvAWt/WoK2f8GKsHNrxMH/vZzKq21ONeRGJeWBQtu2E
        7woLoKQMvq5nQHkxfxs5JGrntdYNfow=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-631-DX27EBCnOeq0l22Gxskmwg-1; Fri, 22 Apr 2022 03:41:44 -0400
X-MC-Unique: DX27EBCnOeq0l22Gxskmwg-1
Received: by mail-pf1-f198.google.com with SMTP id i196-20020a6287cd000000b0050ab83e42c0so4725017pfe.7
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 00:41:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=pdKLtwZK5Sd17EXPwwL/D1E/z7xr4keMdDdXRl8/G4Q=;
        b=hYvl2RCNAOLLkRlQdSR4+d57zwnrRoZB9PV8Eb42ZGlgVhFWr94TCz7W6wW/K/8ogi
         9KKYbaxgeRCQZgGQAa175hRNHWE77slpnSLw64VVcUb1sVgii9mwsoO9egFL4ZfBC/2C
         qat4kyyfEITaorkMHDbMHdJbGuhun/+QkPRMVk2nxby1bl+Njpb/afj/SngaA0BRYu9I
         o1GrCTEjvEG2vGOGBmB6S9dfaOPlCBqocbB2zFyH84lGdBkh9u/peXxiEDwv0MyAQV2y
         qn+toQX3eXHUYQ8QnktHuLLhlxrfJl2aQ77DiJu6nKGZYzWg0+fQ4IsnH17neghTV5Mc
         4DFQ==
X-Gm-Message-State: AOAM530ri5VIG9nzIctAovBdcoxf88aKGiza15d9SwcHu6aoPfCAiHUw
        tWBVtHGFdLWjISCvmd+jHPiDCG1RxMbLOz5zqIMoQbhrknqSUuFZAn+im1bF5eZoBkfqcO92pQ3
        dhlqB95qMs1D/svqbfdtZMNxH
X-Received: by 2002:a17:90b:1b45:b0:1d2:d46f:57d4 with SMTP id nv5-20020a17090b1b4500b001d2d46f57d4mr3951984pjb.214.1650613303421;
        Fri, 22 Apr 2022 00:41:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx/lQLk2H6hJW4zMuC9L+S5/UfIPvYNJfvCLIzNthe22JQT76Zt2zmJ+Vy4cNLeHTZqE/D22g==
X-Received: by 2002:a17:90b:1b45:b0:1d2:d46f:57d4 with SMTP id nv5-20020a17090b1b4500b001d2d46f57d4mr3951958pjb.214.1650613303083;
        Fri, 22 Apr 2022 00:41:43 -0700 (PDT)
Received: from [10.72.12.62] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id n184-20020a6227c1000000b0050a3bbd36d6sm1418035pfn.204.2022.04.22.00.41.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Apr 2022 00:41:42 -0700 (PDT)
Message-ID: <7996f495-3bb8-fa80-7866-fa1fbff3e80a@redhat.com>
Date:   Fri, 22 Apr 2022 15:41:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [PATCH v3 1/5] virtio-crypto: use private buffer for control
 request
Content-Language: en-US
To:     zhenwei pi <pizhenwei@bytedance.com>, arei.gonglei@huawei.com,
        mst@redhat.com
Cc:     herbert@gondor.apana.org.au, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-crypto@vger.kernel.org, helei.sig11@bytedance.com,
        davem@davemloft.net
References: <20220421104016.453458-1-pizhenwei@bytedance.com>
 <20220421104016.453458-2-pizhenwei@bytedance.com>
From:   Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220421104016.453458-2-pizhenwei@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2022/4/21 18:40, zhenwei pi 写道:
> Originally, all of the control requests share a single buffer(
> ctrl & input & ctrl_status fields in struct virtio_crypto), this
> allows queue depth 1 only, the performance of control queue gets
> limited by this design.
>
> In this patch, each request allocates request buffer dynamically, and
> free buffer after request, it's possible to optimize control queue
> depth in the next step.
>
> A necessary comment is already in code, still describe it again:
> /*
>   * Note: there are padding fields in request, clear them to zero before
>   * sending to host,
>   * Ex, virtio_crypto_ctrl_request::ctrl::u::destroy_session::padding[48]
>   */
> So use kzalloc to allocate buffer of struct virtio_crypto_ctrl_request.
>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Gonglei <arei.gonglei@huawei.com>
> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
> ---
>   drivers/crypto/virtio/Makefile                |   1 +
>   .../virtio/virtio_crypto_akcipher_algs.c      |  90 ++++++------
>   drivers/crypto/virtio/virtio_crypto_common.c  |  39 +++++


Any reason we can't use virtio_crypto_core.c?


>   drivers/crypto/virtio/virtio_crypto_common.h  |  19 ++-
>   .../virtio/virtio_crypto_skcipher_algs.c      | 133 ++++++++----------
>   5 files changed, 156 insertions(+), 126 deletions(-)
>   create mode 100644 drivers/crypto/virtio/virtio_crypto_common.c
>
> diff --git a/drivers/crypto/virtio/Makefile b/drivers/crypto/virtio/Makefile
> index bfa6cbae342e..49c1fa80e465 100644
> --- a/drivers/crypto/virtio/Makefile
> +++ b/drivers/crypto/virtio/Makefile
> @@ -3,5 +3,6 @@ obj-$(CONFIG_CRYPTO_DEV_VIRTIO) += virtio_crypto.o
>   virtio_crypto-objs := \
>   	virtio_crypto_skcipher_algs.o \
>   	virtio_crypto_akcipher_algs.o \
> +	virtio_crypto_common.o \
>   	virtio_crypto_mgr.o \
>   	virtio_crypto_core.o
> diff --git a/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c b/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
> index f3ec9420215e..9561bc2df62b 100644
> --- a/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
> +++ b/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
> @@ -102,8 +102,8 @@ static int virtio_crypto_alg_akcipher_init_session(struct virtio_crypto_akcipher
>   {
>   	struct scatterlist outhdr_sg, key_sg, inhdr_sg, *sgs[3];
>   	struct virtio_crypto *vcrypto = ctx->vcrypto;
> +	struct virtio_crypto_ctrl_request *vc_ctrl_req;
>   	uint8_t *pkey;
> -	unsigned int inlen;
>   	int err;
>   	unsigned int num_out = 0, num_in = 0;
>   
> @@ -111,98 +111,91 @@ static int virtio_crypto_alg_akcipher_init_session(struct virtio_crypto_akcipher
>   	if (!pkey)
>   		return -ENOMEM;
>   
> -	spin_lock(&vcrypto->ctrl_lock);
> -	memcpy(&vcrypto->ctrl.header, header, sizeof(vcrypto->ctrl.header));
> -	memcpy(&vcrypto->ctrl.u, para, sizeof(vcrypto->ctrl.u));
> -	vcrypto->input.status = cpu_to_le32(VIRTIO_CRYPTO_ERR);
> +	vc_ctrl_req = kzalloc(sizeof(*vc_ctrl_req), GFP_KERNEL);
> +	if (!vc_ctrl_req) {
> +		err = -ENOMEM;
> +		goto out;
> +	}
>   
> -	sg_init_one(&outhdr_sg, &vcrypto->ctrl, sizeof(vcrypto->ctrl));
> +	memcpy(&vc_ctrl_req->ctrl.header, header, sizeof(vc_ctrl_req->ctrl.header));
> +	memcpy(&vc_ctrl_req->ctrl.u, para, sizeof(vc_ctrl_req->ctrl.u));
> +	sg_init_one(&outhdr_sg, &vc_ctrl_req->ctrl, sizeof(vc_ctrl_req->ctrl));
>   	sgs[num_out++] = &outhdr_sg;
>   
>   	sg_init_one(&key_sg, pkey, keylen);
>   	sgs[num_out++] = &key_sg;
>   
> -	sg_init_one(&inhdr_sg, &vcrypto->input, sizeof(vcrypto->input));
> +	vc_ctrl_req->input.status = cpu_to_le32(VIRTIO_CRYPTO_ERR);


Nit: if there's no special reason, let's move this after the above 
memcpys as what's done previously.


> +	sg_init_one(&inhdr_sg, &vc_ctrl_req->input, sizeof(vc_ctrl_req->input));
>   	sgs[num_out + num_in++] = &inhdr_sg;
>   
> -	err = virtqueue_add_sgs(vcrypto->ctrl_vq, sgs, num_out, num_in, vcrypto, GFP_ATOMIC);
> +	err = virtio_crypto_ctrl_vq_request(vcrypto, sgs, num_out, num_in, vc_ctrl_req);


I'd split this into a separate patch.


>   	if (err < 0)
>   		goto out;
>   
> -	virtqueue_kick(vcrypto->ctrl_vq);
> -	while (!virtqueue_get_buf(vcrypto->ctrl_vq, &inlen) &&
> -	       !virtqueue_is_broken(vcrypto->ctrl_vq))
> -		cpu_relax();
> -
> -	if (le32_to_cpu(vcrypto->input.status) != VIRTIO_CRYPTO_OK) {
> +	if (le32_to_cpu(vc_ctrl_req->input.status) != VIRTIO_CRYPTO_OK) {
> +		pr_err("virtio_crypto: Create session failed status: %u\n",
> +			le32_to_cpu(vc_ctrl_req->input.status));
>   		err = -EINVAL;
>   		goto out;
>   	}


Do we need a warning for -ENOMEM?


>   
> -	ctx->session_id = le64_to_cpu(vcrypto->input.session_id);
> +	ctx->session_id = le64_to_cpu(vc_ctrl_req->input.session_id);
>   	ctx->session_valid = true;
>   	err = 0;
>   
>   out:
> -	spin_unlock(&vcrypto->ctrl_lock);
> +	kfree(vc_ctrl_req);
>   	kfree_sensitive(pkey);
>   
> -	if (err < 0)
> -		pr_err("virtio_crypto: Create session failed status: %u\n",
> -			le32_to_cpu(vcrypto->input.status));
> -
>   	return err;
>   }
>   
>   static int virtio_crypto_alg_akcipher_close_session(struct virtio_crypto_akcipher_ctx *ctx)
>   {
>   	struct scatterlist outhdr_sg, inhdr_sg, *sgs[2];
> +	struct virtio_crypto_ctrl_request *vc_ctrl_req;
>   	struct virtio_crypto_destroy_session_req *destroy_session;
>   	struct virtio_crypto *vcrypto = ctx->vcrypto;
> -	unsigned int num_out = 0, num_in = 0, inlen;
> +	unsigned int num_out = 0, num_in = 0;
>   	int err;
>   
> -	spin_lock(&vcrypto->ctrl_lock);
> -	if (!ctx->session_valid) {
> -		err = 0;
> -		goto out;
> -	}
> -	vcrypto->ctrl_status.status = VIRTIO_CRYPTO_ERR;
> -	vcrypto->ctrl.header.opcode = cpu_to_le32(VIRTIO_CRYPTO_AKCIPHER_DESTROY_SESSION);
> -	vcrypto->ctrl.header.queue_id = 0;
> +	if (!ctx->session_valid)
> +		return 0;
>   
> -	destroy_session = &vcrypto->ctrl.u.destroy_session;
> +	vc_ctrl_req = kzalloc(sizeof(*vc_ctrl_req), GFP_KERNEL);
> +	if (!vc_ctrl_req)
> +		return -ENOMEM;
> +
> +	vc_ctrl_req->ctrl.header.opcode = cpu_to_le32(VIRTIO_CRYPTO_AKCIPHER_DESTROY_SESSION);
> +	vc_ctrl_req->ctrl.header.queue_id = 0;
> +
> +	destroy_session = &vc_ctrl_req->ctrl.u.destroy_session;
>   	destroy_session->session_id = cpu_to_le64(ctx->session_id);
>   
> -	sg_init_one(&outhdr_sg, &vcrypto->ctrl, sizeof(vcrypto->ctrl));
> +	sg_init_one(&outhdr_sg, &vc_ctrl_req->ctrl, sizeof(vc_ctrl_req->ctrl));
>   	sgs[num_out++] = &outhdr_sg;
>   
> -	sg_init_one(&inhdr_sg, &vcrypto->ctrl_status.status, sizeof(vcrypto->ctrl_status.status));
> +	vc_ctrl_req->ctrl_status.status = VIRTIO_CRYPTO_ERR;


If no special reason, let's move this above:

vc_ctrl_req->ctrl.header.opcode = cpu_to_le32(VIRTIO_CRYPTO_AKCIPHER_DESTROY_SESSION);


> +	sg_init_one(&inhdr_sg, &vc_ctrl_req->ctrl_status.status,
> +		sizeof(vc_ctrl_req->ctrl_status.status));
>   	sgs[num_out + num_in++] = &inhdr_sg;
>   
> -	err = virtqueue_add_sgs(vcrypto->ctrl_vq, sgs, num_out, num_in, vcrypto, GFP_ATOMIC);
> +	err = virtio_crypto_ctrl_vq_request(vcrypto, sgs, num_out, num_in, vc_ctrl_req);
>   	if (err < 0)
>   		goto out;
>   
> -	virtqueue_kick(vcrypto->ctrl_vq);
> -	while (!virtqueue_get_buf(vcrypto->ctrl_vq, &inlen) &&
> -	       !virtqueue_is_broken(vcrypto->ctrl_vq))
> -		cpu_relax();
> -
> -	if (vcrypto->ctrl_status.status != VIRTIO_CRYPTO_OK) {
> +	if (vc_ctrl_req->ctrl_status.status != VIRTIO_CRYPTO_OK) {
>   		err = -EINVAL;
> +		pr_err("virtio_crypto: Close session failed status: %u, session_id: 0x%llx\n",
> +			vc_ctrl_req->ctrl_status.status, destroy_session->session_id);
>   		goto out;
>   	}
>   
>   	err = 0;
>   	ctx->session_valid = false;
> -
>   out:
> -	spin_unlock(&vcrypto->ctrl_lock);
> -	if (err < 0) {
> -		pr_err("virtio_crypto: Close session failed status: %u, session_id: 0x%llx\n",
> -			vcrypto->ctrl_status.status, destroy_session->session_id);
> -	}
> +	kfree(vc_ctrl_req);
>   
>   	return err;
>   }
> @@ -210,14 +203,11 @@ static int virtio_crypto_alg_akcipher_close_session(struct virtio_crypto_akciphe
>   static int __virtio_crypto_akcipher_do_req(struct virtio_crypto_akcipher_request *vc_akcipher_req,
>   		struct akcipher_request *req, struct data_queue *data_vq)
>   {
> -	struct virtio_crypto_akcipher_ctx *ctx = vc_akcipher_req->akcipher_ctx;
>   	struct virtio_crypto_request *vc_req = &vc_akcipher_req->base;
> -	struct virtio_crypto *vcrypto = ctx->vcrypto;
>   	struct virtio_crypto_op_data_req *req_data = vc_req->req_data;
>   	struct scatterlist *sgs[4], outhdr_sg, inhdr_sg, srcdata_sg, dstdata_sg;
>   	void *src_buf = NULL, *dst_buf = NULL;
>   	unsigned int num_out = 0, num_in = 0;
> -	int node = dev_to_node(&vcrypto->vdev->dev);
>   	unsigned long flags;
>   	int ret = -ENOMEM;
>   	bool verify = vc_akcipher_req->opcode == VIRTIO_CRYPTO_AKCIPHER_VERIFY;
> @@ -228,7 +218,7 @@ static int __virtio_crypto_akcipher_do_req(struct virtio_crypto_akcipher_request
>   	sgs[num_out++] = &outhdr_sg;
>   
>   	/* src data */
> -	src_buf = kcalloc_node(src_len, 1, GFP_KERNEL, node);
> +	src_buf = kcalloc(src_len, 1, GFP_KERNEL);


This seems not a relevant change. If it is a must we need use a separate 
for this and describe the rationale.


>   	if (!src_buf)
>   		goto err;
>   
> @@ -243,7 +233,7 @@ static int __virtio_crypto_akcipher_do_req(struct virtio_crypto_akcipher_request
>   		sgs[num_out++] = &srcdata_sg;
>   
>   		/* dst data */
> -		dst_buf = kcalloc_node(req->dst_len, 1, GFP_KERNEL, node);
> +		dst_buf = kcalloc(req->dst_len, 1, GFP_KERNEL);


And this.


>   		if (!dst_buf)
>   			goto err;
>   
> diff --git a/drivers/crypto/virtio/virtio_crypto_common.c b/drivers/crypto/virtio/virtio_crypto_common.c
> new file mode 100644
> index 000000000000..e65125a74db2
> --- /dev/null
> +++ b/drivers/crypto/virtio/virtio_crypto_common.c
> @@ -0,0 +1,39 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/* Common functions and helpers
> + *
> + * Authors: zhenwei pi <pizhenwei@bytedance.com>
> + *
> + * Copyright 2022 Bytedance CO., LTD.
> + */
> +
> +#include "virtio_crypto_common.h"
> +
> +int virtio_crypto_ctrl_vq_request(struct virtio_crypto *vcrypto, struct scatterlist *sgs[],
> +				  unsigned int out_sgs, unsigned int in_sgs,
> +				  struct virtio_crypto_ctrl_request *vc_ctrl_req)
> +{
> +	int err;
> +	unsigned int inlen;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&vcrypto->ctrl_lock, flags);
> +	err = virtqueue_add_sgs(vcrypto->ctrl_vq, sgs, out_sgs, in_sgs, vc_ctrl_req, GFP_ATOMIC);
> +	if (err < 0) {
> +		spin_unlock_irqrestore(&vcrypto->ctrl_lock, flags);
> +		return err;
> +	}
> +
> +	virtqueue_kick(vcrypto->ctrl_vq);
> +
> +	/*
> +	 * Trapping into the hypervisor, so the request should be
> +	 * handled immediately.
> +	 */
> +	while (!virtqueue_get_buf(vcrypto->ctrl_vq, &inlen) &&
> +		!virtqueue_is_broken(vcrypto->ctrl_vq))
> +		cpu_relax();
> +
> +	spin_unlock_irqrestore(&vcrypto->ctrl_lock, flags);
> +
> +	return 0;
> +}
> diff --git a/drivers/crypto/virtio/virtio_crypto_common.h b/drivers/crypto/virtio/virtio_crypto_common.h
> index e693d4ee83a6..d2a20fe6e13e 100644
> --- a/drivers/crypto/virtio/virtio_crypto_common.h
> +++ b/drivers/crypto/virtio/virtio_crypto_common.h
> @@ -13,6 +13,7 @@
>   #include <crypto/aead.h>
>   #include <crypto/aes.h>
>   #include <crypto/engine.h>
> +#include <uapi/linux/virtio_crypto.h>
>   
>   
>   /* Internal representation of a data virtqueue */
> @@ -65,11 +66,6 @@ struct virtio_crypto {
>   	/* Maximum size of per request */
>   	u64 max_size;
>   
> -	/* Control VQ buffers: protected by the ctrl_lock */
> -	struct virtio_crypto_op_ctrl_req ctrl;
> -	struct virtio_crypto_session_input input;
> -	struct virtio_crypto_inhdr ctrl_status;
> -
>   	unsigned long status;
>   	atomic_t ref_count;
>   	struct list_head list;
> @@ -85,6 +81,16 @@ struct virtio_crypto_sym_session_info {
>   	__u64 session_id;
>   };
>   
> +/*
> + * Note: there are padding fields in request, clear them to zero before sending to host,
> + * Ex, virtio_crypto_ctrl_request::ctrl::u::destroy_session::padding[48]
> + */
> +struct virtio_crypto_ctrl_request {
> +	struct virtio_crypto_op_ctrl_req ctrl;
> +	struct virtio_crypto_session_input input;
> +	struct virtio_crypto_inhdr ctrl_status;
> +};
> +
>   struct virtio_crypto_request;
>   typedef void (*virtio_crypto_data_callback)
>   		(struct virtio_crypto_request *vc_req, int len);
> @@ -135,4 +141,7 @@ void virtio_crypto_skcipher_algs_unregister(struct virtio_crypto *vcrypto);
>   int virtio_crypto_akcipher_algs_register(struct virtio_crypto *vcrypto);
>   void virtio_crypto_akcipher_algs_unregister(struct virtio_crypto *vcrypto);
>   
> +int virtio_crypto_ctrl_vq_request(struct virtio_crypto *vcrypto, struct scatterlist *sgs[],
> +				  unsigned int out_sgs, unsigned int in_sgs,
> +				  struct virtio_crypto_ctrl_request *vc_ctrl_req);
>   #endif /* _VIRTIO_CRYPTO_COMMON_H */
> diff --git a/drivers/crypto/virtio/virtio_crypto_skcipher_algs.c b/drivers/crypto/virtio/virtio_crypto_skcipher_algs.c
> index a618c46a52b8..fef355ff461c 100644
> --- a/drivers/crypto/virtio/virtio_crypto_skcipher_algs.c
> +++ b/drivers/crypto/virtio/virtio_crypto_skcipher_algs.c
> @@ -118,11 +118,13 @@ static int virtio_crypto_alg_skcipher_init_session(
>   		int encrypt)
>   {
>   	struct scatterlist outhdr, key_sg, inhdr, *sgs[3];
> -	unsigned int tmp;
>   	struct virtio_crypto *vcrypto = ctx->vcrypto;


Can we simply rename this to virtcrypto and then we can use the name 
"vcrypto" for virtio_crypto_ctrl_request then we save tons lot changes?

It simplify the life of reviewers and backporting.

Thanks


>   	int op = encrypt ? VIRTIO_CRYPTO_OP_ENCRYPT : VIRTIO_CRYPTO_OP_DECRYPT;
>   	int err;
>   	unsigned int num_out = 0, num_in = 0;
> +	struct virtio_crypto_ctrl_request *vc_ctrl_req;
> +	struct virtio_crypto_ctrl_header *header;
> +	struct virtio_crypto_sym_create_session_req *sym_create_session;
>   
>   	/*
>   	 * Avoid to do DMA from the stack, switch to using
> @@ -133,26 +135,27 @@ static int virtio_crypto_alg_skcipher_init_session(
>   	if (!cipher_key)
>   		return -ENOMEM;
>   
> -	spin_lock(&vcrypto->ctrl_lock);
> +	vc_ctrl_req = kzalloc(sizeof(*vc_ctrl_req), GFP_KERNEL);
> +	if (!vc_ctrl_req) {
> +		err = -ENOMEM;
> +		goto out;
> +	}
> +
>   	/* Pad ctrl header */
> -	vcrypto->ctrl.header.opcode =
> -		cpu_to_le32(VIRTIO_CRYPTO_CIPHER_CREATE_SESSION);
> -	vcrypto->ctrl.header.algo = cpu_to_le32(alg);
> +	header = &vc_ctrl_req->ctrl.header;
> +	header->opcode = cpu_to_le32(VIRTIO_CRYPTO_CIPHER_CREATE_SESSION);
> +	header->algo = cpu_to_le32(alg);
>   	/* Set the default dataqueue id to 0 */
> -	vcrypto->ctrl.header.queue_id = 0;
> +	header->queue_id = 0;
>   
> -	vcrypto->input.status = cpu_to_le32(VIRTIO_CRYPTO_ERR);
>   	/* Pad cipher's parameters */
> -	vcrypto->ctrl.u.sym_create_session.op_type =
> -		cpu_to_le32(VIRTIO_CRYPTO_SYM_OP_CIPHER);
> -	vcrypto->ctrl.u.sym_create_session.u.cipher.para.algo =
> -		vcrypto->ctrl.header.algo;
> -	vcrypto->ctrl.u.sym_create_session.u.cipher.para.keylen =
> -		cpu_to_le32(keylen);
> -	vcrypto->ctrl.u.sym_create_session.u.cipher.para.op =
> -		cpu_to_le32(op);
> -
> -	sg_init_one(&outhdr, &vcrypto->ctrl, sizeof(vcrypto->ctrl));
> +	sym_create_session = &vc_ctrl_req->ctrl.u.sym_create_session;
> +	sym_create_session->op_type = cpu_to_le32(VIRTIO_CRYPTO_SYM_OP_CIPHER);
> +	sym_create_session->u.cipher.para.algo = header->algo;
> +	sym_create_session->u.cipher.para.keylen = cpu_to_le32(keylen);
> +	sym_create_session->u.cipher.para.op = cpu_to_le32(op);
> +
> +	sg_init_one(&outhdr, &vc_ctrl_req->ctrl, sizeof(vc_ctrl_req->ctrl));
>   	sgs[num_out++] = &outhdr;
>   
>   	/* Set key */
> @@ -160,45 +163,34 @@ static int virtio_crypto_alg_skcipher_init_session(
>   	sgs[num_out++] = &key_sg;
>   
>   	/* Return status and session id back */
> -	sg_init_one(&inhdr, &vcrypto->input, sizeof(vcrypto->input));
> +	vc_ctrl_req->input.status = cpu_to_le32(VIRTIO_CRYPTO_ERR);
> +	sg_init_one(&inhdr, &vc_ctrl_req->input, sizeof(vc_ctrl_req->input));
>   	sgs[num_out + num_in++] = &inhdr;
>   
> -	err = virtqueue_add_sgs(vcrypto->ctrl_vq, sgs, num_out,
> -				num_in, vcrypto, GFP_ATOMIC);
> -	if (err < 0) {
> -		spin_unlock(&vcrypto->ctrl_lock);
> -		kfree_sensitive(cipher_key);
> -		return err;
> -	}
> -	virtqueue_kick(vcrypto->ctrl_vq);
> -
> -	/*
> -	 * Trapping into the hypervisor, so the request should be
> -	 * handled immediately.
> -	 */
> -	while (!virtqueue_get_buf(vcrypto->ctrl_vq, &tmp) &&
> -	       !virtqueue_is_broken(vcrypto->ctrl_vq))
> -		cpu_relax();
> +	err = virtio_crypto_ctrl_vq_request(vcrypto, sgs, num_out, num_in, vc_ctrl_req);
> +	if (err < 0)
> +		goto out;
>   
> -	if (le32_to_cpu(vcrypto->input.status) != VIRTIO_CRYPTO_OK) {
> -		spin_unlock(&vcrypto->ctrl_lock);
> +	if (le32_to_cpu(vc_ctrl_req->input.status) != VIRTIO_CRYPTO_OK) {
>   		pr_err("virtio_crypto: Create session failed status: %u\n",
> -			le32_to_cpu(vcrypto->input.status));
> -		kfree_sensitive(cipher_key);
> -		return -EINVAL;
> +			le32_to_cpu(vc_ctrl_req->input.status));
> +		err = -EINVAL;
> +		goto out;
>   	}
>   
>   	if (encrypt)
>   		ctx->enc_sess_info.session_id =
> -			le64_to_cpu(vcrypto->input.session_id);
> +			le64_to_cpu(vc_ctrl_req->input.session_id);
>   	else
>   		ctx->dec_sess_info.session_id =
> -			le64_to_cpu(vcrypto->input.session_id);
> -
> -	spin_unlock(&vcrypto->ctrl_lock);
> +			le64_to_cpu(vc_ctrl_req->input.session_id);
>   
> +	err = 0;
> +out:
> +	kfree(vc_ctrl_req);
>   	kfree_sensitive(cipher_key);
> -	return 0;
> +
> +	return err;
>   }
>   
>   static int virtio_crypto_alg_skcipher_close_session(
> @@ -206,21 +198,24 @@ static int virtio_crypto_alg_skcipher_close_session(
>   		int encrypt)
>   {
>   	struct scatterlist outhdr, status_sg, *sgs[2];
> -	unsigned int tmp;
>   	struct virtio_crypto_destroy_session_req *destroy_session;
>   	struct virtio_crypto *vcrypto = ctx->vcrypto;
>   	int err;
>   	unsigned int num_out = 0, num_in = 0;
> +	struct virtio_crypto_ctrl_request *vc_ctrl_req;
> +	struct virtio_crypto_ctrl_header *header;
> +
> +	vc_ctrl_req = kzalloc(sizeof(*vc_ctrl_req), GFP_KERNEL);
> +	if (!vc_ctrl_req)
> +		return -ENOMEM;
>   
> -	spin_lock(&vcrypto->ctrl_lock);
> -	vcrypto->ctrl_status.status = VIRTIO_CRYPTO_ERR;
>   	/* Pad ctrl header */
> -	vcrypto->ctrl.header.opcode =
> -		cpu_to_le32(VIRTIO_CRYPTO_CIPHER_DESTROY_SESSION);
> +	header = &vc_ctrl_req->ctrl.header;
> +	header->opcode = cpu_to_le32(VIRTIO_CRYPTO_CIPHER_DESTROY_SESSION);
>   	/* Set the default virtqueue id to 0 */
> -	vcrypto->ctrl.header.queue_id = 0;
> +	header->queue_id = 0;
>   
> -	destroy_session = &vcrypto->ctrl.u.destroy_session;
> +	destroy_session = &vc_ctrl_req->ctrl.u.destroy_session;
>   
>   	if (encrypt)
>   		destroy_session->session_id =
> @@ -229,37 +224,33 @@ static int virtio_crypto_alg_skcipher_close_session(
>   		destroy_session->session_id =
>   			cpu_to_le64(ctx->dec_sess_info.session_id);
>   
> -	sg_init_one(&outhdr, &vcrypto->ctrl, sizeof(vcrypto->ctrl));
> +	sg_init_one(&outhdr, &vc_ctrl_req->ctrl, sizeof(vc_ctrl_req->ctrl));
>   	sgs[num_out++] = &outhdr;
>   
>   	/* Return status and session id back */
> -	sg_init_one(&status_sg, &vcrypto->ctrl_status.status,
> -		sizeof(vcrypto->ctrl_status.status));
> +	vc_ctrl_req->ctrl_status.status = VIRTIO_CRYPTO_ERR;
> +	sg_init_one(&status_sg, &vc_ctrl_req->ctrl_status.status,
> +		sizeof(vc_ctrl_req->ctrl_status.status));
>   	sgs[num_out + num_in++] = &status_sg;
>   
> -	err = virtqueue_add_sgs(vcrypto->ctrl_vq, sgs, num_out,
> -			num_in, vcrypto, GFP_ATOMIC);
> -	if (err < 0) {
> -		spin_unlock(&vcrypto->ctrl_lock);
> -		return err;
> -	}
> -	virtqueue_kick(vcrypto->ctrl_vq);
> -
> -	while (!virtqueue_get_buf(vcrypto->ctrl_vq, &tmp) &&
> -	       !virtqueue_is_broken(vcrypto->ctrl_vq))
> -		cpu_relax();
> +	err = virtio_crypto_ctrl_vq_request(vcrypto, sgs, num_out, num_in, vc_ctrl_req);
> +	if (err < 0)
> +		goto out;
>   
> -	if (vcrypto->ctrl_status.status != VIRTIO_CRYPTO_OK) {
> -		spin_unlock(&vcrypto->ctrl_lock);
> +	if (vc_ctrl_req->ctrl_status.status != VIRTIO_CRYPTO_OK) {
>   		pr_err("virtio_crypto: Close session failed status: %u, session_id: 0x%llx\n",
> -			vcrypto->ctrl_status.status,
> +			vc_ctrl_req->ctrl_status.status,
>   			destroy_session->session_id);
>   
> -		return -EINVAL;
> +		err = -EINVAL;
> +		goto out;
>   	}
> -	spin_unlock(&vcrypto->ctrl_lock);
>   
> -	return 0;
> +	err = 0;
> +out:
> +	kfree(vc_ctrl_req);
> +
> +	return err;
>   }
>   
>   static int virtio_crypto_alg_skcipher_init_sessions(

