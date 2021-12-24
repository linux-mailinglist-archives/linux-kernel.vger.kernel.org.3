Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBD0C47EDD5
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 10:34:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352279AbhLXJew (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 04:34:52 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:35128 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241582AbhLXJev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 04:34:51 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id D8F331F45BEC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1640338490;
        bh=qZF4je+LerA+OqBTDGJZEJVXwlNuPorsNcMLYzAa4mE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Wg3hniFlgAgdm3+vcSd+eEaeyLtW+YGGquc/J66XoOcZZJmWSoP5yHq1QqHbFJ8xg
         a6UBjbyr1qNmhueOZ38UDEgHWRyyB9HeL1TLmBnOdlSHC+WDvm6nGCL4aBd4S8OdET
         wRdm7ILxTeJ0O4Zji5PCMyoIlwnJj/T0UphNwoFSvybGmnV9fGfuQbjCDWXnFX7Ec4
         o8Cw2NB7P3KIUiX8UOG4znfp3z/DNk0gprvhs/ZzD74KMPQKhgW7dSq7jKxDnQZx9J
         rsFOuzP2hrT568VUNyAGUxmBMsX2TqnJkkn9gMaa+8n20439BASD3L6vOzf9fUil9M
         NJ2HkW59ys1KA==
Subject: Re: [PATCH v16 3/7] soc: mediatek: SVS: introduce MTK SVS engine
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
        YT Lee <yt.lee@mediatek.com>,
        Xiaoqing Liu <Xiaoqing.Liu@mediatek.com>,
        Charles Yang <Charles.Yang@mediatek.com>,
        Angus Lin <Angus.Lin@mediatek.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Nishanth Menon <nm@ti.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20210428065440.3704-1-roger.lu@mediatek.com>
 <20210428065440.3704-4-roger.lu@mediatek.com>
 <c97f7dcd-32e5-616e-1bf9-fbd110ecd218@collabora.com>
 <6cdc903250723a6c547bccf2546dd10091b76249.camel@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <fc825af2-7331-fa05-26e0-f3054557333a@collabora.com>
Date:   Fri, 24 Dec 2021 10:34:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <6cdc903250723a6c547bccf2546dd10091b76249.camel@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 24/12/21 10:27, Roger Lu ha scritto:
> Hi AngeloGioacchino,
> 
> Sorry for the late reply and thanks for all the advices.
> 
> On Thu, 2021-10-21 at 10:46 +0200, AngeloGioacchino Del Regno wrote:
>> Il 28/04/21 08:54, Roger Lu ha scritto:
>>> The Smart Voltage Scaling(SVS) engine is a piece of hardware
>>> which calculates suitable SVS bank voltages to OPP voltage table.
>>> Then, DVFS driver could apply those SVS bank voltages to PMIC/Buck
>>> when receiving OPP_EVENT_ADJUST_VOLTAGE.
>>>
>>> Signed-off-by: Roger Lu <roger.lu@mediatek.com>
>>> ---
>>>    drivers/soc/mediatek/Kconfig   |   10 +
>>>    drivers/soc/mediatek/Makefile  |    1 +
>>>    drivers/soc/mediatek/mtk-svs.c | 1723 ++++++++++++++++++++++++++++++++
>>>    3 files changed, 1734 insertions(+)
>>>    create mode 100644 drivers/soc/mediatek/mtk-svs.c
> 
> [snip]
> 
>>> +/* svs bank common setting */
>>> +#define SVSB_DET_CLK_EN			BIT(31)
>>> +#define SVSB_TZONE_HIGH_TEMP_MAX	U32_MAX
>>> +#define SVSB_RUNCONFIG_DEFAULT		0x80000000
>>> +#define SVSB_DC_SIGNED_BIT		0x8000
>>> +#define SVSB_INTEN_INIT0x		0x00005f01
>>> +#define SVSB_INTEN_MONVOPEN		0x00ff0000
>>> +#define SVSB_EN_OFF			0x0
>>> +#define SVSB_EN_MASK			0x7
>>> +#define SVSB_EN_INIT01			0x1
>>> +#define SVSB_EN_INIT02			0x5
>>> +#define SVSB_EN_MON			0x2
>>> +#define SVSB_INTSTS_MONVOP		0x00ff0000
>>> +#define SVSB_INTSTS_COMPLETE		0x1
>>> +#define SVSB_INTSTS_CLEAN		0x00ffffff
>>> +
>>> +static DEFINE_SPINLOCK(mtk_svs_lock);
>>> +
>>> +/*
>>
>> Thanks for using kernel-doc!! However, to be proper, this has to be
>> /**
>>    * ..........
> 
> Oh okay. Thanks. I will use /** to add multi-line comments. However, I checked
> kernel doc-guide and it uses indent as below. So, I'll follow it. If I'm doing
> it wrong, please correct me. Thanks a lot.
> https://www.kernel.org/doc/html/latest/doc-guide/kernel-doc.html
> 
> /**
>   * .........
> 

You're welcome! By the way, yes, the indentation is as shown on the documentation.

Regards,
- Angelo
