Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 814AD484592
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 16:55:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235426AbiADPzf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 10:55:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235224AbiADPzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 10:55:15 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DFD6C061799;
        Tue,  4 Jan 2022 07:55:14 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id F32151F43595
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1641311712;
        bh=/8hS6LpwGBUUv6Bdwdpig6occOMefCCzy4ycInHjP4Q=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=MoyPcKM2zPie6sqOy7lKuFui5mjX8ibrAJNvWl3ML2rKF48WLGkJWcUO0Z4s4C9G2
         uAn187S3kPvHaqvHtjqerxZ09KdgZxj5BWxADGZ6LiHC7kHWAT3EceohFOIjQOIH0j
         53kdiXPAxeujVFJeEkRaTJ204HUuQtJBIi7xubo2GS2WQWO0YAI87QGDrCwovh1H8D
         yhI05ILRgCxcmbMwFuzRpqts1hZs+b03uPpJsKlyJ0iolooNCmUu0I94DYHHs+/Euh
         0oJ5JwvVlBIV6yBHoVyHvJuFLT/4Dd88nVUEj6/Zoe+6M+xi3AqH2hlNRDj1EnMYB7
         LsFQLlUCm4HMw==
Subject: Re: [PATCH v3 04/33] iommu/mediatek: Remove clk_disable in
 mtk_iommu_remove
To:     Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Tomasz Figa <tfiga@chromium.org>,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org,
        Hsin-Yi Wang <hsinyi@chromium.org>, youlin.pei@mediatek.com,
        anan.sun@mediatek.com, chao.hao@mediatek.com,
        yen-chang.chen@mediatek.com
References: <20210923115840.17813-1-yong.wu@mediatek.com>
 <20210923115840.17813-5-yong.wu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <f18d8bc0-f6da-9c20-941f-3880ff0d60fb@collabora.com>
Date:   Tue, 4 Jan 2022 16:55:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210923115840.17813-5-yong.wu@mediatek.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 23/09/21 13:58, Yong Wu ha scritto:
> After the commit b34ea31fe013 ("iommu/mediatek: Always enable the clk on
> resume"), the iommu clock is controlled by the runtime callback.
> thus remove the clk control in the mtk_iommu_remove.
> 
> Otherwise, it will warning like:
> 
> echo 14018000.iommu > /sys/bus/platform/drivers/mtk-iommu/unbind
> 
> [   51.413044] ------------[ cut here ]------------
> [   51.413648] vpp0_smi_iommu already disabled
> [   51.414233] WARNING: CPU: 2 PID: 157 at */v5.15-rc1/kernel/mediatek/
>                            drivers/clk/clk.c:952 clk_core_disable+0xb0/0xb8
> [   51.417174] Hardware name: MT8195V/C(ENG) (DT)
> [   51.418635] pc : clk_core_disable+0xb0/0xb8
> [   51.419177] lr : clk_core_disable+0xb0/0xb8
> ...
> [   51.429375] Call trace:
> [   51.429694]  clk_core_disable+0xb0/0xb8
> [   51.430193]  clk_core_disable_lock+0x24/0x40
> [   51.430745]  clk_disable+0x20/0x30
> [   51.431189]  mtk_iommu_remove+0x58/0x118
> [   51.431705]  platform_remove+0x28/0x60
> [   51.432197]  device_release_driver_internal+0x110/0x1f0
> [   51.432873]  device_driver_detach+0x18/0x28
> [   51.433418]  unbind_store+0xd4/0x108
> [   51.433886]  drv_attr_store+0x24/0x38
> [   51.434363]  sysfs_kf_write+0x40/0x58
> [   51.434843]  kernfs_fop_write_iter+0x164/0x1e0
> 
> Fixes: b34ea31fe013 ("iommu/mediatek: Always enable the clk on resume")
> Reported-by: Hsin-Yi Wang <hsinyi@chromium.org>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

