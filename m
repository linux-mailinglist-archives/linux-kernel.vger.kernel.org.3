Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C3EC50BC69
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 18:00:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1449541AbiDVQDi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 12:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237777AbiDVQDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 12:03:32 -0400
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24B794093E;
        Fri, 22 Apr 2022 09:00:39 -0700 (PDT)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-2f7bb893309so10108597b3.12;
        Fri, 22 Apr 2022 09:00:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m9bkzyI4UcgZkY7b6xlAg7lN+vGGFzqYyYOt4tU1Pyw=;
        b=c+IgWHD2ofsfGvyRHIeuWRr1L9V11NprzYtXPlIwPs1H7PyEH0Zx70CsGqXWKsfVwz
         24ug21e9/TL7nIJnSI/erLkxP+hNVb4MEkqcz24ZGplPk+Aq2InEvsJBBIhuSaLhSetd
         jmA037XuEd1L/y7vLu4XhWk7XKyguFZ0xXHzbo9aiF0dTyYDhfuhHYrS6skBDRDxpx4B
         W0LEmEsm/9eck3aL6qRmu+FdpPYzJsY4nMInn0Y67mGh/t7Z8SoVV1ehbB1p8D5191ZV
         bbOTV3MPhTcZvJSeyFk5g5vA6bULn7Q0+7TMFPzSYYpN6eGSW04ly/hGsiM3m8bqyh2v
         OAig==
X-Gm-Message-State: AOAM5300uNYYhg8uR0KtRHipFrOiZFD/9hMwSE090wShT7VlDtXbyOCQ
        TM/KOaZOjGWrC8RsDmoPWXXHgOfF9cP6U932FUQ=
X-Google-Smtp-Source: ABdhPJzcTeaR74zkfAgbCOSAoahcKgBRrTmEHW+UzQAI3jblvwcpMq2LAMJBnpdtBFN9J51/C8Sop9emVbBu0WT0qjM=
X-Received: by 2002:a0d:e645:0:b0:2f4:dbd6:261e with SMTP id
 p66-20020a0de645000000b002f4dbd6261emr5681151ywe.7.1650643238361; Fri, 22 Apr
 2022 09:00:38 -0700 (PDT)
MIME-Version: 1.0
References: <11974495.O9o76ZdvQC@kreacher> <YmLJEtDFhc3HFg3/@lahna>
In-Reply-To: <YmLJEtDFhc3HFg3/@lahna>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 22 Apr 2022 18:00:27 +0200
Message-ID: <CAJZ5v0iA-9NFWsxrGZFN4ZeQBHDVniTNtw5HKGa+WKAdUZa02g@mail.gmail.com>
Subject: Re: [PATCH] ACPI: bus: Avoid non-ACPI device objects in walks over children
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22, 2022 at 5:27 PM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> Hi Rafael,
>
> On Fri, Apr 22, 2022 at 05:13:48PM +0200, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > When walking the children of an ACPI device, take extra care to avoid
> > using to_acpi_device() on the ones that are not ACPI devices, because
> > that may lead to out-of-bounds access and memory corruption.
> >
> > While at it, make the function passed to acpi_dev_for_each_child()
> > take a struct acpi_device pointer argument (instead of a struct device
> > one), so it is more straightforward to use.
> >
> > Fixes: b7dd6298db81 ("ACPI: PM: Introduce acpi_dev_power_up_children_with_adr()")
> > Reported-by: kernel test robot <oliver.sang@intel.com>
> > BugLink: https://lore.kernel.org/lkml/20220420064725.GB16310@xsang-OptiPlex-9020/
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >
> > The commit being fixed is present in linux-next.
> >
> > ---
> >  drivers/acpi/bus.c       |   24 ++++++++++++++++++++++--
> >  drivers/acpi/device_pm.c |    5 +----
> >  include/acpi/acpi_bus.h  |    2 +-
> >  3 files changed, 24 insertions(+), 7 deletions(-)
> >
> > Index: linux-pm/drivers/acpi/bus.c
> > ===================================================================
> > --- linux-pm.orig/drivers/acpi/bus.c
> > +++ linux-pm/drivers/acpi/bus.c
> > @@ -1070,10 +1070,30 @@ int acpi_bus_for_each_dev(int (*fn)(stru
> >  }
> >  EXPORT_SYMBOL_GPL(acpi_bus_for_each_dev);
> >
> > +struct acpi_dev_walk_context {
> > +     int (*fn)(struct acpi_device *, void *);
> > +     void *data;
> > +};
> > +
> > +static int acpi_dev_for_one_check(struct device *dev, void *context)
> > +{
> > +     struct acpi_dev_walk_context *adwc = context;
> > +
> > +     if (dev->bus != &acpi_bus_type)
> > +             return 0;
>
> I wonder if it make sense to add dev_is_acpi() that does the above
> analoguos to dev_is_pci()?

I thought about that, but this is the only place where it would be
needed ATM, so for now this isn't necessary.

> Regardless of that,
>
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Thanks!
