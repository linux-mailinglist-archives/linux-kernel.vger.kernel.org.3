Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEA1258EC61
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 14:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232319AbiHJMzX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 08:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232283AbiHJMzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 08:55:16 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BF4317E0F;
        Wed, 10 Aug 2022 05:55:15 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id a8so14637973pjg.5;
        Wed, 10 Aug 2022 05:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc;
        bh=q5pzR9cYI26uHb2cy0Dx2bZk76nwKD6XUexNgn2JD3g=;
        b=aCpqMOCjzmlO9Q+T6z3yMZv6hE5ss39fR7nIWjwLtApQs8ZD7SXYe5jCCot/gwAFKx
         VSzitsyCRP2TSw999TCe69gY3X9srVC+cPxa8eHBh8990A9A7PcgggnGLvIrTQJSRhyR
         ujF+6KJgfJILAW1b950XTL8kuAH9wJdgTwe3tvT6tNruN1PSPtQ2fMTm9NdK/ob5KHx8
         uAkqZiPatMfO+YI2+PAjivtIZQ2XzCb/ZvSS4g6o0dGnfGuzKU+7XM23xt1sKEwt2FU+
         Gs66XoJvPLd5nUDUqagBQJnQHduWQ6sgFt1NiISf+B30/A7v4QedA1Ayw1pqg/H2Ji0l
         PK5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc;
        bh=q5pzR9cYI26uHb2cy0Dx2bZk76nwKD6XUexNgn2JD3g=;
        b=1Gs4e1W7s7IWpX3llRtWoLVJ0fg/NacqmJFPcPe26UAHNKmE6wWfBclElWSJnX0+Zr
         CSVPYi+/gFrBcSPnxR12LkCn04ZSssjlibL4zX2p1UyBKFC2fA3GXWSmqPjWU/sJS+3h
         tanGRz+K+KhvRlRMbWicKTQtP94UyOIl+DWhOvd47hZ4VTA9hrYyvO1KByTMQZbt/LQe
         4DBmzKBI6gg2LYWJ79kyr5wYDp8740S7rgK9UCGZbpcjQ+gD6srtYuvDWd8JOZs9iOMv
         pQ2RQ9R1fJ2v4OKAyLCvwuinRM6kgoHSjqPpCGpUk5erxt8QrRZ1z9Cez/K2A6Q745Zt
         eSng==
X-Gm-Message-State: ACgBeo0kDwVI+/RLXq2c97cCE2bhAlNctqROC6YU6bF094ILQjWM6+lF
        24tk3Y3iEXs07Dv0GeFtiw==
X-Google-Smtp-Source: AA6agR6XFPySjhsoFztTXrEROd+fI8QbhtrR8lGEm8TdR23Z6SzvCV3ZyaBCtdaOCqEDRmUViVGb3A==
X-Received: by 2002:a17:90b:1e0c:b0:1f5:4e52:4866 with SMTP id pg12-20020a17090b1e0c00b001f54e524866mr3679074pjb.230.1660136115053;
        Wed, 10 Aug 2022 05:55:15 -0700 (PDT)
Received: from localhost ([240d:1a:c0d:9f00:4f2f:926a:23dd:8588])
        by smtp.gmail.com with ESMTPSA id 7-20020a620407000000b0052d3e81886fsm1908364pfe.42.2022.08.10.05.55.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 05:55:14 -0700 (PDT)
Date:   Wed, 10 Aug 2022 21:55:10 +0900 (JST)
Message-Id: <20220810.215510.73630597636704879.shigeru.yoshida@gmail.com>
To:     mst@redhat.com
Cc:     jasowang@redhat.com, axboe@kernel.dk, pbonzini@redhat.com,
        stefanha@redhat.com, virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtio-blk: Avoid use-after-free on suspend/resume
From:   Shigeru Yoshida <shigeru.yoshida@gmail.com>
In-Reply-To: <20220810084053-mutt-send-email-mst@kernel.org>
References: <20220731070951.196831-1-shigeru.yoshida@gmail.com>
        <20220810.204556.441522765735488771.shigeru.yoshida@gmail.com>
        <20220810084053-mutt-send-email-mst@kernel.org>
X-Mailer: Mew version 6.8 on Emacs 28.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 10 Aug 2022 08:41:04 -0400, Michael S. Tsirkin wrote:
> On Wed, Aug 10, 2022 at 08:45:56PM +0900, Shigeru Yoshida wrote:
>> ping?
>> 
>> On Sun, 31 Jul 2022 16:09:51 +0900, Shigeru Yoshida wrote:
>> > hctx->user_data is set to vq in virtblk_init_hctx().  However, vq is
>> > freed on suspend and reallocated on resume.  So, hctx->user_data is
>> > invalid after resume, and it will cause use-after-free accessing which
>> > will result in the kernel crash something like below:
>> > 
>> > [   22.428391] Call Trace:
>> > [   22.428899]  <TASK>
>> > [   22.429339]  virtqueue_add_split+0x3eb/0x620
>> > [   22.430035]  ? __blk_mq_alloc_requests+0x17f/0x2d0
>> > [   22.430789]  ? kvm_clock_get_cycles+0x14/0x30
>> > [   22.431496]  virtqueue_add_sgs+0xad/0xd0
>> > [   22.432108]  virtblk_add_req+0xe8/0x150
>> > [   22.432692]  virtio_queue_rqs+0xeb/0x210
>> > [   22.433330]  blk_mq_flush_plug_list+0x1b8/0x280
>> > [   22.434059]  __blk_flush_plug+0xe1/0x140
>> > [   22.434853]  blk_finish_plug+0x20/0x40
>> > [   22.435512]  read_pages+0x20a/0x2e0
>> > [   22.436063]  ? folio_add_lru+0x62/0xa0
>> > [   22.436652]  page_cache_ra_unbounded+0x112/0x160
>> > [   22.437365]  filemap_get_pages+0xe1/0x5b0
>> > [   22.437964]  ? context_to_sid+0x70/0x100
>> > [   22.438580]  ? sidtab_context_to_sid+0x32/0x400
>> > [   22.439979]  filemap_read+0xcd/0x3d0
>> > [   22.440917]  xfs_file_buffered_read+0x4a/0xc0
>> > [   22.441984]  xfs_file_read_iter+0x65/0xd0
>> > [   22.442970]  __kernel_read+0x160/0x2e0
>> > [   22.443921]  bprm_execve+0x21b/0x640
>> > [   22.444809]  do_execveat_common.isra.0+0x1a8/0x220
>> > [   22.446008]  __x64_sys_execve+0x2d/0x40
>> > [   22.446920]  do_syscall_64+0x37/0x90
>> > [   22.447773]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
>> > 
>> > This patch fixes this issue by getting vq from vblk, and removes
>> > virtblk_init_hctx().
>> > 
>> > Signed-off-by: Shigeru Yoshida <shigeru.yoshida@gmail.com>
> 
> Fixes: 4e0400525691 ("virtio-blk: support polling I/O")
> Cc: "Suwan Kim" <suwan.kim027@gmail.com>
> 
> I assume?

Yes, this patch fixes the commit you mentioned.

Thanks,
Shigeru

> 
>> > ---
>> >  drivers/block/virtio_blk.c | 24 ++++++++++--------------
>> >  1 file changed, 10 insertions(+), 14 deletions(-)
>> > 
>> > diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
>> > index 6fc7850c2b0a..d756423e0059 100644
>> > --- a/drivers/block/virtio_blk.c
>> > +++ b/drivers/block/virtio_blk.c
>> > @@ -101,6 +101,14 @@ static inline blk_status_t virtblk_result(struct virtblk_req *vbr)
>> >  	}
>> >  }
>> >  
>> > +static inline struct virtio_blk_vq *get_virtio_blk_vq(struct blk_mq_hw_ctx *hctx)
>> > +{
>> > +	struct virtio_blk *vblk = hctx->queue->queuedata;
>> > +	struct virtio_blk_vq *vq = &vblk->vqs[hctx->queue_num];
>> > +
>> > +	return vq;
>> > +}
>> > +
>> >  static int virtblk_add_req(struct virtqueue *vq, struct virtblk_req *vbr)
>> >  {
>> >  	struct scatterlist hdr, status, *sgs[3];
>> > @@ -416,7 +424,7 @@ static void virtio_queue_rqs(struct request **rqlist)
>> >  	struct request *requeue_list = NULL;
>> >  
>> >  	rq_list_for_each_safe(rqlist, req, next) {
>> > -		struct virtio_blk_vq *vq = req->mq_hctx->driver_data;
>> > +		struct virtio_blk_vq *vq = get_virtio_blk_vq(req->mq_hctx);
>> >  		bool kick;
>> >  
>> >  		if (!virtblk_prep_rq_batch(req)) {
>> > @@ -837,7 +845,7 @@ static void virtblk_complete_batch(struct io_comp_batch *iob)
>> >  static int virtblk_poll(struct blk_mq_hw_ctx *hctx, struct io_comp_batch *iob)
>> >  {
>> >  	struct virtio_blk *vblk = hctx->queue->queuedata;
>> > -	struct virtio_blk_vq *vq = hctx->driver_data;
>> > +	struct virtio_blk_vq *vq = get_virtio_blk_vq(hctx);
>> >  	struct virtblk_req *vbr;
>> >  	unsigned long flags;
>> >  	unsigned int len;
>> > @@ -862,22 +870,10 @@ static int virtblk_poll(struct blk_mq_hw_ctx *hctx, struct io_comp_batch *iob)
>> >  	return found;
>> >  }
>> >  
>> > -static int virtblk_init_hctx(struct blk_mq_hw_ctx *hctx, void *data,
>> > -			  unsigned int hctx_idx)
>> > -{
>> > -	struct virtio_blk *vblk = data;
>> > -	struct virtio_blk_vq *vq = &vblk->vqs[hctx_idx];
>> > -
>> > -	WARN_ON(vblk->tag_set.tags[hctx_idx] != hctx->tags);
>> > -	hctx->driver_data = vq;
>> > -	return 0;
>> > -}
>> > -
>> >  static const struct blk_mq_ops virtio_mq_ops = {
>> >  	.queue_rq	= virtio_queue_rq,
>> >  	.queue_rqs	= virtio_queue_rqs,
>> >  	.commit_rqs	= virtio_commit_rqs,
>> > -	.init_hctx	= virtblk_init_hctx,
>> >  	.complete	= virtblk_request_done,
>> >  	.map_queues	= virtblk_map_queues,
>> >  	.poll		= virtblk_poll,
>> > -- 
>> > 2.37.1
>> > 
> 
