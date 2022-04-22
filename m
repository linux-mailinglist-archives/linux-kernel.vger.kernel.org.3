Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A92850B1F7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 09:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445028AbiDVHuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 03:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242661AbiDVHt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 03:49:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 686D0434B4
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 00:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650613622;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fl4I6Zz5JU/gtVPW6f17UGC2f8Wwy9pQR3UHOX0ExY0=;
        b=EHMMCv2TtwObU3vhl1kI9SgLcDsXRHqRUq7KmEY4Myns1+zSKHgPFZ7U0BDb/cvptNzGhT
        CBnUbnXT3zwTSj1eGKsj73/c4rydvJ7qnY2EF24CxuCmNMe6lAVboX5+CWgeXOQa4bbqjG
        7gvKRyOgB9WTsMbSr9/GnVtriThak5s=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-629-foq06wlgPzOqm_rsvCVXvQ-1; Fri, 22 Apr 2022 03:46:58 -0400
X-MC-Unique: foq06wlgPzOqm_rsvCVXvQ-1
Received: by mail-pf1-f197.google.com with SMTP id v13-20020aa7850d000000b0050ad8ff561aso3104149pfn.5
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 00:46:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=fl4I6Zz5JU/gtVPW6f17UGC2f8Wwy9pQR3UHOX0ExY0=;
        b=FaiCS/d+BwYGOEnQfYDuGb0ooxAYANIcpM46SthT3Rv0caeG5slJmlao6Bz4KKnlXj
         YeL18R1C1F5yZw8erAjjpUHaLtQxLJz+LPrdSk2WpfZb1bqFMGb5SPmn2Mhv5ouwAl52
         ungBLBdP6GQ8/nNlakIsiSRvyYpAmXuW5WayKf2p9rj7fJqna++qL/WSyhfHXCFquLxq
         1swwimVTKlRpowgjzIE8ntaUvGGE+h0MNhjtpRxAqAcwekYpRf9UK5b3m4/RXHaiEA78
         BI0yhoROXs0M3wgc7+0W8vGKHc1sQ3AwsotiTwnKsUwpFgfNBgD9jX1G3hsYnrcSDlYL
         9SlQ==
X-Gm-Message-State: AOAM531EE+VLNfoiNPDiJoUt479d0qsVqdiNdfw6pMkOj++7NZDz+uNL
        wABLCnPggj6aWBxXrjDC8ceeU+rbyh9fCrEUnUhCyflQBp6L8PIlNVD6BTzTFyDuH1HAx8kmNU7
        M05qzKFRT5Xw/9sgpOmWm/kbg
X-Received: by 2002:a63:2cd4:0:b0:39d:8636:3808 with SMTP id s203-20020a632cd4000000b0039d86363808mr2865046pgs.290.1650613617163;
        Fri, 22 Apr 2022 00:46:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxxjC9u2kHzwAFJiLNvLW5+T84jRgBq4AMqzv14M2Prz/bhitaguzBgCv0/xIyD9/wmXPFo4g==
X-Received: by 2002:a63:2cd4:0:b0:39d:8636:3808 with SMTP id s203-20020a632cd4000000b0039d86363808mr2865033pgs.290.1650613616861;
        Fri, 22 Apr 2022 00:46:56 -0700 (PDT)
Received: from [10.72.12.62] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id o19-20020a17090a421300b001cd4989fec9sm5215128pjg.21.2022.04.22.00.46.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Apr 2022 00:46:56 -0700 (PDT)
Message-ID: <0cac99a6-8479-394b-4a0e-32df7c8af8d7@redhat.com>
Date:   Fri, 22 Apr 2022 15:46:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [PATCH v3 2/5] virtio-crypto: wait ctrl queue instead of busy
 polling
Content-Language: en-US
To:     zhenwei pi <pizhenwei@bytedance.com>, arei.gonglei@huawei.com,
        mst@redhat.com
Cc:     herbert@gondor.apana.org.au, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-crypto@vger.kernel.org, helei.sig11@bytedance.com,
        davem@davemloft.net
References: <20220421104016.453458-1-pizhenwei@bytedance.com>
 <20220421104016.453458-3-pizhenwei@bytedance.com>
From:   Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220421104016.453458-3-pizhenwei@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2022/4/21 18:40, zhenwei pi 写道:
> Originally, after submitting request into virtio crypto control
> queue, the guest side polls the result from the virt queue. This
> works like following:
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
> To improve the performance of control queue, a request on control queue waits
> completion instead of busy polling to reduce lock racing, and gets completed by
> control queue callback.
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
>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Gonglei <arei.gonglei@huawei.com>
> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
> ---
>   drivers/crypto/virtio/virtio_crypto_common.c | 42 +++++++++++++++-----
>   drivers/crypto/virtio/virtio_crypto_common.h |  8 ++++
>   drivers/crypto/virtio/virtio_crypto_core.c   |  2 +-
>   3 files changed, 41 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/crypto/virtio/virtio_crypto_common.c b/drivers/crypto/virtio/virtio_crypto_common.c
> index e65125a74db2..93df73c40dd3 100644
> --- a/drivers/crypto/virtio/virtio_crypto_common.c
> +++ b/drivers/crypto/virtio/virtio_crypto_common.c
> @@ -8,14 +8,21 @@
>   
>   #include "virtio_crypto_common.h"
>   
> +static void virtio_crypto_ctrlq_callback(struct virtio_crypto_ctrl_request *vc_ctrl_req)
> +{
> +	complete(&vc_ctrl_req->compl);
> +}
> +
>   int virtio_crypto_ctrl_vq_request(struct virtio_crypto *vcrypto, struct scatterlist *sgs[],
>   				  unsigned int out_sgs, unsigned int in_sgs,
>   				  struct virtio_crypto_ctrl_request *vc_ctrl_req)
>   {
>   	int err;
> -	unsigned int inlen;
>   	unsigned long flags;
>   
> +	init_completion(&vc_ctrl_req->compl);
> +	vc_ctrl_req->ctrl_cb =  virtio_crypto_ctrlq_callback;


Is there a chance that the cb would not be virtio_crypto_ctrlq_callback()?


> +
>   	spin_lock_irqsave(&vcrypto->ctrl_lock, flags);
>   	err = virtqueue_add_sgs(vcrypto->ctrl_vq, sgs, out_sgs, in_sgs, vc_ctrl_req, GFP_ATOMIC);
>   	if (err < 0) {
> @@ -24,16 +31,31 @@ int virtio_crypto_ctrl_vq_request(struct virtio_crypto *vcrypto, struct scatterl
>   	}
>   
>   	virtqueue_kick(vcrypto->ctrl_vq);
> -
> -	/*
> -	 * Trapping into the hypervisor, so the request should be
> -	 * handled immediately.
> -	 */
> -	while (!virtqueue_get_buf(vcrypto->ctrl_vq, &inlen) &&
> -		!virtqueue_is_broken(vcrypto->ctrl_vq))
> -		cpu_relax();
> -
>   	spin_unlock_irqrestore(&vcrypto->ctrl_lock, flags);
>   
> +	wait_for_completion(&vc_ctrl_req->compl);
> +
>   	return 0;
>   }
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
> index d2a20fe6e13e..25b4f22e8605 100644
> --- a/drivers/crypto/virtio/virtio_crypto_common.h
> +++ b/drivers/crypto/virtio/virtio_crypto_common.h
> @@ -81,6 +81,10 @@ struct virtio_crypto_sym_session_info {
>   	__u64 session_id;
>   };
>   
> +struct virtio_crypto_ctrl_request;
> +typedef void (*virtio_crypto_ctrl_callback)
> +		(struct virtio_crypto_ctrl_request *vc_ctrl_req);
> +
>   /*
>    * Note: there are padding fields in request, clear them to zero before sending to host,
>    * Ex, virtio_crypto_ctrl_request::ctrl::u::destroy_session::padding[48]
> @@ -89,6 +93,8 @@ struct virtio_crypto_ctrl_request {
>   	struct virtio_crypto_op_ctrl_req ctrl;
>   	struct virtio_crypto_session_input input;
>   	struct virtio_crypto_inhdr ctrl_status;
> +	virtio_crypto_ctrl_callback ctrl_cb;
> +	struct completion compl;
>   };
>   
>   struct virtio_crypto_request;
> @@ -141,7 +147,9 @@ void virtio_crypto_skcipher_algs_unregister(struct virtio_crypto *vcrypto);
>   int virtio_crypto_akcipher_algs_register(struct virtio_crypto *vcrypto);
>   void virtio_crypto_akcipher_algs_unregister(struct virtio_crypto *vcrypto);
>   
> +void virtcrypto_ctrlq_callback(struct virtqueue *vq);
>   int virtio_crypto_ctrl_vq_request(struct virtio_crypto *vcrypto, struct scatterlist *sgs[],
>   				  unsigned int out_sgs, unsigned int in_sgs,
>   				  struct virtio_crypto_ctrl_request *vc_ctrl_req);
> +


Unnecessary changes.

Thanks


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

