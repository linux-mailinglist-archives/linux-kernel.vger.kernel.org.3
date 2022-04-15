Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C09B2502122
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 05:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238096AbiDOEBY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 00:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232052AbiDOEBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 00:01:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 32F9CA5E9E
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 20:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649995133;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c+Kit//VWZalpQ+uwDe/ydbGGhxqUY8FznM+y1PZ1gE=;
        b=chxW6vU1mEoiy4VQPovSRnTg93DVQmNZpeR8mzfDFtwhV4/Rti+/0RrNRHib8sFvG0C1uN
        8akG2bH6W3UwNVeiwaTi2iyCrY0aT4cekwyMHdy4PYIl6n+RyxG7u+1p3+5gg7gB825Iw3
        l7s2U73JELArSW7kWFUbVpgB/zSuMVw=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-247-cpB6zx69NXqnVZTZePPmYw-1; Thu, 14 Apr 2022 23:58:49 -0400
X-MC-Unique: cpB6zx69NXqnVZTZePPmYw-1
Received: by mail-pl1-f200.google.com with SMTP id l6-20020a170903120600b0014f43ba55f3so3764419plh.11
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 20:58:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=c+Kit//VWZalpQ+uwDe/ydbGGhxqUY8FznM+y1PZ1gE=;
        b=wsqELm95oMOTwcjNVb1biQiNqN6m31Kt+bd8VsjVeCd+rEqSOdqD5ODGGtIo0yFxBb
         4TEMAaEB0z0xFq5B89YaAuaSLrGv4Jb3zFHCbiLpYxtf/8LmaMZBUjqcAriP/QoMyWT1
         ipYOh1mZSJsnWGypkRvRbNLb35LGkihZ/pYKT0UrISzF2kXsz73PLDNY7hm+44qnKrKJ
         qUeEpuGy9sIVD5kRK/tqXhWtqXOkUg8KNbO35gLxAf0mXwlQMp58QBM9ZjSfkGDVCrU/
         BJr8Mo8ReA7wFzpAMv0PaiNCTHkaWQHt8cUk0ueB73TpVVVx5KcoYgVeDylJFcB1CKKs
         dDOw==
X-Gm-Message-State: AOAM533usxe9zaV9Jk2C1InotRHZm93syRIGlEXnYOR8Gg4yfa6Z36OC
        X/+ELE+ms7ba0wwXZTFAbdEXr/iDdXda8jb7OEbuN3d2zRm10razCR6WUvHg2h7D1gQfBB6QNbK
        6rCVjwSnJKcTp3XxgcccRrDNa
X-Received: by 2002:a17:903:41c5:b0:158:93ab:1e72 with SMTP id u5-20020a17090341c500b0015893ab1e72mr14338818ple.118.1649995128779;
        Thu, 14 Apr 2022 20:58:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzTr3lMag/7G5E2EV+lDxWlic8ipNpLdSx/UX9bapc/IQv7w07Zx+BwE62kAPwtYEFqJx5MrQ==
X-Received: by 2002:a17:903:41c5:b0:158:93ab:1e72 with SMTP id u5-20020a17090341c500b0015893ab1e72mr14338790ple.118.1649995128372;
        Thu, 14 Apr 2022 20:58:48 -0700 (PDT)
Received: from [10.72.13.51] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id q9-20020a638c49000000b00398677b6f25sm3162601pgn.70.2022.04.14.20.58.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Apr 2022 20:58:47 -0700 (PDT)
Message-ID: <eb381955-0a64-011f-2732-943c60541b18@redhat.com>
Date:   Fri, 15 Apr 2022 11:58:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.0
Subject: Re: [PATCH 3/3] vdpa/mlx5: Add RX MAC VLAN filter support
Content-Language: en-US
To:     Eli Cohen <elic@nvidia.com>, mst@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, si-wei.liu@oracle.com
References: <20220411122942.225717-1-elic@nvidia.com>
 <20220411122942.225717-4-elic@nvidia.com>
From:   Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220411122942.225717-4-elic@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2022/4/11 20:29, Eli Cohen 写道:
> Support HW offloaded filtering of MAC/VLAN packets.
> To allow that, we add a handler to handle VLAN configurations coming
> through the control VQ. Two operations are supported.
>
> 1. Adding VLAN - in this case, an entry will be added to the RX flow
>     table that will allow the combination of the MAC/VLAN to be
>     forwarded to the TIR.
> 2. Removing VLAN - will remove the entry from the flow table,
>     effectively blocking such packets from going through.
>
> Currently the control VQ does not propagate changes to the MAC of the
> VLAN device so we always use the MAC of the parent device.
>
> Examples:
> 1. Create vlan device:
> $ ip link add link ens1 name ens1.8 type vlan id 8
>
> Signed-off-by: Eli Cohen <elic@nvidia.com>
> ---
>   drivers/vdpa/mlx5/net/mlx5_vnet.c | 274 +++++++++++++++++++++++-------
>   1 file changed, 216 insertions(+), 58 deletions(-)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index 5aa6220c7129..f81f9a213ed2 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -48,6 +48,8 @@ MODULE_LICENSE("Dual BSD/GPL");
>   
>   #define MLX5_FEATURE(_mvdev, _feature) (!!((_mvdev)->actual_features & BIT_ULL(_feature)))
>   
> +#define MLX5V_UNTAGGED 0x1000
> +
>   struct mlx5_vdpa_net_resources {
>   	u32 tisn;
>   	u32 tdn;
> @@ -143,6 +145,8 @@ static bool is_index_valid(struct mlx5_vdpa_dev *mvdev, u16 idx)
>   	return idx <= mvdev->max_idx;
>   }
>   
> +#define MLX5V_MACVLAN_SIZE 256
> +
>   struct mlx5_vdpa_net {
>   	struct mlx5_vdpa_dev mvdev;
>   	struct mlx5_vdpa_net_resources res;
> @@ -156,14 +160,20 @@ struct mlx5_vdpa_net {
>   	 */
>   	struct mutex reslock;
>   	struct mlx5_flow_table *rxft;
> -	struct mlx5_flow_handle *rx_rule_ucast;
> -	struct mlx5_flow_handle *rx_rule_mcast;
>   	bool setup;
>   	u32 cur_num_vqs;
>   	u32 rqt_size;
>   	struct notifier_block nb;
>   	struct vdpa_callback config_cb;
>   	struct mlx5_vdpa_wq_ent cvq_ent;
> +	struct hlist_head macvlan_hash[MLX5V_MACVLAN_SIZE];
> +};
> +
> +struct macvlan_node {
> +	struct hlist_node hlist;
> +	struct mlx5_flow_handle *ucast_rule;
> +	struct mlx5_flow_handle *mcast_rule;
> +	u64 macvlan;
>   };
>   
>   static void free_resources(struct mlx5_vdpa_net *ndev);
> @@ -1346,12 +1356,17 @@ static void destroy_tir(struct mlx5_vdpa_net *ndev)
>   	mlx5_vdpa_destroy_tir(&ndev->mvdev, ndev->res.tirn);
>   }
>   
> -static int add_fwd_to_tir(struct mlx5_vdpa_net *ndev)
> +#define MAX_STEERING_ENT 0x8000
> +#define MAX_STEERING_GROUPS 2
> +
> +static int mlx5_vdpa_add_mac_vlan_rules(struct mlx5_vdpa_net *ndev, u8 *mac,
> +					u16 vid, bool tagged,
> +					struct mlx5_flow_handle **ucast,
> +					struct mlx5_flow_handle **mcast)
>   {
>   	struct mlx5_flow_destination dest = {};
> -	struct mlx5_flow_table_attr ft_attr = {};
>   	struct mlx5_flow_act flow_act = {};
> -	struct mlx5_flow_namespace *ns;
> +	struct mlx5_flow_handle *rule;
>   	struct mlx5_flow_spec *spec;
>   	void *headers_c;
>   	void *headers_v;
> @@ -1364,74 +1379,178 @@ static int add_fwd_to_tir(struct mlx5_vdpa_net *ndev)
>   		return -ENOMEM;
>   
>   	spec->match_criteria_enable = MLX5_MATCH_OUTER_HEADERS;
> -	ft_attr.max_fte = 2;
> -	ft_attr.autogroup.max_num_groups = 2;
> -
> -	ns = mlx5_get_flow_namespace(ndev->mvdev.mdev, MLX5_FLOW_NAMESPACE_BYPASS);
> -	if (!ns) {
> -		mlx5_vdpa_warn(&ndev->mvdev, "failed to get flow namespace\n");
> -		err = -EOPNOTSUPP;
> -		goto err_ns;
> -	}
> -
> -	ndev->rxft = mlx5_create_auto_grouped_flow_table(ns, &ft_attr);
> -	if (IS_ERR(ndev->rxft)) {
> -		err = PTR_ERR(ndev->rxft);
> -		goto err_ns;
> -	}
> -
>   	headers_c = MLX5_ADDR_OF(fte_match_param, spec->match_criteria, outer_headers);
> -	dmac_c = MLX5_ADDR_OF(fte_match_param, headers_c, outer_headers.dmac_47_16);
> -	memset(dmac_c, 0xff, ETH_ALEN);
>   	headers_v = MLX5_ADDR_OF(fte_match_param, spec->match_value, outer_headers);
> +	dmac_c = MLX5_ADDR_OF(fte_match_param, headers_c, outer_headers.dmac_47_16);
>   	dmac_v = MLX5_ADDR_OF(fte_match_param, headers_v, outer_headers.dmac_47_16);
> -	ether_addr_copy(dmac_v, ndev->config.mac);
> -
> +	memset(dmac_c, 0xff, ETH_ALEN);
> +	ether_addr_copy(dmac_v, mac);
> +	MLX5_SET(fte_match_set_lyr_2_4, headers_c, cvlan_tag, 1);
> +	if (tagged) {
> +		MLX5_SET(fte_match_set_lyr_2_4, headers_v, cvlan_tag, 1);
> +		MLX5_SET_TO_ONES(fte_match_set_lyr_2_4, headers_c, first_vid);
> +		MLX5_SET(fte_match_set_lyr_2_4, headers_c, first_vid, vid);
> +	}
>   	flow_act.action = MLX5_FLOW_CONTEXT_ACTION_FWD_DEST;
>   	dest.type = MLX5_FLOW_DESTINATION_TYPE_TIR;
>   	dest.tir_num = ndev->res.tirn;
> -	ndev->rx_rule_ucast = mlx5_add_flow_rules(ndev->rxft, spec, &flow_act, &dest, 1);
> +	rule = mlx5_add_flow_rules(ndev->rxft, spec, &flow_act, &dest, 1);
> +	if (IS_ERR(rule))
> +		return PTR_ERR(rule);
>   
> -	if (IS_ERR(ndev->rx_rule_ucast)) {
> -		err = PTR_ERR(ndev->rx_rule_ucast);
> -		ndev->rx_rule_ucast = NULL;
> -		goto err_rule_ucast;
> -	}
> +	*ucast = rule;
>   
>   	memset(dmac_c, 0, ETH_ALEN);
>   	memset(dmac_v, 0, ETH_ALEN);
>   	dmac_c[0] = 1;
>   	dmac_v[0] = 1;
> -	flow_act.action = MLX5_FLOW_CONTEXT_ACTION_FWD_DEST;
> -	ndev->rx_rule_mcast = mlx5_add_flow_rules(ndev->rxft, spec, &flow_act, &dest, 1);
> -	if (IS_ERR(ndev->rx_rule_mcast)) {
> -		err = PTR_ERR(ndev->rx_rule_mcast);
> -		ndev->rx_rule_mcast = NULL;
> -		goto err_rule_mcast;
> +	rule = mlx5_add_flow_rules(ndev->rxft, spec, &flow_act, &dest, 1);
> +	kvfree(spec);
> +	if (IS_ERR(rule)) {
> +		err = PTR_ERR(rule);
> +		goto err_mcast;
>   	}
>   
> -	kvfree(spec);
> +	*mcast = rule;
>   	return 0;
>   
> -err_rule_mcast:
> -	mlx5_del_flow_rules(ndev->rx_rule_ucast);
> -	ndev->rx_rule_ucast = NULL;
> -err_rule_ucast:
> -	mlx5_destroy_flow_table(ndev->rxft);
> -err_ns:
> -	kvfree(spec);
> +err_mcast:
> +	mlx5_del_flow_rules(*ucast);
> +	return err;
> +}
> +
> +static void mlx5_vdpa_del_mac_vlan_rules(struct mlx5_vdpa_net *ndev,
> +					 struct mlx5_flow_handle *ucast,
> +					 struct mlx5_flow_handle *mcast)
> +{
> +	mlx5_del_flow_rules(ucast);
> +	mlx5_del_flow_rules(mcast);
> +}
> +
> +static u64 search_val(u8 *mac, u16 vlan, bool tagged)
> +{
> +	u64 val;
> +
> +	if (!tagged)
> +		vlan = MLX5V_UNTAGGED;
> +
> +	val = (u64)vlan << 48 |
> +	      (u64)mac[0] << 40 |
> +	      (u64)mac[1] << 32 |
> +	      (u64)mac[2] << 24 |
> +	      (u64)mac[3] << 16 |
> +	      (u64)mac[4] << 8 |
> +	      (u64)mac[5];
> +
> +	return val;
> +}
> +
> +static struct macvlan_node *mac_vlan_lookup(struct mlx5_vdpa_net *ndev, u64 value)
> +{
> +	struct macvlan_node *pos;
> +	u32 idx;
> +
> +	idx = hash_64(value, 8); // tbd 8
> +	hlist_for_each_entry(pos, &ndev->macvlan_hash[idx], hlist) {
> +		if (pos->macvlan == value)
> +			return pos;
> +	}
> +	return NULL;
> +}
> +
> +static int mac_vlan_add(struct mlx5_vdpa_net *ndev, u8 *mac, u16 vlan, bool tagged) // vlan -> vid
> +{


I guess checkpatch may not be happy with such kind of comment.


> +	struct macvlan_node *ptr;
> +	u64 val;
> +	u32 idx;
> +	int err;
> +
> +	val = search_val(mac, vlan, tagged);
> +	if (mac_vlan_lookup(ndev, val))
> +		return -EEXIST;
> +
> +	ptr = kzalloc(sizeof(*ptr), GFP_KERNEL);
> +	if (!ptr)
> +		return -ENOMEM;
> +
> +	err = mlx5_vdpa_add_mac_vlan_rules(ndev, ndev->config.mac, vlan, tagged,
> +					   &ptr->ucast_rule, &ptr->mcast_rule);
> +	if (err)
> +		goto err_add;
> +
> +	ptr->macvlan = val;
> +	idx = hash_64(val, 8);
> +	hlist_add_head(&ptr->hlist, &ndev->macvlan_hash[idx]);
> +	return 0;
> +
> +err_add:
> +	kfree(ptr);
>   	return err;
>   }
>   
> -static void remove_fwd_to_tir(struct mlx5_vdpa_net *ndev)
> +static void mac_vlan_del(struct mlx5_vdpa_net *ndev, u8 *mac, u16 vlan, bool tagged)
>   {
> -	if (!ndev->rx_rule_ucast)
> +	struct macvlan_node *ptr;
> +
> +	ptr = mac_vlan_lookup(ndev, search_val(mac, vlan, tagged));
> +	if (!ptr)
>   		return;
>   
> -	mlx5_del_flow_rules(ndev->rx_rule_mcast);
> -	ndev->rx_rule_mcast = NULL;
> -	mlx5_del_flow_rules(ndev->rx_rule_ucast);
> -	ndev->rx_rule_ucast = NULL;
> +	hlist_del(&ptr->hlist);
> +	mlx5_vdpa_del_mac_vlan_rules(ndev, ptr->ucast_rule, ptr->mcast_rule);
> +	kfree(ptr);
> +}
> +
> +static void clear_mac_vlan_table(struct mlx5_vdpa_net *ndev)
> +{
> +	struct macvlan_node *pos;
> +	struct hlist_node *n;
> +	int i;
> +
> +	for (i = 0; i < MLX5V_MACVLAN_SIZE; i++) {
> +		hlist_for_each_entry_safe(pos, n, &ndev->macvlan_hash[i], hlist) {
> +			hlist_del(&pos->hlist);
> +			mlx5_vdpa_del_mac_vlan_rules(ndev, pos->ucast_rule, pos->mcast_rule);
> +			kfree(pos);
> +		}
> +	}
> +}
> +
> +static int setup_steering(struct mlx5_vdpa_net *ndev)
> +{
> +	struct mlx5_flow_table_attr ft_attr = {};
> +	struct mlx5_flow_namespace *ns;
> +	int err;
> +
> +	ft_attr.max_fte = MAX_STEERING_ENT;
> +	ft_attr.autogroup.max_num_groups = MAX_STEERING_GROUPS;
> +
> +	ns = mlx5_get_flow_namespace(ndev->mvdev.mdev, MLX5_FLOW_NAMESPACE_BYPASS);
> +	if (!ns) {
> +		mlx5_vdpa_warn(&ndev->mvdev, "failed to get flow namespace\n");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	ndev->rxft = mlx5_create_auto_grouped_flow_table(ns, &ft_attr);
> +	if (IS_ERR(ndev->rxft)) {
> +		mlx5_vdpa_warn(&ndev->mvdev, "failed to create flow table\n");
> +		return PTR_ERR(ndev->rxft);
> +	}
> +
> +	err = mac_vlan_add(ndev, ndev->config.mac, 0, false);
> +	if (err)
> +		goto err_add;
> +
> +	return 0;
> +
> +err_add:
> +	mlx5_destroy_flow_table(ndev->rxft);
> +	return err;
> +}
> +
> +static void teardown_steering(struct mlx5_vdpa_net *ndev)
> +{
> +	clear_mac_vlan_table(ndev);
>   	mlx5_destroy_flow_table(ndev->rxft);
>   }
>   
> @@ -1482,9 +1601,9 @@ static virtio_net_ctrl_ack handle_ctrl_mac(struct mlx5_vdpa_dev *mvdev, u8 cmd)
>   
>   		/* Need recreate the flow table entry, so that the packet could forward back
>   		 */
> -		remove_fwd_to_tir(ndev);
> +		mac_vlan_del(ndev, ndev->config.mac, 0, false);
>   
> -		if (add_fwd_to_tir(ndev)) {
> +		if (mac_vlan_add(ndev, ndev->config.mac, 0, false)) {
>   			mlx5_vdpa_warn(mvdev, "failed to insert forward rules, try to restore\n");
>   
>   			/* Although it hardly run here, we still need double check */
> @@ -1508,7 +1627,7 @@ static virtio_net_ctrl_ack handle_ctrl_mac(struct mlx5_vdpa_dev *mvdev, u8 cmd)
>   
>   			memcpy(ndev->config.mac, mac_back, ETH_ALEN);
>   
> -			if (add_fwd_to_tir(ndev))
> +			if (mac_vlan_add(ndev, ndev->config.mac, 0, false))
>   				mlx5_vdpa_warn(mvdev, "restore forward rules failed: insert forward rules failed\n");
>   
>   			break;
> @@ -1610,6 +1729,42 @@ static virtio_net_ctrl_ack handle_ctrl_mq(struct mlx5_vdpa_dev *mvdev, u8 cmd)
>   	return status;
>   }
>   
> +static virtio_net_ctrl_ack handle_ctrl_vlan(struct mlx5_vdpa_dev *mvdev, u8 cmd)
> +{
> +	struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
> +	virtio_net_ctrl_ack status = VIRTIO_NET_ERR;
> +	struct mlx5_control_vq *cvq = &mvdev->cvq;
> +	struct virtio_net_ctrl_vlan vlan;
> +	size_t read;
> +	u16 id;
> +
> +	switch (cmd) {
> +	case VIRTIO_NET_CTRL_VLAN_ADD:
> +		read = vringh_iov_pull_iotlb(&cvq->vring, &cvq->riov, (void *)&vlan, sizeof(vlan));
> +		if (read != sizeof(vlan))
> +			break;
> +
> +		id = mlx5vdpa16_to_cpu(mvdev, vlan.id);
> +		if (mac_vlan_add(ndev, ndev->config.mac, id, true))
> +			break;


This may work now but I wonder if we had the plan to support 
VIRTIO_NET_F_CTRL_RX?

if $mac is not in $mac_table
     drop;
if $vlan is not in $vlan_table
     drop;

With that features we probably requires the dedicated vlan filters 
without a mac? Or do we want to a $mac * $vlans rules?

If yes, maybe it's better to decouple vlan filters from mac now.

Thanks


> +
> +		status = VIRTIO_NET_OK;
> +		break;
> +	case VIRTIO_NET_CTRL_VLAN_DEL:
> +		read = vringh_iov_pull_iotlb(&cvq->vring, &cvq->riov, (void *)&vlan, sizeof(vlan));
> +		if (read != sizeof(vlan))
> +			break;
> +
> +		id = mlx5vdpa16_to_cpu(mvdev, vlan.id);
> +		mac_vlan_del(ndev, ndev->config.mac, id, true);
> +		break;
> +	default:
> +	break;
> +}
> +
> +return status;
> +}
> +
>   static void mlx5_cvq_kick_handler(struct work_struct *work)
>   {
>   	virtio_net_ctrl_ack status = VIRTIO_NET_ERR;
> @@ -1654,7 +1809,9 @@ static void mlx5_cvq_kick_handler(struct work_struct *work)
>   		case VIRTIO_NET_CTRL_MQ:
>   			status = handle_ctrl_mq(mvdev, ctrl.cmd);
>   			break;
> -
> +		case VIRTIO_NET_CTRL_VLAN:
> +			status = handle_ctrl_vlan(mvdev, ctrl.cmd);
> +			break;
>   		default:
>   			break;
>   		}
> @@ -1913,6 +2070,7 @@ static u64 get_supported_features(struct mlx5_core_dev *mdev)
>   	mlx_vdpa_features |= BIT_ULL(VIRTIO_NET_F_MQ);
>   	mlx_vdpa_features |= BIT_ULL(VIRTIO_NET_F_STATUS);
>   	mlx_vdpa_features |= BIT_ULL(VIRTIO_NET_F_MTU);
> +	mlx_vdpa_features |= BIT_ULL(VIRTIO_NET_F_CTRL_VLAN);
>   
>   	return mlx_vdpa_features;
>   }
> @@ -2198,9 +2356,9 @@ static int setup_driver(struct mlx5_vdpa_dev *mvdev)
>   		goto err_tir;
>   	}
>   
> -	err = add_fwd_to_tir(ndev);
> +	err = setup_steering(ndev);
>   	if (err) {
> -		mlx5_vdpa_warn(mvdev, "add_fwd_to_tir\n");
> +		mlx5_vdpa_warn(mvdev, "setup_steering\n");
>   		goto err_fwd;
>   	}
>   	ndev->setup = true;
> @@ -2226,7 +2384,7 @@ static void teardown_driver(struct mlx5_vdpa_net *ndev)
>   	if (!ndev->setup)
>   		return;
>   
> -	remove_fwd_to_tir(ndev);
> +	teardown_steering(ndev);
>   	destroy_tir(ndev);
>   	destroy_rqt(ndev);
>   	teardown_virtqueues(ndev);

