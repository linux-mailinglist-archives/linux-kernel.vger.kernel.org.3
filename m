Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDBC9485155
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 11:45:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235175AbiAEKpG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 05:45:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234927AbiAEKpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 05:45:05 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC272C061761
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 02:45:05 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 5D6B31F444D6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1641379504;
        bh=j5jKYJLd2HHKiewIUKNMRt+js9u9s0ejQWXJ1s60ryk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=BOyoPyVKMtE0zA0Cc1bsSHidcURJQGgB54S3tqNbWy+/3DAigDdUmHz0JNJueMiUx
         DM4ttHr38VthFPfpAMHfdZiiibAln9cd3JP5/Gzd2PbbPtg8+mJ6gWKut30fbz41QY
         kUD/MNRiEqthNTLWYqIBqtCRT+7PPw2OV0zQcxKP36uweA8bClsHIJgUC1Qb8Ol8BZ
         AnyKZLDlYWqqe45OAHoRKmrVTJCW+YP+YIqr17F76/6OOyJklyKmjsy/miOoEIhksX
         BKW+Brk0JAY8rhA7q679hcI026p42Ga9VkacyOlAcdTOrOVBIGsGmp20ju4/lBwVlT
         nAFzQ7zZGtiZA==
Subject: Re: [PATCH v10] drm/bridge: add it6505 driver
To:     allen <allen.chen@ite.com.tw>
Cc:     Hsin-Yi Wang <hsinyi@google.com>,
        Jau-Chih Tseng <Jau-Chih.Tseng@ite.com.tw>,
        Kenneth Hung <Kenneth.Hung@ite.com.tw>,
        Hermes Wu <Hermes.Wu@ite.com.tw>,
        Hsin-yi Wang <hsinyi@chromium.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
References: <20211014033031.38459-1-allen.chen@ite.com.tw>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <9513a22c-5b84-88d9-ff5d-ac071df53ba3@collabora.com>
Date:   Wed, 5 Jan 2022 11:45:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211014033031.38459-1-allen.chen@ite.com.tw>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 14/10/21 05:30, allen ha scritto:
> This adds support for the iTE IT6505.
> This device can convert DPI signal to DP output.
> 
> From: Allen Chen <allen.chen@ite.com.tw>
> Tested-by: Hsin-yi Wang <hsinyi@chromium.org>
> Signed-off-by: Hermes Wu <hermes.wu@ite.com.tw>
> Signed-off-by: Allen Chen <allen.chen@ite.com.tw>
> ---
> This patch depends on https://patchwork.kernel.org/project/linux-mediatek/patch/20210722062246.2512666-4-sam@ravnborg.org/
> ---
>   drivers/gpu/drm/bridge/Kconfig      |    8 +
>   drivers/gpu/drm/bridge/Makefile     |    1 +
>   drivers/gpu/drm/bridge/ite-it6505.c | 3335 +++++++++++++++++++++++++++
>   3 files changed, 3344 insertions(+)
>   create mode 100644 drivers/gpu/drm/bridge/ite-it6505.c

Hello Allen,

since the dependency that you mentioned seems to be requiring some time to get
merged in, can you please open-code the call to drm_bridge_new_crtc_state() as
to stop requiring the commit you pointed to?

We can perhaps update this driver later, whenever the series you mentioned will
get applied.

The reason for this request is due to a breakage on MT8183 Kukui: since DPI is
supported in the drm-mediatek driver for this SoC, on platforms that are using
a DSI<->DP/eDP bridge, a probe failure occurs for the DPI0 component.
Leaving apart that drm-mediatek should be fixed to account for this as a non
critical error (and keep going with DSI only, simply ignoring DPI0), the Kukui
family of devices do have this functionality and it should be brought up as
soon as possible at this point - especially since the driver that you've sent
is ok to have.

Looking forward to see a v11 without unsatisfiable dependencies!

Thank you.

Regards,
- Angelo
