Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2EBE48AA2C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 10:11:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349152AbiAKJLA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 04:11:00 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:47086 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236757AbiAKJK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 04:10:59 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 7A11E1F41347
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1641892258;
        bh=ZY19t3su5uLFe0/PG24UiwL7zoDt4pgnUUQFZmfGa94=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=fOeZ71A/jtYIdNLUxiVtNnk0hRxeRY1SYP/9rTYI0dnR3ZKcVeYbk3V5xd0mjkPJJ
         ThDZn5u2JOuWTTAwOxojoTeKFPcdX+cwWgitnl7E04FvKTjzKBm1mJo4YzLupMSJep
         LPDiXVnn7Uu4HpYPzNcv3TNoQWnQoq6x13j1kr3sqir2Y34Y+hpNcZtk+ipOCYW5vY
         RrH2kSurnPai+jGenY38etsNX2y4HS+zvF7BGqlNB1Ggwg61LXm3PBFn7UkiSgBMM2
         51nTWWtPvivLlugdNcvQYq2QYEAOcbjHL92N0imWkW7EgnKru59pBrld4YBPP/moS9
         HRdnBCXYw5PlQ==
Subject: Re: [PATCH v2 4/6] memory: mtk-smi: Fix the return value for
 clk_bulk_prepare_enable
To:     Yong Wu <yong.wu@mediatek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
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
        anthony.huang@mediatek.com
References: <20220111063904.7583-1-yong.wu@mediatek.com>
 <20220111063904.7583-5-yong.wu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <00efa277-6475-4f20-f045-443a0706e9e2@collabora.com>
Date:   Tue, 11 Jan 2022 10:10:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20220111063904.7583-5-yong.wu@mediatek.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 11/01/22 07:39, Yong Wu ha scritto:
> The successful return value for clk_bulk_prepare_enable is 0, rather than
> "< 0". Fix this.
> 

Hello! Thanks for this commit!
However, there are a few comments...

This description is a bit confusing, please reword it, something like...

"Function clk_bulk_prepare_enable() returns 0 for success or a negative
number for error. Fix this code style issue."

In any case, you're not fixing any bad logic issue here, as the function
will never return anything > 0.

What you're fixing is a common pattern usage issue, so the Fixes tag can be
removed since it's not really useful to schedule this commit for backport
over older stable versions.


After the requested changes:

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> Fixes: 0e14917c57f9 ("memory: mtk-smi: Use clk_bulk clock ops")
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>   drivers/memory/mtk-smi.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
> index b883dcc0bbfa..e7b1a22b12ea 100644
> --- a/drivers/memory/mtk-smi.c
> +++ b/drivers/memory/mtk-smi.c
> @@ -480,7 +480,7 @@ static int __maybe_unused mtk_smi_larb_resume(struct device *dev)
>   	int ret;
>   
>   	ret = clk_bulk_prepare_enable(larb->smi.clk_num, larb->smi.clks);
> -	if (ret < 0)
> +	if (ret)
>   		return ret;
>   
>   	/* Configure the basic setting for this larb */
> 

