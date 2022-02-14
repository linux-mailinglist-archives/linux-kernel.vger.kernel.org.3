Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0674B4331
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 09:03:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241549AbiBNID1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 14 Feb 2022 03:03:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233043AbiBNIDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 03:03:25 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 858DD5B3CB
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 00:03:16 -0800 (PST)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1nJWKA-0006vg-Ok; Mon, 14 Feb 2022 09:03:06 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, Yong Wu <yong.wu@mediatek.com>
Cc:     James Wang <james.qian.wang@arm.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        iommu@lists.linux-foundation.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-kernel@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-mediatek@lists.infradead.org,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Stephen Boyd <sboyd@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Tomasz Figa <tfiga@chromium.org>, srv_heupstream@mediatek.com,
        Rob Clark <robdclark@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Yong Wu <yong.wu@mediatek.com>,
        Sandy Huang <hjc@rock-chips.com>,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 13/23] drm/rockchip: Make use of the helper component_compare_dev
Date:   Mon, 14 Feb 2022 09:03:04 +0100
Message-ID: <3640952.nfqboWGjmy@diego>
In-Reply-To: <20220214060819.7334-14-yong.wu@mediatek.com>
References: <20220214060819.7334-1-yong.wu@mediatek.com> <20220214060819.7334-14-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 14. Februar 2022, 07:08:09 CET schrieb Yong Wu:
> Use the common compare helper from component.
> 
> Cc: Sandy Huang <hjc@rock-chips.com>
> Cc: "Heiko St¨¹bner" <heiko@sntech.de>
> Cc: linux-rockchip@lists.infradead.org
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>

Acked-by: Heiko Stuebner <heiko@sntech.de>

> ---
>  drivers/gpu/drm/rockchip/rockchip_drm_drv.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
> index bec207de4544..3c2f2d6ecc36 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
> @@ -290,11 +290,6 @@ int rockchip_drm_endpoint_is_subdriver(struct device_node *ep)
>  	return false;
>  }
>  
> -static int compare_dev(struct device *dev, void *data)
> -{
> -	return dev == (struct device *)data;
> -}
> -
>  static void rockchip_drm_match_remove(struct device *dev)
>  {
>  	struct device_link *link;
> @@ -321,7 +316,7 @@ static struct component_match *rockchip_drm_match_add(struct device *dev)
>  				break;
>  
>  			device_link_add(dev, d, DL_FLAG_STATELESS);
> -			component_match_add(dev, &match, compare_dev, d);
> +			component_match_add(dev, &match, component_compare_dev, d);
>  		} while (true);
>  	}
>  
> 




