Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59A2E567CF8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 06:05:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231793AbiGFEEp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 00:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231347AbiGFEEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 00:04:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4D3786471
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 21:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657080282;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PW1JA3IwMBbLhLVaMU9NmnNjjRdTnwQkFv7IrA803Lg=;
        b=eOHiR5q8STyj+VOTtiGuh+O5KUi9l8xPnkaHmCIQ+77R7cyDDvIOhGnnRleunHxl1Axoxw
        IRSAxHn5qg6IDobERc2kVo2WdETwYtRZdqZUKxhQPYi1b9OvoL6wbgBcPegui0SP1MYqRu
        K69fldJP16qDZ5mcw43GJadhWZl6nOY=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-304-TLsE_RjGNm6b9ih5ySUbGg-1; Wed, 06 Jul 2022 00:04:35 -0400
X-MC-Unique: TLsE_RjGNm6b9ih5ySUbGg-1
Received: by mail-lf1-f72.google.com with SMTP id cf10-20020a056512280a00b0047f5a295656so4680544lfb.15
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 21:04:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PW1JA3IwMBbLhLVaMU9NmnNjjRdTnwQkFv7IrA803Lg=;
        b=olng7oVhXNdCRh8c2chAr8H7ZD+vfMd7+HfuUUoegG82GdO5OYsarME96Lx8k5F906
         fDCVaMn7FA4MfWSs206yax1H4T01wMh/Tiv1iArXDYFysGWXueocgbekJ7WNduY69AkD
         JK3rTFzyH0LIxGAMewIcJvakaM4h+pcjK621XKWDfr0tK32hIOGmO01JLYk9feoySQxW
         GnnZnwneNSExhNIkR/11lss6IlcJSTFNrBG4zltyGpPjgOLsi0oVq+yYWu3hu8FwlzWB
         +zfVHgvYMvXIu5vNXwAnlY9PQ20cZAWphRVWkg6Csz8nhbImSn4AUSFQBar5ULEdOTWQ
         Cv2Q==
X-Gm-Message-State: AJIora/L/UPHaaQlE3vy85v347c2wb0RNEGZb9ykWntT6pw3vfVr29li
        jCIsEtLRcIu4KvMB2ESeM+aIymZd+cDDCU+yY6AM10cMjD5Q2CVzM5ypyHW8GHEcNu32S4dfRpQ
        zI2EyLPtsX+QyHY4biOiNDQKQCd4tqF9GkxxkCFic
X-Received: by 2002:a05:6512:3b8e:b0:481:1a75:452 with SMTP id g14-20020a0565123b8e00b004811a750452mr26453593lfv.238.1657080273542;
        Tue, 05 Jul 2022 21:04:33 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sZxUBY4tuH7mFPtCtHELBxvE6PGXQdNEbj5tf0whZsOUVsKDnhnVVzlPSuQPLU6ZjANs/FNXsiAqRSupm8HSE=
X-Received: by 2002:a05:6512:3b8e:b0:481:1a75:452 with SMTP id
 g14-20020a0565123b8e00b004811a750452mr26453582lfv.238.1657080273384; Tue, 05
 Jul 2022 21:04:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220704021405.64545-1-xuqiang36@huawei.com>
In-Reply-To: <20220704021405.64545-1-xuqiang36@huawei.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Wed, 6 Jul 2022 12:04:22 +0800
Message-ID: <CACGkMEvGsJbR_vCfGfi_Stxw0kiLwJZMXy6m-YXOkj73Y1WEEQ@mail.gmail.com>
Subject: Re: [PATCH -next] vdpa/mlx5: Use eth_broadcast_addr() to assign
 broadcast address
To:     Xu Qiang <xuqiang36@huawei.com>
Cc:     mst <mst@redhat.com>, Eli Cohen <elic@nvidia.com>,
        Si-Wei Liu <si-wei.liu@oracle.com>,
        Parav Pandit <parav@nvidia.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, rui.xiang@huawei.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 4, 2022 at 10:16 AM Xu Qiang <xuqiang36@huawei.com> wrote:
>
> Using eth_broadcast_addr() to assign broadcast address instead
> of memset().
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Xu Qiang <xuqiang36@huawei.com>

Acked-by: Jason Wang <jasowang@redhat.com>

> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index f738c78ef446..3b2929d4a819 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -1440,7 +1440,7 @@ static int mlx5_vdpa_add_mac_vlan_rules(struct mlx5_vdpa_net *ndev, u8 *mac,
>         headers_v = MLX5_ADDR_OF(fte_match_param, spec->match_value, outer_headers);
>         dmac_c = MLX5_ADDR_OF(fte_match_param, headers_c, outer_headers.dmac_47_16);
>         dmac_v = MLX5_ADDR_OF(fte_match_param, headers_v, outer_headers.dmac_47_16);
> -       memset(dmac_c, 0xff, ETH_ALEN);
> +       eth_broadcast_addr(dmac_c);
>         ether_addr_copy(dmac_v, mac);
>         MLX5_SET(fte_match_set_lyr_2_4, headers_c, cvlan_tag, 1);
>         if (tagged) {
> --
> 2.17.1
>

