Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AAA04677DA
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 14:09:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351794AbhLCNMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 08:12:50 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:53546 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239894AbhLCNMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 08:12:48 -0500
Received: from pendragon.ideasonboard.com (cpc89244-aztw30-2-0-cust3082.18-1.cable.virginm.net [86.31.172.11])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id D07E12A5;
        Fri,  3 Dec 2021 14:09:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1638536962;
        bh=JeG57zlvMCaM2kaHo1dn1ZQVl+7DDp/7wuGlRG2esXI=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Kl3BN3KIcMGH+nZEs16ZXfv+/CKZBrFhmrZAzT08XMM7/cYMfKGshkQjXrAOQMASY
         6Dv8seGhoaQnHwUW/kPQ4pRvU5/Bb7DzB4Lw5uffjy59MMr2BeoKtOhAiDMPMLImcO
         Hko62Q1Lc6ZTBSoRModmSLmbdvzBUcDgBUo+JSds=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20211202210335.78015-1-andriy.shevchenko@linux.intel.com>
References: <20211202210335.78015-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/1] media: i2c: max9286: Get rid of duplicate of_node assignment
From:   Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Cc:     Niklas =?utf-8?q?S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Date:   Fri, 03 Dec 2021 13:09:19 +0000
Message-ID: <163853695964.3059017.11079601755830736700@Monstersaurus>
User-Agent: alot/0.10
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Andy Shevchenko (2021-12-02 21:03:35)
> GPIO library does copy the of_node from the parent device of
> the GPIO chip, there is no need to repeat this in the individual
> drivers. Remove assignment here.
>=20
> For the details one may look into the of_gpio_dev_init() implementation.

I see it.

Thanks,

Reviewed-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>

>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/media/i2c/max9286.c | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/drivers/media/i2c/max9286.c b/drivers/media/i2c/max9286.c
> index 7c663fd587bb..a662d3aa0641 100644
> --- a/drivers/media/i2c/max9286.c
> +++ b/drivers/media/i2c/max9286.c
> @@ -1055,7 +1055,6 @@ static int max9286_register_gpio(struct max9286_pri=
v *priv)
>         gpio->label =3D dev_name(dev);
>         gpio->parent =3D dev;
>         gpio->owner =3D THIS_MODULE;
> -       gpio->of_node =3D dev->of_node;
>         gpio->ngpio =3D 2;
>         gpio->base =3D -1;
>         gpio->set =3D max9286_gpio_set;
> --=20
> 2.33.0
>
