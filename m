Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 979CF48C1FE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 11:11:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352375AbiALKLL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 05:11:11 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:56004
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1352280AbiALKLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 05:11:10 -0500
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 9A63B3F1EC
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 10:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1641982269;
        bh=hFTGw3RKSwc/q5rISEyTidCT2dMSfG1tgduzWghD4aY=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=jFEJe7hEmSE9lZwlAcn3eurFShVIHucioQDnCZ+vItBeYbbOjFk1eiFRg+Ls+Y6Af
         gYwD8zJ9unK8Jw5iRWcg7uKALOV67ER/Fwl/4hABO7zwBvakGLPt4EvSHToB28eH1b
         RjvxOdeLRaq6oebK3iKzo/KKJVsVFxcYf2JQMslegi9o3ewE7Yn8J8vWoJBABXlphG
         MsHUtMKAmyXEP331ihzZBdrPEbMPwXsPD9BVDUQYnkmdDEU6evATDWKy2hwO3VU7+a
         LQeG8l4FBRFAOYBZYh9r4rKtSq039FZYUP1ZUEb1TDHDJkyVwxvKGgF0zxfXbDw+DT
         LIuupLvpvTBuA==
Received: by mail-ed1-f70.google.com with SMTP id g11-20020a056402090b00b003f8fd1ac475so1862416edz.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 02:11:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=hFTGw3RKSwc/q5rISEyTidCT2dMSfG1tgduzWghD4aY=;
        b=SyQNtcY1NKqWSZaZA4+cdn+5Ndef1GmMiFm3Jgywyuyc68HFgchUt5onmQkIm/YV2r
         I153BBpUk4aBERYEDMgeMkkM5GN8mEvvi4vM+in2gI8OpA2cf+nApP9CVXMcyjwSKGsT
         XlEZO/aGM05BjPHoI5SDxb1KE2mxtVITNc1oOmSQyCktw3JQ4UP58SNeWMEasI+0K5bN
         T+nS5wcjhptAfuaX0YzWp4G6dvbfP8qtb6TobJusku/MK0lH8GcCuT4VPcpMg426R65Z
         JSMJsbd3Hl6I6WrcIj81rAzPRzWuWbn2LH0CzjRyIM+CtOJBGENkT7hP1PUSqnRjDQK6
         ISEw==
X-Gm-Message-State: AOAM533kgqs6gqNmMB6GtlG3xfHlA0pRjDMJ33bNkqmBbfp27P3DGPcZ
        L8KTUNzdZ0P0XiSoiqdvmMMly19Yg8maAPAoSi1F3ttagQ+yyO9TFNiuxjavHwerRjPix922vHI
        RyYP2UZYGU9AFNFJszC/CdM0780tidqxZEhRiu/p6sQ==
X-Received: by 2002:aa7:d60f:: with SMTP id c15mr8344902edr.197.1641982269281;
        Wed, 12 Jan 2022 02:11:09 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzAkZIIY2ouEWvjM2UFpm4JbXirsTAwA2NAyMnQsItvL764zEjLqhJIHuRjBZytND7lxY0dyA==
X-Received: by 2002:aa7:d60f:: with SMTP id c15mr8344880edr.197.1641982269143;
        Wed, 12 Jan 2022 02:11:09 -0800 (PST)
Received: from [192.168.0.29] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id 21sm4338800ejx.83.2022.01.12.02.11.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jan 2022 02:11:08 -0800 (PST)
Message-ID: <82e235d9-4e57-a4e4-66af-84277f9b9da6@canonical.com>
Date:   Wed, 12 Jan 2022 11:11:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v2 1/6] dt-bindings: memory: mtk-smi: Fix larb-id
 dtbs_check warning
Content-Language: en-US
To:     Yong Wu <yong.wu@mediatek.com>, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Tomasz Figa <tfiga@chromium.org>,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, youlin.pei@mediatek.com,
        anan.sun@mediatek.com, lc.kan@mediatek.com, yi.kuo@mediatek.com,
        anthony.huang@mediatek.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
References: <20220111063904.7583-1-yong.wu@mediatek.com>
 <20220111063904.7583-2-yong.wu@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220111063904.7583-2-yong.wu@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/01/2022 07:38, Yong Wu wrote:
> Mute the warning from "make dtbs_check":
> 
> larb@14016000: 'mediatek,larb-id' is a required property
> 	arch/arm64/boot/dts/mediatek/mt8167-pumpkin.dt.yaml
> larb@15001000: 'mediatek,larb-id' is a required property
> 	arch/arm64/boot/dts/mediatek/mt8167-pumpkin.dt.yaml
> larb@16010000: 'mediatek,larb-id' is a required property
> 	arch/arm64/boot/dts/mediatek/mt8167-pumpkin.dt.yaml

Please explain why larb-id is not necessary on mediatek,mt8167-smi-larb.
IOW, what logical error was there (except the dtschema pointed out issue).

> 
> Fixes: 27bb0e42855a ("dt-bindings: memory: mediatek: Convert SMI to DT schema")
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  .../bindings/memory-controllers/mediatek,smi-larb.yaml           | 1 -
>  1 file changed, 1 deletion(-)
> 


Best regards,
Krzysztof
