Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8FB658781B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 09:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236065AbiHBHpV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 03:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235945AbiHBHpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 03:45:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 64273DE4
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 00:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659426315;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n2QKGORUPt90s3M7laRV8rZjur0eTOpV52LUAMCgLrw=;
        b=iAElqphaXnmwvl5k/N0oZ1rktEMrxHy680Tb1NQaQkntAauLcdM0L1RCT1ri+Bygppe8o1
        eKsHlvV0LlI+PUc0A9YkHBvQ1ybYs30hkQ4bUXnSzTFO9s2aU0eAOJQ43WqL8l0scw0NLQ
        y8I02Cx7bQ6CGmhbQQ9kPpEDL2/V+AE=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-210-Mg2aHvwJP9-debxbZljakA-1; Tue, 02 Aug 2022 03:45:13 -0400
X-MC-Unique: Mg2aHvwJP9-debxbZljakA-1
Received: by mail-lf1-f70.google.com with SMTP id o4-20020ac25e24000000b0048af174d5bdso1887319lfg.9
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 00:45:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=n2QKGORUPt90s3M7laRV8rZjur0eTOpV52LUAMCgLrw=;
        b=QzRzRjk9zRwSRu03QhCtKnhXUN+oezzpKWjZrxo8Gonn9Bn3ItiGFlUJTrLBag4RsB
         bWp3oaxhABIKpuq/GvcETErdSH3jJGcKU226uZwNoNTXQB0VUh1qzoneaxWS9+0od1i+
         N9q89BdiwJ6gzSQ+XD+cOY61EWdTDld6qTF4j++80GcOjj2VXphChqHsA9/uxXalN1c6
         6NPLN+pTsRxWGJg0EeEdyi4ZUdu1BlV7PPdcsOBMIR4xYvV8GGRVkdxkSkrC2vtX/0kt
         2t5xi1W/uDBFeNGmJ+ktmj4piD53CtFTbkO0yRFkBIPP8s1Qd41mMX/6q9Vyzja2Gdzm
         btXA==
X-Gm-Message-State: AJIora/kCGm05e86KySZs+0Iwk1xUdwaBkCPV30vc3vF4h5mb7O8ymgJ
        bLhKUUOfoFdXmj/unpBiwVLUlH/2UBKnoB+diWYP1EyFUuP6mTw+STVW1BLOddt7ndU1+wMYft7
        s8C5QX1hSE0+j3y7I2ngXT+8zIs/+RDP4b76hD1/A
X-Received: by 2002:a2e:82c6:0:b0:25d:eef5:8096 with SMTP id n6-20020a2e82c6000000b0025deef58096mr6288541ljh.201.1659426312321;
        Tue, 02 Aug 2022 00:45:12 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tIVif5PVmN7a8VhTns7vhbkHiwcEFEE4L31UG6gd+2t07IqYSwiB0aIDCfwMP5XF9mr/mf+ZUHXWrTlopG4R8=
X-Received: by 2002:a2e:82c6:0:b0:25d:eef5:8096 with SMTP id
 n6-20020a2e82c6000000b0025deef58096mr6288536ljh.201.1659426312110; Tue, 02
 Aug 2022 00:45:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220721084341.24183-1-qtxuning1999@sjtu.edu.cn>
 <20220721084341.24183-4-qtxuning1999@sjtu.edu.cn> <CAJaqyWfgUqdP6mkOUdouvQSst=qc7MOTaigC-EiTg9-gojHqzg@mail.gmail.com>
 <1D1ABF88-B503-4BE0-AC83-3326EAA62510@sjtu.edu.cn>
In-Reply-To: <1D1ABF88-B503-4BE0-AC83-3326EAA62510@sjtu.edu.cn>
From:   Stefano Garzarella <sgarzare@redhat.com>
Date:   Tue, 2 Aug 2022 09:45:00 +0200
Message-ID: <CAGxU2F4-aBTP=CwzTKutiSqHQL++zfMmK_dCoR+t=BJA9AvhFQ@mail.gmail.com>
Subject: Re: [RFC 3/5] vhost_test: batch used buffer
To:     Zhi Guo <qtxuning1999@sjtu.edu.cn>
Cc:     Eugenio Perez Martin <eperezma@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Michael Tsirkin <mst@redhat.com>,
        netdev <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>,
        virtualization <virtualization@lists.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 2, 2022 at 4:45 AM Zhi Guo <qtxuning1999@sjtu.edu.cn> wrote:
>
>
>
> 2022=E5=B9=B47=E6=9C=8822=E6=97=A5 =E4=B8=8B=E5=8D=883:12=EF=BC=8CEugenio=
 Perez Martin <eperezma@redhat.com> =E5=86=99=E9=81=93=EF=BC=9A
>
> On Thu, Jul 21, 2022 at 10:44 AM Guo Zhi <qtxuning1999@sjtu.edu.cn> wrote=
:
>
>
> Only add to used ring when a batch a buffer have all been used.  And if
> in order feature negotiated, add randomness to the used buffer's order,
> test the ability of vhost to reorder batched buffer.
>
> Signed-off-by: Guo Zhi <qtxuning1999@sjtu.edu.cn>
> ---
> drivers/vhost/test.c | 15 ++++++++++++++-
> 1 file changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/vhost/test.c b/drivers/vhost/test.c
> index bc8e7fb1e..1c9c40c11 100644
> --- a/drivers/vhost/test.c
> +++ b/drivers/vhost/test.c
> @@ -43,6 +43,9 @@ struct vhost_test {
> static void handle_vq(struct vhost_test *n)
> {
>        struct vhost_virtqueue *vq =3D &n->vqs[VHOST_TEST_VQ];
> +       struct vring_used_elem *heads =3D kmalloc(sizeof(*heads)
> +                       * vq->num, GFP_KERNEL);
> +       int batch_idx =3D 0;
>        unsigned out, in;
>        int head;
>        size_t len, total_len =3D 0;
> @@ -84,11 +87,21 @@ static void handle_vq(struct vhost_test *n)
>                        vq_err(vq, "Unexpected 0 len for TX\n");
>                        break;
>                }
> -               vhost_add_used_and_signal(&n->dev, vq, head, 0);
> +               heads[batch_idx].id =3D cpu_to_vhost32(vq, head);
> +               heads[batch_idx++].len =3D cpu_to_vhost32(vq, len);
>                total_len +=3D len;
>                if (unlikely(vhost_exceeds_weight(vq, 0, total_len)))
>                        break;
>        }
> +       if (batch_idx) {
> +               if (vhost_has_feature(vq, VIRTIO_F_IN_ORDER) && batch_idx=
 >=3D 2) {
>
>
> Maybe to add a module parameter to test this? Instead of trusting in
> feature negotiation, "unorder_used=3D1" or something like that.
>
> vhost.c:vhost_add_used_and_signal_n should support receiving buffers
> in order or out of order whether F_IN_ORDER is negotiated or not.
>
> Thanks!
>
> That=E2=80=99s a good idea, The reorder feature in vhost is a "workaround=
=E2=80=9D solution for the device that can't consume buffer in order,
> If that device support in order feature, The reorder in vhost will not be=
 used.
> So we can add a parameter in vhost_test can config in order or not in ord=
er usage for used descriptors.
> A global parameter in vhost_test.c is enough?

Maybe a module parameter is easier to use (or a sysfs file), and to
test we don't need to recompile the module every time.

In view of having a CI, it's definitely easier to set the module
parameter than to recompile it.

Thanks,
Stefano

