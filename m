Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EBE34CA845
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 15:35:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243103AbiCBOgH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 09:36:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231853AbiCBOgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 09:36:03 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5709CC4862;
        Wed,  2 Mar 2022 06:35:20 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id D54CF1F44E0D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1646231718;
        bh=8MD/q6vToKa+aCUMTtabBugzOlMLPxFtpWBZnt1o7Ig=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=KT8JwP+eIhA73Zrb/w0vPcNU77I6YJjXQ8R48YUI3dR54axXZlhKugetbJ6gMEYd1
         yWRJdoUlHOF7CHABqFkFlctkvjiirtm1qV2F2Zrk49i4ugt/JxFGCTXwSCEu2YqKC+
         kU1qDfo1XGQ3RaRxDzyCXGyoXi1jb81CD69J5hPmZN9ShPwybyxeWpOMqd5YydFN07
         T04FWpnHmAD5BivLLO4LJU8pgTGD8aLJKnWkq5owzCKtnfd748gbNdVBoRrz1KJGv8
         h1Stx2tyXnDB5snvTEdAtZcF5QED61gnajKXaUOPgb2OO0yMxkvK4VuFaLG4iTLdso
         VbZ0Vc1BGD/WA==
Message-ID: <60613d10-f7fc-03ea-900f-4255ebe0d5aa@collabora.com>
Date:   Wed, 2 Mar 2022 15:35:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v23 0/7] soc: mediatek: SVS: introduce MTK SVS
Content-Language: en-US
To:     Roger Lu <roger.lu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Enric Balletbo Serra <eballetbo@gmail.com>,
        Kevin Hilman <khilman@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Nicolas Boichat <drinkcat@google.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Fan Chen <fan.chen@mediatek.com>,
        HenryC Chen <HenryC.Chen@mediatek.com>,
        Xiaoqing Liu <Xiaoqing.Liu@mediatek.com>,
        Charles Yang <Charles.Yang@mediatek.com>,
        Angus Lin <Angus.Lin@mediatek.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Nishanth Menon <nm@ti.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Guenter Roeck <linux@roeck-us.net>,
        Jia-wei Chang <jia-wei.chang@mediatek.com>
References: <20220221063939.14969-1-roger.lu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220221063939.14969-1-roger.lu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 21/02/22 07:39, Roger Lu ha scritto:
> The Smart Voltage Scaling(SVS) engine is a piece of hardware
> which calculates suitable SVS bank voltages to OPP voltage table.
> Then, DVFS driver could apply those SVS bank voltages to PMIC/Buck
> when receiving OPP_EVENT_ADJUST_VOLTAGE.
> 
> 1. SVS driver uses OPP adjust event in [1] to update OPP table voltage part.
> 2. SVS driver gets thermal/GPU device by node [2][3] and CPU device by get_cpu_device().
> After retrieving subsys device, SVS driver calls device_link_add() to make sure probe/suspend callback priority.
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git/commit/?h=opp/linux-next&id=25cb20a212a1f989385dfe23230817e69c62bee5
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git/commit/?h=opp/linux-next&id=b325ce39785b1408040d90365a6ab1aa36e94f87
> [3] https://git.kernel.org/pub/scm/linux/kernel/git/matthias.bgg/linux.git/commit/?h=v5.16-next/dts64&id=a8168cebf1bca1b5269e8a7eb2626fb76814d6e2
> 
> change since v22:
> - Make "svsb_volt = max(svsb->volt[i] + temp_voffset, svsb->vmin);" become one line.
> - Remove voffset read/write commands for better system safety.
> - Add more comments on @turn_freq_base.
> 
> Roger Lu (7):
>    [v23,1/7] dt-bindings: soc: mediatek: add mtk svs dt-bindings
>    [v23,2/7] arm64: dts: mt8183: add svs device information
>    [v23,3/7] soc: mediatek: SVS: introduce MTK SVS engine
>    [v23,4/7] soc: mediatek: SVS: add monitor mode
>    [v23,5/7] soc: mediatek: SVS: add debug commands
>    [v23,6/7] dt-bindings: soc: mediatek: add mt8192 svs dt-bindings
>    [v23,7/7] soc: mediatek: SVS: add mt8192 SVS GPU driver
> 
>   .../bindings/soc/mediatek/mtk-svs.yaml        |   91 +
>   arch/arm64/boot/dts/mediatek/mt8183.dtsi      |   16 +
>   drivers/soc/mediatek/Kconfig                  |   10 +
>   drivers/soc/mediatek/Makefile                 |    1 +
>   drivers/soc/mediatek/mtk-svs.c                | 2398 +++++++++++++++++
>   5 files changed, 2516 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/soc/mediatek/mtk-svs.yaml
>   create mode 100644 drivers/soc/mediatek/mtk-svs.c
> 

Hello,
the entire series has got reviews, and this has already reached 23 iterations.
I personally have no more complaints about this one.

Does anyone have any KO comments about this series?

Cheers,
Angelo
