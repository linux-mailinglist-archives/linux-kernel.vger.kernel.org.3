Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9FEA5A1C92
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 00:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241973AbiHYWlh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 18:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243926AbiHYWld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 18:41:33 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8964CC696C;
        Thu, 25 Aug 2022 15:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1661467288; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n4G6QTM/x0INncguqKFGzJUeIOZvp2pHN7zuOsOkoyU=;
        b=CeyjsrF/cZCqvSTrR6YhaW7B7wBWs9ajEStcpdMZ75eH8Ai/Oj6IBhv8h+WIeakOoj9aSL
        tN2892wenn3kfbfkU/Vz2TJdCGwuKO35Aq7sHMRp5AfPJ9VaYZJzciXPqcpEM/Iqm7rIAb
        NvMELK06aS12TWq1PqOkwasXWqmcrWc=
Date:   Thu, 25 Aug 2022 23:41:18 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH] rtc: jz4740: Use devm_clk_get_enabled() helper
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-rtc@vger.kernel.org
Message-Id: <UC07HR.REF39SO0Y5PG2@crapouillou.net>
In-Reply-To: <af10570000d7e103d70bbea590ce8df4f8902b67.1661330532.git.christophe.jaillet@wanadoo.fr>
References: <af10570000d7e103d70bbea590ce8df4f8902b67.1661330532.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

Le mer., ao=FBt 24 2022 at 10:42:29 +0200, Christophe JAILLET=20
<christophe.jaillet@wanadoo.fr> a =E9crit :
> The devm_clk_get_enabled() helper:
>    - calls devm_clk_get()
>    - calls clk_prepare_enable() and registers what is needed in order=20
> to
>      call clk_disable_unprepare() when needed, as a managed resource.
>=20
> This simplifies the code, the error handling paths and avoid the need=20
> of
> a dedicated function used with devm_add_action_or_reset().
>=20
>=20
> As a side effect, some error messages are not logged anymore, so also=20
> use
> dev_err_probe() instead of dev_err() in case of error.
> At least the error code will be logged (and -EPROBE_DEFER will be=20
> filtered)
>=20
> Based on my test with allyesconfig, this reduces the .o size from:
>    text	   data	    bss	    dec	    hex	filename
>    9025	   2488	    128	  11641	   2d79	drivers/rtc/rtc-jz4740.o
> down to:
>    8267	   2080	    128	  10475	   28eb	drivers/rtc/rtc-jz4740.o
>=20
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Acked-by: Paul Cercueil <paul@crapouillou.net>

> ---
> devm_clk_get_enabled() is new and is part of 6.0-rc1
>=20
> Some recent changed use "rtc: ingenic". This looks odd to me, so turn=20
> back
> to "rtc: jz4740"

Yes, the driver basically supports everything Ingenic now, so I=20
generally write "rtc: ingenic:", but "rtc: jz4740:" is absolutely fine.

Cheers,
-Paul

> ---
>  drivers/rtc/rtc-jz4740.c | 25 +++----------------------
>  1 file changed, 3 insertions(+), 22 deletions(-)
>=20
> diff --git a/drivers/rtc/rtc-jz4740.c b/drivers/rtc/rtc-jz4740.c
> index 6e51df72fd65..c383719292c7 100644
> --- a/drivers/rtc/rtc-jz4740.c
> +++ b/drivers/rtc/rtc-jz4740.c
> @@ -257,11 +257,6 @@ static void jz4740_rtc_power_off(void)
>  	kernel_halt();
>  }
>=20
> -static void jz4740_rtc_clk_disable(void *data)
> -{
> -	clk_disable_unprepare(data);
> -}
> -
>  static const struct of_device_id jz4740_rtc_of_match[] =3D {
>  	{ .compatible =3D "ingenic,jz4740-rtc", .data =3D (void *)ID_JZ4740 },
>  	{ .compatible =3D "ingenic,jz4760-rtc", .data =3D (void *)ID_JZ4760 },
> @@ -329,23 +324,9 @@ static int jz4740_rtc_probe(struct=20
> platform_device *pdev)
>  	if (IS_ERR(rtc->base))
>  		return PTR_ERR(rtc->base);
>=20
> -	clk =3D devm_clk_get(dev, "rtc");
> -	if (IS_ERR(clk)) {
> -		dev_err(dev, "Failed to get RTC clock\n");
> -		return PTR_ERR(clk);
> -	}
> -
> -	ret =3D clk_prepare_enable(clk);
> -	if (ret) {
> -		dev_err(dev, "Failed to enable clock\n");
> -		return ret;
> -	}
> -
> -	ret =3D devm_add_action_or_reset(dev, jz4740_rtc_clk_disable, clk);
> -	if (ret) {
> -		dev_err(dev, "Failed to register devm action\n");
> -		return ret;
> -	}
> +	clk =3D devm_clk_get_enabled(dev, "rtc");
> +	if (IS_ERR(clk))
> +		return dev_err_probe(dev, PTR_ERR(clk), "Failed to get RTC=20
> clock\n");
>=20
>  	spin_lock_init(&rtc->lock);
>=20
> --
> 2.34.1
>=20


