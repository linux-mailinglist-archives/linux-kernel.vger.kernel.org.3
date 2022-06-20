Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA4585513E3
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 11:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240627AbiFTJPv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 05:15:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235467AbiFTJPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 05:15:48 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2455310578
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 02:15:42 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id b23so2600558ljh.7
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 02:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=31qkXAXhXqRrqe1Ii07YlWIoTPQBDDXJrZ60sbRxsaY=;
        b=Eyp+EzpsAzGvQb7f/hNtXEbNC89BQQPPsKzbWnZbH1baSLMfxHEcXFPHWGnucCRp8p
         8ql7Vo2CqkmMOyc/szhOJwpUG/D610TIBzKvgZO9RLQ7/SQkckZpqpUIIm5G2I7a5gVc
         WCSFKAxQjGRz4ImOaxsKDS1I/mdb1rpkX8XbqxOICCGybDxOccT1ODiIHdA2oIBs0/Gd
         fU6OQ9wDIo7M3T3euit5yZO0gLHSDcCSlJ8xgEMGJJg8gSbYYc99lsaBtUM7TSektkD3
         dT6EAVYwucRgF0dzbVpCtWlQg7sXjz9sdTzB7Z9q1QHxCjbSb6amFYVP1H/LSHoyG0iD
         q3xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=31qkXAXhXqRrqe1Ii07YlWIoTPQBDDXJrZ60sbRxsaY=;
        b=j3CxucGB2Xji1QLE533R1kIJQapcYkc/7k/mjssR5cvvHoiAd3l4I1Izf24EeZfajQ
         VERktq/9LxtRe6QvHCS1yvM81y6AepODHeVZMsgCtMNeQ7swAVB9gc+Aj4C2Dqcfp1Ll
         ne7vu/TcOlwzciHzsJ5eTvaf69picUurf3lXQCH+BZ6m2TFkDhiP1+UILlQCK4XVoIhe
         uM8RpZrKeTCEkNA/CAK0I/UI78OkxtHJs/ggHg5UesJtksIKZVEGVFawEg68yNTQTDwW
         lVGpIFGjRkUWFQlJYq44p/HCad+mNptaEkQOgoETimLcRrH4cixdFbTsTDWnGLdSXvur
         tY6g==
X-Gm-Message-State: AJIora8b2Lv6AOOcHGhCc8sjBuOrG0iSF0KLexdn4nF3nlzQCa7pjoLX
        oug9k7wPuWiGsAhL8mlWHvkjIOwdYWoST0URJn3WuA==
X-Google-Smtp-Source: AGRyM1scJeYRnEptSEw+aDwE2zYqQ0smNaOHKei8pgrcY2y0euZ7LG3AkBkwGMXH7gtqBkToRQOX+5tmPMjZGX0b+VE=
X-Received: by 2002:a05:651c:514:b0:25a:6232:dbd4 with SMTP id
 o20-20020a05651c051400b0025a6232dbd4mr5074084ljp.5.1655716540417; Mon, 20 Jun
 2022 02:15:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220619074030.1154429-1-mw@semihalf.com> <4dcc3bb4-ea76-527d-701b-289d1d24d73c@linux.intel.com>
In-Reply-To: <4dcc3bb4-ea76-527d-701b-289d1d24d73c@linux.intel.com>
From:   Marcin Wojtas <mw@semihalf.com>
Date:   Mon, 20 Jun 2022 11:15:27 +0200
Message-ID: <CAPv3WKd=TVuW5j4-A81SpHPTqjcasAvHbibC7a6dnOwUH5soqA@mail.gmail.com>
Subject: Re: [PATCH] serial: 8250: dw: enable using pdata with ACPI
To:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        =?UTF-8?Q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>,
        Grzegorz Jaszczyk <jaz@semihalf.com>, upstream@semihalf.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

pon., 20 cze 2022 o 09:31 Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> napisa=C5=82(a):
>
> On Sun, 19 Jun 2022, Marcin Wojtas wrote:
>
> > Commit 3242fe805b52 ("serial: 8250: dw: Move the USR register to pdata"=
)
>
> That commit id is not correct, please fix.
>

Will do, thanks for spotting.

Best regards,
Marcin

> Other than that,
> Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
>
> > caused NULL-pointer dereference when booting with ACPI by unconditional
> > usage of the recently added pdata.
> >
> > In order to fix that and prevent similar issues in future, hook the
> > default version of this structure in dw8250_acpi_match table.
> >
> > Fixes: 3242fe805b52 ("serial: 8250: dw: Move the USR register to pdata"=
)
> > Signed-off-by: Marcin Wojtas <mw@semihalf.com>
> > ---
> >  drivers/tty/serial/8250/8250_dw.c | 24 ++++++++++----------
> >  1 file changed, 12 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/825=
0/8250_dw.c
> > index f57bbd32ef11..3b79bd5c9c9d 100644
> > --- a/drivers/tty/serial/8250/8250_dw.c
> > +++ b/drivers/tty/serial/8250/8250_dw.c
> > @@ -773,18 +773,18 @@ static const struct of_device_id dw8250_of_match[=
] =3D {
> >  MODULE_DEVICE_TABLE(of, dw8250_of_match);
> >
> >  static const struct acpi_device_id dw8250_acpi_match[] =3D {
> > -     { "INT33C4", 0 },
> > -     { "INT33C5", 0 },
> > -     { "INT3434", 0 },
> > -     { "INT3435", 0 },
> > -     { "80860F0A", 0 },
> > -     { "8086228A", 0 },
> > -     { "APMC0D08", 0},
> > -     { "AMD0020", 0 },
> > -     { "AMDI0020", 0 },
> > -     { "AMDI0022", 0 },
> > -     { "BRCM2032", 0 },
> > -     { "HISI0031", 0 },
> > +     { "INT33C4", (kernel_ulong_t)&dw8250_dw_apb },
> > +     { "INT33C5", (kernel_ulong_t)&dw8250_dw_apb },
> > +     { "INT3434", (kernel_ulong_t)&dw8250_dw_apb },
> > +     { "INT3435", (kernel_ulong_t)&dw8250_dw_apb },
> > +     { "80860F0A", (kernel_ulong_t)&dw8250_dw_apb },
> > +     { "8086228A", (kernel_ulong_t)&dw8250_dw_apb },
> > +     { "APMC0D08", (kernel_ulong_t)&dw8250_dw_apb},
> > +     { "AMD0020", (kernel_ulong_t)&dw8250_dw_apb },
> > +     { "AMDI0020", (kernel_ulong_t)&dw8250_dw_apb },
> > +     { "AMDI0022", (kernel_ulong_t)&dw8250_dw_apb },
> > +     { "BRCM2032", (kernel_ulong_t)&dw8250_dw_apb },
> > +     { "HISI0031", (kernel_ulong_t)&dw8250_dw_apb },
> >       { },
> >  };
> >  MODULE_DEVICE_TABLE(acpi, dw8250_acpi_match);
> >
>
> --
>  i.
