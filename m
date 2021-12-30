Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9700E481E15
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 17:30:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241278AbhL3Q3q convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 30 Dec 2021 11:29:46 -0500
Received: from mail-qk1-f174.google.com ([209.85.222.174]:33449 "EHLO
        mail-qk1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239850AbhL3Q3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 11:29:45 -0500
Received: by mail-qk1-f174.google.com with SMTP id de30so23165074qkb.0;
        Thu, 30 Dec 2021 08:29:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rIE0hD6v5+o3+ccVAghnpo8R1EgVOu3GGzhoi4/HkIo=;
        b=HBRW/3ydmtof9tu1K6HDAatJkzfifYHtt0yEVF/SfJmV2Ox4ziC+ygzWC24/adycXI
         MAorFZAG7rB1mapcg0juY9QQJJHXxasWW6JI0C1uvwTUEMGmzK+cpZUZ0lNNgMy2r7bU
         OUgWgomTawJLHpryHLoRK06MDP50oVtP52h67Df+xfk7JVKuFocwGJxHlbKz8/y7FD7X
         0IMzE94A/lR+n4YF8twD5uNrZHVs9lt82wViXaCox7wiftJlYIIm40tZTmjc6dCs1jYq
         73LQPSI3wyWoVauYGC/0U5Smls9HsozhGG3mWCeWLU3OMsofDZ+ASg6la4k/YZc/3jMZ
         4L1g==
X-Gm-Message-State: AOAM532pnK/n/jc3ArYaYA0be9955z5URY7l2CZe3vZE7qF/Ts+L3zIA
        FDTp1dcHJge4B3Bc0/caPKejD/y8kx8+RdHbRU4=
X-Google-Smtp-Source: ABdhPJxdzkS1bQFm0Pe0d0VEkepbe2qMDW95s63oUGlvrYCMDpFeBVzMoZXxdCzPfU0KgR4hP6SJHWOOKX4yG1jypUY=
X-Received: by 2002:a37:b702:: with SMTP id h2mr22394075qkf.135.1640881784332;
 Thu, 30 Dec 2021 08:29:44 -0800 (PST)
MIME-Version: 1.0
References: <20211222212014.66971-1-linux@weissschuh.net> <31a528b8-8318-dc09-3a06-80f76771744a@redhat.com>
In-Reply-To: <31a528b8-8318-dc09-3a06-80f76771744a@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 30 Dec 2021 17:29:33 +0100
Message-ID: <CAJZ5v0jdJNh4QB=-=TCKPZNYnvREPKor+mMyyUZZP8GBMn-ZFQ@mail.gmail.com>
Subject: Re: [PATCH] ACPI: battery: Add the ThinkPad "Not Charging" quirk
To:     Hans de Goede <hdegoede@redhat.com>,
        =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ibm-acpi-devel@lists.sourceforge.net,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Mark Pearson <markpearson@lenovo.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Ognjen Galic <smclt30p@gmail.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Bastien Nocera <hadess@hadess.net>,
        David Zeuthen <davidz@redhat.com>,
        Richard Hughes <richard@hughsie.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 23, 2021 at 5:36 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi Thomas,
>
> On 12/22/21 22:20, Thomas Weißschuh wrote:
> > The EC/ACPI firmware on Lenovo ThinkPads used to report a status
> > of "Unknown" when the battery is between the charge start and
> > charge stop thresholds. On Windows, it reports "Not Charging"
> > so the quirk has been added to also report correctly.
> >
> > Now the "status" attribute returns "Not Charging" when the
> > battery on ThinkPads is not physicaly charging.
> >
> > Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
>
> Thanks, patch looks good to me.
>
> As for the userspace issues in dealing with the
> POWER_SUPPLY_STATUS_NOT_CHARGING status, those indeed
> have long been fixed and this status is already returned
> acpi//battery.c from the acpi_battery_handle_discharging()
> function for a while no; and we have had no complaints
> about that:
>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Applied as 5.17 material, thanks!
