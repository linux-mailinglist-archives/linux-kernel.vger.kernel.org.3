Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93FE951FE2C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 15:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235715AbiEIN1J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 09:27:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236485AbiEIN04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 09:26:56 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D34C1EF08F
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 06:22:19 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 09BA9FF80B;
        Mon,  9 May 2022 13:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1652102527;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hYp7UicfNVk2h+W1pXimL0ouEnlIcPeVZRFiE+KGNmw=;
        b=DsCwXUrGLw7y5zT5ouJuJWAeYpKIYpXbGHRDWJA7femeBQDHbG38oetPYUw3F00wlrT5hA
        VcQrgquobqCorxlWCNKgeTRDf+N++i8i3lqwcMvz+tZ4ftG95MIW5eW6yblJgbEye4wQq5
        xsFNvm4q7vlBhJIa78qcUFtPBVV+TEyQr0FU6Av4X/xlUOFotnoPOtbX5HnfWxmu99UD08
        7X0m3XpmJh1j9FLBPeEJzhA4UW206mGQGN8CZbu7XrhnCkvBAwZXagc5QgnfbmMTqKNNF9
        /OR3WM4s8BomEyozov5Ah8lQHad3DKQTwCw2je9wtvGRsaJm1qCmXeQUB2Tjkw==
Date:   Mon, 9 May 2022 15:22:05 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Guo Zhengkui <guozhengkui@vivo.com>
Cc:     Conor Culhane <conor.culhane@silvaco.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
        zhengkui_guo@outlook.com
Subject: Re: [PATCH] i3c: master: svc: fix returnvar.cocci warning
Message-ID: <20220509152205.5e6432e1@xps13>
In-Reply-To: <20220504164901.9622-1-guozhengkui@vivo.com>
References: <20220504164901.9622-1-guozhengkui@vivo.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
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

Hi,

guozhengkui@vivo.com wrote on Thu,  5 May 2022 00:49:01 +0800:

> Fix the following coccicheck warning:
>=20
> drivers/i3c/master/svc-i3c-master.c:1600:5-8:
> Unneeded variable: "ret". Return "0" on line 1605.
>=20
> Signed-off-by: Guo Zhengkui <guozhengkui@vivo.com>
> ---
>  drivers/i3c/master/svc-i3c-master.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc=
-i3c-master.c
> index 7550dad64ecf..d6e9ed74cdcf 100644
> --- a/drivers/i3c/master/svc-i3c-master.c
> +++ b/drivers/i3c/master/svc-i3c-master.c
> @@ -1597,12 +1597,11 @@ static int __maybe_unused svc_i3c_runtime_suspend=
(struct device *dev)
>  static int __maybe_unused svc_i3c_runtime_resume(struct device *dev)
>  {
>  	struct svc_i3c_master *master =3D dev_get_drvdata(dev);
> -	int ret =3D 0;
> =20
>  	pinctrl_pm_select_default_state(dev);
>  	svc_i3c_master_prepare_clks(master);
> =20
> -	return ret;
> +	return 0;
>  }
> =20
>  static const struct dev_pm_ops svc_i3c_pm_ops =3D {

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miqu=C3=A8l
