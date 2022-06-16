Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE6C654DD3E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 10:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359836AbiFPIqe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 04:46:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359787AbiFPIp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 04:45:59 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DCC95DD02;
        Thu, 16 Jun 2022 01:45:52 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 44EA16601745;
        Thu, 16 Jun 2022 09:45:50 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1655369151;
        bh=3V8ML5nble416YqEnklIe2qV+U/q3IDZwUrctK/WtyU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=jQrHrvQuytaaFWaSqxSHYM0vSS05al78apQ2LJHpDN0hf2dloTBuGpNpWqYBWmsy3
         tyRtoMdES5KqdD1iIQG+xYHTYbN0FGyVjvR4JqmU0olldQRi5BmIAn1CyH8fEFvDQH
         SWB7PyRiC7TiLacNPQhqQ5CIQMP5MO7WYVjfxdztcd3jdY9jmnf9TDAfELy2oE9K4t
         rVbzOokhsQRWjeSq9hl6KWTLDUofWN8quKmI0vWq3LWmVylaz9yAuMk6zxZCYM5rNJ
         fv6bBWLzZ9sAiIFo/uRoG6/qWLVSg1AWwo3rtwOKiPq8Ze0UlJ2cMR+IQtTeKplz1u
         BR2QhjXvcrSnA==
Message-ID: <5bc0a278-6a78-efec-f07b-a990830253f8@collabora.com>
Date:   Thu, 16 Jun 2022 10:45:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 6/6] iommu: mtk_iommu: Lookup phandle to retrieve
 syscon to pericfg
Content-Language: en-US
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     joro@8bytes.org, will@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        iommu@lists.linux-foundation.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        krzysztof.kozlowski@linaro.org
References: <20220609100802.54513-1-angelogioacchino.delregno@collabora.com>
 <20220609100802.54513-7-angelogioacchino.delregno@collabora.com>
 <db422fe4d0b5391ee2aacae989d7e48209e1095f.camel@mediatek.com>
 <80c7fa61-e25a-fc45-bdcb-60ac3796b96e@collabora.com>
 <2d0f49294a8bac34dd5dd1ce4201f009a207b7a7.camel@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <2d0f49294a8bac34dd5dd1ce4201f009a207b7a7.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 16/06/22 08:30, Yong Wu ha scritto:
> On Mon, 2022-06-13 at 10:13 +0200, AngeloGioacchino Del Regno wrote:
>> Il 13/06/22 07:32, Yong Wu ha scritto:
>>> On Thu, 2022-06-09 at 12:08 +0200, AngeloGioacchino Del Regno
>>> wrote:
>>>> On some SoCs (of which only MT8195 is supported at the time of
>>>> writing),
>>>> the "R" and "W" (I/O) enable bits for the IOMMUs are in the
>>>> pericfg_ao
>>>> register space and not in the IOMMU space: as it happened already
>>>> with
>>>> infracfg, it is expected that this list will grow.
>>>
>>> Currently I don't see the list will grow. As commented before, In
>>> the
>>> lastest SoC, The IOMMU enable bits for IOMMU will be in ATF, rather
>>> than in this pericfg register region. In this case, Is this patch
>>> unnecessary? or we could add this patch when there are 2 SoCs use
>>> this
>>> setting at least?  what's your opinion?
>>>
>>
>> Perhaps I've misunderstood... besides, can you please check if
>> there's any
>> other SoC (not just chromebooks, also smartphone SoCs) that need this
>> logic?
> 
> As far as I know, SmartPhone SoCs don't enable the infra iommu until
> now. they don't have this logic. I don't object this patch, I think we
> could add it when at least 2 SoCs need this.
> 
> Thanks very much for help improving here.
> 

Many thanks for checking that! Now that everything is clear, I can safely
go on with pushing a v4 of this series.

Thanks again!
Angelo
