Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85D215450FC
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 17:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344544AbiFIPhh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 11:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344529AbiFIPhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 11:37:33 -0400
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F8B09CF15;
        Thu,  9 Jun 2022 08:37:31 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id g201so14560980ybf.12;
        Thu, 09 Jun 2022 08:37:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oP68gQ771+clRj4cFwUH0Ec4RApgtfD1Z4Jp2OZ6o3Q=;
        b=KTZOd3Lx6qgH3bZ2+CKWKw7kX1GXH8dj0QuBGSNozzHtcZBpCHb+giK9N90t+BHW1B
         ImPveg3UN3MFA53ux9XrJ6XTr/hx8uZTN3Nwkji6QCarMw+ENff0nqPOnMrG+QuVZnLS
         ZcbFWKuj2PABFa4QMHcAxrhgVsy1/K6tciZlKSFUfyMTtMThnyYQponF1oDye4aB0X1K
         uAzEBmiDcqY9hGAxDbG62Ub4L3N4v53iQq3tAeQYUZvo4XZ8PU21VVZShMx4gX7tICSQ
         pNWM/4Fc1WcEFcrsALEnCPmlmxXteWU/DrWl7axLudmD0AtDlDYYYTD9JGruYAtI2nyY
         VD9g==
X-Gm-Message-State: AOAM5304EDvfEEZvLAJtKtSHIaUdr329zjXEAeMHkSEY13FGK2jjBKF9
        dfzT8eR/6QT4pv/Ra0gvLAxMYWCGpQtADmkQ2gI=
X-Google-Smtp-Source: ABdhPJzewuSOGAz8uuz8IRC17huvxlqga12v+Ajz4GI+XfrmsGBeAKa5h8WcMA1Xq9aH/3UoFoD/f99MKmoBn/47fYk=
X-Received: by 2002:a5b:4a:0:b0:663:7c5b:a5ba with SMTP id e10-20020a5b004a000000b006637c5ba5bamr21326407ybp.81.1654789050580;
 Thu, 09 Jun 2022 08:37:30 -0700 (PDT)
MIME-Version: 1.0
References: <1843211.tdWV9SEqCh@kreacher> <3459925.iIbC2pHGDl@kreacher> <YqIRaLdifSnEUN7H@smile.fi.intel.com>
In-Reply-To: <YqIRaLdifSnEUN7H@smile.fi.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 9 Jun 2022 17:37:19 +0200
Message-ID: <CAJZ5v0iezaNmhRUp=rm88xgp2kQqyyUn_v8szFDWuEHmSEABQg@mail.gmail.com>
Subject: Re: [PATCH v1 05/16] USB: ACPI: Use acpi_find_child_by_adr()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        "open list:ULTRA-WIDEBAND (UWB) SUBSYSTEM:" 
        <linux-usb@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 9, 2022 at 5:27 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Jun 09, 2022 at 03:56:42PM +0200, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Instead of walking the list of children of an ACPI device directly
> > in order to find the child matching a given bus address, use
> > acpi_find_child_by_adr() for this purpose.
>
> ...
>
> >       if (!parent)
> >               return NULL;
>
> Can be removed because it's embedded in the call below, no?

Yes, it can, in analogy with the thunderbolt code.  Will update.

> > +     return acpi_find_child_by_adr(parent, raw);
>
> --
