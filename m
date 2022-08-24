Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11E8859F571
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 10:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235684AbiHXIjg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 04:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235520AbiHXIjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 04:39:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 004B069F47;
        Wed, 24 Aug 2022 01:39:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7DF17617A2;
        Wed, 24 Aug 2022 08:39:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF14EC433D6;
        Wed, 24 Aug 2022 08:39:25 +0000 (UTC)
Message-ID: <3ccf3023-9b1c-2ae6-dd70-6f318eec22e2@xs4all.nl>
Date:   Wed, 24 Aug 2022 10:39:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v28 4/4] media: platform: mtk-mdp3: add MediaTek MDP3
 driver
Content-Language: en-US
To:     Moudy Ho <moudy.ho@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Rob Landley <rob@landley.net>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Alexandre Courbot <acourbot@chromium.org>, tfiga@chromium.org,
        drinkcat@chromium.org, pihsun@chromium.org, hsinyi@google.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        cellopoint.kai@gmail.com, Ping-Hsun Wu <ping-hsun.wu@mediatek.com>,
        daoyuan huang <daoyuan.huang@mediatek.com>
References: <20220823023803.27850-1-moudy.ho@mediatek.com>
 <20220823023803.27850-5-moudy.ho@mediatek.com>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <20220823023803.27850-5-moudy.ho@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Moudy,

On 23/08/2022 04:38, Moudy Ho wrote:
> This patch adds driver for MediaTek's Media Data Path ver.3 (MDP3).
> It provides the following functions:
>   color transform, format conversion, resize, crop, rotate, flip
>   and additional image quality enhancement.
> 
> The MDP3 driver is mainly used for Google Chromebook products to
> import the new architecture to set the HW settings as shown below:
>   User -> V4L2 framework
>     -> MDP3 driver -> SCP (setting calculations)
>       -> MDP3 driver -> CMDQ (GCE driver) -> HW
> 
> Each modules' related operation control is sited in mtk-mdp3-comp.c
> Each modules' register table is defined in file with "mdp_reg_" prefix
> GCE related API, operation control  sited in mtk-mdp3-cmdq.c
> V4L2 m2m device functions are implemented in mtk-mdp3-m2m.c
> Probe, power, suspend/resume, system level functions are defined in
> mtk-mdp3-core.c
> 
> Signed-off-by: Ping-Hsun Wu <ping-hsun.wu@mediatek.com>
> Signed-off-by: daoyuan huang <daoyuan.huang@mediatek.com>
> Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>
> Tested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  drivers/media/platform/mediatek/Kconfig       |    1 +
>  drivers/media/platform/mediatek/Makefile      |    1 +
>  drivers/media/platform/mediatek/mdp3/Kconfig  |   20 +
>  drivers/media/platform/mediatek/mdp3/Makefile |    6 +
>  .../platform/mediatek/mdp3/mdp_reg_ccorr.h    |   19 +
>  .../platform/mediatek/mdp3/mdp_reg_rdma.h     |   65 ++
>  .../platform/mediatek/mdp3/mdp_reg_rsz.h      |   39 +
>  .../platform/mediatek/mdp3/mdp_reg_wdma.h     |   47 +
>  .../platform/mediatek/mdp3/mdp_reg_wrot.h     |   55 +
>  .../platform/mediatek/mdp3/mtk-img-ipi.h      |  290 +++++
>  .../platform/mediatek/mdp3/mtk-mdp3-cmdq.c    |  466 ++++++++
>  .../platform/mediatek/mdp3/mtk-mdp3-cmdq.h    |   43 +
>  .../platform/mediatek/mdp3/mtk-mdp3-comp.c    | 1033 +++++++++++++++++
>  .../platform/mediatek/mdp3/mtk-mdp3-comp.h    |  186 +++
>  .../platform/mediatek/mdp3/mtk-mdp3-core.c    |  357 ++++++
>  .../platform/mediatek/mdp3/mtk-mdp3-core.h    |   94 ++
>  .../platform/mediatek/mdp3/mtk-mdp3-m2m.c     |  724 ++++++++++++
>  .../platform/mediatek/mdp3/mtk-mdp3-m2m.h     |   48 +
>  .../platform/mediatek/mdp3/mtk-mdp3-regs.c    |  735 ++++++++++++
>  .../platform/mediatek/mdp3/mtk-mdp3-regs.h    |  373 ++++++
>  .../platform/mediatek/mdp3/mtk-mdp3-vpu.c     |  313 +++++
>  .../platform/mediatek/mdp3/mtk-mdp3-vpu.h     |   78 ++
>  22 files changed, 4993 insertions(+)
>  create mode 100644 drivers/media/platform/mediatek/mdp3/Kconfig
>  create mode 100644 drivers/media/platform/mediatek/mdp3/Makefile
>  create mode 100644 drivers/media/platform/mediatek/mdp3/mdp_reg_ccorr.h
>  create mode 100644 drivers/media/platform/mediatek/mdp3/mdp_reg_rdma.h
>  create mode 100644 drivers/media/platform/mediatek/mdp3/mdp_reg_rsz.h
>  create mode 100644 drivers/media/platform/mediatek/mdp3/mdp_reg_wdma.h
>  create mode 100644 drivers/media/platform/mediatek/mdp3/mdp_reg_wrot.h
>  create mode 100644 drivers/media/platform/mediatek/mdp3/mtk-img-ipi.h
>  create mode 100644 drivers/media/platform/mediatek/mdp3/mtk-mdp3-cmdq.c
>  create mode 100644 drivers/media/platform/mediatek/mdp3/mtk-mdp3-cmdq.h
>  create mode 100644 drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c
>  create mode 100644 drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.h
>  create mode 100644 drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c
>  create mode 100644 drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.h
>  create mode 100644 drivers/media/platform/mediatek/mdp3/mtk-mdp3-m2m.c
>  create mode 100644 drivers/media/platform/mediatek/mdp3/mtk-mdp3-m2m.h
>  create mode 100644 drivers/media/platform/mediatek/mdp3/mtk-mdp3-regs.c
>  create mode 100644 drivers/media/platform/mediatek/mdp3/mtk-mdp3-regs.h
>  create mode 100644 drivers/media/platform/mediatek/mdp3/mtk-mdp3-vpu.c
>  create mode 100644 drivers/media/platform/mediatek/mdp3/mtk-mdp3-vpu.h
> 
> diff --git a/drivers/media/platform/mediatek/Kconfig b/drivers/media/platform/mediatek/Kconfig
> index af47d9888552..84104e2cd024 100644
> --- a/drivers/media/platform/mediatek/Kconfig
> +++ b/drivers/media/platform/mediatek/Kconfig
> @@ -6,3 +6,4 @@ source "drivers/media/platform/mediatek/jpeg/Kconfig"
>  source "drivers/media/platform/mediatek/mdp/Kconfig"
>  source "drivers/media/platform/mediatek/vcodec/Kconfig"
>  source "drivers/media/platform/mediatek/vpu/Kconfig"
> +source "drivers/media/platform/mediatek/mdp3/Kconfig"
> diff --git a/drivers/media/platform/mediatek/Makefile b/drivers/media/platform/mediatek/Makefile
> index d3850a13f128..38e6ba917fe5 100644
> --- a/drivers/media/platform/mediatek/Makefile
> +++ b/drivers/media/platform/mediatek/Makefile
> @@ -3,3 +3,4 @@ obj-y += jpeg/
>  obj-y += mdp/
>  obj-y += vcodec/
>  obj-y += vpu/
> +obj-y += mdp3/
> diff --git a/drivers/media/platform/mediatek/mdp3/Kconfig b/drivers/media/platform/mediatek/mdp3/Kconfig
> new file mode 100644
> index 000000000000..af371c17c386
> --- /dev/null
> +++ b/drivers/media/platform/mediatek/mdp3/Kconfig
> @@ -0,0 +1,20 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +config VIDEO_MEDIATEK_MDP3
> +	tristate "MediaTek MDP v3 driver"
> +	depends on MTK_IOMMU || COMPILE_TEST
> +	depends on VIDEO_DEV
> +	depends on ARCH_MEDIATEK || COMPILE_TEST
> +	depends on HAS_DMA

A 'depends on REMOTEPROC' is missing here (see the 'kernel test robot' email
you received), but I have added that myself.

It's now in my for-v6.1c branch. If I don't see any new 'kernel test robot'
emails in the next few days, then I'll make a PR early next week.

Regards,

	Hans

> +	select VIDEOBUF2_DMA_CONTIG
> +	select V4L2_MEM2MEM_DEV
> +	select MTK_MMSYS
> +	select VIDEO_MEDIATEK_VPU
> +	select MTK_CMDQ
> +	select MTK_SCP
> +	default n
> +	help
> +	    It is a v4l2 driver and present in MediaTek MT8183 SoC.
> +	    The driver supports scaling and color space conversion.
> +
> +	    To compile this driver as a module, choose M here: the
> +	    module will be called mtk-mdp3.
