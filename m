Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C92345AB526
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 17:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235287AbiIBP25 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 11:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236077AbiIBP22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 11:28:28 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F9EE30559;
        Fri,  2 Sep 2022 08:03:11 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id y17so1606454qvr.5;
        Fri, 02 Sep 2022 08:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=uHtcV+yHCWPSDV3MpZ8WfDgtXH4RMpG2pUyZ60oa9MI=;
        b=NmnxLL+Mf+Aq4TIE+J/Rx+FdYbNJXvMUmisd1jFlKELPxyhwMGj70ajLPKJV/dIEq/
         Xdk7mskW45AKOKeA/qYjoHe0/z6vYODbReVO4dOo+G5lVVin7gXZCTDBuM7+m8C8MPYc
         uKobNowxrxT4bbI9FHkdZtaL/LFxjclXtdbgS6y93lRYPGMBV9Y3+SaWxY4jkKylG/yg
         Pa+apQ70z6imaKlJUnI65GGFccq3cBBhJKFnYp4qldkEvqM90hwl82/hlRYrFeRdHBHR
         2guighArChJ4QhFIlIePFA0QP2am4BzlzXc9jtzezigHgVwrpbfdLGBcGc6mlKCYkZhU
         bxxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=uHtcV+yHCWPSDV3MpZ8WfDgtXH4RMpG2pUyZ60oa9MI=;
        b=HIU1RF74ekmUIB0e5MGlasjPGSxp+xWXQoGhQXbKXCL3ekUN3tSmx0qQzDwpwl6HIZ
         o0W7Y9yug2qJQ0/VwEZ1vU7rP3HRwU8Y2OnGUt9TEOPlqlvng0LMIpGUEh+EOVjzl0ej
         bu4DdRoaiO4t9csQbbAoVM4jDFkfmnsejSPZ7QwONImQJnThWoyOLMn566mWFL3EI3NH
         LNoGNMV/GokL8i4mUTpLeh+m/VlXL/icR9uNLJ/UHL5xE3WH1aN5Ebmki9LU1rfKttB9
         lo6oYERczbBCLfF3w7rWEb0AxhnYRXUY1NNCuUSHKoX4Dp8Lro1UufkJgfoPmG0mj9wo
         1s3A==
X-Gm-Message-State: ACgBeo1CnjY8awblZ2YGdzKEUpeMpTDGG9QUQQON7GaAZ/6Pdq34NK2x
        b1dSpk8ay/WasdGUSPdtl/tbaAam1Raj51EcOxQ=
X-Google-Smtp-Source: AA6agR4Ga9erVLbjOKv6kfUP9niDmSO0S/BawjuROQ9tShjiebnSl7urmBNmdBIDIbe2P/M+ymUVdlmjJcpIlHesmXw=
X-Received: by 2002:a05:6214:c8f:b0:499:21eb:ba3b with SMTP id
 r15-20020a0562140c8f00b0049921ebba3bmr10782648qvr.97.1662130990488; Fri, 02
 Sep 2022 08:03:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220830180054.1998296-1-kumaravel.thiagarajan@microchip.com>
 <20220830180054.1998296-2-kumaravel.thiagarajan@microchip.com>
 <CAHp75VfraADCTmZATWTSsYtC5uk5bc=WDVVm0jtUVO90xdFd9g@mail.gmail.com>
 <BN8PR11MB3668BAC07D493EE02AEAEB14E97B9@BN8PR11MB3668.namprd11.prod.outlook.com>
 <63f48d1-f716-5040-c8d1-486087bd1c5e@linux.intel.com> <BN8PR11MB3668FA6A2247710ED7DEF16EE97A9@BN8PR11MB3668.namprd11.prod.outlook.com>
In-Reply-To: <BN8PR11MB3668FA6A2247710ED7DEF16EE97A9@BN8PR11MB3668.namprd11.prod.outlook.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 2 Sep 2022 18:02:34 +0300
Message-ID: <CAHp75VfUq-JkfjD1YOj_+ST-eK=aW=8LoHOUW4zqpeA_QUZbyw@mail.gmail.com>
Subject: Re: [PATCH v1 tty-next 1/2] 8250: microchip: pci1xxxx: Add driver for
 the quad-uart function in the multi-function endpoint of pci1xxxx device.
To:     Kumaravel Thiagarajan - I21417 
        <Kumaravel.Thiagarajan@microchip.com>
Cc:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Johan Hovold <johan@kernel.org>,
        Wander Lairson Costa <wander@redhat.com>,
        Eric Tremblay <etremblay@distech-controls.com>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Jeremy Kerr <jk@ozlabs.org>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Lukas Wunner <lukas@wunner.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>
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

On Fri, Sep 2, 2022 at 2:57 PM <Kumaravel.Thiagarajan@microchip.com> wrote:
> > -----Original Message-----
> > From: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> > Sent: Thursday, September 1, 2022 7:12 PM
> > On Thu, 1 Sep 2022, Kumaravel.Thiagarajan@microchip.com wrote:

...

> > > > > +       const unsigned int standard_baud_list[] =3D {50, 75, 110,=
 134, 150,
> > 300,
> > > > > +                                               600, 1200, 1800, =
2000, 2400, 3600,
> > > > > +                                               4800, 7200, 9600,=
 19200, 38400, 57600,
> > > > > +                                               115200, 125000, 1=
36400, 150000, 166700,
> > > > > +                                               187500, 214300, 2=
50000, 300000, 375000,
> > > > > +                                               500000, 750000,
> > > > > + 1000000, 1500000};
> > > >
> > > > Why?!
> > >
> > > The standard baud rates are handled within serial8250_do_set_termios
> > > which is invoked from within mchp_pci1xxxx_set_termios in first place=
.
> > > Hence if it matches with any of the standard baudrates, it can return
> > > immediately.
> >
> > Care to explain why the baudrates in your table don't match those in
> > tty_baudrate.c? ...It makes no sense to me that you call these "standar=
d
> > baud rates".
> The baudrates in my table are from our legacy UART IP and these baudrates=
 can be
> generated by the hardware by updating UART_DLL & UART_DLM alone as done b=
y the
> serial8250_do_set_termios.
> I noticed that some of the baud rates in tty_baudrate.c arenot listed in =
this table
> but will still be handled by the mchp_pci1xxxx_set_termios.
> I can rename standard_baud_list to simply baud_list. Please let me know.

No, the point is avoid repeating what standard APIs already do. Just
make sure you call it properly and provide _get/_set_divisor()
callbacks. Note, your driver can cope with BOTHER and there all
non-standard baud rates go.

--=20
With Best Regards,
Andy Shevchenko
