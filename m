Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34EE150B2E2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 10:28:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445324AbiDVIaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 04:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352644AbiDVIaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 04:30:08 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 254C352B3B;
        Fri, 22 Apr 2022 01:27:14 -0700 (PDT)
X-UUID: ea650a0e53054247b5d5f0fc411a6aa4-20220422
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:172de966-de87-4395-a575-6cf4b6ff827c,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:faefae9,CLOUDID:3b9398f0-da02-41b4-b6df-58f4ccd36682,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,File:nil,QS:0,BEC:nil
X-UUID: ea650a0e53054247b5d5f0fc411a6aa4-20220422
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 970442411; Fri, 22 Apr 2022 16:27:10 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Fri, 22 Apr 2022 16:27:08 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 22 Apr 2022 16:27:08 +0800
Message-ID: <3765ba9fb62cef8fe9279ba5d6ded1c8b5b31a82.camel@mediatek.com>
Subject: Re: [PATCH v2 1/1] pwrap: mediatek: fix FSM timeout issue
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     Zhiyong Tao <zhiyong.tao@mediatek.com>, <lee.jones@linaro.org>,
        <robh+dt@kernel.org>, <matthias.bgg@gmail.com>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>,
        <eddie.huang@mediatek.com>, <a.zummo@towertech.it>,
        <alexandre.belloni@bootlin.com>, <fshao@chromium.org>
CC:     <srv_heupstream@mediatek.com>, <hui.liu@mediatek.com>,
        <tinghan.shen@mediatek.com>, <hsin-hsiung.wang@mediatek.com>,
        <sean.wang@mediatek.com>, <macpaul.lin@mediatek.com>,
        <wen.su@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-rtc@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Date:   Fri, 22 Apr 2022 16:27:08 +0800
In-Reply-To: <20220422033423.11702-2-zhiyong.tao@mediatek.com>
References: <20220422033423.11702-1-zhiyong.tao@mediatek.com>
         <20220422033423.11702-2-zhiyong.tao@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-04-22 at 11:34 +0800, Zhiyong Tao wrote:
> From: "Zhiyong.Tao" <zhiyong.tao@mediatek.com>
> 
> Fix pwrap FSM timeout issue which leads the system crash on GFX VSRAM
> power on.
> Add a usleep delay to avoid busy read for the H/W status.
> For avoiding the system behavior(ex. disable interrupt in
> suspend/resume
> flow, schedule block task)cause if (time_after()) be turn first,
> we change it after sleep delay.
> 

Hello Zhiyong,

if this is a fix patch.
IMO, you should add Fixes tag:

Fixes: 1f022d84bd19 ("soc: mediatek: Add PMIC wrapper for MT8135 and
MT8173 SoCs")

> Signed-off-by: Zhiyong.Tao <zhiyong.tao@mediatek.com>
> ---
>  drivers/soc/mediatek/mtk-pmic-wrap.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>  mode change 100644 => 100755 drivers/soc/mediatek/mtk-pmic-wrap.c
> 

File mode should be 100644.

BRs,
Rex

> diff --git a/drivers/soc/mediatek/mtk-pmic-wrap.c
> b/drivers/soc/mediatek/mtk-pmic-wrap.c
> old mode 100644
> new mode 100755
> index 952bc554f443..ac7139a67e87
> --- a/drivers/soc/mediatek/mtk-pmic-wrap.c
> +++ b/drivers/soc/mediatek/mtk-pmic-wrap.c
> @@ -12,6 +12,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/regmap.h>
>  #include <linux/reset.h>
> +#include <linux/delay.h>
>  
>  #define PWRAP_MT8135_BRIDGE_IORD_ARB_EN		0x4
>  #define PWRAP_MT8135_BRIDGE_WACS3_EN		0x10
> @@ -1197,10 +1198,13 @@ static int pwrap_wait_for_state(struct
> pmic_wrapper *wrp,
>  	timeout = jiffies + usecs_to_jiffies(10000);
>  
>  	do {
> -		if (time_after(jiffies, timeout))
> -			return fp(wrp) ? 0 : -ETIMEDOUT;
>  		if (fp(wrp))
>  			return 0;
> +
> +		usleep_range(10, 11);
> +
> +		if (time_after(jiffies, timeout))
> +			return fp(wrp) ? 0 : -ETIMEDOUT;
>  	} while (1);
>  }
>  

