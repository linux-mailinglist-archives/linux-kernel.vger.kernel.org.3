Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23AC9535A83
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 09:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347545AbiE0HeL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 03:34:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347412AbiE0HeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 03:34:01 -0400
Received: from out199-4.us.a.mail.aliyun.com (out199-4.us.a.mail.aliyun.com [47.90.199.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33975F7481;
        Fri, 27 May 2022 00:33:59 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=alimailimapcm10staff010182156082;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0VEW7k5j_1653636835;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0VEW7k5j_1653636835)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 27 May 2022 15:33:55 +0800
Message-ID: <1653636827.6549792-6-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH V6 7/9] virtio: allow to unbreak virtqueue
Date:   Fri, 27 May 2022 15:33:47 +0800
From:   Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     tglx@linutronix.de, peterz@infradead.org, paulmck@kernel.org,
        maz@kernel.org, pasic@linux.ibm.com, cohuck@redhat.com,
        eperezma@redhat.com, lulu@redhat.com, sgarzare@redhat.com,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        linux-s390@vger.kernel.org, mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20220527060120.20964-1-jasowang@redhat.com>
 <20220527060120.20964-8-jasowang@redhat.com>
In-Reply-To: <20220527060120.20964-8-jasowang@redhat.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 May 2022 14:01:18 +0800, Jason Wang <jasowang@redhat.com> wrote:
> This patch allows the new introduced __virtio_break_device() to
> unbreak the virtqueue.
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
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

> ---
>  drivers/virtio/virtio_ring.c | 22 ++++++++++++++++++++++
>  include/linux/virtio.h       |  1 +
>  2 files changed, 23 insertions(+)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 9d0bae4293be..9c231e1fded7 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -2395,6 +2395,28 @@ void virtio_break_device(struct virtio_device *dev)
>  }
>  EXPORT_SYMBOL_GPL(virtio_break_device);
>
> +/*
> + * This should allow the device to be used by the driver. You may
> + * need to grab appropriate locks to flush the write to
> + * vq->broken. This should only be used in some specific case e.g
> + * (probing and restoring). This function should only be called by the
> + * core, not directly by the driver.
> + */
> +void __virtio_unbreak_device(struct virtio_device *dev)
> +{
> +	struct virtqueue *_vq;
> +
> +	spin_lock(&dev->vqs_list_lock);
> +	list_for_each_entry(_vq, &dev->vqs, list) {
> +		struct vring_virtqueue *vq = to_vvq(_vq);
> +
> +		/* Pairs with READ_ONCE() in virtqueue_is_broken(). */
> +		WRITE_ONCE(vq->broken, false);
> +	}
> +	spin_unlock(&dev->vqs_list_lock);
> +}
> +EXPORT_SYMBOL_GPL(__virtio_unbreak_device);
> +
>  dma_addr_t virtqueue_get_desc_addr(struct virtqueue *_vq)
>  {
>  	struct vring_virtqueue *vq = to_vvq(_vq);
> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> index 5464f398912a..d8fdf170637c 100644
> --- a/include/linux/virtio.h
> +++ b/include/linux/virtio.h
> @@ -131,6 +131,7 @@ void unregister_virtio_device(struct virtio_device *dev);
>  bool is_virtio_device(struct device *dev);
>
>  void virtio_break_device(struct virtio_device *dev);
> +void __virtio_unbreak_device(struct virtio_device *dev);
>
>  void virtio_config_changed(struct virtio_device *dev);
>  #ifdef CONFIG_PM_SLEEP
> --
> 2.25.1
>
