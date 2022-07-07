Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A120569E67
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 11:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235133AbiGGJQ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 05:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbiGGJQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 05:16:57 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 863FA2CDDE;
        Thu,  7 Jul 2022 02:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1657185414; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0G9+ZdgiY1pf7540Iu8Mnhcomtxme7gXDOd3aBrjvco=;
        b=VyD4jBxnLv08QoWXpC0q4O64XKy65EcXZ9cz2Bd64ITcPsfwEZHpaaMYN0/lJpIyXR2MRh
        hbEdTldsBf/5cCq38mYAn3Q+lzpnsNSizOhJSXk3Nk0TSOzfYjYMo811SiofIV7BFjx9L4
        9qQlmXByEkj81aMxv/rZ6wzmc8o098M=
Date:   Thu, 07 Jul 2022 10:16:44 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 01/11] ASoC: jz4740-i2s: Remove Open Firmware dependency
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, linux-mips@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Message-Id: <WF8NER.2XOF3ZGKDQYB3@crapouillou.net>
In-Reply-To: <20220706211330.120198-2-aidanmacdonald.0x0@gmail.com>
References: <20220706211330.120198-1-aidanmacdonald.0x0@gmail.com>
        <20220706211330.120198-2-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aidan,

Le mer., juil. 6 2022 at 22:13:20 +0100, Aidan MacDonald=20
<aidanmacdonald.0x0@gmail.com> a =E9crit :
> This driver doesn't require Open Firmware support. Remove the
> OF-specific includes and drop the Kconfig dependency.
>=20
> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>

Acked-by: Paul Cercueil <paul@crapouillou.net>

Cheers,
-Paul

> ---
>  sound/soc/jz4740/Kconfig      | 2 +-
>  sound/soc/jz4740/jz4740-i2s.c | 3 +--
>  2 files changed, 2 insertions(+), 3 deletions(-)
>=20
> diff --git a/sound/soc/jz4740/Kconfig b/sound/soc/jz4740/Kconfig
> index 29144720cb62..e72f826062e9 100644
> --- a/sound/soc/jz4740/Kconfig
> +++ b/sound/soc/jz4740/Kconfig
> @@ -2,7 +2,7 @@
>  config SND_JZ4740_SOC_I2S
>  	tristate "SoC Audio (I2S protocol) for Ingenic JZ4740 SoC"
>  	depends on MIPS || COMPILE_TEST
> -	depends on OF && HAS_IOMEM
> +	depends on HAS_IOMEM
>  	select SND_SOC_GENERIC_DMAENGINE_PCM
>  	help
>  	  Say Y if you want to use I2S protocol and I2S codec on Ingenic=20
> JZ4740
> diff --git a/sound/soc/jz4740/jz4740-i2s.c=20
> b/sound/soc/jz4740/jz4740-i2s.c
> index 79afac0c5003..298ff0a83931 100644
> --- a/sound/soc/jz4740/jz4740-i2s.c
> +++ b/sound/soc/jz4740/jz4740-i2s.c
> @@ -5,10 +5,9 @@
>=20
>  #include <linux/init.h>
>  #include <linux/io.h>
> -#include <linux/of.h>
> -#include <linux/of_device.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
>=20
> --
> 2.35.1
>=20


