Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72B195A4683
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 11:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbiH2Jw4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 05:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiH2Jwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 05:52:54 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7508158DD2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 02:52:53 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 55BDB6601EF3;
        Mon, 29 Aug 2022 10:52:51 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1661766772;
        bh=DOOeZ5TocTeNw6rUquvXDuwOcgicPui9OcTrbY9j4bQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ku2W3MDOZWr/nzqhNKp5ebzlbv8gwpUjeWBI4IcZynG2q/6vyJ6J06KeMDL/ARDm1
         Y0yohfxSbjIpPsIB6l53B3hPD5ujRJhnDQ3njsBFMNrfydzuyLJs9fPZiwdwJRA73n
         XvyqWa+GrIdlpxU2n0QG50yCVuV7Q2I8SM0gEeSUHeXqHNlYDuG7BX2DM9Ua8zEAJt
         A29OdV0xK3pRF4Zr5jXlJCDoNPoB9aLQlKds3JRn1x4dXhMM4Rj1vyVRDv2PexYfVs
         OVYrtkeLmPpFGtj5QBcI/YxRkH7iPi0ocL9jjmgmBFvFzJaKbh44hzJwqkO8tNS531
         3n87+SEdtBH0g==
Message-ID: <3e33e564-a62d-d07c-f214-0f1857b99a9c@collabora.com>
Date:   Mon, 29 Aug 2022 11:52:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4,1/2] soc: mediatek: Add mmsys func to adapt to dpi
 output for MT8186
Content-Language: en-US
To:     xinlei.lee@mediatek.com, matthias.bgg@gmail.com,
        rex-bc.chen@mediatek.com, jason-jh.lin@mediatek.com,
        yongqiang.niu@mediatek.com, chunkuang.hu@kernel.org,
        p.zabel@pengutronix.de, airlied@linux.ie, daniel@ffwll.ch
Cc:     jitao.shi@mediatek.com, dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <1661743308-29120-1-git-send-email-xinlei.lee@mediatek.com>
 <1661743308-29120-2-git-send-email-xinlei.lee@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <1661743308-29120-2-git-send-email-xinlei.lee@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,TRACKER_ID,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 29/08/22 05:21, xinlei.lee@mediatek.com ha scritto:
> From: Xinlei Lee <xinlei.lee@mediatek.com>
> 
> Add mmsys func to manipulate dpi output format config for MT8186.
> 
> Co-developed-by: Jitao Shi <jitao.shi@mediatek.com>
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> Signed-off-by: Xinlei Lee <xinlei.lee@mediatek.com>
> Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> ---
>   drivers/soc/mediatek/mt8186-mmsys.h    | 1 +
>   drivers/soc/mediatek/mtk-mmsys.c       | 8 ++++++++
>   include/linux/soc/mediatek/mtk-mmsys.h | 3 +++
>   3 files changed, 12 insertions(+)
> 
> diff --git a/drivers/soc/mediatek/mt8186-mmsys.h b/drivers/soc/mediatek/mt8186-mmsys.h
> index eb1ad9c37a9c..6eca3445bea3 100644
> --- a/drivers/soc/mediatek/mt8186-mmsys.h
> +++ b/drivers/soc/mediatek/mt8186-mmsys.h
> @@ -3,6 +3,7 @@
>   #ifndef __SOC_MEDIATEK_MT8186_MMSYS_H
>   #define __SOC_MEDIATEK_MT8186_MMSYS_H
>   
> +#define MT8186_DPI_OUTPUT_FORMAT		0x400

For readability, can we please rename this definition to

MT8186_MMSYS_DPI_OUTPUT_FORMAT

Thanks,
Angelo

