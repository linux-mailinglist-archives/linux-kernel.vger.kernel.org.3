Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 447AA4A71CA
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 14:45:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242108AbiBBNpK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 08:45:10 -0500
Received: from mail-yb1-f174.google.com ([209.85.219.174]:42739 "EHLO
        mail-yb1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbiBBNpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 08:45:08 -0500
Received: by mail-yb1-f174.google.com with SMTP id m6so61096233ybc.9;
        Wed, 02 Feb 2022 05:45:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uB/YVoClaRjty4b1DpQC/jyBIC7Zl/3uSSAzUawr1v0=;
        b=rhOQszFJr7z/HKf0/60fgYGlRJfqq7b7PWc9tJgTiSJNHUyICQk7H+D79fGZFImsp9
         LpQSgVcZniiwMNsOTqNPMzkByy+7++GDvGVkT+qcsdIb6HO9GrWeX4vuCPPDbAxkMvdU
         4x0DVkYwsYdzC2PQCdrtDzmZFWuG06yUhTBKArssRT14W2R74Ys+orPBBNkB12vBZe8e
         lHGp6NV5BWL4FkEtWRNxUHGlzaPXbj+l1XS/uJoFs3a+p8+s4SUJWsI4vKOGlyM+byZ9
         PN/x/YChp5WLavy42oivGSwOnGdzZ4tm0rlEEj2DnoUh5b+/r500Q0dOngUT9TkObxwv
         0iLA==
X-Gm-Message-State: AOAM532Bl1RwY3nQzhXrq8tu6M0cQw1dvuIBSmvKN/SeTwl+m17mGF+E
        LfLDixbHXqnn7y6C03h/DDEDimJPH2v5pHeVbuU=
X-Google-Smtp-Source: ABdhPJwm4b9rkjIKnZ+Mj/K6IFCtS7kkWBU4vRKOS00anGZHGLtiMuT3CglGBQUdfLldvS5HYBkq+Zn7PDufytBd0/c=
X-Received: by 2002:a05:6902:1507:: with SMTP id q7mr44523541ybu.343.1643809508235;
 Wed, 02 Feb 2022 05:45:08 -0800 (PST)
MIME-Version: 1.0
References: <5790600.lOV4Wx5bFT@kreacher> <fca634ba-a05a-10e3-4c12-8774c49a91fe@arm.com>
In-Reply-To: <fca634ba-a05a-10e3-4c12-8774c49a91fe@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 2 Feb 2022 14:44:56 +0100
Message-ID: <CAJZ5v0gKqhTD_ECRNVecmR_Lv_jRDn_LdszBRWwBwmD+75Mq4A@mail.gmail.com>
Subject: Re: [PATCH] hwtracing: coresight: Replace acpi_bus_get_device()
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 2, 2022 at 12:43 PM Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>
> Hi Rafael
>
> On 01/02/2022 17:58, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Replace acpi_bus_get_device() that is going to be dropped with
> > acpi_fetch_acpi_dev().
> >
> > No intentional functional impact.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
>
> > ---
> >   drivers/hwtracing/coresight/coresight-platform.c |    8 ++++----
> >   1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > Index: linux-pm/drivers/hwtracing/coresight/coresight-platform.c
> > ===================================================================
> > --- linux-pm.orig/drivers/hwtracing/coresight/coresight-platform.c
> > +++ linux-pm/drivers/hwtracing/coresight/coresight-platform.c
> > @@ -626,7 +626,7 @@ static int acpi_coresight_parse_link(str
> >                                    const union acpi_object *link,
> >                                    struct coresight_connection *conn)
> >   {
> > -     int rc, dir;
> > +     int dir;
> >       const union acpi_object *fields;
> >       struct acpi_device *r_adev;
> >       struct device *rdev;
> > @@ -643,9 +643,9 @@ static int acpi_coresight_parse_link(str
> >           fields[3].type != ACPI_TYPE_INTEGER)
> >               return -EINVAL;
> >
> > -     rc = acpi_bus_get_device(fields[2].reference.handle, &r_adev);
> > -     if (rc)
> > -             return rc;
> > +     r_adev = acpi_fetch_acpi_dev(fields[2].reference.handle);
> > +     if (!r_adev)
> > +             return -ENODEV;
> >
>
> Is this patch part of a series ?

No, it isn't.

> I don't see acpi_fetch_acpi_dev() in v5.17-rc1, which our tree is based on at the moment.

acpi_fetch_acpi_dev() is there in v5.17-rc1.  Please see

https://elixir.bootlin.com/linux/v5.17-rc1/A/ident/acpi_fetch_acpi_dev

> Please could you point us to the changes ?
>
> Also do you expect to pull this via your tree ?

I can route it via the ACPI tree, but it may as well be routed along
with other coresight-platform.c changes, if any.
