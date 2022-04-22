Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F087550AEA1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 05:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443826AbiDVDwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 23:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236246AbiDVDwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 23:52:16 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 677634E39F
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 20:49:24 -0700 (PDT)
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com [209.85.161.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id BDEC63F1B6
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 03:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1650599361;
        bh=0NxhJRQc4xEZU6ZVdifwwxxo01avizUDFM7wsF2Edc4=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=Vdg19xlFOb1isoFjS43h6UlCwUzmO6FG2s12NTqowIcyswocYjwtHPfkbFWPF1zXQ
         YzxKndMTTe25wk6UKFgn49POUZqElQi/SPDIxCPwLVw18MhAcD+vxwERJqULhZy+uW
         yVJilxubf08eRu1h0/0UXjqiJYj1D1qeFOFsJ6inhf+EByh8mZvV6Q7L5Ili2+EWL5
         aJUJr6SP6cI8tJFFBt0Isf6ap02ybufa8ZLbtg5VhMZmOvV1v/BqzEKMYye1aK/ZvY
         PNyKFgeah+cQFt6XyWpLne4X/Nq9zHAMcytEQLeTPnfytRiywlfFku8v+B59gISPp/
         F9hJRXmO5ntsQ==
Received: by mail-oo1-f72.google.com with SMTP id n11-20020a4aa7cb000000b0035c174d6e3dso1809310oom.13
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 20:49:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0NxhJRQc4xEZU6ZVdifwwxxo01avizUDFM7wsF2Edc4=;
        b=M1Av5kQmohGJPzyGAnyzn0ElyDodWXtnvfnWcUuWNq+OJA43RZiEf2gPzOOef8qN4V
         tmOGSJf+49Eng1VGVSi8poUrl/HCLm5OEgUCHncgRyUQBLjGHcmMUVVu9HDmLJju9ftw
         o4QqcjPZ/8yeM8yQdl+FlqghTo7JK08JTOyEsgHycfn3p5BzdflGnSjF1ZGINWGDUYk5
         snoVxivc75ONHGkLi2oISKTrl2AWIVK0C5hI1MWB/QI63Vm0UfSdHg4I2C+vOvMotfa6
         T5GulSDusFgG+Es6yitF4eslnKtea6XY7bkR6n+yEAnDEgU3RT3sJF+dfmNWWBQvk/Yn
         WWeA==
X-Gm-Message-State: AOAM531cCL+PSluuXJrxFukV5tDBGfioZ6ivJQXufDEt43vyzEqYm0HW
        k3cCWUpqLgNFVIzGraGSTF/jkMlkKCwCaOl7RgtaHoTkKFKcLLhBcccy/RbEdwLjWwjXO2U0Xuh
        f5uR0C87tOQ3n3MvsYVs0Xyib0zaJM6TB7BfEg5cfKPSRFaIQCUwJOJli0A==
X-Received: by 2002:a05:6870:4391:b0:e6:3f99:49cb with SMTP id r17-20020a056870439100b000e63f9949cbmr5133786oah.54.1650599360623;
        Thu, 21 Apr 2022 20:49:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzzi659SVwz8JvlblBlHOTxkROTWUjrPnlrKkhJluqUultK0XD/5AZ7e+JNeLkbwZ85uDNoFM5AfJigBgxX1LQ=
X-Received: by 2002:a05:6870:4391:b0:e6:3f99:49cb with SMTP id
 r17-20020a056870439100b000e63f9949cbmr5133777oah.54.1650599360290; Thu, 21
 Apr 2022 20:49:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220420124053.853891-1-kai.heng.feng@canonical.com>
 <20220420124053.853891-5-kai.heng.feng@canonical.com> <YmAgq1pm37Glw2v+@lunn.ch>
 <CAAd53p6UAhDC2mGkz3_HgVs7kFgCwjfu2R+9FfROhToH2R6CjA@mail.gmail.com>
 <YmFFWd42Nol7Lrlm@lunn.ch> <CAAd53p6vUcUu=H=cDMh07zcUUDM8WTp+F_L+jiJSWKqd37+MDg@mail.gmail.com>
 <YmFUwXLDIW5ouDCd@lunn.ch>
In-Reply-To: <YmFUwXLDIW5ouDCd@lunn.ch>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Fri, 22 Apr 2022 11:49:08 +0800
Message-ID: <CAAd53p4rv+CH+F4KM6aXZXUdRTM1hi_dELtNbbLJQvO2-dCbTw@mail.gmail.com>
Subject: Re: [PATCH 4/5] net: phy: marvell: Add LED accessors for Marvell 88E1510
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     hkallweit1@gmail.com, linux@armlinux.org.uk,
        peppe.cavallaro@st.com, alexandre.torgue@foss.st.com,
        joabreu@synopsys.com, davem@davemloft.net, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 8:57 PM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Thu, Apr 21, 2022 at 08:24:00PM +0800, Kai-Heng Feng wrote:
> > On Thu, Apr 21, 2022 at 7:51 PM Andrew Lunn <andrew@lunn.ch> wrote:
> > >
> > > > This is not feasible.
> > > > If BIOS can define a method and restore the LED by itself, it can put
> > > > the method inside its S3 method and I don't have to work on this at
> > > > the first place.
> > >
> > > So maybe just declare the BIOS as FUBAR and move on to the next issue
> > > assigned to you.
> > >
> > > Do we really want the maintenance burden of this code for one machines
> > > BIOS?
> >
> > Wasn't this the "set precedence" we discussed earlier for? Someone has
> > to be the first, and more users will leverage the new property we
> > added.
>
> I both agree and disagree. I'm trying to make this feature generic,
> unlike you who seem to be doing the minimal, only saving one of three
> LED configuration registers. But on the other hand, i'm not sure there
> will be more users. Do you have a list of machines where the BIOS is
> FUBAR? Is it one machine? A range of machines from one vendor, or
> multiple vendors with multiple machines. I would feel better about the
> maintenance burden if i knew that this was going to be used a lot.

Right now it's only one machine. But someone has to be the first :)

>
> > > Maybe the better solution is to push back on the vendor and its
> > > BIOS, tell them how they should of done this, if the BIOS wants to be
> > > in control of the LEDs it needs to offer the methods to control the
> > > LEDs. And then hopefully the next machine the vendor produces will
> > > have working BIOS.
> >
> > The BIOS doesn't want to control the LED. It just provides a default
> > LED setting suitable for this platform, so the driver can use this
> > value over the hardcoded one in marvell phy driver.
>
> Exactly, it wants to control the LED, and tell the OS not to touch it
> ever.

That doesn't mean it wants to control the LED, it's still the phy
driver controls it.

>
> > So this really has nothing to do with with any ACPI method.
> > I believe the new property can be useful for DT world too.
>
> DT generally never trusts the bootloader to do anything. So i doubt
> such a DT property would ever be used. Also, DT is about describing
> the hardware, not how to configure the hardware. So you could list
> there is a PHY LED, what colour it is, etc. But in general, you would
> not describe how it is configured, that something else is configuring
> it and it should be left alone.

What if let the property list to the raw value of the LED should be?
So it can fall under "describing hardware" like 'clock-frequency' property.

>
> > > Your other option is to take part in the effort to add control of the
> > > LEDs via the standard Linux LED subsystem. The Marvel PHY driver is
> > > likely to be one of the first to gain support this for. So you can
> > > then totally take control of the LED from the BIOS and put it in the
> > > users hands. And such a solution will be applicable to many machines,
> > > not just one.
> >
> > This series just wants to use the default value platform firmware provides.
> > Create a sysfs to let user meddle with LED value doesn't really help
> > the case here.
>
> I would disagree. You can add a systemd service to configure it at
> boot however you want. It opens up the possibility to implement
> ethtool --identify in a generic way, etc. It is a much more powerful
> and useful feature than saying 'don't touch', and also it justify the
> maintenance burden.

That just pushed the maintenance burden to another subsystem and I
doubt it will bring more users than current approach.

Kai-Heng

>
>      Andrew
