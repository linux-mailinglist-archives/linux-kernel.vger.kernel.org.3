Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8F914DC5C1
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 13:24:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233532AbiCQMZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 08:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233525AbiCQMZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 08:25:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BFBCB12A8F4
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 05:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647519827;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7jeq6srkn3vKPjwF7bOhXJrvBVH81gTqAX2FFARSZuA=;
        b=jNKW0nwMRFtuaWfkyvk8gkGMShGg+yumKpN8mV05W5bcM+OCA73dC87a+y0KxLdNV3K3kZ
        AChh/CjDVpfdwglWPcwi/xc7AsdLzzkzfrRudKKrdNWGOC1I21GbUOJQJ77FZq04EzIEkT
        LfHlcjRLQXOyHzdglKxHlx+qfYtXrrs=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-59-yNstZpkSOcCUAQyx_dvPfQ-1; Thu, 17 Mar 2022 08:23:46 -0400
X-MC-Unique: yNstZpkSOcCUAQyx_dvPfQ-1
Received: by mail-lj1-f199.google.com with SMTP id z20-20020a2eb534000000b002495db7fe98so895583ljm.18
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 05:23:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7jeq6srkn3vKPjwF7bOhXJrvBVH81gTqAX2FFARSZuA=;
        b=fJT+4TboagNbUvXnmD10rgeKjCyUbfDr/H37EIR278Ay9uBeF+50XDFTEMekJF8DZX
         WYskuiIH/ZsTQ5l8vIevwut43s7zsS7WoCQZpSkfM+p/IUf6/takOOzw3c4rIF34ha6V
         s6PpaWAfEFYshZDbtrf39Kw8mKfSwWr/XcrVCZWvPrJy20nluKisnMw+597FVuDpnxZ6
         HdlkEK7Fk21Q3LWNjchD7ZmvrzZKSMr/xZxFyE49JOKFKooaJTNqGZ/t5r8SHUvOnJJn
         ftrxaV6lV6tALiOcr37fwy6u54WBWkyaBDrPEzgSKLFoVMkxqMWfeIHL4lBteOwXhoTJ
         v2eQ==
X-Gm-Message-State: AOAM533KQYMy2A6l4VPfZMHp46uvbB7cJtXPqngZm4mXfjcpKw3lqjJL
        2CZXAgAWd3alKSW6RB9iO74PHhGrEsmCX1Uc5qklNghfKJEsO1ppOx/dYnMLexHE6BJ7+YMycUP
        Ga7detkOJfmqL1/Bbyn0OxoIgMWmBUEHeB2Cav6Ry
X-Received: by 2002:a2e:a0c3:0:b0:247:eba1:366b with SMTP id f3-20020a2ea0c3000000b00247eba1366bmr2704386ljm.190.1647519823612;
        Thu, 17 Mar 2022 05:23:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzo3UqII19WI/p0VdLBXfqVvN1WLU0NnXb91JTrd0VJzRLZZMnD/ko+J4pnliY77wNGREXUQCtRUbMO1vDsylc=
X-Received: by 2002:a2e:a0c3:0:b0:247:eba1:366b with SMTP id
 f3-20020a2ea0c3000000b00247eba1366bmr2704371ljm.190.1647519823413; Thu, 17
 Mar 2022 05:23:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220316143646.13301-1-wander@redhat.com> <20220316143646.13301-6-wander@redhat.com>
 <2f3d386-b82a-9ae1-eaba-f2123b1346f8@linux.intel.com>
In-Reply-To: <2f3d386-b82a-9ae1-eaba-f2123b1346f8@linux.intel.com>
From:   Wander Costa <wcosta@redhat.com>
Date:   Thu, 17 Mar 2022 09:23:32 -0300
Message-ID: <CAAq0SUndENR-Of76g32sAOOD80=nnhmwOfeKzUq7XCboLyFsNQ@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] serial/8250: Only use fifo after the port is
 initialized in console_write
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

On Thu, Mar 17, 2022 at 5:44 AM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> On Wed, 16 Mar 2022, Wander Lairson Costa wrote:
>
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
> >  drivers/tty/serial/8250/8250_port.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8=
250/8250_port.c
> > index 4acf620be241..7e2227161555 100644
> > --- a/drivers/tty/serial/8250/8250_port.c
> > +++ b/drivers/tty/serial/8250/8250_port.c
> > @@ -3416,6 +3416,7 @@ void serial8250_console_write(struct uart_8250_po=
rt *up, const char *s,
> >               !(up->capabilities & UART_CAP_MINI) &&
> >               up->tx_loadsz > 1 &&
> >               (up->fcr & UART_FCR_ENABLE_FIFO) &&
> > +             test_bit(TTY_PORT_INITIALIZED, &port->state->port.iflags)=
 &&
> >               /*
> >                * After we put a data in the fifo, the controller will s=
end
> >                * it regardless of the CTS state. Therefore, only use fi=
fo
>
> So it looks like 2-5 just contain your development history and should all
> be merged to 1/5 (perhaps with Co-developed-by: tags where appropriate).
>
> And please don't just merge them "silently" there w/o describing in the
> message _why_ you ended up doing the things the way you did in the end.
> The messages you've written for patches 2-5 will serve you as great sourc=
e
> material (with small mods, obviously).
>

Ok, I will merge them in v5.

>
> --
>  i.
>

