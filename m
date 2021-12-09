Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8883A46E02A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 02:19:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239522AbhLIBXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 20:23:16 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:51852
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232216AbhLIBXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 20:23:15 -0500
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com [209.85.161.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 478DD3F1F0
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 01:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1639012778;
        bh=QZSMwSAPhjjXEhfCQjdPv8fogjVplogvbmK+fx9KWxM=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=S18liWlYCivXvWUoeCJ7w/NKBon6TI+N2WtiOc5pyLOfh3BxjIUd+7I7Sgtg8RujV
         4Ny0zbxmaMoOxngFA0BDfiaq2kkSzDYbuqGQ9A+ef43Ll1k+WhbNFQdnuNRcROeK35
         6Tiy2yVLT0ZWRVlFw13TEuL9fnAaEhh+GtwPziX5hlnPXJpR8r82HHPIm9+iTpYYCj
         /wRAYBl5bkW7M7xQ/sbMO5PmFnya7xQ5AYG/f+2vHW65h+X4MhMQm36ogTvIfQYHRZ
         NgWngVWu+Y5Vlns4VKn4Zw6Z1GGb1k1oqL3G4UekOwheKn1WeC6kThfGPkNfClUbJe
         Fq2XYob106XxA==
Received: by mail-oo1-f71.google.com with SMTP id z20-20020a4a8e54000000b002c632ba3a12so2403279ook.7
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 17:19:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QZSMwSAPhjjXEhfCQjdPv8fogjVplogvbmK+fx9KWxM=;
        b=detf4Ak5fnUhugAQWUr43UOzO8o1HQaKjsKMmzyOG6L9wdUbP2HIsrpP6siNm8LHQ3
         gQvd+9TJwPMN+rKSnkE/SAFrxQu9+K6BzkaMZtbOU/mxQvEdHsJ6wCSqCQQMIgF9jyty
         zVEk6y1gDJ1jeaCCd36itqbDBzUgP5MqXnkM+qXB0x6pbsmtFv/L87oQdQALjUVpH4QF
         OLZkr0fq9D+XbjgOg5fuStUHW448wPvou1pAHYOxlnwTgiQ5PD1LApac0MuCmkOAYarR
         UwBEZQRyob8ixK+Nsb7Nhbf0a6+qjJP2zbWdsl8kQgwZbs2HZzcFOQfs1xVExpbmBbLX
         re7A==
X-Gm-Message-State: AOAM531NZ9ctismcuJMO2rOQk18sMFEKxfaJ3BDJNLRchN7R0HLBUjpF
        6pI7mntpsbo1z/ZirvDzHDePlWIYEqgxbcV/b9SehCRwn8gZlOJ2sPGzTtcLplddiRvmtHY84cl
        7cdteaIfVzWEKV0zU67G27OuRttEV3CjwVdMA36s0+HCBbhMvCPAN5gc3xg==
X-Received: by 2002:a05:6808:199c:: with SMTP id bj28mr3239746oib.98.1639012777056;
        Wed, 08 Dec 2021 17:19:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwjyoTObJIlskSn5nQLHUsdyJgtUsxygV//ZdRzGUmOQU6Ypv/1vHJeourZBR+oVvk+6T6BpRs/5d+qziYHw2U=
X-Received: by 2002:a05:6808:199c:: with SMTP id bj28mr3239709oib.98.1639012776701;
 Wed, 08 Dec 2021 17:19:36 -0800 (PST)
MIME-Version: 1.0
References: <20211208070835.8877-1-kai.heng.feng@canonical.com> <YbEnf2NUr/BCV4Gb@rowland.harvard.edu>
In-Reply-To: <YbEnf2NUr/BCV4Gb@rowland.harvard.edu>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Thu, 9 Dec 2021 09:19:24 +0800
Message-ID: <CAAd53p61w-AHBxy05Hx-gwae1rUxZxsaVfmH=--bQUkPxYj8Nw@mail.gmail.com>
Subject: Re: [PATCH] usb: hub: Resume hubs to find newly connected device
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     gregkh@linuxfoundation.org, mathias.nyman@linux.intel.com,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Bixuan Cui <cuibixuan@huawei.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Chris Chiu <chris.chiu@canonical.com>,
        Rajat Jain <rajatja@google.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 9, 2021 at 5:45 AM Alan Stern <stern@rowland.harvard.edu> wrote:
>
> On Wed, Dec 08, 2021 at 03:08:33PM +0800, Kai-Heng Feng wrote:
> > When a new USB device gets plugged to nested hubs, the affected hub,
> > which connects to usb 2-1.4-port2, doesn't report there's any change,
> > hence the nested hubs go back to runtime suspend like nothing happened:
>
> That's a bug in the hub.  When there's a change in the connection status
> of one of its ports, it should report this change to the kernel.

I think it should, but when I searched through the USB spec and I
can't find anywhere specify hub requires to report it in change
status.

>
> > [  281.032951] usb usb2: usb wakeup-resume
> > [  281.032959] usb usb2: usb auto-resume
> > [  281.032974] hub 2-0:1.0: hub_resume
> > [  281.033011] usb usb2-port1: status 0263 change 0000
> > [  281.033077] hub 2-0:1.0: state 7 ports 4 chg 0000 evt 0000
> > [  281.049797] usb 2-1: usb wakeup-resume
> > [  281.069800] usb 2-1: Waited 0ms for CONNECT
> > [  281.069810] usb 2-1: finish resume
> > [  281.070026] hub 2-1:1.0: hub_resume
> > [  281.070250] usb 2-1-port4: status 0203 change 0000
> > [  281.070272] usb usb2-port1: resume, status 0
> > [  281.070282] hub 2-1:1.0: state 7 ports 4 chg 0010 evt 0000
> > [  281.089813] usb 2-1.4: usb wakeup-resume
> > [  281.109792] usb 2-1.4: Waited 0ms for CONNECT
> > [  281.109801] usb 2-1.4: finish resume
> > [  281.109991] hub 2-1.4:1.0: hub_resume
> > [  281.110147] usb 2-1.4-port2: status 0263 change 0000
> > [  281.110234] usb 2-1-port4: resume, status 0
> > [  281.110239] usb 2-1-port4: status 0203, change 0000, 10.0 Gb/s
> > [  281.110266] hub 2-1.4:1.0: state 7 ports 4 chg 0000 evt 0000
> > [  281.110426] hub 2-1.4:1.0: hub_suspend
> > [  281.110565] usb 2-1.4: usb auto-suspend, wakeup 1
> > [  281.130998] hub 2-1:1.0: hub_suspend
> > [  281.137788] usb 2-1: usb auto-suspend, wakeup 1
> > [  281.142935] hub 2-0:1.0: state 7 ports 4 chg 0000 evt 0000
> > [  281.177828] usb 2-1: usb wakeup-resume
> > [  281.197839] usb 2-1: Waited 0ms for CONNECT
> > [  281.197850] usb 2-1: finish resume
> > [  281.197984] hub 2-1:1.0: hub_resume
> > [  281.198203] usb 2-1-port4: status 0203 change 0000
> > [  281.198228] usb usb2-port1: resume, status 0
> > [  281.198237] hub 2-1:1.0: state 7 ports 4 chg 0010 evt 0000
> > [  281.217835] usb 2-1.4: usb wakeup-resume
> > [  281.237834] usb 2-1.4: Waited 0ms for CONNECT
> > [  281.237845] usb 2-1.4: finish resume
> > [  281.237990] hub 2-1.4:1.0: hub_resume
> > [  281.238067] usb 2-1.4-port2: status 0263 change 0000
> > [  281.238148] usb 2-1-port4: resume, status 0
> > [  281.238152] usb 2-1-port4: status 0203, change 0000, 10.0 Gb/s
> > [  281.238166] hub 2-1.4:1.0: state 7 ports 4 chg 0000 evt 0000
> > [  281.238385] hub 2-1.4:1.0: hub_suspend
> > [  281.238523] usb 2-1.4: usb auto-suspend, wakeup 1
> > [  281.258076] hub 2-1:1.0: hub_suspend
> > [  281.265744] usb 2-1: usb auto-suspend, wakeup 1
> > [  281.285976] hub 2-0:1.0: hub_suspend
> > [  281.285988] usb usb2: bus auto-suspend, wakeup 1
> >
> > So in addition to change event, wakes up the port if it's a hub to find
> > newly connected device:
> > [  232.069881] usb usb2: usb wakeup-resume
> > [  232.069889] usb usb2: usb auto-resume
> > [  232.069904] hub 2-0:1.0: hub_resume
> > [  232.069941] usb usb2-port1: status 0263 change 0000
> > [  232.069962] hub 2-1:1.0: state 8 ports 4 chg 0000 evt 0000
> > [  232.070034] hub 2-0:1.0: state 7 ports 4 chg 0000 evt 0000
> > [  232.112701] usb 2-1: Waited 0ms for CONNECT
> > [  232.112711] usb 2-1: finish resume
> > [  232.112900] hub 2-1:1.0: hub_resume
> > [  232.113218] usb 2-1-port4: status 0203 change 0000
> > [  232.113267] hub 2-1.4:1.0: state 8 ports 4 chg 0000 evt 0000
> > [  232.152679] usb 2-1.4: Waited 0ms for CONNECT
> > [  232.152691] usb 2-1.4: finish resume
> > [  232.152829] hub 2-1.4:1.0: hub_resume
> > [  232.153057] usb 2-1.4-port2: status 0263 change 0000
> > [  232.153094] hub 2-1.4.2:1.0: state 8 ports 3 chg 0000 evt 0000
> > [  232.153155] usb 2-1-port4: resume, status 0
> > [  232.153160] usb 2-1-port4: status 0203, change 0000, 10.0 Gb/s
> > [  232.153192] hub 2-1.4:1.0: state 7 ports 4 chg 0000 evt 0000
> > [  232.153235] hub 2-1:1.0: state 7 ports 4 chg 0000 evt 0000
> > [  232.153244] usb usb2-port1: resume, status 0
> > [  232.153274] usb 2-1.4.2: usb auto-resume
> > [  232.153444] hub 2-1.4:1.0: state 7 ports 4 chg 0000 evt 0000
> > [  232.220690] usb 2-1.4.2: Waited 0ms for CONNECT
> > [  232.220702] usb 2-1.4.2: finish resume
> > [  232.220849] hub 2-1.4.2:1.0: hub_resume
> > [  232.220870] hub 2-1.4:1.0: state 7 ports 4 chg 0000 evt 0000
> > [  232.220949] usb 2-1.4.2-port2: status 0203 change 0001
> > [  232.328747] usb 2-1.4.2-port2: status 0203, change 0000, 5.0 Gb/s
> > [  232.408838] usb 2-1.4.2.2: new SuperSpeed USB device number 5 using xhci_hcd
> > [  232.429734] usb 2-1.4.2.2: skipped 1 descriptor after endpoint
> > [  232.429745] usb 2-1.4.2.2: skipped 1 descriptor after endpoint
> > [  232.429827] usb 2-1.4.2.2: default language 0x0409
> > [  232.430192] usb 2-1.4.2.2: udev 5, busnum 2, minor = 132
> > [  232.430197] usb 2-1.4.2.2: New USB device found, idVendor=0781, idProduct=5581, bcdDevice= 1.00
> > [  232.430202] usb 2-1.4.2.2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> > [  232.430206] usb 2-1.4.2.2: Product: Ultra
> > [  232.430209] usb 2-1.4.2.2: Manufacturer: SanDisk
> > [  232.430212] usb 2-1.4.2.2: SerialNumber: 4C530001170905105491
> > [  232.430488] usb 2-1.4.2.2: usb_probe_device
> > [  232.430493] usb 2-1.4.2.2: configuration #1 chosen from 1 choice
> > [  232.431196] usb 2-1.4.2.2: Disabling U1 link state for device below second-tier hub.
> > [  232.431199] usb 2-1.4.2.2: Plug device into first-tier hub to decrease power consumption.
> > [  232.431469] usb 2-1.4.2.2: adding 2-1.4.2.2:1.0 (config #1, interface 0)
> > [  232.431610] hub 2-1.4.2:1.0: state 7 ports 3 chg 0000 evt 0004
> >
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>
> So because of this buggy hub, you now want to wake up _every_ hub in the
> system whenever any wakeup event occurs?  Is this really a good idea?
> Is there a better way to solve the problem, such as a special quirk
> flag?

If there's no other activities, the USB hub should go back to suspend
immediately, so the impact is minimal.

I've seen several similar bug reports so I think this solution should
be applied for all hubs.

Kai-Heng

>
> Alan Stern
>
> > ---
> >  drivers/usb/core/hub.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> > index 00070a8a65079..0c9442a8eab05 100644
> > --- a/drivers/usb/core/hub.c
> > +++ b/drivers/usb/core/hub.c
> > @@ -1227,6 +1227,10 @@ static void hub_activate(struct usb_hub *hub, enum hub_activation_type type)
> >                                               port_resumed))
> >                               set_bit(port1, hub->change_bits);
> >
> > +                     if ((portstatus & USB_PORT_STAT_CONNECTION) &&
> > +                         usb_hub_to_struct_hub(udev))
> > +                             usb_kick_hub_wq(udev);
> > +
> >               } else if (udev->persist_enabled) {
> >  #ifdef CONFIG_PM
> >                       udev->reset_resume = 1;
> > --
> > 2.32.0
> >
