Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7920E49650D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 19:30:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382127AbiAUSaP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 13:30:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382129AbiAUSaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 13:30:13 -0500
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [IPv6:2001:67c:2050::465:201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 291D4C061401;
        Fri, 21 Jan 2022 10:30:13 -0800 (PST)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:105:465:1:2:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4JgSbj1788z9slT;
        Fri, 21 Jan 2022 19:30:09 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=elbmurf.de; s=MBO0001;
        t=1642789807;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UXTtNq6dUV4ZB4z8zbGTA1s1E1gY0IC3MSZJKXa0W2k=;
        b=lQ/TKH95MTzwOEMNBNSg1zEfE8wFqtc+kRubJ6UfO7DbZygav0oFoZji/1JRdqcrQ56Cwc
        6C+Ya4dz8JYk0KYd0jnxC5qH3iyGKXuHHnPuZnTiHbrcdCDu/FMaZFzPBDXUkWihc6y25B
        JzA34URxlIeRJ7uI3rzgLt1d0DY95Lt0d2/y82iEQv2cMP8bvETw5xsIP7mYN25MV+rzs1
        ONmNCORiS7r8vCYHG3X0oAstL61nMgDmrQ6gt75lhEsZqAIJXo2T2NKojg/poaR7bYBHcW
        vOQRhFOZJbn5G2F6FO3EiWCK7KfHHEcM5jG0tb84hZfrOzVDkI66h6VJoOqy5Q==
Message-ID: <12d7f37f-340f-f316-f876-b62a1bd20c52@elbmurf.de>
Date:   Fri, 21 Jan 2022 19:30:04 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] Revert "media: em28xx: add missing
 em28xx_close_extension"
Content-Language: de-DE
To:     Pavel Skripkin <paskripkin@gmail.com>, mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
References: <a0ba3685-8c59-cb89-7f81-280c38a92c40@elbmurf.de>
 <20220120193730.28155-1-paskripkin@gmail.com>
From:   =?UTF-8?Q?Maximilian_B=c3=b6hm?= <maximilian.boehm@elbmurf.de>
In-Reply-To: <20220120193730.28155-1-paskripkin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tested-by: Maximilian Böhm, kernelml@elbmurf.de

Am 20.01.22 um 20:37 schrieb Pavel Skripkin:
> This reverts commit 2c98b8a3458df03abdc6945bbef67ef91d181938.
>
> Reverted patch causes problems with Hauppauge WinTV dualHD as Maximilian
> reported [1]. Since quick solution didn't come up let's just revert it
> to make this device work with upstream kernels.
>
> Cc: Hans Verkuil <hverkuil-cisco@xs4all.nl>
> Link: https://lore.kernel.org/all/6a72a37b-e972-187d-0322-16336e12bdc5@elbmurf.de/ [1]
> Reported-by: Maximilian Böhm <maximilian.boehm@elbmurf.de>
> Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
> ---
>   drivers/media/usb/em28xx/em28xx-cards.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/drivers/media/usb/em28xx/em28xx-cards.c b/drivers/media/usb/em28xx/em28xx-cards.c
> index b451ce3cb169..4a46ef50baf9 100644
> --- a/drivers/media/usb/em28xx/em28xx-cards.c
> +++ b/drivers/media/usb/em28xx/em28xx-cards.c
> @@ -4150,11 +4150,8 @@ static void em28xx_usb_disconnect(struct usb_interface *intf)
>   
>   	em28xx_close_extension(dev);
>   
> -	if (dev->dev_next) {
> -		em28xx_close_extension(dev->dev_next);
> +	if (dev->dev_next)
>   		em28xx_release_resources(dev->dev_next);
> -	}
> -
>   	em28xx_release_resources(dev);
>   
>   	if (dev->dev_next) {
