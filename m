Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBA11529ECC
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 12:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245716AbiEQKFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 06:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245386AbiEQKFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 06:05:35 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4241F45539
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 03:04:50 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id gh6so33769926ejb.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 03:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TkqgfhBAHMMgBalqrvTDFOjNTPjFrXbry01Ikd0kdOI=;
        b=nHlv6zuxB9JbZ1kWO/hxvdEMAaLFLStrM+H0a9/ffCqJBVMzD+64YCO3vVjeR/qw1x
         Wtvmncr+CmoWF0ZHpR1F3tvTEHo2vvZ2WOfqJlBM6U8CNYcqGg7DPyZGVpUswQdkqM4M
         9VT9VcY56KJ1I7tiA3IBb2UPFz8PtUVbEWHPE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TkqgfhBAHMMgBalqrvTDFOjNTPjFrXbry01Ikd0kdOI=;
        b=TbsvwUX4NGDmyFPdFZnds81HagZWnGPU/EoynYYkxQDfljI4K/zVDKak0RM2oILoMh
         Azj1W+jCuKEFyIZ5eBYHBTjY9LDBlLIloavTYK0HFQ1xDKPNuU78kMP+3FUyEWQCKMAd
         wXMmrv0btIQtvGyusFlXJryoFtPfSp8wWS3JaPQfbQpjqPrguWBZ2SlVviauys33yrVC
         6qIZsMeVIvKTT8Moa3NMq7Mn/hHB2DEnYUkZcSyEIQA3j/DIYj8dQu7P/dGgZRD2KUYf
         VsKNSz0ltl8MMXq89nm4et8YJhiNCso7NqzJ3h+xmJ75t6pTROLfw8tzgvhIQr5tYWQo
         mM+Q==
X-Gm-Message-State: AOAM533WTir+76tJcfaXxVYtFpLiXH8AQA5dmwrhmMM1u6kHADTihj81
        fhegQ2iVXI4tkhGNU8GVuSfumra7fg8XduNc6qDPkQ==
X-Google-Smtp-Source: ABdhPJzKwXDEj+JdNqfJLCrHs8oDN4eTDZdF3mdG81BSdMMdoDedAIMzTlZiJN5CfqOKYW5Byiul9f/04xxDBhzcwHI=
X-Received: by 2002:a17:907:1b14:b0:6ef:a5c8:afbd with SMTP id
 mp20-20020a1709071b1400b006efa5c8afbdmr19498704ejc.151.1652781888704; Tue, 17
 May 2022 03:04:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220516004311.18358-1-roger.lu@mediatek.com>
In-Reply-To: <20220516004311.18358-1-roger.lu@mediatek.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Tue, 17 May 2022 18:04:37 +0800
Message-ID: <CAGXv+5GSdWPZe3fNpBJ_WW0zCL8Skg6fHx9ATxaKU1hyMEt2Ww@mail.gmail.com>
Subject: Re: [PATCH v25 0/7] soc: mediatek: SVS: introduce MTK SVS
To:     Roger Lu <roger.lu@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Enric Balletbo Serra <eballetbo@gmail.com>,
        Kevin Hilman <khilman@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Nicolas Boichat <drinkcat@google.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Fan Chen <fan.chen@mediatek.com>,
        Charles Yang <Charles.Yang@mediatek.com>,
        Angus Lin <Angus.Lin@mediatek.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Nishanth Menon <nm@ti.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Guenter Roeck <linux@roeck-us.net>,
        Jia-wei Chang <jia-wei.chang@mediatek.com>,
        =?UTF-8?B?UmV4LUJDIENoZW4gKOmZs+afj+i+sCk=?= 
        <rex-bc.chen@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 16, 2022 at 8:43 AM Roger Lu <roger.lu@mediatek.com> wrote:
>
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
> Change since v24:
> - Rebase to Linux 5.18-rc6
> - Show specific fail log in svs_platform_probe() to help catch which step fails quickly
> - Remove struct svs_bank member "pd_dev" because all subsys device's power domain has been merged into one node like above [3]
>
> Test in below environment:
> SW: Integration Tree [4] + Thermal patch [5] + SVS v25 (this patchset)
> HW: mt8183-Krane
>
> [4] https://github.com/wens/linux/commits/mt8183-cpufreq-cci-svs-test

I've updated my branch to include all the latest versions of the relevant
patch series:

- anx7625 DPI bus type series v2 (so the display works)
- MT8183 thermal series v9 (this seems to have been overlooked by the
maintainer)
- MTK SVS driver series v25
- devfreq: cpu based scaling support to passive governor series v5
- MTK CCI devfreq series v4
- MT8183 cpufreq series v7
- Additional WIP patches for panfrost MTK devfreq

ChenYu

> [5] https://patchwork.kernel.org/project/linux-pm/patch/20210820095206.30981-1-ben.tseng@mediatek.com
>
> Boots up log:
> [    4.447369]  SVSB_CPU_LITTLE: svs_init01_isr_handler: VDN74~30:0x141e262e~0x33373c42, DC:0x02f3010b
> [    4.447623]  SVSB_CPU_BIG: svs_init01_isr_handler: VDN74~30:0x151f2830~0x363a4046, DC:0x02f90141
> [    4.447872]  SVSB_CCI: svs_init01_isr_handler: VDN74~30:0x141a232b~0x30363d42, DC:0x02ed00d5
> [    4.448119]  SVSB_GPU: svs_init01_isr_handler: VDN74~30:0x1416171a~0x1d202327, DC:0x02f7012f
> [    4.448239]  SVSB_CPU_LITTLE: svs_init02_isr_handler: VOP74~30:0x1b252d35~0x3a3e4349, DC:0x02f30000
> [    4.448343]  SVSB_CPU_BIG: svs_init02_isr_handler: VOP74~30:0x1c262f37~0x3d41474d, DC:0x02f90000
> [    4.448400]  SVSB_CCI: svs_init02_isr_handler: VOP74~30:0x1b212a32~0x373d4449, DC:0x02ed0000
> [    4.448499]  SVSB_GPU: svs_init02_isr_handler: VOP74~30:0x1618191c~0x1f222529, DC:0x02f70000
>
> SVS commands log:
> localhost ~ # cat /sys/kernel/debug/svs/*/*
> init2
> SVSB_CCI: temperature ignore, turn_pt = 0
> opp_freq[00]: 1196000000, opp_volt[00]: 968750, svsb_volt[00]: 0x4b, freq_pct[00]: 100
> opp_freq[01]: 1144000000, opp_volt[01]: 956250, svsb_volt[01]: 0x49, freq_pct[01]: 96
> opp_freq[02]: 1092000000, opp_volt[02]: 937500, svsb_volt[02]: 0x46, freq_pct[02]: 92
> opp_freq[03]: 1027000000, opp_volt[03]: 918750, svsb_volt[03]: 0x43, freq_pct[03]: 86
> opp_freq[04]: 962000000, opp_volt[04]: 893750, svsb_volt[04]: 0x3f, freq_pct[04]: 81
> opp_freq[05]: 923000000, opp_volt[05]: 881250, svsb_volt[05]: 0x3d, freq_pct[05]: 78
> opp_freq[06]: 871000000, opp_volt[06]: 856250, svsb_volt[06]: 0x39, freq_pct[06]: 73
> opp_freq[07]: 845000000, opp_volt[07]: 850000, svsb_volt[07]: 0x38, freq_pct[07]: 71
> opp_freq[08]: 767000000, opp_volt[08]: 825000, svsb_volt[08]: 0x34, freq_pct[08]: 65
> opp_freq[09]: 689000000, opp_volt[09]: 800000, svsb_volt[09]: 0x30, freq_pct[09]: 58
> opp_freq[10]: 624000000, opp_volt[10]: 775000, svsb_volt[10]: 0x2c, freq_pct[10]: 53
> opp_freq[11]: 546000000, opp_volt[11]: 750000, svsb_volt[11]: 0x28, freq_pct[11]: 46
> opp_freq[12]: 463000000, opp_volt[12]: 718750, svsb_volt[12]: 0x23, freq_pct[12]: 39
> opp_freq[13]: 403000000, opp_volt[13]: 700000, svsb_volt[13]: 0x20, freq_pct[13]: 34
> opp_freq[14]: 338000000, opp_volt[14]: 681250, svsb_volt[14]: 0x1d, freq_pct[14]: 29
> opp_freq[15]: 273000000, opp_volt[15]: 650000, svsb_volt[15]: 0x1a, freq_pct[15]: 23
> init2
> SVSB_CPU_BIG: temperature ignore, turn_pt = 0
> opp_freq[00]: 1989000000, opp_volt[00]: 1050000, svsb_volt[00]: 0x59, freq_pct[00]: 100
> opp_freq[01]: 1924000000, opp_volt[01]: 1025000, svsb_volt[01]: 0x57, freq_pct[01]: 97
> opp_freq[02]: 1846000000, opp_volt[02]: 1000000, svsb_volt[02]: 0x53, freq_pct[02]: 93
> opp_freq[03]: 1781000000, opp_volt[03]: 975000, svsb_volt[03]: 0x50, freq_pct[03]: 90
> opp_freq[04]: 1716000000, opp_volt[04]: 950000, svsb_volt[04]: 0x4d, freq_pct[04]: 87
> opp_freq[05]: 1677000000, opp_volt[05]: 931250, svsb_volt[05]: 0x4c, freq_pct[05]: 85
> opp_freq[06]: 1625000000, opp_volt[06]: 912500, svsb_volt[06]: 0x49, freq_pct[06]: 82
> opp_freq[07]: 1586000000, opp_volt[07]: 900000, svsb_volt[07]: 0x47, freq_pct[07]: 80
> opp_freq[08]: 1508000000, opp_volt[08]: 875000, svsb_volt[08]: 0x43, freq_pct[08]: 76
> opp_freq[09]: 1417000000, opp_volt[09]: 850000, svsb_volt[09]: 0x40, freq_pct[09]: 72
> opp_freq[10]: 1326000000, opp_volt[10]: 825000, svsb_volt[10]: 0x3b, freq_pct[10]: 67
> opp_freq[11]: 1248000000, opp_volt[11]: 800000, svsb_volt[11]: 0x38, freq_pct[11]: 63
> opp_freq[12]: 1131000000, opp_volt[12]: 775000, svsb_volt[12]: 0x32, freq_pct[12]: 57
> opp_freq[13]: 1014000000, opp_volt[13]: 750000, svsb_volt[13]: 0x2d, freq_pct[13]: 51
> opp_freq[14]: 910000000, opp_volt[14]: 725000, svsb_volt[14]: 0x28, freq_pct[14]: 46
> opp_freq[15]: 793000000, opp_volt[15]: 700000, svsb_volt[15]: 0x23, freq_pct[15]: 40
> init2
> SVSB_CPU_LITTLE: temperature ignore, turn_pt = 0
> opp_freq[00]: 1989000000, opp_volt[00]: 968750, svsb_volt[00]: 0x4b, freq_pct[00]: 100
> opp_freq[01]: 1924000000, opp_volt[01]: 956250, svsb_volt[01]: 0x49, freq_pct[01]: 97
> opp_freq[02]: 1846000000, opp_volt[02]: 931250, svsb_volt[02]: 0x45, freq_pct[02]: 93
> opp_freq[03]: 1781000000, opp_volt[03]: 918750, svsb_volt[03]: 0x43, freq_pct[03]: 90
> opp_freq[04]: 1716000000, opp_volt[04]: 900000, svsb_volt[04]: 0x40, freq_pct[04]: 87
> opp_freq[05]: 1677000000, opp_volt[05]: 893750, svsb_volt[05]: 0x3f, freq_pct[05]: 85
> opp_freq[06]: 1625000000, opp_volt[06]: 875000, svsb_volt[06]: 0x3c, freq_pct[06]: 82
> opp_freq[07]: 1586000000, opp_volt[07]: 868750, svsb_volt[07]: 0x3b, freq_pct[07]: 80
> opp_freq[08]: 1508000000, opp_volt[08]: 843750, svsb_volt[08]: 0x37, freq_pct[08]: 76
> opp_freq[09]: 1417000000, opp_volt[09]: 825000, svsb_volt[09]: 0x34, freq_pct[09]: 72
> opp_freq[10]: 1326000000, opp_volt[10]: 793750, svsb_volt[10]: 0x2f, freq_pct[10]: 67
> opp_freq[11]: 1248000000, opp_volt[11]: 775000, svsb_volt[11]: 0x2c, freq_pct[11]: 63
> opp_freq[12]: 1131000000, opp_volt[12]: 743750, svsb_volt[12]: 0x27, freq_pct[12]: 57
> opp_freq[13]: 1014000000, opp_volt[13]: 712500, svsb_volt[13]: 0x22, freq_pct[13]: 51
> opp_freq[14]: 910000000, opp_volt[14]: 681250, svsb_volt[14]: 0x1d, freq_pct[14]: 46
> opp_freq[15]: 793000000, opp_volt[15]: 650000, svsb_volt[15]: 0x18, freq_pct[15]: 40
> mon mode
> SVSB_GPU: temperature = 33492, turn_pt = 0
> opp_freq[00]: 800000000, opp_volt[00]: 743750, svsb_volt[00]: 0x27, freq_pct[00]: 100
> opp_freq[01]: 743000000, opp_volt[01]: 731250, svsb_volt[01]: 0x25, freq_pct[01]: 93
> opp_freq[02]: 698000000, opp_volt[02]: 718750, svsb_volt[02]: 0x23, freq_pct[02]: 88
> opp_freq[03]: 653000000, opp_volt[03]: 712500, svsb_volt[03]: 0x22, freq_pct[03]: 82
> opp_freq[04]: 620000000, opp_volt[04]: 700000, svsb_volt[04]: 0x20, freq_pct[04]: 78
> opp_freq[05]: 580000000, opp_volt[05]: 693750, svsb_volt[05]: 0x1f, freq_pct[05]: 73
> opp_freq[06]: 540000000, opp_volt[06]: 681250, svsb_volt[06]: 0x1d, freq_pct[06]: 68
> opp_freq[07]: 500000000, opp_volt[07]: 675000, svsb_volt[07]: 0x1c, freq_pct[07]: 63
> opp_freq[08]: 460000000, opp_volt[08]: 662500, svsb_volt[08]: 0x1a, freq_pct[08]: 58
> opp_freq[09]: 420000000, opp_volt[09]: 656250, svsb_volt[09]: 0x19, freq_pct[09]: 53
> opp_freq[10]: 400000000, opp_volt[10]: 643750, svsb_volt[10]: 0x17, freq_pct[10]: 50
> opp_freq[11]: 380000000, opp_volt[11]: 643750, svsb_volt[11]: 0x17, freq_pct[11]: 48
> opp_freq[12]: 360000000, opp_volt[12]: 637500, svsb_volt[12]: 0x16, freq_pct[12]: 45
> opp_freq[13]: 340000000, opp_volt[13]: 637500, svsb_volt[13]: 0x16, freq_pct[13]: 43
> opp_freq[14]: 320000000, opp_volt[14]: 625000, svsb_volt[14]: 0x14, freq_pct[14]: 40
> opp_freq[15]: 300000000, opp_volt[15]: 625000, svsb_volt[15]: 0x14, freq_pct[15]: 38
>
> Roger Lu (7):
>   [v25,1/7] dt-bindings: soc: mediatek: add mtk svs dt-bindings
>   [v25,2/7] arm64: dts: mt8183: add svs device information
>   [v25,3/7] soc: mediatek: SVS: introduce MTK SVS engine
>   [v25,4/7] soc: mediatek: SVS: add monitor mode
>   [v25,5/7] soc: mediatek: SVS: add debug commands
>   [v25,6/7] dt-bindings: soc: mediatek: add mt8192 svs dt-bindings
>   [v25,7/7] soc: mediatek: SVS: add mt8192 SVS GPU driver
>
>  .../bindings/soc/mediatek/mtk-svs.yaml        |   91 +
>  arch/arm64/boot/dts/mediatek/mt8183.dtsi      |   16 +
>  drivers/soc/mediatek/Kconfig                  |   10 +
>  drivers/soc/mediatek/Makefile                 |    1 +
>  drivers/soc/mediatek/mtk-svs.c                | 2399 +++++++++++++++++
>  5 files changed, 2517 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/mediatek/mtk-svs.yaml
>  create mode 100644 drivers/soc/mediatek/mtk-svs.c
>
>
>
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
