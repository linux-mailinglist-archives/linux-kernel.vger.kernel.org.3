Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2A7348ABF4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 11:58:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238096AbiAKK6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 05:58:02 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:48566 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349412AbiAKK5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 05:57:52 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 790DD1F43A3B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1641898671;
        bh=KxdiyTxbtyGUISJQVKvbV00ATKClSLfkB7WwAzdixIk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=GHv2Q9Hw9O1BbymA6bPBFesiEoq1kePtT66PJ1DjL9T0Lyuw7pmEQejYX27zrEz4u
         KhuGOzv6vfpDCj5CFrlLnkHBLvzkie3LTBvtrB16YGEWmRcK/Bb2hzvlZVkXsnrFML
         iNuniQCr123u7ZPxvdmcegl9TU+3TZrthSVp7dxcsRMQ/9BZl2LREPItzri5GxaZkm
         /WHSAxGZI10qwOxlOJSRyKR/BAco+r212N+f+NrpdwlLsuvMd58CuxENW+9OLhpIjG
         Rd277bNW5X4zdn5WskZtet5CNVidobI8eHXVog2CXJQkuYeC57x3eV1/JA61Xbmop0
         jQiPE2Mahk5rQ==
Subject: Re: [PATCH v9 05/15] iommu/mediatek: Add device_link between the
 consumer and the larb devices
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
 <20211112105509.12010-6-yong.wu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <cb4054ae-4646-ee61-162f-96112ef6dbcf@collabora.com>
Date:   Tue, 11 Jan 2022 11:57:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211112105509.12010-6-yong.wu@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 12/11/21 11:54, Yong Wu ha scritto:
> MediaTek IOMMU-SMI diagram is like below. all the consumer connect with
> smi-larb, then connect with smi-common.
> 
>          M4U
>           |
>      smi-common
>           |
>    -------------
>    |         |    ...
>    |         |
> larb1     larb2
>    |         |
> vdec       venc
> 
> When the consumer works, it should enable the smi-larb's power which
> also need enable the smi-common's power firstly.
> 
> Thus, First of all, use the device link connect the consumer and the
> smi-larbs. then add device link between the smi-larb and smi-common.
> 
> This patch adds device_link between the consumer and the larbs.
> 
> When device_link_add, I add the flag DL_FLAG_STATELESS to avoid calling
> pm_runtime_xx to keep the original status of clocks. It can avoid two
> issues:
> 1) Display HW show fastlogo abnormally reported in [1]. At the beggining,
> all the clocks are enabled before entering kernel, but the clocks for
> display HW(always in larb0) will be gated after clk_enable and clk_disable
> called from device_link_add(->pm_runtime_resume) and rpm_idle. The clock
> operation happened before display driver probe. At that time, the display
> HW will be abnormal.
> 
> 2) A deadlock issue reported in [2]. Use DL_FLAG_STATELESS to skip
> pm_runtime_xx to avoid the deadlock.
> 
> Corresponding, DL_FLAG_AUTOREMOVE_CONSUMER can't be added, then
> device_link_removed should be added explicitly.
> 
> Meanwhile, Currently we don't have a device connect with 2 larbs at the
> same time. Disallow this case, print the error log.
> 
> [1] https://lore.kernel.org/linux-mediatek/1564213888.22908.4.camel@mhfsdcap03/
> [2] https://lore.kernel.org/patchwork/patch/1086569/
> 
> Suggested-by: Tomasz Figa <tfiga@chromium.org>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> Tested-by: Frank Wunderlich <frank-w@public-files.de> # BPI-R2/MT7623

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

