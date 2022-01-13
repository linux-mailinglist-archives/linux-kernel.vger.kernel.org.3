Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C065148D626
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 11:56:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233791AbiAMK4h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 05:56:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbiAMK4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 05:56:35 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99252C06173F;
        Thu, 13 Jan 2022 02:56:35 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id u15so9143176ple.2;
        Thu, 13 Jan 2022 02:56:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=oJN4J8iu8PnOEhGvfSZZbeVmWmfK/UHswq06bUpnhww=;
        b=FCOLTh9HE7z4yI4p4kO4gjamu+UemBWoBBBlEfR75KI/z+1LGYSGemNx50G0/92gad
         yQgrFSbW5AKtRXtcm6HSebEpz+xon99EKrAIMM6VoH7cfuZt4K0GdRi0f47J2J8Esp/a
         xCjAoGOJLIKQEbLFWLVpmKcurdjZLpZt5JuN3tVeo6PJVnrSz7WJNBB++UUtBLIfS7k/
         vIycNVyWkW60I5KvE0u3M7d7clLiUk1ARAsfGTgLeSJgyxhTBoS0yFL06X3ioFV4KI2S
         s6xB8ThZ5zN8r9eNiMbQ40oNU+XL5eEvLodxI6FvGwvo+dfN8Vg/soJRwRUw/t8D74Gx
         1Y8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=oJN4J8iu8PnOEhGvfSZZbeVmWmfK/UHswq06bUpnhww=;
        b=sie/UPGrbKiSPbDYGKrt3R6UCE2N0wHY0uxrgn7VQaVZGbk5CuwpfZLShpJBp2ndoB
         t5mgTplgTwALPnPalOBMAA/vfZJbmwJGNapBkiNgaaLlgits/NUuLRJ6AodiPIh4enaa
         GM8+viZ7dmOn3uEf6p6YP1JmhpWi3cE/a5m/Xhs2MwGQMxdCQf2rajBrrJm9moEuQPLF
         oxlxD4IezfpDas7NKaNZYWOJlQyhBm7spHQ8gmOaLDj/YoKMKTGYyS4YzfXwLutLvbtw
         CIsaxWoeKABkb2o48iA/iJyZdTBKynGWn4IoHiuUYJsc/v6cu0grQhMLbu03ZBhiXzuF
         5W9A==
X-Gm-Message-State: AOAM5319UoaJUg4e8zyiI5i3suYRhjD8Ga8hcJQuIaQxJdtHwjJelTeX
        0dzrgW1qI+hGt0coyp2jRN9B9ADR5+KQTzMvILQ=
X-Google-Smtp-Source: ABdhPJwLsBJSMyCZLung9morGRLOKMNW3NWd77lPXM9jNrofI1B2dzn/JSHbib0QgGsOYg/UK/Ya2i30o6BWxvwI0bE=
X-Received: by 2002:a63:7f55:: with SMTP id p21mr3402265pgn.338.1642071395080;
 Thu, 13 Jan 2022 02:56:35 -0800 (PST)
MIME-Version: 1.0
References: <1641979444-11661-1-git-send-email-hammerh0314@gmail.com>
 <1641979444-11661-3-git-send-email-hammerh0314@gmail.com> <fcd43c65-6201-9e44-061c-f04e39cef726@kernel.org>
 <CAOX-t54oA9V94d3901w2xKSagSzmXc9r=TDTtbgaSLfL1DxNbw@mail.gmail.com> <d6d3aa07-7bf1-2b6d-356f-ae13c7b9d6cd@kernel.org>
In-Reply-To: <d6d3aa07-7bf1-2b6d-356f-ae13c7b9d6cd@kernel.org>
From:   hammer hsieh <hammerh0314@gmail.com>
Date:   Thu, 13 Jan 2022 18:56:44 +0800
Message-ID: <CAOX-t57KZb0hNDuhPsabkmkf_qOOLqyH3yuvkHP6UNwhLodWDg@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] serial:sunplus-uart:Add Sunplus SoC UART Driver
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>, robh+dt@kernel.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, p.zabel@pengutronix.de,
        wells.lu@sunplus.com, "hammer.hsieh" <hammer.hsieh@sunplus.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jiri Slaby <jirislaby@kernel.org> =E6=96=BC 2022=E5=B9=B41=E6=9C=8813=E6=97=
=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=885:08=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On 13. 01. 22, 9:54, hammer hsieh wrote:
> >>> +static void sunplus_shutdown(struct uart_port *port)
> >>> +{
> >>> +     unsigned long flags;
> >>> +
> >>> +     spin_lock_irqsave(&port->lock, flags);
> >>> +     writel(0, port->membase + SUP_UART_ISC);
> >>> +     spin_unlock_irqrestore(&port->lock, flags);
> >>
> >> I asked last time:
> >> * What bus is this -- posting?
> >>
> >> You replied:
> >> * Here just clear interrupt.
> >> * Not really understand your comment?
> >>
> >> So I am asking again:
> >> What bus is this? Isn't a posted write a problem here? I mean, shouldn=
't
> >> you read from the register so that the write hits the device? That
> >> depends on the bus this sits on, so just asking.
> >>
> >
> > Each UART has its own ISC register.
> > Ex.
> > dev/ttySUP0 base_adr =3D 0x9C00-0000 , isc_addr =3D 0x9C00-001C
> > dev/ttySUP1 base_adr =3D 0x9C00-0080 , isc_addr =3D 0x9C00-009C
> > dev/ttySUP2 base_adr =3D 0x9C00-0100 , isc_addr =3D 0x9C00-011C
> > dev/ttySUP3 base_adr =3D 0x9C00-0180 , isc_addr =3D 0x9C00-019C
> > dev/ttySUP4 base_adr =3D 0x9C00-0200 , isc_addr =3D 0x9C00-021C
> > So sunplus_shutdown() just simply turn off its own device isc only.
> > That's why I didn't read register value, just write 0 for it.
>
> Could you explain me what posted write is and how does it not matter in
> this case?
>

Each UART ISC register contains

Bit7 MSM(Modem Status) INT enable / disable (Access type RW) not use
now (0: default)
Bit6 LSM(Line Status) INT  enable / disable  (Access type RW) not use
now(0: default)
Bit5 RXM INT enable / disable  (Access type RW) set this
Bit4 TXM INT enable / disable  (Access type RW) set this

Bit3 MS(Modem Status) INT flag (Access type Read only) not use now (0: defa=
ult)
Bit2 LS(Line Status) INT flag (Access type Read only) not use now (0: defau=
lt)
Bit1 RX INT flag (Access type Read only) read this
Bit0 TX INT flag (Access type Read only) read this

sunplus_shutdown()
main purpose is to turn off TX INT(bit4) and RX INT(bit5)
bit7 and bit6 not used, should be 0.
bit3 ~ bit0 read only, no effect while writing 0 to them.

> thanks,
> --
> js
> suse labs
