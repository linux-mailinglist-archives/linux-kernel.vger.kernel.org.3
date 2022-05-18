Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD42452B15E
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 06:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbiERESP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 00:18:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbiERESK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 00:18:10 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 210C92715E
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 21:18:07 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id i27so1376367ejd.9
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 21:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LepV/V/rw3KHQSLPiaLiP/J9OYk0ZMB5clNI2uCKxco=;
        b=mRXr4u8V1f/S5RyW1JNxJSUxM+z8+ui74rqnugYbsf5s6dbwGsmqlLlN6ZYgsgxcCG
         bKqcvOMQ23KO1SE+HPFpaE4W1qrmrT2D8ZaS/yHhKJAVJUeQfwrZc2JzpntyqucghdZ6
         lX6dQbdT98u6OdtodRJPm107TfKlDpvepIP+w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LepV/V/rw3KHQSLPiaLiP/J9OYk0ZMB5clNI2uCKxco=;
        b=WJmZRZus9ykP2dae/uIHx2C2+ZxHVHsrSWPFO0cLyvMWi8E4iaW9GO7qwrRI4K/bIt
         NIBXfr7CjMoRqMNBBIVzU9bDKWuckD5Mf1XvqsNMuX3R2WdG06A56KxerNJSX8pebQHk
         qAumNK/Zwc/g9FlPV8fChZRv4jWXnweE3WGh0cyL6Fp948wduzb55P45eC76tmQ1s29s
         tW4LmvgwgIi6PsjcY2buRLoZeIK59dK6RJFIU8xrmlC56JTkOaicIeJwrbmvAr1a+FL5
         +qm5UtK+XwmfK88RjozkhKiaxog1H/oeE13jvDYBXlsK89qjfz3nDMY664in+4BTs0xq
         kVGQ==
X-Gm-Message-State: AOAM5316Bj+Dq0mYYyWcGPB2MV52s27MKtUpmB9ze+0/9nnkLWb55oA8
        tZU2x8rCyLOaxXCXkX7knCZ+VXZvJQ2+xxcshLw0NQ==
X-Google-Smtp-Source: ABdhPJx2Eb3PB99mTXrpervjGP3hlbnI5chnI8LPmgJy/jBWlyWBov63NZ3kC2St8DMKHxEfsAkr7rAxBXKeSKpzdBI=
X-Received: by 2002:a17:906:c142:b0:6da:9781:ae5d with SMTP id
 dp2-20020a170906c14200b006da9781ae5dmr21221643ejc.73.1652847485641; Tue, 17
 May 2022 21:18:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220516004311.18358-1-roger.lu@mediatek.com> <CAGXv+5GSdWPZe3fNpBJ_WW0zCL8Skg6fHx9ATxaKU1hyMEt2Ww@mail.gmail.com>
 <7h4k1ndaui.fsf@baylibre.com> <7hy1yzbtb7.fsf@baylibre.com>
In-Reply-To: <7hy1yzbtb7.fsf@baylibre.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Wed, 18 May 2022 12:17:54 +0800
Message-ID: <CAGXv+5GT=3m=pVPwUOWR42BR=emCpBXvvoAiRV7YKt2kEKWdAQ@mail.gmail.com>
Subject: Re: [PATCH v25 0/7] soc: mediatek: SVS: introduce MTK SVS
To:     Kevin Hilman <khilman@kernel.org>, cw00.choi@samsung.com
Cc:     Roger Lu <roger.lu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Enric Balletbo Serra <eballetbo@gmail.com>,
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

n Wed, May 18, 2022 at 8:03 AM Kevin Hilman <khilman@kernel.org> wrote:
>
> Kevin Hilman <khilman@kernel.org> writes:
>
> > Chen-Yu Tsai <wenst@chromium.org> writes:
> >
> >> On Mon, May 16, 2022 at 8:43 AM Roger Lu <roger.lu@mediatek.com> wrote:
> >>>
> >>> The Smart Voltage Scaling(SVS) engine is a piece of hardware
> >>> which calculates suitable SVS bank voltages to OPP voltage table.
> >>> Then, DVFS driver could apply those SVS bank voltages to PMIC/Buck
> >>> when receiving OPP_EVENT_ADJUST_VOLTAGE.
> >>>
> >>> 1. SVS driver uses OPP adjust event in [1] to update OPP table voltage part.
> >>> 2. SVS driver gets thermal/GPU device by node [2][3] and CPU device by get_cpu_device().
> >>> After retrieving subsys device, SVS driver calls device_link_add() to make sure probe/suspend callback priority.
> >>>
> >>> [1] https://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git/commit/?h=opp/linux-next&id=25cb20a212a1f989385dfe23230817e69c62bee5
> >>> [2] https://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git/commit/?h=opp/linux-next&id=b325ce39785b1408040d90365a6ab1aa36e94f87
> >>> [3] https://git.kernel.org/pub/scm/linux/kernel/git/matthias.bgg/linux.git/commit/?h=v5.16-next/dts64&id=a8168cebf1bca1b5269e8a7eb2626fb76814d6e2
> >>>
> >>> Change since v24:
> >>> - Rebase to Linux 5.18-rc6
> >>> - Show specific fail log in svs_platform_probe() to help catch which step fails quickly
> >>> - Remove struct svs_bank member "pd_dev" because all subsys device's power domain has been merged into one node like above [3]
> >>>
> >>> Test in below environment:
> >>> SW: Integration Tree [4] + Thermal patch [5] + SVS v25 (this patchset)
> >>> HW: mt8183-Krane
> >>>
> >>> [4] https://github.com/wens/linux/commits/mt8183-cpufreq-cci-svs-test
> >>
> >> I've updated my branch to include all the latest versions of the relevant
> >> patch series:
> >>
> >> - anx7625 DPI bus type series v2 (so the display works)
> >> - MT8183 thermal series v9 (this seems to have been overlooked by the
> >> maintainer)
> >> - MTK SVS driver series v25
> >> - devfreq: cpu based scaling support to passive governor series v5
> >> - MTK CCI devfreq series v4
> >> - MT8183 cpufreq series v7
> >> - Additional WIP patches for panfrost MTK devfreq
> >
> > Thanks for preparing an integration branch Chen-Yu.
> >
> > I'm testing this on mt8183-pumpkin with one patch to add the CCI
> > regulator[1], and the defconfig you posted in a previous rev of this
> > series, but the CCI driver still causes a fault on boot[2] on my
> > platform.
> >
> > I mentioned in earlier reviews that I think there's potentially a race
> > between CCI and SVS loading since they are co-dependent.  My hunch is
> > that this is still not being handled properly.
>
> Ah, actually it's crashing when I try to boot the platform with
> `maxcpus=4` on the cmdline (which I have to do because mt8183-pumpkin is
> unstable upstream with the 2nd cluster enabled.)
>
> The CCI driver should be a bit more robust about detecting
> available/online CPUs

This all seems to be handled in the devfreq passive governor.

And presumably we'd like to have CCI devfreq running even if just one
core was booted.

Added Chanwoo for more ideas.

ChenYu


> If I boot with both clusters, I see SVS probing[1], and I see CCI
> doing transitions[2]
>
> Kevin
>
>
> [1]
> # dmesg |grep -i svs
> [    0.739298] mtk-svs 1100b000.svs: M_HW_RES0: 0x00120090
> [    0.739315] mtk-svs 1100b000.svs: M_HW_RES1: 0xa6fdfb5b
> [    0.739318] mtk-svs 1100b000.svs: M_HW_RES2: 0x47cb47cb
> [    0.739321] mtk-svs 1100b000.svs: M_HW_RES3: 0xa6fdfb5b
> [    0.739324] mtk-svs 1100b000.svs: M_HW_RES4: 0xa6fde4ad
> [    0.739326] mtk-svs 1100b000.svs: M_HW_RES5: 0x47f84b80
> [    0.739328] mtk-svs 1100b000.svs: M_HW_RES6: 0xa6fd87a6
> [    0.739331] mtk-svs 1100b000.svs: M_HW_RES7: 0xa6fddf4a
> [    0.739333] mtk-svs 1100b000.svs: M_HW_RES8: 0x4bf84be5
> [    0.739335] mtk-svs 1100b000.svs: M_HW_RES9: 0xa6fd3267
> [    0.739338] mtk-svs 1100b000.svs: M_HW_RES14: 0x9696d5ab
> [    0.739340] mtk-svs 1100b000.svs: M_HW_RES15: 0x015a0015
> [    0.739343] mtk-svs 1100b000.svs: M_HW_RES16: 0xa6fdf05d
> [    0.739345] mtk-svs 1100b000.svs: M_HW_RES17: 0x47f847e5
> [    0.739347] mtk-svs 1100b000.svs: M_HW_RES18: 0xa6fdc240
> [    0.741890]  SVSB_CPU_LITTLE: svs_init01_isr_handler: VDN74~30:0x141c242a~0x2f32373c, DC:0x0316ff30
> [    0.742165]  SVSB_CPU_BIG: svs_init01_isr_handler: VDN74~30:0x141e262e~0x33373c42, DC:0x031aff50
> [    0.742431]  SVSB_CCI: svs_init01_isr_handler: VDN74~30:0x13192128~0x2d31383c, DC:0x0314ff20
> [    0.742696]  SVSB_GPU: svs_init01_isr_handler: VDN74~30:0x1416181a~0x1d202428, DC:0x030efef0
> [    0.742875]  SVSB_CPU_LITTLE: svs_init02_isr_handler: VOP74~30:0x1d252c33~0x373b3f45, DC:0x031600d0
> [    0.742989]  SVSB_CPU_BIG: svs_init02_isr_handler: VOP74~30:0x1d262e36~0x3b3f444a, DC:0x031a00b0
> [    0.743060]  SVSB_CCI: svs_init02_isr_handler: VOP74~30:0x1c222a31~0x353a4045, DC:0x031400e0
> [    0.743176]  SVSB_GPU: svs_init02_isr_handler: VOP74~30:0x181a1c1e~0x2125282c, DC:0x030e0110
>
> [2]
> # cat /sys/class/devfreq/cci/trans_stat
>      From  :   To
>            : 273000000 338000000 403000000 463000000 546000000 624000000 689000000 767000000 845000000 871000000 923000000 9620000001027000000109200000011440000001196000000   time(ms)
>   273000000:         0        77        11        10        34         8         6         8         3         3         0         0         4         1         2        12    135675
>   338000000:        90         0        32         4         7         2         1         0         0         0         0         0         0         0         0         2       664
>   403000000:        20        45         0        35         7         2         0         0         0         0         0         0         0         0         0         0       509
>   463000000:        13         7        53         0        46         4         1         1         1         2         0         1         2         0         0         1       568
>   546000000:        12         5        10        63         0        55         3         3         3         1         3         2         8         3         1        35       858
> * 624000000:         4         0         2        10        50         0        49         1         1         0         0         1         3         2         0         7       407
>   689000000:         6         1         0         2        18        36         0        47         5         3         1         0         1         0         0        10       388
>   767000000:         2         1         0         3         5        11        42         0        35         4         1         1         2         0         1        23       486
>   845000000:         3         0         0         0         1         0         9        27         0        37         8         1         0         0         2        23       290
>   871000000:         2         0         0         1         0         0         3         9        19         0        29         5         1         1         1        12       179
>   923000000:         0         0         0         0         0         2         2         7        10        13         0        31         1         1         0         4       154
>   962000000:         0         0         0         0         0         1         0         4         3         4        14         0        27         1         0         2       123
>  1027000000:         2         0         0         1         2         2         3         2         1         1         7        11         0        24         2         1       182
>  1092000000:         1         0         0         0         3         2         0         1         2         0         0         1         5         0        25         5       123
>  1144000000:         2         0         0         0         0         0         0         0         2         0         1         1         2         7         0        38       193
>  1196000000:        22         2         1         3        34         6        11        21        26        15         7         1         3         5        19         0      1621
> Total transition : 1810
