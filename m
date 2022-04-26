Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D34450FA21
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 12:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348767AbiDZKWA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 06:22:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348926AbiDZKVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 06:21:36 -0400
Received: from mxout01.lancloud.ru (mxout01.lancloud.ru [45.84.86.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1D3419C25;
        Tue, 26 Apr 2022 02:47:58 -0700 (PDT)
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout01.lancloud.ru 5627820AF4DD
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Subject: Re: [PATCH v2 2/3] ASoC: sh: rz-ssi: Propagate error codes returned
 from platform_get_irq_byname()
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, <alsa-devel@alsa-project.org>
CC:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Pavel Machek <pavel@denx.de>, <linux-kernel@vger.kernel.org>,
        <linux-renesas-soc@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
References: <20220426074922.13319-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220426074922.13319-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <5bb82736-50bc-eafd-7d68-df1ed966d572@omp.ru>
Date:   Tue, 26 Apr 2022 12:47:54 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20220426074922.13319-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT02.lancloud.ru (fd00:f066::142) To
 LFEX1907.lancloud.ru (fd00:f066::207)
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 4/26/22 10:49 AM, Lad Prabhakar wrote:

> Propagate error codes returned from platform_get_irq_byname() instead of
> returning -ENODEV. platform_get_irq_byname() may return -EPROBE_DEFER, to
> handle such cases propagate the error codes.
> 
> While at it drop the dev_err_probe() messages as platform_get_irq_byname()
> already does this for us in case of error.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> v1->v2
> * No change
> ---
>  sound/soc/sh/rz-ssi.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/sound/soc/sh/rz-ssi.c b/sound/soc/sh/rz-ssi.c
> index cec458b8c507..d9a684e71ec3 100644
> --- a/sound/soc/sh/rz-ssi.c
> +++ b/sound/soc/sh/rz-ssi.c
> @@ -977,8 +977,7 @@ static int rz_ssi_probe(struct platform_device *pdev)
>  	/* Error Interrupt */
>  	ssi->irq_int = platform_get_irq_byname(pdev, "int_req");
>  	if (ssi->irq_int < 0)
> -		return dev_err_probe(&pdev->dev, -ENODEV,
> -				     "Unable to get SSI int_req IRQ\n");
> +		return ssi->irq_int;

   Why not:

		return dev_err_probe(&pdev->dev, ssi->irq_int,
				     "Unable to get SSI int_req IRQ\n");

[...]
> @@ -990,8 +989,7 @@ static int rz_ssi_probe(struct platform_device *pdev)
>  		/* Tx and Rx interrupts (pio only) */
>  		ssi->irq_tx = platform_get_irq_byname(pdev, "dma_tx");
>  		if (ssi->irq_tx < 0)
> -			return dev_err_probe(&pdev->dev, -ENODEV,
> -					     "Unable to get SSI dma_tx IRQ\n");
> +			return ssi->irq_tx;

   Same here...

>  
>  		ret = devm_request_irq(&pdev->dev, ssi->irq_tx,
>  				       &rz_ssi_interrupt, 0,
> @@ -1002,8 +1000,7 @@ static int rz_ssi_probe(struct platform_device *pdev)
>  
>  		ssi->irq_rx = platform_get_irq_byname(pdev, "dma_rx");
>  		if (ssi->irq_rx < 0)
> -			return dev_err_probe(&pdev->dev, -ENODEV,
> -					     "Unable to get SSI dma_rx IRQ\n");
> +			return ssi->irq_rx;

   And here...

[...]

MBR, Sergey
