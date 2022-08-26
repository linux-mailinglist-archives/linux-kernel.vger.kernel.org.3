Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F12205A2B79
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 17:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343819AbiHZPmu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 11:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232426AbiHZPms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 11:42:48 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40CF92252C;
        Fri, 26 Aug 2022 08:42:47 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id l5so1534631qtv.4;
        Fri, 26 Aug 2022 08:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=UFYQwmu3rx37rlaV8i6ZO9uxfEYKF+2shE4ZpYEpXS0=;
        b=E3xS99QZ67M2h0xfnm0VDKCylMbX5vRHMTg/Ekxj0HA9cukoYWwbOCkO1UIZgGnmT+
         ZNaw78blv4nAGekONnxH0iNYZmuDcathGUWYm4e3bo2PhXd2D9nc7xlP+GRbHYKuWM9f
         2B9ZBXkrwVHXivhiHK9+JU05/e91rdQJbOBneio8fOgeJDcA9o4ufmgC/Y+zOPOaJn8c
         JUDV+QD6f8VWhYqG9/PR6RjIQAZrPpKGrrKRjhXFKi9V6Ci0NZTiXeM+xrM7T6LAum43
         DdA0vnamqruIuq4btn0Bz3+zMs0EoOk5jHctBOocmTY/XSUa66Jakqry3h2d4/zrxsmW
         Ge8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=UFYQwmu3rx37rlaV8i6ZO9uxfEYKF+2shE4ZpYEpXS0=;
        b=xfGS6vD8+F55/Dy1XrTcbMTaYaD2R0j7JtBij4fy9blzDw5hRqPsmL8Mz0K6+JeAi+
         0BuRLXHFWrMpwRvj6+X0Owx2Jzh1ImU2WjUtuyKwtbNNO2uVk18u1WOyLcJ21nZyZXY8
         gbwQ+R/anbFWTpKQVJGZmuCzY2bg1uanSiA/c6LSgZ8YI7rG0K5hrmefXsmOaLTjEv6F
         b/JJ1+EMvEnrJVj4T+LjxVqHwwz9uTUi3nxAM/DXSGYddi526MxH+fKsUmCoxED+T9YX
         fB4mZf+mOX/vFcoYgvZqPdp+eGObxaZeZFi0H76D9cu3E8mPA3suWdVtKCkFrMiSodjg
         5KVw==
X-Gm-Message-State: ACgBeo1dGBFTMI7GDSKuR7QtpeZd90G6bOzYOk4xV2/0n8m9K0r873Uh
        MQg4qA6LwWfDOjJkIl4BgmWcUbSzJ1+5ahf4l2JPNy8/bWE=
X-Google-Smtp-Source: AA6agR79yyBV/4OsWRReLPHNkWaTO++FBqvIDX8IR/keAnrVwQdeR4bl6BBuHUsQrakm0ZSX9myzbyqFXg44YIBIXuM=
X-Received: by 2002:ac8:5786:0:b0:343:3051:170d with SMTP id
 v6-20020ac85786000000b003433051170dmr234782qta.429.1661528566343; Fri, 26 Aug
 2022 08:42:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220826144629.11507-1-ilpo.jarvinen@linux.intel.com> <20220826144629.11507-3-ilpo.jarvinen@linux.intel.com>
In-Reply-To: <20220826144629.11507-3-ilpo.jarvinen@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 26 Aug 2022 18:42:10 +0300
Message-ID: <CAHp75Vf5v3dvm1FeJa-KNNiqKKYfc9S8xjcMPJPTKYjZFjunSA@mail.gmail.com>
Subject: Re: [PATCH 2/3] serial: add helpers to copy serial_rs485 from/to userspace
To:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>
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

On Fri, Aug 26, 2022 at 5:51 PM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> Due to the padding fields, the copying will need to a bit more than
> usual.
>
> Move padding clearing into the helper that copies back to userspace.

If you agree on the below and address as suggested,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  drivers/tty/serial/serial_core.c | 41 +++++++++++++++++++++-----------
>  1 file changed, 27 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial=
_core.c
> index 9c1bf36b7a93..6d57cfdeda9d 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -1375,10 +1375,6 @@ static void uart_sanitize_serial_rs485(struct uart=
_port *port, struct serial_rs4
>         rs485->flags &=3D supported_flags;
>
>         uart_sanitize_serial_rs485_delays(port, rs485);
> -
> -       /* Return clean padding area to userspace */
> -       memset(rs485->padding0, 0, sizeof(rs485->padding0));
> -       memset(rs485->padding1, 0, sizeof(rs485->padding1));
>  }
>
>  static void uart_set_rs485_termination(struct uart_port *port,
> @@ -1407,6 +1403,28 @@ int uart_rs485_config(struct uart_port *port)
>  }
>  EXPORT_SYMBOL_GPL(uart_rs485_config);
>
> +static int user_rs485_to_kernel_serial_rs485(struct serial_rs485 *rs485,
> +                                            const struct serial_rs485 __=
user *rs485_user)

What about

serial_rs485_from_user()

> +{
> +       if (copy_from_user(rs485, rs485_user, sizeof(*rs485)))
> +               return -EFAULT;
> +
> +       return 0;
> +}
> +
> +static int kernel_serial_rs485_to_user_rs485(struct serial_rs485 __user =
*rs485_user,
> +                                            struct serial_rs485 *rs485)

serial_rs485_to_user()

?

> +{
> +       /* Return clean padding area to userspace */
> +       memset(rs485->padding0, 0, sizeof(rs485->padding0));
> +       memset(rs485->padding1, 0, sizeof(rs485->padding1));
> +
> +       if (copy_to_user(rs485_user, rs485, sizeof(*rs485)))
> +               return -EFAULT;
> +
> +       return 0;
> +}
> +
>  static int uart_get_rs485_config(struct uart_port *port,
>                          struct serial_rs485 __user *rs485_user)
>  {
> @@ -1417,10 +1435,7 @@ static int uart_get_rs485_config(struct uart_port =
*port,
>         rs485 =3D port->rs485;
>         spin_unlock_irqrestore(&port->lock, flags);
>
> -       if (copy_to_user(rs485_user, &rs485, sizeof(rs485)))
> -               return -EFAULT;
> -
> -       return 0;
> +       return kernel_serial_rs485_to_user_rs485(rs485_user, &rs485);
>  }
>
>  static int uart_set_rs485_config(struct tty_struct *tty, struct uart_por=
t *port,
> @@ -1433,8 +1448,9 @@ static int uart_set_rs485_config(struct tty_struct =
*tty, struct uart_port *port,
>         if (!port->rs485_config)
>                 return -ENOTTY;
>
> -       if (copy_from_user(&rs485, rs485_user, sizeof(*rs485_user)))
> -               return -EFAULT;
> +       ret =3D user_rs485_to_kernel_serial_rs485(&rs485, rs485_user);
> +       if (ret)
> +               return ret;
>
>         ret =3D uart_check_rs485_flags(port, &rs485);
>         if (ret)
> @@ -1450,10 +1466,7 @@ static int uart_set_rs485_config(struct tty_struct=
 *tty, struct uart_port *port,
>         if (ret)
>                 return ret;
>
> -       if (copy_to_user(rs485_user, &port->rs485, sizeof(port->rs485)))
> -               return -EFAULT;
> -
> -       return 0;
> +       return kernel_serial_rs485_to_user_rs485(rs485_user, &port->rs485=
);
>  }
>
>  static int uart_get_iso7816_config(struct uart_port *port,
> --
> 2.30.2
>


--=20
With Best Regards,
Andy Shevchenko
