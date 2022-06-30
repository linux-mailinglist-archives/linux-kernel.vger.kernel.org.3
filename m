Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96AFE561244
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 08:08:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232743AbiF3GIQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 02:08:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232106AbiF3GIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 02:08:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 88BB91122
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 23:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656569287;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8F2nUeN3UIGvhWhPwdXFRxrBpN+YKacrhMVno3b0HOE=;
        b=DCGVpnElsO3BwLDIhZxih7UhJZkMn2Dh9W+4IX7bt1gU/c3IgR0KnGT3pYmzXPNunpxJz6
        d2SXATDrWQ3bV6RO9N3nn1ne/BuJYqyIlS5ISg3xoxHU26a9Omz6Yz68ALRb82tKzE3tzW
        gT8j7p+9gtvTOWhSRl0K7yrtS2nxuYM=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-55-JLZKD7nXNnG_W3rOpmBhcA-1; Thu, 30 Jun 2022 02:08:05 -0400
X-MC-Unique: JLZKD7nXNnG_W3rOpmBhcA-1
Received: by mail-lf1-f71.google.com with SMTP id h18-20020a056512055200b004810d1b257aso6148556lfl.13
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 23:08:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8F2nUeN3UIGvhWhPwdXFRxrBpN+YKacrhMVno3b0HOE=;
        b=Mx3opvGN0Jsw1eDRd6Z1AKD8TYA3uOLaS8Rsqy4PYb/I8BvYFqJ0Te6k9hias0meCl
         ToWabJ26f29HjnxsWUf8DKsi35YEYfwoBtk+/j8X6YYDWg5VeyVAGWMoyN3YFp7yiDaC
         K0fFBCtkXyfDjIZuMZiDbz1KYJDVK7uFPntmjsiJyncQAJ+JKG5YKL4edrwRCuQTpDTm
         FwHKcmv0IZuFCvhp+khCVT0zhS+VYYXPd4fLjEH8Sxzi9pixjZKSge7GvRO1FceEfGya
         MTj4MVyTBWlkemUVABID3WXwMI6YMCQY3H8EtW0giKvu0SCQfc0YxncopBDlOHz0PLyG
         19dg==
X-Gm-Message-State: AJIora/kwwClTuv0Qj48APrg3+vAMX8//VVR4jgruIgl21Metmz9ZnpH
        NVSpH7q8Yxc+rhhYoHeBXKIunETl3HMRqDd3VGNzy1hY5iFP8VorPZ3DC3ZbK1OaESHjxpkbrmk
        7G711UXoxu9PO7kNXPl6nk4GZ1j/ToM0hZdFi8rlI
X-Received: by 2002:a2e:9ad0:0:b0:25a:7156:26bb with SMTP id p16-20020a2e9ad0000000b0025a715626bbmr3893981ljj.141.1656569283324;
        Wed, 29 Jun 2022 23:08:03 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uycjpe9LzkeJnJwvQ8/m/MahJ4H/ysGKojEgms9aLE1GxSCP4NZcX8Lj7MKqEKJME0I1SUIsT2FYJTz+SKeGY=
X-Received: by 2002:a2e:9ad0:0:b0:25a:7156:26bb with SMTP id
 p16-20020a2e9ad0000000b0025a715626bbmr3893973ljj.141.1656569283083; Wed, 29
 Jun 2022 23:08:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220630020805.74658-1-jasowang@redhat.com> <1656555045.7370687-2-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1656555045.7370687-2-xuanzhuo@linux.alibaba.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Thu, 30 Jun 2022 14:07:52 +0800
Message-ID: <CACGkMEvMrxWRNY_NbujLsWff4zMVELr7C9CJ77k_m5OTFEe0dA@mail.gmail.com>
Subject: Re: [PATCH V2] virtio-net: fix the race between refill work and close
To:     Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc:     mst <mst@redhat.com>, davem <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        virtualization <virtualization@lists.linux-foundation.org>,
        netdev <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2022 at 10:22 AM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
>
> On Thu, 30 Jun 2022 10:08:04 +0800, Jason Wang <jasowang@redhat.com> wrote:
> > We try using cancel_delayed_work_sync() to prevent the work from
> > enabling NAPI. This is insufficient since we don't disable the source
> > of the refill work scheduling. This means an NAPI poll callback after
> > cancel_delayed_work_sync() can schedule the refill work then can
> > re-enable the NAPI that leads to use-after-free [1].
>
>
> Can you explain in more detail how this happened?
>
> napi_disable() is normally called after cancel_delayed_work_sync(). This ensures
> that all napi callbacks will end, and the new napi_disable() will wait.
> There will be no re-enable napi.

An rx interrupt that may come between after the cancel_delayed_work()
but before the napi_disable(). It schedules a refill_work that may run
after the napi_disable() in virtnet_close().

>
> So I guess the use-after-free is caused by refill_work being called after
> dev/vi/napi is released. In this way, we can just call
> cancel_delayed_work_sync() after napi_disalbe().

So the refill_work can re-enable the NAPI when it is run after
napi_disable() in this case.

Thanks


>
> Thanks.
>
> >
> > Since the work can enable NAPI, we can't simply disable NAPI before
> > calling cancel_delayed_work_sync(). So fix this by introducing a
> > dedicated boolean to control whether or not the work could be
> > scheduled from NAPI.
> >
> > [1]
> > ==================================================================
> > BUG: KASAN: use-after-free in refill_work+0x43/0xd4
> > Read of size 2 at addr ffff88810562c92e by task kworker/2:1/42
> >
> > CPU: 2 PID: 42 Comm: kworker/2:1 Not tainted 5.19.0-rc1+ #480
> > Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
> > Workqueue: events refill_work
> > Call Trace:
> >  <TASK>
> >  dump_stack_lvl+0x34/0x44
> >  print_report.cold+0xbb/0x6ac
> >  ? _printk+0xad/0xde
> >  ? refill_work+0x43/0xd4
> >  kasan_report+0xa8/0x130
> >  ? refill_work+0x43/0xd4
> >  refill_work+0x43/0xd4
> >  process_one_work+0x43d/0x780
> >  worker_thread+0x2a0/0x6f0
> >  ? process_one_work+0x780/0x780
> >  kthread+0x167/0x1a0
> >  ? kthread_exit+0x50/0x50
> >  ret_from_fork+0x22/0x30
> >  </TASK>
> > ...
> >
> > Fixes: b2baed69e605c ("virtio_net: set/cancel work on ndo_open/ndo_stop")
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > ---
> >  drivers/net/virtio_net.c | 38 ++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 36 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index db05b5e930be..21bf1e5c81ef 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -251,6 +251,12 @@ struct virtnet_info {
> >       /* Does the affinity hint is set for virtqueues? */
> >       bool affinity_hint_set;
> >
> > +     /* Is refill work enabled? */
> > +     bool refill_work_enabled;
> > +
> > +     /* The lock to synchronize the access to refill_work_enabled */
> > +     spinlock_t refill_lock;
> > +
> >       /* CPU hotplug instances for online & dead */
> >       struct hlist_node node;
> >       struct hlist_node node_dead;
> > @@ -348,6 +354,20 @@ static struct page *get_a_page(struct receive_queue *rq, gfp_t gfp_mask)
> >       return p;
> >  }
> >
> > +static void enable_refill_work(struct virtnet_info *vi)
> > +{
> > +     spin_lock(&vi->refill_lock);
> > +     vi->refill_work_enabled = true;
> > +     spin_unlock(&vi->refill_lock);
> > +}
> > +
> > +static void disable_refill_work(struct virtnet_info *vi)
> > +{
> > +     spin_lock(&vi->refill_lock);
> > +     vi->refill_work_enabled = false;
> > +     spin_unlock(&vi->refill_lock);
> > +}
> > +
> >  static void virtqueue_napi_schedule(struct napi_struct *napi,
> >                                   struct virtqueue *vq)
> >  {
> > @@ -1527,8 +1547,12 @@ static int virtnet_receive(struct receive_queue *rq, int budget,
> >       }
> >
> >       if (rq->vq->num_free > min((unsigned int)budget, virtqueue_get_vring_size(rq->vq)) / 2) {
> > -             if (!try_fill_recv(vi, rq, GFP_ATOMIC))
> > -                     schedule_delayed_work(&vi->refill, 0);
> > +             if (!try_fill_recv(vi, rq, GFP_ATOMIC)) {
> > +                     spin_lock(&vi->refill_lock);
> > +                     if (vi->refill_work_enabled)
> > +                             schedule_delayed_work(&vi->refill, 0);
> > +                     spin_unlock(&vi->refill_lock);
> > +             }
> >       }
> >
> >       u64_stats_update_begin(&rq->stats.syncp);
> > @@ -1651,6 +1675,8 @@ static int virtnet_open(struct net_device *dev)
> >       struct virtnet_info *vi = netdev_priv(dev);
> >       int i, err;
> >
> > +     enable_refill_work(vi);
> > +
> >       for (i = 0; i < vi->max_queue_pairs; i++) {
> >               if (i < vi->curr_queue_pairs)
> >                       /* Make sure we have some buffers: if oom use wq. */
> > @@ -2033,6 +2059,8 @@ static int virtnet_close(struct net_device *dev)
> >       struct virtnet_info *vi = netdev_priv(dev);
> >       int i;
> >
> > +     /* Make sure NAPI doesn't schedule refill work */
> > +     disable_refill_work(vi);
> >       /* Make sure refill_work doesn't re-enable napi! */
> >       cancel_delayed_work_sync(&vi->refill);
> >
> > @@ -2776,6 +2804,9 @@ static void virtnet_freeze_down(struct virtio_device *vdev)
> >       netif_tx_lock_bh(vi->dev);
> >       netif_device_detach(vi->dev);
> >       netif_tx_unlock_bh(vi->dev);
> > +     /* Make sure NAPI doesn't schedule refill work */
> > +     disable_refill_work(vi);
> > +     /* Make sure refill_work doesn't re-enable napi! */
> >       cancel_delayed_work_sync(&vi->refill);
> >
> >       if (netif_running(vi->dev)) {
> > @@ -2799,6 +2830,8 @@ static int virtnet_restore_up(struct virtio_device *vdev)
> >
> >       virtio_device_ready(vdev);
> >
> > +     enable_refill_work(vi);
> > +
> >       if (netif_running(vi->dev)) {
> >               for (i = 0; i < vi->curr_queue_pairs; i++)
> >                       if (!try_fill_recv(vi, &vi->rq[i], GFP_KERNEL))
> > @@ -3548,6 +3581,7 @@ static int virtnet_probe(struct virtio_device *vdev)
> >       vdev->priv = vi;
> >
> >       INIT_WORK(&vi->config_work, virtnet_config_changed_work);
> > +     spin_lock_init(&vi->refill_lock);
> >
> >       /* If we can receive ANY GSO packets, we must allocate large ones. */
> >       if (virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO4) ||
> > --
> > 2.25.1
> >
>

