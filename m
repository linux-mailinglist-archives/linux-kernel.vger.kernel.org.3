Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A68464756FD
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 11:56:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241827AbhLOK4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 05:56:38 -0500
Received: from mail-ot1-f43.google.com ([209.85.210.43]:33699 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241810AbhLOK4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 05:56:37 -0500
Received: by mail-ot1-f43.google.com with SMTP id 35-20020a9d08a6000000b00579cd5e605eso24496980otf.0;
        Wed, 15 Dec 2021 02:56:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c+b6o2kT50XjdF2Qu7E5BjAnXipgwhkkAIzs/MBlias=;
        b=m6voVRwI4246ZqQvAW45aAYJ/+fnritHQxtddZUHDfukKPrbs+uO1ITguZ4ahTkMw2
         MMXNpSTfbG1igXgz2Qt6IAoJojQw7wJwH2nDBH3a+tqcGz8jOnJVfLZmoynVEYjrzCLk
         VotlkKEijDNHx+Pfdb4iSp2/CzJAP0VK9SZgUtmknIVHkEp3KaJE64jV6u9dS3bxMhvH
         L1ZxqCaybVBZTQCpbIdCZ8KKan3P0Of5jhC8ydYEZQzaXWSslLnD788VFXDxmpyWi6mA
         W+rB1zQCTUEZkSs2kfcTgogcAKVwkxUCN8kDaidGMyUeVpiwgsUFX+ZpnL8qbPWpqWWT
         76gQ==
X-Gm-Message-State: AOAM532lz7etEtYMqUV75SdhqiDN9u03UfrISTK8y1h8BJ3ms/1pwvuS
        t3Yl5u40Clm4FotkUxzVVB+/E2PUxe40LDA33KI5Ffj5
X-Google-Smtp-Source: ABdhPJzOKBewyc1EJTNidGydsTDLgPpVQPsCNiOckKPdNK5qGAgB5i204gc3Tmoz8yMpWLqqgsXlSdIoPkJ9mhpu2QU=
X-Received: by 2002:a9d:4c10:: with SMTP id l16mr8244269otf.198.1639565796648;
 Wed, 15 Dec 2021 02:56:36 -0800 (PST)
MIME-Version: 1.0
References: <20211213103243.33657-1-heikki.krogerus@linux.intel.com>
In-Reply-To: <20211213103243.33657-1-heikki.krogerus@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 15 Dec 2021 11:56:25 +0100
Message-ID: <CAJZ5v0gFVQanDYwLFe6GFo2uYOHurrXka2c64n_4rvzPPts-MQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] acpi: Store _PLD information and convert users
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

On Mon, Dec 13, 2021 at 11:32 AM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> Hi,
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
> Rafael, is it still OK if Greg takes these?

It is in general, but let me look at the changes in scan.c in particular.
