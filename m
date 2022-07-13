Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31BC35730BE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 10:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234952AbiGMIRU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 04:17:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235208AbiGMIQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 04:16:54 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5130BD38A
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 01:13:59 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id g16-20020a17090a7d1000b001ea9f820449so2368895pjl.5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 01:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uEs3G00VHY8EwtdUIttGPsPa/hYyZ0phbIsIaqIPwZ4=;
        b=NpZL51UbDNgo7qFQ5Xf5qaSGFTPBk4IEKOlXnzm4eKfW7EJvCzbAMawefAQJXlUDSc
         r9wE1Xrf8ejaEA1KTERugXUavnl4JM1no8mUtjoh+JiBRnRVXD8bCnEnF/ZndYe6dcrr
         TLH/biJ80ZpDu1E2+q2tmLFl5uUaOjfcgovutQwp8Ta9cl48hTPCh+sMMTvAfQjh6OV4
         Qu3/GK7+gfihiFE9dvKiCwrTHA6Ihj9idKKFnW0Wd/4RgNmvrGskMqrSd0FkY/ZhOFES
         GcaVUYZrS+1pDprBcaghqbSbY34aa/5hEgPrOH9XdWtKGr47DfvOTxs8wUqJ8YVkB0TM
         lJVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uEs3G00VHY8EwtdUIttGPsPa/hYyZ0phbIsIaqIPwZ4=;
        b=hBbhYnqTV27MLnnxZGTZsaSWz2WX7fVDKgx8QbWUZLzK4LfmjadG+3haT6wTUqmYiy
         WFZSHs9GDsV1EO2yych5xPi1sB0D8v4Q0+ISunRfYhUYr0lffLrBkjosQOIfn0Vp82NL
         bvAr8XSRr+3a8+46clCOpBtbOWcQguDbm6wmd+XM6LLseoyvp11GEkRbM0AoXzXx6Fcx
         5m9YBrTSyrQTKWeQnz1GzWO3wFqlU7qmwaUXthXT0wc+Zpm+mMYkcE4fhxgwEtgBp9u3
         MKIZxvB9yG7E7/UXLL7CWOdvDTsthtyeCjRYrUHVisTcDwlq3cZVg1+YURKCENjXt2+E
         gP6Q==
X-Gm-Message-State: AJIora8JbbfL49BC/HdAWjcX/usRRRZzc0Vous8wXFzdgSqOIR/v+P9H
        rHQANpsmOJJdTWOyPbuVlFkvL73nbrO0/uY+WQq4TA==
X-Google-Smtp-Source: AGRyM1tcPH/6ecESZNaup02lqJ98voKrU4plooytOmMe+IbjluLlfKDuzFMyhzAbNgin18/kBnUNG8klG76h1Eg7mVQ=
X-Received: by 2002:a17:90b:693:b0:1ef:4d94:412d with SMTP id
 m19-20020a17090b069300b001ef4d94412dmr8802447pjz.27.1657700036609; Wed, 13
 Jul 2022 01:13:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220712131523.1874428-1-vamshigajjela@google.com> <CAHp75VecnJSv9P4ZXf5g4Yi7rYySRN=73KwZ_OBFUyFtaSq00w@mail.gmail.com>
In-Reply-To: <CAHp75VecnJSv9P4ZXf5g4Yi7rYySRN=73KwZ_OBFUyFtaSq00w@mail.gmail.com>
From:   VAMSHI GAJJELA <vamshigajjela@google.com>
Date:   Wed, 13 Jul 2022 13:43:44 +0530
Message-ID: <CAMTSyjrhSSYVEBq=bdu9wBCcuPdrkmxS4jszOgOQBBvSKyaa_g@mail.gmail.com>
Subject: Re: [PATCH] serial: 8250_dw: Avoid pslverr on reading empty receiver fifo
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Johan Hovold <johan@kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Manu Gautam <manugautam@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2022 at 6:56 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Tue, Jul 12, 2022 at 3:16 PM Vamshi Gajjela <vamshigajjela@google.com> wrote:
> >
> > From: VAMSHI GAJJELA <vamshigajjela@google.com>
> >
> > With PSLVERR_RESP_EN parameter set to 1, device generates an error
>
> the device
ack
>
> > response when an attempt to read empty RBR with FIFO enabled.
>
> an empty
ack
>
> > This happens when LCR writes are ignored when UART is busy.
> > dw8250_check_lcr() in retries to updateLCR, invokes dw8250_force_idle()
> > to clear and reset fifo and eventually reads UART_RX causing pslverr.
>
> fifo --> FIFO
> pslverr --> the error
ack
>
> > Avoid this by not reading RBR/UART_RX when no data is available.
>
> ...
>
> > +       unsigned int lsr;
> >         struct uart_8250_port *up = up_to_u8250p(p);
>
> Can we keep it ordered according to the reversed xmas tree?
agree.
>
> ...
>
> > +       /*
> > +        * With PSLVERR_RESP_EN parameter set to 1, device generates pslverr
>
> the device
> pslverr --> an
ack.
>
> > +        * error response when an attempt to read empty RBR with FIFO enabled
>
> Missed period.
ack
>
> > +        */
> > +       lsr = p->serial_in(p, UART_LSR);
>
> The only caller of this function already has the lsr value, why you
> can't (re)use it?
lsr is not read before, caller function (dw8250_check_lcr) reads lcr.
>
> > +       if ((up->fcr & UART_FCR_ENABLE_FIFO) && !(lsr & UART_LSR_DR))
> > +               return;
>
> --
> With Best Regards,
> Andy Shevchenko
