Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22A924845A1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 16:56:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235268AbiADPz7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 10:55:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235345AbiADPzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 10:55:45 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91450C06139B;
        Tue,  4 Jan 2022 07:55:44 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 7B7DE1F43593
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1641311743;
        bh=upNEy1clIYcieEGkiHOyHnuE/MQhUsIdtvTzDimiz1s=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=V82sh8VWBO3wAJ+QOR8LOcH9EIWvCTmuyD2qd+snO29gmBATlO2D8yuxJeVR72uCT
         bQl8zAYDqIFzx5ez1wBEjI8COPnUhuLwxc5iox7C4JDh+6Z/Gb3VYkB9PPKiXA9KA7
         l9oGspH0ttOhoGDeMyqWSvDVylcU/mrr9ote+Usp7DKFo4NlYs1nsiDYCoJN8VBW4r
         +DmW5l+zdXInZcJxLb8LT8PHn3xdomfL5cG3Ec5F0lXJVJyw13xiWlSsL1Kse5z3uX
         2ba7tzfCA1MWgaE/RzOEso3yMSEWv6FCi2ilrCn4s8Y3mPZxcU2Yh794u4L4aEBwes
         PpqjD6VlLUNpw==
Subject: Re: [PATCH v3 12/33] iommu/mediatek: Always tlb_flush_all when each
 PM resume
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
 <20210923115840.17813-13-yong.wu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <5228acea-3bf4-987a-caaf-11b90aa0beae@collabora.com>
Date:   Tue, 4 Jan 2022 16:55:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210923115840.17813-13-yong.wu@mediatek.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 23/09/21 13:58, Yong Wu ha scritto:
> Prepare for 2 HWs that sharing pgtable in different power-domains.
> 
> When there are 2 M4U HWs, it may has problem in the flush_range in which
> we get the pm_status via the m4u dev, BUT that function don't reflect the
> real power-domain status of the HW since there may be other HW also use
> that power-domain.
> 
> The function dma_alloc_attrs help allocate the iommu buffer which
> need the corresponding power domain since tlb flush is needed when
> preparing iova. BUT this function only is for allocating buffer,
> we have no good reason to request the user always call pm_runtime_get
> before calling dma_alloc_xxx. Therefore, we add a tlb_flush_all
> in the pm_runtime_resume to make sure the tlb always is clean.
> 
> Another solution is always call pm_runtime_get in the tlb_flush_range.
> This will trigger pm runtime resume/backup so often when the iommu
> power is not active at some time(means user don't call pm_runtime_get
> before calling dma_alloc_xxx), This may cause the performance drop.
> thus we don't use this.
> 
> In other case, the iommu's power should always be active via device
> link with smi.
> 
> The previous SoC don't have PM except mt8192. the mt8192 IOMMU is display's
> power-domain which nearly always is enabled. thus no need fix tags here.
> Prepare for mt8195.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


