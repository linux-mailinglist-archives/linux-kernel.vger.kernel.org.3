Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F1E24A3F30
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 10:25:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238817AbiAaJZc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 04:25:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238664AbiAaJZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 04:25:18 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5319C061714;
        Mon, 31 Jan 2022 01:25:17 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 9E96B1F42DBC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1643621116;
        bh=fbIVeyjQyhAhoLY74piWBq3+1URHLKGzFfERXylZibQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=G+n3SkiadJcTl8Uqq2gHU6UPyYTCJCZe7c+k6nTg+Y+oZCIgkdqmSAHWpY8W0EiF6
         pwJ3msh30uXexOLmgW47/hr852Sm3Vw4+/yofQhItYYCZrnECur6u/fmN6PaGZwCHQ
         8eEauqSR4Pnd4VMg1PS3+j86GNhxWxjb9HSawRcZGw+YjGmMEEOO8Fkt9nORMLDVK6
         46CeNecPN4m3tA8FfYAuf0mf70jC0f4ouz92sU4Tgp4Da4UAPXpbijXvjDyq2ju9Q5
         mzWXxm5QVDoAioUeUE/hA3KfUBIQxowARZVsfux8Yqbz7P6kpN7cvAgYFEQF713KJ3
         e9qABAggpKHAQ==
Message-ID: <0e430d1e-ee25-1b3d-4a2c-8641db255adb@collabora.com>
Date:   Mon, 31 Jan 2022 10:25:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH 2/2] iommu/mediatek: Add mt8186 iommu support
Content-Language: en-US
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Tomasz Figa <tfiga@chromium.org>,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org,
        Hsin-Yi Wang <hsinyi@chromium.org>, youlin.pei@mediatek.com,
        anan.sun@mediatek.com, xueqi.zhang@mediatek.com,
        yen-chang.chen@mediatek.com, mingyuan.ma@mediatek.com,
        yf.wang@mediatek.com, libo.kang@mediatek.com,
        chengci.xu@mediatek.com, Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Will Deacon <will@kernel.org>
References: <20220125093244.18230-1-yong.wu@mediatek.com>
 <20220125093244.18230-3-yong.wu@mediatek.com>
 <b52a1df8-58f4-baa2-cfb6-9c56244caa0f@collabora.com>
 <01cc69cdf7773962140c01fe37b12ab2c9491c25.camel@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <01cc69cdf7773962140c01fe37b12ab2c9491c25.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 28/01/22 10:39, Yong Wu ha scritto:
> On Thu, 2022-01-27 at 12:28 +0100, AngeloGioacchino Del Regno wrote:
>> Il 25/01/22 10:32, Yong Wu ha scritto:
>>> Add mt8186 iommu supports.
>>>
>>> Signed-off-by: Anan Sun <anan.sun@mediatek.com>
>>> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
>>> ---
>>>    drivers/iommu/mtk_iommu.c | 17 +++++++++++++++++
>>>    1 file changed, 17 insertions(+)
> 
> [snip]
> 
>>>    static const struct mtk_iommu_plat_data mt8192_data = {
>>>    	.m4u_plat       = M4U_MT8192,
>>>    	.flags          = HAS_BCLK | HAS_SUB_COMM_2BITS |
>>> OUT_ORDER_WR_EN |
>>> @@ -1470,6 +1486,7 @@ static const struct of_device_id
>>> mtk_iommu_of_ids[] = {
>>>    	{ .compatible = "mediatek,mt8167-m4u", .data = &mt8167_data},
>>>    	{ .compatible = "mediatek,mt8173-m4u", .data = &mt8173_data},
>>>    	{ .compatible = "mediatek,mt8183-m4u", .data = &mt8183_data},
>>> +	{ .compatible = "mediatek,mt8186-iommu-mm", .data =
>>> &mt8186_data_mm},
>>
>> Hello!
>>
>> Is there any particular reason why this compatible is not
>> "mediatek,mt8186-m4u"?
> 
> There is no special reason. In the previous SoC, We only support MM
> IOMMU, it was called by "m4u". In the lastest SoC, We have the other
> types IOMMU, like for INFRA masters and APU, thus they are called "mm
> iommu", "infra iommu" and "apu iommu". Of course, "m4u" means "mm
> iommu".
> 

I suggest, at this point, to change it to "mediatek,mt8186-m4u" for naming
consistency with the other bindings and to avoid any kind of confusion.

Thank you!

>>
>> Thanks,
>> Angelo
>>
>>>    	{ .compatible = "mediatek,mt8192-m4u", .data = &mt8192_data},
>>>    	{ .compatible = "mediatek,mt8195-iommu-infra", .data =
>>> &mt8195_data_infra},
>>>    	{ .compatible = "mediatek,mt8195-iommu-vdo",   .data =
>>> &mt8195_data_vdo},
>>
>> _______________________________________________
>> Linux-mediatek mailing list
>> Linux-mediatek@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-mediatek
> 

