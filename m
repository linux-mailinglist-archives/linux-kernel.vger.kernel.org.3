Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 729A0507FAA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 05:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359268AbiDTDft (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 23:35:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239413AbiDTDfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 23:35:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B0AC01EECD
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 20:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650425576;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fmkZ9VuJgfsEck212kRbHSlZca3ND4du4JlP1Q+lMT8=;
        b=E5P7IwCoUslouIk1d4Vv3HJM7rpgHH6Hm1wNbO+MgHBvIjLbfSsroHISoAMJdg6D7uiW2k
        x12hOTeL7uXv30em+zl1qK+7Qng8DdUcoZrom3pz/LveYSh4/uPkgHv+6/sPxrDDsOpvRi
        rj/Y6Ze2kytHU7X7m/WwIg8pyS8Xra0=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-592-i8TVWLZBOSCXNZgCHDgLSQ-1; Tue, 19 Apr 2022 23:32:55 -0400
X-MC-Unique: i8TVWLZBOSCXNZgCHDgLSQ-1
Received: by mail-pj1-f69.google.com with SMTP id t24-20020a17090a449800b001d2d6e740c3so2119138pjg.9
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 20:32:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=fmkZ9VuJgfsEck212kRbHSlZca3ND4du4JlP1Q+lMT8=;
        b=oSCzXLjJVTUZaZjiK0CVy+tDa0dgZq8ek5f2FVy+o7D1Ydou3e0Mkw/hDstFXDkLUg
         gPpXZp8xTLJG3MpK61IGGSFTimfkwWi/fpSSi17+8KVvftUEZ2eQzZRiMZdSfrccC8y5
         a7huyqdDJanvNevg0swIcMPg13cHQjslP9PVXCOLP/ebxJc2gXTFF2wfDumDxtFz8DKn
         3NIn5S0sHznDeyMByABjGmTwGUVSAZmyTgw851Dix0+yzBO/d2SrdbDEt63dTZCYETPf
         LATtsKQPD9mKBSgTGYvieMt4CBBvVu24uT6V0RyA8zF5b0nf6ZSWtWEKXlUK9NRXFJpo
         tPsQ==
X-Gm-Message-State: AOAM530A6vKb9ABfu+uh72jHH4LJDqLibezc0l6oQ6dB4lJezGVIn2sD
        7mGWcRLSjp7hTH8JZc0UYRpi79PVvZSrI27Nhmdmlex5uToIZkZ2wbUBdzEfgY8DG7jPK02E2ov
        i1bDEWVsJ7weW8SiaEs0gzL5w
X-Received: by 2002:a17:90a:df8f:b0:1ce:88eb:443c with SMTP id p15-20020a17090adf8f00b001ce88eb443cmr2033961pjv.25.1650425573734;
        Tue, 19 Apr 2022 20:32:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxHNjIh51MsI0LBWK+QwJxWr1Nb71+TL8g9nNpRLppU/ULXxgTDuUUtSnQ+M2YNOi3CPuqoMQ==
X-Received: by 2002:a17:90a:df8f:b0:1ce:88eb:443c with SMTP id p15-20020a17090adf8f00b001ce88eb443cmr2033940pjv.25.1650425573342;
        Tue, 19 Apr 2022 20:32:53 -0700 (PDT)
Received: from [10.72.14.13] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id s7-20020aa78bc7000000b005082ddeb6f8sm18066651pfd.199.2022.04.19.20.32.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Apr 2022 20:32:52 -0700 (PDT)
Message-ID: <af8cff9b-13fd-a591-df88-0abcee083d0e@redhat.com>
Date:   Wed, 20 Apr 2022 11:32:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.0
Subject: Re: [PATCH v2 1/4] virtio-crypto: wait ctrl queue instead of busy
 polling
Content-Language: en-US
To:     zhenwei pi <pizhenwei@bytedance.com>, arei.gonglei@huawei.com,
        mst@redhat.com
Cc:     herbert@gondor.apana.org.au, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-crypto@vger.kernel.org, helei.sig11@bytedance.com,
        davem@davemloft.net
References: <20220418090051.372803-1-pizhenwei@bytedance.com>
 <20220418090051.372803-2-pizhenwei@bytedance.com>
From:   Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220418090051.372803-2-pizhenwei@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2022/4/18 17:00, zhenwei pi 写道:
> Originally, after submitting request into virtio crypto control
> queue, the guest side polls the result from the virt queue. This
> allows all of the requests share a single request buffer in
> struct virtio_crypto(ctrl&input&ctrl_status).
>      CPU0   CPU1               ...             CPUx  CPUy
>       |      |                                  |     |
>       \      \                                  /     /
>        \--------spin_lock(&vcrypto->ctrl_lock)-------/
>                             |
>                   virtqueue add & kick
>                             |
>                    busy poll virtqueue
>                             |
>                spin_unlock(&vcrypto->ctrl_lock)
>                            ...
>
> There are two problems:
> 1, The queue depth is always 1, the performance of a virtio crypto
>     device gets limited. Multi user processes share a single control
>     queue, and hit spin lock race from control queue. Test on Intel
>     Platinum 8260, a single worker gets ~35K/s create/close session
>     operations, and 8 workers get ~40K/s operations with 800% CPU
>     utilization.
> 2, The control request is supposed to get handled immediately, but
>     in the current implementation of QEMU(v6.2), the vCPU thread kicks
>     another thread to do this work, the latency also gets unstable.
>     Tracking latency of virtio_crypto_alg_akcipher_close_session in 5s:
>          usecs               : count     distribution
>           0 -> 1          : 0        |                        |
>           2 -> 3          : 7        |                        |
>           4 -> 7          : 72       |                        |
>           8 -> 15         : 186485   |************************|
>          16 -> 31         : 687      |                        |
>          32 -> 63         : 5        |                        |
>          64 -> 127        : 3        |                        |
>         128 -> 255        : 1        |                        |
>         256 -> 511        : 0        |                        |
>         512 -> 1023       : 0        |                        |
>        1024 -> 2047       : 0        |                        |
>        2048 -> 4095       : 0        |                        |
>        4096 -> 8191       : 0        |                        |
>        8192 -> 16383      : 2        |                        |
>     This means that a CPU may hold vcrypto->ctrl_lock as long as 8192~16383us.
>
> To improve the performance of control queue, remove ctrl&input&ctrl_status from
> struct virtio_crypto, each request allocates request buffer dynamically, waits
> completion instead of busy polling to reduce lock racing, and gets completed by
> control queue callback.


If possible, I would like to split this patch into two:


1) using private buffer

2) remove the busy polling


>      CPU0   CPU1               ...             CPUx  CPUy
>       |      |                                  |     |
>       \      \                                  /     /
>        \--------spin_lock(&vcrypto->ctrl_lock)-------/
>                             |
>                   virtqueue add & kick
>                             |
>        ---------spin_unlock(&vcrypto->ctrl_lock)------
>       /      /                                  \     \
>       |      |                                  |     |
>      wait   wait                               wait  wait
>
> Test this patch, the guest side get ~200K/s operations with 300% CPU
> utilization.


What's more, this could be part of the hardening since it help to reduce 
the possibility of DOS from the buggy device. I think we need to avoid 
busy polling for all ctrl virtqueues (e.g the one in the virtio-net).

Thanks


>
> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
> ---
>   drivers/crypto/virtio/Makefile                |   1 +
>   .../virtio/virtio_crypto_akcipher_algs.c      |  90 ++++++------
>   drivers/crypto/virtio/virtio_crypto_common.c  |  61 ++++++++
>   drivers/crypto/virtio/virtio_crypto_common.h  |  25 +++-
>   drivers/crypto/virtio/virtio_crypto_core.c    |   2 +-
>   .../virtio/virtio_crypto_skcipher_algs.c      | 133 ++++++++----------
>   6 files changed, 185 insertions(+), 127 deletions(-)
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
> +	sg_init_one(&inhdr_sg, &vc_ctrl_req->input, sizeof(vc_ctrl_req->input));
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
> -	if (le32_to_cpu(vcrypto->input.status) != VIRTIO_CRYPTO_OK) {
> +	if (le32_to_cpu(vc_ctrl_req->input.status) != VIRTIO_CRYPTO_OK) {
> +		pr_err("virtio_crypto: Create session failed status: %u\n",
> +			le32_to_cpu(vc_ctrl_req->input.status));
>   		err = -EINVAL;
>   		goto out;
>   	}
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
>   	if (!src_buf)
>   		goto err;
>   
> @@ -243,7 +233,7 @@ static int __virtio_crypto_akcipher_do_req(struct virtio_crypto_akcipher_request
>   		sgs[num_out++] = &srcdata_sg;
>   
>   		/* dst data */
> -		dst_buf = kcalloc_node(req->dst_len, 1, GFP_KERNEL, node);
> +		dst_buf = kcalloc(req->dst_len, 1, GFP_KERNEL);
>   		if (!dst_buf)
>   			goto err;
>   
> diff --git a/drivers/crypto/virtio/virtio_crypto_common.c b/drivers/crypto/virtio/virtio_crypto_common.c
> new file mode 100644
> index 000000000000..93df73c40dd3
> --- /dev/null
> +++ b/drivers/crypto/virtio/virtio_crypto_common.c
> @@ -0,0 +1,61 @@
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
> +static void virtio_crypto_ctrlq_callback(struct virtio_crypto_ctrl_request *vc_ctrl_req)
> +{
> +	complete(&vc_ctrl_req->compl);
> +}
> +
> +int virtio_crypto_ctrl_vq_request(struct virtio_crypto *vcrypto, struct scatterlist *sgs[],
> +				  unsigned int out_sgs, unsigned int in_sgs,
> +				  struct virtio_crypto_ctrl_request *vc_ctrl_req)
> +{
> +	int err;
> +	unsigned long flags;
> +
> +	init_completion(&vc_ctrl_req->compl);
> +	vc_ctrl_req->ctrl_cb =  virtio_crypto_ctrlq_callback;
> +
> +	spin_lock_irqsave(&vcrypto->ctrl_lock, flags);
> +	err = virtqueue_add_sgs(vcrypto->ctrl_vq, sgs, out_sgs, in_sgs, vc_ctrl_req, GFP_ATOMIC);
> +	if (err < 0) {
> +		spin_unlock_irqrestore(&vcrypto->ctrl_lock, flags);
> +		return err;
> +	}
> +
> +	virtqueue_kick(vcrypto->ctrl_vq);
> +	spin_unlock_irqrestore(&vcrypto->ctrl_lock, flags);
> +
> +	wait_for_completion(&vc_ctrl_req->compl);
> +
> +	return 0;
> +}
> +
> +void virtcrypto_ctrlq_callback(struct virtqueue *vq)
> +{
> +	struct virtio_crypto *vcrypto = vq->vdev->priv;
> +	struct virtio_crypto_ctrl_request *vc_ctrl_req;
> +	unsigned long flags;
> +	unsigned int len;
> +
> +	spin_lock_irqsave(&vcrypto->ctrl_lock, flags);
> +	do {
> +		virtqueue_disable_cb(vq);
> +		while ((vc_ctrl_req = virtqueue_get_buf(vq, &len)) != NULL) {
> +			spin_unlock_irqrestore(&vcrypto->ctrl_lock, flags);
> +			if (vc_ctrl_req->ctrl_cb)
> +				vc_ctrl_req->ctrl_cb(vc_ctrl_req);
> +			spin_lock_irqsave(&vcrypto->ctrl_lock, flags);
> +		}
> +		if (unlikely(virtqueue_is_broken(vq)))
> +			break;
> +	} while (!virtqueue_enable_cb(vq));
> +	spin_unlock_irqrestore(&vcrypto->ctrl_lock, flags);
> +}
> diff --git a/drivers/crypto/virtio/virtio_crypto_common.h b/drivers/crypto/virtio/virtio_crypto_common.h
> index e693d4ee83a6..b90ac0ce30d2 100644
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
> @@ -85,6 +81,20 @@ struct virtio_crypto_sym_session_info {
>   	__u64 session_id;
>   };
>   
> +struct virtio_crypto_ctrl_request;
> +typedef void (*virtio_crypto_ctrl_callback)
> +		(struct virtio_crypto_ctrl_request *vc_ctrl_req);
> +
> +/* Note: there are padding fields in request, clear them to zero before sending to host,
> + * Ex, virtio_crypto_ctrl_request::ctrl::u::destroy_session::padding[48] */
> +struct virtio_crypto_ctrl_request {
> +	struct virtio_crypto_op_ctrl_req ctrl;
> +	struct virtio_crypto_session_input input;
> +	struct virtio_crypto_inhdr ctrl_status;
> +	virtio_crypto_ctrl_callback ctrl_cb;
> +	struct completion compl;
> +};
> +
>   struct virtio_crypto_request;
>   typedef void (*virtio_crypto_data_callback)
>   		(struct virtio_crypto_request *vc_req, int len);
> @@ -135,4 +145,9 @@ void virtio_crypto_skcipher_algs_unregister(struct virtio_crypto *vcrypto);
>   int virtio_crypto_akcipher_algs_register(struct virtio_crypto *vcrypto);
>   void virtio_crypto_akcipher_algs_unregister(struct virtio_crypto *vcrypto);
>   
> +void virtcrypto_ctrlq_callback(struct virtqueue *vq);
> +int virtio_crypto_ctrl_vq_request(struct virtio_crypto *vcrypto, struct scatterlist *sgs[],
> +				  unsigned int out_sgs, unsigned int in_sgs,
> +				  struct virtio_crypto_ctrl_request *vc_ctrl_req);
> +
>   #endif /* _VIRTIO_CRYPTO_COMMON_H */
> diff --git a/drivers/crypto/virtio/virtio_crypto_core.c b/drivers/crypto/virtio/virtio_crypto_core.c
> index c6f482db0bc0..e668d4b1bc6a 100644
> --- a/drivers/crypto/virtio/virtio_crypto_core.c
> +++ b/drivers/crypto/virtio/virtio_crypto_core.c
> @@ -73,7 +73,7 @@ static int virtcrypto_find_vqs(struct virtio_crypto *vi)
>   		goto err_names;
>   
>   	/* Parameters for control virtqueue */
> -	callbacks[total_vqs - 1] = NULL;
> +	callbacks[total_vqs - 1] = virtcrypto_ctrlq_callback;
>   	names[total_vqs - 1] = "controlq";
>   
>   	/* Allocate/initialize parameters for data virtqueues */
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

