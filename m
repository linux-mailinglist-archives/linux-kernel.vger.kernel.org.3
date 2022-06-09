Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59D4D5447EC
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 11:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242559AbiFIJrf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 05:47:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235519AbiFIJrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 05:47:33 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD9B1B1CE2
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 02:47:31 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1nzElB-0005Jj-Gh; Thu, 09 Jun 2022 11:47:25 +0200
Message-ID: <64828809-1eb7-dff3-da57-95b545aefc22@pengutronix.de>
Date:   Thu, 9 Jun 2022 11:47:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] soc: imx: gpcv2: print errno for regulator errors
Content-Language: en-US
To:     Martin Kepplinger <martin.kepplinger@puri.sm>, shawnguo@kernel.org,
        s.hauer@pengutronix.de, festevam@gmail.com
Cc:     kernel@puri.sm, linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org
References: <20220609094453.2120099-1-martin.kepplinger@puri.sm>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
In-Reply-To: <20220609094453.2120099-1-martin.kepplinger@puri.sm>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Martin,

On 09.06.22 11:44, Martin Kepplinger wrote:
> Make debugging of power management issues easier by printing the reason
> why a regulator fails to be enabled or disabled.
> 
> Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
> ---
>  drivers/soc/imx/gpcv2.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/soc/imx/gpcv2.c b/drivers/soc/imx/gpcv2.c
> index 3cb123016b3e..311507a815c5 100644
> --- a/drivers/soc/imx/gpcv2.c
> +++ b/drivers/soc/imx/gpcv2.c
> @@ -233,7 +233,8 @@ static int imx_pgc_power_up(struct generic_pm_domain *genpd)
>  	if (!IS_ERR(domain->regulator)) {
>  		ret = regulator_enable(domain->regulator);
>  		if (ret) {
> -			dev_err(domain->dev, "failed to enable regulator\n");
> +			dev_err(domain->dev, "failed to enable regulator: %d\n",
> +				ret);

You could make it even more approachable by using %pe.

>  			goto out_put_pm;
>  		}
>  	}
> @@ -372,7 +373,8 @@ static int imx_pgc_power_down(struct generic_pm_domain *genpd)
>  	if (!IS_ERR(domain->regulator)) {
>  		ret = regulator_disable(domain->regulator);
>  		if (ret) {
> -			dev_err(domain->dev, "failed to disable regulator\n");
> +			dev_err(domain->dev,
> +				"failed to disable regulator: %d\n", ret);
>  			return ret;
>  		}
>  	}


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
