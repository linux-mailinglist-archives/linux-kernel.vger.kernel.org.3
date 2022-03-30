Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 985024EBB41
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 08:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243482AbiC3G7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 02:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243481AbiC3G7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 02:59:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F32BEDE09D
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 23:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648623439;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BlGn54gkEq56ZEq4yxxp6UGaagJu669pehgEVDXqc+s=;
        b=JfO21q6AP2CB0bPufxCcPse3Isj3ieXGImKPMzD1HZtxyllfBMzcthn0DnyZY3a9Q78WPf
        fL8FjztkJ+D2dflI4io+QHzF2qlLamjOH3FFr2Fdr1YenbMgrBFCY5qddd2RtX9JnAzw2C
        exUhKOn7NoY6veX2acuWnvbkkXHVc6g=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-376-k4ezvre6O3uhKkg5gU3xIA-1; Wed, 30 Mar 2022 02:57:15 -0400
X-MC-Unique: k4ezvre6O3uhKkg5gU3xIA-1
Received: by mail-lj1-f200.google.com with SMTP id 20-20020a05651c009400b002462f08f8d2so8330867ljq.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 23:57:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BlGn54gkEq56ZEq4yxxp6UGaagJu669pehgEVDXqc+s=;
        b=blALhtYZze+dJbcUtwVNIvxOGu+DmC2ggQCJn8UrG6//6HHaXcBf/X2BZxmuHsj9XG
         Yq0WuO1ylrFjGsYns1SNNJGxJVKqP1sIRoXrdNGYkzNVGonc7TdUdpwp1kC5XRnynpD/
         wpbgmhzOeGMVqR5Jpba0gubH6ziXAX021EnYUbaTG5dqtcPFxI3/ZTRzzbsrAUmvxNuq
         vQbSucyk0VjsIskuDx1yNlY5oF1BTs3zhtQba3CxKkmicYIb3weeY/Rnqtp8PQuIpt3o
         tTiDX+tfhJUeYLc/8yqeLh8MNNlaZyAdZUzaIBKZ2bSwMABbSJ+BRfnHkRtdSMmnOJWt
         PPuw==
X-Gm-Message-State: AOAM530+wyq6dVzh62q/+O0ycgrZ+mBTtC7iApscPiWbzxAOHSacRRj6
        ybCxj2hLoxuwUcYySz8elRdmS7M0CdQqs/CAuumyP0jtRbEltWsKhMBWSZ7Iu7NKr/SuOngd7xp
        VoEF2y7Ob/irBlmavhQcMD3qrb2uNkwlKApyraTOW
X-Received: by 2002:a05:6512:3341:b0:433:b033:bd22 with SMTP id y1-20020a056512334100b00433b033bd22mr5802730lfd.190.1648623433274;
        Tue, 29 Mar 2022 23:57:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyxgBMDOOCDdXaX9T2w++d+QTu7fkFTESyY1gxiCdJXf/23pMTqhJyEoQUM51UXvHb14nmZ7AXVi9wIgw55ET0=
X-Received: by 2002:a05:6512:3341:b0:433:b033:bd22 with SMTP id
 y1-20020a056512334100b00433b033bd22mr5802717lfd.190.1648623432982; Tue, 29
 Mar 2022 23:57:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220330062315.125924-1-mst@redhat.com> <20220330062315.125924-2-mst@redhat.com>
In-Reply-To: <20220330062315.125924-2-mst@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Wed, 30 Mar 2022 14:57:02 +0800
Message-ID: <CACGkMEvWDQWOWqM6xvxSHkXqGf5_kPR6-enrLUvhA4WW=p0ZYw@mail.gmail.com>
Subject: Re: [PATCH 2/2] Revert "virtio_config: introduce a new .enable_cbs method"
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        virtualization <virtualization@lists.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 30, 2022 at 2:23 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> This reverts commit d50497eb4e554e1f0351e1836ee7241c059592e6.
>
> The new callback ended up not being used, and it's asymmetrical:
> just enable, no disable.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Acked-by: Jason Wang <jasowang@redhat.com>

> ---
>  include/linux/virtio_config.h | 6 ------
>  1 file changed, 6 deletions(-)
>
> diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
> index dafdc7f48c01..b341dd62aa4d 100644
> --- a/include/linux/virtio_config.h
> +++ b/include/linux/virtio_config.h
> @@ -23,8 +23,6 @@ struct virtio_shm_region {
>   *       any of @get/@set, @get_status/@set_status, or @get_features/
>   *       @finalize_features are NOT safe to be called from an atomic
>   *       context.
> - * @enable_cbs: enable the callbacks
> - *      vdev: the virtio_device
>   * @get: read the value of a configuration field
>   *     vdev: the virtio_device
>   *     offset: the offset of the configuration field
> @@ -78,7 +76,6 @@ struct virtio_shm_region {
>   */
>  typedef void vq_callback_t(struct virtqueue *);
>  struct virtio_config_ops {
> -       void (*enable_cbs)(struct virtio_device *vdev);
>         void (*get)(struct virtio_device *vdev, unsigned offset,
>                     void *buf, unsigned len);
>         void (*set)(struct virtio_device *vdev, unsigned offset,
> @@ -233,9 +230,6 @@ void virtio_device_ready(struct virtio_device *dev)
>  {
>         unsigned status = dev->config->get_status(dev);
>
> -       if (dev->config->enable_cbs)
> -                  dev->config->enable_cbs(dev);
> -
>         BUG_ON(status & VIRTIO_CONFIG_S_DRIVER_OK);
>         dev->config->set_status(dev, status | VIRTIO_CONFIG_S_DRIVER_OK);
>  }
> --
> MST
>

