Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C5924DC576
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 13:04:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233399AbiCQMFg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 08:05:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233333AbiCQMFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 08:05:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0ADDD19315E
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 05:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647518657;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FdTSBCWZfRB7gl4NcFBlztb/OOGHep3RIbzmatr6VFQ=;
        b=doYa7O7SpvTlH0Wc3RixiVHVUzdCBa6XZU2S79U6dO8d989sNw1XMgkeizivEjoIyTQrWj
        Hed6gl91pKO7Jv6Kmu71hTUKqaaTy8qO69S9mrs3IxoUhduJw1yPGQW3LwJnECXuo5ebU4
        B9j1cAbqii6JCc1WlmPsWMEJS5yp4cQ=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-351-2LY7Ws31N6SK2Wq2T1FOJA-1; Thu, 17 Mar 2022 08:04:16 -0400
X-MC-Unique: 2LY7Ws31N6SK2Wq2T1FOJA-1
Received: by mail-lf1-f72.google.com with SMTP id y5-20020ac255a5000000b00448bc398d34so1363701lfg.15
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 05:04:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FdTSBCWZfRB7gl4NcFBlztb/OOGHep3RIbzmatr6VFQ=;
        b=oyd2ra6/jRnI+bhHwSbiaP14NGSCVTHD/t87dHgGbEGW78ViLxgl44pMoJXaxWwjv8
         YoEcB6pOGwxprlFQxVIOENA7X2ItTkPVaFmBp9WM/2RIlDqkEbZaMt991c4fqpz+ZWZ+
         TKnNfYegI5Bm6GVoJ8VrbHT0KV7b4YTqHLPn98iH6iqLhXuK2wk+rWrETSV7onEDashK
         MEs2x1BbHDOnu3E7Yc/sWO1vSELiDdy3TKM7YWW5InkbG165LthvXAxDl7tSSETqehWf
         9VmJzJSoxSK3mG6KPg6AW2fBEC9S4PLUBvKuTQn3d7n+UCyVTPioKGBcmOCnCsVR37X4
         aIjA==
X-Gm-Message-State: AOAM531zZIV37l68bNiuCKh6l0DyWT8m1kZNlMxEihcVw9MOuWfPrtvV
        1hlPUHIat9ebbTDfFuujBrMEwasCp0KAAi2TGOZRnOP7cIzjSVKSUsKzk9rqUaHXk2O8LfLtEld
        nX5kbOyvZzyWDUpsV1tG3f/R3uj8V34ltbluLQiwb
X-Received: by 2002:a05:6512:44f:b0:449:b929:a301 with SMTP id y15-20020a056512044f00b00449b929a301mr2699657lfk.180.1647518649511;
        Thu, 17 Mar 2022 05:04:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwn2/gammYMEhSTgjHb3uCUKDlyraLf9N+wqpMA6XqrZ9+XtOOCoVlma0IkJ0zgfZJMfBknwy+BxtFxUgrIIYI=
X-Received: by 2002:a05:6512:44f:b0:449:b929:a301 with SMTP id
 y15-20020a056512044f00b00449b929a301mr2699643lfk.180.1647518649298; Thu, 17
 Mar 2022 05:04:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220316143646.13301-1-wander@redhat.com> <20220316143646.13301-3-wander@redhat.com>
 <ce8be768-6210-c3b-2131-de302a7757d@linux.intel.com>
In-Reply-To: <ce8be768-6210-c3b-2131-de302a7757d@linux.intel.com>
From:   Wander Costa <wcosta@redhat.com>
Date:   Thu, 17 Mar 2022 09:03:55 -0300
Message-ID: <CAAq0SU==UJpdTN2YNm_2KNGQmSKMOU97fFb-wTV2VM=vO5pPCw@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] serial/8250: Use the cache value of the FCR register
To:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Wander Lairson Costa <wander@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Serge Semin <fancer.lancer@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        =?UTF-8?Q?Andr=C3=A9_Goddard_Rosa?= <andre.goddard@gmail.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        David Laight <David.Laight@aculab.com>,
        Jon Hunter <jonathanh@nvidia.com>, phil@raspberrypi.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 17, 2022 at 5:31 AM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> On Wed, 16 Mar 2022, Wander Lairson Costa wrote:
>
> > commit 5021d709b31b ("tty: serial: Use fifo in 8250 console driver")
> > erroneous tries to read the FCR register content, but this register is
> > write-only.
> >
> > This patch fixes that by reading the content from the port struct fcr
> > field.
> >
> > Thanks to Jon Hunter and Jiri Slaby.
> >
> > Suggested-by: Jiri Slaby <jirislaby@kernel.org>
> > Reported-by: Jon Hunter <jonathanh@nvidia.com>
> > Signed-off-by: Wander Lairson Costa <wander@redhat.com>
> > ---
> >  drivers/tty/serial/8250/8250_port.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8=
250/8250_port.c
> > index 2abb3de11a48..9f3fa9fe2a4e 100644
> > --- a/drivers/tty/serial/8250/8250_port.c
> > +++ b/drivers/tty/serial/8250/8250_port.c
> > @@ -3410,7 +3410,7 @@ void serial8250_console_write(struct uart_8250_po=
rt *up, const char *s,
> >
> >       use_fifo =3D (up->capabilities & UART_CAP_FIFO) &&
> >               port->fifosize > 1 &&
> > -             (serial_port_in(port, UART_FCR) & UART_FCR_ENABLE_FIFO) &=
&
> > +             (up->fcr & UART_FCR_ENABLE_FIFO) &&
>
> Didn't you just add this line in 1/5? Please merge this kind of fixes tha=
t
> are due to development history of a change to the main patch itself.
>

The reason is that 1/5 has been applied in 5.17 and then reverted, so
I thought it would make it easier for reviewers if I sent the new
fixes in different commits. If that's not the case, I can send a
squashed version with the changelog described in 0/5.

