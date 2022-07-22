Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA4057DFC6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 12:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234807AbiGVKZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 06:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235143AbiGVKZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 06:25:06 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9250B9D53E
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 03:24:59 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id oy13so7845567ejb.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 03:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EOEXLOldU7ZOXJVFuOzzIy1TJAM2KQnM9rtTSEMd8Is=;
        b=Z5hOVzONR2hSjRiyIpxdvM0KIHcqCLzpk7zVnvTl4U4q0oGJ+R8P1MSOShCivcDGPg
         w8hwkX8kyTjjAAIk2mOyB0xkssTj/6xp6+a184MJvz9UeZvrql57jfD+xFo7ENa3Qrc8
         sANHEoKz+JtJ7cRXPj+cmURudkULMeTEs0ykQbzpj8OsfhkMdf7L0McBepSGu3461xKW
         CYiPiZ+KlveknszWEKo+3uOnsp5wt7wKAI+sSz8udVjsRPZVmBxI0lwUcFYr3ck9C7z2
         TuVFMN2spFkZ4bZcReL/03ezepwh79rnn5AOa+K8IkYMOquX1hg7Ni/r1TtIMHn0etDe
         qGpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EOEXLOldU7ZOXJVFuOzzIy1TJAM2KQnM9rtTSEMd8Is=;
        b=ZwfTCZQEwCzUqaowYMs/y2E6vX/+EZbsNBevZNHwm8lfiXMI3pQEEVSWWHMDEFxZYe
         7CFJqHeYQyDmHh7nbyBswx8PbBsyAspzedwqoh/Q0wbZ/JBU0bwOHKLv10O/jLPUNW1L
         2+FxH+7MNWDypfYmiFXV8xlv1OSar9a8OqnaIBIUi6Bj+XURa4FQmWZv6Ozv8XQC9ZG+
         gwvKRBOvs/QgFz1sNdUjzJRVjfj2kSi7JKIWLG6tNBalsiQn0OSknc1Y/mVE9BPoeKAx
         ++YsjryhnPu3caopL9lWKrvvqjUdhluL8fQPaRixI3+0X9/IuILgAEjkxmI8yRQM4Evf
         UsEw==
X-Gm-Message-State: AJIora+0UmPL/oi6b+5GTFTT0Cu0O78OzThCtcbVmBhxeb+buu55hZoG
        0mJ7BAZCkEB5wnwyQb/9si7WhvHoOUzGM3/dMl8kvw==
X-Google-Smtp-Source: AGRyM1vFYiAtSA3wjdx/WgQoZqrPge2ctC3H+IT42M19E6+c398L6CTRywieE5NphxcXhV4vq3frhmFGe2h4M/MlBmY=
X-Received: by 2002:a17:907:2888:b0:72b:8f41:1405 with SMTP id
 em8-20020a170907288800b0072b8f411405mr2483664ejc.564.1658485497471; Fri, 22
 Jul 2022 03:24:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220712163823.428126-1-sudip.mukherjee@sifive.com>
 <20220712163823.428126-3-sudip.mukherjee@sifive.com> <3a9877d0-3cc5-6452-764b-d07b38c72b00@microchip.com>
 <CAHyZL-fK-d+dPWG63dcFUz17uP-sG4bnSFVW_gt16snnOVTzpQ@mail.gmail.com>
In-Reply-To: <CAHyZL-fK-d+dPWG63dcFUz17uP-sG4bnSFVW_gt16snnOVTzpQ@mail.gmail.com>
From:   Sudip Mukherjee <sudip.mukherjee@sifive.com>
Date:   Fri, 22 Jul 2022 11:24:46 +0100
Message-ID: <CAHyZL-c9iSd8=CaQ00Nptea4cqp9f7oqS5VefT3vfcr2J3hmSQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] mtd: spi-nor: add support for Quad Page Program to no_sfdp_flags
To:     Tudor Ambarus <Tudor.Ambarus@microchip.com>
Cc:     Pratyush Yadav <p.yadav@ti.com>, Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Jude Onyenegecha <jude.onyenegecha@sifive.com>,
        William Salmon <william.salmon@sifive.com>,
        Adnan Chowdhury <adnan.chowdhury@sifive.com>,
        Ben Dooks <ben.dooks@sifive.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tudor,

On Mon, Jul 18, 2022 at 7:49 PM Sudip Mukherjee
<sudip.mukherjee@sifive.com> wrote:
>
> On Mon, Jul 18, 2022 at 6:02 PM <Tudor.Ambarus@microchip.com> wrote:
> >
> > On 7/12/22 19:38, Sudip Mukherjee wrote:
> > > [You don't often get email from sudip.mukherjee@sifive.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> > >
> > > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > >
> > > Some flash chips which does not have a SFDP table can support Quad
> > > Input Page Program. Enable it in hwcaps if defined.
> > >
>
> <snip>
>
> > > diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
> > > index 58fbedc94080f..dde636bdb1a7c 100644
> > > --- a/drivers/mtd/spi-nor/core.h
> > > +++ b/drivers/mtd/spi-nor/core.h
> > > @@ -462,6 +462,7 @@ struct spi_nor_fixups {
> > >   *   SPI_NOR_OCTAL_READ:      flash supports Octal Read.
> > >   *   SPI_NOR_OCTAL_DTR_READ:  flash supports octal DTR Read.
> > >   *   SPI_NOR_OCTAL_DTR_PP:    flash supports Octal DTR Page Program.
> > > + *   SPI_NOR_QUAD_PP:         flash supports Quad Input Page Program.
> >
> > You don't need this flag if your flash supports the 4-byte Address
> > Instruction Table. Does you flash support it? Can you dump all the
> > SFDP tables, please?
>
> Not sure what the correct way to dump sfdp is. I did this from sysfs.

I tried decoding this SFDP table and I think the parameters table says
it has "3-Byte only addressing".
So, I guess that means it does not support 4-byte Address Instruction
Table. And the datasheet
says it supports "Quad Input Page Program (3-byte Address)".
My existing patchset works for Quad Input Page Program, and I can send
a v2 with the previous
patch and this merged together (as you suggested) or I can try
enabling sfdp for this chip and then use
a fixup_flags to enable "Quad Input Page Program" which I think will
be more complicated.
Which one will you suggest?

--
Regards
Sudip
