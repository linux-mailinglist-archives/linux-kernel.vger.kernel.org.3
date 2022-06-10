Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B882546291
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 11:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238741AbiFJJfq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 10 Jun 2022 05:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348183AbiFJJfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 05:35:42 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DAFD215
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 02:35:41 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1nzb3K-0003RD-Dz; Fri, 10 Jun 2022 11:35:38 +0200
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1nzb3K-007YER-UU; Fri, 10 Jun 2022 11:35:37 +0200
Received: from pza by lupine with local (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1nzb3I-00047z-Tl; Fri, 10 Jun 2022 11:35:36 +0200
Message-ID: <103fdfb5287a29fc229a734a40c3bcd3b373037f.camel@pengutronix.de>
Subject: Re: [PATCH 1/2] bus: bt1-apb: Don't print error on -EPROBE_DEFER
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        soc@kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 10 Jun 2022 11:35:36 +0200
In-Reply-To: <20220610080103.10689-1-Sergey.Semin@baikalelectronics.ru>
References: <20220610080103.10689-1-Sergey.Semin@baikalelectronics.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Serge,

On Fr, 2022-06-10 at 11:01 +0300, Serge Semin wrote:
> The Baikal-T1 APB bus driver correctly handles the deferred probe
> situation, but still pollutes the system log with a misleading error
> message. Let's fix that by using the dev_err_probe() method to print the
> log message in case of the clocks/resets request errors.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> ---
>  drivers/bus/bt1-apb.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/bus/bt1-apb.c b/drivers/bus/bt1-apb.c
> index b25ff941e7c7..ac13b5b97107 100644
> --- a/drivers/bus/bt1-apb.c
> +++ b/drivers/bus/bt1-apb.c
> @@ -176,7 +176,8 @@ static int bt1_apb_request_rst(struct bt1_apb *apb)
>  
> 
> 
> 
>  	apb->prst = devm_reset_control_get_optional_exclusive(apb->dev, "prst");
>  	if (IS_ERR(apb->prst)) {
> -		dev_warn(apb->dev, "Couldn't get reset control line\n");
> +		dev_err_probe(apb->dev, PTR_ERR(apb->prst),
> +			      "Couldn't get reset control line\n");
>  		return PTR_ERR(apb->prst);

This could be shortened to

-		dev_warn(apb->dev, "Couldn't get reset control line\n");
+		return dev_err_probe(apb->dev, PTR_ERR(apb->prst),
+				     "Couldn't get reset control line\n");
-		return PTR_ERR(apb->prst);

regards
Philipp

