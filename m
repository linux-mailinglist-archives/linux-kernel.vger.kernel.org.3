Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6431B4A71AF
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 14:37:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344375AbiBBNhC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 08:37:02 -0500
Received: from mail-ua1-f51.google.com ([209.85.222.51]:37462 "EHLO
        mail-ua1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbiBBNhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 08:37:00 -0500
Received: by mail-ua1-f51.google.com with SMTP id b16so19158373uaq.4;
        Wed, 02 Feb 2022 05:37:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f9WjsEImzs4/wXQs95rQ2PrMPR+hf7i8K5ER1ZQOizI=;
        b=5JF/44PmBRRVGECNoyo3gAP4oPUftTmVi6CvKXWIM7P65Tjg9vaYprtzsec5wxpJxK
         79fnqShxglsZ8/l0Z2vAeSP3YchoR4WXWhS4bLsSx97o6QaBIqg8/nE+0DEYaDuz6ruS
         nhARhqYaqBY402eOu2kEKmQEvWGG3D5Dcw2RxbW1ZqUaB7/jJp0ToCY7XZEUmHbFuErq
         huj7z5UJgryw+RFIsSLIAYIToXT7tF/uPiEIJDk3I+aJ9WMuUbuyGYvJGBO9CEW+Y2vG
         5HugZhqMCwxDeT9asExCahxVXLO0EVVyvqsg81DICpqGinZgBbbtTn2KkzNIYD1lCBYu
         2cFw==
X-Gm-Message-State: AOAM532BjvVa+WqB85nFSq0zNbxFtZRqw66siGxM9J2G8cBiDaJCmSOc
        hL1Us+VMqx79G48j4TYFqzP+vU9qz+6zew==
X-Google-Smtp-Source: ABdhPJy+27R3g0HGsRqkDejKj6dzZDtCPVHyuqZI/3KSTDnfSC4My6B6jmS8V3Nx+Hts24aMkryCPQ==
X-Received: by 2002:a9f:2c0a:: with SMTP id r10mr12215040uaj.89.1643809019411;
        Wed, 02 Feb 2022 05:36:59 -0800 (PST)
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com. [209.85.222.52])
        by smtp.gmail.com with ESMTPSA id l67sm2276645vkh.9.2022.02.02.05.36.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Feb 2022 05:36:59 -0800 (PST)
Received: by mail-ua1-f52.google.com with SMTP id c36so19068316uae.13;
        Wed, 02 Feb 2022 05:36:58 -0800 (PST)
X-Received: by 2002:a67:c198:: with SMTP id h24mr12215393vsj.5.1643809018705;
 Wed, 02 Feb 2022 05:36:58 -0800 (PST)
MIME-Version: 1.0
References: <20220121014117.21248-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMuHMdUW+7mCLHnWbPQ4oxNO9Awri9TNN8bTDq7uGSYncAdWKw@mail.gmail.com>
 <OS0PR01MB5922ECB3E4DEDB2595D0101786279@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CAMuHMdXw3Uy=jOivke6exPrUXg4a-yyg_Sg3ote48tqwTCwDzQ@mail.gmail.com> <OS0PR01MB59226A1FEA2A836D885C93A086279@OS0PR01MB5922.jpnprd01.prod.outlook.com>
In-Reply-To: <OS0PR01MB59226A1FEA2A836D885C93A086279@OS0PR01MB5922.jpnprd01.prod.outlook.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 2 Feb 2022 14:36:47 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVOWrc5i508wedtVndTTndZ_sW8=CDUWX1qg=Tmpie-fA@mail.gmail.com>
Message-ID: <CAMuHMdVOWrc5i508wedtVndTTndZ_sW8=CDUWX1qg=Tmpie-fA@mail.gmail.com>
Subject: Re: [PATCH v2] soc: renesas: Add support for reading product revision
 for RZ/G2L family
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Biju,

On Wed, Feb 2, 2022 at 12:20 PM Biju Das <biju.das.jz@bp.renesas.com> wrote:
> > Subject: Re: [PATCH v2] soc: renesas: Add support for reading product
> > revision for RZ/G2L family
> > On Wed, Feb 2, 2022 at 10:51 AM Biju Das <biju.das.jz@bp.renesas.com>
> > wrote:
> > > > Subject: Re: [PATCH v2] soc: renesas: Add support for reading
> > > > product revision for RZ/G2L family On Fri, Jan 21, 2022 at 2:41 AM
> > > > Lad Prabhakar <prabhakar.mahadev- lad.rj@bp.renesas.com> wrote:
> > > > > From: Biju Das <biju.das.jz@bp.renesas.com> As per RZ/G2L HW
> > > > > manual (Rev.1.00 Sep, 2021) DEV_ID [31:28] indicates product
> > > > > revision. Use this information to populate the revision info for
> > > > > RZ/G2L family.
> > > > >
> > > > > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > > > > Signed-off-by: Lad Prabhakar
> > > > > <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > > > > --- a/drivers/soc/renesas/renesas-soc.c
> > > > > +++ b/drivers/soc/renesas/renesas-soc.c
> > > > > @@ -405,41 +417,38 @@ static int __init renesas_soc_init(void)
> > > > >
> > > > >                         eshi = ((product >> 4) & 0x0f) + 1;
> > > > >                         eslo = product & 0xf;
> > > > > +                       soc_dev_attr->revision =
> > > > > + kasprintf(GFP_KERNEL,
> > > > "ES%u.%u",
> > > > > +                                                          eshi,
> > eslo);
> > > > > +               }  else if (id == &id_rzg2l) {
> > > > > +                       eshi =  ((product >> 28) & 0x0f);
> > > > > +                       soc_dev_attr->revision =
> > > > > + kasprintf(GFP_KERNEL,
> > > > "Rev %u",
> > > > > +                                                          eshi);
> > > >
> > > > Would you mind if I would drop the "Rev " while applying?
> > >
> > > Kernel reports the below message after dropping Rev. Is it OK?
> > >
> > > [    0.018297] Detected Renesas RZ/G2L r9a07g044 1
> >
> > That's indeed not so nice...
> >
> > Either we have to add it back, or do something like:
>
> This is much better.
>
> [    0.003427] Detected Renesas RZ/G2L r9a07g044 Rev 1
> root@smarc-rzg2l:~# for i in machine family soc_id revision; do echo -n "$i: ";cat /sys/devices/soc0/$i; done
> machine: Renesas SMARC EVK based on r9a07g044l2
> family: RZ/G2L
> soc_id: r9a07g044
> revision: 1
> root@smarc-rzg2l:~#
>
> >
> > -       pr_info("Detected Renesas %s %s %s\n", soc_dev_attr->family,
> > -               soc_dev_attr->soc_id, soc_dev_attr->revision ?: "");
> > +       pr_info("Detected Renesas %s %s%s%s\n", soc_dev_attr->family,
> > +               soc_dev_attr->soc_id, soc_dev_attr->revision ? " Rev " :
> > "",
> > +               soc_dev_attr->revision ?: "");
> >
>
> Will you post this change or Do you want me to send the patch?
>
> Please let me know.

I'll send a patch, to be folded in to the original.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
