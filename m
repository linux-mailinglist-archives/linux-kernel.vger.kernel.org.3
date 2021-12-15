Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9DDA475B13
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 15:52:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243499AbhLOOw2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 09:52:28 -0500
Received: from mail-oi1-f169.google.com ([209.85.167.169]:36412 "EHLO
        mail-oi1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237842AbhLOOwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 09:52:24 -0500
Received: by mail-oi1-f169.google.com with SMTP id t23so32002894oiw.3;
        Wed, 15 Dec 2021 06:52:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z1up0j7hF/rulik3lRaD24Z6MuUYNaFHV9krTlOBx4A=;
        b=d33rXfN4sbzoaLJVHO0iIoBrGbM2y8M5Ff5MA3t2tBdmV/WwGAYE+j4KiwA1JiOKTk
         avfCizb8sLVwvxgXqOl6Oe76JieZvqZBURhrJV5VrmxSi/hU4nqWdkQrFqD611dO0Ub4
         vo15SRMhbk4sLQAeGWaM77thahDV8QysXZi2EiTIaDIwAzgjsCAA8LLvCijMf9QyOZyv
         8wWlSBF7+FL/geGGluOPJ6rjgdRkreOOkAPM66aF1MuX0I0jLPPlpZEe27tPTgEwKOtD
         SpFTK5vI6gnnkajbeymM1/egTOnG6iGecdlKW2H58ljVzxTfp5LAz2wYcHtc/YhhY4Iu
         fyZg==
X-Gm-Message-State: AOAM530sE+4h1mbinuIA8OsusTzXQdQsfWgs6MNeCNIrZwEyjFowikAj
        A7olQ3Q6u9liHK+Le64Gulz1xstwxRnWmZ6/WDE=
X-Google-Smtp-Source: ABdhPJw8i33FspLIffQinoU6FdTktEhVP9lRVkbZmJZwncQv3RzUzvVSnU9wWIeXS4cV/UHKAONNMnhIOBhnU2RqwI4=
X-Received: by 2002:a05:6808:1454:: with SMTP id x20mr110728oiv.166.1639579944358;
 Wed, 15 Dec 2021 06:52:24 -0800 (PST)
MIME-Version: 1.0
References: <20211213103243.33657-1-heikki.krogerus@linux.intel.com>
 <20211213103243.33657-2-heikki.krogerus@linux.intel.com> <CAJZ5v0jq5ve9+V3k5Vi=vJAheSyQbAsNmi6An9=oKxkyVed5bw@mail.gmail.com>
 <Ybnoy9e6VvFsJ4b1@kuha.fi.intel.com>
In-Reply-To: <Ybnoy9e6VvFsJ4b1@kuha.fi.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 15 Dec 2021 15:52:12 +0100
Message-ID: <CAJZ5v0hiv18Ri5Vi4Y07bXRO9+Qf5bZ+TwmqwRG3spr9nzV0MA@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] acpi: Store the Physical Location of Device (_PLD) information
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

On Wed, Dec 15, 2021 at 2:08 PM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> Hi Rafael,
>
> On Wed, Dec 15, 2021 at 12:43:48PM +0100, Rafael J. Wysocki wrote:
> > One overall problem I see here is that it potentially stores a bunch
> > of _PLD buffers that will never be used, which is a waste of memory.
> >
> > It may be better to make acpi_device_get_location() evaluate _PLD for
> > the target device if it cannot be found in the list and either update
> > one of the existing entries if the crc matches and return the pld data
> > from there, or add a new item to the list and return its pld data.
>
> The primary goal of this series is actually to see the other devices
> that share a fixed location with our device.

It would be good to mention that in the changelog then.

> The _PLD buffer cache
> would be nice, but not necessary. We don't have to store the _PLD
> buffer itself as part of the location structure at all if that's a
> problem.

It may be cached on the first invocation of acpi_device_get_location()
too, but I'm not sure how much overhead would be avoided by doing
that.  I guess it would make most sense in the shared _PLD case.

> I'll make the change.

OK
