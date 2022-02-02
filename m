Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2C654A6EDA
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 11:38:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231591AbiBBKih (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 05:38:37 -0500
Received: from mail-ua1-f41.google.com ([209.85.222.41]:38783 "EHLO
        mail-ua1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiBBKif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 05:38:35 -0500
Received: by mail-ua1-f41.google.com with SMTP id n15so18276167uaq.5;
        Wed, 02 Feb 2022 02:38:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mEdhH32JRLl4dka4c3SOy+Q/qa9dhrWU9+uGTrYbEM4=;
        b=eVX95AnpLrYV4PKAAIcRitmEOYulT7cUNMx7bJKg1e5SxZqRqaax7LWo4FU4BBo2MW
         LVAiI9WStsICxmMoM26bcPxlhmXreswDKOoOtxGunDBuC7+SODzC7k37mAf+0UJMR1zT
         7/qDxVfFSZxEr94lY+yyE+ZoWeY6vpO98URs59PjVy6crRzc3gpOa8ADgoREkInNtdH7
         BL0RPlSC2+FBO/cS+tT8mraK2Ip+3oQTvAO2F29NE7eubfyC0rGl5znhqcY8nB/EMeum
         ui1yHQsOpDY7JsSt7/9GllaWrdTvVKWrY52AghM/OreRSz4LWwJmaBS9NSW9ixYIS5DK
         kZJg==
X-Gm-Message-State: AOAM532mYgbDGjVRUxRY+8ML3qNWcOqRzNST1X4Aspc5zBOd/yKfnF/E
        ZevSWDFQuGuUpq704H/fzOE9JF0WZZb4Nw==
X-Google-Smtp-Source: ABdhPJwXKrYZHdIyxNmwX0sNTJ/hF4BZ/nM61lp+5QJZre//BiEiJsS30dFkN1iIhslURAuoVuSimw==
X-Received: by 2002:a05:6102:c47:: with SMTP id y7mr9775233vss.20.1643798314811;
        Wed, 02 Feb 2022 02:38:34 -0800 (PST)
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com. [209.85.222.47])
        by smtp.gmail.com with ESMTPSA id z10sm6092414uap.14.2022.02.02.02.38.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Feb 2022 02:38:34 -0800 (PST)
Received: by mail-ua1-f47.google.com with SMTP id n15so18276118uaq.5;
        Wed, 02 Feb 2022 02:38:34 -0800 (PST)
X-Received: by 2002:a67:b00e:: with SMTP id z14mr11213904vse.57.1643798314183;
 Wed, 02 Feb 2022 02:38:34 -0800 (PST)
MIME-Version: 1.0
References: <20220121014117.21248-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMuHMdUW+7mCLHnWbPQ4oxNO9Awri9TNN8bTDq7uGSYncAdWKw@mail.gmail.com> <OS0PR01MB5922ECB3E4DEDB2595D0101786279@OS0PR01MB5922.jpnprd01.prod.outlook.com>
In-Reply-To: <OS0PR01MB5922ECB3E4DEDB2595D0101786279@OS0PR01MB5922.jpnprd01.prod.outlook.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 2 Feb 2022 11:38:23 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXw3Uy=jOivke6exPrUXg4a-yyg_Sg3ote48tqwTCwDzQ@mail.gmail.com>
Message-ID: <CAMuHMdXw3Uy=jOivke6exPrUXg4a-yyg_Sg3ote48tqwTCwDzQ@mail.gmail.com>
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

On Wed, Feb 2, 2022 at 10:51 AM Biju Das <biju.das.jz@bp.renesas.com> wrote:
> > Subject: Re: [PATCH v2] soc: renesas: Add support for reading product
> > revision for RZ/G2L family
> > On Fri, Jan 21, 2022 at 2:41 AM Lad Prabhakar <prabhakar.mahadev-
> > lad.rj@bp.renesas.com> wrote:
> > > From: Biju Das <biju.das.jz@bp.renesas.com>
> > > As per RZ/G2L HW manual (Rev.1.00 Sep, 2021) DEV_ID [31:28] indicates
> > > product revision. Use this information to populate the revision info
> > > for RZ/G2L family.
> > >
> > > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

> > > --- a/drivers/soc/renesas/renesas-soc.c
> > > +++ b/drivers/soc/renesas/renesas-soc.c
> > > @@ -405,41 +417,38 @@ static int __init renesas_soc_init(void)
> > >
> > >                         eshi = ((product >> 4) & 0x0f) + 1;
> > >                         eslo = product & 0xf;
> > > +                       soc_dev_attr->revision = kasprintf(GFP_KERNEL,
> > "ES%u.%u",
> > > +                                                          eshi, eslo);
> > > +               }  else if (id == &id_rzg2l) {
> > > +                       eshi =  ((product >> 28) & 0x0f);
> > > +                       soc_dev_attr->revision = kasprintf(GFP_KERNEL,
> > "Rev %u",
> > > +                                                          eshi);
> >
> > Would you mind if I would drop the "Rev " while applying?
>
> Kernel reports the below message after dropping Rev. Is it OK?
>
> [    0.018297] Detected Renesas RZ/G2L r9a07g044 1

That's indeed not so nice...

Either we have to add it back, or do something like:

-       pr_info("Detected Renesas %s %s %s\n", soc_dev_attr->family,
-               soc_dev_attr->soc_id, soc_dev_attr->revision ?: "");
+       pr_info("Detected Renesas %s %s%s%s\n", soc_dev_attr->family,
+               soc_dev_attr->soc_id, soc_dev_attr->revision ? " Rev " : "",
+               soc_dev_attr->revision ?: "");

Any other options?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
