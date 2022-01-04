Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 575CD484555
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 16:54:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233511AbiADPy0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 10:54:26 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:33104 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232209AbiADPyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 10:54:25 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 5FF1A1F43593
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1641311664;
        bh=z8b4JgrEINeDdHaIUQNnWliGF0ifNcQlBrAvNR4lIjA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=RIApkZCMkaFcib0aBu9CH9SoagjUf5BxhxJF4rMLq9d8min2nzflzYPa4uPoCn6Bz
         xQtr2frS8nyypu+J5vauINYYcwtNZA3CJ9SzP7gmHS2YTTWR9qyRTyBnl+LojUmG1S
         t6K7SXfjZ1LwtD6QCJPb41VsanF6DZrzmQJB1eIPniiBMHkdLzykaThTLtCd3O6IEY
         WYh2OaowGW6mYrkQmK3qzAfWT6XtHQiHOUrC71BUx4eVdPDo4DMknqv8L5gw31fQgY
         NY9U4jmNYy8qxqW6x1j1/hV25zioi207s+3xItCCFFBRKzBvXByWQnPmp6tDVtskmg
         g0iPgonHSmZuQ==
Subject: Re: [PATCH v3 27/33] iommu/mediatek: Initialise bank HW for each a
 bank
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
 <20210923115840.17813-28-yong.wu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <af588804-041c-b382-e5e4-4dfd0506b439@collabora.com>
Date:   Tue, 4 Jan 2022 16:54:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210923115840.17813-28-yong.wu@mediatek.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 23/09/21 13:58, Yong Wu ha scritto:
> The mt8195 IOMMU HW max support 5 banks, and regarding the banks'
> registers, it looks like:
> 
>   ----------------------------------------
>   |bank0  | bank1 | bank2 | bank3 | bank4|
>   ----------------------------------------
>   |global |
>   |control|         null
>   |regs   |
>   -----------------------------------------
>   |bank   |bank   |bank   |bank   |bank   |
>   |regs   |regs   |regs   |regs   |regs   |
>   |       |       |       |       |       |
>   -----------------------------------------
> 
> Each bank has some special bank registers and it share bank0's global
> control registers. this patch initialise the bank hw with the bankid.
> 
> In the hw_init, we always initialise bank0's control register since
> we don't know if the bank0 is initialised.
> 
> Additionally, About each bank's register base, always delta 0x1000.
> like bank[x + 1] = bank[x] + 0x1000.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>


Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


