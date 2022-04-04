Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 927804F13CA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 13:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359458AbiDDL1B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 07:27:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235756AbiDDL1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 07:27:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 696D1DEBA
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 04:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649071501;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=//CSXz7hUOIWrf6/ycTr7Ncaj0vrA6tGp2qTqHKf12w=;
        b=Yi/x8jrT5QaZ2c6jEBXh2i3a1lJMlCeJUJnFI3j9s+JL/1RzYM0zCEhW+gcoao5+gEwhsL
        D9bNbxaDItHgJoqnsxcR+moSoWk6HCFIxhm+LAt6VKk6iYamZiAiS+D8/nFROze6bM2xwN
        uW3POdgOW3Ugn6GWKFsvJn/ZfTP0o4Q=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-312-sNPzyRMOMzabeNkVHCzeww-1; Mon, 04 Apr 2022 07:24:58 -0400
X-MC-Unique: sNPzyRMOMzabeNkVHCzeww-1
Received: by mail-wm1-f69.google.com with SMTP id 189-20020a1c02c6000000b0038e6c4c6472so2600064wmc.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 04:24:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=//CSXz7hUOIWrf6/ycTr7Ncaj0vrA6tGp2qTqHKf12w=;
        b=UggXe6QWfp5Z2ZYmApSnfpOtfavgYiFTULGDBjbioE+hZx+loIjoXfw2omrhMASShi
         kdH69yeaaah1bSjPHXJKL8r/EdRFe5qTUc2DmXyAqzmMQ18k2CsBxuCYF20C/zV6nSr1
         CRfGYAmsPKuHFQ2XDZDqTMTCO2oE9xtu36v0X9MFM5iXwM7R7ouJlkGIG06oTQvrmzO+
         z9zrUBPnrr+bB7CNBDyoijjV8LqHVes1ppzlFg0Ryl/CMlL8xz9ZNLZqMQkKQrkQHl+G
         b2aEQolWmtrXj/crk8vhkTKy75ernHqeLH7clnJRzCI6EMRlkm4qZGBH6ul5BbrSQGnA
         s+mw==
X-Gm-Message-State: AOAM533+RTXVC1uP++a1K5iWnqKOsz7v5DWwY50bawgnrO9fwASWqQMg
        7/qKELVrmni/cfEKiVdvFtr7TKiSTI+VY5lTGnFnIQaYdtj8GRp+muRFloNMmapTJbEEK5+ZO4M
        Ao8twcey8VOiKMaAtAkx8uz/e
X-Received: by 2002:a05:600c:4f08:b0:38c:93fd:570f with SMTP id l8-20020a05600c4f0800b0038c93fd570fmr18763349wmq.136.1649071497328;
        Mon, 04 Apr 2022 04:24:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzIj/BYiQDXfsY93PtQi5oo8xne8HserMZoyfzyo0cU8IspuqiM2bgziQEn1gf4dV9wXcesag==
X-Received: by 2002:a05:600c:4f08:b0:38c:93fd:570f with SMTP id l8-20020a05600c4f0800b0038c93fd570fmr18763329wmq.136.1649071497071;
        Mon, 04 Apr 2022 04:24:57 -0700 (PDT)
Received: from redhat.com ([2.54.40.213])
        by smtp.gmail.com with ESMTPSA id bg20-20020a05600c3c9400b0037fa5c422c8sm17833389wmb.48.2022.04.04.04.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 04:24:56 -0700 (PDT)
Date:   Mon, 4 Apr 2022 07:24:52 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Eli Cohen <elic@nvidia.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        "hdanton@sina.com" <hdanton@sina.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RESEND V2 3/3] vdpa/mlx5: Use consistent RQT size
Message-ID: <20220404072402-mutt-send-email-mst@kernel.org>
References: <20220329042109.4029-1-jasowang@redhat.com>
 <20220329042109.4029-3-jasowang@redhat.com>
 <20220404063241-mutt-send-email-mst@kernel.org>
 <DM8PR12MB5400ED1195FE612BBC67CB62ABE59@DM8PR12MB5400.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM8PR12MB5400ED1195FE612BBC67CB62ABE59@DM8PR12MB5400.namprd12.prod.outlook.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 04, 2022 at 11:07:36AM +0000, Eli Cohen wrote:
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Monday, April 4, 2022 1:35 PM
> > To: Jason Wang <jasowang@redhat.com>
> > Cc: Eli Cohen <elic@nvidia.com>; hdanton@sina.com; virtualization@lists.linux-foundation.org; linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH RESEND V2 3/3] vdpa/mlx5: Use consistent RQT size
> > 
> > On Tue, Mar 29, 2022 at 12:21:09PM +0800, Jason Wang wrote:
> > > From: Eli Cohen <elic@nvidia.com>
> > >
> > > The current code evaluates RQT size based on the configured number of
> > > virtqueues. This can raise an issue in the following scenario:
> > >
> > > Assume MQ was negotiated.
> > > 1. mlx5_vdpa_set_map() gets called.
> > > 2. handle_ctrl_mq() is called setting cur_num_vqs to some value, lower
> > >    than the configured max VQs.
> > > 3. A second set_map gets called, but now a smaller number of VQs is used
> > >    to evaluate the size of the RQT.
> > > 4. handle_ctrl_mq() is called with a value larger than what the RQT can
> > >    hold. This will emit errors and the driver state is compromised.
> > >
> > > To fix this, we use a new field in struct mlx5_vdpa_net to hold the
> > > required number of entries in the RQT. This value is evaluated in
> > > mlx5_vdpa_set_driver_features() where we have the negotiated features
> > > all set up.
> > >
> > > In addtion
> > 
> > addition?
> 
> Do you need me to send another version?

It's a bit easier that way but I can handle it manually too.

> If so, let's wait for Jason's reply.

Right.

> > 
> > > to that, we take into consideration the max capability of RQT
> > > entries early when the device is added so we don't need to take consider
> > > it when creating the RQT.
> > >
> > > Last, we remove the use of mlx5_vdpa_max_qps() which just returns the
> > > max_vas / 2 and make the code clearer.
> > >
> > > Fixes: 52893733f2c5 ("vdpa/mlx5: Add multiqueue support")
> > > Signed-off-by: Eli Cohen <elic@nvidia.com>
> > 
> > Jason I don't have your ack or S.O.B on this one.
> > 
> > 
> > > ---
> > >  drivers/vdpa/mlx5/net/mlx5_vnet.c | 61 +++++++++++--------------------
> > >  1 file changed, 21 insertions(+), 40 deletions(-)
> > >
> > > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > index 53b8c1a68f90..61bec1ed0bc9 100644
> > > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > @@ -161,6 +161,7 @@ struct mlx5_vdpa_net {
> > >  	struct mlx5_flow_handle *rx_rule_mcast;
> > >  	bool setup;
> > >  	u32 cur_num_vqs;
> > > +	u32 rqt_size;
> > >  	struct notifier_block nb;
> > >  	struct vdpa_callback config_cb;
> > >  	struct mlx5_vdpa_wq_ent cvq_ent;
> > > @@ -204,17 +205,12 @@ static __virtio16 cpu_to_mlx5vdpa16(struct mlx5_vdpa_dev *mvdev, u16 val)
> > >  	return __cpu_to_virtio16(mlx5_vdpa_is_little_endian(mvdev), val);
> > >  }
> > >
> > > -static inline u32 mlx5_vdpa_max_qps(int max_vqs)
> > > -{
> > > -	return max_vqs / 2;
> > > -}
> > > -
> > >  static u16 ctrl_vq_idx(struct mlx5_vdpa_dev *mvdev)
> > >  {
> > >  	if (!(mvdev->actual_features & BIT_ULL(VIRTIO_NET_F_MQ)))
> > >  		return 2;
> > >
> > > -	return 2 * mlx5_vdpa_max_qps(mvdev->max_vqs);
> > > +	return mvdev->max_vqs;
> > >  }
> > >
> > >  static bool is_ctrl_vq_idx(struct mlx5_vdpa_dev *mvdev, u16 idx)
> > > @@ -1236,25 +1232,13 @@ static void teardown_vq(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *
> > >  static int create_rqt(struct mlx5_vdpa_net *ndev)
> > >  {
> > >  	__be32 *list;
> > > -	int max_rqt;
> > >  	void *rqtc;
> > >  	int inlen;
> > >  	void *in;
> > >  	int i, j;
> > >  	int err;
> > > -	int num;
> > > -
> > > -	if (!(ndev->mvdev.actual_features & BIT_ULL(VIRTIO_NET_F_MQ)))
> > > -		num = 1;
> > > -	else
> > > -		num = ndev->cur_num_vqs / 2;
> > >
> > > -	max_rqt = min_t(int, roundup_pow_of_two(num),
> > > -			1 << MLX5_CAP_GEN(ndev->mvdev.mdev, log_max_rqt_size));
> > > -	if (max_rqt < 1)
> > > -		return -EOPNOTSUPP;
> > > -
> > > -	inlen = MLX5_ST_SZ_BYTES(create_rqt_in) + max_rqt * MLX5_ST_SZ_BYTES(rq_num);
> > > +	inlen = MLX5_ST_SZ_BYTES(create_rqt_in) + ndev->rqt_size * MLX5_ST_SZ_BYTES(rq_num);
> > >  	in = kzalloc(inlen, GFP_KERNEL);
> > >  	if (!in)
> > >  		return -ENOMEM;
> > > @@ -1263,12 +1247,12 @@ static int create_rqt(struct mlx5_vdpa_net *ndev)
> > >  	rqtc = MLX5_ADDR_OF(create_rqt_in, in, rqt_context);
> > >
> > >  	MLX5_SET(rqtc, rqtc, list_q_type, MLX5_RQTC_LIST_Q_TYPE_VIRTIO_NET_Q);
> > > -	MLX5_SET(rqtc, rqtc, rqt_max_size, max_rqt);
> > > +	MLX5_SET(rqtc, rqtc, rqt_max_size, ndev->rqt_size);
> > >  	list = MLX5_ADDR_OF(rqtc, rqtc, rq_num[0]);
> > > -	for (i = 0, j = 0; i < max_rqt; i++, j += 2)
> > > -		list[i] = cpu_to_be32(ndev->vqs[j % (2 * num)].virtq_id);
> > > +	for (i = 0, j = 0; i < ndev->rqt_size; i++, j += 2)
> > > +		list[i] = cpu_to_be32(ndev->vqs[j % ndev->cur_num_vqs].virtq_id);
> > >
> > > -	MLX5_SET(rqtc, rqtc, rqt_actual_size, max_rqt);
> > > +	MLX5_SET(rqtc, rqtc, rqt_actual_size, ndev->rqt_size);
> > >  	err = mlx5_vdpa_create_rqt(&ndev->mvdev, in, inlen, &ndev->res.rqtn);
> > >  	kfree(in);
> > >  	if (err)
> > > @@ -1282,19 +1266,13 @@ static int create_rqt(struct mlx5_vdpa_net *ndev)
> > >  static int modify_rqt(struct mlx5_vdpa_net *ndev, int num)
> > >  {
> > >  	__be32 *list;
> > > -	int max_rqt;
> > >  	void *rqtc;
> > >  	int inlen;
> > >  	void *in;
> > >  	int i, j;
> > >  	int err;
> > >
> > > -	max_rqt = min_t(int, roundup_pow_of_two(ndev->cur_num_vqs / 2),
> > > -			1 << MLX5_CAP_GEN(ndev->mvdev.mdev, log_max_rqt_size));
> > > -	if (max_rqt < 1)
> > > -		return -EOPNOTSUPP;
> > > -
> > > -	inlen = MLX5_ST_SZ_BYTES(modify_rqt_in) + max_rqt * MLX5_ST_SZ_BYTES(rq_num);
> > > +	inlen = MLX5_ST_SZ_BYTES(modify_rqt_in) + ndev->rqt_size * MLX5_ST_SZ_BYTES(rq_num);
> > >  	in = kzalloc(inlen, GFP_KERNEL);
> > >  	if (!in)
> > >  		return -ENOMEM;
> > > @@ -1305,10 +1283,10 @@ static int modify_rqt(struct mlx5_vdpa_net *ndev, int num)
> > >  	MLX5_SET(rqtc, rqtc, list_q_type, MLX5_RQTC_LIST_Q_TYPE_VIRTIO_NET_Q);
> > >
> > >  	list = MLX5_ADDR_OF(rqtc, rqtc, rq_num[0]);
> > > -	for (i = 0, j = 0; i < max_rqt; i++, j += 2)
> > > +	for (i = 0, j = 0; i < ndev->rqt_size; i++, j += 2)
> > >  		list[i] = cpu_to_be32(ndev->vqs[j % num].virtq_id);
> > >
> > > -	MLX5_SET(rqtc, rqtc, rqt_actual_size, max_rqt);
> > > +	MLX5_SET(rqtc, rqtc, rqt_actual_size, ndev->rqt_size);
> > >  	err = mlx5_vdpa_modify_rqt(&ndev->mvdev, in, inlen, ndev->res.rqtn);
> > >  	kfree(in);
> > >  	if (err)
> > > @@ -1582,7 +1560,7 @@ static virtio_net_ctrl_ack handle_ctrl_mq(struct mlx5_vdpa_dev *mvdev, u8 cmd)
> > >
> > >  		newqps = mlx5vdpa16_to_cpu(mvdev, mq.virtqueue_pairs);
> > >  		if (newqps < VIRTIO_NET_CTRL_MQ_VQ_PAIRS_MIN ||
> > > -		    newqps > mlx5_vdpa_max_qps(mvdev->max_vqs))
> > > +		    newqps > ndev->rqt_size)
> > >  			break;
> > >
> > >  		if (ndev->cur_num_vqs == 2 * newqps) {
> > > @@ -1946,7 +1924,7 @@ static int setup_virtqueues(struct mlx5_vdpa_dev *mvdev)
> > >  	int err;
> > >  	int i;
> > >
> > > -	for (i = 0; i < 2 * mlx5_vdpa_max_qps(mvdev->max_vqs); i++) {
> > > +	for (i = 0; i < mvdev->max_vqs; i++) {
> > >  		err = setup_vq(ndev, &ndev->vqs[i]);
> > >  		if (err)
> > >  			goto err_vq;
> > > @@ -2017,9 +1995,11 @@ static int mlx5_vdpa_set_driver_features(struct vdpa_device *vdev, u64 features)
> > >
> > >  	ndev->mvdev.actual_features = features & ndev->mvdev.mlx_features;
> > >  	if (ndev->mvdev.actual_features & BIT_ULL(VIRTIO_NET_F_MQ))
> > > -		ndev->cur_num_vqs = 2 * mlx5vdpa16_to_cpu(mvdev, ndev->config.max_virtqueue_pairs);
> > > +		ndev->rqt_size = mlx5vdpa16_to_cpu(mvdev, ndev->config.max_virtqueue_pairs);
> > >  	else
> > > -		ndev->cur_num_vqs = 2;
> > > +		ndev->rqt_size = 1;
> > > +
> > > +	ndev->cur_num_vqs = 2 * ndev->rqt_size;
> > >
> > >  	update_cvq_info(mvdev);
> > >  	return err;
> > > @@ -2486,7 +2466,7 @@ static void init_mvqs(struct mlx5_vdpa_net *ndev)
> > >  	struct mlx5_vdpa_virtqueue *mvq;
> > >  	int i;
> > >
> > > -	for (i = 0; i < 2 * mlx5_vdpa_max_qps(ndev->mvdev.max_vqs); ++i) {
> > > +	for (i = 0; i < ndev->mvdev.max_vqs; ++i) {
> > >  		mvq = &ndev->vqs[i];
> > >  		memset(mvq, 0, offsetof(struct mlx5_vdpa_virtqueue, ri));
> > >  		mvq->index = i;
> > > @@ -2606,7 +2586,8 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
> > >  		return -EOPNOTSUPP;
> > >  	}
> > >
> > > -	max_vqs = MLX5_CAP_DEV_VDPA_EMULATION(mdev, max_num_virtio_queues);
> > > +	max_vqs = min_t(int, MLX5_CAP_DEV_VDPA_EMULATION(mdev, max_num_virtio_queues),
> > > +			1 << MLX5_CAP_GEN(mdev, log_max_rqt_size));
> > >  	if (max_vqs < 2) {
> > >  		dev_warn(mdev->device,
> > >  			 "%d virtqueues are supported. At least 2 are required\n",
> > > @@ -2670,7 +2651,7 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
> > >  		ndev->mvdev.mlx_features |= BIT_ULL(VIRTIO_NET_F_MAC);
> > >  	}
> > >
> > > -	config->max_virtqueue_pairs = cpu_to_mlx5vdpa16(mvdev, mlx5_vdpa_max_qps(max_vqs));
> > > +	config->max_virtqueue_pairs = cpu_to_mlx5vdpa16(mvdev, max_vqs / 2);
> > >  	mvdev->vdev.dma_dev = &mdev->pdev->dev;
> > >  	err = mlx5_vdpa_alloc_resources(&ndev->mvdev);
> > >  	if (err)
> > > @@ -2697,7 +2678,7 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
> > >  	ndev->nb.notifier_call = event_handler;
> > >  	mlx5_notifier_register(mdev, &ndev->nb);
> > >  	mvdev->vdev.mdev = &mgtdev->mgtdev;
> > > -	err = _vdpa_register_device(&mvdev->vdev, 2 * mlx5_vdpa_max_qps(max_vqs) + 1);
> > > +	err = _vdpa_register_device(&mvdev->vdev, max_vqs + 1);
> > >  	if (err)
> > >  		goto err_reg;
> > >
> > > --
> > > 2.18.1

