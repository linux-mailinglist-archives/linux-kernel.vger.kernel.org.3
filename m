Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA4FA57C6EB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 10:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232662AbiGUIyD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 04:54:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232651AbiGUIyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 04:54:00 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40B127FE4B;
        Thu, 21 Jul 2022 01:53:59 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 53B1D66019C1;
        Thu, 21 Jul 2022 09:53:56 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1658393637;
        bh=PWaD409ygy+Er3xoqJTY1NemC1LqQPgB8DQibUFvffo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=HFOn3jmV7jaLw7oD5M8TZqbVkyn5IY9/ekzUHdGUjK/NHL0uQjPZSsNphdJQoNF7r
         KaYZk9/u1Inf/eei+TdvpOSTrp043auyfH1Mz92Z3tjnig+WQbj+BguEmG8NKpBByH
         QXf9Jx4YBsQqBLdTKYBevHn0R7FB5FkaS0JWgai+EsUO/RTwYieoqVdeVJID3ehKMq
         UIaXr6YLUR7zVEqt/ngzQ2UFcUi81uo6pWD2ggbRKqxjfsUOFW/laJAvAP//4+Cv23
         nMYwM7s/NdsuIdKpiDI35PzXW+ymxuN7ejOJ8RPT/P5VjWE/urap5HmsruvVVrXCoY
         gKam2qjT/QF6g==
Message-ID: <45ff2e82-caeb-9575-ce73-1bd43c37c0c5@collabora.com>
Date:   Thu, 21 Jul 2022 10:53:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v5 0/7] MediaTek Helio X10 MT6795 - Clock drivers
Content-Language: en-US
To:     robh+dt@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        mturquette@baylibre.com, sboyd@kernel.org, p.zabel@pengutronix.de,
        y.oudjana@protonmail.com, jason-jh.lin@mediatek.com,
        ck.hu@mediatek.com, fparent@baylibre.com, rex-bc.chen@mediatek.com,
        tinghan.shen@mediatek.com, chun-jie.chen@mediatek.com,
        weiyi.lu@mediatek.com, ikjn@chromium.org, miles.chen@mediatek.com,
        sam.shih@mediatek.com, wenst@chromium.org,
        bgolaszewski@baylibre.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        konrad.dybcio@somainline.org, marijn.suijten@somainline.org,
        martin.botka@somainline.org, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org, paul.bouchara@somainline.org,
        kernel@collabora.com
References: <20220629110254.184213-1-angelogioacchino.delregno@collabora.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220629110254.184213-1-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 29/06/22 13:02, AngeloGioacchino Del Regno ha scritto:
> In an effort to give some love to the apparently forgotten MT6795 SoC,
> I am upstreaming more components that are necessary to support platforms
> powered by this one apart from a simple boot to serial console.
> 
> This (very big) series introduces system clock, multimedia clock drivers
> (including resets) for this SoC.
> 
> Tested on a MT6795 Sony Xperia M5 (codename "Holly") smartphone.
> 
> This series depends on, and can be merged on top of:
> [1]: https://patchwork.kernel.org/project/linux-mediatek/list/?series=640122
> [2]: https://patchwork.kernel.org/project/linux-mediatek/list/?series=637849
> 

Gentle ping for this series...
...I've got a lot of commits to send that depend on this one...

P.S.: The dependencies in [1] and [2] are already upstream.

Cheers,
Angelo


> Changes in v5:
>   - Renamed clock/reset header filenames to add vendor prefix
>   - Removed quotes for $id, $schema in commit [4/7]
> 
> Changes in v4:
>   - Removed unnecessary examples for clock controllers in commit [4/7]
>   - Fixed one instance of 88 columns line wrap in commit [4/7]
> 
> Changes in v3:
>   - Fixed typo in commit [4/7]
> 
> Changes in v2:
>   - Fixed yaml clock bindings as per Rob's review
>   - Added ability to compile all MT6795 clock drivers as modules
>   - Added commits to export some symbols, required to compile as module
> AngeloGioacchino Del Regno (7):
>    dt-bindings: mediatek: Document MT6795 system controllers bindings
>    dt-bindings: clock: Add MediaTek Helio X10 MT6795 clock bindings
>    dt-bindings: reset: Add bindings for MT6795 Helio X10 reset
>      controllers
>    dt-bindings: clock: mediatek: Add clock driver bindings for MT6795
>    clk: mediatek: clk-apmixed: Remove unneeded __init annotation
>    clk: mediatek: Export required symbols to compile clk drivers as
>      module
>    clk: mediatek: Add MediaTek Helio X10 MT6795 clock drivers
> 
>   .../arm/mediatek/mediatek,infracfg.yaml       |   2 +
>   .../bindings/arm/mediatek/mediatek,mmsys.yaml |   1 +
>   .../arm/mediatek/mediatek,pericfg.yaml        |   1 +
>   .../bindings/clock/mediatek,apmixedsys.yaml   |   1 +
>   .../bindings/clock/mediatek,mt6795-clock.yaml |  66 ++
>   .../clock/mediatek,mt6795-sys-clock.yaml      |  54 ++
>   .../bindings/clock/mediatek,topckgen.yaml     |   1 +
>   drivers/clk/mediatek/Kconfig                  |  37 ++
>   drivers/clk/mediatek/Makefile                 |   6 +
>   drivers/clk/mediatek/clk-apmixed.c            |   3 +-
>   drivers/clk/mediatek/clk-cpumux.c             |   2 +
>   drivers/clk/mediatek/clk-mt6795-apmixedsys.c  | 157 +++++
>   drivers/clk/mediatek/clk-mt6795-infracfg.c    | 148 +++++
>   drivers/clk/mediatek/clk-mt6795-mfg.c         |  50 ++
>   drivers/clk/mediatek/clk-mt6795-mm.c          | 106 +++
>   drivers/clk/mediatek/clk-mt6795-pericfg.c     | 160 +++++
>   drivers/clk/mediatek/clk-mt6795-topckgen.c    | 610 ++++++++++++++++++
>   drivers/clk/mediatek/clk-mt6795-vdecsys.c     |  55 ++
>   drivers/clk/mediatek/clk-mt6795-vencsys.c     |  50 ++
>   drivers/clk/mediatek/clk-mtk.c                |   2 +
>   drivers/clk/mediatek/reset.c                  |   1 +
>   .../dt-bindings/clock/mediatek,mt6795-clk.h   | 275 ++++++++
>   .../reset/mediatek,mt6795-resets.h            |  50 ++
>   23 files changed, 1837 insertions(+), 1 deletion(-)
>   create mode 100644 Documentation/devicetree/bindings/clock/mediatek,mt6795-clock.yaml
>   create mode 100644 Documentation/devicetree/bindings/clock/mediatek,mt6795-sys-clock.yaml
>   create mode 100644 drivers/clk/mediatek/clk-mt6795-apmixedsys.c
>   create mode 100644 drivers/clk/mediatek/clk-mt6795-infracfg.c
>   create mode 100644 drivers/clk/mediatek/clk-mt6795-mfg.c
>   create mode 100644 drivers/clk/mediatek/clk-mt6795-mm.c
>   create mode 100644 drivers/clk/mediatek/clk-mt6795-pericfg.c
>   create mode 100644 drivers/clk/mediatek/clk-mt6795-topckgen.c
>   create mode 100644 drivers/clk/mediatek/clk-mt6795-vdecsys.c
>   create mode 100644 drivers/clk/mediatek/clk-mt6795-vencsys.c
>   create mode 100644 include/dt-bindings/clock/mediatek,mt6795-clk.h
>   create mode 100644 include/dt-bindings/reset/mediatek,mt6795-resets.h
> 


