Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D5F947345E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 19:52:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239918AbhLMSwr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 13:52:47 -0500
Received: from polaris.svanheule.net ([84.16.241.116]:50206 "EHLO
        polaris.svanheule.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233160AbhLMSwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 13:52:47 -0500
Received: from [IPv6:2a02:a03f:eafe:c901:2a24:b9a0:7e22:e714] (unknown [IPv6:2a02:a03f:eafe:c901:2a24:b9a0:7e22:e714])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id 5ED0C280909;
        Mon, 13 Dec 2021 19:52:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1639421565;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/dsibw+615Whdc7GrNO7E0QGD49G7+bxFYOLZ3kh5cs=;
        b=IimVS9+t9nS+BbyVZcnMFjwYYOsUQOtmXvuC5yx8Qhf36K/ooDMU9odJUO3PLo+22Qp7Cw
        OhU6U4JH/L+o/R2qJCYGl8+90JuHEEHs2edENI1igYqwwT9jzljNHLbIIYortIhTV20ZKN
        UdOWn+xKxMN9jxFHIJgNf70ko6bZMikSKtXI4Xhup1EeLWDddtQj7jG6iv9ZGfKqP4GlhX
        1HuTHkiIjQHsKatH8zhECXC0O48xYKF5rnv8gOQ62e+Zm/NxSpj3O7qO1JB459SYZasFol
        2lOziYvY0CoJduNWxn8CWniBovgZX5VLGUTvbj432XkS0IYelwoQBawGsBscaA==
Message-ID: <cd01c62484faa9a5b364020c5c8985e3ea7fa643.camel@svanheule.net>
Subject: Re: [PATCH 1/9] mips: drop selecting the non-existing config
 SYS_HAS_EARLY_PRINTK_8250
From:   Sander Vanheule <sander@svanheule.net>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Maciej W . Rozycki" <macro@orcam.me.uk>,
        Bert Vermeulen <bert@biot.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Paul Burton <paulburton@kernel.org>,
        Daniel Silsby <dansilsby@gmail.com>,
        Paul Cercueil <paul@crapouillou.net>
Date:   Mon, 13 Dec 2021 19:52:44 +0100
In-Reply-To: <20211213111642.11317-2-lukas.bulwahn@gmail.com>
References: <20211213111642.11317-1-lukas.bulwahn@gmail.com>
         <20211213111642.11317-2-lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.2 (3.42.2-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukas,

Thanks for the patch!

On Mon, 2021-12-13 at 12:16 +0100, Lukas Bulwahn wrote:
> Commit 4042147a0cc6 ("MIPS: Add Realtek RTL838x/RTL839x support as generic
> MIPS system") introduces config MACH_REALTEK_RTL, which selects the
> non-existing config SYS_HAS_EARLY_PRINTK_8250.
> 
> As the MACH_REALTEK_RTL config also selects SYS_HAS_EARLY_PRINTK and
> USE_GENERIC_EARLY_PRINTK_8250, an early printk with 8250 should be covered.
> Probably SYS_HAS_EARLY_PRINTK_8250 is just some left-over from an early
> draft version of this commit.
> 
> Drop selecting the non-existing config SYS_HAS_EARLY_PRINTK_8250.
> 
> Fixes: 4042147a0cc6 ("MIPS: Add Realtek RTL838x/RTL839x support as generic MIPS system")
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
>  arch/mips/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index 00951bfdbab0..c89ce68d9580 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -640,7 +640,6 @@ config MACH_REALTEK_RTL
>         select SYS_SUPPORTS_MULTITHREADING
>         select SYS_SUPPORTS_VPE_LOADER
>         select SYS_HAS_EARLY_PRINTK
> -       select SYS_HAS_EARLY_PRINTK_8250
>         select USE_GENERIC_EARLY_PRINTK_8250
>         select BOOT_RAW
>         select PINCTRL

MACH_REALTEK_RTL doesn't actually call setup_8250_early_printk_port(). That means
USE_GENERIC_EARLY_PRINTK_8250 is also not needed. Being MIPS_GENERIC, that additionaly
means SYS_HAS_EARLY_PRINTK doesn't need to be selected. 

I only recently found the MIPS_GENERIC "early" console therefore doesn't actually work,
but we use the "ns16550a" earlycon console instead. So feel free to also drop the other
two other EARLY_PRINTK symbols, if you think this is in-scope for this patch. Otherwise I
can submit a separate patch later.

In any case:
Acked-by: Sander Vanheule <sander@svanheule.net>


Best,
Sander
