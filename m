Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BBB155EFB3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 22:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbiF1UkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 16:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbiF1UkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 16:40:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8A94520BF3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 13:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656448803;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CGLaXyxLtS2RSX+ruaLC5L5b9q7shHcOM9kFn/gAU+s=;
        b=eEbWk5OheCJpZfB/mzsJcF3n54KIhO8Hdhhk1DkEYmfOgDi933UgMutnTeaNaO0geUW6TR
        SALdNQWhsBdgwHs6xpvIB2YY16KGoVIGVJXxX16VkpJBk/5i9+Uu03iKEDPPalvyRC9MJx
        upoK9+XlTm27GdcJetRcz4grGysbEsA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-567-62tZ8YqaPqSSquNMfU5MvQ-1; Tue, 28 Jun 2022 16:40:02 -0400
X-MC-Unique: 62tZ8YqaPqSSquNMfU5MvQ-1
Received: by mail-wm1-f69.google.com with SMTP id be12-20020a05600c1e8c00b0039c506b52a4so132043wmb.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 13:40:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CGLaXyxLtS2RSX+ruaLC5L5b9q7shHcOM9kFn/gAU+s=;
        b=lzvxXXJUDO0RShhqha5l/OKuAuKe4uRWlenpJS+q1mlSDfIeEaYLRt5Lv+bSOBLqCL
         gWUgCyryStAS3Xf7x0uCyUCXAD4WxT3nRGmmI/rBc5061HXrS7bfmXZ7WIqk9skmJn3k
         +pix1OhXF+weWI0UnLJjEZvH/g7sqYrMrOWW/cpQ6HGVQDq/jYNWANw68Tfet6ei/48C
         vuZkz19yC5grDuKkW5M6p8cgS63uYPbqYikXSQgRoYK4Fy2AILtBSAJECHlvXkSCMV6v
         T1JTxTjtg5gNqUGbsdcxSZNfY6+cV2SGxHSdqxF+GYfJDjOsDLqitTNyptBZFSh1FGaN
         8duA==
X-Gm-Message-State: AJIora9cTtFaxP6dXvqsmon8YSFlpkCTB0wIz4EkqEbQ8hOEI76my/HD
        bYFZJxbKN+Fxa8JAl/ZRVLKQuFzdTO77Fpy6V+29iSZhvzXnVDmKDQIgMrx4Kec/rS36TR9vx2U
        GjqmeRnfNeFg2vZQwgvRqGaBy
X-Received: by 2002:a5d:4205:0:b0:21b:89ea:b5e3 with SMTP id n5-20020a5d4205000000b0021b89eab5e3mr18403187wrq.103.1656448800864;
        Tue, 28 Jun 2022 13:40:00 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1stXRbnYj9xa9v+Dh058tTTbo+XuIUckpFFfQHVMfNz/XwZpJF2tJtQ/iyTQoS3Mc1VNz2gcw==
X-Received: by 2002:a5d:4205:0:b0:21b:89ea:b5e3 with SMTP id n5-20020a5d4205000000b0021b89eab5e3mr18403174wrq.103.1656448800651;
        Tue, 28 Jun 2022 13:40:00 -0700 (PDT)
Received: from redhat.com ([2.52.23.204])
        by smtp.gmail.com with ESMTPSA id c3-20020adfef43000000b0021bab0ba755sm15121087wrp.106.2022.06.28.13.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 13:40:00 -0700 (PDT)
Date:   Tue, 28 Jun 2022 16:39:55 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Xu Qiang <xuqiang36@huawei.com>
Cc:     jasowang@redhat.com, elic@nvidia.com, si-wei.liu@oracle.com,
        parav@nvidia.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, rui.xiang@huawei.com
Subject: Re: [PATCH v2 -next] vdpa/mlx5: Use eth_zero_addr() to assign zero
 address
Message-ID: <20220628163950-mutt-send-email-mst@kernel.org>
References: <20220628123457.90884-1-xuqiang36@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220628123457.90884-1-xuqiang36@huawei.com>
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2022 at 12:34:57PM +0000, Xu Qiang wrote:
> Using eth_zero_addr() to assign zero address instead of memset().
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Xu Qiang <xuqiang36@huawei.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
> v2:
> - fix typo in commit log
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index e85c1d71f4ed..f738c78ef446 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -1457,8 +1457,8 @@ static int mlx5_vdpa_add_mac_vlan_rules(struct mlx5_vdpa_net *ndev, u8 *mac,
>  
>  	*ucast = rule;
>  
> -	memset(dmac_c, 0, ETH_ALEN);
> -	memset(dmac_v, 0, ETH_ALEN);
> +	eth_zero_addr(dmac_c);
> +	eth_zero_addr(dmac_v);
>  	dmac_c[0] = 1;
>  	dmac_v[0] = 1;
>  	rule = mlx5_add_flow_rules(ndev->rxft, spec, &flow_act, &dest, 1);
> -- 
> 2.17.1

