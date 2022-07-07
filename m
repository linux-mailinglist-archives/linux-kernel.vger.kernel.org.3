Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E62CB5699A2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 07:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235064AbiGGFAD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 01:00:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234872AbiGGFAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 01:00:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D52FB2FFDB
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 21:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657169998;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=87kGiNSJscDrhkcqf9onMm+btgIEmECZQ3ujjWWzTDc=;
        b=GHZOvwnr0kTPGRC29QJKFGIzPO/KWdw3Xh1Z3UpOcahukRq+8QjfXtneY3kJ7HxkQxbPwU
        5zUvrzRLrahDO3/Dy6cG6up+5hhTm83SE27wSMXPmVmegnH3aiffGe4CwULyQ00T0JyYMY
        fmDECMrMuNEu7qO/gj+E6h/vF7nSPC0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-481-T4HjFeG0NK2qRPn5VaOG_g-1; Thu, 07 Jul 2022 00:59:57 -0400
X-MC-Unique: T4HjFeG0NK2qRPn5VaOG_g-1
Received: by mail-wm1-f69.google.com with SMTP id o28-20020a05600c511c00b003a04f97f27aso9019890wms.9
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 21:59:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=87kGiNSJscDrhkcqf9onMm+btgIEmECZQ3ujjWWzTDc=;
        b=RkexBfMNKddOAAzmrHt5lVIkneWrsf7kiDVEUCWSsphgMwsuvY3giB5vApOR6i8U/a
         JtjrcDKw33CXtAEpyHC3WCo94vxzX9QOPWc16oD0vjfFN+oL58b4SxkO4CnTbbKe0ixF
         iboipF6Ghr9YBcntpddsh8LAYMqBZfSrDZCUVaUmV6H6z5GPJZRKEKY5mFawjU0ihvl6
         ieacrZ0HEu5O+INsNC7XkcucbiJSwMHVKgYFks0A2epEqxqi7Lsf9CLurv3YZQFijtew
         E9yBCZyKgfnhmweoeHqqCZEDIcZWj2UaNjujPoIvRi4TKkoDz9CTkUJ8B/f+zt4Km6ah
         +Lnw==
X-Gm-Message-State: AJIora8RHM0sviV1hfPfk1Ial+UseR5TqKkop4ayrPDvPZh426e+XwCe
        wfGX/Yx0RJankRHQsm9txe5TichSgyHgvmn1j4wDasUGL/rk7fvZSN7crefkc5YrkTG1P4ChtGr
        eDnwvEy+Ry553d2IHMx0M/EAc
X-Received: by 2002:a05:600c:154c:b0:3a1:884e:72ac with SMTP id f12-20020a05600c154c00b003a1884e72acmr2306295wmg.23.1657169995388;
        Wed, 06 Jul 2022 21:59:55 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1upX1q823M5idzqfyXLIdglC8V3bd4vHkK4OrK+AmRKZd7yXW3c6aZu7VmA8Y4bGp5ywmiDYQ==
X-Received: by 2002:a05:600c:154c:b0:3a1:884e:72ac with SMTP id f12-20020a05600c154c00b003a1884e72acmr2306277wmg.23.1657169995141;
        Wed, 06 Jul 2022 21:59:55 -0700 (PDT)
Received: from redhat.com ([2.52.154.68])
        by smtp.gmail.com with ESMTPSA id k11-20020a05600c1c8b00b003a2cf5eb900sm449581wms.40.2022.07.06.21.59.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 21:59:54 -0700 (PDT)
Date:   Thu, 7 Jul 2022 00:59:50 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Guo Zhi <qtxuning1999@sjtu.edu.cn>
Cc:     jasowang@redhat.com, eperezma@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, sgarzare@redhat.com
Subject: Re: [PATCH v2 4/4] virtio_test: enable indirection feature
Message-ID: <20220707005311-mutt-send-email-mst@kernel.org>
References: <20220707024409.1869-1-qtxuning1999@sjtu.edu.cn>
 <20220707024409.1869-5-qtxuning1999@sjtu.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220707024409.1869-5-qtxuning1999@sjtu.edu.cn>
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 07, 2022 at 10:44:09AM +0800, Guo Zhi wrote:
> Prior implementation don't use indirection feature because there is only
> one descriptor for every io event, actually prior implementation don't
> support indirection because vhost can't translate and find the indirect
> descriptors. This commit enable virtio_test malloc indirect descriptors
> in a indirect buffer and map this buffer to vhost, thus resolve this
> problem.
> 
> Signed-off-by: Guo Zhi <qtxuning1999@sjtu.edu.cn>
> ---
>  tools/virtio/virtio_test.c | 50 ++++++++++++++++++++++++++++++++------
>  1 file changed, 42 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/virtio/virtio_test.c b/tools/virtio/virtio_test.c
> index 363695b33..dca408a5c 100644
> --- a/tools/virtio/virtio_test.c
> +++ b/tools/virtio/virtio_test.c
> @@ -25,7 +25,7 @@
>  #define RINGSIZE   256
>  #define TEST_BUF_NUM 0x100000
>  #define BUF_SIZE   1024
> -/* Unused */
> +#define INDIRECTS_SIZE   (RINGSIZE * sizeof(struct vring_desc) * 8)
>  void *__kmalloc_fake, *__kfree_ignore_start, *__kfree_ignore_end;
>  
>  struct vq_info {
> @@ -47,6 +47,8 @@ struct vdev_info {
>  	int nvqs;
>  	void *buf;
>  	size_t buf_size;
> +	void *indirects;
> +	size_t indirects_size;

What are these exactly?

>  	struct vhost_memory *mem;
>  };
>  
> @@ -131,6 +133,8 @@ static void vq_info_add(struct vdev_info *dev, int num)
>  static void vdev_info_init(struct vdev_info* dev, unsigned long long features)
>  {
>  	int r;
> +	int nregions = 2;
> +
>  	memset(dev, 0, sizeof *dev);
>  	dev->vdev.features = features;
>  	INIT_LIST_HEAD(&dev->vdev.vqs);
> @@ -138,19 +142,25 @@ static void vdev_info_init(struct vdev_info* dev, unsigned long long features)
>  	dev->buf_size = BUF_SIZE;
>  	dev->buf = malloc(dev->buf_size);
>  	assert(dev->buf);
> -        dev->control = open("/dev/vhost-test", O_RDWR);
> +	dev->indirects_size = INDIRECTS_SIZE;
> +	dev->indirects = malloc(dev->indirects_size);
> +	assert(dev->indirects);
> +	dev->control = open("/dev/vhost-test", O_RDWR);
>  	assert(dev->control >= 0);
>  	r = ioctl(dev->control, VHOST_SET_OWNER, NULL);
>  	assert(r >= 0);
>  	dev->mem = malloc(offsetof(struct vhost_memory, regions) +
> -			  sizeof dev->mem->regions[0]);
> +			(sizeof(dev->mem->regions[0])) * nregions);
>  	assert(dev->mem);
>  	memset(dev->mem, 0, offsetof(struct vhost_memory, regions) +
> -                          sizeof dev->mem->regions[0]);
> -	dev->mem->nregions = 1;
> +			(sizeof(dev->mem->regions[0])) * nregions);
> +	dev->mem->nregions = nregions;
>  	dev->mem->regions[0].guest_phys_addr = (long)dev->buf;
>  	dev->mem->regions[0].userspace_addr = (long)dev->buf;
>  	dev->mem->regions[0].memory_size = dev->buf_size;
> +	dev->mem->regions[1].guest_phys_addr = (long)dev->indirects;
> +	dev->mem->regions[1].userspace_addr = (long)dev->indirects;
> +	dev->mem->regions[1].memory_size = dev->indirects_size;
>  	r = ioctl(dev->control, VHOST_SET_MEM_TABLE, dev->mem);
>  	assert(r >= 0);
>  }
> @@ -170,6 +180,19 @@ static void wait_for_interrupt(struct vdev_info *dev)
>  		}
>  }
>  
> +static int test_virtqueue_add_outbuf(struct virtqueue *vq,
> +				     struct scatterlist *sg, unsigned int num,
> +				     void *data, void *indirects)
> +{
> +	int r;
> +
> +	__kmalloc_fake = indirects;
> +	r = virtqueue_add_outbuf(vq, sg, num, data,
> +				 GFP_ATOMIC);
> +	__kmalloc_fake = NULL;
> +	return r;
> +}
> +

Quite a hack. Please add comments with documentation. Also - no way to
avoid hacks?

>  static void run_test(struct vdev_info *dev, struct vq_info *vq,
>  		     bool delayed, int batch, int reset_n, int bufs)
>  {
> @@ -181,6 +204,7 @@ static void run_test(struct vdev_info *dev, struct vq_info *vq,
>  	unsigned len;
>  	long long spurious = 0;
>  	const bool random_batch = batch == RANDOM_BATCH;
> +	void *indirects;
>  
>  	r = ioctl(dev->control, VHOST_TEST_RUN, &test);
>  	assert(r >= 0);
> @@ -188,10 +212,15 @@ static void run_test(struct vdev_info *dev, struct vq_info *vq,
>  		next_reset = INT_MAX;
>  	}
>  
> +	/* Don't kfree indirects. */
> +	__kfree_ignore_start = dev->indirects;
> +	__kfree_ignore_end = dev->indirects + dev->indirects_size;
> +
>  	for (;;) {
>  		virtqueue_disable_cb(vq->vq);
>  		completed_before = completed;
>  		started_before = started;
> +		indirects = dev->indirects;
>  		do {
>  			const bool reset = completed > next_reset;
>  			if (random_batch)
> @@ -203,9 +232,13 @@ static void run_test(struct vdev_info *dev, struct vq_info *vq,
>  				sg_init_table(sg, sg_size);
>  				for (int i = 0; i < sg_size; ++i)
>  					sg_set_buf(&sg[i], dev->buf + i, 0x1);
> -				r = virtqueue_add_outbuf(vq->vq, sg, sg_size,
> -							 dev->buf + started,
> -							 GFP_ATOMIC);
> +
> +				// use indirects buffer repeatedly


C style comments please.

> +				if (indirects + sg_size * sizeof(struct vring_desc) >
> +						dev->indirects + dev->indirects_size)
> +					indirects = dev->indirects;
> +				r = test_virtqueue_add_outbuf(vq->vq, sg, sg_size,
> +							      dev->buf + started, indirects);
>  				if (unlikely(r != 0)) {
>  					if (r == -ENOSPC &&
>  					    started > started_before)
> @@ -216,6 +249,7 @@ static void run_test(struct vdev_info *dev, struct vq_info *vq,
>  				}
>  
>  				++started;
> +				indirects += sg_size * sizeof(struct vring_desc);
>  			}
>  			if (unlikely(!virtqueue_kick(vq->vq))) {
>  				r = -1;
> -- 
> 2.17.1

