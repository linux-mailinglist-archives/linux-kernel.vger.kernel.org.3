Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE4F2575084
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 16:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232304AbiGNONU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 10:13:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239185AbiGNONI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 10:13:08 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3380F57265;
        Thu, 14 Jul 2022 07:13:07 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B6EFC6601A3B;
        Thu, 14 Jul 2022 15:13:04 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1657807985;
        bh=K1pAx4yUym6fPpWmvpm8rAcGNbLZfMNPgYQz3MOq/KM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=KkuVebcLx9P3YNSG5CYljp9B98IOxqVxAVxR3Z5DXxVLFCO+yM9qMTKuKQxVkUg0x
         pxpEm2JYS8pt7RkXL8eG4YquZ2Q/pIF3pUQ9QIpecnHutC6jxUFr4mIyJplFhnpAma
         AKqpbRQh/9D5UXVYx79cdq5cynV3pV8Q/Nk9xehoS4cucN25RG8a0HNRaWpdipcs2R
         PeOV6P3gCzUcTCi22FNwHoG+fgblDAhXkGhVr9pPito0xY66ujKkrbRY8Jlh183eQy
         wvUmwpMItZTzcRGfLOgoK9qXCmwUM154IToVD4OsPNoHHiXfMJc540R5WZdVutvGK/
         LYYyPSkRARddw==
Message-ID: <6991dcc6-5902-a9ed-78c4-c7bd4f60f91c@collabora.com>
Date:   Thu, 14 Jul 2022 16:13:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v9 5/8] ASoC: mediatek: mt8186: add machine driver with
 mt6366, da7219 and max98357
Content-Language: en-US
To:     Jiaxin Yu <jiaxin.yu@mediatek.com>, broonie@kernel.org,
        robh+dt@kernel.org
Cc:     aaronyu@google.com, matthias.bgg@gmail.com, trevor.wu@mediatek.com,
        tzungbi@google.com, julianbraha@gmail.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220712150442.32504-1-jiaxin.yu@mediatek.com>
 <20220712150442.32504-6-jiaxin.yu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220712150442.32504-6-jiaxin.yu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 12/07/22 17:04, Jiaxin Yu ha scritto:
> Add support for mt8186 board with mt6366, da7219 and max98357.
> 
> Signed-off-by: Jiaxin Yu <jiaxin.yu@mediatek.com>
> ---
>   sound/soc/mediatek/Kconfig                    |   16 +
>   sound/soc/mediatek/mt8186/Makefile            |    1 +
>   .../mt8186/mt8186-mt6366-da7219-max98357.c    | 1002 +++++++++++++++++
>   3 files changed, 1019 insertions(+)
>   create mode 100644 sound/soc/mediatek/mt8186/mt8186-mt6366-da7219-max98357.c
> 

> +
> +static int mt8186_mt6366_da7219_max98357_dev_probe(struct platform_device *pdev)
> +{
> +	struct snd_soc_card *card;
> +	struct snd_soc_dai_link *dai_link;
> +	struct mt8186_mt6366_da7219_max98357_priv *priv;
> +	struct device_node *platform_node, *headset_codec, *playback_codec;
> +	int ret, i;
> +
> +	card = (struct snd_soc_card *)of_device_get_match_data(&pdev->dev);

You don't really need this cast, plus, you can use device_get_match_data() instead.

After that:

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
