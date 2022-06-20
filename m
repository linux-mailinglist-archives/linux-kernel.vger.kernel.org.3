Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8D88552858
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 01:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245483AbiFTXbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 19:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244221AbiFTXbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 19:31:31 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 511E51274C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 16:31:29 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id a11so4756154ljb.5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 16:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1CFkBJOtdGheyOUeX2yPaN3vtsNkY5WbEiLu1iujMTs=;
        b=c4HGipQeXgKwPcs43aMkdi5K3w74ldx4cPKh57/kJpEQTehk3R/ApwGMNcAHO0Tdv1
         KZcLI3O9sYzcsqENTulejrJsKyKbECVvxjRTj8MwTSKDp1iU1F7fJ2jwGzYLCZFmtPp4
         lFpffbNNQ5kIHynvctCZjyLfHRPhdPZUxsbvm5i7v/Zvk2CJq/t7YLnFaTCwfsHe0C1u
         onkG1TkN4yM9IuLPlUwYVfnTQ+SgsNSxQG59fnew9BzNwu2V8ik0qxv07FfJ9pMmGQCZ
         MOhJ+CKSFEtbEffaaaZ+krJRh1TGny3Kr9jJAXaWLOUE2a6Ym3yzB1vBdIepC5L74Xwb
         6g6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1CFkBJOtdGheyOUeX2yPaN3vtsNkY5WbEiLu1iujMTs=;
        b=0Yxa7dayVLMn9EyNJXD7GNo7i6draVMIhao3yYCJCwSbQTPlTZfxORExeBU9kJlNyq
         OSL8Vu4Vcse0gSejPBwCHbU76MpLPHN1Ygftzi0h3MDOqqUMQpCg4/6/O3VoaDULLWJa
         0j5p7irRuFwBYVSe00qk8o7oQjypiJDbPXoI/0vpMgVi173uSZ9RX6bMu08D5J6BNYN7
         mbdVYSTDC4yITafxlwGik+0v8QHXFuQQGKspNhCp92eZe4MUK5EzEKSMqczaD80XLjCG
         qJxmtpviKB0Lng0KvndCnsjmClJ1mHMEGG/OkDNBhovaCYbojrneAFO4K77xC9rTWKOW
         VxBA==
X-Gm-Message-State: AJIora/+W3JsGDshYfcZt8h60yo+wl7pIpHE8FZ96k77girUoq/KOhiR
        bgj8idTXJiFW31YbO0C30nOsA5cLz8BLql54t6IuiA==
X-Google-Smtp-Source: AGRyM1sbnZzfwsCxwOZ4fl03m/sbkmCz2JnOCvW0MwaN6F99qEiBqmCOunyhbakJlEfMe1w/RrfFHKde5cExa9fFVm4=
X-Received: by 2002:a2e:a58d:0:b0:25a:6348:9595 with SMTP id
 m13-20020a2ea58d000000b0025a63489595mr6680735ljp.72.1655767887614; Mon, 20
 Jun 2022 16:31:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220620150225.1307946-1-mw@semihalf.com> <20220620150225.1307946-11-mw@semihalf.com>
 <YrC9KpEuYCgHv14l@lunn.ch>
In-Reply-To: <YrC9KpEuYCgHv14l@lunn.ch>
From:   Marcin Wojtas <mw@semihalf.com>
Date:   Tue, 21 Jun 2022 01:31:17 +0200
Message-ID: <CAPv3WKeHpB0v1udzSAjm3QnRoCaVTUqiOa7f_MvAbgMOWDDEAg@mail.gmail.com>
Subject: Re: [net-next: PATCH 10/12] net: dsa: add ACPI support
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Len Brown <lenb@kernel.org>, vivien.didelot@gmail.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, pabeni@redhat.com,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Grzegorz Bernacki <gjb@semihalf.com>,
        Grzegorz Jaszczyk <jaz@semihalf.com>,
        Tomasz Nowicki <tn@semihalf.com>,
        Samer El-Haj-Mahmoud <Samer.El-Haj-Mahmoud@arm.com>,
        upstream@semihalf.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pon., 20 cze 2022 o 20:32 Andrew Lunn <andrew@lunn.ch> napisa=C5=82(a):
>
> >  static int dsa_port_parse_dsa(struct dsa_port *dp)
> >  {
> > +     /* Cascade switch connection is not supported in ACPI world. */
> > +     if (is_acpi_node(dp->fwnode)) {
> > +             dev_warn(dp->ds->dev,
> > +                      "DSA type is not supported with ACPI, disable po=
rt #%d\n",
> > +                      dp->index);
> > +             dp->type =3D DSA_PORT_TYPE_UNUSED;
> > +             return 0;
> > +     }
> > +
>
> Did you try this? I'm not sure it will work correctly. When a switch
> registers with the DSA core, the core will poke around in DT and fill
> in various bits of information, including the DSA links. Once that has
> completed, the core will look at all the switches registered so far
> and try to determine if it has a complete set, i.e, it has both ends
> of all DSA links. If it does have a complete set, it then calls the
> setup methods on each switch, and gets them configured. If it finds it
> does not have a complete setup, it does nothing, waiting for the next
> switch to register.
>
> So if somebody passed an ACPI description with multiple switches, it
> is likely to call the setup methods as soon as the first switch is
> registered. And it might call those same setup methods a second time,
> when the second switch registers, on both switches. And when the third
> switch registers, it will probably call the setup methods yet again on
> all the switches....
>
> You will have a much safer system if you return -EINVAL if you find a
> DSA link in ACPI. That should abort the switch probe.
>

I only set a single port to "dsa" label to check if this condition is
entered. I see 2 devices in the arm64 tree (fsl-lx2160a-bluebox3.dts
and armada-3720-turris-mox.dts) that support cascade switches via
"link" property. I don't have access to real life setup (and those
seem to not support ACPI anyway...).

In case this temporarily would remain as unsupported feature, I agree
-EINVAL is a safer solution.

Thanks,
Marcin
