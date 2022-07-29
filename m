Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D597758562F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 22:33:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238672AbiG2UdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 16:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbiG2UdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 16:33:18 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C2C367162;
        Fri, 29 Jul 2022 13:33:17 -0700 (PDT)
Received: from notapiano (pool-98-113-53-228.nycmny.fios.verizon.net [98.113.53.228])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 6D83D66019F8;
        Fri, 29 Jul 2022 21:33:13 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1659126796;
        bh=JE9yLr73dTeyo3+2VHkB5/L8XO+ZrpQ1qwaLSyUkuP0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=orf3OoP6cMCHdWcib7IB2wAeMdOGbEK6ft6Z+GntI0KU9g49SGWJ/Qcv46oaAY75+
         T04nDQxyq5WokkTk42rCN+zt4i3mvzbJC4fTkinlvO51W5ZWHTJSugmUSlLpVKWWlF
         hl1zBGz+1KMtiqgknyPeg09tqwVIlt1+PU1tU6HOA3q6dfh3+/oRFtZPJyLm0kuZDE
         XOx9uuGSEEMIuPst5FeYMuKJEef6jdWyJZH6rwbvtplA+nr4IKXxRHQkuxnhnVS/to
         I9XEkLQWUWIMl9DC59MYNznXRSGarTQ0PdPgJk9vb3A0nXLuQj9+IPLMORwJYCiAgd
         vXU2URX4cLYRQ==
Date:   Fri, 29 Jul 2022 16:33:10 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Balsam CHIHI <bchihi@baylibre.com>
Cc:     rafael@kernel.org, rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amitk@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, khilman@baylibre.com,
        mka@chromium.org, robh+dt@kernel.org, krzk+dt@kernel.org,
        matthias.bgg@gmail.com, p.zabel@pengutronix.de,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, james.lo@mediatek.com,
        fan.chen@mediatek.com, louis.yu@mediatek.com,
        rex-bc.chen@mediatek.com, abailon@baylibre.com
Subject: Re: [PATCH v8 0/6] Add LVTS architecture thermal
Message-ID: <20220729203310.b26hcmeharlgiq7v@notapiano>
References: <20220726135506.485108-1-bchihi@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220726135506.485108-1-bchihi@baylibre.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 26, 2022 at 03:55:00PM +0200, Balsam CHIHI wrote:
> This series moves thermal files related to MediaTek to the mediatek folder.
> And introduce the new architecture LVTS (low voltage thermal sensor) driver to report
> the highest temperature in the SoC and record the highest temperature sensor,
> each sensor as a hot zone.
> The LVTS body is divided into two parts, the LVTS controller and the LVTS device.
> The LVTS controller can connect up to 4 LVTS devices, and each LVTS device
> can connect up to 7 TSMCUs.
> 
> The architecture will be the first to be used on mt8192 and mt8195.
> 
> Changelog:
> Changes in v8:
>         - Fix Coding style issues
>         - Rebase to kernel-5.18.rc8
>         - Rebase on top of these series :
>           - [RESEND v8 00/19] Cleanup MediaTek clk reset drivers and support SoCs :
>                 https://lore.kernel.org/all/20220523093346.28493-1-rex-bc.chen@mediatek.com/
>           - [PATCH v6 00/12] thermal OF rework :
>                 https://lore.kernel.org/all/20220722200007.1839356-1-daniel.lezcano@linexp.org/
>         - Add multi-instance support and SRC Modularization :
>           - Rewrite DTS and DT bindings
>             - Add DT bindings for MT8195
>             - One LVTS node for each HW Domain (AP and MCU)
>           - One SW Instance for each HW Domain, for each SoC
>           - Add an SRC file for each SoC (MT8192 and MT8195)
>           - Add a Kconfig sub-menu entry for each SoC
>         - Shrink LVTS instance iospace length from 0x1000 to 0x400
>         - Replace platform_get_resource by platform_get_mem_or_io to get Base Address
>         - Replace platform_get_resource by platform_get_irq to get Interrupt Number
>         - Add "lvts_" prefix to functions and structs
> 
> Changes in v7:
>         - Fix coding style issues
>         - Rewrite dt bindings
>           - was not accurate
>           - Use mt8195 for example (instead of mt8192)
>           - Rename mt6873 to mt8192
>           - Remove clock name
>         - Rebased on top of to series:
>           - https://patchwork.kernel.org/project/linux-mediatek/list/?series=637849
>           - https://patchwork.kernel.org/project/linux-pm/list/?series=639386
> 
> Changes in v6:
>         - Remove temperature aggregation (it will be added in another series)
>         - Update the way to read the temperature (read one sensor instead of all)
>         - Add support of mt8195
> 
> Changes in v5:
>         - Use 'git mv' for the relocated file.
> 
> Changes in v4:
>         - Rebase to kernel-v5.13-rc1
>         - Resend
> 
> Changes in v3:
>         - change the expression in the lvts_temp_to_raw to dev_s64.
> 
> Changes in v2:
>         - Rebase to kernel-5.11-rc1.
>         - sort headers
>         - remove initial value 0 of msr_raw in the lvts_temp_to_raw.
>         - disconstruct the api of lvts_read_tc_msr_raw.
>         - add the initial value max_temp = 0 and compare e.q.
>           in the lvts_read_all_tc_temperature.
>         - add the return with an invalid number in the lvts_init.
> 
> This series depends on [1] and [2].
> 
> [1]https://lore.kernel.org/all/20220523093346.28493-1-rex-bc.chen@mediatek.com/
> [2]https://lore.kernel.org/all/20220722200007.1839356-1-daniel.lezcano@linexp.org/
> 
> Alexandre Bailon (2):
>   dt-bindings: thermal: Add binding document for LVTS thermal
>     controllers
>   arm64: dts: mt8195: Add efuse node to mt8195
> 
> Michael Kao (3):
>   thermal: mediatek: Relocate driver to mediatek folder
>   thermal: mediatek: Add LVTS drivers for SoC theraml zones for mt8192
>   thermal: mediatek: Add thermal zone settings for mt8195
> 
> Tinghan Shen (1):
>   arm64: dts: mt8195: Add thermal zone
> 
>  .../thermal/mediatek,mt8192-lvts.yaml         |  73 ++
>  .../thermal/mediatek,mt8195-lvts.yaml         |  75 ++
>  arch/arm64/boot/dts/mediatek/mt8195.dtsi      | 131 ++-
>  drivers/thermal/Kconfig                       |  14 +-
>  drivers/thermal/Makefile                      |   2 +-
>  drivers/thermal/mediatek/Kconfig              |  62 ++
>  drivers/thermal/mediatek/Makefile             |   4 +
>  drivers/thermal/mediatek/lvts_mt8192.c        | 241 +++++
>  drivers/thermal/mediatek/lvts_mt8195.c        | 253 +++++
>  .../{mtk_thermal.c => mediatek/soc_temp.c}    |   2 +-
>  drivers/thermal/mediatek/soc_temp_lvts.c      | 928 ++++++++++++++++++
>  drivers/thermal/mediatek/soc_temp_lvts.h      | 366 +++++++
>  12 files changed, 2138 insertions(+), 13 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/thermal/mediatek,mt8192-lvts.yaml
>  create mode 100644 Documentation/devicetree/bindings/thermal/mediatek,mt8195-lvts.yaml
>  create mode 100644 drivers/thermal/mediatek/Kconfig
>  create mode 100644 drivers/thermal/mediatek/Makefile
>  create mode 100644 drivers/thermal/mediatek/lvts_mt8192.c
>  create mode 100644 drivers/thermal/mediatek/lvts_mt8195.c
>  rename drivers/thermal/{mtk_thermal.c => mediatek/soc_temp.c} (99%)
>  create mode 100644 drivers/thermal/mediatek/soc_temp_lvts.c
>  create mode 100644 drivers/thermal/mediatek/soc_temp_lvts.h

Given that you're adding a driver that supports both mt8192 and mt8195, and also
the DT thermal nodes for mt8195, maybe you could the DT nodes for mt8192 here as
well?

Thanks,
Nícolas
