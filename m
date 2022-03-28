Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B06E4E8FCB
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 10:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239148AbiC1ILn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 04:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236254AbiC1ILl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 04:11:41 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 726D6527D2;
        Mon, 28 Mar 2022 01:10:01 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 0E96B1F430E3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1648455000;
        bh=/nWwqk3sPy6vmwVbxGTUip5rp6cQqefeecpSJO7M4VU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=UiJeHcrb22+gxlwFAcWUPiZHHp8/logMJ7mTY54Dc1dhEE8gp3W9RL0O7G2CeQXbV
         gIqH3zqEye8pXt/cRvpTwr9+Q8OjU5Dx0heK90tYwCh0FG6ooKJCrPf7lDXXZpsFOU
         iwY+2LC5L/DGNeGUnoN9ihJH5wnjerx0CcCMLOPISGODK27sNNctav+XfeXXZnT9LJ
         CHFwHtVxRjUBayuSZAllKSy96pw17v1+oZgJF5zYl3SpZC9S5LcITyy6uM2G5QoBXJ
         hgfBsPl3nn+kuliZ6N1Fg1z4XIIGmoYOMwZlhuvbmsSXO3z/csC/LfIC/IJsyFz+yx
         8fyq0INsI78aQ==
Message-ID: <33212024-ae93-32c3-7890-09006057ff49@collabora.com>
Date:   Mon, 28 Mar 2022 10:09:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v9 06/22] video/hdmi: Add audio_infoframe packing for DP
Content-Language: en-US
To:     Guillaume Ranquet <granquet@baylibre.com>, airlied@linux.ie,
        chunfeng.yun@mediatek.com, chunkuang.hu@kernel.org,
        ck.hu@mediatek.com, daniel@ffwll.ch, deller@gmx.de,
        jitao.shi@mediatek.com, kishon@ti.com, krzk+dt@kernel.org,
        maarten.lankhorst@linux.intel.com, matthias.bgg@gmail.com,
        mripard@kernel.org, p.zabel@pengutronix.de, robh+dt@kernel.org,
        tzimmermann@suse.de, vkoul@kernel.org
Cc:     devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-phy@lists.infradead.org, markyacoub@google.com,
        Markus Schneider-Pargmann <msp@baylibre.com>
References: <20220327223927.20848-1-granquet@baylibre.com>
 <20220327223927.20848-7-granquet@baylibre.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220327223927.20848-7-granquet@baylibre.com>
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

Il 28/03/22 00:39, Guillaume Ranquet ha scritto:
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
> ---
>   drivers/video/hdmi.c           | 82 ++++++++++++++++++++++++++--------
>   include/drm/dp/drm_dp_helper.h |  2 +
>   include/linux/hdmi.h           |  7 ++-
>   3 files changed, 71 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/video/hdmi.c b/drivers/video/hdmi.c
> index 947be761dfa4..5f50237554ed 100644
> --- a/drivers/video/hdmi.c
> +++ b/drivers/video/hdmi.c
> @@ -21,6 +21,7 @@
>    * DEALINGS IN THE SOFTWARE.
>    */
>   
> +#include <drm/dp/drm_dp_helper.h>
>   #include <linux/bitops.h>
>   #include <linux/bug.h>
>   #include <linux/errno.h>
> @@ -381,12 +382,34 @@ static int hdmi_audio_infoframe_check_only(const struct hdmi_audio_infoframe *fr
>    *
>    * Returns 0 on success or a negative error code on failure.
>    */
> -int hdmi_audio_infoframe_check(struct hdmi_audio_infoframe *frame)
> +int hdmi_audio_infoframe_check(const struct hdmi_audio_infoframe *frame)

I agree with this change, as hdmi_audio_infoframe_check_only()'s param is a const,
but you really should mention that you're constifying this one in your commit
description, or do that in a separate commit.

Either of the two is fine.

Regards,
Angelo
