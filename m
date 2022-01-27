Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CA5049DEEE
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 11:12:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232441AbiA0KMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 05:12:47 -0500
Received: from mail-ua1-f49.google.com ([209.85.222.49]:36775 "EHLO
        mail-ua1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiA0KMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 05:12:45 -0500
Received: by mail-ua1-f49.google.com with SMTP id u76so3808915uau.3;
        Thu, 27 Jan 2022 02:12:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y8tFLfG3AkbX5FC2LkFwx+nrAMcVQcoVBJvwDmbMZbE=;
        b=ghD6eUP5+9xYrVMzM4SXkCmEgS8ZwIVwvqpd0PwSB9TGpw4BHRw/Jve3AYZi02vDXP
         1jVif9W4JdGBcJrQ/TaIpQcuyx4zFPFiJEEL8dgPxSpu/fMR/KL6EdOBuNgO5iDN0cir
         zkXbfjsgAnTFBqHMo3hB2T5Hem76Mm8/nxSlknwtOVDcncYH6iQ0F3zbZ6BbK2RjLHhq
         Zdw/PHSFNC9uJj+2y765ba13C/CDKgBLOqyNPTXyb6zelrNczKUCGbbF04QMoZPyuwz9
         syNs97JXqd00tKqWp5RTice7AimkGSyimiOlRJ5stECQorkpatm+ps3puic0/LWRFC8G
         WXIw==
X-Gm-Message-State: AOAM530hPE4PpTYhPUTZQPC864PFvtuGxg4HhdXOLT/e5gaSCjWLYoKG
        F7nIMyJUPbF58rUI+dfoIrDZhMqLA74Jkw==
X-Google-Smtp-Source: ABdhPJygabxpKaOvJSjf6MZ745UE5jG/K/hV4OcXsIIiAXNGIOa32UslKNPUjZ6tGIn6tA+/4m7u+w==
X-Received: by 2002:a67:b003:: with SMTP id z3mr1292949vse.64.1643278365124;
        Thu, 27 Jan 2022 02:12:45 -0800 (PST)
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com. [209.85.222.48])
        by smtp.gmail.com with ESMTPSA id z27sm489554vsf.24.2022.01.27.02.12.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jan 2022 02:12:44 -0800 (PST)
Received: by mail-ua1-f48.google.com with SMTP id y4so3825165uad.1;
        Thu, 27 Jan 2022 02:12:44 -0800 (PST)
X-Received: by 2002:ab0:6cf9:: with SMTP id l25mr1377097uai.122.1643278364573;
 Thu, 27 Jan 2022 02:12:44 -0800 (PST)
MIME-Version: 1.0
References: <20220121014117.21248-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220121014117.21248-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 27 Jan 2022 11:12:33 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUW+7mCLHnWbPQ4oxNO9Awri9TNN8bTDq7uGSYncAdWKw@mail.gmail.com>
Message-ID: <CAMuHMdUW+7mCLHnWbPQ4oxNO9Awri9TNN8bTDq7uGSYncAdWKw@mail.gmail.com>
Subject: Re: [PATCH v2] soc: renesas: Add support for reading product revision
 for RZ/G2L family
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prabhakar,

On Fri, Jan 21, 2022 at 2:41 AM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> From: Biju Das <biju.das.jz@bp.renesas.com>
>
> As per RZ/G2L HW manual (Rev.1.00 Sep, 2021) DEV_ID [31:28] indicates
> product revision. Use this information to populate the revision info
> for RZ/G2L family.
>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> v1->v2
> * Fixed freeing up soc_dev_attr in error path.

Thanks for the update!

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v5.18.

> --- a/drivers/soc/renesas/renesas-soc.c
> +++ b/drivers/soc/renesas/renesas-soc.c
> @@ -405,41 +417,38 @@ static int __init renesas_soc_init(void)
>
>                         eshi = ((product >> 4) & 0x0f) + 1;
>                         eslo = product & 0xf;
> +                       soc_dev_attr->revision = kasprintf(GFP_KERNEL, "ES%u.%u",
> +                                                          eshi, eslo);
> +               }  else if (id == &id_rzg2l) {
> +                       eshi =  ((product >> 28) & 0x0f);
> +                       soc_dev_attr->revision = kasprintf(GFP_KERNEL, "Rev %u",
> +                                                          eshi);

Would you mind if I would drop the "Rev " while applying?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
