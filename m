Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2657151D3E4
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 11:00:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390319AbiEFJDV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 6 May 2022 05:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390326AbiEFJDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 05:03:13 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7906863519;
        Fri,  6 May 2022 01:59:30 -0700 (PDT)
Received: from kwepemi100014.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KvkxV3RFwzfbK0;
        Fri,  6 May 2022 16:58:22 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 kwepemi100014.china.huawei.com (7.221.188.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 6 May 2022 16:59:28 +0800
Received: from dggpemm500006.china.huawei.com ([7.185.36.236]) by
 dggpemm500006.china.huawei.com ([7.185.36.236]) with mapi id 15.01.2375.024;
 Fri, 6 May 2022 16:59:27 +0800
From:   "Gonglei (Arei)" <arei.gonglei@huawei.com>
To:     zhenwei pi <pizhenwei@bytedance.com>,
        "mst@redhat.com" <mst@redhat.com>
CC:     "jasowang@redhat.com" <jasowang@redhat.com>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "helei.sig11@bytedance.com" <helei.sig11@bytedance.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: RE: [PATCH v5 2/5] virtio-crypto: use private buffer for control
 request
Thread-Topic: [PATCH v5 2/5] virtio-crypto: use private buffer for control
 request
Thread-Index: AQHYYGJ2tIXH1Yy/2EmNsqtpgpAmaK0RjkgQ
Date:   Fri, 6 May 2022 08:59:27 +0000
Message-ID: <7862f80e5cc440b8be1983c911b15ec9@huawei.com>
References: <20220505092408.53692-1-pizhenwei@bytedance.com>
 <20220505092408.53692-3-pizhenwei@bytedance.com>
In-Reply-To: <20220505092408.53692-3-pizhenwei@bytedance.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.149.11]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: zhenwei pi [mailto:pizhenwei@bytedance.com]
> Sent: Thursday, May 5, 2022 5:24 PM
> To: Gonglei (Arei) <arei.gonglei@huawei.com>; mst@redhat.com
> Cc: jasowang@redhat.com; herbert@gondor.apana.org.au;
> linux-kernel@vger.kernel.org; virtualization@lists.linux-foundation.org;
> linux-crypto@vger.kernel.org; helei.sig11@bytedance.com;
> pizhenwei@bytedance.com; davem@davemloft.net; kernel test robot
> <lkp@intel.com>; Dan Carpenter <dan.carpenter@oracle.com>
> Subject: [PATCH v5 2/5] virtio-crypto: use private buffer for control request
> 
> Originally, all of the control requests share a single buffer( ctrl & input &
> ctrl_status fields in struct virtio_crypto), this allows queue depth 1 only, the
> performance of control queue gets limited by this design.
> 
> In this patch, each request allocates request buffer dynamically, and free buffer
> after request, so the scope protected by ctrl_lock also get optimized here.
> It's possible to optimize control queue depth in the next step.
> 
> A necessary comment is already in code, still describe it again:
> /*
>  * Note: there are padding fields in request, clear them to zero before
>  * sending to host to avoid to divulge any information.
>  * Ex, virtio_crypto_ctrl_request::ctrl::u::destroy_session::padding[48]
>  */
> So use kzalloc to allocate buffer of struct virtio_crypto_ctrl_request.
> 
> Potentially dereferencing uninitialized variables:
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Gonglei <arei.gonglei@huawei.com>
> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
> ---
>  .../virtio/virtio_crypto_akcipher_algs.c      | 57 ++++++++++++-------
>  drivers/crypto/virtio/virtio_crypto_common.h  | 17 ++++--
>  .../virtio/virtio_crypto_skcipher_algs.c      | 50 ++++++++++------
>  3 files changed, 79 insertions(+), 45 deletions(-)
> 

Reviewed-by: Gonglei <arei.gonglei@huawei.com>

Regards,
-Gonglei 

> diff --git a/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
> b/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
> index 20901a263fc8..698ea57e2649 100644
> --- a/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
> +++ b/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
> @@ -108,16 +108,22 @@ static int
> virtio_crypto_alg_akcipher_init_session(struct virtio_crypto_akcipher
>  	unsigned int num_out = 0, num_in = 0;
>  	struct virtio_crypto_op_ctrl_req *ctrl;
>  	struct virtio_crypto_session_input *input;
> +	struct virtio_crypto_ctrl_request *vc_ctrl_req;
> 
>  	pkey = kmemdup(key, keylen, GFP_ATOMIC);
>  	if (!pkey)
>  		return -ENOMEM;
> 
> -	spin_lock(&vcrypto->ctrl_lock);
> -	ctrl = &vcrypto->ctrl;
> +	vc_ctrl_req = kzalloc(sizeof(*vc_ctrl_req), GFP_KERNEL);
> +	if (!vc_ctrl_req) {
> +		err = -ENOMEM;
> +		goto out;
> +	}
> +
> +	ctrl = &vc_ctrl_req->ctrl;
>  	memcpy(&ctrl->header, header, sizeof(ctrl->header));
>  	memcpy(&ctrl->u, para, sizeof(ctrl->u));
> -	input = &vcrypto->input;
> +	input = &vc_ctrl_req->input;
>  	input->status = cpu_to_le32(VIRTIO_CRYPTO_ERR);
> 
>  	sg_init_one(&outhdr_sg, ctrl, sizeof(*ctrl)); @@ -129,16 +135,22 @@
> static int virtio_crypto_alg_akcipher_init_session(struct virtio_crypto_akcipher
>  	sg_init_one(&inhdr_sg, input, sizeof(*input));
>  	sgs[num_out + num_in++] = &inhdr_sg;
> 
> +	spin_lock(&vcrypto->ctrl_lock);
>  	err = virtqueue_add_sgs(vcrypto->ctrl_vq, sgs, num_out, num_in, vcrypto,
> GFP_ATOMIC);
> -	if (err < 0)
> +	if (err < 0) {
> +		spin_unlock(&vcrypto->ctrl_lock);
>  		goto out;
> +	}
> 
>  	virtqueue_kick(vcrypto->ctrl_vq);
>  	while (!virtqueue_get_buf(vcrypto->ctrl_vq, &inlen) &&
>  	       !virtqueue_is_broken(vcrypto->ctrl_vq))
>  		cpu_relax();
> +	spin_unlock(&vcrypto->ctrl_lock);
> 
>  	if (le32_to_cpu(input->status) != VIRTIO_CRYPTO_OK) {
> +		pr_err("virtio_crypto: Create session failed status: %u\n",
> +			le32_to_cpu(input->status));
>  		err = -EINVAL;
>  		goto out;
>  	}
> @@ -148,13 +160,9 @@ static int
> virtio_crypto_alg_akcipher_init_session(struct virtio_crypto_akcipher
>  	err = 0;
> 
>  out:
> -	spin_unlock(&vcrypto->ctrl_lock);
> +	kfree(vc_ctrl_req);
>  	kfree_sensitive(pkey);
> 
> -	if (err < 0)
> -		pr_err("virtio_crypto: Create session failed status: %u\n",
> -			le32_to_cpu(input->status));
> -
>  	return err;
>  }
> 
> @@ -167,15 +175,18 @@ static int
> virtio_crypto_alg_akcipher_close_session(struct virtio_crypto_akciphe
>  	int err;
>  	struct virtio_crypto_op_ctrl_req *ctrl;
>  	struct virtio_crypto_inhdr *ctrl_status;
> +	struct virtio_crypto_ctrl_request *vc_ctrl_req;
> 
> -	spin_lock(&vcrypto->ctrl_lock);
> -	if (!ctx->session_valid) {
> -		err = 0;
> -		goto out;
> -	}
> -	ctrl_status = &vcrypto->ctrl_status;
> +	if (!ctx->session_valid)
> +		return 0;
> +
> +	vc_ctrl_req = kzalloc(sizeof(*vc_ctrl_req), GFP_KERNEL);
> +	if (!vc_ctrl_req)
> +		return -ENOMEM;
> +
> +	ctrl_status = &vc_ctrl_req->ctrl_status;
>  	ctrl_status->status = VIRTIO_CRYPTO_ERR;
> -	ctrl = &vcrypto->ctrl;
> +	ctrl = &vc_ctrl_req->ctrl;
>  	ctrl->header.opcode =
> cpu_to_le32(VIRTIO_CRYPTO_AKCIPHER_DESTROY_SESSION);
>  	ctrl->header.queue_id = 0;
> 
> @@ -188,16 +199,22 @@ static int
> virtio_crypto_alg_akcipher_close_session(struct virtio_crypto_akciphe
>  	sg_init_one(&inhdr_sg, &ctrl_status->status, sizeof(ctrl_status->status));
>  	sgs[num_out + num_in++] = &inhdr_sg;
> 
> +	spin_lock(&vcrypto->ctrl_lock);
>  	err = virtqueue_add_sgs(vcrypto->ctrl_vq, sgs, num_out, num_in, vcrypto,
> GFP_ATOMIC);
> -	if (err < 0)
> +	if (err < 0) {
> +		spin_unlock(&vcrypto->ctrl_lock);
>  		goto out;
> +	}
> 
>  	virtqueue_kick(vcrypto->ctrl_vq);
>  	while (!virtqueue_get_buf(vcrypto->ctrl_vq, &inlen) &&
>  	       !virtqueue_is_broken(vcrypto->ctrl_vq))
>  		cpu_relax();
> +	spin_unlock(&vcrypto->ctrl_lock);
> 
>  	if (ctrl_status->status != VIRTIO_CRYPTO_OK) {
> +		pr_err("virtio_crypto: Close session failed status: %u, session_id:
> 0x%llx\n",
> +			ctrl_status->status, destroy_session->session_id);
>  		err = -EINVAL;
>  		goto out;
>  	}
> @@ -206,11 +223,7 @@ static int
> virtio_crypto_alg_akcipher_close_session(struct virtio_crypto_akciphe
>  	ctx->session_valid = false;
> 
>  out:
> -	spin_unlock(&vcrypto->ctrl_lock);
> -	if (err < 0) {
> -		pr_err("virtio_crypto: Close session failed status: %u, session_id:
> 0x%llx\n",
> -			ctrl_status->status, destroy_session->session_id);
> -	}
> +	kfree(vc_ctrl_req);
> 
>  	return err;
>  }
> diff --git a/drivers/crypto/virtio/virtio_crypto_common.h
> b/drivers/crypto/virtio/virtio_crypto_common.h
> index e693d4ee83a6..2422237ec4e6 100644
> --- a/drivers/crypto/virtio/virtio_crypto_common.h
> +++ b/drivers/crypto/virtio/virtio_crypto_common.h
> @@ -13,6 +13,7 @@
>  #include <crypto/aead.h>
>  #include <crypto/aes.h>
>  #include <crypto/engine.h>
> +#include <uapi/linux/virtio_crypto.h>
> 
> 
>  /* Internal representation of a data virtqueue */ @@ -65,11 +66,6 @@ struct
> virtio_crypto {
>  	/* Maximum size of per request */
>  	u64 max_size;
> 
> -	/* Control VQ buffers: protected by the ctrl_lock */
> -	struct virtio_crypto_op_ctrl_req ctrl;
> -	struct virtio_crypto_session_input input;
> -	struct virtio_crypto_inhdr ctrl_status;
> -
>  	unsigned long status;
>  	atomic_t ref_count;
>  	struct list_head list;
> @@ -85,6 +81,17 @@ struct virtio_crypto_sym_session_info {
>  	__u64 session_id;
>  };
> 
> +/*
> + * Note: there are padding fields in request, clear them to zero before
> + *       sending to host to avoid to divulge any information.
> + * Ex,
> +virtio_crypto_ctrl_request::ctrl::u::destroy_session::padding[48]
> + */
> +struct virtio_crypto_ctrl_request {
> +	struct virtio_crypto_op_ctrl_req ctrl;
> +	struct virtio_crypto_session_input input;
> +	struct virtio_crypto_inhdr ctrl_status; };
> +
>  struct virtio_crypto_request;
>  typedef void (*virtio_crypto_data_callback)
>  		(struct virtio_crypto_request *vc_req, int len); diff --git
> a/drivers/crypto/virtio/virtio_crypto_skcipher_algs.c
> b/drivers/crypto/virtio/virtio_crypto_skcipher_algs.c
> index e3c5bc8d6112..6aaf0869b211 100644
> --- a/drivers/crypto/virtio/virtio_crypto_skcipher_algs.c
> +++ b/drivers/crypto/virtio/virtio_crypto_skcipher_algs.c
> @@ -126,6 +126,7 @@ static int virtio_crypto_alg_skcipher_init_session(
>  	struct virtio_crypto_op_ctrl_req *ctrl;
>  	struct virtio_crypto_session_input *input;
>  	struct virtio_crypto_sym_create_session_req *sym_create_session;
> +	struct virtio_crypto_ctrl_request *vc_ctrl_req;
> 
>  	/*
>  	 * Avoid to do DMA from the stack, switch to using @@ -136,15 +137,20
> @@ static int virtio_crypto_alg_skcipher_init_session(
>  	if (!cipher_key)
>  		return -ENOMEM;
> 
> -	spin_lock(&vcrypto->ctrl_lock);
> +	vc_ctrl_req = kzalloc(sizeof(*vc_ctrl_req), GFP_KERNEL);
> +	if (!vc_ctrl_req) {
> +		err = -ENOMEM;
> +		goto out;
> +	}
> +
>  	/* Pad ctrl header */
> -	ctrl = &vcrypto->ctrl;
> +	ctrl = &vc_ctrl_req->ctrl;
>  	ctrl->header.opcode =
> cpu_to_le32(VIRTIO_CRYPTO_CIPHER_CREATE_SESSION);
>  	ctrl->header.algo = cpu_to_le32(alg);
>  	/* Set the default dataqueue id to 0 */
>  	ctrl->header.queue_id = 0;
> 
> -	input = &vcrypto->input;
> +	input = &vc_ctrl_req->input;
>  	input->status = cpu_to_le32(VIRTIO_CRYPTO_ERR);
>  	/* Pad cipher's parameters */
>  	sym_create_session = &ctrl->u.sym_create_session; @@ -164,12
> +170,12 @@ static int virtio_crypto_alg_skcipher_init_session(
>  	sg_init_one(&inhdr, input, sizeof(*input));
>  	sgs[num_out + num_in++] = &inhdr;
> 
> +	spin_lock(&vcrypto->ctrl_lock);
>  	err = virtqueue_add_sgs(vcrypto->ctrl_vq, sgs, num_out,
>  				num_in, vcrypto, GFP_ATOMIC);
>  	if (err < 0) {
>  		spin_unlock(&vcrypto->ctrl_lock);
> -		kfree_sensitive(cipher_key);
> -		return err;
> +		goto out;
>  	}
>  	virtqueue_kick(vcrypto->ctrl_vq);
> 
> @@ -180,13 +186,13 @@ static int virtio_crypto_alg_skcipher_init_session(
>  	while (!virtqueue_get_buf(vcrypto->ctrl_vq, &tmp) &&
>  	       !virtqueue_is_broken(vcrypto->ctrl_vq))
>  		cpu_relax();
> +	spin_unlock(&vcrypto->ctrl_lock);
> 
>  	if (le32_to_cpu(input->status) != VIRTIO_CRYPTO_OK) {
> -		spin_unlock(&vcrypto->ctrl_lock);
>  		pr_err("virtio_crypto: Create session failed status: %u\n",
>  			le32_to_cpu(input->status));
> -		kfree_sensitive(cipher_key);
> -		return -EINVAL;
> +		err = -EINVAL;
> +		goto out;
>  	}
> 
>  	if (encrypt)
> @@ -194,10 +200,11 @@ static int virtio_crypto_alg_skcipher_init_session(
>  	else
>  		ctx->dec_sess_info.session_id = le64_to_cpu(input->session_id);
> 
> -	spin_unlock(&vcrypto->ctrl_lock);
> -
> +	err = 0;
> +out:
> +	kfree(vc_ctrl_req);
>  	kfree_sensitive(cipher_key);
> -	return 0;
> +	return err;
>  }
> 
>  static int virtio_crypto_alg_skcipher_close_session(
> @@ -212,12 +219,16 @@ static int virtio_crypto_alg_skcipher_close_session(
>  	unsigned int num_out = 0, num_in = 0;
>  	struct virtio_crypto_op_ctrl_req *ctrl;
>  	struct virtio_crypto_inhdr *ctrl_status;
> +	struct virtio_crypto_ctrl_request *vc_ctrl_req;
> 
> -	spin_lock(&vcrypto->ctrl_lock);
> -	ctrl_status = &vcrypto->ctrl_status;
> +	vc_ctrl_req = kzalloc(sizeof(*vc_ctrl_req), GFP_KERNEL);
> +	if (!vc_ctrl_req)
> +		return -ENOMEM;
> +
> +	ctrl_status = &vc_ctrl_req->ctrl_status;
>  	ctrl_status->status = VIRTIO_CRYPTO_ERR;
>  	/* Pad ctrl header */
> -	ctrl = &vcrypto->ctrl;
> +	ctrl = &vc_ctrl_req->ctrl;
>  	ctrl->header.opcode =
> cpu_to_le32(VIRTIO_CRYPTO_CIPHER_DESTROY_SESSION);
>  	/* Set the default virtqueue id to 0 */
>  	ctrl->header.queue_id = 0;
> @@ -236,28 +247,31 @@ static int virtio_crypto_alg_skcipher_close_session(
>  	sg_init_one(&status_sg, &ctrl_status->status,
> sizeof(ctrl_status->status));
>  	sgs[num_out + num_in++] = &status_sg;
> 
> +	spin_lock(&vcrypto->ctrl_lock);
>  	err = virtqueue_add_sgs(vcrypto->ctrl_vq, sgs, num_out,
>  			num_in, vcrypto, GFP_ATOMIC);
>  	if (err < 0) {
>  		spin_unlock(&vcrypto->ctrl_lock);
> -		return err;
> +		goto out;
>  	}
>  	virtqueue_kick(vcrypto->ctrl_vq);
> 
>  	while (!virtqueue_get_buf(vcrypto->ctrl_vq, &tmp) &&
>  	       !virtqueue_is_broken(vcrypto->ctrl_vq))
>  		cpu_relax();
> +	spin_unlock(&vcrypto->ctrl_lock);
> 
>  	if (ctrl_status->status != VIRTIO_CRYPTO_OK) {
> -		spin_unlock(&vcrypto->ctrl_lock);
>  		pr_err("virtio_crypto: Close session failed status: %u, session_id:
> 0x%llx\n",
>  			ctrl_status->status, destroy_session->session_id);
> 
>  		return -EINVAL;
>  	}
> -	spin_unlock(&vcrypto->ctrl_lock);
> 
> -	return 0;
> +	err = 0;
> +out:
> +	kfree(vc_ctrl_req);
> +	return err;
>  }
> 
>  static int virtio_crypto_alg_skcipher_init_sessions(
> --
> 2.20.1

