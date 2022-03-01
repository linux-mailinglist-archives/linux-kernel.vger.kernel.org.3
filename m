Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 715A54C8F10
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 16:26:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235908AbiCAP1B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 10:27:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235682AbiCAP0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 10:26:34 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF066A997D
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 07:25:46 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id p9so21055613wra.12
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 07:25:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pCV3B7TS4aCvWLkBAafjmXlImHeZ58cVSFXmovkWYyU=;
        b=JSEJ86n5yjtPt2dV/f43r6O6uLNJZvnHJQc7tAMwdz6x9W56GcYVlZcuh2D9jq2rNk
         QCkkinyaQrSgD92fl1iodWGfJpFGGO3vicxIvSKYPPIBScrw9Rc5XHFt0/QjrKbQhCpw
         x9yM0ddrQWdnF8ZFEM+meZFcOxQZtwjFVTpghKahXHJLJkT8QXaqXuINo7mfvg5s9x7s
         A6falHN7fL3Tv3q781LymlUw98gkLkHFmoLHVZfC9b1OAq9jmHyiiA661Hv5eSKRWsGV
         9cHQfh/zc7jjHnalpp7kq8w3Extj8deA1OBRHPVRR8ZrBfdQ3IyZgF2Jzs7VBAxRmox9
         gjnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pCV3B7TS4aCvWLkBAafjmXlImHeZ58cVSFXmovkWYyU=;
        b=qYYdsscL/vXvqttoCw3mloqgBrESrtpBn7yQ/Jb0JHj02IRMvCvjbMc9AgsJyrHDEN
         F2kNIq2XJBfmmqwHrFKGRrwDNmkpkjBoLt38c0qwNjlHXmysVcsGWE95i0p5zkM/ADwc
         kDeD5t9ZrJbeXTeJ8evUX1wwahRUd2QzxulzWU1RW3cRlQJ2OUcc84gAri33/F9B2Wjz
         eVTsagk8SivMpHxUReKoxppoU+5Sc6SvD/I1GbDIVbnk1PLBSGTQcbBjIu7axzYnHvhv
         vPDVsfTAcxtpM5+TS9bF8FlZh0o9/kVAKzbXyCTwOmHdONv4YrBtCsZXy6Z65GnpYHZS
         OOLw==
X-Gm-Message-State: AOAM533MRq1Up0/6m+UUMLE0zS4A9N9YfPaaQLgKdRKzyBpDLuqBskSr
        OsnNk0yxCzxmStggMKC6hqLBnPfxEJ+MmRaXxHU=
X-Google-Smtp-Source: ABdhPJyS38TCc+icP/RpAutyaC8cHH7zyMH8To14lcuUGqOjC0yDAZ0DZG5X3WV1r9HpVMgmIV6UialiQIUEJvG2Xdc=
X-Received: by 2002:adf:ec03:0:b0:1f0:2488:8ff9 with SMTP id
 x3-20020adfec03000000b001f024888ff9mr154418wrn.542.1646148345438; Tue, 01 Mar
 2022 07:25:45 -0800 (PST)
MIME-Version: 1.0
References: <20220301124935.2893622-1-michael@walle.cc>
In-Reply-To: <20220301124935.2893622-1-michael@walle.cc>
From:   Heiko Thiery <heiko.thiery@gmail.com>
Date:   Tue, 1 Mar 2022 16:25:33 +0100
Message-ID: <CAEyMn7YnoGnfgauXUDqgkVJ2krt7RrcXHrwfSgxdTmGmkgBPJA@mail.gmail.com>
Subject: Re: [PATCH RFC] mtd: spi-nor: unset quad_enable if SFDP doesn't
 specify it
To:     Michael Walle <michael@walle.cc>
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

Am Di., 1. M=C3=A4rz 2022 um 13:49 Uhr schrieb Michael Walle <michael@walle=
.cc>:
>
> For flashes which use the first JESD216 revision, we don't know
> which enable method for quad mode we can use. The default one in
> spi_nor_init_default_params() is wrong for at least the Macronix
> MX25L12835F, thus clear the enable method. Flashes with such an
> SFDP revision will have to use a flash (and SFDP revision)
> specific fixup.
>
> Signed-off-by: Michael Walle <michael@walle.cc>

Tested-by: Heiko Thiery <heiko.thiery@gmail.com>

> ---
> Please note, completely, untested. Heiko, could you test this without
> having the second series from Tudor applied? Then you should have at
> least a working flash without quad mode.

I removed the second series and applied yours. With that it works.


--
Heiko

>
>  drivers/mtd/spi-nor/sfdp.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mtd/spi-nor/sfdp.c b/drivers/mtd/spi-nor/sfdp.c
> index a5211543d30d..c23e85274ff2 100644
> --- a/drivers/mtd/spi-nor/sfdp.c
> +++ b/drivers/mtd/spi-nor/sfdp.c
> @@ -549,6 +549,14 @@ static int spi_nor_parse_bfpt(struct spi_nor *nor,
>         map->uniform_erase_type =3D map->uniform_region.offset &
>                                   SNOR_ERASE_TYPE_MASK;
>
> +       /*
> +        * The first JESD216 revision doesn't specify a method to enable
> +        * quad mode. spi_nor_init_default_params() will set a legacy
> +        * default method to enable quad mode. We have to disable it
> +        * again.
> +        */
> +       params->quad_enable =3D NULL;
> +
>         /* Stop here if not JESD216 rev A or later. */
>         if (bfpt_header->length =3D=3D BFPT_DWORD_MAX_JESD216)
>                 return spi_nor_post_bfpt_fixups(nor, bfpt_header, &bfpt);
> @@ -562,7 +570,6 @@ static int spi_nor_parse_bfpt(struct spi_nor *nor,
>         /* Quad Enable Requirements. */
>         switch (bfpt.dwords[BFPT_DWORD(15)] & BFPT_DWORD15_QER_MASK) {
>         case BFPT_DWORD15_QER_NONE:
> -               params->quad_enable =3D NULL;
>                 break;
>
>         case BFPT_DWORD15_QER_SR2_BIT1_BUGGY:
> --
> 2.30.2
>
