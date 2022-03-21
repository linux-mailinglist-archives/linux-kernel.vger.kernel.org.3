Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4483A4E2151
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 08:24:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344583AbiCUHZo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 03:25:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242077AbiCUHZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 03:25:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CC460546B9
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 00:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647847442;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gm1sVEe7dfvUdSkynXTsnwrA/DTKgGNcg7xjF4IEAm0=;
        b=QAQ4k3ncB5sUgY0rOU74GskkcM/0cBl5r/DiRbJoGIKSsjepLWrVQBSJL49E6GX2Tk2Z9K
        /pmjWrdtxawTdPTpi/AYBrynA8PGxuoNf9JKwegPk4v27gn5U2bY5Yml/QR/JbxwzXPHxp
        z7rTHm7xf/e2l35YCg5hHKQWnmUJ1RI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-635-FgfZmjtSO-eMAWVnlDnqhg-1; Mon, 21 Mar 2022 03:24:01 -0400
X-MC-Unique: FgfZmjtSO-eMAWVnlDnqhg-1
Received: by mail-wm1-f71.google.com with SMTP id f19-20020a7bcd13000000b0038c01defd5aso5614293wmj.7
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 00:24:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gm1sVEe7dfvUdSkynXTsnwrA/DTKgGNcg7xjF4IEAm0=;
        b=umz+a798y7WOaUNESuhmFmGA3SUoDBujU2I0iVzbK9qRGq3r2LaaxNJITsHOTurhvU
         z7XFLSzWq4IRwJt6OVcKA24MqPmjJ+EXpi04OOmAhbS2BTChCbwyQ8wF9Ct+DOHQEBlu
         rPX5Q0WxZHg3KJLcE6mRGZyhmkURRCVR9khZOOOkdgPg5HuLPluMftg38fva2KDs7kG1
         RPR32f5G7YUtEZ2wojLdGTxQsNEedEaUkAN7dzmnwrMYBw8F+Vy3XKox5HSJWvRVkt3D
         f/IQTf+ay4g0qwU4KDEwN7ht0l5u0zmm4aKNzs+/Qobbick3V7l4pMpv3kcMDkHZFgKf
         AB/w==
X-Gm-Message-State: AOAM532WokTHEVG7MRZkTiHb1vrSj8dwzvn7j7u/4Zj3ZFy/N0qWOGeO
        bcnbAvV1FP9YqqNhwgiwZbqEG4saetrlim2eFl7x83oKy526WnI0aqi1jIT5aRD0WegYg8pHLeG
        fdqCIrKmkPocKeLRwPdMoMtwd
X-Received: by 2002:a5d:64ce:0:b0:204:1175:690c with SMTP id f14-20020a5d64ce000000b002041175690cmr2961298wri.602.1647847440342;
        Mon, 21 Mar 2022 00:24:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwl3os8XroyBJYveWuikCF+kPUTeHbT5+F3Baho+OM7HQh1WENiU61jeHtVPPieVClAnGIOWg==
X-Received: by 2002:a5d:64ce:0:b0:204:1175:690c with SMTP id f14-20020a5d64ce000000b002041175690cmr2961288wri.602.1647847440056;
        Mon, 21 Mar 2022 00:24:00 -0700 (PDT)
Received: from redhat.com ([2.55.132.0])
        by smtp.gmail.com with ESMTPSA id w5-20020a5d5445000000b00203f8c96bcesm7223459wrv.49.2022.03.21.00.23.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 00:23:59 -0700 (PDT)
Date:   Mon, 21 Mar 2022 03:23:56 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     elic@nvidia.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] vdpa: mlx5: synchronize driver status with CVQ
Message-ID: <20220321032130-mutt-send-email-mst@kernel.org>
References: <20220321060429.10457-1-jasowang@redhat.com>
 <20220321060429.10457-2-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220321060429.10457-2-jasowang@redhat.com>
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21, 2022 at 02:04:29PM +0800, Jason Wang wrote:
> Currently, CVQ doesn't have any synchronization with the driver
> status. Then CVQ emulation code run in the middle of:
> 
> 1) device reset
> 2) device status changed
> 3) map updating
> 
> The will lead several unexpected issue like trying to execute CVQ
> command after the driver has been teared down.
> 
> Fixing this by using reslock to synchronize CVQ emulation code with
> the driver status changing:
> 
> - protect the whole device reset, status changing and map updating
>   with reslock
> - protect the CVQ handler with the reslock and check
>   VIRTIO_CONFIG_S_DRIVER_OK in the CVQ handler
> 
> This will guarantee that:
> 
> 1) CVQ handler won't work if VIRTIO_CONFIG_S_DRIVER_OK is not set
> 2) CVQ handler will see a consistent state of the driver instead of
>    the partial one when it is running in the middle of the
>    teardown_driver() or setup_driver().
> 
> Cc: 5262912ef3cfc ("vdpa/mlx5: Add support for control VQ and MAC setting")
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 42 +++++++++++++++++++++++--------
>  1 file changed, 31 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index d5a6fb3f9c41..524240f55c1c 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -1618,11 +1618,17 @@ static void mlx5_cvq_kick_handler(struct work_struct *work)
>  	mvdev = wqent->mvdev;
>  	ndev = to_mlx5_vdpa_ndev(mvdev);
>  	cvq = &mvdev->cvq;
> +
> +	mutex_lock(&ndev->reslock);
> +
> +	if (!(mvdev->status & VIRTIO_CONFIG_S_DRIVER_OK))
> +		goto done;
> +
>  	if (!(ndev->mvdev.actual_features & BIT_ULL(VIRTIO_NET_F_CTRL_VQ)))
> -		return;
> +		goto done;
>  
>  	if (!cvq->ready)
> -		return;
> +		goto done;
>  
>  	while (true) {
>  		err = vringh_getdesc_iotlb(&cvq->vring, &cvq->riov, &cvq->wiov, &cvq->head,
> @@ -1663,6 +1669,9 @@ static void mlx5_cvq_kick_handler(struct work_struct *work)
>  			break;
>  		}
>  	}
> +
> +done:
> +	mutex_unlock(&ndev->reslock);
>  }
>  
>  static void mlx5_vdpa_kick_vq(struct vdpa_device *vdev, u16 idx)
> @@ -2125,6 +2134,8 @@ static int mlx5_vdpa_change_map(struct mlx5_vdpa_dev *mvdev, struct vhost_iotlb
>  	struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
>  	int err;
>  
> +	mutex_lock(&ndev->reslock);
> +
>  	suspend_vqs(ndev);
>  	err = save_channels_info(ndev);
>  	if (err)
> @@ -2137,18 +2148,20 @@ static int mlx5_vdpa_change_map(struct mlx5_vdpa_dev *mvdev, struct vhost_iotlb
>  		goto err_mr;
>  
>  	if (!(mvdev->status & VIRTIO_CONFIG_S_DRIVER_OK))
> -		return 0;
> +		goto err_mr;
>  
>  	restore_channels_info(ndev);
>  	err = setup_driver(mvdev);
>  	if (err)
>  		goto err_setup;
>  
> +	mutex_unlock(&ndev->reslock);
>  	return 0;
>  
>  err_setup:
>  	mlx5_vdpa_destroy_mr(mvdev);
>  err_mr:
> +	mutex_unlock(&ndev->reslock);
>  	return err;
>  }
>  
> @@ -2157,7 +2170,8 @@ static int setup_driver(struct mlx5_vdpa_dev *mvdev)
>  	struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
>  	int err;
>  
> -	mutex_lock(&ndev->reslock);
> +	WARN_ON(!mutex_is_locked(&ndev->reslock));
> +
>  	if (ndev->setup) {
>  		mlx5_vdpa_warn(mvdev, "setup driver called for already setup driver\n");
>  		err = 0;


Maybe also add a comment near function header explaining this must be
called with lock held.

> @@ -2187,7 +2201,6 @@ static int setup_driver(struct mlx5_vdpa_dev *mvdev)
>  		goto err_fwd;
>  	}
>  	ndev->setup = true;
> -	mutex_unlock(&ndev->reslock);
>  
>  	return 0;
>  
> @@ -2198,23 +2211,22 @@ static int setup_driver(struct mlx5_vdpa_dev *mvdev)
>  err_rqt:
>  	teardown_virtqueues(ndev);
>  out:
> -	mutex_unlock(&ndev->reslock);
>  	return err;
>  }
>  
>  static void teardown_driver(struct mlx5_vdpa_net *ndev)
>  {
> -	mutex_lock(&ndev->reslock);
> +
> +	WARN_ON(!mutex_is_locked(&ndev->reslock));
> +
>  	if (!ndev->setup)
> -		goto out;
> +		return;
>  
>  	remove_fwd_to_tir(ndev);
>  	destroy_tir(ndev);
>  	destroy_rqt(ndev);
>  	teardown_virtqueues(ndev);
>  	ndev->setup = false;
> -out:
> -	mutex_unlock(&ndev->reslock);
>  }
>  
>  static void clear_vqs_ready(struct mlx5_vdpa_net *ndev)
> @@ -2235,6 +2247,8 @@ static void mlx5_vdpa_set_status(struct vdpa_device *vdev, u8 status)
>  
>  	print_status(mvdev, status, true);
>  
> +	mutex_lock(&ndev->reslock);
> +
>  	if ((status ^ ndev->mvdev.status) & VIRTIO_CONFIG_S_DRIVER_OK) {
>  		if (status & VIRTIO_CONFIG_S_DRIVER_OK) {
>  			err = setup_driver(mvdev);
> @@ -2244,16 +2258,19 @@ static void mlx5_vdpa_set_status(struct vdpa_device *vdev, u8 status)
>  			}
>  		} else {
>  			mlx5_vdpa_warn(mvdev, "did not expect DRIVER_OK to be cleared\n");
> -			return;
> +			goto err_clear;
>  		}
>  	}
>  
>  	ndev->mvdev.status = status;
> +	mutex_unlock(&ndev->reslock);
>  	return;
>  
>  err_setup:
>  	mlx5_vdpa_destroy_mr(&ndev->mvdev);
>  	ndev->mvdev.status |= VIRTIO_CONFIG_S_FAILED;
> +err_clear:
> +	mutex_unlock(&ndev->reslock);
>  }
>  
>  static int mlx5_vdpa_reset(struct vdpa_device *vdev)
> @@ -2263,6 +2280,8 @@ static int mlx5_vdpa_reset(struct vdpa_device *vdev)
>  
>  	print_status(mvdev, 0, true);
>  	mlx5_vdpa_info(mvdev, "performing device reset\n");
> +
> +	mutex_lock(&ndev->reslock);
>  	teardown_driver(ndev);
>  	clear_vqs_ready(ndev);
>  	mlx5_vdpa_destroy_mr(&ndev->mvdev);
> @@ -2275,6 +2294,7 @@ static int mlx5_vdpa_reset(struct vdpa_device *vdev)
>  		if (mlx5_vdpa_create_mr(mvdev, NULL))
>  			mlx5_vdpa_warn(mvdev, "create MR failed\n");
>  	}
> +	mutex_unlock(&ndev->reslock);
>  
>  	return 0;
>  }
> -- 
> 2.18.1

