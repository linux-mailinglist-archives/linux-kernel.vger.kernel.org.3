Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB89D5301A7
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 09:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346469AbiEVHhX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 03:37:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345986AbiEVHhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 03:37:18 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B92A33E0EC;
        Sun, 22 May 2022 00:37:16 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id i27so22823964ejd.9;
        Sun, 22 May 2022 00:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OdhdDP/uxlcANINOeHwQJ1MfvJN8y/K+wdplfOLCUbg=;
        b=Q7vTZzoeodbfmkaLaMjIU/yoC1tkECqU3K6iKZ4VlVbZVdYZymn4X8AizZmULhwZZW
         HKh4Bq4IpzdMFY8uupDPGDVXPIc+okstubtxys/zfpxcQytXclhiT0DQ5lNaAviPpoGi
         G2HhydMwmWaX/5N2cvyefWrUjHYjdQw0u0LdTibjGwH2ZKjOwgkopi3lokgOa4XJ6gxf
         6IVL19F9sSqP/068BF/oY7XJeoT6aCCthhjNCmqJDgodHVJqDS36f1rlGs0mjR0GY4G2
         B2KtbUrSNltXro6jngVpNd56rSWb7gqC+rQXfJgG99jAT2YxrUdbONXd4nwIL77GTf70
         zALQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OdhdDP/uxlcANINOeHwQJ1MfvJN8y/K+wdplfOLCUbg=;
        b=PsxBPvToXZ/AcHYJ59VFyyxa/o8ybIoFdUET1ugHuLrVEjXRYmUjMnkmN8Qn0v5kDO
         LzOuQZXuUqA+8U5Wh9eFoM3aVeA02z3FfLfGBwW4LWXseNpXmKN0h2nR5LeqCY9gMjYo
         LbFZseBKe9Blj9fZL3GEFnMJ2jy6NeWAbfYYbvtNdWhjpQvQFdQfiv108dOXXVqhGN4R
         QdghXpURTua4tPYTTVXG98qXxJyGAN7w1J8bz7A+r+9cxmRw+uzGzGwLU6R8VZ2n9zdY
         6Q/ch8XYXXg+PrabDtrQL7jmwd5iO1etrAWSelIbgZaLfCMa48Kj8jh5A/2PxSU5ZdVi
         32xw==
X-Gm-Message-State: AOAM5328JCgAzBDSrtgyCvtUuhw8FH4Xjh0Vvt4CJY69ViBOGPrKrhza
        Zq6V6YVWmZPXXc+O7Inuh1aAENDbH0yVZw==
X-Google-Smtp-Source: ABdhPJxQBeuln8XMeRYo4K+y9ER4XF9UILSt1sR+YydK3j1021j2KKwVo/wXR5MBMrpqHT1JvAHAqg==
X-Received: by 2002:a17:907:2d10:b0:6fe:debf:bfc7 with SMTP id gs16-20020a1709072d1000b006fedebfbfc7mr304155ejc.502.1653205034817;
        Sun, 22 May 2022 00:37:14 -0700 (PDT)
Received: from jernej-laptop.localnet (89-212-118-115.static.t-2.net. [89.212.118.115])
        by smtp.gmail.com with ESMTPSA id k16-20020a1709067ad000b006fed8dfcf78sm238483ejo.225.2022.05.22.00.37.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 May 2022 00:37:14 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-spdx@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-sunxi@lists.linux.dev
Subject: Re: [patch 10/10] clocksource/drivers/timer-sun5i: Convert to SPDX identifier
Date:   Sun, 22 May 2022 09:37:13 +0200
Message-ID: <4737788.31r3eYUQgx@jernej-laptop>
In-Reply-To: <20220510171254.970933294@linutronix.de>
References: <20220510171003.952873904@linutronix.de> <20220510171254.970933294@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne torek, 10. maj 2022 ob 19:24:51 CEST je Thomas Gleixner napisal(a):
> The license information clearly states GPL version 2 only. The extra text
> which excludes warranties is an excerpt of the corresponding GPLv2 clause
> 11.
> 
> So the SPDX identifier covers it completely.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Cc: Samuel Holland <samuel@sholland.org>
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> Cc: linux-sunxi@lists.linux.dev

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
>  drivers/clocksource/timer-sun5i.c |    5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> --- a/drivers/clocksource/timer-sun5i.c
> +++ b/drivers/clocksource/timer-sun5i.c
> @@ -1,13 +1,10 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * Allwinner SoCs hstimer driver.
>   *
>   * Copyright (C) 2013 Maxime Ripard
>   *
>   * Maxime Ripard <maxime.ripard@free-electrons.com>
> - *
> - * This file is licensed under the terms of the GNU General Public
> - * License version 2.  This program is licensed "as is" without any
> - * warranty of any kind, whether express or implied.
>   */
> 
>  #include <linux/clk.h>




