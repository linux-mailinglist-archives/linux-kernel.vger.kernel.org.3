Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 975534DC5BA
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 13:23:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233504AbiCQMYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 08:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232878AbiCQMYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 08:24:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9EAE19F6CC
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 05:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647519773;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yX02XpRMKMKyrhCKJ+Q/Jp6VfNS2QcQlDe8XZZXmMQE=;
        b=T/fwsf7aMqsLDKmY3Cim6NchmxuEdmFLpfBfuEuLx5p44hGgOhmU9dl1r/iDIBSD/XHAD9
        wd4h19iixDQjO7zgAYEhFC1Nusissv72pY8IfoSUCs4iJIhFmKUkz6S7OSosz8P4ozCbfA
        /9U6jEptHWJs9S3oRc1QcH0tppjiixg=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-16-YPsi2uNoNdKh6w4hBWiQpw-1; Thu, 17 Mar 2022 08:22:52 -0400
X-MC-Unique: YPsi2uNoNdKh6w4hBWiQpw-1
Received: by mail-lj1-f197.google.com with SMTP id d16-20020a2e8910000000b00247ff33e987so1995364lji.14
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 05:22:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yX02XpRMKMKyrhCKJ+Q/Jp6VfNS2QcQlDe8XZZXmMQE=;
        b=wgPek6WjJq8Af7OvBe+Y+BLbAt6qkBViRn5IBPmQLzR6nHUiv3lA3b53VaEdXAbkLb
         qGBEQuxKAyENnMSNCoch9sNIavOK5dcuWnS/9vCrDNOnC4hIdMi7tAstDKO4mbjHQow3
         KfbPWXmeNJc1IPzaNw7/x3UPz64jvMP71T19SHO6ll1pwsA/AAznlZfQRCls6W0vgvAI
         YhcHwiCa4DTaVTAz5R1g9445AhpntfPtQ6isK6vZB4p4uwPcJ/HWumyeojFiexfzoH89
         YM7I8pQKHUfOLQQLDcfW4+Q6ps+BTKUKfVm/rYUq1PhgZZbSYSEwo8lwTNwFPSuIfFeR
         gAxg==
X-Gm-Message-State: AOAM531+uuk1uPiLthUwbnohPHJQ+S7B9+lAZQGlO1g/xRpeZwIkhzjS
        QxBFR3vTjKUEliJ+r233xsCM43QbQwFVZoRL0dlnBDR+HKrkPIkSGOFiw4N2jgY4q0FeVMI22Iy
        NY7MhSyUJ9ly4YxdPFnJdgMqO1iWPQ+24+lbKraLF
X-Received: by 2002:ac2:4189:0:b0:448:bc2b:e762 with SMTP id z9-20020ac24189000000b00448bc2be762mr2576753lfh.471.1647519770417;
        Thu, 17 Mar 2022 05:22:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx1rJqT6+g/fKTYm+1dcMdSVQxbzMyICiFHJGIWw3B+6PHmjLZGBFQKLst/7DouRH0T5POM7UoxpgR0fSAeKns=
X-Received: by 2002:ac2:4189:0:b0:448:bc2b:e762 with SMTP id
 z9-20020ac24189000000b00448bc2be762mr2576737lfh.471.1647519770215; Thu, 17
 Mar 2022 05:22:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220316143646.13301-1-wander@redhat.com> <20220316143646.13301-6-wander@redhat.com>
 <4914513f-cdb8-7698-be7f-968d343c5693@kernel.org>
In-Reply-To: <4914513f-cdb8-7698-be7f-968d343c5693@kernel.org>
From:   Wander Costa <wcosta@redhat.com>
Date:   Thu, 17 Mar 2022 09:22:39 -0300
Message-ID: <CAAq0SUmuwc7KZWQOwoQfDrX+os8TVRhdr2pcXiwFNAgGCeRi=g@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] serial/8250: Only use fifo after the port is
 initialized in console_write
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     Wander Lairson Costa <wander@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 17, 2022 at 4:06 AM Jiri Slaby <jirislaby@kernel.org> wrote:
>
> On 16. 03. 22, 15:36, Wander Lairson Costa wrote:
> > The serial driver set the value of uart_8250_port.fcr in the function
> > serial8250_config_port, but only writes the value to the controller
> > register later in the initalization code.
> >
> > That opens a small window in which is not safe to use the fifo for
> > console write.
> >
> > Make sure the port is initialized correctly before reading the FCR
> > cached value.
> >
> > Unfortunately, I lost track of who originally reported the issue. If
> > s/he is reading this, please speak up so I can give you the due credit.
> >
> > Signed-off-by: Wander Lairson Costa <wander@redhat.com>
> > ---
> >   drivers/tty/serial/8250/8250_port.c | 1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> > index 4acf620be241..7e2227161555 100644
> > --- a/drivers/tty/serial/8250/8250_port.c
> > +++ b/drivers/tty/serial/8250/8250_port.c
> > @@ -3416,6 +3416,7 @@ void serial8250_console_write(struct uart_8250_port *up, const char *s,
> >               !(up->capabilities & UART_CAP_MINI) &&
> >               up->tx_loadsz > 1 &&
> >               (up->fcr & UART_FCR_ENABLE_FIFO) &&
> > +             test_bit(TTY_PORT_INITIALIZED, &port->state->port.iflags) &&
>
> Cannot be port->state be NULL sometimes here?
>

IIUC, state is assigned at early port registration in
uart_add_one_port(), so this function wouldn't be called when state is
NULL. But I think it causes no harm to add an extra check. Thanks!

> >               /*
> >                * After we put a data in the FIFO, the controller will send
> >                * it regardless of the CTS state. Therefore, only use fifo
>
>
> --
> js
> suse labs
>

