Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B880C4D0847
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 21:25:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241593AbiCGU0g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 15:26:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232324AbiCGU0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 15:26:32 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 812B474DDE;
        Mon,  7 Mar 2022 12:25:37 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id qx21so34518871ejb.13;
        Mon, 07 Mar 2022 12:25:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IjS5wu4o1WHiEQruyx1LGz56N/4vOLCWv30WPAE8q6Q=;
        b=DsmUyVP4Wn1NwO0wfWEB0BBjKiGNX8spoxCT4yCCsRwW7owVLQDEoG6TPfS5VGz49m
         ymiYDKhUQYxwHuZ/Hgljkt3iycJvIQ50/43Av6kwN7kLKwvnbS6Jyj7dFgbFqZBMNpjp
         FBNu8otLiMUQNiTFLoQtnHkHJt1FOJ9JEvgmN5OOubvX59IVYFdJOyMMXvArdVpG+Q9A
         J3jelBTwYJMk6qCYAloER1oYKZrPVBngzc9pnVeOUaSvnbrK+K0dhzwGFFFBQqz+fyca
         L1Rm6juJADrYQmWRZKR7zhJ+rLiUOxvgnhjwQGMcUeTo0RDCJZo94BvDMVGmAbU50LJz
         Pvjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IjS5wu4o1WHiEQruyx1LGz56N/4vOLCWv30WPAE8q6Q=;
        b=1g5hKDxECvz/fMFlZP449TECQno+AcK6tJZXNBT4dI1OhgqZwvq/ViRcDJPeQzGti2
         nm6s6WebnvYtrrQc/ZXNWblMrDR3sH+05I/2XkrlLf5T1AKa9hyysCFkFRYhZNykuNVw
         k3tcGDX7tr2DuGPMTjBdpSDP8IDBNSJYOxvVFBu3UveXMbt3kvkM6QqaFRODJVnRJs9z
         cRBTcPXXDsPk00ja1b7P8fcubru3eQt2ISiWIXU1euFAKDfrL7hpC/070+M4n/SZMO13
         3si67PCcXvh6t2K77PWYuzStTkRaeUaDg9MERBXwRycF30PJQUS8avK3w4ypy01g9l73
         iaZg==
X-Gm-Message-State: AOAM5324TqckAYTvnTJ72sIzoU4GLHJpgg3cLI+6iuvospohStDu3B9Y
        S9syyUm3xjdNnrWan9t0x8ZqaUblBiuA1UzpWpo=
X-Google-Smtp-Source: ABdhPJyJElS7UBre+fq6DJ/l5/8SwGOj+xfz86v1y2Ql0mk0t5luB3Rft0HLui6lvCy4O+5Rx8vLUam/JDFCYj33fLs=
X-Received: by 2002:a17:906:cc12:b0:6b5:ec8f:fdf2 with SMTP id
 ml18-20020a170906cc1200b006b5ec8ffdf2mr10153043ejb.579.1646684735868; Mon, 07
 Mar 2022 12:25:35 -0800 (PST)
MIME-Version: 1.0
References: <20220307080810.53847-1-krzysztof.kozlowski@canonical.com> <20220307080925.54131-6-krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220307080925.54131-6-krzysztof.kozlowski@canonical.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 7 Mar 2022 22:24:16 +0200
Message-ID: <CAHp75VdN3MDDEjEoLAudtRW5pgHvfgP7Zt9Hv8OOhfZbHN9hpA@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] tty: serial: samsung: simplify getting OF match data
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Samsung SOC <linux-samsung-soc@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 7, 2022 at 11:20 AM Krzysztof Kozlowski
<krzysztof.kozlowski@canonical.com> wrote:
>
> Simplify the code with of_device_get_match_data().

You may get rid of ugly ifdeffery as well.

...

>  static inline const struct s3c24xx_serial_drv_data *
>  s3c24xx_get_driver_data(struct platform_device *pdev)
>  {
>  #ifdef CONFIG_OF
> -       if (pdev->dev.of_node) {
> -               const struct of_device_id *match;
> -
> -               match = of_match_node(s3c24xx_uart_dt_match, pdev->dev.of_node);
> -               return (struct s3c24xx_serial_drv_data *)match->data;
> -       }

> +       if (pdev->dev.of_node)

I believe it's never true when CONFIG_OF=n,

> +               return of_device_get_match_data(&pdev->dev);
>  #endif
> +
>         return (struct s3c24xx_serial_drv_data *)
>                         platform_get_device_id(pdev)->driver_data;
>  }

-- 
With Best Regards,
Andy Shevchenko
