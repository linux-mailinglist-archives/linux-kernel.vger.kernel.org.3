Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A230C58FCD5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 14:52:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235480AbiHKMwb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 08:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234179AbiHKMw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 08:52:28 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74B67357E8;
        Thu, 11 Aug 2022 05:52:27 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id k26so33350070ejx.5;
        Thu, 11 Aug 2022 05:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=GrsV45TEM8tOUeQpg2pTx4YM2UxANe4hTiuuoUTWjiM=;
        b=lnJhTdJi4wLhoar8pZZ+5IjYt2gDnyW5qUA+ADtIjfvUktbs87UJRVnl2Sk0pvTQ5f
         aalEhGp2MZKNiYouYh8qQ7zTepQyCrvDxFII7PpFzyOd7jPhe/BcYujNwnYXAh7R8BID
         bs7gV4Z8NES15UtJoXJ0VgzHbI9E/O6xsWobYGPm27rts5fCIGCTMLjxYUvSmiV6iuii
         FqtLWd/2oT1wWvQ5ZcFoF0qF5N45YwV7B0/eM+NzwKndgi1MmOC62tDnB6d6QWaJldiq
         mq4njWD9NlaCm7PugqsoiCTKVpoY/vnOLp75Bu3Wpwhva92Pu7LKZIoJgJwWOyo2iZLR
         pvJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=GrsV45TEM8tOUeQpg2pTx4YM2UxANe4hTiuuoUTWjiM=;
        b=rEiqIin/khGT4IbhspnkcsRWe/9yFQEQh4xG6nC1CCMwoio0B7L6m5ta/QP59bgPW1
         CwqsjG2mvMqIpvqKZRnbf23jolxyCbkFZzhsxlkfUET58hox/nHreBkoom14Jr0993k2
         5kpGaNKyAI6w0yGwR4WyToOIF+wxS80r4tCV+vosCFoAVbOE17OBcxUXb9Uh6GeBjTMY
         J/tuTD3O4UM/zQbC0+B0PQfwd3noWPiWb1ldu4+B0aHZC+Um0jzrs+nbqO98EhpkrBVE
         0ggcSkk9wJ4zsjzz3HT418iTezENZcEnvIPxqpYUzyuWEsBrg9VcXCALm5P+HfnR/foM
         UFJQ==
X-Gm-Message-State: ACgBeo2ZIpyacQLTEiuFWTnADfTLRTNr1qwTdhCD6wdHmqPevQS5kA1/
        FSQv605njvuDvrhQ1cYevdSB+s2wazrgefcJOpQ=
X-Google-Smtp-Source: AA6agR5zSSQ/Rpk9uJPWSAJeaWj2OyDkOEJ6nU66u3V5Rj943Yvd1SlbOtfLj0mOG9DDKSGQv3XK39UBW2MvjuR4vFQ=
X-Received: by 2002:a17:907:c07:b0:730:b91b:2cab with SMTP id
 ga7-20020a1709070c0700b00730b91b2cabmr24325915ejc.294.1660222345817; Thu, 11
 Aug 2022 05:52:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220810160948.959781-1-syoshida@redhat.com>
In-Reply-To: <20220810160948.959781-1-syoshida@redhat.com>
From:   Kim Suwan <suwan.kim027@gmail.com>
Date:   Thu, 11 Aug 2022 21:52:14 +0900
Message-ID: <CAFNWusZQBFDkpv9DEFFg-a4aZ6-3o55i7g=Mz3+m-rMyN81w3Q@mail.gmail.com>
Subject: Re: [PATCH v2] virtio-blk: Avoid use-after-free on suspend/resume
To:     Shigeru Yoshida <syoshida@redhat.com>
Cc:     mst@redhat.com, jasowang@redhat.com, axboe@kernel.dk,
        pbonzini@redhat.com, stefanha@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 11, 2022 at 1:10 AM Shigeru Yoshida <syoshida@redhat.com> wrote:
>
> hctx->user_data is set to vq in virtblk_init_hctx().  However, vq is
> freed on suspend and reallocated on resume.  So, hctx->user_data is
> invalid after resume, and it will cause use-after-free accessing which
> will result in the kernel crash something like below:
>
> [   22.428391] Call Trace:
> [   22.428899]  <TASK>
> [   22.429339]  virtqueue_add_split+0x3eb/0x620
> [   22.430035]  ? __blk_mq_alloc_requests+0x17f/0x2d0
> [   22.430789]  ? kvm_clock_get_cycles+0x14/0x30
> [   22.431496]  virtqueue_add_sgs+0xad/0xd0
> [   22.432108]  virtblk_add_req+0xe8/0x150
> [   22.432692]  virtio_queue_rqs+0xeb/0x210
> [   22.433330]  blk_mq_flush_plug_list+0x1b8/0x280
> [   22.434059]  __blk_flush_plug+0xe1/0x140
> [   22.434853]  blk_finish_plug+0x20/0x40
> [   22.435512]  read_pages+0x20a/0x2e0
> [   22.436063]  ? folio_add_lru+0x62/0xa0
> [   22.436652]  page_cache_ra_unbounded+0x112/0x160
> [   22.437365]  filemap_get_pages+0xe1/0x5b0
> [   22.437964]  ? context_to_sid+0x70/0x100
> [   22.438580]  ? sidtab_context_to_sid+0x32/0x400
> [   22.439979]  filemap_read+0xcd/0x3d0
> [   22.440917]  xfs_file_buffered_read+0x4a/0xc0
> [   22.441984]  xfs_file_read_iter+0x65/0xd0
> [   22.442970]  __kernel_read+0x160/0x2e0
> [   22.443921]  bprm_execve+0x21b/0x640
> [   22.444809]  do_execveat_common.isra.0+0x1a8/0x220
> [   22.446008]  __x64_sys_execve+0x2d/0x40
> [   22.446920]  do_syscall_64+0x37/0x90
> [   22.447773]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
>
> This patch fixes this issue by getting vq from vblk, and removes
> virtblk_init_hctx().
>
> Fixes: 4e0400525691 ("virtio-blk: support polling I/O")
> Cc: "Suwan Kim" <suwan.kim027@gmail.com>
> Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
> ---
>  drivers/block/virtio_blk.c | 24 ++++++++++--------------
>  1 file changed, 10 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 6fc7850c2b0a..d756423e0059 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -101,6 +101,14 @@ static inline blk_status_t virtblk_result(struct virtblk_req *vbr)
>         }
>  }
>
> +static inline struct virtio_blk_vq *get_virtio_blk_vq(struct blk_mq_hw_ctx *hctx)
> +{
> +       struct virtio_blk *vblk = hctx->queue->queuedata;
> +       struct virtio_blk_vq *vq = &vblk->vqs[hctx->queue_num];
> +
> +       return vq;
> +}
> +
>  static int virtblk_add_req(struct virtqueue *vq, struct virtblk_req *vbr)
>  {
>         struct scatterlist hdr, status, *sgs[3];
> @@ -416,7 +424,7 @@ static void virtio_queue_rqs(struct request **rqlist)
>         struct request *requeue_list = NULL;
>
>         rq_list_for_each_safe(rqlist, req, next) {
> -               struct virtio_blk_vq *vq = req->mq_hctx->driver_data;
> +               struct virtio_blk_vq *vq = get_virtio_blk_vq(req->mq_hctx);
>                 bool kick;
>
>                 if (!virtblk_prep_rq_batch(req)) {
> @@ -837,7 +845,7 @@ static void virtblk_complete_batch(struct io_comp_batch *iob)
>  static int virtblk_poll(struct blk_mq_hw_ctx *hctx, struct io_comp_batch *iob)
>  {
>         struct virtio_blk *vblk = hctx->queue->queuedata;
> -       struct virtio_blk_vq *vq = hctx->driver_data;
> +       struct virtio_blk_vq *vq = get_virtio_blk_vq(hctx);
>         struct virtblk_req *vbr;
>         unsigned long flags;
>         unsigned int len;
> @@ -862,22 +870,10 @@ static int virtblk_poll(struct blk_mq_hw_ctx *hctx, struct io_comp_batch *iob)
>         return found;
>  }
>
> -static int virtblk_init_hctx(struct blk_mq_hw_ctx *hctx, void *data,
> -                         unsigned int hctx_idx)
> -{
> -       struct virtio_blk *vblk = data;
> -       struct virtio_blk_vq *vq = &vblk->vqs[hctx_idx];
> -
> -       WARN_ON(vblk->tag_set.tags[hctx_idx] != hctx->tags);
> -       hctx->driver_data = vq;
> -       return 0;
> -}
> -
>  static const struct blk_mq_ops virtio_mq_ops = {
>         .queue_rq       = virtio_queue_rq,
>         .queue_rqs      = virtio_queue_rqs,
>         .commit_rqs     = virtio_commit_rqs,
> -       .init_hctx      = virtblk_init_hctx,
>         .complete       = virtblk_request_done,
>         .map_queues     = virtblk_map_queues,
>         .poll           = virtblk_poll,
> --
> 2.37.1
>

Hi Shigeru,

It works well on my machine.
I missed the reallocation of vqs on freeze/restore situations.
Thanks for debugging this issue. Michael already committed it.

Regards,
Suwan Kim
