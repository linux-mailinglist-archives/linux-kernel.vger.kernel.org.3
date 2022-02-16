Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F21F34B833A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 09:48:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231644AbiBPIrd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 03:47:33 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:53028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231625AbiBPIrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 03:47:32 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 044F618D018
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 00:47:20 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id o10so970753ilh.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 00:47:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nB6wLJxeL9331zrH9OmKZTrfg56pynJrLVvetUJChCg=;
        b=FpkzP6+voqC5VXMfC6oZxzJTtQv/idk0vcbpoeWIbj/pmSnIITaj+6KDkzIfPnoa9a
         q1RKQ7taEWsfV6RG4MBYbQ858KxlO7QZeMBhJMmo9FD1NRMirvyapnw4rjQIMOJuGBgP
         6UzMULyNATkqbFoDq/uX+sGhQdbIwJftr88ZqCuNSXCoSYZyBF7q///6t4Dgby6m6B4g
         366xtDO7ni1/xxVZMOStgRqo2h7qyXVAPAU6MFI00LB9MdFvU4vD0kJDTkbhsKconWUK
         vHaFnsICSqTre8Yg900WInYHPoTuWDxH04sU2Q+PTUlgh5DKC78cDP3vOAA6/s76DnJZ
         hCfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nB6wLJxeL9331zrH9OmKZTrfg56pynJrLVvetUJChCg=;
        b=S668I23PqA6ArnO+id8SDJmTo338dtRzhwJ4w8u59pTxCk4o5ihcyIlPqpcfKSDD/8
         4sHhCdpplOh3+b0y4ilXWuC39Y+9AKI79zbX/ZtLblwfkxGtmszdnss6lGa/zzNlO53N
         ukaBvM3RmapcvrttnHRTVxogK5/1zcUTOkkQa8QuSZjK8FJOTx+Gcwtgj305p3ztTPG2
         SuWgPgMfMYWjm1JdBE7tTPEQMKE9yJkdO11mJDV99TJsDnZnhrqtxdJ42HplyzuwO6Hz
         HQLKUwHH0cLx2vluGeS/kJiMDWRlM07w5127UAeG6bGaW0T1hM/QncBpnIm7DFpmSZD/
         7OKA==
X-Gm-Message-State: AOAM530EYkxoaPlajvKQeX4LSmeDOFmsu6P+JgrQ8zYKPdYUkj0cNRmB
        RFQv3CfNivpviMW2w4pPxGL6jSHrgHGP2oVLbrI=
X-Google-Smtp-Source: ABdhPJxeADlV+pkxePZ6vUBJ4xRfgj2IR/BT1L/ygiYbFzT/vJwX/tLnY2CtttF0CWUK1RwiD20jQouSVgKl2rU1DDg=
X-Received: by 2002:a05:6e02:17ca:b0:2be:8b06:eb67 with SMTP id
 z10-20020a056e0217ca00b002be8b06eb67mr1126006ilu.247.1645001239363; Wed, 16
 Feb 2022 00:47:19 -0800 (PST)
MIME-Version: 1.0
References: <20220111161937.56272-1-pankaj.gupta.linux@gmail.com>
 <20220111161937.56272-2-pankaj.gupta.linux@gmail.com> <CAPcyv4jrVJ_B0N_-vtqgXaOMovUgnSLCNj228nWMRhGAC5PDhA@mail.gmail.com>
In-Reply-To: <CAPcyv4jrVJ_B0N_-vtqgXaOMovUgnSLCNj228nWMRhGAC5PDhA@mail.gmail.com>
From:   Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date:   Wed, 16 Feb 2022 09:47:08 +0100
Message-ID: <CAM9Jb+i0B2jZ0uCEDyiz8ujuMkioFgOA0r7Lz9wDK026Vq1Hxg@mail.gmail.com>
Subject: Re: [RFC v3 1/2] virtio-pmem: Async virtio-pmem flush
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Linux NVDIMM <nvdimm@lists.linux.dev>,
        virtualization@lists.linux-foundation.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jmoyer <jmoyer@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        Pankaj Gupta <pankaj.gupta@ionos.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >
> > Enable asynchronous flush for virtio pmem using work queue. Also,
> > coalesce the flush requests when a flush is already in process.
> > This functionality is copied from md/RAID code.
> >
> > When a flush is already in process, new flush requests wait till
> > previous flush completes in another context (work queue). For all
> > the requests come between ongoing flush and new flush start time, only
> > single flush executes, thus adhers to flush coalscing logic. This is
>
> s/adhers/adheres/
>
> s/coalscing/coalescing/
>
> > important for maintaining the flush request order with request coalscing.
>
> s/coalscing/coalescing/

o.k. Sorry for the spelling mistakes.

>
> >
> > Signed-off-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
> > ---
> >  drivers/nvdimm/nd_virtio.c   | 74 +++++++++++++++++++++++++++---------
> >  drivers/nvdimm/virtio_pmem.c | 10 +++++
> >  drivers/nvdimm/virtio_pmem.h | 16 ++++++++
> >  3 files changed, 83 insertions(+), 17 deletions(-)
> >
> > diff --git a/drivers/nvdimm/nd_virtio.c b/drivers/nvdimm/nd_virtio.c
> > index 10351d5b49fa..179ea7a73338 100644
> > --- a/drivers/nvdimm/nd_virtio.c
> > +++ b/drivers/nvdimm/nd_virtio.c
> > @@ -100,26 +100,66 @@ static int virtio_pmem_flush(struct nd_region *nd_region)
> >  /* The asynchronous flush callback function */
> >  int async_pmem_flush(struct nd_region *nd_region, struct bio *bio)
> >  {
> > -       /*
> > -        * Create child bio for asynchronous flush and chain with
> > -        * parent bio. Otherwise directly call nd_region flush.
> > +       /* queue asynchronous flush and coalesce the flush requests */
> > +       struct virtio_device *vdev = nd_region->provider_data;
> > +       struct virtio_pmem *vpmem  = vdev->priv;
> > +       ktime_t req_start = ktime_get_boottime();
> > +       int ret = -EINPROGRESS;
> > +
> > +       spin_lock_irq(&vpmem->lock);
>
> Why a new lock and not continue to use ->pmem_lock?

This spinlock is to protect entry in 'wait_event_lock_irq'
and the Other spinlock is to protect virtio queue data.
>
> Have you tested this with CONFIG_PROVE_LOCKING?
No, I only ran xfs tests and some of my unit test program.
Will enable and test with CONFIG_PROVE_LOCKING.

>
> Along those lines do you have a selftest that can be added to the
> kernel as well so that 0day or other bots could offer early warnings
> on regressions?

Will try to add one.

Thank you Dan for the feedback!

Best regards,
Pankaj
>
> > +       /* flush requests wait until ongoing flush completes,
> > +        * hence coalescing all the pending requests.
> >          */
> > -       if (bio && bio->bi_iter.bi_sector != -1) {
> > -               struct bio *child = bio_alloc(GFP_ATOMIC, 0);
> > -
> > -               if (!child)
> > -                       return -ENOMEM;
> > -               bio_copy_dev(child, bio);
> > -               child->bi_opf = REQ_PREFLUSH;
> > -               child->bi_iter.bi_sector = -1;
> > -               bio_chain(child, bio);
> > -               submit_bio(child);
> > -               return 0;
> > +       wait_event_lock_irq(vpmem->sb_wait,
> > +                           !vpmem->flush_bio ||
> > +                           ktime_before(req_start, vpmem->prev_flush_start),
> > +                           vpmem->lock);
> > +       /* new request after previous flush is completed */
> > +       if (ktime_after(req_start, vpmem->prev_flush_start)) {
> > +               WARN_ON(vpmem->flush_bio);
> > +               vpmem->flush_bio = bio;
> > +               bio = NULL;
> > +       }
> > +       spin_unlock_irq(&vpmem->lock);
> > +
> > +       if (!bio)
> > +               queue_work(vpmem->pmem_wq, &vpmem->flush_work);
> > +       else {
> > +       /* flush completed in other context while we waited */
> > +               if (bio && (bio->bi_opf & REQ_PREFLUSH))
> > +                       bio->bi_opf &= ~REQ_PREFLUSH;
> > +               else if (bio && (bio->bi_opf & REQ_FUA))
> > +                       bio->bi_opf &= ~REQ_FUA;
> > +
> > +               ret = vpmem->prev_flush_err;
> >         }
> > -       if (virtio_pmem_flush(nd_region))
> > -               return -EIO;
> >
> > -       return 0;
> > +       return ret;
> >  };
> >  EXPORT_SYMBOL_GPL(async_pmem_flush);
> > +
> > +void submit_async_flush(struct work_struct *ws)
>
> This name is too generic to be exported from drivers/nvdimm/nd_virtio.c
>
> ...it strikes me that there is little reason for nd_virtio and
> virtio_pmem to be separate modules. They are both enabled by the same
> Kconfig, so why not combine them into one module and drop the exports?

makes sense.
>
> > +{
> > +       struct virtio_pmem *vpmem = container_of(ws, struct virtio_pmem, flush_work);
> > +       struct bio *bio = vpmem->flush_bio;
> > +
> > +       vpmem->start_flush = ktime_get_boottime();
> > +       vpmem->prev_flush_err = virtio_pmem_flush(vpmem->nd_region);
> > +       vpmem->prev_flush_start = vpmem->start_flush;
> > +       vpmem->flush_bio = NULL;
> > +       wake_up(&vpmem->sb_wait);
> > +
> > +       if (vpmem->prev_flush_err)
> > +               bio->bi_status = errno_to_blk_status(-EIO);
> > +
> > +       /* Submit parent bio only for PREFLUSH */
> > +       if (bio && (bio->bi_opf & REQ_PREFLUSH)) {
> > +               bio->bi_opf &= ~REQ_PREFLUSH;
> > +               submit_bio(bio);
> > +       } else if (bio && (bio->bi_opf & REQ_FUA)) {
> > +               bio->bi_opf &= ~REQ_FUA;
> > +               bio_endio(bio);
> > +       }
> > +}
> > +EXPORT_SYMBOL_GPL(submit_async_flush);
> >  MODULE_LICENSE("GPL");
> > diff --git a/drivers/nvdimm/virtio_pmem.c b/drivers/nvdimm/virtio_pmem.c
> > index 726c7354d465..75ed9b7ddea1 100644
> > --- a/drivers/nvdimm/virtio_pmem.c
> > +++ b/drivers/nvdimm/virtio_pmem.c
> > @@ -24,6 +24,7 @@ static int init_vq(struct virtio_pmem *vpmem)
> >                 return PTR_ERR(vpmem->req_vq);
> >
> >         spin_lock_init(&vpmem->pmem_lock);
> > +       spin_lock_init(&vpmem->lock);
> >         INIT_LIST_HEAD(&vpmem->req_list);
> >
> >         return 0;
> > @@ -57,7 +58,14 @@ static int virtio_pmem_probe(struct virtio_device *vdev)
> >                 dev_err(&vdev->dev, "failed to initialize virtio pmem vq's\n");
> >                 goto out_err;
> >         }
> > +       vpmem->pmem_wq = alloc_workqueue("vpmem_wq", WQ_MEM_RECLAIM, 0);
> > +       if (!vpmem->pmem_wq) {
> > +               err = -ENOMEM;
> > +               goto out_err;
> > +       }
> >
> > +       INIT_WORK(&vpmem->flush_work, submit_async_flush);
> > +       init_waitqueue_head(&vpmem->sb_wait);
> >         virtio_cread_le(vpmem->vdev, struct virtio_pmem_config,
> >                         start, &vpmem->start);
> >         virtio_cread_le(vpmem->vdev, struct virtio_pmem_config,
> > @@ -90,10 +98,12 @@ static int virtio_pmem_probe(struct virtio_device *vdev)
> >                 goto out_nd;
> >         }
> >         nd_region->provider_data = dev_to_virtio(nd_region->dev.parent->parent);
> > +       vpmem->nd_region = nd_region;
> >         return 0;
> >  out_nd:
> >         nvdimm_bus_unregister(vpmem->nvdimm_bus);
> >  out_vq:
> > +       destroy_workqueue(vpmem->pmem_wq);
> >         vdev->config->del_vqs(vdev);
> >  out_err:
> >         return err;
> > diff --git a/drivers/nvdimm/virtio_pmem.h b/drivers/nvdimm/virtio_pmem.h
> > index 0dddefe594c4..495dc20e1cdb 100644
> > --- a/drivers/nvdimm/virtio_pmem.h
> > +++ b/drivers/nvdimm/virtio_pmem.h
> > @@ -35,9 +35,24 @@ struct virtio_pmem {
> >         /* Virtio pmem request queue */
> >         struct virtqueue *req_vq;
> >
> > +       struct bio *flush_bio;
> > +       /* last_flush is when the last completed flush was started */
> > +       ktime_t prev_flush_start, start_flush;
> > +       int prev_flush_err;
> > +
> > +       /* work queue for deferred flush */
> > +       struct work_struct flush_work;
> > +       struct workqueue_struct *pmem_wq;
> > +
> > +       /* Synchronize flush wait queue data */
> > +       spinlock_t lock;
> > +       /* for waiting for previous flush to complete */
> > +       wait_queue_head_t sb_wait;
> > +
> >         /* nvdimm bus registers virtio pmem device */
> >         struct nvdimm_bus *nvdimm_bus;
> >         struct nvdimm_bus_descriptor nd_desc;
> > +       struct nd_region *nd_region;
> >
> >         /* List to store deferred work if virtqueue is full */
> >         struct list_head req_list;
> > @@ -52,4 +67,5 @@ struct virtio_pmem {
> >
> >  void virtio_pmem_host_ack(struct virtqueue *vq);
> >  int async_pmem_flush(struct nd_region *nd_region, struct bio *bio);
> > +void submit_async_flush(struct work_struct *ws);
> >  #endif
> > --
> > 2.25.1
> >
> >
