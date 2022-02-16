Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF4C34B7EB7
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 04:49:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344212AbiBPDVt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 22:21:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233625AbiBPDVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 22:21:47 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 443DA13F66
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 19:21:35 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id c10so1018689pfv.8
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 19:21:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vw8qsUjrvsewVRkefqUfPybP+5Z8VVwo22NfPcxFm0A=;
        b=dgO7FhOY2JfQ2IuLfOG2+6uYTThsWgKj/hMrjHToVTKPrHe2y7HZPfgQon5t2nJupZ
         xE/6oPFfV6H6vhhYCOlncyNL7KmQGjDkC0fK1cN3YOKHm0dC4BT4/WN6CmIIOMNERuHA
         uMVsZRX/f02HrDzFwhUtgY/LAoFOjBHXHOpI3xbcwFnM3HgpTJj/ldRGYzC++aMpFIay
         rwequSDABGFWuBzkdYLmFvdqk3kistFZ9YZce6p+KpDSUs/r5AMaOhO6NgRJNBLoXsJL
         Q4wdnDkA9AJXGBNuFZSCvpC11uUZFWl7dwdCdZk2q5/xG+ErbjgqoFLTJkzOmivOCSr1
         DwrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vw8qsUjrvsewVRkefqUfPybP+5Z8VVwo22NfPcxFm0A=;
        b=ZHCJ7gHP1i/DewiTTL46bdAHMGPatsMDD7HAGALXrVnRUTWsb0hUcCw7hCEgLVP8cA
         gdod6Eyjeq6Rnt6b1vyE5nK3yrirh25ZuRxOuLxJ2OHdTZwB1Ie/1fDuuiGpmvEa+NCX
         MqKIXwkI+I70cJay/1qQ8digiFTxhv/zVzbylC99kuUvFdQABYVPFpqF1KssANXdxlDN
         wVTsnyktNKC9yLSDB9FOWXN3qgBaQy+fdnzzyQ+/dBrmKACZiYJVT2WB2MNn3+3UMxnq
         xGA0cLkevGjNxl0zI+IRbZzaYxGKBSxyP9BqBbmL0k8rrXW1l8P2CK3qVy1TA7a0BhEw
         gKpg==
X-Gm-Message-State: AOAM533qx6Le/LIlANNbphUsugNhY92VQgEzYhQaXlrRFVj37q2DL/oD
        2pGozWo0vQa04K6fut9m0uEseYv9zXXv9Vmw505lCw==
X-Google-Smtp-Source: ABdhPJyuuPzOEwmW+m5vEZBdWxTnv9HwCvggPR3Bu976gqtuMVGeBifHYjgGPdwjgVlUgB3HcMqCsBka29+qh7hOs/k=
X-Received: by 2002:a63:f011:0:b0:36c:2da3:32bc with SMTP id
 k17-20020a63f011000000b0036c2da332bcmr661337pgh.40.1644981694745; Tue, 15 Feb
 2022 19:21:34 -0800 (PST)
MIME-Version: 1.0
References: <20220111161937.56272-1-pankaj.gupta.linux@gmail.com> <20220111161937.56272-2-pankaj.gupta.linux@gmail.com>
In-Reply-To: <20220111161937.56272-2-pankaj.gupta.linux@gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 15 Feb 2022 19:21:23 -0800
Message-ID: <CAPcyv4jrVJ_B0N_-vtqgXaOMovUgnSLCNj228nWMRhGAC5PDhA@mail.gmail.com>
Subject: Re: [RFC v3 1/2] virtio-pmem: Async virtio-pmem flush
To:     Pankaj Gupta <pankaj.gupta.linux@gmail.com>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2022 at 8:23 AM Pankaj Gupta
<pankaj.gupta.linux@gmail.com> wrote:
>
> Enable asynchronous flush for virtio pmem using work queue. Also,
> coalesce the flush requests when a flush is already in process.
> This functionality is copied from md/RAID code.
>
> When a flush is already in process, new flush requests wait till
> previous flush completes in another context (work queue). For all
> the requests come between ongoing flush and new flush start time, only
> single flush executes, thus adhers to flush coalscing logic. This is

s/adhers/adheres/

s/coalscing/coalescing/

> important for maintaining the flush request order with request coalscing.

s/coalscing/coalescing/

>
> Signed-off-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
> ---
>  drivers/nvdimm/nd_virtio.c   | 74 +++++++++++++++++++++++++++---------
>  drivers/nvdimm/virtio_pmem.c | 10 +++++
>  drivers/nvdimm/virtio_pmem.h | 16 ++++++++
>  3 files changed, 83 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/nvdimm/nd_virtio.c b/drivers/nvdimm/nd_virtio.c
> index 10351d5b49fa..179ea7a73338 100644
> --- a/drivers/nvdimm/nd_virtio.c
> +++ b/drivers/nvdimm/nd_virtio.c
> @@ -100,26 +100,66 @@ static int virtio_pmem_flush(struct nd_region *nd_region)
>  /* The asynchronous flush callback function */
>  int async_pmem_flush(struct nd_region *nd_region, struct bio *bio)
>  {
> -       /*
> -        * Create child bio for asynchronous flush and chain with
> -        * parent bio. Otherwise directly call nd_region flush.
> +       /* queue asynchronous flush and coalesce the flush requests */
> +       struct virtio_device *vdev = nd_region->provider_data;
> +       struct virtio_pmem *vpmem  = vdev->priv;
> +       ktime_t req_start = ktime_get_boottime();
> +       int ret = -EINPROGRESS;
> +
> +       spin_lock_irq(&vpmem->lock);

Why a new lock and not continue to use ->pmem_lock?

Have you tested this with CONFIG_PROVE_LOCKING?

Along those lines do you have a selftest that can be added to the
kernel as well so that 0day or other bots could offer early warnings
on regressions?

> +       /* flush requests wait until ongoing flush completes,
> +        * hence coalescing all the pending requests.
>          */
> -       if (bio && bio->bi_iter.bi_sector != -1) {
> -               struct bio *child = bio_alloc(GFP_ATOMIC, 0);
> -
> -               if (!child)
> -                       return -ENOMEM;
> -               bio_copy_dev(child, bio);
> -               child->bi_opf = REQ_PREFLUSH;
> -               child->bi_iter.bi_sector = -1;
> -               bio_chain(child, bio);
> -               submit_bio(child);
> -               return 0;
> +       wait_event_lock_irq(vpmem->sb_wait,
> +                           !vpmem->flush_bio ||
> +                           ktime_before(req_start, vpmem->prev_flush_start),
> +                           vpmem->lock);
> +       /* new request after previous flush is completed */
> +       if (ktime_after(req_start, vpmem->prev_flush_start)) {
> +               WARN_ON(vpmem->flush_bio);
> +               vpmem->flush_bio = bio;
> +               bio = NULL;
> +       }
> +       spin_unlock_irq(&vpmem->lock);
> +
> +       if (!bio)
> +               queue_work(vpmem->pmem_wq, &vpmem->flush_work);
> +       else {
> +       /* flush completed in other context while we waited */
> +               if (bio && (bio->bi_opf & REQ_PREFLUSH))
> +                       bio->bi_opf &= ~REQ_PREFLUSH;
> +               else if (bio && (bio->bi_opf & REQ_FUA))
> +                       bio->bi_opf &= ~REQ_FUA;
> +
> +               ret = vpmem->prev_flush_err;
>         }
> -       if (virtio_pmem_flush(nd_region))
> -               return -EIO;
>
> -       return 0;
> +       return ret;
>  };
>  EXPORT_SYMBOL_GPL(async_pmem_flush);
> +
> +void submit_async_flush(struct work_struct *ws)

This name is too generic to be exported from drivers/nvdimm/nd_virtio.c

...it strikes me that there is little reason for nd_virtio and
virtio_pmem to be separate modules. They are both enabled by the same
Kconfig, so why not combine them into one module and drop the exports?

> +{
> +       struct virtio_pmem *vpmem = container_of(ws, struct virtio_pmem, flush_work);
> +       struct bio *bio = vpmem->flush_bio;
> +
> +       vpmem->start_flush = ktime_get_boottime();
> +       vpmem->prev_flush_err = virtio_pmem_flush(vpmem->nd_region);
> +       vpmem->prev_flush_start = vpmem->start_flush;
> +       vpmem->flush_bio = NULL;
> +       wake_up(&vpmem->sb_wait);
> +
> +       if (vpmem->prev_flush_err)
> +               bio->bi_status = errno_to_blk_status(-EIO);
> +
> +       /* Submit parent bio only for PREFLUSH */
> +       if (bio && (bio->bi_opf & REQ_PREFLUSH)) {
> +               bio->bi_opf &= ~REQ_PREFLUSH;
> +               submit_bio(bio);
> +       } else if (bio && (bio->bi_opf & REQ_FUA)) {
> +               bio->bi_opf &= ~REQ_FUA;
> +               bio_endio(bio);
> +       }
> +}
> +EXPORT_SYMBOL_GPL(submit_async_flush);
>  MODULE_LICENSE("GPL");
> diff --git a/drivers/nvdimm/virtio_pmem.c b/drivers/nvdimm/virtio_pmem.c
> index 726c7354d465..75ed9b7ddea1 100644
> --- a/drivers/nvdimm/virtio_pmem.c
> +++ b/drivers/nvdimm/virtio_pmem.c
> @@ -24,6 +24,7 @@ static int init_vq(struct virtio_pmem *vpmem)
>                 return PTR_ERR(vpmem->req_vq);
>
>         spin_lock_init(&vpmem->pmem_lock);
> +       spin_lock_init(&vpmem->lock);
>         INIT_LIST_HEAD(&vpmem->req_list);
>
>         return 0;
> @@ -57,7 +58,14 @@ static int virtio_pmem_probe(struct virtio_device *vdev)
>                 dev_err(&vdev->dev, "failed to initialize virtio pmem vq's\n");
>                 goto out_err;
>         }
> +       vpmem->pmem_wq = alloc_workqueue("vpmem_wq", WQ_MEM_RECLAIM, 0);
> +       if (!vpmem->pmem_wq) {
> +               err = -ENOMEM;
> +               goto out_err;
> +       }
>
> +       INIT_WORK(&vpmem->flush_work, submit_async_flush);
> +       init_waitqueue_head(&vpmem->sb_wait);
>         virtio_cread_le(vpmem->vdev, struct virtio_pmem_config,
>                         start, &vpmem->start);
>         virtio_cread_le(vpmem->vdev, struct virtio_pmem_config,
> @@ -90,10 +98,12 @@ static int virtio_pmem_probe(struct virtio_device *vdev)
>                 goto out_nd;
>         }
>         nd_region->provider_data = dev_to_virtio(nd_region->dev.parent->parent);
> +       vpmem->nd_region = nd_region;
>         return 0;
>  out_nd:
>         nvdimm_bus_unregister(vpmem->nvdimm_bus);
>  out_vq:
> +       destroy_workqueue(vpmem->pmem_wq);
>         vdev->config->del_vqs(vdev);
>  out_err:
>         return err;
> diff --git a/drivers/nvdimm/virtio_pmem.h b/drivers/nvdimm/virtio_pmem.h
> index 0dddefe594c4..495dc20e1cdb 100644
> --- a/drivers/nvdimm/virtio_pmem.h
> +++ b/drivers/nvdimm/virtio_pmem.h
> @@ -35,9 +35,24 @@ struct virtio_pmem {
>         /* Virtio pmem request queue */
>         struct virtqueue *req_vq;
>
> +       struct bio *flush_bio;
> +       /* last_flush is when the last completed flush was started */
> +       ktime_t prev_flush_start, start_flush;
> +       int prev_flush_err;
> +
> +       /* work queue for deferred flush */
> +       struct work_struct flush_work;
> +       struct workqueue_struct *pmem_wq;
> +
> +       /* Synchronize flush wait queue data */
> +       spinlock_t lock;
> +       /* for waiting for previous flush to complete */
> +       wait_queue_head_t sb_wait;
> +
>         /* nvdimm bus registers virtio pmem device */
>         struct nvdimm_bus *nvdimm_bus;
>         struct nvdimm_bus_descriptor nd_desc;
> +       struct nd_region *nd_region;
>
>         /* List to store deferred work if virtqueue is full */
>         struct list_head req_list;
> @@ -52,4 +67,5 @@ struct virtio_pmem {
>
>  void virtio_pmem_host_ack(struct virtqueue *vq);
>  int async_pmem_flush(struct nd_region *nd_region, struct bio *bio);
> +void submit_async_flush(struct work_struct *ws);
>  #endif
> --
> 2.25.1
>
>
