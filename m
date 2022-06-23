Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC755576FF
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 11:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbiFWJqv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 05:46:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbiFWJql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 05:46:41 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C424949927;
        Thu, 23 Jun 2022 02:46:39 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id h23so39814731ejj.12;
        Thu, 23 Jun 2022 02:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CqZHI78qt9lumbdFWlSiHgcuuijsjPdVdWVBLjHodmk=;
        b=D38lj8H8nJhIo9qkx/MnZ8wJ1AkNoxYBlHUbMF4zwGLQsc73QZg/eYrvqbxfYv64R1
         CdXo/2hZprxh0OmqHz63eiVupNkiL4+XXEbcnbk80c7Ovxq+15xb8CTuxVygBkRKOUrn
         aAba6DsefOi2kHghmRTRYRas8PHUyxqlGxAqfGnmVwOuUg/iBJE70Y3jnebaneuPwRIQ
         UPutxElfQgar0VmZVnbY6MNeF+wvaMI5vK6qMogMGyzDDlah/j5RuEfM7Fv95zoEX9Vw
         6RhssvO9KLptXYbzKnUbonEPYK82iRuJ5b8ienIAqEk03TyQJR6UUwsJRMLDmclvDWbV
         PFaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CqZHI78qt9lumbdFWlSiHgcuuijsjPdVdWVBLjHodmk=;
        b=1p/R2+muDh1qgmwioYpFL+jDgcdTfC/XMO4J+1wZ8PICg+kIcBNWR+HYnoAyF4CChb
         YyT673YRGysYM8KbclFMlz8rM8mdKIFw8sezvnUi1o38ghhl3FJ8MYzf1TGe4yql4jX0
         uN7NtEDSte1kQjKEOdhCHj5uLiv0gHliA+xnQT2na0nEWvuhNk0UyRMtRNXVhFXq+Jho
         a2ITMocXChcLIlSfWdY5TKzq4ZeNmYuO/FzMqbJ54n9cLIFv3gbUoB5rqO/stM38Tkr9
         NEmuQF0VYVxmyfSSkne9pD1vytPr50b5y7/xrQ3OkYgbh+OoGH2I7hT5BkXWYpW9oPqe
         2QQg==
X-Gm-Message-State: AJIora9Q8Q2AGcCYnreocRN1G1qWTGaHLOVM0Gech1ljUR7FEWdoT/sL
        GVtHgSH3SmFVyxYQ0y6MZDjgcUYAw91e+PKtXbk=
X-Google-Smtp-Source: AGRyM1tcdDytx3LsBRh8vBYNujZdlq64fb8nbca2bDlIhtR7BJ/rWehDXJzpfzQCwCnDrzBHegri9ri9odY7E19Xv+w=
X-Received: by 2002:a17:906:434f:b0:711:eb76:c320 with SMTP id
 z15-20020a170906434f00b00711eb76c320mr7344946ejm.636.1655977598189; Thu, 23
 Jun 2022 02:46:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220622154659.8710-1-LinoSanfilippo@gmx.de> <20220622154659.8710-2-LinoSanfilippo@gmx.de>
 <YrNLtg+BZlwKsBbF@smile.fi.intel.com> <2dda5707-6f13-6d33-863d-a88b89e88a88@gmx.de>
In-Reply-To: <2dda5707-6f13-6d33-863d-a88b89e88a88@gmx.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 23 Jun 2022 11:45:57 +0200
Message-ID: <CAHp75Vd_ix=bJs9k6bYM8S+3f_Pw7Tvs9DhPcZxu1=33T=mQ7A@mail.gmail.com>
Subject: Re: [PATCH 1/8] serial: core: only get RS485 termination gpio if supported
To:     Lino Sanfilippo <LinoSanfilippo@gmx.de>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vladimir Zapolskiy <vz@mleia.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lukas Wunner <lukas@wunner.de>, p.rosenberger@kunbus.com,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 23, 2022 at 4:00 AM Lino Sanfilippo <LinoSanfilippo@gmx.de> wrote:
> On 22.06.22 at 19:04, Andy Shevchenko wrote:
> > On Wed, Jun 22, 2022 at 05:46:52PM +0200, Lino Sanfilippo wrote:
> >> From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> >>
> >> In uart_get_rs485_mode() only try to get a termination GPIO if RS485 bus
> >> termination is supported by the driver.
> >
> > I'm not sure I got the usefulness of this change.
> > We request GPIO line as optional, so if one is defined it in the DT/ACPI, then
> > they probably want to (opportunistically) have it>
> >
> > With your change it's possible to have a DTS where GPIO line defined in a
> > broken way and user won't ever know about it, if they are using platforms
> > without termination support.
>
> This behavior is not introduced with this patch, also in the current code the driver
> wont inform the user if it does not make use erroneous defined termination GPIO.

It does. If a previously stale GPIO resource may have deferred a probe
and hence one may debug why the driver is not working, after this
change one may put a stale GPIO resource into DT/ACPI and have nothing
in the result. Meaning the change relaxes validation which I consider
is not good.

> This patch at least prevents the driver from allocating and holding a GPIO descriptor across
> the drivers lifetime that will never be used.

But it's not your issue, if DTS defines it, so the platform has an
idea about its usage.

> Furthermore it simplifies the code in patch 2 when we want to set the GPIO, since we can
> skip the check whether or not the termination GPIO is supported by the driver.

That's fine.

-- 
With Best Regards,
Andy Shevchenko
