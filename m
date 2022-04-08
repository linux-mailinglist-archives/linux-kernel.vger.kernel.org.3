Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFA584F90A8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 10:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231610AbiDHIYA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 04:24:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231559AbiDHIX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 04:23:56 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 076825FB5
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 01:21:52 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 0BC531F46C62
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1649406110;
        bh=5hTYFqNB9vDIxHeFkZOuvaqNuZxpgzcJpUFPnM90T7A=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=RX2ac4nHdftRiVxnIm/L5xLNJ346VIem9P4MCmnuKCk9O3k39+2W9DAYtLA8WHl5s
         WRg5G8B1tppItIlehtNiZNLX9peiMae6F1O1Ewu/dI2ue4OMlTaazbd0INZ/VKJ2j6
         7zWzEK66mcjqyd8IyXdc7vFR9OOd/fGZnJ+5RISKzOXLRm5P25tx6hJQ9gbji4aegA
         GcRGQt5XDzNSCrjVM97T0cv4yzbyaQkzF8v9ln+q2elehSPLXs9VqjJNPg0tHwB6Pt
         rNWrgJlYlPdfsM7hETLT6GSDmAeq+doDka/C4xwdBK/N4lOLYKJLLq4SeMO/HCDSEJ
         PaFNHVl4XbYFQ==
Message-ID: <20848108-31bc-357c-224b-9cbdd465b195@collabora.com>
Date:   Fri, 8 Apr 2022 10:21:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] drm/bridge: anx7625: Use uint8 for lane-swing arrays
Content-Language: en-US
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>, Robert Foss <robert.foss@linaro.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>
Cc:     kernel@collabora.com, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Pi-Hsun Shih <pihsun@chromium.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Tzung-Bi Shih <tzungbi@google.com>,
        Xin Ji <xji@analogixsemi.com>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20220408013034.673418-1-nfraprado@collabora.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220408013034.673418-1-nfraprado@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 08/04/22 03:30, Nícolas F. R. A. Prado ha scritto:
> As defined in the anx7625 dt-binding, the analogix,lane0-swing and
> analogix,lane1-swing properties are uint8 arrays. Yet, the driver was
> reading the array as if it were of uint32 and masking to 8-bit before
> writing to the registers. This means that a devicetree written in
> accordance to the dt-binding would have its values incorrectly parsed.
> 
> Fix the issue by reading the array as uint8 and storing them as uint8
> internally, so that we can also drop the masking when writing the
> registers.
> 
> Fixes: fd0310b6fe7d ("drm/bridge: anx7625: add MIPI DPI input feature")
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> 

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
