Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45DC74BB473
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 09:41:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232776AbiBRImF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 03:42:05 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232748AbiBRImA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 03:42:00 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD1B6275AFC;
        Fri, 18 Feb 2022 00:41:42 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 3F9AD1F4417B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1645173701;
        bh=y1MQQgamboxKWXR250aZ3v7J3tHKl044R2X9kxvJNdI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=hryznIMs6S1YAgP5BqLwjtosco6cTHMhj8+u3FKZgapd5mLfncU7NthBVXO5JlV/K
         uV3Y2xOjmgTMbN71Usw1XA6qLIlGbCLHg7Fb/4CxzQPdFGiVwcPLyhRRsp6xas6EoI
         rt0DZ24LBHflRQEkcdLvCH4JYZwN/yFYchX0c96GaOHzYoroYIwuzhc7JrEXdNR4xQ
         mqCZ1Ld8DDobZ6EniAvDXDGa6GjGor8eXqWhKJpOJi37BCg2wFuhw1lgfVW8BxIdr2
         ZBCDZUBjSN/xOmGmP9h8SO3jzWdulFseuCCj71qC4MnDJ8jv40LOK/caehosqx4iKM
         ZoQfCXpD9PUbQ==
Message-ID: <a4e66e61-35c4-adb5-fb65-e1f076bbe6ba@collabora.com>
Date:   Fri, 18 Feb 2022 09:41:37 +0100
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
 <0e430d1e-ee25-1b3d-4a2c-8641db255adb@collabora.com>
 <8b63983222a4a304586a7b880379fcf4a7036c4a.camel@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <8b63983222a4a304586a7b880379fcf4a7036c4a.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 18/02/22 04:32, Yong Wu ha scritto:
> On Mon, 2022-01-31 at 10:25 +0100, AngeloGioacchino Del Regno wrote:
>> Il 28/01/22 10:39, Yong Wu ha scritto:
>>> On Thu, 2022-01-27 at 12:28 +0100, AngeloGioacchino Del Regno
>>> wrote:
>>>> Il 25/01/22 10:32, Yong Wu ha scritto:
>>>>> Add mt8186 iommu supports.
>>>>>
>>>>> Signed-off-by: Anan Sun <anan.sun@mediatek.com>
>>>>> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
>>>>> ---
>>>>>     drivers/iommu/mtk_iommu.c | 17 +++++++++++++++++
>>>>>     1 file changed, 17 insertions(+)
>>>
>>> [snip]
>>>
>>>>>     static const struct mtk_iommu_plat_data mt8192_data = {
>>>>>     	.m4u_plat       = M4U_MT8192,
>>>>>     	.flags          = HAS_BCLK | HAS_SUB_COMM_2BITS |
>>>>> OUT_ORDER_WR_EN |
>>>>> @@ -1470,6 +1486,7 @@ static const struct of_device_id
>>>>> mtk_iommu_of_ids[] = {
>>>>>     	{ .compatible = "mediatek,mt8167-m4u", .data =
>>>>> &mt8167_data},
>>>>>     	{ .compatible = "mediatek,mt8173-m4u", .data =
>>>>> &mt8173_data},
>>>>>     	{ .compatible = "mediatek,mt8183-m4u", .data =
>>>>> &mt8183_data},
>>>>> +	{ .compatible = "mediatek,mt8186-iommu-mm", .data =
>>>>> &mt8186_data_mm},
>>>>
>>>> Hello!
>>>>
>>>> Is there any particular reason why this compatible is not
>>>> "mediatek,mt8186-m4u"?
>>>
>>> There is no special reason. In the previous SoC, We only support MM
>>> IOMMU, it was called by "m4u". In the lastest SoC, We have the
>>> other
>>> types IOMMU, like for INFRA masters and APU, thus they are called
>>> "mm
>>> iommu", "infra iommu" and "apu iommu". Of course, "m4u" means "mm
>>> iommu".
>>>
>>
>> I suggest, at this point, to change it to "mediatek,mt8186-m4u" for
>> naming
>> consistency with the other bindings and to avoid any kind of
>> confusion.
> 
> Understand. But we don't call it "m4u" anymore. I'd not like to use a
> outdated name. For readable, I could add a comment like this:
> 
> { .compatible = "mediatek,mt8186-iommu-mm", xx}, /* iommu-mm: m4u */
> 
> Is this ok for you?
> Thanks.
> 

Ok, go on with that.

Cheers,
Angelo

>> Thank you!
>>
>>>>
>>>> Thanks,
>>>> Angelo
>>>>
>>>>>     	{ .compatible = "mediatek,mt8192-m4u", .data =
>>>>> &mt8192_data},
>>>>>     	{ .compatible = "mediatek,mt8195-iommu-infra", .data =
>>>>> &mt8195_data_infra},
>>>>>     	{ .compatible = "mediatek,mt8195-iommu-vdo",   .data =
>>>>> &mt8195_data_vdo},
>>>>
>>>> _______________________________________________
>>>> Linux-mediatek mailing list
>>>> Linux-mediatek@lists.infradead.org
>>>> http://lists.infradead.org/mailman/listinfo/linux-mediatek
>>
>>
> 

