Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D36FD4B09AE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 10:39:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238820AbiBJJio (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 04:38:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238772AbiBJJin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 04:38:43 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F33F220;
        Thu, 10 Feb 2022 01:38:45 -0800 (PST)
Received: from pendragon.ideasonboard.com (cpc89244-aztw30-2-0-cust3082.18-1.cable.virginm.net [86.31.172.11])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 0760193;
        Thu, 10 Feb 2022 10:38:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1644485921;
        bh=lF+r6UQCxoqWroIZy8/2n+0n/A+ghFkPyKqL+rYmqL4=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=nIsX+aUCZpg42I5BMkVxnW3NzL+xrWrld4vcDWTJYe3M+saH5lhg4RYD8ixO0PhPA
         zxdQVr58HRIFIJHw95qKt91z0GBERL0glsPJI1b995rxII2iZqNx7dpRJ9nzd8mLw2
         z7fyydxbZPRtyb6Bua6g3icy28+AMgfCMXKh9Yv4=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1644481960-15049-1-git-send-email-wangqing@vivo.com>
References: <1644481960-15049-1-git-send-email-wangqing@vivo.com>
Subject: Re: [PATCH] media: wl128x: use time_after_eq() instead of jiffies judgment
From:   Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc:     Wang Qing <wangqing@vivo.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Qing Wang <wangqing@vivo.com>, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Date:   Thu, 10 Feb 2022 09:38:38 +0000
Message-ID: <164448591856.3354066.6123333934504651771@Monstersaurus>
User-Agent: alot/0.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

All of these patches you've just sent say "Use time_after_eq()" in the
subject, but I haven't yet seen a usage of that.

Could you make your patch subject reflective of the true changes in each
patch please?

Batching them in a series as suggested by Joe would be helpful too.

Quoting Qing Wang (2022-02-10 08:32:39)
> From: Wang Qing <wangqing@vivo.com>
>=20
> It is better to use time_xxx() directly instead of jiffies judgment
> for understanding.
>=20
> Signed-off-by: Wang Qing <wangqing@vivo.com>
> ---
>  drivers/media/radio/wl128x/fmdrv_common.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/media/radio/wl128x/fmdrv_common.c b/drivers/media/ra=
dio/wl128x/fmdrv_common.c
> index 6142484d..a599d08
> --- a/drivers/media/radio/wl128x/fmdrv_common.c
> +++ b/drivers/media/radio/wl128x/fmdrv_common.c
> @@ -23,6 +23,7 @@
>  #include <linux/firmware.h>
>  #include <linux/module.h>
>  #include <linux/nospec.h>
> +#include <linux/jiffies.h>
> =20
>  #include "fmdrv.h"
>  #include "fmdrv_v4l2.h"
> @@ -342,7 +343,7 @@ static void send_tasklet(struct tasklet_struct *t)
>                 return;
> =20
>         /* Check, is there any timeout happened to last transmitted packe=
t */
> -       if ((jiffies - fmdev->last_tx_jiffies) > FM_DRV_TX_TIMEOUT) {
> +       if (time_after(jiffies, fmdev->last_tx_jiffies + FM_DRV_TX_TIMEOU=
T)) {

It looks like there are specific macros for working with jiffies too.

Should this be=20
              time_is_after_jiffies(fmdev->last_tx_jiffies + FM_DRV_TX_TIME=
OUT) {

Although that is in fact 2 characters longer ;-S


--
Kieran


>                 fmerr("TX timeout occurred\n");
>                 atomic_set(&fmdev->tx_cnt, 1);
>         }
> --=20
> 2.7.4
>
