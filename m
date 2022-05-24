Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B1535323EF
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 09:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235120AbiEXHTm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 03:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232123AbiEXHTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 03:19:38 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D045C93471;
        Tue, 24 May 2022 00:19:35 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id BE3641C0008;
        Tue, 24 May 2022 07:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1653376774;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zjs+j4aGboQ+r/y2NDDZnHkMaoAXbFrfp8OX0hEDMTY=;
        b=Hrv8Zsh1HBJE+qiGwCtSziYPbAIIZRQYbqJrscPwH/aKPvucWB7QNCTA/CfL1aexxkOq1F
        wMzpcu4HylA9w6a9lctw6DWeFrYAKpLqs+08J8byQbmBUcgKwmLMLAUj6fyczwFIQloRZn
        th3Z0qWCX/2yH6IzVFzQ4Q316L9NsOkeCjeA9g6LBuL299vbQUKcAVzgJ043AQGAkX/raQ
        LzDa4fppfsEWkyKstWce+crnwcI13wDIrWVqzvYaaw0Yv0HyGCPHjaDweDVd3TnxnVTIjA
        UVkoVlN303xg+Xep8zys1ujxWdm45kwdRo9dQWnBsPK7s8NnZk/K2jUQXVRojw==
Date:   Tue, 24 May 2022 09:19:30 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Haowen Bai <baihaowen@meizu.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Michel Pollet <michel.pollet@bp.renesas.com>,
        <linux-rtc@vger.kernel.org>, <linux-renesas-soc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rtc: rzn1: Fix  inconsistent IS_ERR and PTR_ERR
Message-ID: <20220524091930.51e2a7ef@xps-13>
In-Reply-To: <1653372586-24736-1-git-send-email-baihaowen@meizu.com>
References: <1653372586-24736-1-git-send-email-baihaowen@meizu.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Haowen,

baihaowen@meizu.com wrote on Tue, 24 May 2022 14:09:45 +0800:

> The proper pointer to be passed as argument is rtc->rtcdev.
> Detected using Coccinelle.
>=20
> Fixes: deeb4b5393e1 ("rtc: rzn1: Add new RTC driver")

Thanks for your patch. This has already been reported twice,
Alexandre will likely apply one of the fixes after the merge window.

>=20
> Signed-off-by: Haowen Bai <baihaowen@meizu.com>
> ---
>  drivers/rtc/rtc-rzn1.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/rtc/rtc-rzn1.c b/drivers/rtc/rtc-rzn1.c
> index f92d1398b0f1..4cf54af8a8c3 100644
> --- a/drivers/rtc/rtc-rzn1.c
> +++ b/drivers/rtc/rtc-rzn1.c
> @@ -348,7 +348,7 @@ static int rzn1_rtc_probe(struct platform_device *pde=
v)
> =20
>  	rtc->rtcdev =3D devm_rtc_allocate_device(&pdev->dev);
>  	if (IS_ERR(rtc->rtcdev))
> -		return PTR_ERR(rtc);
> +		return PTR_ERR(rtc->rtcdev);
> =20
>  	rtc->rtcdev->range_min =3D RTC_TIMESTAMP_BEGIN_2000;
>  	rtc->rtcdev->range_max =3D RTC_TIMESTAMP_END_2099;


Thanks,
Miqu=C3=A8l
