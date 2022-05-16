Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 938F3528062
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 11:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232193AbiEPJHz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 05:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237440AbiEPJHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 05:07:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D1D2DDF45
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 02:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652692056;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hv3r7ywwBY+MFq7sMrvzb8rnxuHrTSC23t3Ukqr2ZWk=;
        b=f8esMoRCUFYJNe/dw3c8OQCeUENH1wCHNXT0URze3gKuymwMtwtzFv9/slye/hzxJew7EK
        sYUo8CPWQ3LnGCiBPcWYIuPq6ZUv/dzKh3Wy7Iw4cgPbgKCc0RmjqH0fwcq1/J0defoKbi
        T76M7rnAlei6DbW/9xyzgDgQqy73qZ8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-587-D8Jap-kMPe62Ez2CXTYLRQ-1; Mon, 16 May 2022 05:07:34 -0400
X-MC-Unique: D8Jap-kMPe62Ez2CXTYLRQ-1
Received: by mail-wm1-f72.google.com with SMTP id m124-20020a1c2682000000b00393fcd2722dso5352405wmm.4
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 02:07:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hv3r7ywwBY+MFq7sMrvzb8rnxuHrTSC23t3Ukqr2ZWk=;
        b=cIksS2SJURuLzW9zPD4XrDsLu6Qr3Rx8X1fnA5IDmzk/KkRq1XdzjsPoUxy7IFM43D
         St4ekP2PXScYLnBFpfZnnJteNY8YQpDRS62vWbTX6zTf2RQWWNHC4zT16MtsqZMGbN70
         O851Yrdtk6lku2jNhKQW651PJm6tWZ/q0adaLBH336lDFAnDhlhYX0f2+mAh7AvrlBON
         AAaBLe4aTejHeua2iFzHfrZ06hbTbqA7vt3Tj9ubpbqg7bnbbCzC75eDefq5Edl2f+G7
         ibDJ3WVhni3opjZZL1KRpwHsBZQIUv8hQuNjM7XomBoDMMCYuGplCjp1E6N/oXxB16S8
         G77w==
X-Gm-Message-State: AOAM533WgenVpqbvVdhh6aNktoi55WTWrMKRLnCvF1hiqxUogudpDc9i
        VbWxlyQ63Ba6uP21DC7OmvJ7ARz3oFlwFcI5t5tL6QDAEg2sPjHZGT+MNKQF7U+58kJeqmUd4rN
        P/1Gt3Wfcc9wyccYjDa1nRzuE
X-Received: by 2002:a5d:45c2:0:b0:20d:689:9a with SMTP id b2-20020a5d45c2000000b0020d0689009amr4375379wrs.17.1652692052380;
        Mon, 16 May 2022 02:07:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzKeI/FnFQ0miz4j3jF7FyuiHc454mE3tyAvhhsESfbXImBd//z9fsY35jdX5QJBUFD/I/ngA==
X-Received: by 2002:a5d:45c2:0:b0:20d:689:9a with SMTP id b2-20020a5d45c2000000b0020d0689009amr4375363wrs.17.1652692052125;
        Mon, 16 May 2022 02:07:32 -0700 (PDT)
Received: from redhat.com ([2.55.141.66])
        by smtp.gmail.com with ESMTPSA id q29-20020adfab1d000000b0020c66310845sm4966393wrc.55.2022.05.16.02.07.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 02:07:31 -0700 (PDT)
Date:   Mon, 16 May 2022 05:07:28 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Eli Cohen <elic@nvidia.com>
Cc:     jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, si-wei.liu@oracle.com
Subject: Re: [PATCH] vdpa/mlx5: Use consistent RQT size
Message-ID: <20220516045637-mutt-send-email-mst@kernel.org>
References: <20220516084735.198165-1-elic@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220516084735.198165-1-elic@nvidia.com>
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 16, 2022 at 11:47:35AM +0300, Eli Cohen wrote:
> The current code evaluates RQT size based on the configured number of
> virtqueues. This can raise an issue in the following scenario:
> 
> Assume MQ was negotiated.
> 1. mlx5_vdpa_set_map() gets called.
> 2. handle_ctrl_mq() is called setting cur_num_vqs to some value, lower
>    than the configured max VQs.
> 3. A second set_map gets called, but now a smaller number of VQs is used
>    to evaluate the size of the RQT.
> 4. handle_ctrl_mq() is called with a value larger than what the RQT can
>    hold. This will emit errors and the driver state is compromised.
> 
> To fix this, we use a new field in struct mlx5_vdpa_net to hold the
> required number of entries in the RQT. This value is evaluated in
> mlx5_vdpa_set_driver_features() where we have the negotiated features
> all set up.
> 
> In addition to that, we take into consideration the max capability of RQT
> entries early when the device is added so we don't need to take consider
> it when creating the RQT.
> 
> Last, we remove the use of mlx5_vdpa_max_qps() which just returns the
> max_vas / 2 and make the code clearer.
> 
> Fixes: 52893733f2c5 ("vdpa/mlx5: Add multiqueue support")
> Acked-by: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Eli Cohen <elic@nvidia.com>

I picked this up. Thanks!

> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 61 +++++++++++--------------------
>  1 file changed, 21 insertions(+), 40 deletions(-)
> 
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index 79001301b383..e0de44000d92 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -161,6 +161,7 @@ struct mlx5_vdpa_net {
>  	struct mlx5_flow_handle *rx_rule_mcast;
>  	bool setup;
>  	u32 cur_num_vqs;
> +	u32 rqt_size;
>  	struct notifier_block nb;
>  	struct vdpa_callback config_cb;
>  	struct mlx5_vdpa_wq_ent cvq_ent;
> @@ -204,17 +205,12 @@ static __virtio16 cpu_to_mlx5vdpa16(struct mlx5_vdpa_dev *mvdev, u16 val)
>  	return __cpu_to_virtio16(mlx5_vdpa_is_little_endian(mvdev), val);
>  }
>  
> -static inline u32 mlx5_vdpa_max_qps(int max_vqs)
> -{
> -	return max_vqs / 2;
> -}
> -
>  static u16 ctrl_vq_idx(struct mlx5_vdpa_dev *mvdev)
>  {
>  	if (!(mvdev->actual_features & BIT_ULL(VIRTIO_NET_F_MQ)))
>  		return 2;
>  
> -	return 2 * mlx5_vdpa_max_qps(mvdev->max_vqs);
> +	return mvdev->max_vqs;
>  }
>  
>  static bool is_ctrl_vq_idx(struct mlx5_vdpa_dev *mvdev, u16 idx)
> @@ -1236,25 +1232,13 @@ static void teardown_vq(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *
>  static int create_rqt(struct mlx5_vdpa_net *ndev)
>  {
>  	__be32 *list;
> -	int max_rqt;
>  	void *rqtc;
>  	int inlen;
>  	void *in;
>  	int i, j;
>  	int err;
> -	int num;
> -
> -	if (!(ndev->mvdev.actual_features & BIT_ULL(VIRTIO_NET_F_MQ)))
> -		num = 1;
> -	else
> -		num = ndev->cur_num_vqs / 2;
>  
> -	max_rqt = min_t(int, roundup_pow_of_two(num),
> -			1 << MLX5_CAP_GEN(ndev->mvdev.mdev, log_max_rqt_size));
> -	if (max_rqt < 1)
> -		return -EOPNOTSUPP;
> -
> -	inlen = MLX5_ST_SZ_BYTES(create_rqt_in) + max_rqt * MLX5_ST_SZ_BYTES(rq_num);
> +	inlen = MLX5_ST_SZ_BYTES(create_rqt_in) + ndev->rqt_size * MLX5_ST_SZ_BYTES(rq_num);
>  	in = kzalloc(inlen, GFP_KERNEL);
>  	if (!in)
>  		return -ENOMEM;
> @@ -1263,12 +1247,12 @@ static int create_rqt(struct mlx5_vdpa_net *ndev)
>  	rqtc = MLX5_ADDR_OF(create_rqt_in, in, rqt_context);
>  
>  	MLX5_SET(rqtc, rqtc, list_q_type, MLX5_RQTC_LIST_Q_TYPE_VIRTIO_NET_Q);
> -	MLX5_SET(rqtc, rqtc, rqt_max_size, max_rqt);
> +	MLX5_SET(rqtc, rqtc, rqt_max_size, ndev->rqt_size);
>  	list = MLX5_ADDR_OF(rqtc, rqtc, rq_num[0]);
> -	for (i = 0, j = 0; i < max_rqt; i++, j += 2)
> -		list[i] = cpu_to_be32(ndev->vqs[j % (2 * num)].virtq_id);
> +	for (i = 0, j = 0; i < ndev->rqt_size; i++, j += 2)
> +		list[i] = cpu_to_be32(ndev->vqs[j % ndev->cur_num_vqs].virtq_id);
>  
> -	MLX5_SET(rqtc, rqtc, rqt_actual_size, max_rqt);
> +	MLX5_SET(rqtc, rqtc, rqt_actual_size, ndev->rqt_size);
>  	err = mlx5_vdpa_create_rqt(&ndev->mvdev, in, inlen, &ndev->res.rqtn);
>  	kfree(in);
>  	if (err)
> @@ -1282,19 +1266,13 @@ static int create_rqt(struct mlx5_vdpa_net *ndev)
>  static int modify_rqt(struct mlx5_vdpa_net *ndev, int num)
>  {
>  	__be32 *list;
> -	int max_rqt;
>  	void *rqtc;
>  	int inlen;
>  	void *in;
>  	int i, j;
>  	int err;
>  
> -	max_rqt = min_t(int, roundup_pow_of_two(ndev->cur_num_vqs / 2),
> -			1 << MLX5_CAP_GEN(ndev->mvdev.mdev, log_max_rqt_size));
> -	if (max_rqt < 1)
> -		return -EOPNOTSUPP;
> -
> -	inlen = MLX5_ST_SZ_BYTES(modify_rqt_in) + max_rqt * MLX5_ST_SZ_BYTES(rq_num);
> +	inlen = MLX5_ST_SZ_BYTES(modify_rqt_in) + ndev->rqt_size * MLX5_ST_SZ_BYTES(rq_num);
>  	in = kzalloc(inlen, GFP_KERNEL);
>  	if (!in)
>  		return -ENOMEM;
> @@ -1305,10 +1283,10 @@ static int modify_rqt(struct mlx5_vdpa_net *ndev, int num)
>  	MLX5_SET(rqtc, rqtc, list_q_type, MLX5_RQTC_LIST_Q_TYPE_VIRTIO_NET_Q);
>  
>  	list = MLX5_ADDR_OF(rqtc, rqtc, rq_num[0]);
> -	for (i = 0, j = 0; i < max_rqt; i++, j += 2)
> +	for (i = 0, j = 0; i < ndev->rqt_size; i++, j += 2)
>  		list[i] = cpu_to_be32(ndev->vqs[j % num].virtq_id);
>  
> -	MLX5_SET(rqtc, rqtc, rqt_actual_size, max_rqt);
> +	MLX5_SET(rqtc, rqtc, rqt_actual_size, ndev->rqt_size);
>  	err = mlx5_vdpa_modify_rqt(&ndev->mvdev, in, inlen, ndev->res.rqtn);
>  	kfree(in);
>  	if (err)
> @@ -1625,7 +1603,7 @@ static virtio_net_ctrl_ack handle_ctrl_mq(struct mlx5_vdpa_dev *mvdev, u8 cmd)
>  
>  		newqps = mlx5vdpa16_to_cpu(mvdev, mq.virtqueue_pairs);
>  		if (newqps < VIRTIO_NET_CTRL_MQ_VQ_PAIRS_MIN ||
> -		    newqps > mlx5_vdpa_max_qps(mvdev->max_vqs))
> +		    newqps > ndev->rqt_size)
>  			break;
>  
>  		if (ndev->cur_num_vqs == 2 * newqps) {
> @@ -1989,7 +1967,7 @@ static int setup_virtqueues(struct mlx5_vdpa_dev *mvdev)
>  	int err;
>  	int i;
>  
> -	for (i = 0; i < 2 * mlx5_vdpa_max_qps(mvdev->max_vqs); i++) {
> +	for (i = 0; i < mvdev->max_vqs; i++) {
>  		err = setup_vq(ndev, &ndev->vqs[i]);
>  		if (err)
>  			goto err_vq;
> @@ -2060,9 +2038,11 @@ static int mlx5_vdpa_set_driver_features(struct vdpa_device *vdev, u64 features)
>  
>  	ndev->mvdev.actual_features = features & ndev->mvdev.mlx_features;
>  	if (ndev->mvdev.actual_features & BIT_ULL(VIRTIO_NET_F_MQ))
> -		ndev->cur_num_vqs = 2 * mlx5vdpa16_to_cpu(mvdev, ndev->config.max_virtqueue_pairs);
> +		ndev->rqt_size = mlx5vdpa16_to_cpu(mvdev, ndev->config.max_virtqueue_pairs);
>  	else
> -		ndev->cur_num_vqs = 2;
> +		ndev->rqt_size = 1;
> +
> +	ndev->cur_num_vqs = 2 * ndev->rqt_size;
>  
>  	update_cvq_info(mvdev);
>  	return err;
> @@ -2529,7 +2509,7 @@ static void init_mvqs(struct mlx5_vdpa_net *ndev)
>  	struct mlx5_vdpa_virtqueue *mvq;
>  	int i;
>  
> -	for (i = 0; i < 2 * mlx5_vdpa_max_qps(ndev->mvdev.max_vqs); ++i) {
> +	for (i = 0; i < ndev->mvdev.max_vqs; ++i) {
>  		mvq = &ndev->vqs[i];
>  		memset(mvq, 0, offsetof(struct mlx5_vdpa_virtqueue, ri));
>  		mvq->index = i;
> @@ -2671,7 +2651,8 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
>  		return -EOPNOTSUPP;
>  	}
>  
> -	max_vqs = MLX5_CAP_DEV_VDPA_EMULATION(mdev, max_num_virtio_queues);
> +	max_vqs = min_t(int, MLX5_CAP_DEV_VDPA_EMULATION(mdev, max_num_virtio_queues),
> +			1 << MLX5_CAP_GEN(mdev, log_max_rqt_size));
>  	if (max_vqs < 2) {
>  		dev_warn(mdev->device,
>  			 "%d virtqueues are supported. At least 2 are required\n",
> @@ -2742,7 +2723,7 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
>  		ndev->mvdev.mlx_features |= BIT_ULL(VIRTIO_NET_F_MAC);
>  	}
>  
> -	config->max_virtqueue_pairs = cpu_to_mlx5vdpa16(mvdev, mlx5_vdpa_max_qps(max_vqs));
> +	config->max_virtqueue_pairs = cpu_to_mlx5vdpa16(mvdev, max_vqs / 2);
>  	mvdev->vdev.dma_dev = &mdev->pdev->dev;
>  	err = mlx5_vdpa_alloc_resources(&ndev->mvdev);
>  	if (err)
> @@ -2769,7 +2750,7 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
>  	ndev->nb.notifier_call = event_handler;
>  	mlx5_notifier_register(mdev, &ndev->nb);
>  	mvdev->vdev.mdev = &mgtdev->mgtdev;
> -	err = _vdpa_register_device(&mvdev->vdev, 2 * mlx5_vdpa_max_qps(max_vqs) + 1);
> +	err = _vdpa_register_device(&mvdev->vdev, max_vqs + 1);
>  	if (err)
>  		goto err_reg;
>  
> -- 
> 2.35.1

