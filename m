Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 017075699BE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 07:17:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234897AbiGGFQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 01:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbiGGFQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 01:16:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3146531234
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 22:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657171005;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1/5gQIogadsVarAHL6peGmK6MYhegEwuOEcNLhHz0wI=;
        b=JveTPD/P/FtxCwwmmOlvWTUy8P0d7Htt6KcsTvzISaWBv7rHKtVnGlTV+yX8axUvu1S2Pm
        z7SXOyCnSkxmP6mhl8axq5U0M6dZcmeS93NYTiqnH5YdoNCe6cfPlpHho8ehGpzxGxkhOq
        yLkuPYRwAL6L4wH8EPha/JyyLI3Whlg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-12-4hGVzF9MPAqY9bOuJFZ5Zg-1; Thu, 07 Jul 2022 01:16:43 -0400
X-MC-Unique: 4hGVzF9MPAqY9bOuJFZ5Zg-1
Received: by mail-wm1-f69.google.com with SMTP id v67-20020a1cac46000000b003a2be9fa09cso2124643wme.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 22:16:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1/5gQIogadsVarAHL6peGmK6MYhegEwuOEcNLhHz0wI=;
        b=sXJAm9w9bmzON4OoHgob6F4iqtmL6Xdt0eaIlG129/+NZ4woA5gAJauNL0NdjM/I3L
         piX+DGDczvvi2b/gWWjUO60BR+gfYDsD/nXiOI0thKMWRlKx3R3biPtlLr9/FE9MsP3r
         oDzvtx7QZxocFpiLQyjFYzkV3h4ATo18C8RN1vH5cIa4/2f7wzFk4g+/0goLnSCKoKQa
         Wxt61IPT0HbIYJEy8jxEWpkAzjPEkkqe5UAOV+ssPSdwauSqBEq2/XHNK80GfLtQqgh4
         zxEXVxZ0V7eJdsil4X56GrHBag89lcR60rF3Dk5YdnyXj8U/Hrs4K4cPitAk9c/jnlLk
         Hm1A==
X-Gm-Message-State: AJIora+KSw6+ql1YPU9LT1Z4a2OH92qRQHdoVvKt8fmeILP/MuuBOLps
        F5IW8zQ7wp3twtus3zxD/Ua5SEayIV31aN7ZmPBJdp3e17EawXJ5lgiltXYoxDz+q5Foi5jQUSI
        T4AwjqZ+ogfd9wQup1FAWLsBv
X-Received: by 2002:a1c:770d:0:b0:3a0:3d95:4538 with SMTP id t13-20020a1c770d000000b003a03d954538mr2272524wmi.17.1657171002751;
        Wed, 06 Jul 2022 22:16:42 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1szzNKb24PPtBh+b6VdvF9GQriDQNIAizLQlki1SQSJXfirR97xglPrMIyx3ky0UhetxN3TpQ==
X-Received: by 2002:a1c:770d:0:b0:3a0:3d95:4538 with SMTP id t13-20020a1c770d000000b003a03d954538mr2272515wmi.17.1657171002572;
        Wed, 06 Jul 2022 22:16:42 -0700 (PDT)
Received: from redhat.com ([2.52.154.68])
        by smtp.gmail.com with ESMTPSA id f18-20020adff992000000b0021b9416fa13sm15603260wrr.90.2022.07.06.22.16.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 22:16:42 -0700 (PDT)
Date:   Thu, 7 Jul 2022 01:16:38 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Guo Zhi <qtxuning1999@sjtu.edu.cn>
Cc:     jasowang@redhat.com, eperezma@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, sgarzare@redhat.com
Subject: Re: [PATCH v2 3/4] virtio_test: use random length scatterlists to
 test descriptor chain
Message-ID: <20220707011015-mutt-send-email-mst@kernel.org>
References: <20220707024409.1869-1-qtxuning1999@sjtu.edu.cn>
 <20220707024409.1869-4-qtxuning1999@sjtu.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220707024409.1869-4-qtxuning1999@sjtu.edu.cn>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 07, 2022 at 10:44:08AM +0800, Guo Zhi wrote:
> Prior implementation only use one descriptor for each io event, which
> does't test code of descriptor chain. More importantly, one descriptor
> will not use indirect feature even indirect feature is specified. Use
> random length scatterlists here to test descriptor chain.
> 
> Signed-off-by: Guo Zhi <qtxuning1999@sjtu.edu.cn>
> ---
>  tools/virtio/virtio_test.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/virtio/virtio_test.c b/tools/virtio/virtio_test.c
> index 1ecd64271..363695b33 100644
> --- a/tools/virtio/virtio_test.c
> +++ b/tools/virtio/virtio_test.c
> @@ -20,6 +20,7 @@
>  #include "../../drivers/vhost/test.h"
>  
>  #define RANDOM_BATCH -1
> +#define MAX_SG_FRAGS 8UL
>  #define ALIGN 4096
>  #define RINGSIZE   256
>  #define TEST_BUF_NUM 0x100000
> @@ -172,7 +173,8 @@ static void wait_for_interrupt(struct vdev_info *dev)
>  static void run_test(struct vdev_info *dev, struct vq_info *vq,
>  		     bool delayed, int batch, int reset_n, int bufs)
>  {
> -	struct scatterlist sl;
> +	struct scatterlist sg[MAX_SG_FRAGS];
> +	int sg_size = 0;
>  	long started = 0, completed = 0, next_reset = reset_n;
>  	long completed_before, started_before;
>  	int r, test = 1;
> @@ -197,8 +199,11 @@ static void run_test(struct vdev_info *dev, struct vq_info *vq,
>  
>  			while (started < bufs &&
>  			       (started - completed) < batch) {
> -				sg_init_one(&sl, dev->buf, dev->buf_size);
> -				r = virtqueue_add_outbuf(vq->vq, &sl, 1,
> +				sg_size = random() % (MAX_SG_FRAGS - 1) + 1;
> +				sg_init_table(sg, sg_size);
> +				for (int i = 0; i < sg_size; ++i)
> +					sg_set_buf(&sg[i], dev->buf + i, 0x1);
> +				r = virtqueue_add_outbuf(vq->vq, sg, sg_size,
>  							 dev->buf + started,
>  							 GFP_ATOMIC);
>  				if (unlikely(r != 0)) {

random on data path is pretty expensive.
I would suggest get an array size from user (and maybe a seed?) and
pregenerate some numbers, then reuse.


> -- 
> 2.17.1

