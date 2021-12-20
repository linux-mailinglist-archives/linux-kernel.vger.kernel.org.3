Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8E2147A609
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 09:30:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234406AbhLTIaK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 03:30:10 -0500
Received: from mail-ua1-f45.google.com ([209.85.222.45]:36855 "EHLO
        mail-ua1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231287AbhLTIaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 03:30:09 -0500
Received: by mail-ua1-f45.google.com with SMTP id r15so16325401uao.3;
        Mon, 20 Dec 2021 00:30:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rMAO1VGZAlbtYZ79yXzZbE6uNLUuolj3od2YVWnGiLQ=;
        b=UveSCvYZeIXhE5t6S0vI1qJaDHCuld83TYTFt5YiJpP8WSYFirj91wN+ZZdyzNl8aW
         iPWAupDSSGZKgZAIUC+lorFfSUM97T4+7VYFWGzb5dMF+BBeuL9u2T4wYYR7gNoa631b
         0CV4sc9NT6USgc+gmBptoyAKpJewbnUqliHlS64Jc7r71k9hpJjLDiwgm5Qnmg+QLtLJ
         FhCfORKDYSZnrTyeV1ipG6qIjdhFNdNju1XALCtdB0mB7QnoAeqBtvvpUJOsvH3tCy1W
         JB6/TxRr8hzlm2+ROR9ZereDiOvsIyE3Qs2xS6idona8L7vwZ36B3nCMnYeW02IMfjHY
         cM4Q==
X-Gm-Message-State: AOAM530HHaBvSegGY7gfX/JwWqQ0JmE7uWSGDqINmyIIWOR+bTDpJWHN
        Tw5wPeZl29h3aL5qlZ1K4tvOF8E+WRnEEg==
X-Google-Smtp-Source: ABdhPJzS+UuIYwicJpWu84Ncm8JS88IQrccXLSHDYpGL5n3GrMm2owLBJOhETRl2BaLGPjN9bEsUCQ==
X-Received: by 2002:a67:c106:: with SMTP id d6mr4317149vsj.77.1639989008291;
        Mon, 20 Dec 2021 00:30:08 -0800 (PST)
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com. [209.85.222.41])
        by smtp.gmail.com with ESMTPSA id m3sm2540411vsh.7.2021.12.20.00.30.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Dec 2021 00:30:07 -0800 (PST)
Received: by mail-ua1-f41.google.com with SMTP id p2so16235242uad.11;
        Mon, 20 Dec 2021 00:30:07 -0800 (PST)
X-Received: by 2002:a05:6102:2155:: with SMTP id h21mr2504985vsg.68.1639989007492;
 Mon, 20 Dec 2021 00:30:07 -0800 (PST)
MIME-Version: 1.0
References: <20211220081132.883709-1-jiasheng@iscas.ac.cn>
In-Reply-To: <20211220081132.883709-1-jiasheng@iscas.ac.cn>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 20 Dec 2021 09:29:56 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWhs-wTcZNq2VrAZXrxeSNa88GR49j2rn5zSryxF4peOw@mail.gmail.com>
Message-ID: <CAMuHMdWhs-wTcZNq2VrAZXrxeSNa88GR49j2rn5zSryxF4peOw@mail.gmail.com>
Subject: Re: [PATCH v2] video: fbdev: Check for null res pointer
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, shawnguo@kernel.org,
        festevam@gmail.com, linux-imx@nxp.com, linux-fbdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiasheng,

On Mon, Dec 20, 2021 at 9:19 AM Jiasheng Jiang <jiasheng@iscas.ac.cn> wrote:
> The return value of platform_get_resource() needs to be checked.
> To avoid use of error pointer in case that there is no suitable resource.

Thanks for your patch!

> Fixes: f7018c213502 ("video: move fbdev to drivers/video/fbdev")

That can't be the real introducer of the "bug"...

> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>

> --- a/drivers/video/fbdev/imxfb.c
> +++ b/drivers/video/fbdev/imxfb.c
> @@ -1083,6 +1083,8 @@ static int imxfb_remove(struct platform_device *pdev)
>         struct resource *res;
>
>         res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       if (!res)
> +               return -EINVAL;

This cannot happen, as imxfb_remove() can only be called if
imxfb_probe() succeeded.  imxfb_probe() does check the result of
platform_get_resource(), and fails if the resource was not found.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
