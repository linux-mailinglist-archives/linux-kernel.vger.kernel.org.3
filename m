Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8D10527F8E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 10:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241632AbiEPIWz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 04:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232004AbiEPIWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 04:22:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D17E5DFFF
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 01:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652689369;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WNvDsFdKXXxNUzS9xa6p0OG+HdvP+Qe9tir/WG8T4Zw=;
        b=b+i//+D63x/YH7ATPT3MObEphfXNJeCxze1+2pkMcfAIiG5VbHAlNPeuxKRkBBuSSa0B6m
        zaH4S/bZ7u+vI3boDTob8F/j5w81WS29u+lgs2rbi1/xPfISWPGFnoeTOZXhYIE7HPczsQ
        SceREEfubgxnmih2mdjNFpMo5UZRr6s=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-348-xO_UNQ7HOJ2WMjMFY6jptQ-1; Mon, 16 May 2022 04:22:48 -0400
X-MC-Unique: xO_UNQ7HOJ2WMjMFY6jptQ-1
Received: by mail-wm1-f72.google.com with SMTP id e9-20020a05600c4e4900b00394779649b1so9998737wmq.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 01:22:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WNvDsFdKXXxNUzS9xa6p0OG+HdvP+Qe9tir/WG8T4Zw=;
        b=LfBaxDtWEKG4c8Laa4REhEQqUgk8ZUXk1yY8W/+xL5UjbbDnvNc5J8+L41mr++VgTw
         UnrX3mVTDsrRzda+hnYhVFWtpWTGd5uEsL9Nf6GiC6HYuNFghWF/k7T3fI/W5YKasGPC
         ge4YkppTJ7RgNsam9QjkLPt51r8g/MJclT9dhgjE84VDwrFXY5ycQXu/FKJlvTHniht+
         mI62EsWn/7tFcvulM9iYIR60NnfHxV/eTLSMs8OFdBvjVbtUOibVAQ0WTzPnSuhRdcHu
         yXsZeJViiqJgX+WfIIAfpNfHLxoW20An9gWJZr5BBuLUSQbaDsrdw9cj+z4Y68Cuns83
         3HBw==
X-Gm-Message-State: AOAM532iWGN+GUDLkwIUFxfCTg+7yUhoCdEPwaTEHnt+VTsEAo8v/vFK
        /fymzK9r7GyfCfEHGlFOiLB+WpdP7hslKBZ+0W6kEpUZNWlrDmkUSJbGl/iTn8EM0YgmuxPVEiy
        7tchKF89bSpuio5Iihs1bU2V8
X-Received: by 2002:a1c:4456:0:b0:395:b9bf:57 with SMTP id r83-20020a1c4456000000b00395b9bf0057mr23439428wma.21.1652689367025;
        Mon, 16 May 2022 01:22:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxejjGYUhnUK8sEqz50naB0K9MbMknqjB3nHtA62/D77/KpoFScxr6uUPVS4u9zWeA/TaNNSA==
X-Received: by 2002:a1c:4456:0:b0:395:b9bf:57 with SMTP id r83-20020a1c4456000000b00395b9bf0057mr23439416wma.21.1652689366805;
        Mon, 16 May 2022 01:22:46 -0700 (PDT)
Received: from redhat.com ([2.55.141.66])
        by smtp.gmail.com with ESMTPSA id o20-20020a1c4d14000000b0039453fe55a7sm12550284wmh.35.2022.05.16.01.22.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 01:22:46 -0700 (PDT)
Date:   Mon, 16 May 2022 04:22:43 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Eli Cohen <elic@nvidia.com>
Cc:     "jasowang@redhat.com" <jasowang@redhat.com>,
        Cindy Lu <lulu@redhat.com>,
        "hdanton@sina.com" <hdanton@sina.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RESEND V3 3/3] vdpa/mlx5: Use consistent RQT size
Message-ID: <20220516041917-mutt-send-email-mst@kernel.org>
References: <20220406085325.87644-1-elic@nvidia.com>
 <DM8PR12MB5400507B1DA407DEC2E72195ABCF9@DM8PR12MB5400.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM8PR12MB5400507B1DA407DEC2E72195ABCF9@DM8PR12MB5400.namprd12.prod.outlook.com>
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 16, 2022 at 08:17:18AM +0000, Eli Cohen wrote:
> Hi Michael,
> 
> When are you going to pull this fix?
> It fixes a real problem and was reviewed and acked.

Do I understand it correctly that this is a stand-alone patch?
Sorry, my process have been thrown off by it being labeled 3/3 but not
being part of a thread. Do not do this for single patches please.
And I suspect 0-day machinery didn't process it either.
Can you repost as a stand-along patch please?
I will then process ASAP.

Thanks!

> > -----Original Message-----
> > From: Eli Cohen <elic@nvidia.com>
> > Sent: Wednesday, April 6, 2022 11:53 AM
> > To: mst@redhat.com; jasowang@redhat.com
> > Cc: hdanton@sina.com; virtualization@lists.linux-foundation.org; linux-kernel@vger.kernel.org; Eli Cohen <elic@nvidia.com>
> > Subject: [PATCH RESEND V3 3/3] vdpa/mlx5: Use consistent RQT size
> > 
> > The current code evaluates RQT size based on the configured number of
> > virtqueues. This can raise an issue in the following scenario:
> > 
> > Assume MQ was negotiated.
> > 1. mlx5_vdpa_set_map() gets called.
> > 2. handle_ctrl_mq() is called setting cur_num_vqs to some value, lower
> >    than the configured max VQs.
> > 3. A second set_map gets called, but now a smaller number of VQs is used
> >    to evaluate the size of the RQT.
> > 4. handle_ctrl_mq() is called with a value larger than what the RQT can
> >    hold. This will emit errors and the driver state is compromised.
> > 
> > To fix this, we use a new field in struct mlx5_vdpa_net to hold the
> > required number of entries in the RQT. This value is evaluated in
> > mlx5_vdpa_set_driver_features() where we have the negotiated features
> > all set up.
> > 
> > In addition to that, we take into consideration the max capability of RQT
> > entries early when the device is added so we don't need to take consider
> > it when creating the RQT.
> > 
> > Last, we remove the use of mlx5_vdpa_max_qps() which just returns the
> > max_vas / 2 and make the code clearer.
> > 
> > Fixes: 52893733f2c5 ("vdpa/mlx5: Add multiqueue support")
> > Acked-by: Jason Wang <jasowang@redhat.com>
> > Signed-off-by: Eli Cohen <elic@nvidia.com>
> > ---
> > V2 -> V3:
> > Fix typo in change log
> > Add acked-by Jason
> > 
> >  drivers/vdpa/mlx5/net/mlx5_vnet.c | 61 +++++++++++--------------------
> >  1 file changed, 21 insertions(+), 40 deletions(-)
> > 
> > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > index 79001301b383..e0de44000d92 100644
> > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > @@ -161,6 +161,7 @@ struct mlx5_vdpa_net {
> >  	struct mlx5_flow_handle *rx_rule_mcast;
> >  	bool setup;
> >  	u32 cur_num_vqs;
> > +	u32 rqt_size;
> >  	struct notifier_block nb;
> >  	struct vdpa_callback config_cb;
> >  	struct mlx5_vdpa_wq_ent cvq_ent;
> > @@ -204,17 +205,12 @@ static __virtio16 cpu_to_mlx5vdpa16(struct mlx5_vdpa_dev *mvdev, u16 val)
> >  	return __cpu_to_virtio16(mlx5_vdpa_is_little_endian(mvdev), val);
> >  }
> > 
> > -static inline u32 mlx5_vdpa_max_qps(int max_vqs)
> > -{
> > -	return max_vqs / 2;
> > -}
> > -
> >  static u16 ctrl_vq_idx(struct mlx5_vdpa_dev *mvdev)
> >  {
> >  	if (!(mvdev->actual_features & BIT_ULL(VIRTIO_NET_F_MQ)))
> >  		return 2;
> > 
> > -	return 2 * mlx5_vdpa_max_qps(mvdev->max_vqs);
> > +	return mvdev->max_vqs;
> >  }
> > 
> >  static bool is_ctrl_vq_idx(struct mlx5_vdpa_dev *mvdev, u16 idx)
> > @@ -1236,25 +1232,13 @@ static void teardown_vq(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *
> >  static int create_rqt(struct mlx5_vdpa_net *ndev)
> >  {
> >  	__be32 *list;
> > -	int max_rqt;
> >  	void *rqtc;
> >  	int inlen;
> >  	void *in;
> >  	int i, j;
> >  	int err;
> > -	int num;
> > -
> > -	if (!(ndev->mvdev.actual_features & BIT_ULL(VIRTIO_NET_F_MQ)))
> > -		num = 1;
> > -	else
> > -		num = ndev->cur_num_vqs / 2;
> > 
> > -	max_rqt = min_t(int, roundup_pow_of_two(num),
> > -			1 << MLX5_CAP_GEN(ndev->mvdev.mdev, log_max_rqt_size));
> > -	if (max_rqt < 1)
> > -		return -EOPNOTSUPP;
> > -
> > -	inlen = MLX5_ST_SZ_BYTES(create_rqt_in) + max_rqt * MLX5_ST_SZ_BYTES(rq_num);
> > +	inlen = MLX5_ST_SZ_BYTES(create_rqt_in) + ndev->rqt_size * MLX5_ST_SZ_BYTES(rq_num);
> >  	in = kzalloc(inlen, GFP_KERNEL);
> >  	if (!in)
> >  		return -ENOMEM;
> > @@ -1263,12 +1247,12 @@ static int create_rqt(struct mlx5_vdpa_net *ndev)
> >  	rqtc = MLX5_ADDR_OF(create_rqt_in, in, rqt_context);
> > 
> >  	MLX5_SET(rqtc, rqtc, list_q_type, MLX5_RQTC_LIST_Q_TYPE_VIRTIO_NET_Q);
> > -	MLX5_SET(rqtc, rqtc, rqt_max_size, max_rqt);
> > +	MLX5_SET(rqtc, rqtc, rqt_max_size, ndev->rqt_size);
> >  	list = MLX5_ADDR_OF(rqtc, rqtc, rq_num[0]);
> > -	for (i = 0, j = 0; i < max_rqt; i++, j += 2)
> > -		list[i] = cpu_to_be32(ndev->vqs[j % (2 * num)].virtq_id);
> > +	for (i = 0, j = 0; i < ndev->rqt_size; i++, j += 2)
> > +		list[i] = cpu_to_be32(ndev->vqs[j % ndev->cur_num_vqs].virtq_id);
> > 
> > -	MLX5_SET(rqtc, rqtc, rqt_actual_size, max_rqt);
> > +	MLX5_SET(rqtc, rqtc, rqt_actual_size, ndev->rqt_size);
> >  	err = mlx5_vdpa_create_rqt(&ndev->mvdev, in, inlen, &ndev->res.rqtn);
> >  	kfree(in);
> >  	if (err)
> > @@ -1282,19 +1266,13 @@ static int create_rqt(struct mlx5_vdpa_net *ndev)
> >  static int modify_rqt(struct mlx5_vdpa_net *ndev, int num)
> >  {
> >  	__be32 *list;
> > -	int max_rqt;
> >  	void *rqtc;
> >  	int inlen;
> >  	void *in;
> >  	int i, j;
> >  	int err;
> > 
> > -	max_rqt = min_t(int, roundup_pow_of_two(ndev->cur_num_vqs / 2),
> > -			1 << MLX5_CAP_GEN(ndev->mvdev.mdev, log_max_rqt_size));
> > -	if (max_rqt < 1)
> > -		return -EOPNOTSUPP;
> > -
> > -	inlen = MLX5_ST_SZ_BYTES(modify_rqt_in) + max_rqt * MLX5_ST_SZ_BYTES(rq_num);
> > +	inlen = MLX5_ST_SZ_BYTES(modify_rqt_in) + ndev->rqt_size * MLX5_ST_SZ_BYTES(rq_num);
> >  	in = kzalloc(inlen, GFP_KERNEL);
> >  	if (!in)
> >  		return -ENOMEM;
> > @@ -1305,10 +1283,10 @@ static int modify_rqt(struct mlx5_vdpa_net *ndev, int num)
> >  	MLX5_SET(rqtc, rqtc, list_q_type, MLX5_RQTC_LIST_Q_TYPE_VIRTIO_NET_Q);
> > 
> >  	list = MLX5_ADDR_OF(rqtc, rqtc, rq_num[0]);
> > -	for (i = 0, j = 0; i < max_rqt; i++, j += 2)
> > +	for (i = 0, j = 0; i < ndev->rqt_size; i++, j += 2)
> >  		list[i] = cpu_to_be32(ndev->vqs[j % num].virtq_id);
> > 
> > -	MLX5_SET(rqtc, rqtc, rqt_actual_size, max_rqt);
> > +	MLX5_SET(rqtc, rqtc, rqt_actual_size, ndev->rqt_size);
> >  	err = mlx5_vdpa_modify_rqt(&ndev->mvdev, in, inlen, ndev->res.rqtn);
> >  	kfree(in);
> >  	if (err)
> > @@ -1625,7 +1603,7 @@ static virtio_net_ctrl_ack handle_ctrl_mq(struct mlx5_vdpa_dev *mvdev, u8 cmd)
> > 
> >  		newqps = mlx5vdpa16_to_cpu(mvdev, mq.virtqueue_pairs);
> >  		if (newqps < VIRTIO_NET_CTRL_MQ_VQ_PAIRS_MIN ||
> > -		    newqps > mlx5_vdpa_max_qps(mvdev->max_vqs))
> > +		    newqps > ndev->rqt_size)
> >  			break;
> > 
> >  		if (ndev->cur_num_vqs == 2 * newqps) {
> > @@ -1989,7 +1967,7 @@ static int setup_virtqueues(struct mlx5_vdpa_dev *mvdev)
> >  	int err;
> >  	int i;
> > 
> > -	for (i = 0; i < 2 * mlx5_vdpa_max_qps(mvdev->max_vqs); i++) {
> > +	for (i = 0; i < mvdev->max_vqs; i++) {
> >  		err = setup_vq(ndev, &ndev->vqs[i]);
> >  		if (err)
> >  			goto err_vq;
> > @@ -2060,9 +2038,11 @@ static int mlx5_vdpa_set_driver_features(struct vdpa_device *vdev, u64 features)
> > 
> >  	ndev->mvdev.actual_features = features & ndev->mvdev.mlx_features;
> >  	if (ndev->mvdev.actual_features & BIT_ULL(VIRTIO_NET_F_MQ))
> > -		ndev->cur_num_vqs = 2 * mlx5vdpa16_to_cpu(mvdev, ndev->config.max_virtqueue_pairs);
> > +		ndev->rqt_size = mlx5vdpa16_to_cpu(mvdev, ndev->config.max_virtqueue_pairs);
> >  	else
> > -		ndev->cur_num_vqs = 2;
> > +		ndev->rqt_size = 1;
> > +
> > +	ndev->cur_num_vqs = 2 * ndev->rqt_size;
> > 
> >  	update_cvq_info(mvdev);
> >  	return err;
> > @@ -2529,7 +2509,7 @@ static void init_mvqs(struct mlx5_vdpa_net *ndev)
> >  	struct mlx5_vdpa_virtqueue *mvq;
> >  	int i;
> > 
> > -	for (i = 0; i < 2 * mlx5_vdpa_max_qps(ndev->mvdev.max_vqs); ++i) {
> > +	for (i = 0; i < ndev->mvdev.max_vqs; ++i) {
> >  		mvq = &ndev->vqs[i];
> >  		memset(mvq, 0, offsetof(struct mlx5_vdpa_virtqueue, ri));
> >  		mvq->index = i;
> > @@ -2671,7 +2651,8 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
> >  		return -EOPNOTSUPP;
> >  	}
> > 
> > -	max_vqs = MLX5_CAP_DEV_VDPA_EMULATION(mdev, max_num_virtio_queues);
> > +	max_vqs = min_t(int, MLX5_CAP_DEV_VDPA_EMULATION(mdev, max_num_virtio_queues),
> > +			1 << MLX5_CAP_GEN(mdev, log_max_rqt_size));
> >  	if (max_vqs < 2) {
> >  		dev_warn(mdev->device,
> >  			 "%d virtqueues are supported. At least 2 are required\n",
> > @@ -2742,7 +2723,7 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
> >  		ndev->mvdev.mlx_features |= BIT_ULL(VIRTIO_NET_F_MAC);
> >  	}
> > 
> > -	config->max_virtqueue_pairs = cpu_to_mlx5vdpa16(mvdev, mlx5_vdpa_max_qps(max_vqs));
> > +	config->max_virtqueue_pairs = cpu_to_mlx5vdpa16(mvdev, max_vqs / 2);
> >  	mvdev->vdev.dma_dev = &mdev->pdev->dev;
> >  	err = mlx5_vdpa_alloc_resources(&ndev->mvdev);
> >  	if (err)
> > @@ -2769,7 +2750,7 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
> >  	ndev->nb.notifier_call = event_handler;
> >  	mlx5_notifier_register(mdev, &ndev->nb);
> >  	mvdev->vdev.mdev = &mgtdev->mgtdev;
> > -	err = _vdpa_register_device(&mvdev->vdev, 2 * mlx5_vdpa_max_qps(max_vqs) + 1);
> > +	err = _vdpa_register_device(&mvdev->vdev, max_vqs + 1);
> >  	if (err)
> >  		goto err_reg;
> > 
> > --
> > 2.35.1

