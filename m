Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C961E49F9AC
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 13:41:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348614AbiA1MlJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 07:41:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237505AbiA1MlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 07:41:07 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BEE9C061714;
        Fri, 28 Jan 2022 04:41:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0ACE2619B9;
        Fri, 28 Jan 2022 12:41:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA84CC340E6;
        Fri, 28 Jan 2022 12:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643373666;
        bh=QTzghuuSPtxJUTuUKx+W2/InQdxW15PSFwUv7VwUABw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fDDCmQCAaMcJEavgtcJqwJ2QJDBq3pXRsPPc/l3by+2yESxDGmW5Kc9OAQqn3MlGS
         9u8Jv1ppUGuCND2rokmY9SaMNtaybtUEWIbP9oXZ0jFRJDx82sG3zyppd2O0w9G76o
         Uf6erkYS+tgPQeVG5Z4aajPuWDNl06NAHpm7V+osyHiEA1BafH1iqrwBRt4Nwh5f7b
         wTP3ylF7iEUpGtGw+XjQr3MkFPOrG30hsWP/p9VE+pXFzTebvsbCxultxHFmtTO7Ho
         qvm2eN+tw7ziwQofhdfjUSM4ZDTzEncDr5Kmwnm/HUP8sHcsjZTVNARCCP6qFvyT/z
         eHYTGTk6Yk5gg==
Date:   Fri, 28 Jan 2022 13:40:55 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Yong Wu <yong.wu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Hans Verkuil <hverkuil@xs4all.nl>, Joerg Roedel <jroedel@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        David Airlie <airlied@linux.ie>,
        Evan Green <evgreen@chromium.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Will Deacon <will.deacon@arm.com>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <youlin.pei@mediatek.com>,
        Matthias Kaehlcke <mka@chromium.org>, <anan.sun@mediatek.com>,
        <yi.kuo@mediatek.com>, <acourbot@chromium.org>,
        <linux-media@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        "Dafna Hirschfeld" <dafna.hirschfeld@collabora.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Eizan Miyamoto <eizan@chromium.org>,
        <anthony.huang@mediatek.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        <mingyuan.ma@mediatek.com>, <yf.wang@mediatek.com>,
        <libo.kang@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v10 02/13] iommu/mediatek-v1: Free the existed fwspec if
 the master dev already has
Message-ID: <20220128134055.720bb43c@coco.lan>
In-Reply-To: <20220117070510.17642-3-yong.wu@mediatek.com>
References: <20220117070510.17642-1-yong.wu@mediatek.com>
        <20220117070510.17642-3-yong.wu@mediatek.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias/Yong,

Are you ok if this patch gets merged via the media tree together with the
remaining series, or do you prefer to apply it via SoC tree instead?

Regards,
Mauro


Em Mon, 17 Jan 2022 15:04:59 +0800
Yong Wu <yong.wu@mediatek.com> escreveu:

> When the iommu master device enters of_iommu_xlate, the ops may be
> NULL(iommu dev is defered), then it will initialize the fwspec here:
> 
> [<c0c9c5bc>] (dev_iommu_fwspec_set) from [<c06bda80>]
> (iommu_fwspec_init+0xbc/0xd4)
> [<c06bd9c4>] (iommu_fwspec_init) from [<c06c0db4>]
> (of_iommu_xlate+0x7c/0x12c)
> [<c06c0d38>] (of_iommu_xlate) from [<c06c10e8>]
> (of_iommu_configure+0x144/0x1e8)
> 
> BUT the mtk_iommu_v1.c only supports arm32, the probing flow still is a bit
> weird. We always expect create the fwspec internally. otherwise it will
> enter here and return fail.
> 
> static int mtk_iommu_create_mapping(struct device *dev,
> 				    struct of_phandle_args *args)
> {
>         ...
> 	if (!fwspec) {
> 	        ....
> 	} else if (dev_iommu_fwspec_get(dev)->ops != &mtk_iommu_ops) {
>                 >>>>>>>>>>Enter here. return fail.<<<<<<<<<<<<  
> 		return -EINVAL;
> 	}
> 	...
> }
> 
> Thus, Free the existed fwspec if the master device already has fwspec.
> 
> This issue is reported at:
> https://lore.kernel.org/linux-mediatek/trinity-7d9ebdc9-4849-4d93-bfb5-429dcb4ee449-1626253158870@3c-app-gmx-bs01/
> 
> Reported-by: Frank Wunderlich <frank-w@public-files.de>
> Tested-by: Frank Wunderlich <frank-w@public-files.de> # BPI-R2/MT7623
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> Acked-by: Joerg Roedel <jroedel@suse.de>
> Acked-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  drivers/iommu/mtk_iommu_v1.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/iommu/mtk_iommu_v1.c b/drivers/iommu/mtk_iommu_v1.c
> index be22fcf988ce..1467ba1e4417 100644
> --- a/drivers/iommu/mtk_iommu_v1.c
> +++ b/drivers/iommu/mtk_iommu_v1.c
> @@ -425,6 +425,15 @@ static struct iommu_device *mtk_iommu_probe_device(struct device *dev)
>  	struct mtk_iommu_data *data;
>  	int err, idx = 0;
>  
> +	/*
> +	 * In the deferred case, free the existed fwspec.
> +	 * Always initialize the fwspec internally.
> +	 */
> +	if (fwspec) {
> +		iommu_fwspec_free(dev);
> +		fwspec = dev_iommu_fwspec_get(dev);
> +	}
> +
>  	while (!of_parse_phandle_with_args(dev->of_node, "iommus",
>  					   "#iommu-cells",
>  					   idx, &iommu_spec)) {



Thanks,
Mauro
