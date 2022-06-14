Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6838554AB36
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 09:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353151AbiFNHxx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 03:53:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355539AbiFNHxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 03:53:21 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C619640E76
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 00:52:16 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id F2C4766016A5;
        Tue, 14 Jun 2022 08:52:13 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1655193134;
        bh=YiYxfz9UJYMv0Yzl92YcMKOgxfk4MMa4/uB2sRksOJM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=UUod8iVfxYNNRG93+40eRBJxUTQ3ZMgriSgsL2pjQ7TOiQCiDUa9nUiDsYxWRkP1I
         J5w3HAl/BXe/Q6B6GwMcl3f9CawLTS2jXqIIot2MCzgKx1VFkVC0GNtMAC6dwA2sDu
         sEDwNJugHElihkizTLODY+vFVbqAyo2Nc0A+SANM34T/+FBJEumOXIHLvqCqkGORER
         1n53h10MPyNSaoBd/YmIETwznwOUFBZEAvHx3Flg9n9RcaFEA42l6jXeKo+8jwHlhJ
         md6WWZoS6XWPCD3fJHg9pceZe1BIdNxOqZ1IZUCGa5AbcJ7mX8a4xoOH/xSH5aIdN5
         E7/yJ3pSnhAkQ==
Message-ID: <9c8c712c-75d1-bd0f-0205-be769ce5e83d@collabora.com>
Date:   Tue, 14 Jun 2022 09:52:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] drm/bridge: anx7625: Zero error variable when panel
 bridge not present
Content-Language: en-US
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>, Robert Foss <robert.foss@linaro.org>
Cc:     kernel@collabora.com, Andrzej Hajda <andrzej.hajda@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Tzung-Bi Shih <tzungbi@google.com>,
        Xin Ji <xji@analogixsemi.com>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20220613163705.1531721-1-nfraprado@collabora.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220613163705.1531721-1-nfraprado@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 13/06/22 18:37, Nícolas F. R. A. Prado ha scritto:
> While parsing the DT, the anx7625 driver checks for the presence of a
> panel bridge on endpoint 1. If it is missing, pdata->panel_bridge stores
> the error pointer and the function returns successfully without first
> cleaning that variable. This is an issue since other functions later
> check for the presence of a panel bridge by testing the trueness of that
> variable.
> 
> In order to ensure proper behavior, zero out pdata->panel_bridge before
> returning when no panel bridge is found.
> 
> Fixes: 9e82ea0fb1df ("drm/bridge: anx7625: switch to devm_drm_of_get_bridge")
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> 

I would've preferred s/zero out/cleanup/g but it's also fine as you wrote it.
Besides, good catch!

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

