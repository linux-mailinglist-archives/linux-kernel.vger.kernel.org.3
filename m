Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09CD4548C5E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 18:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353019AbiFMLY3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 07:24:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353729AbiFMLQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 07:16:16 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4603B13E1F
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 03:39:43 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C69E66601652;
        Mon, 13 Jun 2022 11:39:40 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1655116781;
        bh=3fY9PYB9PhNS2MZFOLYAaBtLhPjrOVQJSWIC+nCM9cs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=LRgmghN5uXYInfi0t0BsNuDg6Z/oiZRcZJ2Jo4VKcPd0KQnwD5IwZ+4eKNPJnVDl0
         dfollf3m/u9jySVLhfKv9tjgIAcj8Fbcc4SV6gU6eJGEoNS6ArXDUNWE/btMnF6do9
         Wc4hDJYmPWNZ3f6yWm9iI8UR+gmlTO3glvth8BK5H0vDgFHWlA1K3h04nrjQBlqlxv
         Rbghe6kn6Mtk6+z1HtYV1EUmEc6WGATD3NAE72CtskD0uk5yxNiqyyODl0Bv2tWhi0
         i+ESeZ0SD6+nirCaEnQQNsbL7LN4rgsNv4LwBfXMkazFIZGM89y1DQ18qGg87lOZhY
         Llu96jmftJGPA==
Message-ID: <8a87d094-1c9e-d899-6671-ebf8c80ffbe6@collabora.com>
Date:   Mon, 13 Jun 2022 12:39:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v11 1/1] phy: phy-mtk-dp: Add driver for DP phy
Content-Language: en-US
To:     Bo-Chen Chen <rex-bc.chen@mediatek.com>, chunkuang.hu@kernel.org,
        p.zabel@pengutronix.de, chunfeng.yun@mediatek.com, kishon@ti.com,
        vkoul@kernel.org, matthias.bgg@gmail.com, airlied@linux.ie
Cc:     msp@baylibre.com, granquet@baylibre.com, jitao.shi@mediatek.com,
        wenst@chromium.org, ck.hu@mediatek.com,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220613072648.11081-1-rex-bc.chen@mediatek.com>
 <20220613072648.11081-2-rex-bc.chen@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220613072648.11081-2-rex-bc.chen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 13/06/22 09:26, Bo-Chen Chen ha scritto:
> From: Markus Schneider-Pargmann <msp@baylibre.com>
> 
> This is a new driver that supports the integrated DisplayPort phy for
> mediatek SoCs, especially the mt8195. The phy is integrated into the
> DisplayPort controller and will be created by the mtk-dp driver. This
> driver expects a struct regmap to be able to work on the same registers
> as the DisplayPort controller. It sets the device data to be the struct
> phy so that the DisplayPort controller can easily work with it.
> 
> The driver does not have any devicetree bindings because the datasheet
> does not list the controller and the phy as distinct units.
> 
> The interaction with the controller can be covered by the configure
> callback of the phy framework and its displayport parameters.
> 
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
> [Bo-Chen: Modify reviewers' comments.]
> Signed-off-by: Bo-Chen Chen <rex-bc.chen@mediatek.com>

There's no power_on()/power_off() callbacks and looks a bit weird, but it's
also right... the only thing that's missing, IMO, is a comment in the actual
file explaining that power for this PHY is always on when the DP block is on
and that no PHY specific power sequence has to be carried on (being managed
elsewhere and strongly tied to the specific DP IP).

Besides that,

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

