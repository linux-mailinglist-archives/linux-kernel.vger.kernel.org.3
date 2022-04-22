Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A0CC50B9FE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 16:23:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1448589AbiDVOZ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 10:25:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1448333AbiDVOZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 10:25:27 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EF481CFCE;
        Fri, 22 Apr 2022 07:22:33 -0700 (PDT)
Received: from pendragon.ideasonboard.com (cpc89244-aztw30-2-0-cust3082.18-1.cable.virginm.net [86.31.172.11])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id C0A332F7;
        Fri, 22 Apr 2022 16:22:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1650637351;
        bh=wZifj+fUEBhv1yJJc/JjqYEk/AIauY1nIeQNs8Vfq5M=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=AVrFqNQBMQ08PG/1j2E2IaWmP4UHB6LrGSoilBvdiiHNDF4f3oq+QDV69K4C/Shdp
         mCMNZ6fua8sS684gPmro1TpZwBFhXKn/Khh3NszaDScNpybYCGgtO//roB6WZJ+9U7
         CpFuJH56kH90x+3COBtf7kNi4VWYR/PqpQjx5hNA=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1650607607-22893-1-git-send-email-baihaowen@meizu.com>
References: <1650607607-22893-1-git-send-email-baihaowen@meizu.com>
Subject: Re: [PATCH] media: m920x: Remove useless kfree
From:   Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc:     Haowen Bai <baihaowen@meizu.com>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
To:     Haowen Bai <baihaowen@meizu.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Date:   Fri, 22 Apr 2022 15:22:28 +0100
Message-ID: <165063734898.3204481.2637889109438003078@Monstersaurus>
User-Agent: alot/0.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Haowen Bai (2022-04-22 07:06:47)
> After alloc fail, we do not need to kfree.
>=20

Agreed, this shouldn't hurt as kfree will be a noop here but it is
always null so redundant.

May still warrant a fixes tag though, but it's not a critical fix.


Reviewed-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>

> Signed-off-by: Haowen Bai <baihaowen@meizu.com>
> ---
>  drivers/media/usb/dvb-usb/m920x.c | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/drivers/media/usb/dvb-usb/m920x.c b/drivers/media/usb/dvb-us=
b/m920x.c
> index 548199cd86f6..9df0ccfb654b 100644
> --- a/drivers/media/usb/dvb-usb/m920x.c
> +++ b/drivers/media/usb/dvb-usb/m920x.c
> @@ -277,7 +277,6 @@ static int m920x_i2c_xfer(struct i2c_adapter *adap, s=
truct i2c_msg msg[], int nu
>                         char *read =3D kmalloc(1, GFP_KERNEL);
>                         if (!read) {
>                                 ret =3D -ENOMEM;
> -                               kfree(read);
>                                 goto unlock;
>                         }
> =20
> --=20
> 2.7.4
>
