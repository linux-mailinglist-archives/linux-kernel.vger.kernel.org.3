Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31EAC542E3F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 12:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237425AbiFHKrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 06:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237400AbiFHKrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 06:47:05 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C23DF1AADBB;
        Wed,  8 Jun 2022 03:46:54 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id d14so950793eda.12;
        Wed, 08 Jun 2022 03:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Kxz5ukf9NuI7QZhGGJCWt/BEcAXXCXhyATQAn1S8OfY=;
        b=lEKWusknJIsFlBgjh/ZtAuJt7WzzdwGtj4Zes031YbUPipF8pjOgw2iYGN5WpQQtDs
         /82k4YWJVq8swIXEaOFdpWTT6vALJv6QZT3ly3cDeHDljA1DwCvPFM3LzAZeQVcjUevs
         FZH0AVPc9R+P3mPtAhbJ0Vw/IDVYW8mkU1VRBkEX6oGUC9VVWD6yDqGa+J6xEZIJVNd+
         wuqkmxeNUYWEmAAV9egAYnnjA/e9YIIv91DiuLWYwRWHSik/Kqdlwow7E1+oBUiZ2dz8
         CEAthNQatLMDp5BqFdhuLSoiLhf6um9pLYvJ/4J/fCykHyCosYfMC3DPly13lR2AqoeU
         QZqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Kxz5ukf9NuI7QZhGGJCWt/BEcAXXCXhyATQAn1S8OfY=;
        b=j8IsSPXtJ3CFtVJ8Qa9JVgM+3Gx6OZiF7NEJ8p3Zz11W/pDib3c3tnkwyMzJXeUiZW
         xVPf1ypFhvV2929QEsJqzEkugk34ZKqOCLWkRpaK0TWJGKTTIlIzgFdfh50sbNevcpqG
         6ULpWv+chi2oIwhWmfvxT5twvGnbFyxMX2GhDg8/uDMl1rXRxeb8TCT7JVJgJ4bGU3WW
         pM70kyM12eiF2rENx72bUi+nmyywx76+vBYz6qfeniObusJWkOqclHuk0xDSpO95t31D
         /63Xhc/IYbEYmPY8Rjcpgx+THox+uFeP1gn9zotT2KNHai3p1jwvUNVQXyrqF7I5S0SB
         syHQ==
X-Gm-Message-State: AOAM530HTzbSjxrsep9HVS4JOM5PpRFow5hOZmzFv2ofkngQdfChq6Xa
        3kHIS4DZYeHtfmvaooAuJMZ7WNxP9C+k6N0a944=
X-Google-Smtp-Source: ABdhPJxb00KVhaz+i/HhJ7kC+AwJ9qmD+KBhwD4rUhO9CXne2kPv3/FMPKggPu/znLNrvqUfRgQn1KRQWP8Pp2gL5kI=
X-Received: by 2002:aa7:c396:0:b0:42d:8b86:a8dc with SMTP id
 k22-20020aa7c396000000b0042d8b86a8dcmr37765076edq.54.1654685212994; Wed, 08
 Jun 2022 03:46:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220608095431.18376-1-ilpo.jarvinen@linux.intel.com> <20220608095431.18376-2-ilpo.jarvinen@linux.intel.com>
In-Reply-To: <20220608095431.18376-2-ilpo.jarvinen@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 8 Jun 2022 12:46:16 +0200
Message-ID: <CAHp75Vd+6NiqLgCQkdhCX2Ai==txmxsW2DO+aS53bdsean1nPQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/6] serial: 8250: Store to lsr_save_flags after lsr read
To:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "Matwey V. Kornilov" <matwey@sai.msu.ru>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 8, 2022 at 12:44 PM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> Not all LSR register flags are preserved across reads. Therefore, LSR
> readers must store the non-preserved bits into lsr_save_flags.
>
> This fix was initially mixed into feature commit f6f586102add ("serial:
> 8250: Handle UART without interrupt on TEMT using em485"). However,
> that feature change had a flaw and it was reverted to make room for
> simpler approach providing the same feature. The embedded fix got
> reverted with the feature change.
>
> Re-add the lsr_save_flags fix and properly mark it's a fix.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Fixes: e490c9144cfa ("tty: Add software emulated RS485 support for 8250")
> Link: https://lore.kernel.org/all/1d6c31d-d194-9e6a-ddf9-5f29af829f3@linu=
x.intel.com/T/#m1737eef986bd20cf19593e344cebd7b0244945fc
> Co-developed-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  drivers/tty/serial/8250/8250_port.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/825=
0/8250_port.c
> index 4998799abae2..c5e0f925f4b6 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -1511,6 +1511,8 @@ static inline void __stop_tx(struct uart_8250_port =
*p)
>                 unsigned char lsr =3D serial_in(p, UART_LSR);
>                 u64 stop_delay =3D 0;
>
> +               p->lsr_saved_flags |=3D lsr & LSR_SAVE_FLAGS;
> +
>                 if (!(lsr & UART_LSR_THRE))
>                         return;
>                 /*
> --
> 2.30.2
>


--=20
With Best Regards,
Andy Shevchenko
