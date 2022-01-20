Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD57B49459D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 02:47:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358095AbiATBrJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 20:47:09 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:34354 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1358052AbiATBrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 20:47:07 -0500
X-UUID: 242f6a14f1454019a8b2e2b6c9b59e30-20220120
X-UUID: 242f6a14f1454019a8b2e2b6c9b59e30-20220120
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <guodong.liu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1829855336; Thu, 20 Jan 2022 09:47:02 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Thu, 20 Jan 2022 09:47:01 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 20 Jan 2022 09:47:00 +0800
Message-ID: <883391d5642d217e79fb09bebd81f9b5027ce20a.camel@mediatek.com>
Subject: Re: [PATCH 2/7] pinctrl: mediatek: paris: Fix
 PIN_CONFIG_BIAS_DISABLE readback
From:   Guodong Liu <guodong.liu@mediatek.com>
To:     Chen-Yu Tsai <wenst@chromium.org>
CC:     Sean Wang <sean.wang@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-mediatek@lists.infradead.org>, <linux-gpio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        Hui Liu <hui.liu@mediatek.com>,
        Light Hsieh <light.hsieh@mediatek.com>
Date:   Thu, 20 Jan 2022 09:47:00 +0800
In-Reply-To: <CAGXv+5GHVtCO9tN7B0O2c5V_Bk61-LL79LvbE1CRbyBfnvKSGQ@mail.gmail.com>
References: <20220111112244.1483783-1-wenst@chromium.org>
         <20220111112244.1483783-3-wenst@chromium.org>
         <eca4a0c18fe75536c8276410628b9459c040dce2.camel@mediatek.com>
         <CAGXv+5GHVtCO9tN7B0O2c5V_Bk61-LL79LvbE1CRbyBfnvKSGQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-----Original Message-----
From: Chen-Yu Tsai <wenst@chromium.org>
To: Guodong Liu <guodong.liu@mediatek.com>
Cc: Sean Wang <sean.wang@kernel.org>, Linus Walleij <
linus.walleij@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org, 
linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
Zhiyong Tao <zhiyong.tao@mediatek.com>, Hui Liu <hui.liu@mediatek.com>,
Light Hsieh <light.hsieh@mediatek.com>
Subject: Re: [PATCH 2/7] pinctrl: mediatek: paris: Fix
PIN_CONFIG_BIAS_DISABLE readback
Date: Wed, 19 Jan 2022 13:57:18 +0800

On Wed, Jan 19, 2022 at 9:42 AM Guodong Liu <guodong.liu@mediatek.com>
wrote:
> 
> -----Original Message-----
> From: Chen-Yu Tsai <wenst@chromium.org>
> To: Sean Wang <sean.wang@kernel.org>, Linus Walleij <
> linus.walleij@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>
> Cc: Chen-Yu Tsai <wenst@chromium.org>,
> linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
> linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
> Zhiyong Tao <zhiyong.tao@mediatek.com>, Guodong Liu <
> guodong.liu@mediatek.com>
> Subject: [PATCH 2/7] pinctrl: mediatek: paris: Fix
> PIN_CONFIG_BIAS_DISABLE readback
> Date: Tue, 11 Jan 2022 19:22:39 +0800
> 
> When reading back pin bias settings, if the pin is not in a
> bias-disabled state, the function should return -EINVAL.
> 
> Fix this in the mediatek-paris pinctrl library so that the read back
> state is not littered with bogus a "input bias disabled" combined
> with
> "pull up" or "pull down" states.
> 
> Fixes: 805250982bb5 ("pinctrl: mediatek: add pinctrl-paris that
> implements the vendor dt-bindings")
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
>  drivers/pinctrl/mediatek/pinctrl-paris.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pinctrl/mediatek/pinctrl-paris.c
> b/drivers/pinctrl/mediatek/pinctrl-paris.c
> index f9f9110f2107..1ca598ea7ba7 100644
> --- a/drivers/pinctrl/mediatek/pinctrl-paris.c
> +++ b/drivers/pinctrl/mediatek/pinctrl-paris.c
> @@ -97,8 +97,8 @@ static int mtk_pinconf_get(struct pinctrl_dev
> *pctldev,
>                         if (err)
>                                 goto out;
>                         if (param == PIN_CONFIG_BIAS_DISABLE) {
> -                               if (ret == MTK_PUPD_SET_R1R0_00)
> -                                       ret = MTK_DISABLE;
> +                               if (ret != MTK_PUPD_SET_R1R0_00)
> +                                       err = -EINVAL;
> Hi Chen-Yu
> 
> When the API "hw->soc->bias_get_combo(hw, desc, &pullup, &ret)" is
> called,
> The ret vaule of ret may be MTK_DISABLE or MTK_PUPD_SET_R1R0_00
> or  (pullen
> == 0),  All those cases are expected to be as "bias-disable".
> We advices to keep original code,
> +                               if (ret == MTK_PUPD_SET_R1R0_00)
> +                                       ret = MTK_DISABLE;
> +                               if (ret != MTK_DISABLE)
> +                                       err = -EINVAL;

IIUC you are suggesting to assign MTK_DISABLE to ret in the other two
cases,
and then check if ret == MTK_DISABLE.

Thanks for pointing that out.

ChenYu

> Thanks

Hi Chen-Yu

Yes, just for pins with config of MTK_PUPD_SET_R1R0_00 are required to
do additional assignment operations(ret = MTK_DISABLE;), in the other
two cases, the assignment operations of ret as MTK_DISABLE is obtained
by function call "hw->soc->bias_get_combo(hw, desc, &pullup, &ret)".

Thanks

>                         } else if (param == PIN_CONFIG_BIAS_PULL_UP)
> {
>                                 /* When desire to get pull-up value,
> return
>                                  *  error if current setting is pull-
> down
> 

