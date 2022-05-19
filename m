Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97A8252D231
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 14:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237770AbiESMNQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 08:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237727AbiESMNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 08:13:02 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0F6F6BFE7;
        Thu, 19 May 2022 05:12:57 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id A1931240011;
        Thu, 19 May 2022 12:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1652962376;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YdYYUpD3AWSzDg3ucW4PZuX/tknffoSqqCf8c/4+U+k=;
        b=kU5oxW180FvZkjXu5vKUBj1nf/DgJchWR+wQZ+IPlcWZShi0dfMcthr/C3pHZb873WxKo2
        V6Je//tx1VlAmvZp4cOotGh1Zmjb3kN2Oa6w0YbwaJar4yRuiRlw6Gb1ofo2BPsoZBqiD+
        dtod5npdS7Ql95q1HT1AELu8c1xDumacm1MqylmmlRLEY9vWh98M+FMqh8bgkJXOQjdvAm
        EwBEyHsIKyUp5K9osbwUa+LS885yM/xdR86lv8r3+swAw9gruqgOtQhLtW8BxibJ8jsq5j
        +0QKqZKFkdP3JUkVC1w0DfIe8VmaY9qO9c8drNwcXrMo5kzKTAMTm250Dl3Yuw==
Date:   Thu, 19 May 2022 14:12:52 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Michel Pollet <michel.pollet@bp.renesas.com>,
        linux-rtc@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] rtc: rzn1: Fix uninitialized variable val
Message-ID: <20220519141252.7b24d522@xps-13>
In-Reply-To: <20220519100641.595608-1-colin.i.king@gmail.com>
References: <20220519100641.595608-1-colin.i.king@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Colin,

colin.i.king@gmail.com wrote on Thu, 19 May 2022 11:06:41 +0100:

> Variable val is not being initialized and is later being read with
> a potentially garbage value. Fix this by initializing val to zero.
>=20
> Detected by clang scan build:
> warning: variable 'val' is uninitialized when used here [-Wuninitialized]
>=20
> Fixes: deeb4b5393e1 ("rtc: rzn1: Add new RTC driver")
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>


> ---
>  drivers/rtc/rtc-rzn1.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/rtc/rtc-rzn1.c b/drivers/rtc/rtc-rzn1.c
> index 980ade8c9601..0b4bf6e43464 100644
> --- a/drivers/rtc/rtc-rzn1.c
> +++ b/drivers/rtc/rtc-rzn1.c
> @@ -272,7 +272,7 @@ static int rzn1_rtc_set_offset(struct device *dev, lo=
ng offset)
>  	struct rzn1_rtc *rtc =3D dev_get_drvdata(dev);
>  	unsigned int steps;
>  	int stepsh, stepsl;
> -	u32 val;
> +	u32 val =3D 0;

There are actually two variables mixed together. "val" is used both for
the readl_poll_timeout() call (where it should be a dedicated 'ctl2'
variable) and for the subu register which is written at the end. This
variable could be renamed 'subu' and initialized to 0 as you did.

Thanks,
Miqu=C3=A8l
