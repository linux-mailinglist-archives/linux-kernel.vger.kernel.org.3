Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1414C55DD16
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344984AbiF1Khl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 06:37:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344995AbiF1Khc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 06:37:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C39FA31531
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 03:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656412650;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JZ412A6etRNSSmCZ+MdpqmCicNkRtP9zW1av9UbdkXw=;
        b=IFVdUcCjXkmR+pRqKW3sd3RHyQtBz+UvoGaf+o2ItL/wUQl5b68cRsq7q7SPqthE99MQdq
        lSoq+fDtT34c/KQBl2PiHE9q8PTxXaw9cxA2hNcgwf+av5Xem/4hcD2RnZNMxBKd6jwK2H
        S0bPt5Mafq2Lj8BiUrLCj/9tTjVJy4s=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-156-DdCJlHcGMMisGMW0sWZBlg-1; Tue, 28 Jun 2022 06:37:27 -0400
X-MC-Unique: DdCJlHcGMMisGMW0sWZBlg-1
Received: by mail-wm1-f69.google.com with SMTP id p6-20020a05600c358600b003a0483b3c2eso3549248wmq.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 03:37:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JZ412A6etRNSSmCZ+MdpqmCicNkRtP9zW1av9UbdkXw=;
        b=Mq+U7Ox7iBdhYEuNOwB2Wn/+GapaAtT/YU7aag8/BxreJ2AGKQ3STUjR841jDZ4p47
         Ec7TLggmDfBRalvKJOBMzxZV62Z2rmG8FJ/uzi9sjdTmrVBddIehiqiZIN7oR4FqeaMw
         HDbYeI2SHmWEhgSoNOjpHx8+ExRYNBhNe5MJaQCp4C3U9quDFkbr5knxtWjipm+BJ8Ps
         /NnU6znz9nABwW+z0Kjn8vCUcC/Q8wjHQlStsq/KAkElpTiEB1Yfw4M/9xI5VIfx/YlE
         ETeUQuRRxloE0YvlnmTiAR5Ptz5QTOgMA7V/wQOt9bzqof+rAIe9h6mYHzkUWYWB0lca
         w3vQ==
X-Gm-Message-State: AJIora+tVXvVmSZ5dYI9llJeqzcimBUyjY7xiKNUmype76+Qetc9WZ7j
        YTvBXioPJXBm7mf7QElCqtQH9vkw9knw9fq16GxXzWHgUDIvpZ1mJAiEhrA584cgfoCWIeJfeN3
        snhzWzFiK8EmPcMQMpQA7hmLy
X-Received: by 2002:a5d:5f05:0:b0:21b:8ca0:6d3d with SMTP id cl5-20020a5d5f05000000b0021b8ca06d3dmr16999588wrb.382.1656412645825;
        Tue, 28 Jun 2022 03:37:25 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uXNGFE5xDiJLqCYzHw0b1cPLBkMfKGgL9TiFcXE4v2aSyk0kMGcqQcAG4JMTTFITIUubCZuQ==
X-Received: by 2002:a5d:5f05:0:b0:21b:8ca0:6d3d with SMTP id cl5-20020a5d5f05000000b0021b8ca06d3dmr16999571wrb.382.1656412645635;
        Tue, 28 Jun 2022 03:37:25 -0700 (PDT)
Received: from redhat.com ([2.52.23.204])
        by smtp.gmail.com with ESMTPSA id v24-20020a5d5918000000b0021b9870049dsm13038675wrd.82.2022.06.28.03.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 03:37:25 -0700 (PDT)
Date:   Tue, 28 Jun 2022 06:37:20 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Xu Qiang <xuqiang36@huawei.com>
Cc:     jasowang@redhat.com, elic@nvidia.com, si-wei.liu@oracle.com,
        parav@nvidia.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, rui.xiang@huawei.com
Subject: Re: [PATCH -next] vdpa/mlx5: Use eth_zero_addr() to assign zero
 address
Message-ID: <20220628063703-mutt-send-email-mst@kernel.org>
References: <20220628094418.27973-1-xuqiang36@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220628094418.27973-1-xuqiang36@huawei.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2022 at 09:44:18AM +0000, Xu Qiang wrote:
> Using eth_zero_addr() to assign zero address insetad of

typo

> memset().
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Xu Qiang <xuqiang36@huawei.com>
> ---
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

