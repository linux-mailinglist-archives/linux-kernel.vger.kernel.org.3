Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D11AF4DD8F1
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 12:29:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235778AbiCRLas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 07:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235769AbiCRLam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 07:30:42 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B1251ED062;
        Fri, 18 Mar 2022 04:29:16 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 2FC531F45EB1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1647602954;
        bh=yR6YIljfGinF+pJoIGBmN8q7+1O8ZzcAnqybJw3gz6o=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=E8KU89+4XqdG3J8L/OLvNgA8upKBw/lygW9TlmKTChO/fWZuTxAKqOVrkhGEHE5PR
         c1Ryx3Vb+ETKbMRiLx6pJnL+NA2cDmyUdUJynygITn8Wb9TBa5wDM295sjIftjUl2B
         MAg9nV3rdwRkQQpDBMxI0C90KVKWsDkNvPDrOuy1HDy4YCzPHEQgVfA7C1LsGVRhAj
         pfu271TQ3FdfpyAjnkxjslqSIpCW4nytRx86bQwaPHHVJaPhfTN1btlb7QpB0l0lYA
         8ZgZiIiTho3/i1kGNMNsbs/WiZ/aS8aDvQqp0uTJp4CRPanOklvbHzknoBcvPf4Zok
         qLFCymsgSwXhw==
Message-ID: <a6844feb-98d5-4f44-f8fa-87f47aa9ec93@collabora.com>
Date:   Fri, 18 Mar 2022 12:29:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH V5 1/3] spi: mediatek: add spi memory support for ipm
 design
Content-Language: en-US
To:     Leilk Liu <leilk.liu@mediatek.com>, Mark Brown <broonie@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-mediatek@lists.infradead.org
References: <20220318025027.31281-1-leilk.liu@mediatek.com>
 <20220318025027.31281-2-leilk.liu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220318025027.31281-2-leilk.liu@mediatek.com>
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

Il 18/03/22 03:50, Leilk Liu ha scritto:
> this patch add the support of spi-mem for ipm design.
> 
> Signed-off-by: Leilk Liu <leilk.liu@mediatek.com>
> ---
>   drivers/spi/spi-mt65xx.c | 302 ++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 301 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
> index 1a0b3208dfca..ea6223259060 100644
> --- a/drivers/spi/spi-mt65xx.c
> +++ b/drivers/spi/spi-mt65xx.c

...snip...

> @@ -78,8 +79,21 @@
>   #define SPI_CMD_IPM_GET_TICKDLY_OFFSET    22
>   
>   #define SPI_CMD_IPM_GET_TICKDLY_MASK	GENMASK(24, 22)
> +
> +#define PIN_MODE_CFG(x)	((x) / 2)
> +
> +#define SPI_CFG3_IPM_PIN_MODE_OFFSET		0

This definition is useless, the offset is zero... and this is used
to bitshift zero.


Please remove that, after which:

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
