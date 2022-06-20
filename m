Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B788D55167F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 13:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241209AbiFTLCJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 07:02:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241148AbiFTLCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 07:02:08 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 861C66339
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 04:02:07 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id z7so14552648edm.13
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 04:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WhQKcQWdfh+qi9q/v/2cFx1cfDj+vsZNcur6hEkr1L4=;
        b=ZTSGOyoo4P4+63u2AcFSC2wLm3VOxozGvCOgQPHMzOikglfXqQm8kRmi9oEe+TrT6D
         tVG2mNpE+z9eDC32vjWpPagDUbCraBzQhEs9bvUuBm2CmrxzKLDAcvttoEQ0wxhkSwUA
         C+ieD5sTF3SRcYeaEkNePDspxZsKsC2X9yI9wgzGY38zS6XY3T10wJiUpn3b99x2mQft
         wz9Aelb19XScjKQ006skw9xP5kP+XfSwHRT5puceRNWKHk7kvd1Ho8loLI5i6rMoAoPm
         WO1Y/cAzvBZqj/Us4cE1B7Rb/j6Si21Twu7c9XD5LkbdOAZEqK7PBWa009iAYQcvOHpN
         Q4zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WhQKcQWdfh+qi9q/v/2cFx1cfDj+vsZNcur6hEkr1L4=;
        b=SomeE8y6YAnTnp1TLmhATL37Nfnq37bHElUuNCRq/EPcvB4GlKSemOk2/nYpDXZR2V
         E/V3TED289z6Z9c4vaDDK2qjwTNO694l5H0Chc3y+26NbJM/J+qIAd3LJgTQKpWTAg5U
         fnUks4gGFt2yrJ7OPnx5xYCF5ggEd3TBFwd8Wi2TCuPZ1QRP6t41gPKGpwnSpO9t+XGt
         g2dyXufSYZQtPKQFk/oGdnaqeik+uE0WTYChmizfhgg/y7+cM8qLlRZLX71KKS/2TqUR
         uUFhweB/KrIFZMwKV6oIwwC5mmtUNpenDZMxqdQ1W0y9yWGe7e6pmmeEgsdPwwlnbTf4
         oo1Q==
X-Gm-Message-State: AJIora+AkNNSnEal3dhMtstsfxEJ9giM4KCwv3AISBLAUgzqADu0TXTb
        O7/G6YCsUU4YMYbk/9qGQkxKpDreNG3EgCzUcNM=
X-Google-Smtp-Source: AGRyM1sgmWmoe2JqOoQ8RHXev39j0YYhnWlXRZK4mL4db2WGtm0Ur6rf/pZNYRr4yJv4St+pxXyeGIJLvICniUEp8b4=
X-Received: by 2002:a05:6402:4390:b0:42e:b7e:e9ac with SMTP id
 o16-20020a056402439000b0042e0b7ee9acmr29054633edc.97.1655722926065; Mon, 20
 Jun 2022 04:02:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220619204949.50d9154d@thinkpad> <YrAEUM20n3Rc4aOn@google.com>
 <20220620120234.5a65ac97@thinkpad> <YrBIURn7lxykWghw@google.com> <20220620122904.30c06c4e@thinkpad>
In-Reply-To: <20220620122904.30c06c4e@thinkpad>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 20 Jun 2022 13:01:28 +0200
Message-ID: <CAHp75VdcY1TAksJ10gFPJbagVVfYoe08J9c3Ow_X7dGRrrNyyQ@mail.gmail.com>
Subject: Re: Boot stall regression from "printk for 5.19" merge
To:     =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        John Ogness <john.ogness@linutronix.de>,
        Petr Mladek <pmladek@suse.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

+Cc: Ilpo, a new maintainer for the driver

On Mon, Jun 20, 2022 at 12:46 PM Marek Beh=C3=BAn <kabel@kernel.org> wrote:
>
> On Mon, 20 Jun 2022 19:13:37 +0900
> Sergey Senozhatsky <senozhatsky@chromium.org> wrote:
>
> > On (22/06/20 12:02), Marek Beh=C3=BAn wrote:
> > > > On (22/06/19 20:49), Marek Beh=C3=BAn wrote:
> > > > [..]
> > > > > causes a regression on arm64 (Marvell CN9130-CRB board) where the
> > > > > system boot freezes in most cases (and is unusable until restarte=
d by
> > > > > watchdog), or, in some cases boots, but the console output gets m=
angled
> > > > > for a while (the serial console spits garbage characters).
> > > >
> > > > Can you please try disabling console kthreads and see how the boot
> > > > process goes? Just `return 0` from printk_activate_kthreads() (I th=
ink
> > > > this should do the trick).
> > >
> > > This indeed makes the problem go away...
> >
> > Oh... OK. Didn't expect that :)
> >
> > > > > The garbage example:
> > > > >
> > > > >   ...
> > > > >   [    0.920951] raid6: using neon recovery algorithm
> > > > >   [    0.921228] iommu: Default domain type: Translated
> > > > >   %
> > > > >
> > > > >           gb@k+cFL/[    4.954974] DSA: tree 0 setup
> > > > >   [    4.955286] cfg80211: Loading compiled-in X.509 certificates=
 for regulatory database
> > > >
> > > > This is pretty suspicious. I don't see how console kthreads would
> > > > corrupt the output. I suspect that something else is going on, some
> > > > memory corruption, etc.
> > >
> > > Maybe multiple threads are writing to serial registers, or something.=
..
> >
> > That's possible. Console drivers usually should grab port->lock for
> > write(), but maybe something is missing in the driver you use. What
> > console driver are you using?
>
> compatible =3D "snps,dw-apb-uart", so drivers/tty/serial/8250/8250_dw.c
>
> seems that the function dw8250_serial_out() does not use the spinlock...
>
> Marek



--=20
With Best Regards,
Andy Shevchenko
