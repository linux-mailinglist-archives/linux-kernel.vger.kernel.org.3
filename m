Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53F784CEE17
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Mar 2022 23:08:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234243AbiCFWJR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 17:09:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbiCFWJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 17:09:15 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9831822B0E;
        Sun,  6 Mar 2022 14:08:22 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id kt27so28266849ejb.0;
        Sun, 06 Mar 2022 14:08:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=B+OdQEqw3gVimMqDvTK4mctUlemCPrMedCr5iIpp+zM=;
        b=Qu6f92sIsjPSPety4vCcVtCiuPb634KVCRKpGyaQY8869tDnAjA6x1Gv5st7j1xZHh
         lT6QhOZr7BnCay8Rzh2OkruAFEWMhgtJGNl/aQt2SCZV28gk9OGhAAN5mCcEYZoQjUNj
         w+1Z7KyrOTbBvXrrzCcFOhOIbuRE4hOI0LBmY/C2+sv6Wo5KOXPtRMlRDWkUcZk1+U8m
         jhnOGCxAsDRwvQMhqPczsq+hnTlhjVLbYGSX35JXPCJFVHiaTBaMq1vbSYdZmLZw7cdH
         9x/79BDlPAydtMRqvJ1qYORTYmbPX5bMHDQ/CeenyylujzvWyhRnT7BKyq6LVHJFqOB1
         F3Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=B+OdQEqw3gVimMqDvTK4mctUlemCPrMedCr5iIpp+zM=;
        b=P/ycxzVogmVZMLVBbO4mwM4VNxQlGM76+9VSWNMuucSh4poRk72lcNT95lh+HQWv+x
         SSLizoQeLpSkqTlSgsE/fX7PZIKsG16wbTo/TBFw/pJ6sF+GeqqfNtqEAXbSOw0WmG3S
         Ph+xRS5vACGfvqctnRU2CvMdAHtfvGdyHpHJlC65KmEdSb/NNWSSSqjL6lBms2Aip5uV
         SQFqr7zs9ffet+54JH18tTyYFSAkCBpblMjinQV5qlrjnnBCtYfHjH+wepFOpbKBwD4L
         6/pVMV5ywOLtRM+zV3a4UWneg5TCZwjtFcNTItoKbvegVD3cPMWlByCguDWKijDpn0Cr
         lgCw==
X-Gm-Message-State: AOAM531n32c4mG6vIbLk2zNFLhbXALzvxnCpW/WrF79Pj4fQgKtX8DMs
        NabD+cRiAfRJibPsgkMrYMXR9DdqULh1KfJG2rnC0514LEA=
X-Google-Smtp-Source: ABdhPJxtJPeQPYTwcWknxaOsrytx6gzAfSrsO8vnTvrMWRTFPtLU10WxSJ3igPjaAPfMi3Fv9tDnRcnGtHQF/bM4X4U=
X-Received: by 2002:a17:907:6e01:b0:6d0:562c:e389 with SMTP id
 sd1-20020a1709076e0100b006d0562ce389mr7073620ejc.497.1646604501024; Sun, 06
 Mar 2022 14:08:21 -0800 (PST)
MIME-Version: 1.0
References: <20220302095606.14818-1-ilpo.jarvinen@linux.intel.com>
 <20220302095606.14818-2-ilpo.jarvinen@linux.intel.com> <20220306184857.GA19394@wunner.de>
In-Reply-To: <20220306184857.GA19394@wunner.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 7 Mar 2022 00:07:44 +0200
Message-ID: <CAHp75Vdxa_p866t5B7zJ8nHS-v+tu3vLiW0=vaBznnyCGyve_g@mail.gmail.com>
Subject: Re: [PATCH 1/7] serial: 8250_dwlib: RS485 HW half duplex support
To:     Lukas Wunner <lukas@wunner.de>
Cc:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Johan Hovold <johan@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Raymond Tan <raymond.tan@intel.com>,
        Heiko Stuebner <heiko@sntech.de>
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

On Mon, Mar 7, 2022 at 12:00 AM Lukas Wunner <lukas@wunner.de> wrote:
> On Wed, Mar 02, 2022 at 11:56:00AM +0200, Ilpo J=C3=A4rvinen wrote:

...

> Does the DesignWare UART use dedicated DE and RE pins instead of
> the RTS pin?  That would be quite unusual.

They are muxed with other UART pins on SoC level, but I don't remember
by heart which ones. According to the Synopsys datasheet they are
separate signals. It might be that I'm missing something, since the
last time I looked was last year.

...

> > +     d->hw_rs485_support =3D device_property_read_bool(p->dev, "snps,r=
s485-interface-en");
> > +     if (d->hw_rs485_support)
> > +             p->rs485_config =3D dw8250_rs485_config;
> > +
>
> You wrote in the commit message that rs485 support is present from
> version 4.0 onward.  Can't we just check the IP version and enable
> rs485 support for >=3D 4.0?  That would seem more appropriate instead
> of introducing yet another new property.

AFAIU this is dependent on the IP syntheses. I.o.w. version 4.0+ is a
prerequisite, but doesn't automatically mean that there is a support.
Unfortunately there is no way to tell this clearly in the IP
configuration register.

--=20
With Best Regards,
Andy Shevchenko
