Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 777CF5AD00B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 12:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235598AbiIEKYP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 06:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235407AbiIEKYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 06:24:12 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A894393;
        Mon,  5 Sep 2022 03:24:11 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 2534A6601EB2;
        Mon,  5 Sep 2022 11:24:09 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1662373449;
        bh=bYfDLiA2ERg8hGGzHNEQdP7PWNDTavkHqOv/zPnBBww=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=WgGwH1cmE6gheXGmxT/u4IMMyAum+qgVztsmQr7lxhp3QOOSpYLqsbzghWxVF+/JI
         YYzGdRvlB1synFtDv8yu00wqK3Sm69PSJg0FUZnP+DI99eM8ZdWFG82M1Wf7EzF886
         cChSHa4suMf0gvaVvRwpeg2y0yYU3Xcgy3gAyn9BOv1G690kzVFPdAyS+n31bRSk+8
         9yyj1AVgYq3E43gLsdIT7EisyY9aFefKCb2ExDu9NFgrB+RnJQJA46BOHp1G42XZN2
         YUG08HZZUbvWST4rkXJi+3+nvGBvViTiqTJNs6NTkx56RCHwMfU8Pozr7MWbaubLnU
         xlIOJbDYSxkJA==
Message-ID: <f7913808-d9b7-9f42-1a16-aedcc0d21497@collabora.com>
Date:   Mon, 5 Sep 2022 12:24:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 00/19] Add driver for dvfsrc, support for interconnect
Content-Language: en-US
To:     Dawei Chien <dawei.chien@mediatek.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Ryan Case <ryandcase@chromium.org>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Nicolas Boichat <drinkcat@google.com>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Fan Chen <fan.chen@mediatek.com>,
        Arvin Wang <arvin.wang@mediatek.com>,
        James Liao <jamesjj.liao@mediatek.com>
References: <20210812085846.2628-1-dawei.chien@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20210812085846.2628-1-dawei.chien@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Dawei,
this series brings very nice improvements to many MediaTek platforms, it would
be a real pity to abandon it.

Can you, or anyone else from MediaTek, please respin on the latest -next?

Thanks,
Angelo

> This series is based on v5.14-rc1.
> 
> The patchsets add support for MediaTek hardware module named DVFSRC
> (dynamic voltage and frequency scaling resource collector). The DVFSRC is
> a HW module which is used to collect all the requests from both software
> and hardware and turn into the decision of minimum operating voltage and
> minimum DRAM frequency to fulfill those requests.
> 
> So, This series is to implement the dvfsrc driver to collect all the
> requests of operating voltage or DRAM bandwidth from other device drivers
> likes GPU/Camera through 3 frameworks basically:
> 
> 1. interconnect framework: to aggregate the bandwidth
>     requirements from different clients
> 
> [1] https://patchwork.kernel.org/cover/10766329/
> 
> There has a hw module "DRAM scheduler", which used to control the
> throughput.
> The DVFSRC will collect forecast data of dram bandwidth from
> SW consumers(camera/gpu...), and according the forecast to change the DRAM
> frequency
> 
> 2. Regualtor framework: to handle the operating voltage requirement from
>     user or cosumer which not belong any power domain
> 
> Changes in V11:
> * rebase all patches on v5.14-rc1.
> * support platform mt8195.
> * add initial bw in mediatek interconnect driver.
> * add one more pcie client in mediatek interconnect driver.
> * add compatible for MT8195 dvfsrc.
> 
> Changes in V10:
> * rebase all patches on v5.13-rc1
> * add acked TAG for interconnect provider driver (Georgi)
> * update comment message for typos. (Georgi)
> * update cover leter for typos.
> 
> Changes in V9:
> * modify the configuration of dvfsrc.yaml. (Rob)
> 
> Changes in V8:
> * Fixed the dt_binding_check error of dvfsrc.yaml. (Rob)
> * Remove Kconfig dependency of DVFSRC
> 
> Changes in V7:
> * Fixed the dt_binding_check error of dvfsrc.yaml. (Rob)
> * Fixed the checkpatch complains of "Signed-off-by:
> email name mismatch". (Georgi)
> * Fixed coding style of interconnect driver. (Georgi)
> * Update comment of the years to 2021. (Georgi)
> 
> Changes in V6:
> * Remove the performace state support, because the request from consumer
> can be replaced by using interconnect and regulator framework.
> * Update the DT patches and convert them to DT schema. (Georgi)
> * Modify the comment format and coding style. (Mark)
> 
> Changes in V5:
> * Support more platform mt6873/mt8192
> * Drop the compatible and interconnect provider node and make the parent
> node an interconnect provider. (Rob/Georgi)
> * Make modification of interconnect driver from coding suggestion. (Georgi)
> * Move interconnect diagram into the commit text of patch. (Georgi)
> * Register the interconnect provider as a platform sub-device. (Georgi)
> 
> Changes in V4:
> * Add acked TAG on dt-bindings patches. (Rob)
> * Declaration of emi_icc_aggregate since the prototype of aggregate
> function has changed meanwhile. (Georgi)
> * Used emi_icc_remove instead of icc_provider_del on probe. (Georgi)
> * Add dvfsrc regulator driver into series.
> * Bug fixed of mt8183_get_current_level.
> * Add mutex protection for pstate operation on dvfsrc_set_performance.
> 
> Changes in V3:
> * Remove RFC from the subject prefix of the series
> * Combine dt-binding patch and move interconnect dt-binding document into
> dvfsrc. (Rob)
> * Remove unused header, add unit descirption to the bandwidth, rename
> compatible name on interconnect driver. (Georgi)
> * Fixed some coding style: check flow, naming, used readx_poll_timeout
> on dvfsrc driver. (Ryan)
> * Rename interconnect driver mt8183.c to mtk-emi.c
> * Rename interconnect header mtk,mt8183.h to mtk,emi.h
> * mtk-scpsys.c: Add opp table check first to avoid OF runtime parse failed
> 
> Changes in RFC V2:
> * Remove the DT property dram_type. (Rob)
> * Used generic dts property 'opp-level' to get the performace
> state. (Stephen)
> * Remove unnecessary dependency config on Kconfig. (Stephen)
> * Remove unused header file, fixed some coding style issue, typo,
> error handling on dvfsrc driver. (Nicolas/Stephen)
> * Remove irq handler on dvfsrc driver. (Stephen)
> * Remove init table on dvfsrc driver, combine hw init on trustzone.
> * Add interconnect support of mt8183 to aggregate the emi bandwidth.
> (Georgi)
> 
> v10: https://patchwork.kernel.org/project/linux-mediatek/list/?series=494095
> V9: https://patchwork.kernel.org/project/linux-mediatek/list/?series=440389
> V8: https://patchwork.kernel.org/project/linux-mediatek/list/?series=421713
> V7: https://patchwork.kernel.org/project/linux-mediatek/list/?series=411057
> V6: https://patchwork.kernel.org/project/linux-mediatek/list/?series=406077
> V5: https://patchwork.kernel.org/project/linux-mediatek/list/?series=348065
> V4: https://lore.kernel.org/patchwork/cover/1209284/
> V3: https://patchwork.kernel.org/cover/11118867/
> RFC V2: https://lore.kernel.org/patchwork/patch/1068113/
> RFC V1: https://lore.kernel.org/patchwork/cover/1028535/
> 
> Dawei Chien (8):
>    dt-bindings: mediatek: add compatible for MT8195 dvfsrc
>    soc: mediatek: add support for mt8195
>    arm64: dts: mt8195: add dvfsrc related nodes
>    dt-bindings: interconnect: add MT8195 interconnect dt-bindings
>    interconnect: mediatek: add support for mt8195
>    interconnect: mediatek: add initial bandwidth
>    regulator: mediatek: add support for mt8195
>    arm64: dts: mt8195: add dvfsrc related nodes
> 
> Henry Chen (11):
>    dt-bindings: soc: Add dvfsrc driver bindings
>    soc: mediatek: add header for mediatek SIP interface
>    soc: mediatek: add driver for dvfsrc support
>    soc: mediatek: add support for mt6873
>    arm64: dts: mt8183: add dvfsrc related nodes
>    arm64: dts: mt8192: add dvfsrc related nodes
>    dt-bindings: interconnect: add MT6873 interconnect dt-bindings
>    interconnect: mediatek: Add interconnect provider driver
>    arm64: dts: mt8183: add dvfsrc related nodes
>    arm64: dts: mt8192: add dvfsrc related nodes
>    arm64: dts: mt8192: add dvfsrc regulator nodes
> 
>   .../devicetree/bindings/soc/mediatek/dvfsrc.yaml   |  68 +++
>   arch/arm64/boot/dts/mediatek/mt8183.dtsi           |   7 +
>   arch/arm64/boot/dts/mediatek/mt8192.dtsi           |  14 +
>   arch/arm64/boot/dts/mediatek/mt8195.dtsi           |   7 +
>   drivers/interconnect/Kconfig                       |   1 +
>   drivers/interconnect/Makefile                      |   1 +
>   drivers/interconnect/mediatek/Kconfig              |  13 +
>   drivers/interconnect/mediatek/Makefile             |   3 +
>   drivers/interconnect/mediatek/mtk-emi.c            | 385 +++++++++++++++
>   drivers/regulator/mtk-dvfsrc-regulator.c           |  23 +
>   drivers/soc/mediatek/Kconfig                       |  11 +
>   drivers/soc/mediatek/Makefile                      |   1 +
>   drivers/soc/mediatek/mtk-dvfsrc.c                  | 538 +++++++++++++++++++++
>   include/dt-bindings/interconnect/mtk,mt6873-emi.h  |  41 ++
>   include/dt-bindings/interconnect/mtk,mt8183-emi.h  |  21 +
>   include/dt-bindings/interconnect/mtk,mt8195-emi.h  |  42 ++
>   include/linux/soc/mediatek/mtk_dvfsrc.h            |  35 ++
>   include/linux/soc/mediatek/mtk_sip_svc.h           |   4 +
>   18 files changed, 1215 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/soc/mediatek/dvfsrc.yaml
>   create mode 100644 drivers/interconnect/mediatek/Kconfig
>   create mode 100644 drivers/interconnect/mediatek/Makefile
>   create mode 100644 drivers/interconnect/mediatek/mtk-emi.c
>   create mode 100644 drivers/soc/mediatek/mtk-dvfsrc.c
>   create mode 100644 include/dt-bindings/interconnect/mtk,mt6873-emi.h
>   create mode 100644 include/dt-bindings/interconnect/mtk,mt8183-emi.h
>   create mode 100644 include/dt-bindings/interconnect/mtk,mt8195-emi.h
>   create mode 100644 include/linux/soc/mediatek/mtk_dvfsrc.h
> 



