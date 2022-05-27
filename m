Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80261535CD3
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 11:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350194AbiE0Iyt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 04:54:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350167AbiE0IxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 04:53:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2E20C46B3F
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 01:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653641569;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cUv5tpS5RGrDYRnAjsYwiC+v1VkMuttRdgrw+2d7f3M=;
        b=J22HiRiXNwVBo8FO/ASP43BByGmfKE7BEgxbdKxHh2tG85rmgptoWqfD/h3Bkuwn1rzcuc
        NuD0Dvcw/cxTUiQYRLOXQmkahfq+Ge16LWPpCKs93hdDaoxhu4F/+85EJWkQclm2XdJapI
        /RXDwqF7vJ0ugKDHm0zhgsGWZ291lns=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-371-ybN1uBEnPueY11CtWvZ5xQ-1; Fri, 27 May 2022 04:52:48 -0400
X-MC-Unique: ybN1uBEnPueY11CtWvZ5xQ-1
Received: by mail-qt1-f200.google.com with SMTP id w21-20020a05622a135500b002f3b801f51eso3827562qtk.23
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 01:52:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cUv5tpS5RGrDYRnAjsYwiC+v1VkMuttRdgrw+2d7f3M=;
        b=7k1f0E6JUBBi7PaJSsE7yRf/18rudQVInFdd8TU9k7ndeeJPawulYdpOxo8RyVuSUN
         L8cXQqGhiN6oCWfMUsPhecTWT53RURk39g1qXMlfouKKllUaEseQZ11cruA+880LSKO0
         6/UoxpTBwmY2tLEmAZL+RrCOLph4aTNaOgJK69OjUWqcqdo/QI2flV5r1jgwBMCq5dmh
         EE0hJfF9Cf0u0GPiW+FPL0idaY41kE5qlLNG4J5epa2CF4KVRS/WWr5Fp9UEKGuY/fvW
         xzrxoGswAQBAc2mw9Lh+/+LLGEl8SwWeot/fj11FrF7CjrnCLlbFkQ2HeP0JLDAMMHet
         8rFw==
X-Gm-Message-State: AOAM5329AOAs3o4VrljFhmDJVZa2UT9itp0EH+7+QuK1jd4E+EbPk7Gd
        H453eOH3MV+MqUlELSHKpco09dDmXgiI8rNRclUFDc5xe0GI6NN20QyJ++mr/dIHisThsu4BAzR
        +P5vhALZdnpFMkiukwWpG3S6B0aFAz7oEzLMkOAKc
X-Received: by 2002:a05:622a:1a08:b0:2fb:e220:271b with SMTP id f8-20020a05622a1a0800b002fbe220271bmr6997228qtb.221.1653641567530;
        Fri, 27 May 2022 01:52:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwKqH0anNdhavibGTRGCo+d9MXqgc9ldarPAg5gL/d0srfgCERUMp8nLOCw758Ke0YknAIw06QDtuklBZExwkw=
X-Received: by 2002:a05:622a:1a08:b0:2fb:e220:271b with SMTP id
 f8-20020a05622a1a0800b002fbe220271bmr6997219qtb.221.1653641567335; Fri, 27
 May 2022 01:52:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220527060120.20964-1-jasowang@redhat.com> <20220527060120.20964-3-jasowang@redhat.com>
In-Reply-To: <20220527060120.20964-3-jasowang@redhat.com>
From:   Eugenio Perez Martin <eperezma@redhat.com>
Date:   Fri, 27 May 2022 10:52:11 +0200
Message-ID: <CAJaqyWf+afFW-JxF1wpYm5mvO3Am7BDMQX+X+SOe=+B_LA-ceA@mail.gmail.com>
Subject: Re: [PATCH V6 2/9] virtio: use virtio_reset_device() when possible
To:     Jason Wang <jasowang@redhat.com>
Cc:     Michael Tsirkin <mst@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, tglx@linutronix.de,
        peterz@infradead.org, paulmck@kernel.org, maz@kernel.org,
        Halil Pasic <pasic@linux.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>, Cindy Lu <lulu@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        xuanzhuo@linux.alibaba.com,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 27, 2022 at 8:01 AM Jason Wang <jasowang@redhat.com> wrote:
>
> This allows us to do common extension without duplicating code.
>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Halil Pasic <pasic@linux.ibm.com>
> Cc: Cornelia Huck <cohuck@redhat.com>
> Cc: Vineeth Vijayan <vneethv@linux.ibm.com>
> Cc: Peter Oberparleiter <oberpar@linux.ibm.com>
> Cc: linux-s390@vger.kernel.org
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Reviewed-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> ---
>  drivers/virtio/virtio.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> index 938e975029d4..aa1eb5132767 100644
> --- a/drivers/virtio/virtio.c
> +++ b/drivers/virtio/virtio.c
> @@ -430,7 +430,7 @@ int register_virtio_device(struct virtio_device *dev)
>
>         /* We always start by resetting the device, in case a previous
>          * driver messed it up.  This also tests that code path a little.=
 */
> -       dev->config->reset(dev);
> +       virtio_reset_device(dev);
>
>         /* Acknowledge that we've seen the device. */
>         virtio_add_status(dev, VIRTIO_CONFIG_S_ACKNOWLEDGE);
> @@ -496,7 +496,7 @@ int virtio_device_restore(struct virtio_device *dev)
>
>         /* We always start by resetting the device, in case a previous
>          * driver messed it up. */
> -       dev->config->reset(dev);
> +       virtio_reset_device(dev);
>
>         /* Acknowledge that we've seen the device. */
>         virtio_add_status(dev, VIRTIO_CONFIG_S_ACKNOWLEDGE);
> --
> 2.25.1
>

