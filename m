Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB2B44949C2
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 09:45:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359329AbiATIpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 03:45:17 -0500
Received: from mail-ua1-f46.google.com ([209.85.222.46]:33384 "EHLO
        mail-ua1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240038AbiATIpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 03:45:16 -0500
Received: by mail-ua1-f46.google.com with SMTP id u6so9600000uaq.0;
        Thu, 20 Jan 2022 00:45:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lv2jFAKWB+Jny0Y4PrrNR/cuL3vXxueExme2w68uWOY=;
        b=Rd/w1+QwYzUk6KBg33XOJuaMGdP1XDaX9HHCMSE7Fqe6KyU4Rji9sURgITFujinIoq
         L3u0n12FQk6pbN6heI3byCw/0rTpNDbRTC/oF5ZuVI2CkKQi2tZ8kxRmSf0iqH/mGPal
         GuYSM+lWc3oV7KVFASOt7fiMmo7duOkq24VSftR2b91eOurLiNc4F26NJKdeVwpG8uQ7
         kmR66WEA3bICvua+l73JJXpzAnDOkVXAhl+2afWHs44+1jRfgi/s7w7UNglHsxCxUPHV
         M6W3G0fhdchxSS6A1SIVHYH34/Im8+mK4q7NZkHDpClyPjFxZqKeWpIQKkKuVqsLYX0r
         CMVg==
X-Gm-Message-State: AOAM530Ay7QkjzR7gOwhUPIM+BhHN4McusS0Z62T09DAllAVihQ/EKNm
        2li+zEAFBHfaWJ+LFbVPzTrAC3aVVfktlQ==
X-Google-Smtp-Source: ABdhPJzhNnVO3mlOOi3f8HurwC42j6bDnk0FoGBdk7q3F8EjkMl1/o/BnERdtMehICC+2xbNVXVPFA==
X-Received: by 2002:a05:6102:b0a:: with SMTP id b10mr8264747vst.39.1642668315540;
        Thu, 20 Jan 2022 00:45:15 -0800 (PST)
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com. [209.85.221.175])
        by smtp.gmail.com with ESMTPSA id b26sm494028uam.6.2022.01.20.00.45.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jan 2022 00:45:15 -0800 (PST)
Received: by mail-vk1-f175.google.com with SMTP id 19so3155951vkl.2;
        Thu, 20 Jan 2022 00:45:15 -0800 (PST)
X-Received: by 2002:a05:6122:c89:: with SMTP id ba9mr14222109vkb.39.1642668314846;
 Thu, 20 Jan 2022 00:45:14 -0800 (PST)
MIME-Version: 1.0
References: <20211220170357.7899-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20211220170357.7899-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 20 Jan 2022 09:45:03 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXKRNDAGqwz0oqJyCWq6LyTdJ7BEe2uCmek60x3Ec2-GA@mail.gmail.com>
Message-ID: <CAMuHMdXKRNDAGqwz0oqJyCWq6LyTdJ7BEe2uCmek60x3Ec2-GA@mail.gmail.com>
Subject: Re: [PATCH] soc: renesas: Add support for reading product revision
 for RZ/G2L family
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prabhakar,

On Mon, Dec 20, 2021 at 6:04 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> From: Biju Das <biju.das.jz@bp.renesas.com>
>
> As per RZ/G2L HW manual (Rev.1.00 Sep, 2021) DEV_ID [31:28] indicates
> product revision. Use this information to populate the revision info
> for RZ/G2L family.
>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Thanks for your patch!

> Below is the log from Renesas RZ/G2L SMARC EVK:
>
> root@smarc-rzg2l:~#
> at /sys/devices/soc0/$i; donemachine family soc_id revision; do echo -n "$i: ";ca

This looks a bit mangled ;-)

> machine: Renesas SMARC EVK based on r9a07g044l2
> family: RZ/G2L
> soc_id: r9a07g044
> revision: Rev 1
> root@smarc-rzg2l:~#
>
> Cheers,
> Prabhakar
> ---
>  drivers/soc/renesas/renesas-soc.c | 31 +++++++++++++++++--------------
>  1 file changed, 17 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/soc/renesas/renesas-soc.c b/drivers/soc/renesas/renesas-soc.c
> index 8f82749f182f..6ecd2763d100 100644
> --- a/drivers/soc/renesas/renesas-soc.c
> +++ b/drivers/soc/renesas/renesas-soc.c
> @@ -416,6 +416,17 @@ static int __init renesas_soc_init(void)
>                 chipid = ioremap(family->reg, 4);
>         }
>
> +       soc_dev_attr = kzalloc(sizeof(*soc_dev_attr), GFP_KERNEL);

This is not freed in case of SoC mismatch error below.

> +       if (!soc_dev_attr)
> +               return -ENOMEM;
> +
> +       np = of_find_node_by_path("/");
> +       of_property_read_string(np, "model", &soc_dev_attr->machine);
> +       of_node_put(np);
> +
> +       soc_dev_attr->family = kstrdup_const(family->name, GFP_KERNEL);
> +       soc_dev_attr->soc_id = kstrdup_const(soc_id, GFP_KERNEL);
> +
>         if (chipid) {
>                 product = readl(chipid + id->offset);
>                 iounmap(chipid);
> @@ -430,6 +441,12 @@ static int __init renesas_soc_init(void)
>
>                         eshi = ((product >> 4) & 0x0f) + 1;
>                         eslo = product & 0xf;
> +                       soc_dev_attr->revision = kasprintf(GFP_KERNEL, "ES%u.%u",
> +                                                          eshi, eslo);
> +               }  else if (id == &id_rzg2l) {
> +                       eshi =  ((product >> 28) & 0x0f);
> +                       soc_dev_attr->revision = kasprintf(GFP_KERNEL, "Rev %u",
> +                                                          eshi);

These are not freed in case of SoC mismatch error below.

>                 }
>
>                 if (soc->id &&
> @@ -439,20 +456,6 @@ static int __init renesas_soc_init(void)
>                 }
>         }
>
> -       soc_dev_attr = kzalloc(sizeof(*soc_dev_attr), GFP_KERNEL);
> -       if (!soc_dev_attr)
> -               return -ENOMEM;
> -
> -       np = of_find_node_by_path("/");
> -       of_property_read_string(np, "model", &soc_dev_attr->machine);
> -       of_node_put(np);
> -
> -       soc_dev_attr->family = kstrdup_const(family->name, GFP_KERNEL);
> -       soc_dev_attr->soc_id = kstrdup_const(soc_id, GFP_KERNEL);
> -       if (eshi)
> -               soc_dev_attr->revision = kasprintf(GFP_KERNEL, "ES%u.%u", eshi,
> -                                                  eslo);
> -
>         pr_info("Detected Renesas %s %s %s\n", soc_dev_attr->family,
>                 soc_dev_attr->soc_id, soc_dev_attr->revision ?: "");

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
