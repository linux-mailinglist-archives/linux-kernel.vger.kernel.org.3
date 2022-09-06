Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE3B75AE936
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 15:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240333AbiIFNPm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 09:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234277AbiIFNPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 09:15:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A3314D4FE
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 06:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662470136;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1uJsWhraelKXluHwB7FaDWCgu+gdxCn6dypgVW00Tgc=;
        b=bF5LJJux6pkMsVLSu9nhNW/lSLbx6PqMRuDcPP3rp8MRQW/eKT3RDtWAFO01gOjiCg6JXj
        oLPEru7ZKFnDfsjCb5p44b9xAesyfcdDuZzSICNlpQ6pnaow+hY64dirPC/NqER2MtKev3
        w2409D0WQFhyeucvX/8O9KlOHxtKe+0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-329-ZJ6f2qvFNdyHQEaDEwgJug-1; Tue, 06 Sep 2022 09:15:35 -0400
X-MC-Unique: ZJ6f2qvFNdyHQEaDEwgJug-1
Received: by mail-wm1-f72.google.com with SMTP id v21-20020a05600c215500b003a83c910d83so2093556wml.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 06:15:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date;
        bh=1uJsWhraelKXluHwB7FaDWCgu+gdxCn6dypgVW00Tgc=;
        b=0Fy2Qwi/HXpYZtHy48dHpUEW2HalY+ekEJvjgqOMiBThH4skCL3iuX1E/xM34GR0hz
         S8wU1AQ1LCL3eKJryN5hlYQHYgsZfYsblZxE+i9wn7zDnBHzqckzboQW+Lry0Oohb1Ir
         iBIfan756xkG6mnOtn0kaTd2jo2VKWhrYeFErWge5wtOKjxBFwIWHlx8zQj270vrbzyA
         1JW7tFhcBotgpB+GyIQ08prIFivx7VxIorvmVv/4r3/vqf780j0C+rR0ZKMRTGtB2ZXn
         p4t4WmH2BSLh7snnw7E4R0Z9O14B3iAN8zPf0ADNgGRN1d8RtjzFNvxz7ubGM7p46a2v
         mCjQ==
X-Gm-Message-State: ACgBeo2gXwMBYmIUsphZPtdw7XIveHzERb9dxCxoec0cTT4zW8foW0u1
        we5jyYhB0lWJYu4KdlX7uS6cu0FxIS/AF0h0CqRL6wwcbLA5ti/VMaf3xEY+/0X9MJGYmNc7xgB
        x3CijvEaMkewmWAUFTua03U3T
X-Received: by 2002:a5d:59a4:0:b0:228:5f74:796 with SMTP id p4-20020a5d59a4000000b002285f740796mr9196592wrr.655.1662470133839;
        Tue, 06 Sep 2022 06:15:33 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5P3NAwv8A+ZEKH3JYcwHQ89wUpJPH3H2eNehgZC3vx/2n+iYwWJrNvkLHshgWwyn7m7zUFWA==
X-Received: by 2002:a5d:59a4:0:b0:228:5f74:796 with SMTP id p4-20020a5d59a4000000b002285f740796mr9196562wrr.655.1662470133442;
        Tue, 06 Sep 2022 06:15:33 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-112-72.dyn.eolo.it. [146.241.112.72])
        by smtp.gmail.com with ESMTPSA id q1-20020a05600c2e4100b003a2cf1ba9e2sm13653800wmf.6.2022.09.06.06.15.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 06:15:32 -0700 (PDT)
Message-ID: <8b2589bd6303133fd27cab1af27b096a5f848074.camel@redhat.com>
Subject: Re: [PATCH net-next 2/5] net: hns3: support ndo_select_queue()
From:   Paolo Abeni <pabeni@redhat.com>
To:     Guangbin Huang <huangguangbin2@huawei.com>, davem@davemloft.net,
        kuba@kernel.org
Cc:     edumazet@google.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, lipeng321@huawei.com,
        lanhao@huawei.com
Date:   Tue, 06 Sep 2022 15:15:31 +0200
In-Reply-To: <20220905081539.62131-3-huangguangbin2@huawei.com>
References: <20220905081539.62131-1-huangguangbin2@huawei.com>
         <20220905081539.62131-3-huangguangbin2@huawei.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-09-05 at 16:15 +0800, Guangbin Huang wrote:
> To support tx packets to select queue according to its dscp field after
> setting dscp and tc map relationship, this patch implements
> ndo_select_queue() to set skb->priority according to the user's setting
> dscp and priority map relationship.
> 
> Signed-off-by: Guangbin Huang <huangguangbin2@huawei.com>
> ---
>  .../net/ethernet/hisilicon/hns3/hns3_enet.c   | 46 +++++++++++++++++++
>  1 file changed, 46 insertions(+)
> 
> diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
> index 481a300819ad..82f83e3f8162 100644
> --- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
> +++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
> @@ -2963,6 +2963,51 @@ static int hns3_nic_set_vf_mac(struct net_device *netdev, int vf_id, u8 *mac)
>  	return h->ae_algo->ops->set_vf_mac(h, vf_id, mac);
>  }
>  
> +#define HNS3_INVALID_DSCP		0xff
> +#define HNS3_DSCP_SHIFT			2
> +
> +static u8 hns3_get_skb_dscp(struct sk_buff *skb)
> +{
> +	__be16 protocol = skb->protocol;
> +	u8 dscp = HNS3_INVALID_DSCP;
> +
> +	if (protocol == htons(ETH_P_8021Q))
> +		protocol = vlan_get_protocol(skb);
> +
> +	if (protocol == htons(ETH_P_IP))
> +		dscp = ipv4_get_dsfield(ip_hdr(skb)) >> HNS3_DSCP_SHIFT;
> +	else if (protocol == htons(ETH_P_IPV6))
> +		dscp = ipv6_get_dsfield(ipv6_hdr(skb)) >> HNS3_DSCP_SHIFT;
> +
> +	return dscp;
> +}
> +
> +static u16 hns3_nic_select_queue(struct net_device *netdev,
> +				 struct sk_buff *skb,
> +				 struct net_device *sb_dev)
> +{
> +	struct hnae3_handle *h = hns3_get_handle(netdev);
> +	u8 dscp, priority;
> +	int ret;
> +
> +	if (h->kinfo.tc_map_mode != HNAE3_TC_MAP_MODE_DSCP ||
> +	    !h->ae_algo->ops->get_dscp_prio)
> +		goto out;
> +
> +	dscp = hns3_get_skb_dscp(skb);
> +	if (unlikely(dscp == HNS3_INVALID_DSCP))
> +		goto out;
> +
> +	ret = h->ae_algo->ops->get_dscp_prio(h, dscp, NULL, &priority);

This introduces an additional, unneeded indirect call in the fast path,
you could consider replacing the above with a direct call to
hclge_get_dscp_prio() - again taking care of the CONFIG_HNS3_DCB
dependency.

Cheers,

Paolo

