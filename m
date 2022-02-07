Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 413CE4AB5D6
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 08:25:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243928AbiBGHRz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 02:17:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233876AbiBGHKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 02:10:01 -0500
X-Greylist: delayed 304 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 06 Feb 2022 23:10:00 PST
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36B37C043184;
        Sun,  6 Feb 2022 23:09:59 -0800 (PST)
X-UUID: fd9c5bceefe0466cbcc7d76da858e708-20220207
X-UUID: fd9c5bceefe0466cbcc7d76da858e708-20220207
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <johnson.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 509826133; Mon, 07 Feb 2022 15:04:53 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Mon, 7 Feb 2022 15:04:52 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 7 Feb 2022 15:04:51 +0800
Message-ID: <777a3344a7edc654548f435cc21dd9d628fe69ea.camel@mediatek.com>
Subject: Re: [PATCH 1/4] mfd: Add support for the MediaTek MT6366 PMIC
From:   Johnson Wang <johnson.wang@mediatek.com>
To:     <lee.jones@linaro.org>, <robh+dt@kernel.org>, <broonie@kernel.org>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Mon, 7 Feb 2022 15:04:52 +0800
In-Reply-To: <20220106065407.16036-2-johnson.wang@mediatek.com>
References: <20220106065407.16036-1-johnson.wang@mediatek.com>
         <20220106065407.16036-2-johnson.wang@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee,
This patch intends to add MT6366 PMIC support and 
there are some modifications in mfd subsystem.

Could you give us some suggestion for this patch?

Thanks for your support!

BRs,
Johnson Wang 

On Thu, 2022-01-06 at 14:54 +0800, Johnson Wang wrote:
> This adds support for the MediaTek MT6366 PMIC. This is a
> multifunction device with the following sub modules:
> 
> - Regulator
> - RTC
> - Codec
> - Interrupt
> 
> It is interfaced to the host controller using SPI interface
> by a proprietary hardware called PMIC wrapper or pwrap.
> MT6366 MFD is a child device of the pwrap.
> 
> Signed-off-by: Johnson Wang <johnson.wang@mediatek.com>
> ---
>  drivers/mfd/mt6358-irq.c             | 1 +
>  include/linux/mfd/mt6358/registers.h | 7 +++++++
>  include/linux/mfd/mt6397/core.h      | 1 +
>  3 files changed, 9 insertions(+)
> 
> diff --git a/drivers/mfd/mt6358-irq.c b/drivers/mfd/mt6358-irq.c
> index 83f3ffbdbb4c..ea5e452510eb 100644
> --- a/drivers/mfd/mt6358-irq.c
> +++ b/drivers/mfd/mt6358-irq.c
> @@ -212,6 +212,7 @@ int mt6358_irq_init(struct mt6397_chip *chip)
>  
>  	switch (chip->chip_id) {
>  	case MT6358_CHIP_ID:
> +	case MT6366_CHIP_ID:
>  		chip->irq_data = &mt6358_irqd;
>  		break;
>  
> diff --git a/include/linux/mfd/mt6358/registers.h
> b/include/linux/mfd/mt6358/registers.h
> index 201139b12140..3d33517f178c 100644
> --- a/include/linux/mfd/mt6358/registers.h
> +++ b/include/linux/mfd/mt6358/registers.h
> @@ -94,6 +94,10 @@
>  #define MT6358_BUCK_VCORE_CON0                0x1488
>  #define MT6358_BUCK_VCORE_DBG0                0x149e
>  #define MT6358_BUCK_VCORE_DBG1                0x14a0
> +#define MT6358_BUCK_VCORE_SSHUB_CON0          0x14a4
> +#define MT6358_BUCK_VCORE_SSHUB_CON1          0x14a6
> +#define
> MT6358_BUCK_VCORE_SSHUB_ELR0          MT6358_BUCK_VCORE_SSHUB_CON1
> +#define MT6358_BUCK_VCORE_SSHUB_DBG1          MT6358_BUCK_VCORE_DBG1
>  #define MT6358_BUCK_VCORE_ELR0                0x14aa
>  #define MT6358_BUCK_VGPU_CON0                 0x1508
>  #define MT6358_BUCK_VGPU_DBG0                 0x151e
> @@ -169,6 +173,9 @@
>  #define MT6358_LDO_VSRAM_OTHERS_CON0          0x1ba6
>  #define MT6358_LDO_VSRAM_OTHERS_DBG0          0x1bc0
>  #define MT6358_LDO_VSRAM_OTHERS_DBG1          0x1bc2
> +#define MT6358_LDO_VSRAM_OTHERS_SSHUB_CON0    0x1bc4
> +#define MT6358_LDO_VSRAM_OTHERS_SSHUB_CON1    0x1bc6
> +#define
> MT6358_LDO_VSRAM_OTHERS_SSHUB_DBG1    MT6358_LDO_VSRAM_OTHERS_DBG1
>  #define MT6358_LDO_VSRAM_GPU_CON0             0x1bc8
>  #define MT6358_LDO_VSRAM_GPU_DBG0             0x1be2
>  #define MT6358_LDO_VSRAM_GPU_DBG1             0x1be4
> diff --git a/include/linux/mfd/mt6397/core.h
> b/include/linux/mfd/mt6397/core.h
> index 56f210eebc54..1cf78726503b 100644
> --- a/include/linux/mfd/mt6397/core.h
> +++ b/include/linux/mfd/mt6397/core.h
> @@ -14,6 +14,7 @@ enum chip_id {
>  	MT6323_CHIP_ID = 0x23,
>  	MT6358_CHIP_ID = 0x58,
>  	MT6359_CHIP_ID = 0x59,
> +	MT6366_CHIP_ID = 0x66,
>  	MT6391_CHIP_ID = 0x91,
>  	MT6397_CHIP_ID = 0x97,
>  };

