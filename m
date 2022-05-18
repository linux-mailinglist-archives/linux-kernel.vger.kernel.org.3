Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 058AE52BA9E
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 14:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236343AbiERMSi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 08:18:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236268AbiERMSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 08:18:35 -0400
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68EE650E0C;
        Wed, 18 May 2022 05:18:33 -0700 (PDT)
Received: by mail-oo1-xc34.google.com with SMTP id q73-20020a4a334c000000b0035eb110dd0dso367738ooq.10;
        Wed, 18 May 2022 05:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mQVkiR9K26Mjqv9w5+Bh3SJF7deBKHMCzHUnWBqakyM=;
        b=ZUg1pZdOh4QKOj/mrQGrC/5LZOqSoVPwv+15oaQ+OZrY1ZHDz2r4Njys38Faodan93
         kVqhivAGdKTSRf+QwSEKKxlOR7kF8nzfo6bX50R66+BncfrbKNopSkvptECqHNLSHZbt
         bO69fOW8INae6HprEpucgN1XSNJ1sLcFxwV31QhUCH5fWVtUZzTgK1HZdbSJPjxH+kda
         cq1OS4hbueKOoEnW4sAAQqZnl3rc/X2u55KDCnVIVvIVAoOBnare8QJpJyJY9z+zB54k
         xtUnzw1mkFgWoBwo/JVMVL5WF0RixkHuefX43bcjhSyaAh5wP7lN0B7MZ2VcuJzr09VA
         K1og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mQVkiR9K26Mjqv9w5+Bh3SJF7deBKHMCzHUnWBqakyM=;
        b=Ar3YIBMdDe9XgQ2gHVTrF86MFYG1LvrtpIWbpfEyOorA/+DgYa9J0Jzt7tS9QIMW/Y
         6NrFpAwpfbg44Y/DU3pQYJoD9pLjN1TAf/OR3nnGJlJ8aSoQzxpwt/ZLGRPCkPNzMhYw
         yg5VCmu/FpTg6HynK+lq4NM+fCniE0iICLd/wSr9l3ezHEiGYh7M1noFESZJx2yfUyFg
         u2WHtC1Lhu9VBqrTjr65L6YM4g0cpID+rt0i32wD+Sl5yI8s2W0YhUoVcnhlWsA66ie5
         TR/x689fw/FVxua0vod9wKHn6l/dsq1CF4Lc0Pd0XcnMLT0sTMibg7Tn1/iGGiZHlfRA
         xlsw==
X-Gm-Message-State: AOAM533Z4Rp2TaY0B2WG9S1pqiOvErNGwVD9z8X/ZPaADQf2SVjBBnAV
        64XTsdQvemSaVigfvnvEWmnXUiL8ZI+mBOYGZDo=
X-Google-Smtp-Source: ABdhPJwoIZVHzgubTmduaSfWKij9jgMHdaixLU3LO3nn/8ycnPjnyKbzTNT5SHvdrGyT9o/x7Pexc/6wFvbcV83cKro=
X-Received: by 2002:a4a:d88e:0:b0:35e:a637:be71 with SMTP id
 b14-20020a4ad88e000000b0035ea637be71mr9807579oov.10.1652876312413; Wed, 18
 May 2022 05:18:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220517110737.37148-1-ilpo.jarvinen@linux.intel.com> <20220517110737.37148-2-ilpo.jarvinen@linux.intel.com>
In-Reply-To: <20220517110737.37148-2-ilpo.jarvinen@linux.intel.com>
From:   Shubhrajyoti Datta <shubhrajyoti.datta@gmail.com>
Date:   Wed, 18 May 2022 17:48:21 +0530
Message-ID: <CAKfKVtFO5z68JwFtGDoHAVVfwXvNnT0B_dGZutCLyu6Vo8tXOQ@mail.gmail.com>
Subject: Re: [PATCH 1/9] serial: uartline: Fix BRKINT clearing
To:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Peter Korsgaard <jacmet@sunsite.dk>,
        Sean Anderson <sean.anderson@seco.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
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

On Tue, May 17, 2022 at 5:58 PM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> BRKINT is within c_iflag rather than c_cflag.
Nit typo in the subject line.


>
> Cc: Sean Anderson <sean.anderson@seco.com>
> Fixes: ea017f5853e9 (tty: serial: uartlite: Prevent changing fixed parame=
ters)
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  drivers/tty/serial/uartlite.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/tty/serial/uartlite.c b/drivers/tty/serial/uartlite.=
c
> index 007db67292a2..880e2afbb97b 100644
> --- a/drivers/tty/serial/uartlite.c
> +++ b/drivers/tty/serial/uartlite.c
> @@ -321,7 +321,8 @@ static void ulite_set_termios(struct uart_port *port,=
 struct ktermios *termios,
>         struct uartlite_data *pdata =3D port->private_data;
>
>         /* Set termios to what the hardware supports */
> -       termios->c_cflag &=3D ~(BRKINT | CSTOPB | PARENB | PARODD | CSIZE=
);
> +       termios->c_iflag &=3D ~BRKINT;
> +       termios->c_cflag &=3D ~(CSTOPB | PARENB | PARODD | CSIZE);
>         termios->c_cflag |=3D pdata->cflags & (PARENB | PARODD | CSIZE);
>         tty_termios_encode_baud_rate(termios, pdata->baud, pdata->baud);
>
> --
> 2.30.2
>
