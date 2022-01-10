Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 600374897D6
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 12:46:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245148AbiAJLqh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 06:46:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244969AbiAJLog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 06:44:36 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C51FC061756;
        Mon, 10 Jan 2022 03:44:36 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 9DDD61F436F1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1641815075;
        bh=bFgbf+SKJkohaV9z0g5mte5KBBwjvSAxwUBFmODWAhw=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=A36shmdnUkCoT+7gAJ2/CGJwPNCabWozqEZZ9fjIIuYwqcVPk/UMBvFRy2be4+kif
         S5I0K/Iwz86gHF8Jgf723v59h823VxwMt7ma+AaJY51gSC9x26au8pPG6FljzkjG3v
         dwuyNHdZJSBxuBW2lzEmTKIlGpsPwZs7qDd24ryylKt0dxtApNGE5kxriJngIilpOz
         aYQFNR6wXZ1X3F5+/9Q4xIj2RaSMJA7ZM9cT9L403tggtJS4BsdvreAtjhW6NDQFWq
         Znx+L7JLG9xCyjCLMxN5vByA+LB15SehaRO0wVwr2Smxl5oSP8kU5aDyL7tjaGkO4t
         TiiGHl+BI6daA==
Subject: Re: [PATCH v2 5/5] iommu/mediatek: Always tlb_flush_all when each PM
 resume
To:     Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
        iommu@lists.linux-foundation.org, Yong Wu <yong.wu@mediatek.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "moderated list:MEDIATEK IOMMU DRIVER" 
        <linux-mediatek@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>, kernel@collabora.com,
        linux-media@vger.kernel.org, sebastian.reichel@collabora.com
References: <20211208120744.2415-1-dafna.hirschfeld@collabora.com>
 <20211208120744.2415-6-dafna.hirschfeld@collabora.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <02719a0f-9725-abc5-f5c4-acbb4bfac08d@collabora.com>
Date:   Mon, 10 Jan 2022 12:44:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211208120744.2415-6-dafna.hirschfeld@collabora.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 08/12/21 13:07, Dafna Hirschfeld ha scritto:
> From: Yong Wu <yong.wu@mediatek.com>
> 
> Prepare for 2 HWs that sharing pgtable in different power-domains.
> 
> When there are 2 M4U HWs, it may has problem in the flush_range in which
> we get the pm_status via the m4u dev, BUT that function don't reflect the
> real power-domain status of the HW since there may be other HW also use
> that power-domain.
> 
> DAM allocation is often done while the allocating device is runtime
> suspended. In such a case the iommu will also be suspended and partial
> flushing of the tlb will not be executed.
> Therefore, we add a tlb_flush_all in the pm_runtime_resume to make
> sure the tlb is always clean.
> 
> In other case, the iommu's power should be active via device
> link with smi.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> [move the call to mtk_iommu_tlb_flush_all to the bottom of resume cb, improve doc/log]
> Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
