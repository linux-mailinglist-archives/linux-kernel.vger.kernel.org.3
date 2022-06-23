Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53B0F557285
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 07:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbiFWFP1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 01:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiFWFPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 01:15:24 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DC75D8F;
        Wed, 22 Jun 2022 22:15:22 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id h14-20020a1ccc0e000000b0039eff745c53so752069wmb.5;
        Wed, 22 Jun 2022 22:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=oPeA0hoICoghXxDRi6yeZio4UQ/8IEJ0AJS1aepLCoY=;
        b=PPC5vEfOOiUED1jMF7smhAcCdLoazsLATSan19A9GSR0SJ+lwhPotJnKxyDlgbgSP1
         sohoypREZdPDd8p1hqHZxKnBKBEz+CGwt5yha1CLMxLhgRVPf404tOIHhO/b++WVZVEa
         LnWH7my/aosu7ZcJWBM6/zJXTkRQ40bp/Qq9E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=oPeA0hoICoghXxDRi6yeZio4UQ/8IEJ0AJS1aepLCoY=;
        b=xYJofVEX8ZutDMBM0tiAwaqfQKuaRTUJ/bNZVh3SOpXlKEo3abNox1f6NImTobqhWW
         IMTr6HGqguiwvD1nv4EzGzl9FvVOh9X5R6HSUWjjZmTk86W7OG9F2b0bSJ/7QqwtWkwR
         qsG1lVbBKBOrirrwdtWcTSqzuAlLUjAuyr89GRrfvaXe0AuEs5LWYy6MLjruAzXijAYQ
         zZcgq22x9H8FORGsNaJN4vWfI810LXsC/2UkvIoCT/DE8aX4OMPYoXNWk6coWsc79vmj
         T70xyme7BNnGhfiwGiSwVJTHXsJeAxf+73veewYSXSGxYPj4nJcaQFnTE8cnKRF0CEvb
         OBaQ==
X-Gm-Message-State: AJIora/urzOhNUH0Ubz8eihWQvN9etlsq+/bAvjqMZ2hW3AC/z1bRox9
        hUqnjjBsMwPTlMV9hpecIQhy+Mkf1hEb6VbJvsw=
X-Google-Smtp-Source: AGRyM1u4Z/YtN0xWZHHdwVAqbHPAHfcCY3NJ3W9gw5ET54aG8ykNlJ5ZA86+dwL1I9imO6luKzAx//VpSKtT7snEWkQ=
X-Received: by 2002:a05:600c:1990:b0:39c:81f0:a882 with SMTP id
 t16-20020a05600c199000b0039c81f0a882mr1879834wmq.72.1655961320646; Wed, 22
 Jun 2022 22:15:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220622161617.3719096-1-clg@kaod.org> <20220622161617.3719096-2-clg@kaod.org>
In-Reply-To: <20220622161617.3719096-2-clg@kaod.org>
From:   Joel Stanley <joel@jms.id.au>
Date:   Thu, 23 Jun 2022 05:15:07 +0000
Message-ID: <CACPK8XdeEmv7exWngQkEYs+oj5vV6YjqSvvfuq+5fn8MotxpsA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] spi: aspeed: Add dev_dbg() to dump the spi-mem
 direct mapping descriptor
To:     =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc:     linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Pratyush Yadav <p.yadav@ti.com>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Paul Menzel <pmenzel@molgen.mpg.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Jun 2022 at 16:16, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
> The default value of the control register is set using the direct
> mapping information passed to the ->dirmap_create() handler. Dump the
> mapping range and the SPI memory operation characteristics to analyze
> how the register value has been computed.
>
>   spi-aspeed-smc 1e630000.spi: CE0 read dirmap [ 0x00000000 - 0x04000000 =
] OP 0x6c mode:1.1.1.4 naddr:0x4 ndummies:0x1
>   ...
>   spi-aspeed-smc 1e630000.spi: CE0 write dirmap [ 0x00000000 - 0x04000000=
 ] OP 0x12 mode:1.1.0.1 naddr:0x4 ndummies:0x0
>
> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>

Very handy! Thanks C=C3=A9dric.

Reviewed-by: Joel Stanley <joel@jms.id.au>

> ---
>  drivers/spi/spi-aspeed-smc.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/spi/spi-aspeed-smc.c b/drivers/spi/spi-aspeed-smc.c
> index 496f3e1e9079..ac64be289e59 100644
> --- a/drivers/spi/spi-aspeed-smc.c
> +++ b/drivers/spi/spi-aspeed-smc.c
> @@ -558,6 +558,14 @@ static int aspeed_spi_dirmap_create(struct spi_mem_d=
irmap_desc *desc)
>         u32 ctl_val;
>         int ret =3D 0;
>
> +       dev_dbg(aspi->dev,
> +               "CE%d %s dirmap [ 0x%.8llx - 0x%.8llx ] OP %#x mode:%d.%d=
.%d.%d naddr:%#x ndummies:%#x\n",
> +               chip->cs, op->data.dir =3D=3D SPI_MEM_DATA_IN ? "read" : =
"write",
> +               desc->info.offset, desc->info.offset + desc->info.length,
> +               op->cmd.opcode, op->cmd.buswidth, op->addr.buswidth,
> +               op->dummy.buswidth, op->data.buswidth,
> +               op->addr.nbytes, op->dummy.nbytes);
> +
>         chip->clk_freq =3D desc->mem->spi->max_speed_hz;
>
>         /* Only for reads */
> --
> 2.35.3
>
