Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01F9C483076
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 12:26:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232970AbiACL04 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 3 Jan 2022 06:26:56 -0500
Received: from aposti.net ([89.234.176.197]:56396 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231570AbiACL0z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 06:26:55 -0500
Date:   Mon, 03 Jan 2022 11:26:41 +0000
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH] Input: gpio-keys: Avoid clearing twice some memory
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     dmitry.torokhov@gmail.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Message-Id: <H4T45R.07J01GT7EIY23@crapouillou.net>
In-Reply-To: <d6ee621b9dd75b92f8831db365cee58dc2025322.1640813136.git.christophe.jaillet@wanadoo.fr>
References: <d6ee621b9dd75b92f8831db365cee58dc2025322.1640813136.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le mer., déc. 29 2021 at 22:26:56 +0100, Christophe JAILLET 
<christophe.jaillet@wanadoo.fr> a écrit :
> bitmap_parselist() already clears the 'bits' bitmap, so there is no 
> need
> to clear it when it is allocated. This just wastes some cycles.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Acked-by: Paul Cercueil <paul@crapouillou.net>

Cheers,
-Paul

> ---
>  drivers/input/keyboard/gpio_keys.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/keyboard/gpio_keys.c 
> b/drivers/input/keyboard/gpio_keys.c
> index 8dbf1e69c90a..d75a8b179a8a 100644
> --- a/drivers/input/keyboard/gpio_keys.c
> +++ b/drivers/input/keyboard/gpio_keys.c
> @@ -247,7 +247,7 @@ static ssize_t gpio_keys_attr_store_helper(struct 
> gpio_keys_drvdata *ddata,
>  	ssize_t error;
>  	int i;
> 
> -	bits = bitmap_zalloc(n_events, GFP_KERNEL);
> +	bits = bitmap_alloc(n_events, GFP_KERNEL);
>  	if (!bits)
>  		return -ENOMEM;
> 
> --
> 2.32.0
> 


