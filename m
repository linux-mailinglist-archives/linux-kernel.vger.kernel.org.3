Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25F925444C0
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 09:25:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239925AbiFIHYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 03:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232296AbiFIHY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 03:24:28 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C30C43555CE
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 00:24:26 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id h8so2918135iof.11
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 00:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RKAu3Su9OCcQgarsv+yiwODwUHrRRpMfJPL/wOkMh7I=;
        b=Ut3mWkgX4WnmnIjzD7Y0ontAlJvatWNtNA7i7kkNUfSsgFwOcbJ7WdYWsRFYTpbKKc
         /0nrI402hf8GfR5EyIbpPypJP3XwyE8nJQKgOwrx8adaHVHSJ3Dz0g9yNPQBAXhJw8m7
         z8v5yfzGM12zNlH/uY+/17+h5ZD54ungo7Ayg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RKAu3Su9OCcQgarsv+yiwODwUHrRRpMfJPL/wOkMh7I=;
        b=LgNcwm3RA1sHInwfHQ8rp8Yyba/4nO59qYDiUeUnL94ornTsEkd+9rSmXyJ/8Jdkyh
         4qZ91M6cSN6G06E7YDE1tRJEdIWxTfm3DHl4HySjRwb37EDIeRj2Xp9srCrSRnsXK/hM
         h/NQHLNDLevmRfBpOXuiLZpcBwIcXOvsUw+qbaJRAYJK8Cl39XHYiNjUl2qe7ENDtWya
         +jeKY12mt95n0gjmpE0uM9e7W/Zx92EhPOphZ3DVrvnaIUaIQX2b0C0cp7zp+ovQOSpH
         0QPYVzvxvOInDrc6s7vw8l/EKQXdnkd95Kvoth+zVipfrWn/asr8S/P8KhpmIqf/UauA
         UuZg==
X-Gm-Message-State: AOAM530KAE0CUFzuI2+eYw5BICLAAw3IWrHFDvm4jCEtD451fWyyY0xM
        PwWgSHPCKwvyYwKpiJhtFo42REL8OxKUJKh9AcoJrg==
X-Google-Smtp-Source: ABdhPJyDqcjLIBpTBS64LqLkQZpEx7rVFU6JZM2QkFg15kaKcyHwaWA2gLwOY0OELDn8r9Tnab2NjzmWEIGw6/3aSpo=
X-Received: by 2002:a6b:8f90:0:b0:669:3ad9:9bd with SMTP id
 r138-20020a6b8f90000000b006693ad909bdmr12248465iod.121.1654759465617; Thu, 09
 Jun 2022 00:24:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220607094752.1029295-1-dario.binacchi@amarulasolutions.com>
 <20220607094752.1029295-12-dario.binacchi@amarulasolutions.com>
 <20220607105225.xw33w32en7fd4vmh@pengutronix.de> <CABGWkvozX51zeQt16bdh+edsjwqST5A11qtfxYjTvP030DnToQ@mail.gmail.com>
 <20220609063813.jf5u6iaghoae5dv3@pengutronix.de>
In-Reply-To: <20220609063813.jf5u6iaghoae5dv3@pengutronix.de>
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
Date:   Thu, 9 Jun 2022 09:24:14 +0200
Message-ID: <CABGWkvrViDyWfU=PUfKq2HXnDjhiZdOMWSBt3xcmxFKxhHKCyw@mail.gmail.com>
Subject: Re: [RFC PATCH 11/13] can: slcan: add ethtool support to reset
 adapter errors
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Amarula patchwork <linux-amarula@amarulasolutions.com>,
        michael@amarulasolutions.com,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Wolfgang Grandegger <wg@grandegger.com>,
        linux-can@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On Thu, Jun 9, 2022 at 8:38 AM Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>
> On 08.06.2022 18:33:08, Dario Binacchi wrote:
> > Hi Marc,
> >
> > On Tue, Jun 7, 2022 at 12:52 PM Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> > >
> > > On 07.06.2022 11:47:50, Dario Binacchi wrote:
> > > > This patch adds a private flag to the slcan driver to switch the
> > > > "err-rst-on-open" setting on and off.
> > > >
> > > > "err-rst-on-open" on  - Reset error states on opening command
> > > >
> > > > "err-rst-on-open" off - Don't reset error states on opening command
> > > >                         (default)
> > > >
> > > > The setting can only be changed if the interface is down:
> > > >
> > > >     ip link set dev can0 down
> > > >     ethtool --set-priv-flags can0 err-rst-on-open {off|on}
> > > >     ip link set dev can0 up
> > > >
> > > > Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> > >
> > > I'm a big fan of bringing the device into a well known good state during
> > > ifup. What would be the reasons/use cases to not reset the device?
> >
> > Because by default either slcand and slcan_attach don't reset the
> > error states, but you must use the `-f' option to do so. So, I
> > followed this use case.
>
> Is this a CAN bus error state, like Bus Off or some controller (i.e. non
> CAN related) error?

The help option of slcan_attach and slcand prints " -f (read status
flags with 'F\\r' to reset error states)\n"
I looked at the sources of the adapter I am using (USBtin, which uses
the mcp2515 controller). The 'F'
command reads the EFLG register (0x2d) without resetting the RX0OVR
and RX1OVR overrun bits.
The error states reset is done by 'f <subcmd>' command, that is not
managed by slcan_attach/slcand.

        switch (subcmd) {
            case 0x0: // Disable status reporting
                mcp2515_write_register(MCP2515_REG_CANINTE, 0x00);
                return CR;
            case 0x1: // Enable status reporting
                mcp2515_write_register(MCP2515_REG_CANINTE, 0x20); //
ERRIE interrupt to INT pin
                return CR;
            case 0x2: // Clear overrun errors
                mcp2515_write_register(MCP2515_REG_EFLG, 0x00);
                return CR;
            case 0x3: // Reinit/reset MCP2515 to clear all errors
                if (state == STATE_CONFIG) {
                    mcp2515_init();
                    return CR;
                }
                break;
        }


Thanks and regards,
Dario

>
> regards,
> Marc
>
> --
> Pengutronix e.K.                 | Marc Kleine-Budde           |
> Embedded Linux                   | https://www.pengutronix.de  |
> Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
> Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |



-- 

Dario Binacchi

Embedded Linux Developer

dario.binacchi@amarulasolutions.com

__________________________________


Amarula Solutions SRL

Via Le Canevare 30, 31100 Treviso, Veneto, IT

T. +39 042 243 5310
info@amarulasolutions.com

www.amarulasolutions.com
