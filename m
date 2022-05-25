Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 521F1533ABF
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 12:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240084AbiEYKjm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 06:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbiEYKji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 06:39:38 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7EB4986E4;
        Wed, 25 May 2022 03:39:36 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 5C5B31F448AA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1653475175;
        bh=JtMKudCPbVBC4fPSg8WPLsPO72lG8JrBwViYM6bNNoI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ei1cJvaBsJOHecaFd4fbRaXHd2+DhGLrvQgIZDAknuw5CZDoea0DCSET+jljl/Odc
         I7defVnJskBOCTvNng734y1gn7qK9bQ+krN+2eGUQ44PbKqZhufzA65SgLvGbANq6o
         c1vBwwjfAWIE88mkjwfvoSmw9b50vTyiXGb6mx7Aa1XVhXzNLfcZNYlgJN4+6KxFfN
         n1fS6unEx/OgVs+kS/DWLlnj2gXcm//B4/ZSW1Nc+JsugNc2a2Z+jqS+pu/ZA3GQuH
         UMU+IKDdmvEMx3F/ULu59eHH8po7X6n1OBmguD10pVD2UVqPdljaPqjFqRq6lrqWya
         AxT5gFkChux2Q==
Message-ID: <54d6c0ff-d93c-0506-4db9-3852c69211ab@collabora.com>
Date:   Wed, 25 May 2022 12:39:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v7 1/1] firmware: mediatek: add adsp ipc protocol
 interface
Content-Language: en-US
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>, tzungbi@google.com,
        Chen-Yu Tsai <wenst@chromium.org>, cujomalainey@google.com,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        sound-open-firmware@alsa-project.org
References: <20220407130338.28939-1-allen-kh.cheng@mediatek.com>
 <20220407130338.28939-2-allen-kh.cheng@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220407130338.28939-2-allen-kh.cheng@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 07/04/22 15:03, Allen-KH Cheng ha scritto:
> From: Allen-KH Cheng <Allen-KH.Cheng@mediatek.com>
> 
> Some of mediatek processors contain
> the Tensilica HiFix DSP for audio processing.
> 
> The communication between Host CPU and DSP firmware is
> taking place using a shared memory area for message passing.
> 
> ADSP IPC protocol offers (send/recv) interfaces using
> mediatek-mailbox APIs.
> 
> We use two mbox channels to implement a request-reply protocol.
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Reviewed-by: Curtis Malainey <cujomalainey@chromium.org>
> Reviewed-by: Tzung-Bi Shih <tzungbi@google.com>
> Reviewed-by: YC Hung <yc.hung@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>   drivers/firmware/Kconfig                      |   1 +
>   drivers/firmware/Makefile                     |   1 +
>   drivers/firmware/mediatek/Kconfig             |   9 +
>   drivers/firmware/mediatek/Makefile            |   2 +
>   drivers/firmware/mediatek/mtk-adsp-ipc.c      | 161 ++++++++++++++++++
>   .../linux/firmware/mediatek/mtk-adsp-ipc.h    |  65 +++++++
>   6 files changed, 239 insertions(+)
>   create mode 100644 drivers/firmware/mediatek/Kconfig
>   create mode 100644 drivers/firmware/mediatek/Makefile
>   create mode 100644 drivers/firmware/mediatek/mtk-adsp-ipc.c
>   create mode 100644 include/linux/firmware/mediatek/mtk-adsp-ipc.h
> 

Gentle ping for this one, as it's getting stale... and it's ready.

To add context, this driver is *really* necessary, as support for it
is added in the MT8195 ASoC SOF driver as a platform device [1], and the
necessary memory regions are coming from the mediatek,mt8195-dsp [2] driver.

[1]: 
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/sound/soc/sof/mediatek/mt8195/mt8195.c?h=next-20220525#n389

[2]: 
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/Documentation/devicetree/bindings/dsp/mediatek,mt8195-dsp.yaml?h=next-20220525#n61

Cheers,
Angelo
