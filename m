Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 989474A63D0
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 19:30:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236044AbiBASaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 13:30:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232677AbiBAS37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 13:29:59 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44109C061714
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 10:29:59 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id p5so53505972ybd.13
        for <linux-kernel@vger.kernel.org>; Tue, 01 Feb 2022 10:29:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=I7jVNfxfiR6L9cpor2lIeHYS68RLOhT6ui7FFhcZWz8=;
        b=DE+IbdQ63PDvuuuh9gJIWrSsywRKD8r77zIfVu8whigf/Ly1xuNWc66zIh1s30fhb5
         dJinz/fjR2Eno8I8Mm6DoNhea7xR51a5wbnq4XVYC2VAvphzzzIJVJKyIHlZ/VqTfE0e
         w8/+D7iv7bwBy4BKrKOGSoR3LxqqyLNZVFP+c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=I7jVNfxfiR6L9cpor2lIeHYS68RLOhT6ui7FFhcZWz8=;
        b=PkJDmumbI+aHN8KnKldBfk6M+Q1GB2Qz4a8BvDbKHWav8CcCiRYoPazaNSgs0EzZVR
         kAC3WM/Uck0KOzvLdkVOzYzpJ4iOI3V24ovRKHKpnDJvPrIJwMmFU9GkSYUOoNZumveh
         ya1wM84qaDeKCducWnDTLI7BkJHLndmtTSzek1irdwUrXsu9gW/EL9RRvmsPJN6chh7n
         qsLs3x4yylgqkT7bUDCAzj+3AFPMHaEmi/ahxQiv9aIbt94QswZPkTeNnUcmrURFVWa8
         qIWUKuT7tv7TzKxCSmRnETQvUceD4HjAUNah3bgea0DPWXgJ9GkdaoTrJQDdrtoXFpJL
         7UCg==
X-Gm-Message-State: AOAM533eIrZMMyMMzo8cnlKUFIbLG6sOMleuytO2rL/HX2IPrjMOyopz
        yAyGGXG79mZ1iv2BLvm+BvVGDfLqUt6qhsOgtndcRM4O7S0=
X-Google-Smtp-Source: ABdhPJwPxuDKdBHh2HvzjmJlvoYFjqoLZkyj4AU5NDzGKsornYRfx+d/FQCt96plRhZ/ajyaShJX1vAIstG2jAjhfXE=
X-Received: by 2002:a25:ad14:: with SMTP id y20mr28247979ybi.155.1643740198548;
 Tue, 01 Feb 2022 10:29:58 -0800 (PST)
MIME-Version: 1.0
References: <20220126190219.3095419-1-pmalani@chromium.org>
 <20220126230411.nn2illij4wbpdm4q@eve> <YfHUXtJPU77wtCPb@chromium.org> <20220201121745.r4dbilp3fpqhjuty@eve>
In-Reply-To: <20220201121745.r4dbilp3fpqhjuty@eve>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Tue, 1 Feb 2022 10:29:47 -0800
Message-ID: <CACeCKadF3Yn-DvE+fgVPDq84K0VO-L-5j8UxOEk3zZGpkDFixg@mail.gmail.com>
Subject: Re: [PATCH v2] platform/chrome: cros_ec_typec: Check for EC device
To:     Alyssa Ross <hi@alyssa.is>
Cc:     linux-kernel@vger.kernel.org, Tzung-Bi Shih <tzungbi@google.com>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        chrome-platform@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alyssa,

On Tue, Feb 1, 2022 at 4:17 AM Alyssa Ross <hi@alyssa.is> wrote:
>
> Hi Prashant,
>
> On Wed, Jan 26, 2022 at 11:08:14PM +0000, Prashant Malani wrote:
> > Hi Alyssa,
> >
> > On Jan 26 23:04, Alyssa Ross wrote:
> > > On Wed, Jan 26, 2022 at 07:02:20PM +0000, Prashant Malani wrote:
> > > > The Type C ACPI device on older Chromebooks is not generated correc=
tly
> > > > (since their EC firmware doesn't support the new commands required)=
. In
> > > > such cases, the crafted ACPI device doesn't have an EC parent, and =
it is
> > > > therefore not useful (it shouldn't be generated in the first place =
since
> > > > the EC firmware doesn't support any of the Type C commands).
> > > >
> > > > To handle devices which use these older firmware revisions, check f=
or
> > > > the parent EC device handle, and fail the probe if it's not found.
> > > >
> > > > Fixes: fdc6b21e2444 ("platform/chrome: Add Type C connector class d=
river")
> > > > Reported-by: Alyssa Ross <hi@alyssa.is>
> > > > Reviewed-by: Tzung-Bi Shih <tzungbi@google.com>
> > > > Signed-off-by: Prashant Malani <pmalani@chromium.org>
> > > > ---
> > > > Hi Alyssa, could you kindly test this with your existing setup? Tha=
nks!
> > >
> > > Hi Prashant, I'm happy to test, but I'm on vacation until the end of =
the
> > > week so probably won't get a chance before Monday.
> >
> > No worries, whenever you get the chance is fine.
> >
> > >
> > > I'm guessing I should be testing with latest upstream coreboot (now t=
hat
> > > your fix there has been applied)?
> >
> > You should use the coreboot with which you discovered the crash, so the
> > one which *doesn't* contain the fix.
>
> I applied this patch to Linux 5.17-rc2 and tested with the
> coreboot_tiano-eve-mrchromebox-20210806.rom firmware.
>
> The Oops has been replaced with
> "cros-ec-typec: GOOG0014:00: couldn't find parent EC device".
> My laptop now reboots correctly =E2=80=94 the hang on reboot is gone.
>
> The cros_ec_typec driver ends up being loaded, but no devices are bound
> to it.  This differs from the behaviour with upstream coreboot
> (cabf9e33a7), where cros_ec_typec does not end up being loaded.
>
> Assuming all that's the intended behaviour:

Yep, that's WAI. Thanks a lot for testing this, and yes, we'll be sure
to reach out
for future help with validating changes.

Best regards,
