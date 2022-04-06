Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86DC04F5D29
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 14:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232152AbiDFMIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 08:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232543AbiDFMIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 08:08:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AA39423AFB2
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 19:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649212540;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oJ2HQALH8Cqs9kIKIwV7NoBOcB2CCPCquiTlNVyU38w=;
        b=PufTmWMteILfRDNuPbbBMxR9CLOEyPZX4JlLWzgNoaUUR7efbBmWXNfndv12R42s4FChIJ
        8EWtqnkrcJHjyLLnqqxPL3F1tHDg0V/e38H2qvHItjacJUpjjgWX7ydmS0pxmPbg+upmZl
        xneKHQ33PPVcQ++u66a3fcNV+bkyF7I=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-258-ygralSSvPNyWzJC-7BaOXg-1; Tue, 05 Apr 2022 22:35:39 -0400
X-MC-Unique: ygralSSvPNyWzJC-7BaOXg-1
Received: by mail-pj1-f71.google.com with SMTP id lr15-20020a17090b4b8f00b001c646e432baso2874114pjb.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 19:35:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=oJ2HQALH8Cqs9kIKIwV7NoBOcB2CCPCquiTlNVyU38w=;
        b=iuBJOTxmTok3dAZB0rz7USHMAGkRhoagyVNioAHZ4wm69rjRFXFz2Wfu82CZjs+Xh3
         8Ss1rbXioZPhdIqI0FAbdBksw/QxAEiDCUDPEKfPdnL+LJQZqhn1KD7MnA17v7i0DPxM
         A+4IGzYrUpc1URUB4xtXsk4lVzR325HomYDCEnXAGCq7UiYWn9wnibP9E8C2AZXpe7dd
         zuKIOZ80OzGordCDMjelN9DAS9M9xbVdpm/05Sxh7XyiPs4h078DSD+5TtOu2t0Ko3EV
         ntTKNts6mx7Iv8BvRyNV+TgXHZOnicylvkM2R4/IGi0rSWb/iEbTrSJFPNpxqTdQbWBe
         eK9A==
X-Gm-Message-State: AOAM5332lCZHj6qnP7fCWCkL+sSPgph0z1v8/ImmWE4EljQzSRfY8nDe
        fJOJOMqrd0Nvnj1QCbo02Hwro8NCVJxdWe9MOg0HTA6M/Id458n3BlXikEy9iizRtHAFSOagRL4
        TTuEEeH5lpQ/GhpvY2GfPyiPi
X-Received: by 2002:a17:902:b103:b0:156:c7bb:a852 with SMTP id q3-20020a170902b10300b00156c7bba852mr6350263plr.29.1649212538330;
        Tue, 05 Apr 2022 19:35:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxiLmZXEFw2pEVfpDizPCFvSI79Awv8vp9DRmR25W86HRVozr57ChUVK9ho29fFnhWmzYrnmA==
X-Received: by 2002:a17:902:b103:b0:156:c7bb:a852 with SMTP id q3-20020a170902b10300b00156c7bba852mr6350233plr.29.1649212537989;
        Tue, 05 Apr 2022 19:35:37 -0700 (PDT)
Received: from [10.72.12.58] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id k137-20020a633d8f000000b0039800918b00sm14298680pga.77.2022.04.05.19.35.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Apr 2022 19:35:37 -0700 (PDT)
Message-ID: <b6f21ec6-2374-69de-c21b-8e917dae8f82@redhat.com>
Date:   Wed, 6 Apr 2022 10:35:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH RESEND V2 3/3] vdpa/mlx5: Use consistent RQT size
Content-Language: en-US
To:     "Michael S. Tsirkin" <mst@redhat.com>, Eli Cohen <elic@nvidia.com>
Cc:     "hdanton@sina.com" <hdanton@sina.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220329042109.4029-1-jasowang@redhat.com>
 <20220329042109.4029-3-jasowang@redhat.com>
 <20220404063241-mutt-send-email-mst@kernel.org>
 <DM8PR12MB5400ED1195FE612BBC67CB62ABE59@DM8PR12MB5400.namprd12.prod.outlook.com>
 <20220404072402-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220404072402-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2022/4/4 下午7:24, Michael S. Tsirkin 写道:
> On Mon, Apr 04, 2022 at 11:07:36AM +0000, Eli Cohen wrote:
>>> From: Michael S. Tsirkin <mst@redhat.com>
>>> Sent: Monday, April 4, 2022 1:35 PM
>>> To: Jason Wang <jasowang@redhat.com>
>>> Cc: Eli Cohen <elic@nvidia.com>; hdanton@sina.com; virtualization@lists.linux-foundation.org; linux-kernel@vger.kernel.org
>>> Subject: Re: [PATCH RESEND V2 3/3] vdpa/mlx5: Use consistent RQT size
>>>
>>> On Tue, Mar 29, 2022 at 12:21:09PM +0800, Jason Wang wrote:
>>>> From: Eli Cohen <elic@nvidia.com>
>>>>
>>>> The current code evaluates RQT size based on the configured number of
>>>> virtqueues. This can raise an issue in the following scenario:
>>>>
>>>> Assume MQ was negotiated.
>>>> 1. mlx5_vdpa_set_map() gets called.
>>>> 2. handle_ctrl_mq() is called setting cur_num_vqs to some value, lower
>>>>     than the configured max VQs.
>>>> 3. A second set_map gets called, but now a smaller number of VQs is used
>>>>     to evaluate the size of the RQT.
>>>> 4. handle_ctrl_mq() is called with a value larger than what the RQT can
>>>>     hold. This will emit errors and the driver state is compromised.
>>>>
>>>> To fix this, we use a new field in struct mlx5_vdpa_net to hold the
>>>> required number of entries in the RQT. This value is evaluated in
>>>> mlx5_vdpa_set_driver_features() where we have the negotiated features
>>>> all set up.
>>>>
>>>> In addtion
>>> addition?
>> Do you need me to send another version?
> It's a bit easier that way but I can handle it manually too.


Let me send a new version with this fixed.


>
>> If so, let's wait for Jason's reply.
> Right.
>
>>>> to that, we take into consideration the max capability of RQT
>>>> entries early when the device is added so we don't need to take consider
>>>> it when creating the RQT.
>>>>
>>>> Last, we remove the use of mlx5_vdpa_max_qps() which just returns the
>>>> max_vas / 2 and make the code clearer.
>>>>
>>>> Fixes: 52893733f2c5 ("vdpa/mlx5: Add multiqueue support")
>>>> Signed-off-by: Eli Cohen <elic@nvidia.com>
>>> Jason I don't have your ack or S.O.B on this one.


My bad, for some reason, I miss that.

Will fix.

Thanks


>>>
>>>
>>>> ---
>>>>   drivers/vdpa/mlx5/net/mlx5_vnet.c | 61 +++++++++++--------------------
>>>>   1 file changed, 21 insertions(+), 40 deletions(-)
>>>>
>>>> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
>>>> index 53b8c1a68f90..61bec1ed0bc9 100644
>>>> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
>>>> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
>>>> @@ -161,6 +161,7 @@ struct mlx5_vdpa_net {
>>>>   	struct mlx5_flow_handle *rx_rule_mcast;
>>>>   	bool setup;
>>>>   	u32 cur_num_vqs;
>>>> +	u32 rqt_size;
>>>>   	struct notifier_block nb;
>>>>   	struct vdpa_callback config_cb;
>>>>   	struct mlx5_vdpa_wq_ent cvq_ent;
>>>> @@ -204,17 +205,12 @@ static __virtio16 cpu_to_mlx5vdpa16(struct mlx5_vdpa_dev *mvdev, u16 val)
>>>>   	return __cpu_to_virtio16(mlx5_vdpa_is_little_endian(mvdev), val);
>>>>   }
>>>>
>>>> -static inline u32 mlx5_vdpa_max_qps(int max_vqs)
>>>> -{
>>>> -	return max_vqs / 2;
>>>> -}
>>>> -
>>>>   static u16 ctrl_vq_idx(struct mlx5_vdpa_dev *mvdev)
>>>>   {
>>>>   	if (!(mvdev->actual_features & BIT_ULL(VIRTIO_NET_F_MQ)))
>>>>   		return 2;
>>>>
>>>> -	return 2 * mlx5_vdpa_max_qps(mvdev->max_vqs);
>>>> +	return mvdev->max_vqs;
>>>>   }
>>>>
>>>>   static bool is_ctrl_vq_idx(struct mlx5_vdpa_dev *mvdev, u16 idx)
>>>> @@ -1236,25 +1232,13 @@ static void teardown_vq(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *
>>>>   static int create_rqt(struct mlx5_vdpa_net *ndev)
>>>>   {
>>>>   	__be32 *list;
>>>> -	int max_rqt;
>>>>   	void *rqtc;
>>>>   	int inlen;
>>>>   	void *in;
>>>>   	int i, j;
>>>>   	int err;
>>>> -	int num;
>>>> -
>>>> -	if (!(ndev->mvdev.actual_features & BIT_ULL(VIRTIO_NET_F_MQ)))
>>>> -		num = 1;
>>>> -	else
>>>> -		num = ndev->cur_num_vqs / 2;
>>>>
>>>> -	max_rqt = min_t(int, roundup_pow_of_two(num),
>>>> -			1 << MLX5_CAP_GEN(ndev->mvdev.mdev, log_max_rqt_size));
>>>> -	if (max_rqt < 1)
>>>> -		return -EOPNOTSUPP;
>>>> -
>>>> -	inlen = MLX5_ST_SZ_BYTES(create_rqt_in) + max_rqt * MLX5_ST_SZ_BYTES(rq_num);
>>>> +	inlen = MLX5_ST_SZ_BYTES(create_rqt_in) + ndev->rqt_size * MLX5_ST_SZ_BYTES(rq_num);
>>>>   	in = kzalloc(inlen, GFP_KERNEL);
>>>>   	if (!in)
>>>>   		return -ENOMEM;
>>>> @@ -1263,12 +1247,12 @@ static int create_rqt(struct mlx5_vdpa_net *ndev)
>>>>   	rqtc = MLX5_ADDR_OF(create_rqt_in, in, rqt_context);
>>>>
>>>>   	MLX5_SET(rqtc, rqtc, list_q_type, MLX5_RQTC_LIST_Q_TYPE_VIRTIO_NET_Q);
>>>> -	MLX5_SET(rqtc, rqtc, rqt_max_size, max_rqt);
>>>> +	MLX5_SET(rqtc, rqtc, rqt_max_size, ndev->rqt_size);
>>>>   	list = MLX5_ADDR_OF(rqtc, rqtc, rq_num[0]);
>>>> -	for (i = 0, j = 0; i < max_rqt; i++, j += 2)
>>>> -		list[i] = cpu_to_be32(ndev->vqs[j % (2 * num)].virtq_id);
>>>> +	for (i = 0, j = 0; i < ndev->rqt_size; i++, j += 2)
>>>> +		list[i] = cpu_to_be32(ndev->vqs[j % ndev->cur_num_vqs].virtq_id);
>>>>
>>>> -	MLX5_SET(rqtc, rqtc, rqt_actual_size, max_rqt);
>>>> +	MLX5_SET(rqtc, rqtc, rqt_actual_size, ndev->rqt_size);
>>>>   	err = mlx5_vdpa_create_rqt(&ndev->mvdev, in, inlen, &ndev->res.rqtn);
>>>>   	kfree(in);
>>>>   	if (err)
>>>> @@ -1282,19 +1266,13 @@ static int create_rqt(struct mlx5_vdpa_net *ndev)
>>>>   static int modify_rqt(struct mlx5_vdpa_net *ndev, int num)
>>>>   {
>>>>   	__be32 *list;
>>>> -	int max_rqt;
>>>>   	void *rqtc;
>>>>   	int inlen;
>>>>   	void *in;
>>>>   	int i, j;
>>>>   	int err;
>>>>
>>>> -	max_rqt = min_t(int, roundup_pow_of_two(ndev->cur_num_vqs / 2),
>>>> -			1 << MLX5_CAP_GEN(ndev->mvdev.mdev, log_max_rqt_size));
>>>> -	if (max_rqt < 1)
>>>> -		return -EOPNOTSUPP;
>>>> -
>>>> -	inlen = MLX5_ST_SZ_BYTES(modify_rqt_in) + max_rqt * MLX5_ST_SZ_BYTES(rq_num);
>>>> +	inlen = MLX5_ST_SZ_BYTES(modify_rqt_in) + ndev->rqt_size * MLX5_ST_SZ_BYTES(rq_num);
>>>>   	in = kzalloc(inlen, GFP_KERNEL);
>>>>   	if (!in)
>>>>   		return -ENOMEM;
>>>> @@ -1305,10 +1283,10 @@ static int modify_rqt(struct mlx5_vdpa_net *ndev, int num)
>>>>   	MLX5_SET(rqtc, rqtc, list_q_type, MLX5_RQTC_LIST_Q_TYPE_VIRTIO_NET_Q);
>>>>
>>>>   	list = MLX5_ADDR_OF(rqtc, rqtc, rq_num[0]);
>>>> -	for (i = 0, j = 0; i < max_rqt; i++, j += 2)
>>>> +	for (i = 0, j = 0; i < ndev->rqt_size; i++, j += 2)
>>>>   		list[i] = cpu_to_be32(ndev->vqs[j % num].virtq_id);
>>>>
>>>> -	MLX5_SET(rqtc, rqtc, rqt_actual_size, max_rqt);
>>>> +	MLX5_SET(rqtc, rqtc, rqt_actual_size, ndev->rqt_size);
>>>>   	err = mlx5_vdpa_modify_rqt(&ndev->mvdev, in, inlen, ndev->res.rqtn);
>>>>   	kfree(in);
>>>>   	if (err)
>>>> @@ -1582,7 +1560,7 @@ static virtio_net_ctrl_ack handle_ctrl_mq(struct mlx5_vdpa_dev *mvdev, u8 cmd)
>>>>
>>>>   		newqps = mlx5vdpa16_to_cpu(mvdev, mq.virtqueue_pairs);
>>>>   		if (newqps < VIRTIO_NET_CTRL_MQ_VQ_PAIRS_MIN ||
>>>> -		    newqps > mlx5_vdpa_max_qps(mvdev->max_vqs))
>>>> +		    newqps > ndev->rqt_size)
>>>>   			break;
>>>>
>>>>   		if (ndev->cur_num_vqs == 2 * newqps) {
>>>> @@ -1946,7 +1924,7 @@ static int setup_virtqueues(struct mlx5_vdpa_dev *mvdev)
>>>>   	int err;
>>>>   	int i;
>>>>
>>>> -	for (i = 0; i < 2 * mlx5_vdpa_max_qps(mvdev->max_vqs); i++) {
>>>> +	for (i = 0; i < mvdev->max_vqs; i++) {
>>>>   		err = setup_vq(ndev, &ndev->vqs[i]);
>>>>   		if (err)
>>>>   			goto err_vq;
>>>> @@ -2017,9 +1995,11 @@ static int mlx5_vdpa_set_driver_features(struct vdpa_device *vdev, u64 features)
>>>>
>>>>   	ndev->mvdev.actual_features = features & ndev->mvdev.mlx_features;
>>>>   	if (ndev->mvdev.actual_features & BIT_ULL(VIRTIO_NET_F_MQ))
>>>> -		ndev->cur_num_vqs = 2 * mlx5vdpa16_to_cpu(mvdev, ndev->config.max_virtqueue_pairs);
>>>> +		ndev->rqt_size = mlx5vdpa16_to_cpu(mvdev, ndev->config.max_virtqueue_pairs);
>>>>   	else
>>>> -		ndev->cur_num_vqs = 2;
>>>> +		ndev->rqt_size = 1;
>>>> +
>>>> +	ndev->cur_num_vqs = 2 * ndev->rqt_size;
>>>>
>>>>   	update_cvq_info(mvdev);
>>>>   	return err;
>>>> @@ -2486,7 +2466,7 @@ static void init_mvqs(struct mlx5_vdpa_net *ndev)
>>>>   	struct mlx5_vdpa_virtqueue *mvq;
>>>>   	int i;
>>>>
>>>> -	for (i = 0; i < 2 * mlx5_vdpa_max_qps(ndev->mvdev.max_vqs); ++i) {
>>>> +	for (i = 0; i < ndev->mvdev.max_vqs; ++i) {
>>>>   		mvq = &ndev->vqs[i];
>>>>   		memset(mvq, 0, offsetof(struct mlx5_vdpa_virtqueue, ri));
>>>>   		mvq->index = i;
>>>> @@ -2606,7 +2586,8 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
>>>>   		return -EOPNOTSUPP;
>>>>   	}
>>>>
>>>> -	max_vqs = MLX5_CAP_DEV_VDPA_EMULATION(mdev, max_num_virtio_queues);
>>>> +	max_vqs = min_t(int, MLX5_CAP_DEV_VDPA_EMULATION(mdev, max_num_virtio_queues),
>>>> +			1 << MLX5_CAP_GEN(mdev, log_max_rqt_size));
>>>>   	if (max_vqs < 2) {
>>>>   		dev_warn(mdev->device,
>>>>   			 "%d virtqueues are supported. At least 2 are required\n",
>>>> @@ -2670,7 +2651,7 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
>>>>   		ndev->mvdev.mlx_features |= BIT_ULL(VIRTIO_NET_F_MAC);
>>>>   	}
>>>>
>>>> -	config->max_virtqueue_pairs = cpu_to_mlx5vdpa16(mvdev, mlx5_vdpa_max_qps(max_vqs));
>>>> +	config->max_virtqueue_pairs = cpu_to_mlx5vdpa16(mvdev, max_vqs / 2);
>>>>   	mvdev->vdev.dma_dev = &mdev->pdev->dev;
>>>>   	err = mlx5_vdpa_alloc_resources(&ndev->mvdev);
>>>>   	if (err)
>>>> @@ -2697,7 +2678,7 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
>>>>   	ndev->nb.notifier_call = event_handler;
>>>>   	mlx5_notifier_register(mdev, &ndev->nb);
>>>>   	mvdev->vdev.mdev = &mgtdev->mgtdev;
>>>> -	err = _vdpa_register_device(&mvdev->vdev, 2 * mlx5_vdpa_max_qps(max_vqs) + 1);
>>>> +	err = _vdpa_register_device(&mvdev->vdev, max_vqs + 1);
>>>>   	if (err)
>>>>   		goto err_reg;
>>>>
>>>> --
>>>> 2.18.1

