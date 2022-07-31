Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25124585F8C
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 17:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237250AbiGaPlk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 11:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233604AbiGaPlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 11:41:35 -0400
Received: from ciao.gmane.io (ciao.gmane.io [116.202.254.214])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDB48E0BE
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 08:41:34 -0700 (PDT)
Received: from list by ciao.gmane.io with local (Exim 4.92)
        (envelope-from <glk-linux-kernel-4@m.gmane-mx.org>)
        id 1oIB4O-0001xM-M1
        for linux-kernel@vger.kernel.org; Sun, 31 Jul 2022 17:41:32 +0200
X-Injected-Via-Gmane: http://gmane.org/
To:     linux-kernel@vger.kernel.org
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH v1 3/3] ASoC: amd: acp: Add legacy audio driver support
 for Rembrandt platform
Date:   Sun, 31 Jul 2022 17:41:25 +0200
Message-ID: <e30925e7-56b7-48df-b287-094441f8c586@wanadoo.fr>
References: <20220707161142.491034-1-Vsujithkumar.Reddy@amd.com>
 <20220707161142.491034-4-Vsujithkumar.Reddy@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Cc:     alsa-devel@alsa-project.org
Content-Language: fr
In-Reply-To: <20220707161142.491034-4-Vsujithkumar.Reddy@amd.com>
Cc:     linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this patch has already reached -next, but a few nit below.

Le 07/07/2022 à 18:11, V sujith kumar Reddy a écrit :
> Add i2s and dmic support for Rembrandt platform,
> Add machine support for nau8825, max98360 and rt5682s,rt1019 codec
> in legacy driver for rembrandt platform.
> Here codec is in a slave mode.
> 
> Signed-off-by: V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>
> ---
>   sound/soc/amd/acp/Kconfig            |  11 +
>   sound/soc/amd/acp/Makefile           |   2 +
>   sound/soc/amd/acp/acp-i2s.c          | 137 ++++++++-
>   sound/soc/amd/acp/acp-legacy-mach.c  |  32 +++
>   sound/soc/amd/acp/acp-mach-common.c  |  86 +++++-
>   sound/soc/amd/acp/acp-mach.h         |   6 +
>   sound/soc/amd/acp/acp-pci.c          |   6 +
>   sound/soc/amd/acp/acp-platform.c     |  16 +-
>   sound/soc/amd/acp/acp-rembrandt.c    | 401 +++++++++++++++++++++++++++
>   sound/soc/amd/acp/amd.h              |  62 ++++-
>   sound/soc/amd/acp/chip_offset_byte.h |  28 ++
>   11 files changed, 781 insertions(+), 6 deletions(-)
>   create mode 100644 sound/soc/amd/acp/acp-rembrandt.c
> 

[...]

> diff --git a/sound/soc/amd/acp/acp-rembrandt.c b/sound/soc/amd/acp/acp-rembrandt.c
> new file mode 100644
> index 000000000000..2b57c0ca4e99
> --- /dev/null
> +++ b/sound/soc/amd/acp/acp-rembrandt.c
> @@ -0,0 +1,401 @@
> +// SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)
> +//
> +// This file is provided under a dual BSD/GPLv2 license. When using or
> +// redistributing this file, you may do so under either license.

These lines are useless. There is already a SPDX-License-Identifier just 
above.

> +//
> +// Copyright(c) 2022 Advanced Micro Devices, Inc.
> +//
> +// Authors: Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
> +//          V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>
> +/*
> + * Hardware interface for Renoir ACP block
> + */
> +

[...]

> +static int rembrandt_audio_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct acp_chip_info *chip;
> +	struct acp_dev_data *adata;
> +	struct resource *res;
> +
> +	chip = dev_get_platdata(&pdev->dev);
> +	if (!chip || !chip->base) {
> +		dev_err(&pdev->dev, "ACP chip data is NULL\n");
> +		return -ENODEV;
> +	}
> +
> +	if (chip->acp_rev != ACP6X_DEV) {
> +		dev_err(&pdev->dev, "Un-supported ACP Revision %d\n", chip->acp_rev);
> +		return -ENODEV;
> +	}
> +
> +	rmb_acp_init(chip->base);

Should rmb_acp_deinit() be called if an error occurs below?
Or a devm_add_action_or_reset() + .remove() simplification?

(this is called in the .remove() function)

> +
> +	adata = devm_kzalloc(dev, sizeof(struct acp_dev_data), GFP_KERNEL);
> +	if (!adata)
> +		return -ENOMEM;
> +
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "acp_mem");
> +	if (!res) {
> +		dev_err(&pdev->dev, "IORESOURCE_MEM FAILED\n");
> +		return -ENODEV;
> +	}
> +
> +	adata->acp_base = devm_ioremap(&pdev->dev, res->start, resource_size(res));
> +	if (!adata->acp_base)
> +		return -ENOMEM;
> +
> +	res = platform_get_resource_byname(pdev, IORESOURCE_IRQ, "acp_dai_irq");
> +	if (!res) {
> +		dev_err(&pdev->dev, "IORESOURCE_IRQ FAILED\n");
> +		return -ENODEV;
> +	}
> +
> +	adata->i2s_irq = res->start;
> +	adata->dev = dev;
> +	adata->dai_driver = acp_rmb_dai;
> +	adata->num_dai = ARRAY_SIZE(acp_rmb_dai);
> +	adata->rsrc = &rsrc;
> +
> +	adata->machines = snd_soc_acpi_amd_rmb_acp_machines;
> +	acp_machine_select(adata);
> +
> +	dev_set_drvdata(dev, adata);
> +	acp6x_enable_interrupts(adata);
> +	acp_platform_register(dev);
> +
> +	return 0;
> +}
> +
> +static int rembrandt_audio_remove(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct acp_dev_data *adata = dev_get_drvdata(dev);
> +	struct acp_chip_info *chip;
> +
> +	chip = dev_get_platdata(&pdev->dev);
> +	if (!chip || !chip->base) {
> +		dev_err(&pdev->dev, "ACP chip data is NULL\n");
> +		return -ENODEV;
> +	}

These tests and dev_err and return look useless.
The same is already tested at the biginning of the probe and if it 
fails, the probe will fail, right?

> +
> +	rmb_acp_deinit(chip->base);
> +
> +	acp6x_disable_interrupts(adata);
> +	acp_platform_unregister(dev);
> +	return 0;
> +}

[...]


