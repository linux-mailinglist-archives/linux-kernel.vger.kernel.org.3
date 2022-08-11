Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF5658FC3B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 14:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234530AbiHKM3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 08:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234061AbiHKM3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 08:29:37 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12FFC89803
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 05:29:36 -0700 (PDT)
Received: from martin by viti.kaiser.cx with local (Exim 4.89)
        (envelope-from <martin@viti.kaiser.cx>)
        id 1oM7JR-0002kD-2k; Thu, 11 Aug 2022 14:29:21 +0200
Date:   Thu, 11 Aug 2022 14:29:21 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Lee Jones <lee@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] mfd: fsl-imx25: fix check for platform_get_irq() errors
Message-ID: <20220811122921.b24tc2xvn2rovzes@viti.kaiser.cx>
References: <YvTfkbVQWYKMKS/t@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YvTfkbVQWYKMKS/t@kili>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: Martin Kaiser <martin@viti.kaiser.cx>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thus wrote Dan Carpenter (dan.carpenter@oracle.com):

> The mx25_tsadc_remove() function assumes all non-zero returns are success
> but the platform_get_irq() function returns negative on error and
> positive non-zero values on success.  It never returns zero, but if it
> did then treat that as a success.

> Fixes: 18f773937968 ("mfd: fsl-imx25: Clean up irq settings during removal")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/mfd/fsl-imx25-tsadc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

> diff --git a/drivers/mfd/fsl-imx25-tsadc.c b/drivers/mfd/fsl-imx25-tsadc.c
> index 37e5e02a1d05..dfc6da9b4aec 100644
> --- a/drivers/mfd/fsl-imx25-tsadc.c
> +++ b/drivers/mfd/fsl-imx25-tsadc.c
> @@ -69,7 +69,7 @@ static int mx25_tsadc_setup_irq(struct platform_device *pdev,
>  	int irq;

>  	irq = platform_get_irq(pdev, 0);
> -	if (irq <= 0)
> +	if (irq < 0)
>  		return irq;

>  	tsadc->domain = irq_domain_add_simple(np, 2, 0, &mx25_tsadc_domain_ops,
> @@ -179,7 +179,7 @@ static int mx25_tsadc_remove(struct platform_device *pdev)
>  	struct mx25_tsadc *tsadc = platform_get_drvdata(pdev);
>  	int irq = platform_get_irq(pdev, 0);

> -	if (irq) {
> +	if (irq >= 0) {
>  		irq_set_chained_handler_and_data(irq, NULL, NULL);
>  		irq_domain_remove(tsadc->domain);
>  	}
> -- 
> 2.35.1

Reviewed-by: Martin Kaiser <martin@kaiser.cx>

Thanks,

   Martin
