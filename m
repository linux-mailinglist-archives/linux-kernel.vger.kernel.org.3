Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C39C55C176
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234252AbiF0KTU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 06:19:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234240AbiF0KTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 06:19:14 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 470B132B;
        Mon, 27 Jun 2022 03:19:13 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id DF39D6601822;
        Mon, 27 Jun 2022 11:19:10 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1656325152;
        bh=ifo75he1zccAIukoq+Y8qsDgP4/nZXF5zclgYxbptVk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=lVOS5KTI98Vc61DG5Wu6FehcIW9LZn6qFy4x9kE3Yms9Biycc8h1k3BSp22jHfw37
         2BxgTCmUVocIqXwecu/NupfEuvcPB07kyR5zcsY5QGCcca+SLmuEd2A85xkr/Np7Es
         Jnuq9nQ2FqqbPiLS/uNijdergVGxEPJvETQNoQQF50EcDvHCkhPQf0YTGnW9XIlwEs
         TV7mIt+bhnFo21XPpc68wodVYGvUhiSYHH6rLPclM0imkfznCGs1TfMEAruDTHAW5L
         q/MTD9ZhdaevACN1VNr2mly5ZSkbMxeXeLeHMAKFvwwliGXyeCDWs4MTDHOlXhdGGi
         Sxru0TEIEteWQ==
Message-ID: <9e60dfa4-b648-8005-2cf3-f993dddf57a6@collabora.com>
Date:   Mon, 27 Jun 2022 12:19:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v12 07/10] drm/mediatek: add hpd debounce
Content-Language: en-US
To:     Bo-Chen Chen <rex-bc.chen@mediatek.com>, chunkuang.hu@kernel.org,
        p.zabel@pengutronix.de, daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mripard@kernel.org,
        tzimmermann@suse.de, matthias.bgg@gmail.com, deller@gmx.de,
        airlied@linux.ie
Cc:     msp@baylibre.com, granquet@baylibre.com, jitao.shi@mediatek.com,
        wenst@chromium.org, ck.hu@mediatek.com,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-fbdev@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220627080341.5087-1-rex-bc.chen@mediatek.com>
 <20220627080341.5087-8-rex-bc.chen@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220627080341.5087-8-rex-bc.chen@mediatek.com>
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

Il 27/06/22 10:03, Bo-Chen Chen ha scritto:
> From: Jitao Shi <jitao.shi@mediatek.com>
> 
>  From the DP spec 1.4a chapter 3.3, upstream devices should implement
> HPD signal de-bouncing on an external connection.
> A period of 100ms should be used to detect an HPD connect event.
> To cover these cases, HPD de-bounce should be implemented only after
> HPD low has been detected for at least 100ms.
> 
> Therefore,
> 1. If HPD is low (which means plugging out) for longer than 100ms:
>     we need to do de-bouncing (which means we need to wait for 100ms).
> 2. If HPD low is for less than 100ms:
>     we don't need to care about the de-bouncing.
> 
> In this patch, we start a 100ms timer and use a need_debounce boolean
> to implement the feature.
> 
> Two cases when HPD is high:
> 1. If the timer is expired (>100ms):
>     - need_debounce is true.
>     - When HPD high (plugging event comes), need_debounce will be true
>       and then we need to do de-bouncing (wait for 100ms).
> 2. If the timer is not expired (<100ms):
>     - need_debounce is false.
>     - When HPD high (plugging event comes), need_debounce will be false
>       and no need to do de-bouncing.
> 
> HPD_______             __________________
>            |            |<-  100ms   ->
>            |____________|
>            <-  100ms   ->
> 
> Without HPD de-bouncing, USB-C to HDMI Adapaters will not be detected.
> 
> The change has been successfully tested with the following devices:
> - Dell Adapter - USB-C to HDMI
> - Acer 1in1 HDMI dongle
> - Ugreen 1in1 HDMI dongle
> - innowatt HDMI + USB3 hub
> - Acer 2in1 HDMI dongle
> - Apple 3in1 HDMI dongle (A2119)
> - J5Create 3in1 HDMI dongle (JAC379)
> 
> Tested-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> Reviewed-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
> Signed-off-by: Bo-Chen Chen <rex-bc.chen@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

