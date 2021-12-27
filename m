Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FABF480184
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 17:18:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233959AbhL0QSg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 11:18:36 -0500
Received: from mail-qv1-f47.google.com ([209.85.219.47]:46708 "EHLO
        mail-qv1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231254AbhL0QSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 11:18:34 -0500
Received: by mail-qv1-f47.google.com with SMTP id r6so14110969qvr.13;
        Mon, 27 Dec 2021 08:18:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8gefXXdQomg2lMC26R9yB37lprOxns0H/Q3I88w1pc0=;
        b=gtVR6W7ikJzw2dvMUOpVn3LQTt/KLLp3Cg777DRMLIqF8ytLlV456cK7KEdlvLxSG5
         qfkW/DF1aO+QWX6ZxKsUMmSa6BEouunSm05VxaJHxFJ53ts/h/ozaDkFCRcjkZKz5vJh
         jK14DX6ocH07VJIPU2PbBfdjQwD3UYpHCoP/P2DVUB4QMN62uC0HBm9W9kCd+dwyagu7
         Ux1eXOWfOaGtLelFBJhaqv8Qd5GyvHxYJYcLPCwnhR8uTO6fxblsb38NyswQCQMVcsWu
         ep1C7UI7tWWqvXxWGwB98ZCNOkSuy4D1aZa/tbqCI0/r5ou/CeivrGly1SFMw12nmIAS
         BwjQ==
X-Gm-Message-State: AOAM531+HCYYBmlV00uFoE48O1XLL5hFj+MCZtxydutVLBS7tGxcMX+E
        G7a9LEH+roZ04h63iHl7l49GY7Ztj0u4AB2/CK4=
X-Google-Smtp-Source: ABdhPJyZMQE+q0b7sLIZlcl0UDL23HMrfnC8oKMWtZvi2Rx0CrrigaC4GJ5Q+ydgTiYFPA82KU3vN6IA3v7v8iaKylA=
X-Received: by 2002:a05:6214:1c06:: with SMTP id u6mr15692349qvc.35.1640621913901;
 Mon, 27 Dec 2021 08:18:33 -0800 (PST)
MIME-Version: 1.0
References: <20211223081620.45479-1-heikki.krogerus@linux.intel.com>
In-Reply-To: <20211223081620.45479-1-heikki.krogerus@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 27 Dec 2021 17:18:16 +0100
Message-ID: <CAJZ5v0jHQmNGsOu9TQhUJD3uoc6XijZwRD1K4GfV_KoD=Q79WA@mail.gmail.com>
Subject: Re: [PATCH v5 0/5] acpi: Store _PLD information and convert users
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Prashant Malani <pmalani@chromium.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:ULTRA-WIDEBAND (UWB) SUBSYSTEM:" 
        <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 23, 2021 at 9:16 AM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> Hi,
>
> The last version (v4) was not properly cleaned up. Should be now OK.

It looks good to me, so

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

for the ACPI-related changes in this series and please feel free to
route it through the USB tree if that's preferred.

Thanks!

> v4 cover letter:
>
> Now only storing the crc hash to a new member in struct acpi_device,
> just like proposed by Rafael. In port-mapper.c I'm then scanning the
> acpi bus separately with every port in order to find the matching
> devices.
>
>
> v3 cover letter:
>
> The _PLD buffer is no longer stored as requested by Rafael, so the
> drivers will need to continue to evaluate the _PLD if they need it.
>
> The stored locations will therefore only contain the list of other
> devices that share the location, but that is most important, and in
> practice the main goal of the series in any case.
>
>
> v2 cover letter:
>
> I'm now using the helpers device_match_acpi_dev() and
> device_match_fwnode() like Andy suggested. No other changes.
>
>
> The original cover letter:
>
> This removes the need for the drivers to always separately evaluate
> the _PLD. With the USB Type-C connector and USB port mapping this
> allows us to start using the component framework and remove the custom
> APIs.
>
> So far the only users of the _PLD information have been the USB
> drivers, but it seems it will be used also at least in some camera
> drivers later. These nevertheless touch mostly USB drivers.
>
> thanks,
>
> Heikki Krogerus (5):
>   acpi: Export acpi_bus_type
>   acpi: Store CRC-32 hash of the _PLD in struct acpi_device
>   usb: Link the ports to the connectors they are attached to
>   usb: typec: port-mapper: Convert to the component framework
>   usb: Remove usb_for_each_port()
>
>  Documentation/ABI/testing/sysfs-bus-usb |   9 +
>  drivers/acpi/bus.c                      |   1 +
>  drivers/acpi/scan.c                     |  16 ++
>  drivers/usb/core/port.c                 |  32 +++
>  drivers/usb/core/usb.c                  |  46 ----
>  drivers/usb/typec/Makefile              |   3 +-
>  drivers/usb/typec/class.c               |   2 -
>  drivers/usb/typec/class.h               |  10 +-
>  drivers/usb/typec/port-mapper.c         | 279 ++++--------------------
>  include/acpi/acpi_bus.h                 |   1 +
>  include/linux/usb.h                     |   9 -
>  include/linux/usb/typec.h               |  12 -
>  12 files changed, 105 insertions(+), 315 deletions(-)
>
> --
> 2.34.1
>
