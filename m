Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E0474E66A9
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 17:10:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351548AbiCXQLl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 12:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234603AbiCXQLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 12:11:38 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6A48237CA;
        Thu, 24 Mar 2022 09:10:05 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id n7-20020a17090aab8700b001c6aa871860so5575161pjq.2;
        Thu, 24 Mar 2022 09:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Yx6e+knQ1Y5zWPXeZZfvunt9KLxx+WpHSkr7jzMyxmk=;
        b=e0huBxOHjyFWHBLV/81d4h8G1rlge1GoRCD52VLoS7ADL7ziKcqe9DkCyks60ZbtwQ
         a6x19bBIec5YgTcseduI+/w8dPEMoBDcGtlo1JPAf54QU9kZmG4VCNGbrtDqQuDG61qI
         rTWfbXyxKdMNTixyNPn+sXEscb+wCiJgHDYw4ZtiBQXb38srgFbBzBmvSaMTwgvaloap
         BAz5mMayeKLTqjS7ZNg0hc92pF38sYYXKyLy/UmZZ/BNJdAmSU/rnyOUdeN7V7SnJBlu
         sv6t0g9+TL5pWCl2Vw8nWVKEEpBEgHyaxwGZDNCe0cMpAvnj9LvxA7uq0U6vIi90faUz
         s5XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Yx6e+knQ1Y5zWPXeZZfvunt9KLxx+WpHSkr7jzMyxmk=;
        b=YkkEf4stODsIclrDsOYckwtFaoj6a3OUS4yCt6HOnA5N5K9Ck9UE6r3KWEQR67cEF+
         OqI45I0T3XD4kE/a4jmhFT8xyoHKdMn79JAPp9b1pldwSGXJiOZoDsX1q+6BmvkjP4oE
         5ri8pBD/lIVY0j78jcLKnZz08r7k93i5lsiYPn9s94RaR7IC7MwVVqKC13EQKLz4pf/s
         5np4s3EYpOArxvzckQTitp4Usj/+ZEwzg8M6rQADmSdDXWil1cC/YnPu6YtmWq7eDL97
         c2xV9Zjb78+q111uXYASJYiVrOQOBVtNrW0sNAYrvA91GLOdUP1Z2rr5cfgRvDzgPb9A
         xLUA==
X-Gm-Message-State: AOAM532XnsI8hvqOMVbK6obwKShzHp+bdbUWMbjddQdE8OIUmUcoQYfn
        TMTO1W1uGgQEWxPGfbnCBYY=
X-Google-Smtp-Source: ABdhPJyswsjNuZjYCxTL6CXqhhWR95S8YEPrwguEFilcVxOiIybab4tZdkTJP6sHnE67nKoGpHov3Q==
X-Received: by 2002:a17:90a:fcc:b0:1c6:62b5:45c0 with SMTP id 70-20020a17090a0fcc00b001c662b545c0mr7024135pjz.133.1648138204889;
        Thu, 24 Mar 2022 09:10:04 -0700 (PDT)
Received: from hermes ([2604:3d09:e80:800::72d9])
        by smtp.gmail.com with ESMTPSA id ev16-20020a17090aead000b001c7c2919453sm2408992pjb.33.2022.03.24.09.10.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 09:10:04 -0700 (PDT)
Date:   Thu, 24 Mar 2022 10:10:02 -0600
From:   Manuel =?iso-8859-1?Q?Sch=F6nlaub?= <manuel.schoenlaub@gmail.com>
To:     Bastien Nocera <hadess@hadess.net>
Cc:     Filipe =?iso-8859-1?Q?La=EDns?= <lains@riseup.net>,
        jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: logitech-hidpp: support Color LED feature (8071).
Message-ID: <YjyX2q1IXeJQ2LGG@hermes>
References: <Yifr4etBFPu1a2Ct@hermes>
 <275245e8048fa124055d9ff3d10ce6562294483a.camel@riseup.net>
 <ce3adf7013ba01aad54fb65bf9c657dd9d0b7d23.camel@hadess.net>
 <YjvlQrvRS+ZKNbZ5@hermes>
 <5b842bd4f8d17e5ecb8e7972637dbe7ad50060ac.camel@hadess.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5b842bd4f8d17e5ecb8e7972637dbe7ad50060ac.camel@hadess.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 24, 2022 at 10:32:21AM +0100, Bastien Nocera wrote:
> On Wed, 2022-03-23 at 21:28 -0600, Manuel Schönlaub wrote:
> > On Wed, Mar 23, 2022 at 11:24:18PM +0100, Bastien Nocera wrote:
> > > On Wed, 2022-03-23 at 21:22 +0000, Filipe Laíns wrote:
> > > > On Tue, 2022-03-08 at 16:50 -0700, Manuel Schönlaub wrote:
> > > > > The HID++ protocol allows to set multicolor (RGB) to a static
> > > > > color.
> > > > > Multiple of such LED zones per device are supported.
> > > > > This patch exports said LEDs so that they can be set from
> > > > > userspace.
> > > > > 
> > > > > Signed-off-by: Manuel Schönlaub <manuel.schoenlaub@gmail.com>
> > > > > ---
> > > > >  drivers/hid/hid-logitech-hidpp.c | 188
> > > > > +++++++++++++++++++++++++++++++
> > > > >  1 file changed, 188 insertions(+)
> > > > 
> > > > *snip*
> > > > 
> > > > Hi Manuel,
> > > > 
> > > > Thanks for putting this forward, although I am not sure if this
> > > > is
> > > > the best way
> > > > to handle this.
> > > > 
> > > > Before anything, could you elaborate a bit on what lead to you
> > > > wanting this?
> > > > 
> > > > There are a couple of reasons why merging this in the kernel
> > > > might be
> > > > problematic.
> > > > 
> > > > 1) I don't think we will ever support the full capabilities of
> > > > the
> > > > devices, so
> > > > configuration via userspace apps will always be required, and
> > > > here we
> > > > are
> > > > introducing a weird line between the two.
> > > > 
> > > > 2) There is already an ecosystem of userspace configuration apps,
> > > > with which
> > > > this would conflict. They might not be in the best maintenance
> > > > state
> > > > due to lack
> > > > of time from the maintainers, but moving this functionality to
> > > > the
> > > > kernel, which
> > > > is harder change, and harder to ship to users, will only make
> > > > that
> > > > worse.
> > > 
> > > There's already an API for LEDs in the kernel, why shouldn't it be
> > > used
> > > to avoid user-space needing to know how to configure Logitech, and
> > > every other brand of keyboards?
> > > 
> > > systemd has code to save and restore LED status, as well as code to
> > > change the level of backlight. I can imagine that it wouldn't take
> > > much
> > > to make it aware of RGB LEDs so it handles them properly, whether
> > > it's
> > > for Logitech, or another brand of keyboards, or laptops.
> > 
> > Teaching systemd-backlight about mulicolor backlights might be a nice
> > project
> > too. But their use case seems to be more about screen backlights as
> > it seems.
> > Did I overlook something here?
> 
> From rules.d/99-systemd.rules.in:
> # Pull in backlight save/restore for all backlight devices and
> # keyboard backlights
> SUBSYSTEM=="backlight", TAG+="systemd", IMPORT{builtin}="path_id", ENV{SYSTEMD_WANTS}+="systemd-backlight@backlight:$name.service"
> SUBSYSTEM=="leds", KERNEL=="*kbd_backlight", TAG+="systemd", IMPORT{builtin}="path_id", ENV{SYSTEMD_WANTS}+="systemd-backlight@leds:$name.service"
> 
> And from the NEWS file for systemd 243:
>         * systemd-logind now exposes a per-session SetBrightness() bus call, 
>           which may be used to securely change the brightness of a kernel
>           brightness device, if it belongs to the session's seat. By using this
>           call unprivileged clients can make changes to "backlight" and "leds"
>           devices securely with strict requirements on session membership.
>           Desktop environments may use this to generically make brightness
>           changes to such devices without shipping private SUID binaries or
>           udev rules for that purpose.
> 
> It's clear that it's not just displays.
> 
> > 
> > Oh and yeah, IMHO another argument could be that obviously at some
> > point
> > the LED management could be removed from those user space tools, as
> > the
> > kernel would already know about them.
> > 
> > After all the LED class devices should be there for a reason ;-)
> > 
> > Cheers,
> > 
> > Manuel
> > 
>

Yeah the SetBrightness in systemd / logind should work out of box.

Though I just noticed something: For this to be useful, the default
multi_intensity for each component of the multicolor LED in the kernel should be set to
max_brightness, effectively producing white (on RGB LEDs at least).
If it is zero, like now, SetBrightness would IMHO not actually switch
the LED on because of how the calculation of color components works. 
That way systemd wouldn't need to care about whether the LED is
multicolor or not.

The save/restore stuff IMHO works only for backlights and kbd_backlight LEDs,
as seen from the udev rules. At least out of the box. It even seems to stop
working once you would have two kbd_backlights for the same device
(as the name would be kbd_backlight-1, kbd_backlight-2, ... as per the
documentation on LED classdevs.)

Now there are three solutions:

1) Naming the Logitech LEDs <device>:rgb:kbd_backlight-N even on mice
and at some point send a patch to systemd adapting the udev rules to
care for devices with nuemrical suffixes.

2) Naming the LEDs <device>:rgb:backlight-N and send a patch to systemd
adding a new udev rule to cater for backlight LEDs in general.

3) Like 2 but expect users to write their own udev rules if they want
save/restore for Logitech devices.

What's your opinion on the naming? IMHO mice are not exactly keyboards,
so it probably should be a "general" backlight.
(Instead of "indicator", as in version 1 of the patch)

Cheers
