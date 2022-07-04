Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9C11565400
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 13:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233511AbiGDLpA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 07:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233194AbiGDLo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 07:44:57 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF2C011445
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 04:44:56 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B65B06601606;
        Mon,  4 Jul 2022 12:44:54 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1656935095;
        bh=jjo/dyeQs/GxvVIxuo7XEbbDAa6wk9DN2Its8ccnRJ0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=nbJnzWpIAwOdT1NnRPK3dzVlUURFg7owdJam04RFnvJ1M7R5J4KEmBvJsOP+V62Qh
         cY5xqLdSoHcmUI1epUxuKG90LJlj5x7P9/YpS1EfHuyIYfayhQnnHzB9256yBDKyDP
         M2ubH3i6prhjBmd1BXjyeoDFPIr+8Ccn1khWm1dNo6cRhlEz7hhqswvZxf/yFv8wM6
         elWZfMriM/zOTb1xhCbkpKSl6ls0PEEQXcwEVLwMWnP8a71fKlm2EAr8VzXnKkUw2g
         qj/elSmFNeBE3KTdMf4xaVV4bWxSfwIWabWi6niy/+tiqVJDzTFL/4QwFSbaxW7N+n
         NedgxcEU4P/Xw==
Message-ID: <e405bbc2-c1af-f445-5b78-021b8e88090a@collabora.com>
Date:   Mon, 4 Jul 2022 13:44:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] drm/mediatek: ensure bridge disable happends before
 suspend
Content-Language: en-US
To:     Hsin-Yi Wang <hsinyi@chromium.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220629190545.478113-1-hsinyi@chromium.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220629190545.478113-1-hsinyi@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 29/06/22 21:05, Hsin-Yi Wang ha scritto:
> Make sure bridge_disable will be called before suspend by calling
> drm_mode_config_helper_suspend() in .prepare callback.
> 
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> Reviewed-by: CK Hu <ck.hu@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> ---
> The issue is found if suspend is called via VT2 in several MTK SoC (eg.
> MT8173, MT8183, MT8186) chromebook boards with eDP bridge:
> bridge disable is called through mtk-drm's suspend, and it needs to be
> called before bridge pm runtime suspend.
> So we move the hook to .prepare() and .complete().
> ---
>   drivers/gpu/drm/mediatek/mtk_drm_drv.c | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)
> 
