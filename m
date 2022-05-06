Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E524D51D455
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 11:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390472AbiEFJaO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 6 May 2022 05:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240072AbiEFJaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 05:30:08 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBE1D64BC3;
        Fri,  6 May 2022 02:26:25 -0700 (PDT)
Received: from kwepemi100011.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KvlVg205nzGpPT;
        Fri,  6 May 2022 17:23:39 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 kwepemi100011.china.huawei.com (7.221.188.134) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 6 May 2022 17:26:23 +0800
Received: from dggpemm500006.china.huawei.com ([7.185.36.236]) by
 dggpemm500006.china.huawei.com ([7.185.36.236]) with mapi id 15.01.2375.024;
 Fri, 6 May 2022 17:26:23 +0800
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
        "davem@davemloft.net" <davem@davemloft.net>
Subject: RE: [PATCH v5 3/5] virtio-crypto: wait ctrl queue instead of busy
 polling
Thread-Topic: [PATCH v5 3/5] virtio-crypto: wait ctrl queue instead of busy
 polling
Thread-Index: AQHYYGJ3j3V9/tMOWkSHO0wnVUQtWq0RldRg
Date:   Fri, 6 May 2022 09:26:23 +0000
Message-ID: <a65d3b24384a4932903bdddbdc5388e6@huawei.com>
References: <20220505092408.53692-1-pizhenwei@bytedance.com>
 <20220505092408.53692-4-pizhenwei@bytedance.com>
In-Reply-To: <20220505092408.53692-4-pizhenwei@bytedance.com>
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
> pizhenwei@bytedance.com; davem@davemloft.net
> Subject: [PATCH v5 3/5] virtio-crypto: wait ctrl queue instead of busy polling
> 
> Originally, after submitting request into virtio crypto control queue, the guest
> side polls the result from the virt queue. This works like following:
>     CPU0   CPU1               ...             CPUx  CPUy
>      |      |                                  |     |
>      \      \                                  /     /
>       \--------spin_lock(&vcrypto->ctrl_lock)-------/
>                            |
>                  virtqueue add & kick
>                            |
>                   busy poll virtqueue
>                            |
>               spin_unlock(&vcrypto->ctrl_lock)
>                           ...
> 
> There are two problems:
> 1, The queue depth is always 1, the performance of a virtio crypto
>    device gets limited. Multi user processes share a single control
>    queue, and hit spin lock race from control queue. Test on Intel
>    Platinum 8260, a single worker gets ~35K/s create/close session
>    operations, and 8 workers get ~40K/s operations with 800% CPU
>    utilization.
> 2, The control request is supposed to get handled immediately, but
>    in the current implementation of QEMU(v6.2), the vCPU thread kicks
>    another thread to do this work, the latency also gets unstable.
>    Tracking latency of virtio_crypto_alg_akcipher_close_session in 5s:
>         usecs               : count     distribution
>          0 -> 1          : 0        |                        |
>          2 -> 3          : 7        |                        |
>          4 -> 7          : 72       |                        |
>          8 -> 15         : 186485   |************************|
>         16 -> 31         : 687      |                        |
>         32 -> 63         : 5        |                        |
>         64 -> 127        : 3        |                        |
>        128 -> 255        : 1        |                        |
>        256 -> 511        : 0        |                        |
>        512 -> 1023       : 0        |                        |
>       1024 -> 2047       : 0        |                        |
>       2048 -> 4095       : 0        |                        |
>       4096 -> 8191       : 0        |                        |
>       8192 -> 16383      : 2        |                        |
> This means that a CPU may hold vcrypto->ctrl_lock as long as 8192~16383us.
> 
> To improve the performance of control queue, a request on control queue waits
> completion instead of busy polling to reduce lock racing, and gets completed by
> control queue callback.
>     CPU0   CPU1               ...             CPUx  CPUy
>      |      |                                  |     |
>      \      \                                  /     /
>       \--------spin_lock(&vcrypto->ctrl_lock)-------/
>                            |
>                  virtqueue add & kick
>                            |
>       ---------spin_unlock(&vcrypto->ctrl_lock)------
>      /      /                                  \     \
>      |      |                                  |     |
>     wait   wait                               wait  wait
> 
> Test this patch, the guest side get ~200K/s operations with 300% CPU
> utilization.
> 
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Gonglei <arei.gonglei@huawei.com>
> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
> ---
>  .../virtio/virtio_crypto_akcipher_algs.c      | 29 ++---------
>  drivers/crypto/virtio/virtio_crypto_common.h  |  4 ++
>  drivers/crypto/virtio/virtio_crypto_core.c    | 52 ++++++++++++++++++-
>  .../virtio/virtio_crypto_skcipher_algs.c      | 34 ++----------
>  4 files changed, 64 insertions(+), 55 deletions(-)
> 

Reviewed-by: Gonglei <arei.gonglei@huawei.com>

Regards,
-Gonglei 

> diff --git a/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
> b/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
> index 698ea57e2649..382ccec9ab12 100644
> --- a/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
> +++ b/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
> @@ -103,7 +103,6 @@ static int
> virtio_crypto_alg_akcipher_init_session(struct virtio_crypto_akcipher
>  	struct scatterlist outhdr_sg, key_sg, inhdr_sg, *sgs[3];
>  	struct virtio_crypto *vcrypto = ctx->vcrypto;
>  	uint8_t *pkey;
> -	unsigned int inlen;
>  	int err;
>  	unsigned int num_out = 0, num_in = 0;
>  	struct virtio_crypto_op_ctrl_req *ctrl; @@ -135,18 +134,9 @@ static int
> virtio_crypto_alg_akcipher_init_session(struct virtio_crypto_akcipher
>  	sg_init_one(&inhdr_sg, input, sizeof(*input));
>  	sgs[num_out + num_in++] = &inhdr_sg;
> 
> -	spin_lock(&vcrypto->ctrl_lock);
> -	err = virtqueue_add_sgs(vcrypto->ctrl_vq, sgs, num_out, num_in, vcrypto,
> GFP_ATOMIC);
> -	if (err < 0) {
> -		spin_unlock(&vcrypto->ctrl_lock);
> +	err = virtio_crypto_ctrl_vq_request(vcrypto, sgs, num_out, num_in,
> vc_ctrl_req);
> +	if (err < 0)
>  		goto out;
> -	}
> -
> -	virtqueue_kick(vcrypto->ctrl_vq);
> -	while (!virtqueue_get_buf(vcrypto->ctrl_vq, &inlen) &&
> -	       !virtqueue_is_broken(vcrypto->ctrl_vq))
> -		cpu_relax();
> -	spin_unlock(&vcrypto->ctrl_lock);
> 
>  	if (le32_to_cpu(input->status) != VIRTIO_CRYPTO_OK) {
>  		pr_err("virtio_crypto: Create session failed status: %u\n", @@
> -171,7 +161,7 @@ static int virtio_crypto_alg_akcipher_close_session(struct
> virtio_crypto_akciphe
>  	struct scatterlist outhdr_sg, inhdr_sg, *sgs[2];
>  	struct virtio_crypto_destroy_session_req *destroy_session;
>  	struct virtio_crypto *vcrypto = ctx->vcrypto;
> -	unsigned int num_out = 0, num_in = 0, inlen;
> +	unsigned int num_out = 0, num_in = 0;
>  	int err;
>  	struct virtio_crypto_op_ctrl_req *ctrl;
>  	struct virtio_crypto_inhdr *ctrl_status; @@ -199,18 +189,9 @@ static int
> virtio_crypto_alg_akcipher_close_session(struct virtio_crypto_akciphe
>  	sg_init_one(&inhdr_sg, &ctrl_status->status, sizeof(ctrl_status->status));
>  	sgs[num_out + num_in++] = &inhdr_sg;
> 
> -	spin_lock(&vcrypto->ctrl_lock);
> -	err = virtqueue_add_sgs(vcrypto->ctrl_vq, sgs, num_out, num_in, vcrypto,
> GFP_ATOMIC);
> -	if (err < 0) {
> -		spin_unlock(&vcrypto->ctrl_lock);
> +	err = virtio_crypto_ctrl_vq_request(vcrypto, sgs, num_out, num_in,
> vc_ctrl_req);
> +	if (err < 0)
>  		goto out;
> -	}
> -
> -	virtqueue_kick(vcrypto->ctrl_vq);
> -	while (!virtqueue_get_buf(vcrypto->ctrl_vq, &inlen) &&
> -	       !virtqueue_is_broken(vcrypto->ctrl_vq))
> -		cpu_relax();
> -	spin_unlock(&vcrypto->ctrl_lock);
> 
>  	if (ctrl_status->status != VIRTIO_CRYPTO_OK) {
>  		pr_err("virtio_crypto: Close session failed status: %u, session_id:
> 0x%llx\n", diff --git a/drivers/crypto/virtio/virtio_crypto_common.h
> b/drivers/crypto/virtio/virtio_crypto_common.h
> index 2422237ec4e6..59a4c0259456 100644
> --- a/drivers/crypto/virtio/virtio_crypto_common.h
> +++ b/drivers/crypto/virtio/virtio_crypto_common.h
> @@ -90,6 +90,7 @@ struct virtio_crypto_ctrl_request {
>  	struct virtio_crypto_op_ctrl_req ctrl;
>  	struct virtio_crypto_session_input input;
>  	struct virtio_crypto_inhdr ctrl_status;
> +	struct completion compl;
>  };
> 
>  struct virtio_crypto_request;
> @@ -141,5 +142,8 @@ int virtio_crypto_skcipher_algs_register(struct
> virtio_crypto *vcrypto);  void virtio_crypto_skcipher_algs_unregister(struct
> virtio_crypto *vcrypto);  int virtio_crypto_akcipher_algs_register(struct
> virtio_crypto *vcrypto);  void virtio_crypto_akcipher_algs_unregister(struct
> virtio_crypto *vcrypto);
> +int virtio_crypto_ctrl_vq_request(struct virtio_crypto *vcrypto, struct
> scatterlist *sgs[],
> +				  unsigned int out_sgs, unsigned int in_sgs,
> +				  struct virtio_crypto_ctrl_request *vc_ctrl_req);
> 
>  #endif /* _VIRTIO_CRYPTO_COMMON_H */
> diff --git a/drivers/crypto/virtio/virtio_crypto_core.c
> b/drivers/crypto/virtio/virtio_crypto_core.c
> index c6f482db0bc0..60490ffa3df1 100644
> --- a/drivers/crypto/virtio/virtio_crypto_core.c
> +++ b/drivers/crypto/virtio/virtio_crypto_core.c
> @@ -22,6 +22,56 @@ virtcrypto_clear_request(struct virtio_crypto_request
> *vc_req)
>  	}
>  }
> 
> +static void virtio_crypto_ctrlq_callback(struct
> +virtio_crypto_ctrl_request *vc_ctrl_req) {
> +	complete(&vc_ctrl_req->compl);
> +}
> +
> +static void virtcrypto_ctrlq_callback(struct virtqueue *vq) {
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
> +			virtio_crypto_ctrlq_callback(vc_ctrl_req);
> +			spin_lock_irqsave(&vcrypto->ctrl_lock, flags);
> +		}
> +		if (unlikely(virtqueue_is_broken(vq)))
> +			break;
> +	} while (!virtqueue_enable_cb(vq));
> +	spin_unlock_irqrestore(&vcrypto->ctrl_lock, flags); }
> +
> +int virtio_crypto_ctrl_vq_request(struct virtio_crypto *vcrypto, struct
> scatterlist *sgs[],
> +		unsigned int out_sgs, unsigned int in_sgs,
> +		struct virtio_crypto_ctrl_request *vc_ctrl_req) {
> +	int err;
> +	unsigned long flags;
> +
> +	init_completion(&vc_ctrl_req->compl);
> +
> +	spin_lock_irqsave(&vcrypto->ctrl_lock, flags);
> +	err = virtqueue_add_sgs(vcrypto->ctrl_vq, sgs, out_sgs, in_sgs,
> vc_ctrl_req, GFP_ATOMIC);
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
>  static void virtcrypto_dataq_callback(struct virtqueue *vq)  {
>  	struct virtio_crypto *vcrypto = vq->vdev->priv; @@ -73,7 +123,7 @@
> static int virtcrypto_find_vqs(struct virtio_crypto *vi)
>  		goto err_names;
> 
>  	/* Parameters for control virtqueue */
> -	callbacks[total_vqs - 1] = NULL;
> +	callbacks[total_vqs - 1] = virtcrypto_ctrlq_callback;
>  	names[total_vqs - 1] = "controlq";
> 
>  	/* Allocate/initialize parameters for data virtqueues */ diff --git
> a/drivers/crypto/virtio/virtio_crypto_skcipher_algs.c
> b/drivers/crypto/virtio/virtio_crypto_skcipher_algs.c
> index 6aaf0869b211..e553ccadbcbc 100644
> --- a/drivers/crypto/virtio/virtio_crypto_skcipher_algs.c
> +++ b/drivers/crypto/virtio/virtio_crypto_skcipher_algs.c
> @@ -118,7 +118,6 @@ static int virtio_crypto_alg_skcipher_init_session(
>  		int encrypt)
>  {
>  	struct scatterlist outhdr, key_sg, inhdr, *sgs[3];
> -	unsigned int tmp;
>  	struct virtio_crypto *vcrypto = ctx->vcrypto;
>  	int op = encrypt ? VIRTIO_CRYPTO_OP_ENCRYPT :
> VIRTIO_CRYPTO_OP_DECRYPT;
>  	int err;
> @@ -170,23 +169,9 @@ static int virtio_crypto_alg_skcipher_init_session(
>  	sg_init_one(&inhdr, input, sizeof(*input));
>  	sgs[num_out + num_in++] = &inhdr;
> 
> -	spin_lock(&vcrypto->ctrl_lock);
> -	err = virtqueue_add_sgs(vcrypto->ctrl_vq, sgs, num_out,
> -				num_in, vcrypto, GFP_ATOMIC);
> -	if (err < 0) {
> -		spin_unlock(&vcrypto->ctrl_lock);
> +	err = virtio_crypto_ctrl_vq_request(vcrypto, sgs, num_out, num_in,
> vc_ctrl_req);
> +	if (err < 0)
>  		goto out;
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
> -	spin_unlock(&vcrypto->ctrl_lock);
> 
>  	if (le32_to_cpu(input->status) != VIRTIO_CRYPTO_OK) {
>  		pr_err("virtio_crypto: Create session failed status: %u\n", @@
> -212,7 +197,6 @@ static int virtio_crypto_alg_skcipher_close_session(
>  		int encrypt)
>  {
>  	struct scatterlist outhdr, status_sg, *sgs[2];
> -	unsigned int tmp;
>  	struct virtio_crypto_destroy_session_req *destroy_session;
>  	struct virtio_crypto *vcrypto = ctx->vcrypto;
>  	int err;
> @@ -247,19 +231,9 @@ static int virtio_crypto_alg_skcipher_close_session(
>  	sg_init_one(&status_sg, &ctrl_status->status,
> sizeof(ctrl_status->status));
>  	sgs[num_out + num_in++] = &status_sg;
> 
> -	spin_lock(&vcrypto->ctrl_lock);
> -	err = virtqueue_add_sgs(vcrypto->ctrl_vq, sgs, num_out,
> -			num_in, vcrypto, GFP_ATOMIC);
> -	if (err < 0) {
> -		spin_unlock(&vcrypto->ctrl_lock);
> +	err = virtio_crypto_ctrl_vq_request(vcrypto, sgs, num_out, num_in,
> vc_ctrl_req);
> +	if (err < 0)
>  		goto out;
> -	}
> -	virtqueue_kick(vcrypto->ctrl_vq);
> -
> -	while (!virtqueue_get_buf(vcrypto->ctrl_vq, &tmp) &&
> -	       !virtqueue_is_broken(vcrypto->ctrl_vq))
> -		cpu_relax();
> -	spin_unlock(&vcrypto->ctrl_lock);
> 
>  	if (ctrl_status->status != VIRTIO_CRYPTO_OK) {
>  		pr_err("virtio_crypto: Close session failed status: %u, session_id:
> 0x%llx\n",
> --
> 2.20.1

