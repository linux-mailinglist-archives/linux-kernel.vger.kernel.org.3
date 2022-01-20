Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAB9249456C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 02:15:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237545AbiATBPW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 20:15:22 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:37950
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231224AbiATBPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 20:15:21 -0500
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 36F2E3F1C9
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 01:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1642641312;
        bh=0v4gy51wpzyV29O6CgPisevK08euN9YpQian7OujOLs=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=bAlb1kvMh+vxIiytQt7tLuLxk6szLf6Fd7c1MWgehFKvAPqGBQ5+cjST9BSriTaHU
         qwIkwTyAh+1C6BuztxKTBT6d/oJndDikk7HxaG/oy6kLml+fQNsZB3u8qkrkS462Ms
         w0CDF0FLblUqWR+z6s6r2yA0HE0ayebKxq3QrQOAddjg7gHdARSJvLF7tPLHrfGhxT
         Vikem1ILqPJ1SSW5DPlCRxgXv0WWWg5VYb957FxyY2qyHGlLTn2Qgt6vOyp5yvgqDs
         y9tky86VRLBIlZ9FldjONatidvRf6/gGJUPtfNksYMBGUTjsJtZIs0pDj+/Wt9VpIK
         pRyZ+d+ddOizg==
Received: by mail-oi1-f200.google.com with SMTP id o130-20020aca5a88000000b002c8dd0d6fa3so3004513oib.18
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 17:15:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0v4gy51wpzyV29O6CgPisevK08euN9YpQian7OujOLs=;
        b=xrBPG1AkllmQMZu2Mca4faNcMlHuTSSteeYKjI1m2NbLGagrMX6+gqOSR5G3F0dYrg
         hf6+8PiozKjnzbUDIMj6DQIekHbEm2r1+96PT+iH1lUZFopxPeK3iEYkPVdKeQzTmPEN
         eKXIgeXSOPI/zD2CXqwp5jA/j1bERGI1KW2HIACin2+gLPELyDWzn4/Y1IeHx731ZLYk
         39QixTxUyPVbvtEUqQoUqsOq9tQKlO99vvrH8sQjFNeWzhyZ35G01uLzFpsfdTZZmmBw
         3NRoyPbi3oZ7S4j7F5joucP4BaHWtzwp4dL+2IwkCf7uX53xxvDSFWCRdxIXQTPwb8lB
         fz2A==
X-Gm-Message-State: AOAM532uArvGlhrVjjvOrukdc0jVopSS/ZKPNPpj0Aqh77FeYDLnhOgL
        EVhwWV87D6FZFOMsSRyv4a4e42Ofdu0eEAQolLQ2iprbJpBGLahxGkGvbTisBDI7UVaN2YyqgkA
        JoS3d9FgtpOGVl1rpg+kfnaIyoa/xuvasp7nN7On/TXwKX8Nhn0aTCpxWJQ==
X-Received: by 2002:a9d:480e:: with SMTP id c14mr1866739otf.233.1642641311091;
        Wed, 19 Jan 2022 17:15:11 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz5ZrANjov6CvE7y3xxcCys3zYKdgn2cIwpXdF/tgkrxPVjt3tEqcAzq4H7WWd2Bpfe9Wn047ZAa3W8lqIcNBs=
X-Received: by 2002:a9d:480e:: with SMTP id c14mr1866718otf.233.1642641310835;
 Wed, 19 Jan 2022 17:15:10 -0800 (PST)
MIME-Version: 1.0
References: <20220119202749.GA959272@bhelgaas> <4a767d48-fa5d-17be-373d-b49522910285@redhat.com>
In-Reply-To: <4a767d48-fa5d-17be-373d-b49522910285@redhat.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Thu, 20 Jan 2022 09:14:59 +0800
Message-ID: <CAAd53p63JfuipN97-vQgtGL0jwnAZ2BqxmTrXpQ5rjdVwc8XWA@mail.gmail.com>
Subject: Re: Convert type of 'struct dmi_system_id -> driver_data' from 'void
 *' to kernel_ulong_t?
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, jkosina@suse.cz,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Bjorn Helgaas <bhelgaas@google.com>, mgurtovoy@nvidia.com,
        linux@weissschuh.net, Arnd Bergmann <arnd@arndb.de>,
        stephan@gerhold.net, "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans an Bjorn,

On Thu, Jan 20, 2022 at 4:45 AM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 1/19/22 21:27, Bjorn Helgaas wrote:
> > On Wed, Jan 19, 2022 at 11:20:36AM +0100, Hans de Goede wrote:
> >> On 1/19/22 02:22, Kai-Heng Feng wrote:
> >>> I wonder if there's any reason to use 'void *' instead of
> >>> kernel_ulong_t for 'driver_data' in 'struct dmi_system_id'?
> >>>
> >>> I'd like to use the driver_data for applying quirk flags, and I found
> >>> out unlike most other struct *_id, the dmi variant is using 'void *'
> >>> for driver_data. Is there any technical reason for this?
> >>> ...
> >
> >> You are asking for a technical reason why "void *" was used,
> >> but lets turn that around, why do you believe that "unsigned long"
> >> is inherently a better type here ?
> >>
> >> driver_data in most places in the kernel (like data for
> >> all sort of callback functions) actually typically is a void *
> >> already, because often people want to pass more data then what
> >> fits in a single long and this also applies to driver-id attached
> >> data.
> >
> > FWIW, "egrep "context;|data;|info;" include/linux/mod_devicetable.h"
> > says 4 of the ~40 instances use a void *; the others use
> > kernel_ulong_t.
>
> Right inside mod_devicetable.h kernel_ulong_t is the norm, but outside
> e.g. inside struct device and with dev_set_drvdata/dev_get_drvdata
> and all their many derratives using void * is the norm.
>
> So looking at the kernel as a whole using kernel_ulong_t seems
> to be the exception. But maybe that indeed has something to
> do with:
>
> > f45d069a5628 ("PCI dynids - documentation fixes, id_table NULL check")
> > [1] (from the tglx history tree) added the original hint for
> > pci_device_id that:
> >
> >   Best practice for use of driver_data is to use it as an index into a
> >   static list of equivalant device types, not to use it as a pointer.
> >
> > I don't know the background of that, but I could imagine that using an
> > index rather than a pointer makes things like /sys/bus/pci/.../new_id
> > easier and safer.
>
> Right, interesting.
>
> OTOH we have:
>
> const void *device_get_match_data(struct device *dev);
>
> Which is a wrapper to easily get the driver_data for popular firmware
> based matches (ACPI/of), which also returns a void *...
>
> Actually the rule seems to be that firmware-id matching,
> including WMI GUID matching uses void * where as hw-id
> (e.g prod:vend matching) uses kernel_ulong_t with acpi_device_id
> being the exception since it is a fwid using kernel_ulong_t,
> which then gets "fixed" by acpi_device_get_match_data turning
> it into a void * for the caller.
>
> As DMI matching is closer to firmware compatible/id matching then
> to actual hw-id matching, it seems that it actually follows
> the pattern of fw-id matches using void * where as hw-id
> matches using void * .
>
> TBH I don't care much either way, but I also really don't see
> strong reasons to spend a lot of time on changing any of this.

Thanks for all the info.
I think they are great justifications that I should avoid all the
hustles to convert the type, and stick to the pointer/integer casting.

Kai-Heng

>
> Regards,
>
> Hans
>
