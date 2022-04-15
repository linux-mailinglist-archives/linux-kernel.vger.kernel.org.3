Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66ACC502A05
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 14:35:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353714AbiDOMiK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 08:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353717AbiDOMhm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 08:37:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8C639D3993
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 05:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650026000;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ftgpEXExt/Q8tapC3VPgV4SRlTmXUpdTzVH1uq6974U=;
        b=iyplEH9yjOGTNu6PE3JAIDVfm89DvtB8wEf7sdML63gbz9YL+TvGQJq5xwi8o8cfg9cVLU
        iY9IHLWKMp7S/S9Dwu7HxWXIEoqppzIFUCsgYRhRvXdj0/32qW4kj6HqY8U0l68izgYBRV
        SmJZ0MojfHoRdVjPWTODmQz57Y8lWi4=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-139-69H2YbngM3CC-Yt7jEwRlg-1; Fri, 15 Apr 2022 08:33:19 -0400
X-MC-Unique: 69H2YbngM3CC-Yt7jEwRlg-1
Received: by mail-ej1-f69.google.com with SMTP id sd41-20020a1709076e2900b006e8ade22310so3169536ejc.8
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 05:33:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ftgpEXExt/Q8tapC3VPgV4SRlTmXUpdTzVH1uq6974U=;
        b=wmhlt+OZ7bPTL+eAzgI00lqcI0ZSIY9iAyCmXjb4YtuIRHr+bYdq/XOjf3F8FoqWFL
         3O8Va45RV4jPm6yCGSImYVcFY/qZhikzTfz/YPB72Fyfxl/bcZ2IMcynVvcWUaliSfFX
         dmx9r5TEb8qT+nIP93wFqUxmLMNTgTqDBSVuFW+5YW591le1/mxRwF3sV0dpqzNOKEcI
         LxoeEyHlvQ3FCp18sygqAF0sl3K1WSvAZjNGDGPauGUd4AorYeto0Xvfb9QUYT3yW9CR
         Hdhuu6hTibokLuL/UW6POoZVYYVyEST6zZaOCuWrcsl/UYoWCehMCYZ5Wq8KHQLpmPck
         TAWA==
X-Gm-Message-State: AOAM532kVoEz5V/RoxaUIVcFGhXuZXR4fJKyBNRBEFk8xBJ80YmLbBQ3
        vSYukIaIUjc6V9kZsEhkt9ICI7/5j9LGe0pQYJdcbBtHjp1cadabmKl6MDlP9PdiynN3As5ywzC
        ww7T4vLZkkyowg+xVmq0V24iB
X-Received: by 2002:a17:907:6e0d:b0:6e0:59ae:21f1 with SMTP id sd13-20020a1709076e0d00b006e059ae21f1mr6240112ejc.362.1650025997842;
        Fri, 15 Apr 2022 05:33:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyuKmlTty+4i2feqbobmTM30rT7DiZ0fmBwHM9hMPpc7VE0xAYd1NkDNPZxHO77k5Tbr4RyuQ==
X-Received: by 2002:a17:907:6e0d:b0:6e0:59ae:21f1 with SMTP id sd13-20020a1709076e0d00b006e059ae21f1mr6240091ejc.362.1650025997535;
        Fri, 15 Apr 2022 05:33:17 -0700 (PDT)
Received: from redhat.com ([2.53.138.98])
        by smtp.gmail.com with ESMTPSA id w7-20020a1709061f0700b006ec8197e8a4sm1135508ejj.97.2022.04.15.05.33.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 05:33:16 -0700 (PDT)
Date:   Fri, 15 Apr 2022 08:33:12 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     zhenwei pi <pizhenwei@bytedance.com>
Cc:     arei.gonglei@huawei.com, jasowang@redhat.com,
        herbert@gondor.apana.org.au, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-crypto@vger.kernel.org, helei.sig11@bytedance.com,
        davem@davemloft.net
Subject: Re: Re: [PATCH 1/4] virtio-crypto: wait ctrl queue instead of busy
 polling
Message-ID: <20220415082750-mutt-send-email-mst@kernel.org>
References: <20220415064136.304661-1-pizhenwei@bytedance.com>
 <20220415064136.304661-2-pizhenwei@bytedance.com>
 <20220415042555-mutt-send-email-mst@kernel.org>
 <eba72a32-aa94-0d9c-b927-a9e6b965ca44@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eba72a32-aa94-0d9c-b927-a9e6b965ca44@bytedance.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 15, 2022 at 06:50:19PM +0800, zhenwei pi wrote:
> On 4/15/22 16:41, Michael S. Tsirkin wrote:
> > > diff --git a/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c b/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
> > > index f3ec9420215e..bf7c1aa4be37 100644
> > > --- a/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
> > > +++ b/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
> > > @@ -102,107 +102,100 @@ static int virtio_crypto_alg_akcipher_init_session(struct virtio_crypto_akcipher
> > >   {
> > >   	struct scatterlist outhdr_sg, key_sg, inhdr_sg, *sgs[3];
> > >   	struct virtio_crypto *vcrypto = ctx->vcrypto;
> > > +	struct virtio_crypto_ctrl_request *vc_ctrl_req = NULL;
> > 
> > this is initialized down the road, I think you can skip = NULL here.
> > 
> OK.
> > >   	uint8_t *pkey;
> > > -	unsigned int inlen;
> > > -	int err;
> > > +	int err = -ENOMEM;
> > 
> > I would assign this in the single case where this value is used.
> > 
> OK
> > >   	unsigned int num_out = 0, num_in = 0;
> > > +	int node = dev_to_node(&vcrypto->vdev->dev);
> > are you sure it is
> > better to allocate close to device and not to current node
> > which is the default?
> > 
> Also with this part:
>  /* Internal representation of a data virtqueue */
> @@ -65,11 +66,6 @@ struct virtio_crypto {
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
> 
> Orignally virtio crypto driver allocates ctrl&input&ctrl_status per-device,
> and protects this with ctrl_lock. This is the reason why the control queue
> reaches the bottleneck of performance. I'll append this in the next version
> in commit message.
> 
> Instead of the single request buffer, declare struct
> virtio_crypto_ctrl_request {
>         struct virtio_crypto_op_ctrl_req ctrl;
>         struct virtio_crypto_session_input input;
>         struct virtio_crypto_inhdr ctrl_status;
> 	... }
> 
> The motivation of this change is to allocate buffer from the same node with
> device during control queue operations.

But are you sure it's a win?  quite possibly it's a win to
have it close to driver not close to device.
This kind of change is really best done separately with some
testing showing it's a win. If that is too much to ask,
make it a separate patch and add some analysis explaining
why device accesses the structure more than the driver.


> > 
> > >   	pkey = kmemdup(key, keylen, GFP_ATOMIC);
> > >   	if (!pkey)
> > >   		return -ENOMEM;
> > > -	spin_lock(&vcrypto->ctrl_lock);
> > > -	memcpy(&vcrypto->ctrl.header, header, sizeof(vcrypto->ctrl.header));
> > > -	memcpy(&vcrypto->ctrl.u, para, sizeof(vcrypto->ctrl.u));
> > > -	vcrypto->input.status = cpu_to_le32(VIRTIO_CRYPTO_ERR);
> > > +	vc_ctrl_req = kzalloc_node(sizeof(*vc_ctrl_req), GFP_KERNEL, node);
> > > +	if (!vc_ctrl_req)
> > > +		goto out;
> > 
> > do you need to allocate it with kzalloc?
> > is anything wrong with just keeping it part of device?
> > even if yes this change is better split in a separate patch, would make the patch smaller.
> Because there are padding field in
> virtio_crypto_op_ctrl_req&virtio_crypto_session_input, I suppose the
> original version also needs to clear padding field.
> So I use kzalloc to make sure that the padding field gets cleared.
> If this is reasonable, to separate this patch is OK to me, or I append this
> reason into commit message and comments in code.

Not sure I understand. Maybe add a code comment explaining
what is cleared and why.

> > > +
> > > +void virtcrypto_ctrlq_callback(struct virtqueue *vq)
> > > +{
> > > +	struct virtio_crypto *vcrypto = vq->vdev->priv;
> > > +	struct virtio_crypto_ctrl_request *vc_ctrl_req;
> > > +	unsigned long flags;
> > > +	unsigned int len;
> > > +
> > > +	spin_lock_irqsave(&vcrypto->ctrl_lock, flags);
> > > +	do {
> > > +		virtqueue_disable_cb(vq);
> > > +		while ((vc_ctrl_req = virtqueue_get_buf(vq, &len)) != NULL) {
> > 
> > 
> > you really need to break out of this loop if vq is broken,
> > virtqueue_get_buf will keep returning NULL in this case.
> > 
> I'm a little confused here, if virtqueue_get_buf return NULL, this loop will
> break. Could you please give me more hints?

Oh right. Sorry was confused.

> > 
> > > +			spin_unlock_irqrestore(&vcrypto->ctrl_lock, flags);
> > > +			if (vc_ctrl_req->ctrl_cb)
> > > +				vc_ctrl_req->ctrl_cb(vc_ctrl_req);
> > > +			spin_lock_irqsave(&vcrypto->ctrl_lock, flags);
> > > +		}
> > > +		if (unlikely(virtqueue_is_broken(vq)))
> > > +			break;
> > > +	} while (!virtqueue_enable_cb(vq));
> > > +	spin_unlock_irqrestore(&vcrypto->ctrl_lock, flags);
> > 
> > speaking of which existing code does not handle vq broken case
> > all that well but it looks like this patch makes it a bit worse.
> > want to try fixing? basically report an error ...
> > 
> > if virtqueue is broken, I can print log.
> 
> > > diff --git a/drivers/crypto/virtio/virtio_crypto_core.c b/drivers/crypto/virtio/virtio_crypto_core.c
> > > index c6f482db0bc0..e668d4b1bc6a 100644
> > > --- a/drivers/crypto/virtio/virtio_crypto_core.c
> > > +++ b/drivers/crypto/virtio/virtio_crypto_core.c
> > > @@ -73,7 +73,7 @@ static int virtcrypto_find_vqs(struct virtio_crypto *vi)
> > >   		goto err_names;
> > >   	/* Parameters for control virtqueue */
> > > -	callbacks[total_vqs - 1] = NULL;
> > > +	callbacks[total_vqs - 1] = virtcrypto_ctrlq_callback;
> > >   	names[total_vqs - 1] = "controlq";
> > >   	/* Allocate/initialize parameters for data virtqueues */
> > > diff --git a/drivers/crypto/virtio/virtio_crypto_skcipher_algs.c b/drivers/crypto/virtio/virtio_crypto_skcipher_algs.c
> > > index a618c46a52b8..b8999dab3e66 100644
> > > --- a/drivers/crypto/virtio/virtio_crypto_skcipher_algs.c
> > > +++ b/drivers/crypto/virtio/virtio_crypto_skcipher_algs.c
> > > +	err = 0;
> > > +out:
> > > +	kfree_sensitive(vc_ctrl_req);
> > 
> > it is interesting that you use kfree_sensitive here. why is that?
> > is there in fact anything sensitive here? if yes this is a security
> > improvement and might need its own patch, or at least documentation.
> > 
> 
> OK, kfree is good enough here, I'll fix this.
> 
> 
> Thanks a lot!
> 
> 
> -- 
> zhenwei pi

