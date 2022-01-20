Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8145495165
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 16:26:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376638AbiATP0G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 10:26:06 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:35544 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376574AbiATPZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 10:25:58 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 20AE41F45362
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1642692356;
        bh=8+iuI55GEe2f55qKCFzj4slDIPT5+kv1gU6x/pdsBWs=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=GTb4GYgETr0dGmKkiXlgmJg7q/i9Jobg8xDglDVLE1yiD9nqSCfbJ6YOsd7BirHkD
         MpqsMfqmuNcZ+/1ceXPqJt5YiQxspgDj8/6fwrcKtbxzqDMxkf0CJd+BvzYKQk1wCa
         znonQ211B4GgUX0BhXhUSWLOh0spevMCXUj4FkR3Hs2qri6R4TuaWaDpcmVZmfnE84
         N6QN0FEQe2Vx+L2ongu551azvIgenLYGdYwfHrlOJz7/5zAPq6bHoPz1y5cyXrCzIo
         EyzdhCTvcMM3srz9WawMdAtHs/6Gs83C9GqliWKX7cG1GQ5+h/XPDjwyc/QfyJOinP
         MCe8ry4JrqplA==
Subject: Re: [PATCH v11] drm/bridge: add it6505 driver
To:     allen <allen.chen@ite.com.tw>
Cc:     Kenneth Hung <Kenneth.Hung@ite.com.tw>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jau-Chih Tseng <Jau-Chih.Tseng@ite.com.tw>,
        David Airlie <airlied@linux.ie>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        open list <linux-kernel@vger.kernel.org>,
        Robert Foss <robert.foss@linaro.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        Hermes Wu <hermes.wu@ite.com.tw>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Hsin-yi Wang <hsinyi@chromium.org>,
        Hsin-Yi Wang <hsinyi@google.com>
References: <20220114091502.333083-1-allen.chen@ite.com.tw>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <f4696a8d-5c1d-1007-7814-b2e6cbe334ae@collabora.com>
Date:   Thu, 20 Jan 2022 16:25:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20220114091502.333083-1-allen.chen@ite.com.tw>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 14/01/22 10:14, allen ha scritto:
> This adds support for the iTE IT6505.
> This device can convert DPI signal to DP output.
> 
> From: Allen Chen <allen.chen@ite.com.tw>
> Tested-by: Hsin-yi Wang <hsinyi@chromium.org>
> Signed-off-by: Hermes Wu <hermes.wu@ite.com.tw>
> Signed-off-by: Allen Chen <allen.chen@ite.com.tw>
> ---
> v10 -> v11 : remove drm_bridge_new_crtc_state
> ---
>   drivers/gpu/drm/bridge/Kconfig      |    8 +
>   drivers/gpu/drm/bridge/Makefile     |    1 +
>   drivers/gpu/drm/bridge/ite-it6505.c | 3352 +++++++++++++++++++++++++++
>   3 files changed, 3361 insertions(+)
>   create mode 100644 drivers/gpu/drm/bridge/ite-it6505.c
> 

...snip...

> +static const struct of_device_id it6505_of_match[] = {
> +	{ .compatible = "ite,it6505" },
> +	{ }
> +};

If you want to have a DT compatible and DT properties, you have to also add
dt-bindings (yaml) for this driver, otherwise, any SoC/device DT will fail
the dt binding check.... So, please, add that.

For the driver by itself, though:

Acked-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> +
> +static struct i2c_driver it6505_i2c_driver = {
> +	.driver = {
> +		.name = "it6505",
> +		.of_match_table = it6505_of_match,
> +		.pm = &it6505_bridge_pm_ops,
> +	},
> +	.probe = it6505_i2c_probe,
> +	.remove = it6505_i2c_remove,
> +	.shutdown = it6505_shutdown,
> +	.id_table = it6505_id,
> +};
> +
> +module_i2c_driver(it6505_i2c_driver);
> +
> +MODULE_AUTHOR("Allen Chen <allen.chen@ite.com.tw>");
> +MODULE_DESCRIPTION("IT6505 DisplayPort Transmitter driver");
> +MODULE_LICENSE("GPL v2");
> 

