Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2471848AC06
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 11:58:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349596AbiAKK6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 05:58:14 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:48648 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349440AbiAKK54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 05:57:56 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 9E9241F43A23
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1641898675;
        bh=wGR7oi2bLZenrRXTXE28i4i6d2Ekxsg5WZGuvas3jHY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Elc7ksex3MqC7VFRbmEfNUXzNvwhk3UEccDOC/u1znbgRXDZTYLQdp/SSiOJ5SEAs
         1KmcNwdqFZFAJDabwwHyatfRD2zhbhAguiP1XMOqqBDB3qeFl7V1OHP3VBZ/jvitd4
         6+MgYh6T+cbVegQp6IxnBOF+F95uaD4zdLm3d1lalgGHMCcec+egpC8Fbk/+jEW8dp
         qffAVj3LFRjOTVG7Imi1WW9tlZVKBcd+ux0un1J7gGzXYV8ADM3uzotHqlFQ+v7hGS
         T14MeN/OpRqSiQ+UceKM2Zv0VP7lHG/fD3ibwIs1PyI7Isl0VgfMgbAIJolt18vMOg
         m2gaQsbvPNOtQ==
Subject: Re: [PATCH v9 02/15] iommu/mediatek-v1: Free the existed fwspec if
 the master dev already has
To:     Yong Wu <yong.wu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        David Airlie <airlied@linux.ie>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        dri-devel@lists.freedesktop.org, yf.wang@mediatek.com,
        anthony.huang@mediatek.com, youlin.pei@mediatek.com,
        Evan Green <evgreen@chromium.org>,
        Eizan Miyamoto <eizan@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        linux-arm-kernel@lists.infradead.org, mingyuan.ma@mediatek.com,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        Philipp Zabel <p.zabel@pengutronix.de>, libo.kang@mediatek.com,
        yi.kuo@mediatek.com, linux-mediatek@lists.infradead.org,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Tiffany Lin <tiffany.lin@mediatek.com>, anan.sun@mediatek.com,
        srv_heupstream@mediatek.com, acourbot@chromium.org,
        linux-kernel@vger.kernel.org, Tomasz Figa <tfiga@chromium.org>,
        iommu@lists.linux-foundation.org, Daniel Vetter <daniel@ffwll.ch>,
        Robin Murphy <robin.murphy@arm.com>
References: <20211112105509.12010-1-yong.wu@mediatek.com>
 <20211112105509.12010-3-yong.wu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <db984e48-a0fc-0802-0ce6-69d542c08771@collabora.com>
Date:   Tue, 11 Jan 2022 11:57:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211112105509.12010-3-yong.wu@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 12/11/21 11:54, Yong Wu ha scritto:
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
>          ...
> 	if (!fwspec) {
> 	        ....
> 	} else if (dev_iommu_fwspec_get(dev)->ops != &mtk_iommu_ops) {
>                  >>>>>>>>>>Enter here. return fail.<<<<<<<<<<<<
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

Acked-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

