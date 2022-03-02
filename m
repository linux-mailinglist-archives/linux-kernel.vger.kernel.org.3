Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 122074CB254
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 23:30:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbiCBWbI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 17:31:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbiCBWbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 17:31:05 -0500
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 929DBE7F6B;
        Wed,  2 Mar 2022 14:30:21 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id b12so2727890qvk.1;
        Wed, 02 Mar 2022 14:30:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ML24VFxrXfMfqzwDIQgpfFTM0/emw2jp9VMO0/xXk6E=;
        b=VD19IUJbn22IqGQs1TEnEdJ37rFzmLayB1HYyyMoWx7NVuIy7o5mYADHLr1b8cOxcb
         3Qpv3FDvdxxZnrp4UQLLp+15C+GY2NT4O8omYxlurZrzNO470WmltkCPDLJFc8dKNvQB
         KMM1JcMP2ZTm/PqIEJmdQXjsYEoiz1nngw/kM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ML24VFxrXfMfqzwDIQgpfFTM0/emw2jp9VMO0/xXk6E=;
        b=7I3RwiZ/lkoZyYU7PoTFjd/vMJgeLzNHjZc3y8rBG+qIxHkNnTjjyz85/5HrsB6GQh
         8FhfLaU7zZcXeIEy4gtwMllPiA/8I8DltrpLhyuCQri31uzEc2PeyTWypLbvlLu7zWLb
         S+tsWP5DTlbCWdPkFMGm8lM2nsGASE0920r5LxEHiMyxLugfReg6x9chi9UfbOWJ82F+
         A/8rtVEevJOCQjkkRr5avLbTy2/mlfzhedB1M7XYWFmzEdj4kQ2/6h8phwJ+fks3lxOM
         Nf94YeOZP3iKtx1B3Y2gQIBvSM1OVItQox4fXa/WwRGSE6R3e/yBhOkS7gvKfukP9s0t
         xJLQ==
X-Gm-Message-State: AOAM532Lb4BRmkfCAPBxA7GqXplG9HGtk9gCjosdHJ6PouzHtKejYU4O
        726Scnfhb9NcijpYPKLUdnkUZCWxHYjcVAe5pRM=
X-Google-Smtp-Source: ABdhPJzJtD+iy3qA83qK2b0/uPlG0vWYsMm4HqktSZgOxSO0FWDUN9MgnYNyp1h+Wqy5l3jmjQa5X2HV+/qsLwLVQrA=
X-Received: by 2002:ad4:4347:0:b0:432:a1f0:f5aa with SMTP id
 q7-20020ad44347000000b00432a1f0f5aamr21695306qvs.49.1646260220663; Wed, 02
 Mar 2022 14:30:20 -0800 (PST)
MIME-Version: 1.0
References: <20220302173114.927476-1-clg@kaod.org> <20220302173114.927476-8-clg@kaod.org>
In-Reply-To: <20220302173114.927476-8-clg@kaod.org>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 2 Mar 2022 22:30:08 +0000
Message-ID: <CACPK8Xesu-3cfH+fPvNGW=JfntTarTSv1njb1FBZ7pD2-TMbMA@mail.gmail.com>
Subject: Re: [PATCH v2 07/10] spi: aspeed: Workaround AST2500 limitations
To:     =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc:     linux-spi@vger.kernel.org,
        linux-mtd <linux-mtd@lists.infradead.org>,
        Mark Brown <broonie@kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>,
        devicetree <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Wed, 2 Mar 2022 at 17:31, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
> It is not possible to configure a full 128MB window for a chip of the
> same size on the AST2500 SPI controller. For his case, the maximum

typo: this

> window size is restricted to 120MB for CE0.
>
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>

Reviewed-by: Joel Stanley <joel@jms.id.au>

> ---
>  drivers/spi/spi-aspeed-smc.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/drivers/spi/spi-aspeed-smc.c b/drivers/spi/spi-aspeed-smc.c
> index 974ab215ec34..e133984d3c95 100644
> --- a/drivers/spi/spi-aspeed-smc.c
> +++ b/drivers/spi/spi-aspeed-smc.c
> @@ -445,6 +445,8 @@ static int aspeed_spi_set_window(struct aspeed_spi *a=
spi,
>   * - ioremap each window, not strictly necessary since the overall windo=
w
>   *   is correct.
>   */
> +static const struct aspeed_spi_data ast2500_spi_data;
> +
>  static int aspeed_spi_chip_adjust_window(struct aspeed_spi_chip *chip,
>                                          u32 local_offset, u32 size)
>  {
> @@ -453,6 +455,16 @@ static int aspeed_spi_chip_adjust_window(struct aspe=
ed_spi_chip *chip,
>         struct aspeed_spi_window *win =3D &windows[chip->cs];
>         int ret;
>
> +       /*
> +        * Due to an HW issue on the AST2500 SPI controller, the CE0
> +        * window size should be smaller than the maximum 128MB.
> +        */
> +       if (aspi->data =3D=3D &ast2500_spi_data && chip->cs =3D=3D 0 && s=
ize =3D=3D SZ_128M) {
> +               size =3D 120 << 20;
> +               dev_info(aspi->dev, "CE%d window resized to %dMB (AST2500=
 HW quirk)",
> +                        chip->cs, size >> 20);
> +       }
> +
>         aspeed_spi_get_windows(aspi, windows);
>
>         /* Adjust this chip window */
> --
> 2.34.1
>
