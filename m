Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3ABE55F902
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 09:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231878AbiF2H3G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 03:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231650AbiF2H3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 03:29:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4A97E1E3C0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 00:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656487741;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xiRibrSvAoM6W9wAB2ExJi4FE4mfhgvmaHhoHqyyRbM=;
        b=CEnDPJV9nKAnpMhSr6zMz8l2RD84Dp1/bf/Dt3aK8bOrlhuXSliWDyaOOIz4qH0J9Xm0tp
        RqrEhbgJcUapHWO7sVDvBF3V/N3SVPoj6xGvkKMedQnlqKnIGRFdCGDoPWv/EZ/Pix9sH+
        nalfn3piBJWLn2p360n6kVys+IWRgzs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-259-ntPgwXi3O32MNyMq12nvRg-1; Wed, 29 Jun 2022 03:29:00 -0400
X-MC-Unique: ntPgwXi3O32MNyMq12nvRg-1
Received: by mail-wm1-f72.google.com with SMTP id p6-20020a05600c358600b003a0483b3c2eso4943894wmq.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 00:29:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xiRibrSvAoM6W9wAB2ExJi4FE4mfhgvmaHhoHqyyRbM=;
        b=Hkb2W/6Pkhb5xY8AjtJ+yLUn2qtRxdBgehxN2AQ4zXHDMjQ6iEXkfXSmaA63foeFN1
         gi5/523SmDF+WdlV6OOWkoF/8G+TdLOXOxDBdmGoIre3bLIsRHRvQOWcEWkTM1So87of
         CT2mdFv76q+PQwoGxWmsgVLUQn5yxcPNk8rr2Qnr7zIP4Y9nlkvlDpIuvMmZR3aCOvMR
         aY0UYRtQeisseA4cCBgLewUlKpFN1Ywq6i312o8Lqv4cSNaTOi67xN1ZmlZlvEzs8JY2
         Y/VMUWGnWV9h3E0c0Usjgknqmz6D8i0wuUhxY8+eulK9cckz4kaQ1btFZEIYlLoNfIXk
         0xWw==
X-Gm-Message-State: AJIora/fp4Rw/G2+gxeWnZg/cc8eugQhGJ7wZqc9h/M9/hc3sHmdywBV
        W+y+ENYrLhzAcPqjSOL5s+K/W6M4X1LzQzz+7czvZBRcUyJMLgjL/ycV/Mt/EN3j8anVbVw/2N0
        848gVmmEEHZQBQsv30RZH8x8P
X-Received: by 2002:a7b:cf18:0:b0:3a0:54b3:d848 with SMTP id l24-20020a7bcf18000000b003a054b3d848mr2058472wmg.3.1656487738711;
        Wed, 29 Jun 2022 00:28:58 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tfysaLsrnPck1jxZb3L9c6KAMx3q01zMPf4AMhC3h7kyffbacEWnGaGpxGMi+HZGbpOMCBGQ==
X-Received: by 2002:a7b:cf18:0:b0:3a0:54b3:d848 with SMTP id l24-20020a7bcf18000000b003a054b3d848mr2058448wmg.3.1656487738440;
        Wed, 29 Jun 2022 00:28:58 -0700 (PDT)
Received: from redhat.com ([2.52.23.204])
        by smtp.gmail.com with ESMTPSA id u3-20020a05600c210300b003a044fe7fe7sm2075973wml.9.2022.06.29.00.28.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 00:28:57 -0700 (PDT)
Date:   Wed, 29 Jun 2022 03:28:53 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     davem@davemloft.net, kuba@kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtio-net: fix the race between refill work and close
Message-ID: <20220629032106-mutt-send-email-mst@kernel.org>
References: <20220628090324.62219-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220628090324.62219-1-jasowang@redhat.com>
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2022 at 05:03:24PM +0800, Jason Wang wrote:
> We try using cancel_delayed_work_sync() to prevent the work from
> enabling NAPI. This is insufficient since we don't disable the the
> source the scheduling

can't parse this sentence

> of the refill work. This means an NAPI

what do you mean "an NAPI"? a NAPI poll callback?

> after
> cancel_delayed_work_sync() can schedule the refill work then can
> re-enable the NAPI that leads to use-after-free [1].
> 
> Since the work can enable NAPI, we can't simply disable NAPI before
> calling cancel_delayed_work_sync(). So fix this by introducing a
> dedicated boolean to control whether or not the work could be
> scheduled from NAPI.
> 
> [1]
> ==================================================================
> BUG: KASAN: use-after-free in refill_work+0x43/0xd4
> Read of size 2 at addr ffff88810562c92e by task kworker/2:1/42
> 
> CPU: 2 PID: 42 Comm: kworker/2:1 Not tainted 5.19.0-rc1+ #480
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
> Workqueue: events refill_work
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x34/0x44
>  print_report.cold+0xbb/0x6ac
>  ? _printk+0xad/0xde
>  ? refill_work+0x43/0xd4
>  kasan_report+0xa8/0x130
>  ? refill_work+0x43/0xd4
>  refill_work+0x43/0xd4
>  process_one_work+0x43d/0x780
>  worker_thread+0x2a0/0x6f0
>  ? process_one_work+0x780/0x780
>  kthread+0x167/0x1a0
>  ? kthread_exit+0x50/0x50
>  ret_from_fork+0x22/0x30
>  </TASK>
> ...
> 
> Fixes: b2baed69e605c ("virtio_net: set/cancel work on ndo_open/ndo_stop")
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/net/virtio_net.c | 38 ++++++++++++++++++++++++++++++++++++--
>  1 file changed, 36 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index db05b5e930be..21bf1e5c81ef 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -251,6 +251,12 @@ struct virtnet_info {
>  	/* Does the affinity hint is set for virtqueues? */
>  	bool affinity_hint_set;
>  
> +	/* Is refill work enabled? */
> +	bool refill_work_enabled;
> +
> +	/* The lock to synchronize the access to refill_work_enabled */
> +	spinlock_t refill_lock;
> +
>  	/* CPU hotplug instances for online & dead */
>  	struct hlist_node node;
>  	struct hlist_node node_dead;
> @@ -348,6 +354,20 @@ static struct page *get_a_page(struct receive_queue *rq, gfp_t gfp_mask)
>  	return p;
>  }
>  
> +static void enable_refill_work(struct virtnet_info *vi)
> +{
> +	spin_lock(&vi->refill_lock);
> +	vi->refill_work_enabled = true;
> +	spin_unlock(&vi->refill_lock);
> +}
> +
> +static void disable_refill_work(struct virtnet_info *vi)
> +{
> +	spin_lock(&vi->refill_lock);
> +	vi->refill_work_enabled = false;
> +	spin_unlock(&vi->refill_lock);
> +}
> +
>  static void virtqueue_napi_schedule(struct napi_struct *napi,
>  				    struct virtqueue *vq)
>  {
> @@ -1527,8 +1547,12 @@ static int virtnet_receive(struct receive_queue *rq, int budget,
>  	}
>  
>  	if (rq->vq->num_free > min((unsigned int)budget, virtqueue_get_vring_size(rq->vq)) / 2) {
> -		if (!try_fill_recv(vi, rq, GFP_ATOMIC))
> -			schedule_delayed_work(&vi->refill, 0);
> +		if (!try_fill_recv(vi, rq, GFP_ATOMIC)) {
> +			spin_lock(&vi->refill_lock);
> +			if (vi->refill_work_enabled)
> +				schedule_delayed_work(&vi->refill, 0);
> +			spin_unlock(&vi->refill_lock);
> +		}
>  	}
>  
>  	u64_stats_update_begin(&rq->stats.syncp);
> @@ -1651,6 +1675,8 @@ static int virtnet_open(struct net_device *dev)
>  	struct virtnet_info *vi = netdev_priv(dev);
>  	int i, err;
>  
> +	enable_refill_work(vi);
> +
>  	for (i = 0; i < vi->max_queue_pairs; i++) {
>  		if (i < vi->curr_queue_pairs)
>  			/* Make sure we have some buffers: if oom use wq. */
> @@ -2033,6 +2059,8 @@ static int virtnet_close(struct net_device *dev)
>  	struct virtnet_info *vi = netdev_priv(dev);
>  	int i;
>  
> +	/* Make sure NAPI doesn't schedule refill work */
> +	disable_refill_work(vi);
>  	/* Make sure refill_work doesn't re-enable napi! */
>  	cancel_delayed_work_sync(&vi->refill);
>  
> @@ -2776,6 +2804,9 @@ static void virtnet_freeze_down(struct virtio_device *vdev)
>  	netif_tx_lock_bh(vi->dev);
>  	netif_device_detach(vi->dev);
>  	netif_tx_unlock_bh(vi->dev);
> +	/* Make sure NAPI doesn't schedule refill work */
> +	disable_refill_work(vi);
> +	/* Make sure refill_work doesn't re-enable napi! */
>  	cancel_delayed_work_sync(&vi->refill);
>  
>  	if (netif_running(vi->dev)) {
> @@ -2799,6 +2830,8 @@ static int virtnet_restore_up(struct virtio_device *vdev)
>  
>  	virtio_device_ready(vdev);
>  
> +	enable_refill_work(vi);
> +
>  	if (netif_running(vi->dev)) {
>  		for (i = 0; i < vi->curr_queue_pairs; i++)
>  			if (!try_fill_recv(vi, &vi->rq[i], GFP_KERNEL))
> @@ -3548,6 +3581,7 @@ static int virtnet_probe(struct virtio_device *vdev)
>  	vdev->priv = vi;
>  
>  	INIT_WORK(&vi->config_work, virtnet_config_changed_work);
> +	spin_lock_init(&vi->refill_lock);
>  
>  	/* If we can receive ANY GSO packets, we must allocate large ones. */
>  	if (virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO4) ||


Can't say I love all the extra state but oh well.

> -- 
> 2.25.1

