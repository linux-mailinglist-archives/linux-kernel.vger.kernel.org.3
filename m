Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11B024B9D63
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 11:41:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239250AbiBQKky (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 05:40:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239244AbiBQKkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 05:40:52 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39848284D1C
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 02:40:38 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 581411F4560C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1645094437;
        bh=a4kVXcts5RYYnYTz5xCDykmha1OtLX+CuQebEarzxD4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=PILuS0FjWxb32OJHPC9LFsuDVR2N2f8T1T47E8XjDZYH4g/Qdf9Ys1kjJL1nPJFZf
         0HCZnyJ2jttRNd/7uL54TZOwi8FNIoQxm/rHjQdH7o+aSkXC2rNq11KKxzp7fDiLRd
         j0MNWb2YrLuAIzsbfjoXnM4UmnCw4SCXlXhGRAL0DiaIPR/rDn0115FZAhoDauUl7c
         XJCJCEJJfeS+r1AuvnwXPyAc+WGolhB/mO8sgBUfFSASYRVKk4Khj2wvlZWOpa8DSU
         hCDnCYyLXHXuUbZU9hyrcoYc7KjABQL1sEyOpI6AXMRSlrzaGRN2JDOLh7uSjDIWwF
         pnJ2kUPw5uxgQ==
Message-ID: <e93b12d6-5c7b-2ad6-47e5-c1311d95cba2@collabora.com>
Date:   Thu, 17 Feb 2022 11:40:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v2] soc: mediatek: mtk-infracfg: Disable ACP on MT8192
Content-Language: en-US
To:     Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        linux-mediatek@lists.infradead.org
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nick Fan <Nick.Fan@mediatek.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Stephen Boyd <sboyd@kernel.org>
References: <20220215184651.12168-1-alyssa.rosenzweig@collabora.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220215184651.12168-1-alyssa.rosenzweig@collabora.com>
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

Il 15/02/22 19:46, Alyssa Rosenzweig ha scritto:
> MT8192 contains an experimental Accelerator Coherency Port
> implementation, which does not work correctly but was unintentionally
> enabled by default. For correct operation of the GPU, we must set a
> chicken bit disabling ACP on MT8192.
> 
> Adapted from the following downstream change to the out-of-tree, legacy
> Mali GPU driver:
> 
> https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/2781271/5
> 
> Note this change is required for both Panfrost and the legacy kernel
> driver.

Hello Alyssa,
the v2 note should not get inside the commit message, even though they should be
on the patch to provide context.
Look at the example...

> 
> v2: Move the change from clk-mt8192.c to mtk-infracfg.c (Robin).
> Although it does not make sense to add this platform-specific hack to
> the GPU driver, it has nothing to do with clocks. We already have
> mtk-infracfg.c to manage other infracfg bits; the ACP disable should
> live there too.
> 
> Co-developed-by: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
> Cc: Nick Fan <Nick.Fan@mediatek.com>
> Cc: Nicolas Boichat <drinkcat@chromium.org>
> Cc: Chen-Yu Tsai <wenst@chromium.org>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---

v2: Move the change from clk-mt8192.c to mtk-infracfg.c (Robin).

^^^ put it here, after the "---" :)

Anyway,
Tested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

>   drivers/soc/mediatek/mtk-infracfg.c   | 19 +++++++++++++++++++
>   include/linux/soc/mediatek/infracfg.h |  3 +++
>   2 files changed, 22 insertions(+)
> 
> diff --git a/drivers/soc/mediatek/mtk-infracfg.c b/drivers/soc/mediatek/mtk-infracfg.c
> index 0590b68e0d78..2acf19676af2 100644
> --- a/drivers/soc/mediatek/mtk-infracfg.c
> +++ b/drivers/soc/mediatek/mtk-infracfg.c
> @@ -6,6 +6,7 @@
>   #include <linux/export.h>
>   #include <linux/jiffies.h>
>   #include <linux/regmap.h>
> +#include <linux/mfd/syscon.h>
>   #include <linux/soc/mediatek/infracfg.h>
>   #include <asm/processor.h>
>   
> @@ -72,3 +73,21 @@ int mtk_infracfg_clear_bus_protection(struct regmap *infracfg, u32 mask,
>   
>   	return ret;
>   }
> +
> +static int __init mtk_infracfg_init(void)
> +{
> +	struct regmap *infracfg;
> +
> +	/*
> +	 * MT8192 has an experimental path to route GPU traffic to the DSU's
> +	 * Accelerator Coherency Port, which is inadvertently enabled by
> +	 * default. It turns out not to work, so disable it to prevent spurious
> +	 * GPU faults.
> +	 */
> +	infracfg = syscon_regmap_lookup_by_compatible("mediatek,mt8192-infracfg");
> +	if (!IS_ERR(infracfg))
> +		regmap_set_bits(infracfg, MT8192_INFRA_CTRL,
> +				MT8192_INFRA_CTRL_DISABLE_MFG2ACP);
> +	return 0;
> +}
> +postcore_initcall(mtk_infracfg_init);
> diff --git a/include/linux/soc/mediatek/infracfg.h b/include/linux/soc/mediatek/infracfg.h
> index d858e0bab7a2..fcbbd0dd5e55 100644
> --- a/include/linux/soc/mediatek/infracfg.h
> +++ b/include/linux/soc/mediatek/infracfg.h
> @@ -229,6 +229,9 @@
>   #define INFRA_TOPAXI_PROTECTEN_SET		0x0260
>   #define INFRA_TOPAXI_PROTECTEN_CLR		0x0264
>   
> +#define MT8192_INFRA_CTRL			0x290
> +#define MT8192_INFRA_CTRL_DISABLE_MFG2ACP	BIT(9)
> +
>   #define REG_INFRA_MISC				0xf00
>   #define F_DDR_4GB_SUPPORT_EN			BIT(13)
>   


-- 
AngeloGioacchino Del Regno
Software Engineer

Collabora Ltd.
Platinum Building, St John's Innovation Park, Cambridge CB4 0DS, UK
Registered in England & Wales, no. 5513718
