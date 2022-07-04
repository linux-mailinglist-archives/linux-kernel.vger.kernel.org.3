Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D93BA564E28
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 09:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233112AbiGDHD1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 03:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233051AbiGDHDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 03:03:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F2B0B60DC
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 00:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656918196;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dbMjjAZXWJpAVIpo7B4exIkMNlsj/klWOact/FA3tfw=;
        b=c8K5f45RrFYdo0+UpwzfEsycIM5xn4o1Bl2QwZJvnl1+fRSNV4HzzGFN3DsTnFke8nt+c+
        ov5ajNQI0HuvrnSfr8dOyMWUk7XTicBDsrA3vRrs4MoHjTc2oeaquHw+TN9O1KYj6iqntL
        EZVCslKVp+dXyfekyVTw4Oh2FbRU/0s=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-341-cFPGJnB5PnaARvkxq3SSPw-1; Mon, 04 Jul 2022 03:03:15 -0400
X-MC-Unique: cFPGJnB5PnaARvkxq3SSPw-1
Received: by mail-ed1-f71.google.com with SMTP id w5-20020a056402268500b0043980311a5fso6115451edd.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 00:03:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dbMjjAZXWJpAVIpo7B4exIkMNlsj/klWOact/FA3tfw=;
        b=Jh1Ai6dfCZp7/HK9MV36MGahIVhKGakZXDJMTMcj4EEgPlERbm0/LvZ5i0zriQP+Ai
         3zn5k4NfXr7nNNn86k5nYO48wP5m2ERapyhY2VWc48QDh5M0MlpJgloxtY+QDWZpiaX5
         OEp21S6BtUEAwJbMQ0+sstyULrbwv0qN+JxY5PvFCfXHIKKQB+8C9pR4mMibG6hWbngJ
         ycdanMEtU2YJJKXguZKEB9WMHGdDrjNP+DAUnhKvwA0SKqeH1LjD4I/yr6pDElvCHA4N
         5tQWGG6Vq2mqsENoS2uHuFeB7N12zMK/XsPb1crvC5e5Luw1bvLtsFBtJ83/VqsuOCfI
         926w==
X-Gm-Message-State: AJIora9W5JBT/3W+rSBuK/vvjBUXQhWBDFRCi1h3TJ+oFrdPpRXRMT7L
        Nwz45VwmDA+ODJjVlSCXgDg6eTB06244eHT+2Dahpyzh1pTZNjrmVQHze5VltW5OErzGUc0FgJ0
        1PRfM9sBoav6Q7jG4a7uMTKvh
X-Received: by 2002:a17:906:cc47:b0:72a:95bf:2749 with SMTP id mm7-20020a170906cc4700b0072a95bf2749mr13345730ejb.204.1656918193262;
        Mon, 04 Jul 2022 00:03:13 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uFUbcMqG+3NKA/v47zZ900Hz/GxevZvwo2m/XCrH9k9CLGuwfFOxSS6CtmlxQvaIN3VxGa7Q==
X-Received: by 2002:a17:906:cc47:b0:72a:95bf:2749 with SMTP id mm7-20020a170906cc4700b0072a95bf2749mr13345706ejb.204.1656918192899;
        Mon, 04 Jul 2022 00:03:12 -0700 (PDT)
Received: from redhat.com ([2.55.3.188])
        by smtp.gmail.com with ESMTPSA id u6-20020a170906780600b006fef557bb7asm13791488ejm.80.2022.07.04.00.03.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 00:03:12 -0700 (PDT)
Date:   Mon, 4 Jul 2022 03:03:07 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     davem <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        netdev <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net V4] virtio-net: fix the race between refill work and
 close
Message-ID: <20220704030124-mutt-send-email-mst@kernel.org>
References: <20220704041948.13212-1-jasowang@redhat.com>
 <20220704021656-mutt-send-email-mst@kernel.org>
 <CACGkMEsOy6kgaj+Q0vYxDBy7JEd=DUm7KLKo7AjGCi2ay5ciKQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACGkMEsOy6kgaj+Q0vYxDBy7JEd=DUm7KLKo7AjGCi2ay5ciKQ@mail.gmail.com>
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 04, 2022 at 02:32:45PM +0800, Jason Wang wrote:
> On Mon, Jul 4, 2022 at 2:19 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Mon, Jul 04, 2022 at 12:19:48PM +0800, Jason Wang wrote:
> > > We try using cancel_delayed_work_sync() to prevent the work from
> > > enabling NAPI. This is insufficient since we don't disable the source
> > > of the refill work scheduling. This means an NAPI poll callback after
> > > cancel_delayed_work_sync() can schedule the refill work then can
> > > re-enable the NAPI that leads to use-after-free [1].
> > >
> > > Since the work can enable NAPI, we can't simply disable NAPI before
> > > calling cancel_delayed_work_sync(). So fix this by introducing a
> > > dedicated boolean to control whether or not the work could be
> > > scheduled from NAPI.
> > >
> > > [1]
> > > ==================================================================
> > > BUG: KASAN: use-after-free in refill_work+0x43/0xd4
> > > Read of size 2 at addr ffff88810562c92e by task kworker/2:1/42
> > >
> > > CPU: 2 PID: 42 Comm: kworker/2:1 Not tainted 5.19.0-rc1+ #480
> > > Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
> > > Workqueue: events refill_work
> > > Call Trace:
> > >  <TASK>
> > >  dump_stack_lvl+0x34/0x44
> > >  print_report.cold+0xbb/0x6ac
> > >  ? _printk+0xad/0xde
> > >  ? refill_work+0x43/0xd4
> > >  kasan_report+0xa8/0x130
> > >  ? refill_work+0x43/0xd4
> > >  refill_work+0x43/0xd4
> > >  process_one_work+0x43d/0x780
> > >  worker_thread+0x2a0/0x6f0
> > >  ? process_one_work+0x780/0x780
> > >  kthread+0x167/0x1a0
> > >  ? kthread_exit+0x50/0x50
> > >  ret_from_fork+0x22/0x30
> > >  </TASK>
> > > ...
> > >
> > > Fixes: b2baed69e605c ("virtio_net: set/cancel work on ndo_open/ndo_stop")
> > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > ---
> > > Changes since V3:
> > > - rebase to -net
> > > Changes since V2:
> > > - use spin_unlock()/lock_bh() in open/stop to synchronize with bh
> > > Changes since V1:
> > > - Tweak the changelog
> > > ---
> > >  drivers/net/virtio_net.c | 35 +++++++++++++++++++++++++++++++++--
> > >  1 file changed, 33 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > index 356cf8dd4164..68430d7923ac 100644
> > > --- a/drivers/net/virtio_net.c
> > > +++ b/drivers/net/virtio_net.c
> > > @@ -251,6 +251,12 @@ struct virtnet_info {
> > >       /* Does the affinity hint is set for virtqueues? */
> > >       bool affinity_hint_set;
> > >
> > > +     /* Is refill work enabled? */
> >
> > refilling enabled
> 
> I think it should be reill work, we try refill first, if fail we
> schedule the work:
> 
>                 if (!try_fill_recv(vi, rq, GFP_ATOMIC))
>                         schedule_delayed_work(&vi->refill, 0);
> 
> Thanks

maybe "delayed refill"? It's not "work" it's a work struct.
I'm trying to be consistent with:
        /* Work struct for refilling if we run low on memory. */
        struct delayed_work refill;


> >
> > > +     bool refill_work_enabled;
> >
> >
> > refill_work -> refill?
> >
> > > +
> > > +     /* The lock to synchronize the access to refill_work_enabled */
> >
> > .. and refill
> >
> > And maybe put these field near the refill field.
> >
> > > +     spinlock_t refill_lock;
> > > +
> > >       /* CPU hotplug instances for online & dead */
> > >       struct hlist_node node;
> > >       struct hlist_node node_dead;
> > > @@ -348,6 +354,20 @@ static struct page *get_a_page(struct receive_queue *rq, gfp_t gfp_mask)
> > >       return p;
> > >  }
> > >
> > > +static void enable_refill_work(struct virtnet_info *vi)
> > > +{
> > > +     spin_lock_bh(&vi->refill_lock);
> > > +     vi->refill_work_enabled = true;
> > > +     spin_unlock_bh(&vi->refill_lock);
> > > +}
> > > +
> > > +static void disable_refill_work(struct virtnet_info *vi)
> > > +{
> > > +     spin_lock_bh(&vi->refill_lock);
> > > +     vi->refill_work_enabled = false;
> > > +     spin_unlock_bh(&vi->refill_lock);
> > > +}
> > > +
> > >  static void virtqueue_napi_schedule(struct napi_struct *napi,
> > >                                   struct virtqueue *vq)
> > >  {
> > > @@ -1527,8 +1547,12 @@ static int virtnet_receive(struct receive_queue *rq, int budget,
> > >       }
> > >
> > >       if (rq->vq->num_free > min((unsigned int)budget, virtqueue_get_vring_size(rq->vq)) / 2) {
> > > -             if (!try_fill_recv(vi, rq, GFP_ATOMIC))
> > > -                     schedule_delayed_work(&vi->refill, 0);
> > > +             if (!try_fill_recv(vi, rq, GFP_ATOMIC)) {
> > > +                     spin_lock(&vi->refill_lock);
> > > +                     if (vi->refill_work_enabled)
> > > +                             schedule_delayed_work(&vi->refill, 0);
> > > +                     spin_unlock(&vi->refill_lock);
> > > +             }
> > >       }
> > >
> > >       u64_stats_update_begin(&rq->stats.syncp);
> > > @@ -1651,6 +1675,8 @@ static int virtnet_open(struct net_device *dev)
> > >       struct virtnet_info *vi = netdev_priv(dev);
> > >       int i, err;
> > >
> > > +     enable_refill_work(vi);
> > > +
> > >       for (i = 0; i < vi->max_queue_pairs; i++) {
> > >               if (i < vi->curr_queue_pairs)
> > >                       /* Make sure we have some buffers: if oom use wq. */
> > > @@ -2033,6 +2059,8 @@ static int virtnet_close(struct net_device *dev)
> > >       struct virtnet_info *vi = netdev_priv(dev);
> > >       int i;
> > >
> > > +     /* Make sure NAPI doesn't schedule refill work */
> > > +     disable_refill_work(vi);
> > >       /* Make sure refill_work doesn't re-enable napi! */
> > >       cancel_delayed_work_sync(&vi->refill);
> > >
> > > @@ -2792,6 +2820,8 @@ static int virtnet_restore_up(struct virtio_device *vdev)
> > >
> > >       virtio_device_ready(vdev);
> > >
> > > +     enable_refill_work(vi);
> > > +
> > >       if (netif_running(vi->dev)) {
> > >               err = virtnet_open(vi->dev);
> > >               if (err)
> > > @@ -3535,6 +3565,7 @@ static int virtnet_probe(struct virtio_device *vdev)
> > >       vdev->priv = vi;
> > >
> > >       INIT_WORK(&vi->config_work, virtnet_config_changed_work);
> > > +     spin_lock_init(&vi->refill_lock);
> > >
> > >       /* If we can receive ANY GSO packets, we must allocate large ones. */
> > >       if (virtio_has_feature(vdev, VIRTIO_NET_F_GUEST_TSO4) ||
> > > --
> > > 2.25.1
> >

