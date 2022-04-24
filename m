Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0E6050D003
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 08:22:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238372AbiDXGZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 02:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235842AbiDXGYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 02:24:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 023FE32043
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 23:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650781300;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pn5vZufU+wZDPtEw0CFV7kn4KWKqaAcFWOLs0ntfZac=;
        b=cFXmMu/Ov1KY7oLitwu7eF0memr7WjDPubaR2q6MDCsuPJM00vcUk0FNEoDFt3xPc5Oxr7
        FMYYK8kYrvytgESDDPHxXnGlgko+nfmayHRDNY0JvDHk2VJ7dbLUxFCGjpUuP0wZ//BFYJ
        Af26VBH5EoaUnKSUFUuOk/JNfO2KQRA=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-193-C_vA_VWsOV-lucq28MxTJw-1; Sun, 24 Apr 2022 02:21:37 -0400
X-MC-Unique: C_vA_VWsOV-lucq28MxTJw-1
Received: by mail-lf1-f70.google.com with SMTP id k17-20020a0565123d9100b00471c860aa98so3997640lfv.7
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 23:21:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pn5vZufU+wZDPtEw0CFV7kn4KWKqaAcFWOLs0ntfZac=;
        b=Bvn3G0RRZ0vfSutMUtQLK2km3HIZjBU5i3CPgg9CtXn+hlM6X69KJxv7rflzc57zBs
         TTKLjOhPT5ZSyf6NMiWf3KN6wYXfYEOj9x2Q4c96haYYuMP/0SpxShp34kJxp+4MgrpA
         n3KjjmFrbf7zUc4woCsytAPPULrScc3z/U3nMe4mrb7jXx+GS/Mjd9FsopCTbR4bmDRW
         T8qxyS4YVroDOp+LFjXDlgxLeujKr1PmVHIzoqHMFMw1V8pIGo5h9evQJAn7xgvONpiw
         AluLVlSsJfexwUxnfo4Da4tJ9m2nSnz3x+ikZaosOjeqSg/bfdd35TKXOzvIimp5da3/
         NZWQ==
X-Gm-Message-State: AOAM531E0VeS/hgZg7rCr+0lKQDusL3ES6Q9ZGuvvXoJ/wkNPIxs8HKT
        FWkuMdEE1I8u3ojB7maRlYM081eWdaCKY6mXVT/YklOG7EIPqNqsYshWZXv20hDWCg//SuNGSfm
        xKnZoIGAoCFNFUJaXf/B+NGpyRDHvtGnbjNZvjEHB
X-Received: by 2002:a05:6512:1293:b0:471:a1bb:d55d with SMTP id u19-20020a056512129300b00471a1bbd55dmr8776255lfs.190.1650781296371;
        Sat, 23 Apr 2022 23:21:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzMmn8zJap4RF0U5O3fAKz3sI59WuUzJ31zf05jpgT2C2tst+mp5petO9CvsrPyt/DXHj/5ufUwbFjHQ7xrJ14=
X-Received: by 2002:a05:6512:1293:b0:471:a1bb:d55d with SMTP id
 u19-20020a056512129300b00471a1bbd55dmr8776242lfs.190.1650781296086; Sat, 23
 Apr 2022 23:21:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220421104016.453458-1-pizhenwei@bytedance.com>
 <20220421104016.453458-2-pizhenwei@bytedance.com> <7996f495-3bb8-fa80-7866-fa1fbff3e80a@redhat.com>
 <cbe1041e-e7e0-49bb-3164-f472823e736b@bytedance.com>
In-Reply-To: <cbe1041e-e7e0-49bb-3164-f472823e736b@bytedance.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Sun, 24 Apr 2022 14:21:24 +0800
Message-ID: <CACGkMEutBJpeZbO52KM6=2HPTBuGx00hVyjBuj7nu5EUHuofrQ@mail.gmail.com>
Subject: Re: Re: [PATCH v3 1/5] virtio-crypto: use private buffer for control request
To:     zhenwei pi <pizhenwei@bytedance.com>
Cc:     "Gonglei (Arei)" <arei.gonglei@huawei.com>, mst <mst@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-crypto@vger.kernel.org, helei.sig11@bytedance.com,
        davem <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22, 2022 at 5:12 PM zhenwei pi <pizhenwei@bytedance.com> wrote:
>
> On 4/22/22 15:41, Jason Wang wrote:
> >
> > =E5=9C=A8 2022/4/21 18:40, zhenwei pi =E5=86=99=E9=81=93:
> >> Originally, all of the control requests share a single buffer(
> >> ctrl & input & ctrl_status fields in struct virtio_crypto), this
> >> allows queue depth 1 only, the performance of control queue gets
> >> limited by this design.
> >>
> >> In this patch, each request allocates request buffer dynamically, and
> >> free buffer after request, it's possible to optimize control queue
> >> depth in the next step.
> >>
> >> A necessary comment is already in code, still describe it again:
> >> /*
> >>   * Note: there are padding fields in request, clear them to zero befo=
re
> >>   * sending to host,
> >>   * Ex, virtio_crypto_ctrl_request::ctrl::u::destroy_session::padding[=
48]
> >>   */
> >> So use kzalloc to allocate buffer of struct virtio_crypto_ctrl_request=
.
> >>
> >> Cc: Michael S. Tsirkin <mst@redhat.com>
> >> Cc: Jason Wang <jasowang@redhat.com>
> >> Cc: Gonglei <arei.gonglei@huawei.com>
> >> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
> >> ---
> >>   drivers/crypto/virtio/Makefile                |   1 +
> >>   .../virtio/virtio_crypto_akcipher_algs.c      |  90 ++++++------
> >>   drivers/crypto/virtio/virtio_crypto_common.c  |  39 +++++
> >
> >
> > Any reason we can't use virtio_crypto_core.c?
> >
> Another patch in this series: [PATCH v3 3/5] virtio-crypto: move helpers
> into virtio_crypto_common.c
>
> Move virtcrypto_clear_request and virtcrypto_dataq_callback into
> virtio_crypto_common.c to make code clear. Then the xx_core.c
> supports:
>    - probe/remove/irq affinity seting for a virtio device
>    - basic virtio related operations
>
> xx_common.c supports:
>    - common helpers/functions for algos
>
> So I put this into a new file.

I don't see obvious differences but we can leave it to the
virtio-crypto maintainers to decide.

>
> >
> >>   drivers/crypto/virtio/virtio_crypto_common.h  |  19 ++-
> >>   .../virtio/virtio_crypto_skcipher_algs.c      | 133 ++++++++--------=
--
> >>   5 files changed, 156 insertions(+), 126 deletions(-)
> >>   create mode 100644 drivers/crypto/virtio/virtio_crypto_common.c
> >>
> >> diff --git a/drivers/crypto/virtio/Makefile
> >> b/drivers/crypto/virtio/Makefile
> >> index bfa6cbae342e..49c1fa80e465 100644
> >> --- a/drivers/crypto/virtio/Makefile
> >> +++ b/drivers/crypto/virtio/Makefile
> >> @@ -3,5 +3,6 @@ obj-$(CONFIG_CRYPTO_DEV_VIRTIO) +=3D virtio_crypto.o
> >>   virtio_crypto-objs :=3D \
> >>       virtio_crypto_skcipher_algs.o \
> >>       virtio_crypto_akcipher_algs.o \
> >> +    virtio_crypto_common.o \
> >>       virtio_crypto_mgr.o \
> >>       virtio_crypto_core.o
> >> diff --git a/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
> >> b/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
> >> index f3ec9420215e..9561bc2df62b 100644
> >> --- a/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
> >> +++ b/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
> >> @@ -102,8 +102,8 @@ static int
> >> virtio_crypto_alg_akcipher_init_session(struct virtio_crypto_akcipher
> >>   {
> >>       struct scatterlist outhdr_sg, key_sg, inhdr_sg, *sgs[3];
> >>       struct virtio_crypto *vcrypto =3D ctx->vcrypto;
> >> +    struct virtio_crypto_ctrl_request *vc_ctrl_req;
> >>       uint8_t *pkey;
> >> -    unsigned int inlen;
> >>       int err;
> >>       unsigned int num_out =3D 0, num_in =3D 0;
> >> @@ -111,98 +111,91 @@ static int
> >> virtio_crypto_alg_akcipher_init_session(struct virtio_crypto_akcipher
> >>       if (!pkey)
> >>           return -ENOMEM;
> >> -    spin_lock(&vcrypto->ctrl_lock);
> >> -    memcpy(&vcrypto->ctrl.header, header, sizeof(vcrypto->ctrl.header=
));
> >> -    memcpy(&vcrypto->ctrl.u, para, sizeof(vcrypto->ctrl.u));
> >> -    vcrypto->input.status =3D cpu_to_le32(VIRTIO_CRYPTO_ERR);
> >> +    vc_ctrl_req =3D kzalloc(sizeof(*vc_ctrl_req), GFP_KERNEL);
> >> +    if (!vc_ctrl_req) {
> >> +        err =3D -ENOMEM;
> >> +        goto out;
> >> +    }
> >> -    sg_init_one(&outhdr_sg, &vcrypto->ctrl, sizeof(vcrypto->ctrl));
> >> +    memcpy(&vc_ctrl_req->ctrl.header, header,
> >> sizeof(vc_ctrl_req->ctrl.header));
> >> +    memcpy(&vc_ctrl_req->ctrl.u, para, sizeof(vc_ctrl_req->ctrl.u));
> >> +    sg_init_one(&outhdr_sg, &vc_ctrl_req->ctrl,
> >> sizeof(vc_ctrl_req->ctrl));
> >>       sgs[num_out++] =3D &outhdr_sg;
> >>       sg_init_one(&key_sg, pkey, keylen);
> >>       sgs[num_out++] =3D &key_sg;
> >> -    sg_init_one(&inhdr_sg, &vcrypto->input, sizeof(vcrypto->input));
> >> +    vc_ctrl_req->input.status =3D cpu_to_le32(VIRTIO_CRYPTO_ERR);
> >
> >
> > Nit: if there's no special reason, let's move this after the above
> > memcpys as what's done previously.
> >
> >
> >> +    sg_init_one(&inhdr_sg, &vc_ctrl_req->input,
> >> sizeof(vc_ctrl_req->input));
> >>       sgs[num_out + num_in++] =3D &inhdr_sg;
> >> -    err =3D virtqueue_add_sgs(vcrypto->ctrl_vq, sgs, num_out, num_in,
> >> vcrypto, GFP_ATOMIC);
> >> +    err =3D virtio_crypto_ctrl_vq_request(vcrypto, sgs, num_out,
> >> num_in, vc_ctrl_req);
> >
> >
> > I'd split this into a separate patch.
> >
>
> OK!
> >
> >>       if (err < 0)
> >>           goto out;
> >> -    virtqueue_kick(vcrypto->ctrl_vq);
> >> -    while (!virtqueue_get_buf(vcrypto->ctrl_vq, &inlen) &&
> >> -           !virtqueue_is_broken(vcrypto->ctrl_vq))
> >> -        cpu_relax();
> >> -
> >> -    if (le32_to_cpu(vcrypto->input.status) !=3D VIRTIO_CRYPTO_OK) {
> >> +    if (le32_to_cpu(vc_ctrl_req->input.status) !=3D VIRTIO_CRYPTO_OK)=
 {
> >> +        pr_err("virtio_crypto: Create session failed status: %u\n",
> >> +            le32_to_cpu(vc_ctrl_req->input.status));
> >>           err =3D -EINVAL;
> >>           goto out;
> >>       }
> >
> >
> > Do we need a warning for -ENOMEM?
> >
>
> Memory(especially small size) allocation is unlikely case, I also check
> the virtio_net and virtio_blk, both handles -ENOMEM only without error
> reporting.

Ok.

>
> >
> >> -    ctx->session_id =3D le64_to_cpu(vcrypto->input.session_id);
> >> +    ctx->session_id =3D le64_to_cpu(vc_ctrl_req->input.session_id);
> >>       ctx->session_valid =3D true;
> >>       err =3D 0;
> >>   out:
> >> -    spin_unlock(&vcrypto->ctrl_lock);
> >> +    kfree(vc_ctrl_req);
> >>       kfree_sensitive(pkey);
> >> -    if (err < 0)
> >> -        pr_err("virtio_crypto: Create session failed status: %u\n",
> >> -            le32_to_cpu(vcrypto->input.status));
> >> -
> >>       return err;
> >>   }
> >>   static int virtio_crypto_alg_akcipher_close_session(struct
> >> virtio_crypto_akcipher_ctx *ctx)
> >>   {
> >>       struct scatterlist outhdr_sg, inhdr_sg, *sgs[2];
> >> +    struct virtio_crypto_ctrl_request *vc_ctrl_req;
> >>       struct virtio_crypto_destroy_session_req *destroy_session;
> >>       struct virtio_crypto *vcrypto =3D ctx->vcrypto;
> >> -    unsigned int num_out =3D 0, num_in =3D 0, inlen;
> >> +    unsigned int num_out =3D 0, num_in =3D 0;
> >>       int err;
> >> -    spin_lock(&vcrypto->ctrl_lock);
> >> -    if (!ctx->session_valid) {
> >> -        err =3D 0;
> >> -        goto out;
> >> -    }
> >> -    vcrypto->ctrl_status.status =3D VIRTIO_CRYPTO_ERR;
> >> -    vcrypto->ctrl.header.opcode =3D
> >> cpu_to_le32(VIRTIO_CRYPTO_AKCIPHER_DESTROY_SESSION);
> >> -    vcrypto->ctrl.header.queue_id =3D 0;
> >> +    if (!ctx->session_valid)
> >> +        return 0;
> >> -    destroy_session =3D &vcrypto->ctrl.u.destroy_session;
> >> +    vc_ctrl_req =3D kzalloc(sizeof(*vc_ctrl_req), GFP_KERNEL);
> >> +    if (!vc_ctrl_req)
> >> +        return -ENOMEM;
> >> +
> >> +    vc_ctrl_req->ctrl.header.opcode =3D
> >> cpu_to_le32(VIRTIO_CRYPTO_AKCIPHER_DESTROY_SESSION);
> >> +    vc_ctrl_req->ctrl.header.queue_id =3D 0;
> >> +
> >> +    destroy_session =3D &vc_ctrl_req->ctrl.u.destroy_session;
> >>       destroy_session->session_id =3D cpu_to_le64(ctx->session_id);
> >> -    sg_init_one(&outhdr_sg, &vcrypto->ctrl, sizeof(vcrypto->ctrl));
> >> +    sg_init_one(&outhdr_sg, &vc_ctrl_req->ctrl,
> >> sizeof(vc_ctrl_req->ctrl));
> >>       sgs[num_out++] =3D &outhdr_sg;
> >> -    sg_init_one(&inhdr_sg, &vcrypto->ctrl_status.status,
> >> sizeof(vcrypto->ctrl_status.status));
> >> +    vc_ctrl_req->ctrl_status.status =3D VIRTIO_CRYPTO_ERR;
> >
> >
> > If no special reason, let's move this above:
> >
> > vc_ctrl_req->ctrl.header.opcode =3D
> > cpu_to_le32(VIRTIO_CRYPTO_AKCIPHER_DESTROY_SESSION);
> >
>
> OK!
> >
> >> +    sg_init_one(&inhdr_sg, &vc_ctrl_req->ctrl_status.status,
> >> +        sizeof(vc_ctrl_req->ctrl_status.status));
> >>       sgs[num_out + num_in++] =3D &inhdr_sg;
> >> -    err =3D virtqueue_add_sgs(vcrypto->ctrl_vq, sgs, num_out, num_in,
> >> vcrypto, GFP_ATOMIC);
> >> +    err =3D virtio_crypto_ctrl_vq_request(vcrypto, sgs, num_out,
> >> num_in, vc_ctrl_req);
> >>       if (err < 0)
> >>           goto out;
> >> -    virtqueue_kick(vcrypto->ctrl_vq);
> >> -    while (!virtqueue_get_buf(vcrypto->ctrl_vq, &inlen) &&
> >> -           !virtqueue_is_broken(vcrypto->ctrl_vq))
> >> -        cpu_relax();
> >> -
> >> -    if (vcrypto->ctrl_status.status !=3D VIRTIO_CRYPTO_OK) {
> >> +    if (vc_ctrl_req->ctrl_status.status !=3D VIRTIO_CRYPTO_OK) {
> >>           err =3D -EINVAL;
> >> +        pr_err("virtio_crypto: Close session failed status: %u,
> >> session_id: 0x%llx\n",
> >> +            vc_ctrl_req->ctrl_status.status,
> >> destroy_session->session_id);
> >>           goto out;
> >>       }
> >>       err =3D 0;
> >>       ctx->session_valid =3D false;
> >> -
> >>   out:
> >> -    spin_unlock(&vcrypto->ctrl_lock);
> >> -    if (err < 0) {
> >> -        pr_err("virtio_crypto: Close session failed status: %u,
> >> session_id: 0x%llx\n",
> >> -            vcrypto->ctrl_status.status, destroy_session->session_id)=
;
> >> -    }
> >> +    kfree(vc_ctrl_req);
> >>       return err;
> >>   }
> >> @@ -210,14 +203,11 @@ static int
> >> virtio_crypto_alg_akcipher_close_session(struct virtio_crypto_akciphe
> >>   static int __virtio_crypto_akcipher_do_req(struct
> >> virtio_crypto_akcipher_request *vc_akcipher_req,
> >>           struct akcipher_request *req, struct data_queue *data_vq)
> >>   {
> >> -    struct virtio_crypto_akcipher_ctx *ctx =3D
> >> vc_akcipher_req->akcipher_ctx;
> >>       struct virtio_crypto_request *vc_req =3D &vc_akcipher_req->base;
> >> -    struct virtio_crypto *vcrypto =3D ctx->vcrypto;
> >>       struct virtio_crypto_op_data_req *req_data =3D vc_req->req_data;
> >>       struct scatterlist *sgs[4], outhdr_sg, inhdr_sg, srcdata_sg,
> >> dstdata_sg;
> >>       void *src_buf =3D NULL, *dst_buf =3D NULL;
> >>       unsigned int num_out =3D 0, num_in =3D 0;
> >> -    int node =3D dev_to_node(&vcrypto->vdev->dev);
> >>       unsigned long flags;
> >>       int ret =3D -ENOMEM;
> >>       bool verify =3D vc_akcipher_req->opcode =3D=3D
> >> VIRTIO_CRYPTO_AKCIPHER_VERIFY;
> >> @@ -228,7 +218,7 @@ static int __virtio_crypto_akcipher_do_req(struct
> >> virtio_crypto_akcipher_request
> >>       sgs[num_out++] =3D &outhdr_sg;
> >>       /* src data */
> >> -    src_buf =3D kcalloc_node(src_len, 1, GFP_KERNEL, node);
> >> +    src_buf =3D kcalloc(src_len, 1, GFP_KERNEL);
> >
> >
> > This seems not a relevant change. If it is a must we need use a separat=
e
> > for this and describe the rationale.
> >
> >
> >>       if (!src_buf)
> >>           goto err;
> >> @@ -243,7 +233,7 @@ static int __virtio_crypto_akcipher_do_req(struct
> >> virtio_crypto_akcipher_request
> >>           sgs[num_out++] =3D &srcdata_sg;
> >>           /* dst data */
> >> -        dst_buf =3D kcalloc_node(req->dst_len, 1, GFP_KERNEL, node);
> >> +        dst_buf =3D kcalloc(req->dst_len, 1, GFP_KERNEL);
> >
> >
> > And this.
> >
> >
> >>           if (!dst_buf)
> >>               goto err;
> >> diff --git a/drivers/crypto/virtio/virtio_crypto_common.c
> >> b/drivers/crypto/virtio/virtio_crypto_common.c
> >> new file mode 100644
> >> index 000000000000..e65125a74db2
> >> --- /dev/null
> >> +++ b/drivers/crypto/virtio/virtio_crypto_common.c
> >> @@ -0,0 +1,39 @@
> >> +// SPDX-License-Identifier: GPL-2.0-or-later
> >> +/* Common functions and helpers
> >> + *
> >> + * Authors: zhenwei pi <pizhenwei@bytedance.com>
> >> + *
> >> + * Copyright 2022 Bytedance CO., LTD.
> >> + */
> >> +
> >> +#include "virtio_crypto_common.h"
> >> +
> >> +int virtio_crypto_ctrl_vq_request(struct virtio_crypto *vcrypto,
> >> struct scatterlist *sgs[],
> >> +                  unsigned int out_sgs, unsigned int in_sgs,
> >> +                  struct virtio_crypto_ctrl_request *vc_ctrl_req)
> >> +{
> >> +    int err;
> >> +    unsigned int inlen;
> >> +    unsigned long flags;
> >> +
> >> +    spin_lock_irqsave(&vcrypto->ctrl_lock, flags);
> >> +    err =3D virtqueue_add_sgs(vcrypto->ctrl_vq, sgs, out_sgs, in_sgs,
> >> vc_ctrl_req, GFP_ATOMIC);
> >> +    if (err < 0) {
> >> +        spin_unlock_irqrestore(&vcrypto->ctrl_lock, flags);
> >> +        return err;
> >> +    }
> >> +
> >> +    virtqueue_kick(vcrypto->ctrl_vq);
> >> +
> >> +    /*
> >> +     * Trapping into the hypervisor, so the request should be
> >> +     * handled immediately.
> >> +     */
> >> +    while (!virtqueue_get_buf(vcrypto->ctrl_vq, &inlen) &&
> >> +        !virtqueue_is_broken(vcrypto->ctrl_vq))
> >> +        cpu_relax();
> >> +
> >> +    spin_unlock_irqrestore(&vcrypto->ctrl_lock, flags);
> >> +
> >> +    return 0;
> >> +}
> >> diff --git a/drivers/crypto/virtio/virtio_crypto_common.h
> >> b/drivers/crypto/virtio/virtio_crypto_common.h
> >> index e693d4ee83a6..d2a20fe6e13e 100644
> >> --- a/drivers/crypto/virtio/virtio_crypto_common.h
> >> +++ b/drivers/crypto/virtio/virtio_crypto_common.h
> >> @@ -13,6 +13,7 @@
> >>   #include <crypto/aead.h>
> >>   #include <crypto/aes.h>
> >>   #include <crypto/engine.h>
> >> +#include <uapi/linux/virtio_crypto.h>
> >>   /* Internal representation of a data virtqueue */
> >> @@ -65,11 +66,6 @@ struct virtio_crypto {
> >>       /* Maximum size of per request */
> >>       u64 max_size;
> >> -    /* Control VQ buffers: protected by the ctrl_lock */
> >> -    struct virtio_crypto_op_ctrl_req ctrl;
> >> -    struct virtio_crypto_session_input input;
> >> -    struct virtio_crypto_inhdr ctrl_status;
> >> -
> >>       unsigned long status;
> >>       atomic_t ref_count;
> >>       struct list_head list;
> >> @@ -85,6 +81,16 @@ struct virtio_crypto_sym_session_info {
> >>       __u64 session_id;
> >>   };
> >> +/*
> >> + * Note: there are padding fields in request, clear them to zero
> >> before sending to host,
> >> + * Ex, virtio_crypto_ctrl_request::ctrl::u::destroy_session::padding[=
48]
> >> + */
> >> +struct virtio_crypto_ctrl_request {
> >> +    struct virtio_crypto_op_ctrl_req ctrl;
> >> +    struct virtio_crypto_session_input input;
> >> +    struct virtio_crypto_inhdr ctrl_status;
> >> +};
> >> +
> >>   struct virtio_crypto_request;
> >>   typedef void (*virtio_crypto_data_callback)
> >>           (struct virtio_crypto_request *vc_req, int len);
> >> @@ -135,4 +141,7 @@ void virtio_crypto_skcipher_algs_unregister(struct
> >> virtio_crypto *vcrypto);
> >>   int virtio_crypto_akcipher_algs_register(struct virtio_crypto
> >> *vcrypto);
> >>   void virtio_crypto_akcipher_algs_unregister(struct virtio_crypto
> >> *vcrypto);
> >> +int virtio_crypto_ctrl_vq_request(struct virtio_crypto *vcrypto,
> >> struct scatterlist *sgs[],
> >> +                  unsigned int out_sgs, unsigned int in_sgs,
> >> +                  struct virtio_crypto_ctrl_request *vc_ctrl_req);
> >>   #endif /* _VIRTIO_CRYPTO_COMMON_H */
> >> diff --git a/drivers/crypto/virtio/virtio_crypto_skcipher_algs.c
> >> b/drivers/crypto/virtio/virtio_crypto_skcipher_algs.c
> >> index a618c46a52b8..fef355ff461c 100644
> >> --- a/drivers/crypto/virtio/virtio_crypto_skcipher_algs.c
> >> +++ b/drivers/crypto/virtio/virtio_crypto_skcipher_algs.c
> >> @@ -118,11 +118,13 @@ static int virtio_crypto_alg_skcipher_init_sessi=
on(
> >>           int encrypt)
> >>   {
> >>       struct scatterlist outhdr, key_sg, inhdr, *sgs[3];
> >> -    unsigned int tmp;
> >>       struct virtio_crypto *vcrypto =3D ctx->vcrypto;
> >
> >
> > Can we simply rename this to virtcrypto and then we can use the name
> > "vcrypto" for virtio_crypto_ctrl_request then we save tons lot changes?
> >
> > It simplify the life of reviewers and backporting.
> >
> > Thanks
> >
>
> This series focuses on performance improvment, and keeps the style with
> the orignal style. What about fixing this in another series? (If so,
> I'll fix this later)

Just in case we are at the same page, what I suggest can save hundreds
lines of codes:

E.g:

> >> -    vcrypto->ctrl.header.queue_id =3D 0;
> >> +    header->queue_id =3D 0;

If we stick to the name of "vcrypto" we don't need this change at all.

It can simplify:

1) future context difference when backporting patches to -stable
2) reviewing

Thanks

> >
> >>       int op =3D encrypt ? VIRTIO_CRYPTO_OP_ENCRYPT :
> >> VIRTIO_CRYPTO_OP_DECRYPT;
> >>       int err;
> >>       unsigned int num_out =3D 0, num_in =3D 0;
> >> +    struct virtio_crypto_ctrl_request *vc_ctrl_req;
> >> +    struct virtio_crypto_ctrl_header *header;
> >> +    struct virtio_crypto_sym_create_session_req *sym_create_session;
> >>       /*
> >>        * Avoid to do DMA from the stack, switch to using
> >> @@ -133,26 +135,27 @@ static int virtio_crypto_alg_skcipher_init_sessi=
on(
> >>       if (!cipher_key)
> >>           return -ENOMEM;
> >> -    spin_lock(&vcrypto->ctrl_lock);
> >> +    vc_ctrl_req =3D kzalloc(sizeof(*vc_ctrl_req), GFP_KERNEL);
> >> +    if (!vc_ctrl_req) {
> >> +        err =3D -ENOMEM;
> >> +        goto out;
> >> +    }
> >> +
> >>       /* Pad ctrl header */
> >> -    vcrypto->ctrl.header.opcode =3D
> >> -        cpu_to_le32(VIRTIO_CRYPTO_CIPHER_CREATE_SESSION);
> >> -    vcrypto->ctrl.header.algo =3D cpu_to_le32(alg);
> >> +    header =3D &vc_ctrl_req->ctrl.header;
> >> +    header->opcode =3D cpu_to_le32(VIRTIO_CRYPTO_CIPHER_CREATE_SESSIO=
N);
> >> +    header->algo =3D cpu_to_le32(alg);
> >>       /* Set the default dataqueue id to 0 */
> >> -    vcrypto->ctrl.header.queue_id =3D 0;
> >> +    header->queue_id =3D 0;
> >> -    vcrypto->input.status =3D cpu_to_le32(VIRTIO_CRYPTO_ERR);
> >>       /* Pad cipher's parameters */
> >> -    vcrypto->ctrl.u.sym_create_session.op_type =3D
> >> -        cpu_to_le32(VIRTIO_CRYPTO_SYM_OP_CIPHER);
> >> -    vcrypto->ctrl.u.sym_create_session.u.cipher.para.algo =3D
> >> -        vcrypto->ctrl.header.algo;
> >> -    vcrypto->ctrl.u.sym_create_session.u.cipher.para.keylen =3D
> >> -        cpu_to_le32(keylen);
> >> -    vcrypto->ctrl.u.sym_create_session.u.cipher.para.op =3D
> >> -        cpu_to_le32(op);
> >> -
> >> -    sg_init_one(&outhdr, &vcrypto->ctrl, sizeof(vcrypto->ctrl));
> >> +    sym_create_session =3D &vc_ctrl_req->ctrl.u.sym_create_session;
> >> +    sym_create_session->op_type =3D
> >> cpu_to_le32(VIRTIO_CRYPTO_SYM_OP_CIPHER);
> >> +    sym_create_session->u.cipher.para.algo =3D header->algo;
> >> +    sym_create_session->u.cipher.para.keylen =3D cpu_to_le32(keylen);
> >> +    sym_create_session->u.cipher.para.op =3D cpu_to_le32(op);
> >> +
> >> +    sg_init_one(&outhdr, &vc_ctrl_req->ctrl, sizeof(vc_ctrl_req->ctrl=
));
> >>       sgs[num_out++] =3D &outhdr;
> >>       /* Set key */
> >> @@ -160,45 +163,34 @@ static int virtio_crypto_alg_skcipher_init_sessi=
on(
> >>       sgs[num_out++] =3D &key_sg;
> >>       /* Return status and session id back */
> >> -    sg_init_one(&inhdr, &vcrypto->input, sizeof(vcrypto->input));
> >> +    vc_ctrl_req->input.status =3D cpu_to_le32(VIRTIO_CRYPTO_ERR);
> >> +    sg_init_one(&inhdr, &vc_ctrl_req->input,
> >> sizeof(vc_ctrl_req->input));
> >>       sgs[num_out + num_in++] =3D &inhdr;
> >> -    err =3D virtqueue_add_sgs(vcrypto->ctrl_vq, sgs, num_out,
> >> -                num_in, vcrypto, GFP_ATOMIC);
> >> -    if (err < 0) {
> >> -        spin_unlock(&vcrypto->ctrl_lock);
> >> -        kfree_sensitive(cipher_key);
> >> -        return err;
> >> -    }
> >> -    virtqueue_kick(vcrypto->ctrl_vq);
> >> -
> >> -    /*
> >> -     * Trapping into the hypervisor, so the request should be
> >> -     * handled immediately.
> >> -     */
> >> -    while (!virtqueue_get_buf(vcrypto->ctrl_vq, &tmp) &&
> >> -           !virtqueue_is_broken(vcrypto->ctrl_vq))
> >> -        cpu_relax();
> >> +    err =3D virtio_crypto_ctrl_vq_request(vcrypto, sgs, num_out,
> >> num_in, vc_ctrl_req);
> >> +    if (err < 0)
> >> +        goto out;
> >> -    if (le32_to_cpu(vcrypto->input.status) !=3D VIRTIO_CRYPTO_OK) {
> >> -        spin_unlock(&vcrypto->ctrl_lock);
> >> +    if (le32_to_cpu(vc_ctrl_req->input.status) !=3D VIRTIO_CRYPTO_OK)=
 {
> >>           pr_err("virtio_crypto: Create session failed status: %u\n",
> >> -            le32_to_cpu(vcrypto->input.status));
> >> -        kfree_sensitive(cipher_key);
> >> -        return -EINVAL;
> >> +            le32_to_cpu(vc_ctrl_req->input.status));
> >> +        err =3D -EINVAL;
> >> +        goto out;
> >>       }
> >>       if (encrypt)
> >>           ctx->enc_sess_info.session_id =3D
> >> -            le64_to_cpu(vcrypto->input.session_id);
> >> +            le64_to_cpu(vc_ctrl_req->input.session_id);
> >>       else
> >>           ctx->dec_sess_info.session_id =3D
> >> -            le64_to_cpu(vcrypto->input.session_id);
> >> -
> >> -    spin_unlock(&vcrypto->ctrl_lock);
> >> +            le64_to_cpu(vc_ctrl_req->input.session_id);
> >> +    err =3D 0;
> >> +out:
> >> +    kfree(vc_ctrl_req);
> >>       kfree_sensitive(cipher_key);
> >> -    return 0;
> >> +
> >> +    return err;
> >>   }
> >>   static int virtio_crypto_alg_skcipher_close_session(
> >> @@ -206,21 +198,24 @@ static int
> >> virtio_crypto_alg_skcipher_close_session(
> >>           int encrypt)
> >>   {
> >>       struct scatterlist outhdr, status_sg, *sgs[2];
> >> -    unsigned int tmp;
> >>       struct virtio_crypto_destroy_session_req *destroy_session;
> >>       struct virtio_crypto *vcrypto =3D ctx->vcrypto;
> >>       int err;
> >>       unsigned int num_out =3D 0, num_in =3D 0;
> >> +    struct virtio_crypto_ctrl_request *vc_ctrl_req;
> >> +    struct virtio_crypto_ctrl_header *header;
> >> +
> >> +    vc_ctrl_req =3D kzalloc(sizeof(*vc_ctrl_req), GFP_KERNEL);
> >> +    if (!vc_ctrl_req)
> >> +        return -ENOMEM;
> >> -    spin_lock(&vcrypto->ctrl_lock);
> >> -    vcrypto->ctrl_status.status =3D VIRTIO_CRYPTO_ERR;
> >>       /* Pad ctrl header */
> >> -    vcrypto->ctrl.header.opcode =3D
> >> -        cpu_to_le32(VIRTIO_CRYPTO_CIPHER_DESTROY_SESSION);
> >> +    header =3D &vc_ctrl_req->ctrl.header;
> >> +    header->opcode =3D cpu_to_le32(VIRTIO_CRYPTO_CIPHER_DESTROY_SESSI=
ON);
> >>       /* Set the default virtqueue id to 0 */
> >> -    vcrypto->ctrl.header.queue_id =3D 0;
> >> +    header->queue_id =3D 0;
> >> -    destroy_session =3D &vcrypto->ctrl.u.destroy_session;
> >> +    destroy_session =3D &vc_ctrl_req->ctrl.u.destroy_session;
> >>       if (encrypt)
> >>           destroy_session->session_id =3D
> >> @@ -229,37 +224,33 @@ static int
> >> virtio_crypto_alg_skcipher_close_session(
> >>           destroy_session->session_id =3D
> >>               cpu_to_le64(ctx->dec_sess_info.session_id);
> >> -    sg_init_one(&outhdr, &vcrypto->ctrl, sizeof(vcrypto->ctrl));
> >> +    sg_init_one(&outhdr, &vc_ctrl_req->ctrl, sizeof(vc_ctrl_req->ctrl=
));
> >>       sgs[num_out++] =3D &outhdr;
> >>       /* Return status and session id back */
> >> -    sg_init_one(&status_sg, &vcrypto->ctrl_status.status,
> >> -        sizeof(vcrypto->ctrl_status.status));
> >> +    vc_ctrl_req->ctrl_status.status =3D VIRTIO_CRYPTO_ERR;
> >> +    sg_init_one(&status_sg, &vc_ctrl_req->ctrl_status.status,
> >> +        sizeof(vc_ctrl_req->ctrl_status.status));
> >>       sgs[num_out + num_in++] =3D &status_sg;
> >> -    err =3D virtqueue_add_sgs(vcrypto->ctrl_vq, sgs, num_out,
> >> -            num_in, vcrypto, GFP_ATOMIC);
> >> -    if (err < 0) {
> >> -        spin_unlock(&vcrypto->ctrl_lock);
> >> -        return err;
> >> -    }
> >> -    virtqueue_kick(vcrypto->ctrl_vq);
> >> -
> >> -    while (!virtqueue_get_buf(vcrypto->ctrl_vq, &tmp) &&
> >> -           !virtqueue_is_broken(vcrypto->ctrl_vq))
> >> -        cpu_relax();
> >> +    err =3D virtio_crypto_ctrl_vq_request(vcrypto, sgs, num_out,
> >> num_in, vc_ctrl_req);
> >> +    if (err < 0)
> >> +        goto out;
> >> -    if (vcrypto->ctrl_status.status !=3D VIRTIO_CRYPTO_OK) {
> >> -        spin_unlock(&vcrypto->ctrl_lock);
> >> +    if (vc_ctrl_req->ctrl_status.status !=3D VIRTIO_CRYPTO_OK) {
> >>           pr_err("virtio_crypto: Close session failed status: %u,
> >> session_id: 0x%llx\n",
> >> -            vcrypto->ctrl_status.status,
> >> +            vc_ctrl_req->ctrl_status.status,
> >>               destroy_session->session_id);
> >> -        return -EINVAL;
> >> +        err =3D -EINVAL;
> >> +        goto out;
> >>       }
> >> -    spin_unlock(&vcrypto->ctrl_lock);
> >> -    return 0;
> >> +    err =3D 0;
> >> +out:
> >> +    kfree(vc_ctrl_req);
> >> +
> >> +    return err;
> >>   }
> >>   static int virtio_crypto_alg_skcipher_init_sessions(
> >
>
> --
> zhenwei pi
>

