Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18C6348ABFA
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 11:58:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238174AbiAKK6E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 05:58:04 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:48594 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349419AbiAKK5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 05:57:53 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 53B6C1F43A3E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1641898672;
        bh=aSvQDDZiVNuGLK0+g5pmKJt4zz1QTtvk8bu0eYABcYE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=RRn+gK/K6Oe8djLMwl7E0Zru4jSSkxXRUnWQAAfuLZ0AiA2fLNRpLyLimSJNIhMtu
         GbCmYibe3IdiVyevThwQNpRh3KXcNGbfn7j01ofTIwJnEZPN+qORhigdQ1iVcg8nuS
         ZON68CYWhNbbK5oABT+8xs7E9Oa1MWcR2JGP5Ca0LTcwd+YSk54BB4Kg+Jvof5vkRI
         KzK0frlA9SUROFZNEy2aduPWb5c4FqbSQVdv4RPrj69rUl14uTz3hOMqtH/l+MnsL2
         j7/wUm/JmNhovDWBm9IYHFOnL+5nul/9tnRNeWUnNgejZYTwTHVe0t2PjmYKrTa4Vh
         NmwUYMSMA4pBg==
Subject: Re: [PATCH v9 04/15] iommu/mediatek: Add probe_defer for smi-larb
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
 <20211112105509.12010-5-yong.wu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <eaf59017-49d2-6579-a106-44bd2a21e5af@collabora.com>
Date:   Tue, 11 Jan 2022 11:57:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211112105509.12010-5-yong.wu@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 12/11/21 11:54, Yong Wu ha scritto:
> Prepare for adding device_link.
> 
> The iommu consumer should use device_link to connect with the
> smi-larb(supplier). then the smi-larb should run before the iommu
> consumer. Here we delay the iommu driver until the smi driver is ready,
> then all the iommu consumers always are after the smi driver.
> 
> When there is no this patch, if some consumer drivers run before
> smi-larb, the supplier link_status is DL_DEV_NO_DRIVER(0) in the
> device_link_add, then device_links_driver_bound will use WARN_ON
> to complain that the link_status of supplier is not right.
> 
> device_is_bound may be more elegant here. but it is not allowed to
> EXPORT from https://lore.kernel.org/patchwork/patch/1334670/.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> Tested-by: Frank Wunderlich <frank-w@public-files.de> # BPI-R2/MT7623

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

