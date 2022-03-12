Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 726834D6E67
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 12:23:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbiCLLY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 06:24:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiCLLY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 06:24:57 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F20558C;
        Sat, 12 Mar 2022 03:23:51 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id gb39so24084134ejc.1;
        Sat, 12 Mar 2022 03:23:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3f+ibCQHYhTXQxUBNEK2juHi8lBsmqsUoSUZZ8pGA8w=;
        b=WFsof7h/DWoEA4aa3AcV6OW1zKC+pvshdXwFujuf9dDsuK2yISxJ13BkVmZS+54QuY
         Pm7rSBHQVBapi8rTUm5LEodgjxh9KvBg88OTVmSdHjN441gskyv83nigVpQ1bO0AHX2o
         hFEGKTP8fDlYM8t4m/Eu4A7tTJaJefGgKKO76HSTZBTF9gE3vi6OhscfBzwbO6iAO2x2
         0mXZjrqXXdxMJ+/oF5+1tSKSGW3ikbakxba5wPD5bjf/amBym4dWdQ3UZjEoCQzM+Qos
         tKjG04iJNHBO3eTxZ8OZ3kiIvR68nMPYUSO/yP1pbgTEBgLvRBmp0prKz+QIitPaYmzV
         tcUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3f+ibCQHYhTXQxUBNEK2juHi8lBsmqsUoSUZZ8pGA8w=;
        b=uHkO5+Drb+ViEtaTs1gqhPJPmWykdqlcyBmYOUOp4vT9UVv7jZvDugKN05qX3x3ny/
         RazbMSex63ge3JGpJY7rK3W0+WI6BdeBSN2g/TshWVZrjy+6pSWOXLDT72BdrK1+tDDJ
         F99QoYKjL5aw8lW2nDUnRXMwIWCINPfHJYY0sCSC9D/Bsajq4zfd8MS02agiTgGJ/HHx
         ST5ZT3M4nfbwuolM42t9n2Iow+e8N3X9jwxq/hwMFd3Gyfl4PaQdLy1+p/oSfThdzFJL
         McbiPHhLsAz8hSUk9vBdpaQijvmcrPQclpMmtRa9dpH/LlfZ1+Y0wExKQd/DW3w3ncLA
         mQCg==
X-Gm-Message-State: AOAM530kN8k2bSBvJBx5v2APHpHWJrK7VUZEMzsZEKYb82uJAuMaqxMl
        UN3r8kfyBWglv5+/Sl/csLM=
X-Google-Smtp-Source: ABdhPJxgA2H/bN1nGZKBG20n06Z/JGFlfDtEt1jrDZkcOzT5HlHGrlcgclUA2ihc7ep5CyZC5OTpnA==
X-Received: by 2002:a17:907:2d90:b0:6d8:9fc9:ac36 with SMTP id gt16-20020a1709072d9000b006d89fc9ac36mr11900287ejc.28.1647084230371;
        Sat, 12 Mar 2022 03:23:50 -0800 (PST)
Received: from kista.localnet (cpe-86-58-32-107.static.triera.net. [86.58.32.107])
        by smtp.gmail.com with ESMTPSA id zk1-20020a17090733c100b006dab4a41df8sm4071929ejb.111.2022.03.12.03.23.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Mar 2022 03:23:49 -0800 (PST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Niklas =?ISO-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Chen-Yu Tsai <wens@csie.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Maxime Ripard <mripard@kernel.org>,
        Ming Qian <ming.qian@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v2 29/38] media: platform: sun8i-rotate: move config to its own file
Date:   Sat, 12 Mar 2022 12:23:48 +0100
Message-ID: <2619690.mvXUDI8C0e@kista>
In-Reply-To: <bd96344ebc563aa632a3a1c5ddad7b7d7ee6fc0a.1647006877.git.mchehab@kernel.org>
References: <cover.1647006877.git.mchehab@kernel.org> <bd96344ebc563aa632a3a1c5ddad7b7d7ee6fc0a.1647006877.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne petek, 11. marec 2022 ob 15:07:42 CET je Mauro Carvalho Chehab napisal(a):
> In order to better organize the platform/Kconfig, place
> sun8i-rotate-specific config stuff on a separate Kconfig file.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
> Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
> ---

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> 
> To avoid mailbombing on a large number of people, only mailing lists were C/
C on the cover.
> See [PATCH v2 00/38] at: https://lore.kernel.org/all/cover.
1647006877.git.mchehab@kernel.org/
> 
>  drivers/media/platform/Kconfig                    | 14 +-------------
>  drivers/media/platform/sunxi/sun8i-rotate/Kconfig | 14 ++++++++++++++
>  2 files changed, 15 insertions(+), 13 deletions(-)
>  create mode 100644 drivers/media/platform/sunxi/sun8i-rotate/Kconfig
> 
> diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
> index 37103f24979f..8d0fa9670eaa 100644
> --- a/drivers/media/platform/Kconfig
> +++ b/drivers/media/platform/Kconfig
> @@ -71,6 +71,7 @@ source "drivers/media/platform/s5p-g2d/Kconfig"
>  source "drivers/media/platform/sti/hva/Kconfig"
>  source "drivers/media/platform/stm32/Kconfig"
>  source "drivers/media/platform/sunxi/sun8i-di/Kconfig"
> +source "drivers/media/platform/sunxi/sun8i-rotate/Kconfig"
>  
>  config VIDEO_MUX
>  	tristate "Video Multiplexer"
> @@ -241,19 +242,6 @@ config VIDEO_TI_VPE_DEBUG
>  	help
>  	  Enable debug messages on VPE driver.
>  
> -config VIDEO_SUN8I_ROTATE
> -	tristate "Allwinner DE2 rotation driver"
> -	depends on V4L_MEM2MEM_DRIVERS
> -	depends on VIDEO_DEV && VIDEO_V4L2
> -	depends on ARCH_SUNXI || COMPILE_TEST
> -	depends on COMMON_CLK && OF
> -	depends on PM
> -	select VIDEOBUF2_DMA_CONTIG
> -	select V4L2_MEM2MEM_DEV
> -	help
> -	   Support for the Allwinner DE2 rotation unit.
> -	   To compile this driver as a module choose m here.
> -
>  config VIDEO_TEGRA_VDE
>  	tristate "NVIDIA Tegra Video Decoder Engine driver"
>  	depends on V4L_MEM2MEM_DRIVERS
> diff --git a/drivers/media/platform/sunxi/sun8i-rotate/Kconfig b/drivers/
media/platform/sunxi/sun8i-rotate/Kconfig
> new file mode 100644
> index 000000000000..64a8ea76e917
> --- /dev/null
> +++ b/drivers/media/platform/sunxi/sun8i-rotate/Kconfig
> @@ -0,0 +1,14 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +
> +config VIDEO_SUN8I_ROTATE
> +	tristate "Allwinner DE2 rotation driver"
> +	depends on V4L_MEM2MEM_DRIVERS
> +	depends on VIDEO_DEV && VIDEO_V4L2
> +	depends on ARCH_SUNXI || COMPILE_TEST
> +	depends on COMMON_CLK && OF
> +	depends on PM
> +	select VIDEOBUF2_DMA_CONTIG
> +	select V4L2_MEM2MEM_DEV
> +	help
> +	   Support for the Allwinner DE2 rotation unit.
> +	   To compile this driver as a module choose m here.
> -- 
> 2.35.1
> 
> 


