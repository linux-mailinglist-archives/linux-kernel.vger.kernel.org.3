Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E678E483EEB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 10:13:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbiADJNs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 04:13:48 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:55810 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiADJNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 04:13:48 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 879501F42D87
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1641287627;
        bh=XZd2lykqJomHU+Ox/8ttKPosF+qxXhAWLOOqEgbtIdo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=iQ8lVGvPPym5/5IZSktbxmSKApdFKXLV8L8JhFK1cp/LQSXq7Lmr3S678qN+ET2gh
         YCAKi7zdhELODH1TlKDTZtSDwSBhVp8nn28VTzd+oAI7KVI/2oqZgxBXSzhWEye0oB
         wWmEW9VsBH97h6caTCJ705TyY1jqDyYywebgbpN8jUfCYWbaZcuHNqwagIvwWO7IdC
         W+hlBtG2dxDoYOpNneQsZZJfMXsiS3qeZYstDQgtZdz28SKGXQNHm+FSsDTta9dC+i
         FMPJ5qz47jH2g6bT9zWr8tpoojCfprjAqSf+zLJAYUI6dw+TjwS/HSs30vfZEzBIVi
         nXVE02V4PKQ/Q==
Subject: Re: [PATCH] drm/mediatek: mtk_dsi: Avoid EPROBE_DEFER loop with
 external bridge
To:     dri-devel@lists.freedesktop.org
Cc:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        chunkuang.hu@kernel.org, p.zabel@pengutronix.de, airlied@linux.ie,
        daniel@ffwll.ch, matthias.bgg@gmail.com, kernel@collabora.com
References: <20211210113617.196204-1-angelogioacchino.delregno@collabora.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <a2c54a49-b052-ab41-d2af-1869c63878e3@collabora.com>
Date:   Tue, 4 Jan 2022 10:13:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211210113617.196204-1-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 10/12/21 12:36, AngeloGioacchino Del Regno ha scritto:
> DRM bridge drivers are now attaching their DSI device at probe time,
> which requires us to register our DSI host in order to let the bridge
> to probe: this recently started producing an endless -EPROBE_DEFER
> loop on some machines that are using external bridges, like the
> parade-ps8640, found on the ACER Chromebook R13.
> 
> Now that the DSI hosts/devices probe sequence is documented, we can
> do adjustments to the mtk_dsi driver as to both fix now and make sure
> to avoid this situation in the future: for this, following what is
> documented in drm_bridge.c, move the mtk_dsi component_add() to the
> mtk_dsi_ops.attach callback and delete it in the detach callback;
> keeping in mind that we are registering a drm_bridge for our DSI,
> which is only used/attached if the DSI Host is bound, it wouldn't
> make sense to keep adding our bridge at probe time (as it would
> be useless to have it if mtk_dsi_ops.attach() fails!), so also move
> that one to the dsi host attach function (and remove it in detach).
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Due to the latest changes in drm bridge, we need this patch to land as soon as
possible, otherwise breakages will be seen on all MediaTek powered devices using
DSI to eDP/DP bridges...

...hence, friendly ping for a review :)
