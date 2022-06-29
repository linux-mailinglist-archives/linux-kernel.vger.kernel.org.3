Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1139E560786
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 19:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230513AbiF2Rn1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 13:43:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbiF2RnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 13:43:24 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D6C322B1D
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 10:43:22 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id k9so6550368pfg.5
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 10:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JYmoTNNj2u0Lok7u1LjrEtUQiPn3m9TUK3sK1Y6kL4A=;
        b=rUeuBihYsq497ezCoCAJZAN+xjweZLDohCiI8Ix/wAaJ/zhbrEh0XGF1MSRHmVfzCP
         9QVgiWs+6ILQq4RlM4wcMdNpcH+bjSNJkg7rqUTdUawMmgI0zXfIcpnxsm6au2kQmiCt
         hNDnwhgmYde+YY1XOZVZnOYI6q3J/NDuP6aiCCAIaxLVuIh7Z1eLuSO+CDIZ8wknyPBr
         PaFmfICaASRnV4xv7mu0F01fF8YLTqdlKd7AXKLLbkJi/ivTWCeFUQCeZWQJTidEgNE/
         JtmNs+U0sxiKPhEPsiZdpGoWNVpXKkukGDuEd+AIiudVKpEGRbLYnTxxS4g7RkFVtpAs
         LZVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JYmoTNNj2u0Lok7u1LjrEtUQiPn3m9TUK3sK1Y6kL4A=;
        b=lEabUQkkVo6K6S6JI2hxaePwH0axqG9cC/INc22eNw6gQ/o3DHaO4DM8qok0ZOJ/Zy
         UKaG2P9D9tSYwbJsaJtl8vjCcAHiipbfkWzAN3qM6qvH0LVFKKv/KulPdTB4KBRCZYmq
         YS0+ZRmWzZUw7j637vDQI5UrOGg57OCergq53RBZdfRCZ56mOgc3dMfQ180rExjPIfL3
         fWBpsDPcCQFBMrQhbLZZmXnHQU9o0dQI+0HJrDZX1NqloNzgjGla+GxM5r980DFSQlAP
         7cx/T3X2jwv3byLbu+o7zBAh4bhz5Sox/JpeeCTfSQ6zNV1mIAnYWGtiOOwTNiquxACp
         2YSQ==
X-Gm-Message-State: AJIora+wEY58OHZO/aFBB1lNATMKONOyW6eUym3UrJ+/it7D4btfhhQ+
        PiJwgPr4bhz42nqjkTP6UQ2yEg==
X-Google-Smtp-Source: AGRyM1sLJtpLkVERiBCjUAP4WJMQReS9VEfnekz+M+5IbfdSpho2//yeUPx0+GXDAPGWBEyGLl/Syw==
X-Received: by 2002:a62:ee07:0:b0:525:1a3e:bebb with SMTP id e7-20020a62ee07000000b005251a3ebebbmr11229314pfi.77.1656524602172;
        Wed, 29 Jun 2022 10:43:22 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id f20-20020a170902ab9400b0016a109c7606sm11796430plr.259.2022.06.29.10.43.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 10:43:20 -0700 (PDT)
Date:   Wed, 29 Jun 2022 11:43:18 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Atish Patra <atishp@atishpatra.org>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        linux-remoteproc@vger.kernel.org, kvm-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rpmsg: virtio: Fix broken rpmsg_probe()
Message-ID: <20220629174318.GB2018382@p14s>
References: <20220608171334.730739-1-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220608171334.730739-1-apatel@ventanamicro.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anup,

On Wed, Jun 08, 2022 at 10:43:34PM +0530, Anup Patel wrote:
> The rpmsg_probe() is broken at the moment because virtqueue_add_inbuf()
> fails due to both virtqueues (Rx and Tx) marked as broken by the
> __vring_new_virtqueue() function. To solve this, virtio_device_ready()
> (which unbreaks queues) should be called before virtqueue_add_inbuf().
> 
> Fixes: 8b4ec69d7e09 ("virtio: harden vring IRQ")
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
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

Calling virtio_device_ready() here means that virtqueue_get_buf_ctx_split() can
potentially be called (by way of rpmsg_recv_done()), which will race with
virtqueue_add_inbuf().  If buffers in the virtqueue aren't available then
rpmsg_recv_done() will fail, potentially breaking remote processors' state
machines that don't expect their initial name service to fail when the "device"
has been marked as ready.

What does make me curious though is that nobody on the remoteproc mailing list
has complained about commit 8b4ec69d7e09 breaking their environment... By now,
i.e rc4, that should have happened.  Anyone from TI, ST and Xilinx care to test this on
their rig?

Thanks,
Mathieu

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
