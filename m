Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6184C4E212E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 08:21:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344833AbiCUHWT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 03:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232949AbiCUHWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 03:22:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 311505C36B
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 00:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647847252;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SIJ1lFudMiKPRPgtx9GaQG4dP6LxXEZqctYzO9j/NOg=;
        b=ZSWW0leRe6ilGk3Kv29P1GodpIVkOZnWrEqPdx6kanwPxx2ymQb4lm47xgdyp2mWJ7jE0O
        Ln6IhDs/s4Ey+PXfnKL4j1f0wCqfg1ZE5xmlZeUkjSByivEA5AUZcQ6E9j+Y4VbsdfaI/f
        TEham6NA7hhZsOUWthAykHHug71LRHM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-659-gl3iry-MO4eYoDfa_t84Pg-1; Mon, 21 Mar 2022 03:20:50 -0400
X-MC-Unique: gl3iry-MO4eYoDfa_t84Pg-1
Received: by mail-wm1-f72.google.com with SMTP id 4-20020a05600c274400b0038c8ab2e835so3127492wmw.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 00:20:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SIJ1lFudMiKPRPgtx9GaQG4dP6LxXEZqctYzO9j/NOg=;
        b=bcONJE3f9sA/txZ6pYKk4gWGWYjbdI8yane9ivfw/9ORsQfjRgZQvJN5sMKiUMWWPB
         5BV66Yr66ec4452acbF/bk8lBMUOSyp3e0+YPYxdN+cmTsGqMct9fqdHKsh+prHZTa+C
         84g012nC5DP09AfFqUDL0N6+85gOAVT1pYFXjA4EQmZTnSQKYceUVhvTJzb+j2/R3Es6
         IS9XRHfL38Oi+FMDGaEGjQG+s6QhInW5JwrBhIUh/Z8inwH9GhpM9Z2h15wbzkaSsko3
         Lh7a8b+tXcYir/7/D1eGv1arwX6P2wOL3Xnie51ou52ime7tBy4JY/eKUN/VFBqAvQjR
         cdOg==
X-Gm-Message-State: AOAM531sPYP97hfhmrnXHRlCaZJIbYJIN5QA5ML7jcdmuv3yU94CTX3e
        4hddVXra032M2n6M2VORlYaeiF2pkoKXhgAgoA7Op/Qix1wvFTB4iBEoc2Va7I8fvIH/ujaQj1g
        9+uUr7lDD44KxHji1EWOSZa2c
X-Received: by 2002:a7b:cbc5:0:b0:38c:a756:a8c4 with SMTP id n5-20020a7bcbc5000000b0038ca756a8c4mr2584119wmi.83.1647847249100;
        Mon, 21 Mar 2022 00:20:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyMFI7roHJtjURXiWeuCi+lFKn4bmYP0BmmvCPxzn9UBqWfoqLkvs3gZIW+8PuD1gQkJBXSYQ==
X-Received: by 2002:a7b:cbc5:0:b0:38c:a756:a8c4 with SMTP id n5-20020a7bcbc5000000b0038ca756a8c4mr2584099wmi.83.1647847248803;
        Mon, 21 Mar 2022 00:20:48 -0700 (PDT)
Received: from redhat.com ([2.55.132.0])
        by smtp.gmail.com with ESMTPSA id az26-20020adfe19a000000b00204154a1d1fsm1467442wrb.88.2022.03.21.00.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 00:20:48 -0700 (PDT)
Date:   Mon, 21 Mar 2022 03:20:45 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     elic@nvidia.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] vdpa: mlx5: prevent cvq work from hogging CPU
Message-ID: <20220321032019-mutt-send-email-mst@kernel.org>
References: <20220321060429.10457-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220321060429.10457-1-jasowang@redhat.com>
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21, 2022 at 02:04:28PM +0800, Jason Wang wrote:
> A userspace triggerable infinite loop could happen in
> mlx5_cvq_kick_handler() if userspace keeps sending a huge amount of
> cvq requests.
> 
> Fixing this by introducing a quota and re-queue the work if we're out
> of the budget. While at it, using a per device workqueue to avoid on
> demand memory allocation for cvq.
> 
> Fixes: 5262912ef3cfc ("vdpa/mlx5: Add support for control VQ and MAC setting")
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 28 +++++++++++++++-------------
>  1 file changed, 15 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index d0f91078600e..d5a6fb3f9c41 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -163,6 +163,7 @@ struct mlx5_vdpa_net {
>  	u32 cur_num_vqs;
>  	struct notifier_block nb;
>  	struct vdpa_callback config_cb;
> +	struct mlx5_vdpa_wq_ent cvq_ent;
>  };
>  
>  static void free_resources(struct mlx5_vdpa_net *ndev);
> @@ -1600,6 +1601,8 @@ static virtio_net_ctrl_ack handle_ctrl_mq(struct mlx5_vdpa_dev *mvdev, u8 cmd)
>  	return status;
>  }
>  
> +#define MLX5_CVQ_BUDGET 16
> +
>  static void mlx5_cvq_kick_handler(struct work_struct *work)
>  {
>  	virtio_net_ctrl_ack status = VIRTIO_NET_ERR;
> @@ -1609,17 +1612,17 @@ static void mlx5_cvq_kick_handler(struct work_struct *work)
>  	struct mlx5_control_vq *cvq;
>  	struct mlx5_vdpa_net *ndev;
>  	size_t read, write;
> -	int err;
> +	int err, n = 0;
>  
>  	wqent = container_of(work, struct mlx5_vdpa_wq_ent, work);
>  	mvdev = wqent->mvdev;
>  	ndev = to_mlx5_vdpa_ndev(mvdev);
>  	cvq = &mvdev->cvq;
>  	if (!(ndev->mvdev.actual_features & BIT_ULL(VIRTIO_NET_F_CTRL_VQ)))
> -		goto out;
> +		return;
>  
>  	if (!cvq->ready)
> -		goto out;
> +		return;
>  
>  	while (true) {
>  		err = vringh_getdesc_iotlb(&cvq->vring, &cvq->riov, &cvq->wiov, &cvq->head,
> @@ -1653,9 +1656,13 @@ static void mlx5_cvq_kick_handler(struct work_struct *work)
>  
>  		if (vringh_need_notify_iotlb(&cvq->vring))
>  			vringh_notify(&cvq->vring);
> +
> +		n++;
> +		if (n > MLX5_CVQ_BUDGET) {
> +			queue_work(mvdev->wq, &wqent->work);
> +			break;
> +		}
>  	}
> -out:
> -	kfree(wqent);
>  }
>  
>  static void mlx5_vdpa_kick_vq(struct vdpa_device *vdev, u16 idx)
> @@ -1663,7 +1670,6 @@ static void mlx5_vdpa_kick_vq(struct vdpa_device *vdev, u16 idx)
>  	struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
>  	struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
>  	struct mlx5_vdpa_virtqueue *mvq;
> -	struct mlx5_vdpa_wq_ent *wqent;
>  
>  	if (!is_index_valid(mvdev, idx))
>  		return;
> @@ -1672,13 +1678,7 @@ static void mlx5_vdpa_kick_vq(struct vdpa_device *vdev, u16 idx)
>  		if (!mvdev->cvq.ready)
>  			return;
>  
> -		wqent = kzalloc(sizeof(*wqent), GFP_ATOMIC);
> -		if (!wqent)
> -			return;
> -
> -		wqent->mvdev = mvdev;
> -		INIT_WORK(&wqent->work, mlx5_cvq_kick_handler);
> -		queue_work(mvdev->wq, &wqent->work);
> +		queue_work(mvdev->wq, &ndev->cvq_ent.work);
>  		return;
>  	}
>  
> @@ -2668,6 +2668,8 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
>  	if (err)
>  		goto err_mr;
>  
> +	ndev->cvq_ent.mvdev = mvdev;
> +	INIT_WORK(&ndev->cvq_ent.work, mlx5_cvq_kick_handler);
>  	mvdev->wq = create_singlethread_workqueue("mlx5_vdpa_wq");
>  	if (!mvdev->wq) {
>  		err = -ENOMEM;

Shouldn't there be a flush during cleanup somewhere?

> -- 
> 2.18.1

