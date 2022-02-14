Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21ACB4B53F0
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 16:00:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355487AbiBNO6N convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 14 Feb 2022 09:58:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353443AbiBNO6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 09:58:12 -0500
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D61F639A;
        Mon, 14 Feb 2022 06:58:03 -0800 (PST)
Received: by mail-vs1-f41.google.com with SMTP id g20so6930910vsb.9;
        Mon, 14 Feb 2022 06:58:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rS2Rv2GBzmPsRgR8aVJpyB824lH6GkUYYxH2zRSJXDw=;
        b=NNhKLN75afFXXk2G52h7t83qxkYnsyFRg5SzYMfVqMgqzCggv1CF2E2FEoFDi4irYb
         2XOkgOBAwIhtT9MU78y7MjEJ0DijY5H0VlsMKJsLdQ8pUzKEf73tupH9/3/wyclU199Z
         aEqJAQ2+n9wGoRmeqD2Pf5McIAqAtD5KSW4RPOvG81JnG7w3ITT6jAK5ZM4cYfRZOAbT
         gS6NH8Jd0IUcAzDZXWnLP4iIBALEVou3735C8tC5EUKHyOx9dGPs55bkMPuHRPNCLs8Y
         3sZ98HAgfLMOZq6tDfRaUX+pNYYuoMQFftXv+vmyP6WIjSzltgiSsDq6fPoOU4O2BXUY
         p+ug==
X-Gm-Message-State: AOAM530lH07QzVTqknHMCqFKkAf0zVJDsVla865g1F4/aU3JjC+LBKXO
        K9antfAx4wR1G1BOw4Gl8md78/fHCUEDew==
X-Google-Smtp-Source: ABdhPJyWbG0c+QeYwcJysbUjRasFvkyzHlH9vx+ibEHBMQDQ2FgNm0KwIyjyG4FXS5RyGgIoDOOTsw==
X-Received: by 2002:a05:6102:dd0:: with SMTP id e16mr1922949vst.32.1644850682883;
        Mon, 14 Feb 2022 06:58:02 -0800 (PST)
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com. [209.85.217.52])
        by smtp.gmail.com with ESMTPSA id k204sm6209506vkk.0.2022.02.14.06.58.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Feb 2022 06:58:02 -0800 (PST)
Received: by mail-vs1-f52.google.com with SMTP id v6so19081326vsp.11;
        Mon, 14 Feb 2022 06:58:02 -0800 (PST)
X-Received: by 2002:a05:6102:440d:: with SMTP id df13mr1470040vsb.5.1644850682160;
 Mon, 14 Feb 2022 06:58:02 -0800 (PST)
MIME-Version: 1.0
References: <20220214143248.502-1-andriy.shevchenko@linux.intel.com> <20220214143248.502-2-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20220214143248.502-2-andriy.shevchenko@linux.intel.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 14 Feb 2022 15:57:51 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVFY0LZ90vxPiJ9+fWD_gfOtWrEAcRvqOA=4A2SQumHkA@mail.gmail.com>
Message-ID: <CAMuHMdVFY0LZ90vxPiJ9+fWD_gfOtWrEAcRvqOA=4A2SQumHkA@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] serial: sh-sci: Switch to use dev_err_probe_ptr()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jirislaby@kernel.org>,
        Javier Martinez Canillas <javierm@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Mon, Feb 14, 2022 at 3:33 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> Instead of
>         return ERR_PTR(dev_err_probe(...));
> call
>         return dev_err_probe_ptr(...);
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thanks for your patch!

> --- a/drivers/tty/serial/sh-sci.c
> +++ b/drivers/tty/serial/sh-sci.c
> @@ -3199,8 +3199,7 @@ static struct plat_sci_port *sci_parse_dt(struct platform_device *pdev,
>
>         rstc = devm_reset_control_get_optional_exclusive(&pdev->dev, NULL);
>         if (IS_ERR(rstc))
> -               return ERR_PTR(dev_err_probe(&pdev->dev, PTR_ERR(rstc),
> -                                            "failed to get reset ctrl\n"));
> +               return dev_err_probe_ptr(&pdev->dev, PTR_ERR(rstc), "failed to get reset ctrl\n");

I think the joined line is too long, so please keep it split.

drivers/tty/serial/sh-sci.c:3824:10: error: too few arguments to
function ‘dev_err_probe_ptr’

Indeed, dev_err_probe_ptr() is not a varargs function.
BTW, I do like the general idea.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
