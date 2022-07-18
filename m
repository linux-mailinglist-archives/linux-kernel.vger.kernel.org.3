Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 768695789C7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 20:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234628AbiGRSto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 14:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbiGRStm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 14:49:42 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64F1512091
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 11:49:41 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id os14so22992714ejb.4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 11:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ajZurwdncCAgynNzM1MrS9PWiOGYl6kXPZjU9+ZXs/g=;
        b=SO2JrpLHD8/U3tQZJl9vxDLzH9y1488eAfsc5OcHp4Ap/tQCTnUC8PrSHYfv82S3AY
         rDFWm3RtyD9e3TE/1uDsGyymMJEEEMBnPQkCIUVOBY/eCGCKLcqhQNJQxoAo0+YTVpt7
         L2jBrfJnsljJupsGuLN1QTmblDUhugZTNDQK/blCup99f4pKeXmjWFAzyLbBZomHVC6m
         /pvwuuC/QnFA4NJ0ScysJwkXFElXIV1vcoDtITwMImEO9yCfv+VIeg6loUzh4Rl8o/+T
         x53vSTUGoTNHfrV7fWU+VWzR60c4ckzl6c4f6WqYvHqPYGHufFv2LUK1fsPr74/HEUZW
         lC5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ajZurwdncCAgynNzM1MrS9PWiOGYl6kXPZjU9+ZXs/g=;
        b=aM3ahjhKo9WGyecwfWPcfUiainMuKSIxGalm4Eh05hlj8CZTrgXCXZIhvzGOO1leUW
         WxoaZoBzc+Of5u70YoQs0JruFTBXYUcvrqb3VbL0HomlKmMdzmDw+LmuBjeOGbBvF8FX
         U4sTm4tVUo9dCZIaZ8yzsXHzNWOrlSKugBYU3ipUZ3HKjKLCsECXqUZg1cFeI37t0ku9
         K6VEHJw/mujW4vJAZTtxeFYNvPIvgu2gESL0PYWT2ty1YkFQ8M096auBQPwN9kvarDs3
         erPhPXcRLlwsYaw6Ftm4SCPq/zTnHuUyb21NIWDg2Ix0CTOcUs8NpAbDKycROw9UjQvq
         VhWg==
X-Gm-Message-State: AJIora8F0VbhrDmzFECzQCFiWPFJfjpQR9HmBks53RWaoeAYjKzndF9P
        BC5caKWuYq5g/Gm1UIl0qZJmvJ2KjWncN3iQCj54Vg==
X-Google-Smtp-Source: AGRyM1uLbEvkc2rMlroHMhlr35e2sn4YRTKHuTV3sqCTjdfNxB3zt4pfVIM3eVGqnYLKlWJBuDZLe0PPWNJqIolIXwg=
X-Received: by 2002:a17:907:2888:b0:72b:8f41:1405 with SMTP id
 em8-20020a170907288800b0072b8f411405mr26049141ejc.564.1658170180010; Mon, 18
 Jul 2022 11:49:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220712163823.428126-1-sudip.mukherjee@sifive.com>
 <20220712163823.428126-3-sudip.mukherjee@sifive.com> <3a9877d0-3cc5-6452-764b-d07b38c72b00@microchip.com>
In-Reply-To: <3a9877d0-3cc5-6452-764b-d07b38c72b00@microchip.com>
From:   Sudip Mukherjee <sudip.mukherjee@sifive.com>
Date:   Mon, 18 Jul 2022 19:49:29 +0100
Message-ID: <CAHyZL-fK-d+dPWG63dcFUz17uP-sG4bnSFVW_gt16snnOVTzpQ@mail.gmail.com>
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

On Mon, Jul 18, 2022 at 6:02 PM <Tudor.Ambarus@microchip.com> wrote:
>
> On 7/12/22 19:38, Sudip Mukherjee wrote:
> > [You don't often get email from sudip.mukherjee@sifive.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> >
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> >
> > Some flash chips which does not have a SFDP table can support Quad
> > Input Page Program. Enable it in hwcaps if defined.
> >

<snip>

> > diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
> > index 58fbedc94080f..dde636bdb1a7c 100644
> > --- a/drivers/mtd/spi-nor/core.h
> > +++ b/drivers/mtd/spi-nor/core.h
> > @@ -462,6 +462,7 @@ struct spi_nor_fixups {
> >   *   SPI_NOR_OCTAL_READ:      flash supports Octal Read.
> >   *   SPI_NOR_OCTAL_DTR_READ:  flash supports octal DTR Read.
> >   *   SPI_NOR_OCTAL_DTR_PP:    flash supports Octal DTR Page Program.
> > + *   SPI_NOR_QUAD_PP:         flash supports Quad Input Page Program.
>
> You don't need this flag if your flash supports the 4-byte Address
> Instruction Table. Does you flash support it? Can you dump all the
> SFDP tables, please?

Not sure what the correct way to dump sfdp is. I did this from sysfs.

# cat sfdp | xxd
00000000: 5346 4450 0601 01ff 0006 0110 3000 00ff  SFDP........0...
00000010: 9d05 0103 8000 0002 ffff ffff ffff ffff  ................
00000020: ffff ffff ffff ffff ffff ffff ffff ffff  ................
00000030: e520 f9ff ffff ff0f 44eb 086b 083b 80bb  . ......D..k.;..
00000040: feff ffff ffff 00ff ffff 44eb 0c20 0f52  ..........D.. .R
00000050: 10d8 00ff 234a c900 82d8 11ce cccd 6846  ....#J........hF
00000060: 7a75 7a75 f7ae d55c 4a42 2cff f030 faa9  zuzu...\JB,..0..
00000070: ffff ffff ffff ffff ffff ffff ffff ffff  ................
00000080: 5019 5016 9ff9 c064 8fef ffff            P.P....d....


--
Regards
Sudip
