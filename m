Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D44D47B6FC
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 02:57:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231481AbhLUB4U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 20:56:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231309AbhLUB4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 20:56:19 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 661E9C061574;
        Mon, 20 Dec 2021 17:56:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=bHLeXu+YMuW4qKMNGcZRf53kShKHZ66lrQQNLJlHeOU=; b=Sd0IVJrnBLyxGYK77jnqtIcNFl
        jY+oRGxJyg0l0Ov7DVxFPs919H48yOJ8rXWVFTLkI+QIN4J916pkwnB4u787lQGQ8zc0xbBzkWfvU
        8xTe7EsL1P47eIRXnhCdyo5dKUx60bVGXTXH7U1DVYyuYMqoujTmQvtGd7+HCog4JHvaYc/INLJxl
        cSji4/9B7v73iaHb1j5//sxuvf7yMzBTmq8fFUEs9lcNpux01OyIKrpxzNslCx9EDI7zql/E4t1rU
        Ascjo+h+knVWDK8scDgZjlc9XkwfPitizGMF1Gaykb48zosiNPd2hCaGc0VXcOVaqccU+E4rZ2Dz3
        ngIvGNPg==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mzUNx-002dI0-45; Tue, 21 Dec 2021 01:56:13 +0000
Message-ID: <00384bd8-f51a-7c7f-9319-c40c33ca14cc@infradead.org>
Date:   Mon, 20 Dec 2021 17:56:08 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH -next] reset: starfive-jh7100: Fix 32bit compilation
Content-Language: en-US
To:     Emil Renner Berthing <kernel@esmil.dk>, soc@kernel.org
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Philipp Zabel <p.zabel@pengutronix.de>
References: <20211220121800.760846-1-kernel@esmil.dk>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20211220121800.760846-1-kernel@esmil.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/20/21 04:17, Emil Renner Berthing wrote:
> We need to include linux/io-64-nonatomic-lo-hi.h or readq/writeq won't
> be defined when compiling on 32bit architectures:
> 
> On i386:
> 
> ../drivers/reset/reset-starfive-jh7100.c: In function ‘jh7100_reset_update’:
> ../drivers/reset/reset-starfive-jh7100.c:81:10: error: implicit declaration of function ‘readq’; did you mean ‘readl’? [-Werror=implicit-function-declaration]
>   value = readq(reg_assert);
>            ^~~~~
> ../drivers/reset/reset-starfive-jh7100.c:86:2: error: implicit declaration of function ‘writeq’; did you mean ‘writel’? [-Werror=implicit-function-declaration]
>   writeq(value, reg_assert);
>   ^~~~~~
> 
> On m68k:
> 
> drivers/reset/reset-starfive-jh7100.c:81:17: error: implicit declaration of function 'readq'; did you mean 'readb'? [-Werror=implicit-function-declaration]
> drivers/reset/reset-starfive-jh7100.c:86:9: error: implicit declaration of function 'writeq'; did you mean 'writel'? [-Werror=implicit-function-declaration]
> cc1: all warnings being treated as errors
> make[3]: *** [scripts/Makefile.build:289: drivers/reset/reset-starfive-jh7100.o] Error 1
> make[2]: *** [scripts/Makefile.build:572: drivers/reset] Error 2
> make[1]: *** [Makefile:1969: drivers] Error 2
> make: *** [Makefile:226: __sub-make] Error 2
> 
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Fixes: 0be3a1595bf8 ("reset: starfive-jh7100: Add StarFive JH7100 reset driver")
> Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>

Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

Thanks.

> ---
>  drivers/reset/reset-starfive-jh7100.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/reset/reset-starfive-jh7100.c b/drivers/reset/reset-starfive-jh7100.c
> index e28a19d271cb..fc44b2fb3e03 100644
> --- a/drivers/reset/reset-starfive-jh7100.c
> +++ b/drivers/reset/reset-starfive-jh7100.c
> @@ -7,6 +7,7 @@
>  
>  #include <linux/bitmap.h>
>  #include <linux/io.h>
> +#include <linux/io-64-nonatomic-lo-hi.h>
>  #include <linux/iopoll.h>
>  #include <linux/mod_devicetable.h>
>  #include <linux/platform_device.h>

-- 
~Randy
