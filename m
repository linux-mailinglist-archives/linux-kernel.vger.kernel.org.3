Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 760D25622EE
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 21:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236168AbiF3TQx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 15:16:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232971AbiF3TQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 15:16:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 504E04133B
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 12:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656616608;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8gPj9krTbLjGAvSHhIp9TWblMOR87ZSI83JsXe3PpyM=;
        b=NrkuzOSFmZYiMd6XnE29rAZvwR6pR1iQQtRYnoBtSAXb9GTidO0BwE+KFKv3+JNnk9KEpV
        Zxhh8vEP8BWhs7thiley8e9vjGp3So9OuPdSM2F3u6iWXtFPA2p4wy3AunaA2SsDwdR9Wf
        EuVwD2RcgxNeHXAbtjSv7Z9j6z3pFYc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-407-Cy-lw1dgM52j6kq0Q8CzgA-1; Thu, 30 Jun 2022 15:16:47 -0400
X-MC-Unique: Cy-lw1dgM52j6kq0Q8CzgA-1
Received: by mail-wm1-f69.google.com with SMTP id 6-20020a1c0206000000b003a02cd754d1so8333068wmc.9
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 12:16:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8gPj9krTbLjGAvSHhIp9TWblMOR87ZSI83JsXe3PpyM=;
        b=JjJ28FY2onNzY5yzxh1LddZUuu5ufuG1jXb965ehel9C8ZUUU/gchfhHkRReVdflym
         OngMzagmkVILjHJsvlqyATZv2ihzkYP+hDlXryXNZJOyCcseppUdA4RRV55orKaMN9pl
         7ziqQd3k4+knP4TTYTzy2vIP4rnx4TrJHZOc1YHkphGddpDYBVhKqSAOuTu6a8DBPNRl
         nEHBcsb45V2mC9KOwkw4t1f1sHqvPjEiY5gMvt+ZgLVAMlFMol4BS9beXqHZEYFMQDMm
         BEgv5x5Ky5jjyI9zwk7gvKOnXGdjzSIJEf1q5OSYglLrlZY7dyx6fOtMHNsuKEMYth/X
         Nnuw==
X-Gm-Message-State: AJIora8W/KDV+nBnw46urQYF1BWISGckCSQiXAP0aQXGjVLYuAeAqJQb
        7p+uNhhUvbLn/5P6bohWavDLDHKO/xVHbKRY73UutjaHj8z/PaxzQnhUFup/4HgxH25lsMERgkO
        XOtxx95kT58o0xrLF7tvmF2P7
X-Received: by 2002:a05:6000:9:b0:21b:9ebf:54e4 with SMTP id h9-20020a056000000900b0021b9ebf54e4mr10212830wrx.658.1656616605508;
        Thu, 30 Jun 2022 12:16:45 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1s/F4GcF0m776xEtj95hoyvqAE5yPjbDqrmsHQFlCRSRhIilYJvx8+EQ/1YhAZ1T5+5/jUpaQ==
X-Received: by 2002:a05:6000:9:b0:21b:9ebf:54e4 with SMTP id h9-20020a056000000900b0021b9ebf54e4mr10212811wrx.658.1656616605260;
        Thu, 30 Jun 2022 12:16:45 -0700 (PDT)
Received: from redhat.com ([2.55.3.188])
        by smtp.gmail.com with ESMTPSA id n1-20020a1c2701000000b003a0231af43csm7692663wmn.48.2022.06.30.12.16.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 12:16:44 -0700 (PDT)
Date:   Thu, 30 Jun 2022 15:16:41 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Atish Patra <atishp@atishpatra.org>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        linux-remoteproc@vger.kernel.org, kvm-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rpmsg: virtio: Fix broken rpmsg_probe()
Message-ID: <20220630150732-mutt-send-email-mst@kernel.org>
References: <20220608171334.730739-1-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220608171334.730739-1-apatel@ventanamicro.com>
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 08, 2022 at 10:43:34PM +0530, Anup Patel wrote:
> The rpmsg_probe() is broken at the moment because virtqueue_add_inbuf()
> fails due to both virtqueues (Rx and Tx) marked as broken by the
> __vring_new_virtqueue() function. To solve this, virtio_device_ready()
> (which unbreaks queues) should be called before virtqueue_add_inbuf().
> 
> Fixes: 8b4ec69d7e09 ("virtio: harden vring IRQ")
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>


Yea, I've more or less reverted that. (There's VIRTIO_HARDEN_NOTIFICATION
that we'll use to try and develop this to something more reasonable).

> ---
>  drivers/rpmsg/virtio_rpmsg_bus.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
> index 905ac7910c98..71a64d2c7644 100644
> --- a/drivers/rpmsg/virtio_rpmsg_bus.c
> +++ b/drivers/rpmsg/virtio_rpmsg_bus.c
> @@ -929,6 +929,9 @@ static int rpmsg_probe(struct virtio_device *vdev)
>  	/* and half is dedicated for TX */
>  	vrp->sbufs = bufs_va + total_buf_space / 2;
>  
> +	/* From this point on, we can notify and get callbacks. */
> +	virtio_device_ready(vdev);
> +
>  	/* set up the receive buffers */
>  	for (i = 0; i < vrp->num_bufs / 2; i++) {
>  		struct scatterlist sg;
> @@ -983,9 +986,6 @@ static int rpmsg_probe(struct virtio_device *vdev)
>  	 */
>  	notify = virtqueue_kick_prepare(vrp->rvq);
>  
> -	/* From this point on, we can notify and get callbacks. */
> -	virtio_device_ready(vdev);
> -
>  	/* tell the remote processor it can start sending messages */
>  	/*
>  	 * this might be concurrent with callbacks, but we are only
> -- 
> 2.34.1
> 
> 

