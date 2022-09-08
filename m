Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDBBF5B16CB
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 10:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231153AbiIHIVV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 04:21:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbiIHIVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 04:21:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCA06A3D78
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 01:21:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 548F6B81F4B
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 08:21:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E282BC43140;
        Thu,  8 Sep 2022 08:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662625275;
        bh=eK3jWN0l9NYiCRNfzoAFckaaL38cs/Ho8c1Mxa2PVAI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XvkbnJbD2jm5c51qgrpKGWk4KFpRbt0m/rxUIJHNoUopnS1Nb6iva5xFZuvK9I3Q4
         IrBpOGm6sPDzz7oLloU9UWtr+IvTh1KHZDm3yFvFnXd5zChKT0kNdjQQVlaZv+/RBd
         DaFc6loiu0MBELaUjK/6P1SXCmkP0rbDhq2q11E3mZkXxYgQ0WKDdf0HrqD/dg3vX3
         4yQ44YQBqgff0U/s/i7ZOprhJd0ru1XbdkQe2rJp7gmZjQTiDpJkFKxOcJ2FXoJCPw
         ALk5fUx/0njqlyX6NAqmq9H7rpkUQul4sKyOehT25Cpwqqp/pEk/D5J7TNqu11Ycv1
         Iwuj+QPxDxH3g==
Date:   Thu, 8 Sep 2022 09:21:09 +0100
From:   Lee Jones <lee@kernel.org>
To:     Yu Zhe <yuzhe@nfschina.com>
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        liqiong@nfschina.com
Subject: Re: [PATCH] mfd: fix tests for platform_get_irq() failure
Message-ID: <Yxml9asIAhYkY240@google.com>
References: <20220825010911.5324-1-yuzhe@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220825010911.5324-1-yuzhe@nfschina.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Aug 2022, Yu Zhe wrote:

> The platform_get_irq() returns negative error codes.  It can't actually
> return zero.
> 
> Signed-off-by: Yu Zhe <yuzhe@nfschina.com>
> ---
>  drivers/mfd/fsl-imx25-tsadc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Already fixed: https://lore.kernel.org/r/YvTfkbVQWYKMKS/t@kili

> diff --git a/drivers/mfd/fsl-imx25-tsadc.c b/drivers/mfd/fsl-imx25-tsadc.c
> index 37e5e02a1d05..8ccdfd73e694 100644
> --- a/drivers/mfd/fsl-imx25-tsadc.c
> +++ b/drivers/mfd/fsl-imx25-tsadc.c
> @@ -179,7 +179,7 @@ static int mx25_tsadc_remove(struct platform_device *pdev)
>  	struct mx25_tsadc *tsadc = platform_get_drvdata(pdev);
>  	int irq = platform_get_irq(pdev, 0);
>  
> -	if (irq) {
> +	if (irq > 0) {
>  		irq_set_chained_handler_and_data(irq, NULL, NULL);
>  		irq_domain_remove(tsadc->domain);
>  	}

-- 
Lee Jones [李琼斯]
