Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC3194BFC34
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 16:17:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231300AbiBVPRZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 10:17:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233313AbiBVPRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 10:17:21 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE0F32A721;
        Tue, 22 Feb 2022 07:16:53 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 1402E1F42D79
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1645543012;
        bh=m6iks4nKShpjnvSQCg9oNY965h9zeoboZznnHfhpxKI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=hWvPkhkzNvqzNuA/40T3XKUxHYa8HSRU4pVMNzoIFWC7rXAT0apDYLnpkMJhnqbJM
         arssexAyQVcSVzvw5Amf+UBgH8G+8JAoeSIFcUxhxPNyzQMNZV+16CstcTP/iDH5Hg
         8XKAw2ROpBcy+hVlpJZNGroDpoRV/m8w9fVh/Yl0wVhuV6RPtUoYvkLuG/iZUukwGC
         bAX9ZZ15SJkfiUYauqLfQv5HFCFnR47Rx3FLe1eOLehFQPIJKIeNvBPRO6NReiqME2
         u+ne7v0rhJH3lU010TKtdqa7o08BP9WgUrRIeePPFQWufHuOtvUjuDVVM8Ex9z5m24
         I22HEnZSbhtaw==
Message-ID: <1c791b60-935c-1e8e-dd1b-4b18fc273c1b@collabora.com>
Date:   Tue, 22 Feb 2022 16:16:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v8 04/19] video/hdmi: Add audio_infoframe packing for DP
Content-Language: en-US
To:     Guillaume Ranquet <granquet@baylibre.com>, chunkuang.hu@kernel.org,
        p.zabel@pengutronix.de, airlied@linux.ie, daniel@ffwll.ch,
        robh+dt@kernel.org, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, tzimmermann@suse.de, matthias.bgg@gmail.com,
        chunfeng.yun@mediatek.com, kishon@ti.com, vkoul@kernel.org,
        deller@gmx.de, ck.hu@mediatek.com, jitao.shi@mediatek.com
Cc:     dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org, linux-fbdev@vger.kernel.org,
        Markus Schneider-Pargmann <msp@baylibre.com>
References: <20220218145437.18563-1-granquet@baylibre.com>
 <20220218145437.18563-5-granquet@baylibre.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220218145437.18563-5-granquet@baylibre.com>
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

Il 18/02/22 15:54, Guillaume Ranquet ha scritto:
> From: Markus Schneider-Pargmann <msp@baylibre.com>
> 
> Similar to HDMI, DP uses audio infoframes as well which are structured
> very similar to the HDMI ones.
> 
> This patch adds a helper function to pack the HDMI audio infoframe for
> DP, called hdmi_audio_infoframe_pack_for_dp().
> hdmi_audio_infoframe_pack_only() is split into two parts. One of them
> packs the payload only and can be used for HDMI and DP.
> 
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>

Hello Guillaume,

I've just noticed that this patch will not apply against the latest linux-next,
as the include/drm/drm_dp_helper.h header was moved to
include/drm/dp/drm_dp_helper.h

Can you please rebase for v9?

Thanks,
Angelo

> ---
>   drivers/video/hdmi.c        | 83 ++++++++++++++++++++++++++++---------
>   include/drm/drm_dp_helper.h |  2 +
>   include/linux/hdmi.h        |  7 +++-
>   3 files changed, 72 insertions(+), 20 deletions(-)
> 
