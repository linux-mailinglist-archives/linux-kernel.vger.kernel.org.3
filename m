Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AED04A7631
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 17:49:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346029AbiBBQtK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 11:49:10 -0500
Received: from mail-yb1-f182.google.com ([209.85.219.182]:33728 "EHLO
        mail-yb1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236171AbiBBQtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 11:49:08 -0500
Received: by mail-yb1-f182.google.com with SMTP id j2so622673ybu.0;
        Wed, 02 Feb 2022 08:49:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=no9drO4AwVZVF+z4nTPpFt+6o0kRfm9YBUAgclW1DkU=;
        b=Yq1R3q1kBXwUs1T52kQiNKcMkRhwV2D6v2mgWiz9oNtwMNaqpgxaxKgJr370uUnT3y
         c0375nUH2uu+mm5fwZmXjIPQ1Y8QXVxBES0GSYsufyCVmbQjSA0RXhiGBEQRHwpx1XAC
         eWjPvIUwZqPBEce4BUWRGKVv8L68z+P+U86Fydc5tXybcz6cG67AvxOmMZoiOaB93fR6
         X1a/bs/M122FEUtzSTDtbX4i8NIvjl2//0YxnAwreutxId36yDfRyJruq3GTs3z+vnc+
         AydGMvqfTvZ2ih3P6WEUFFg4FoDpWti3rlSopErZSJj+BvCQ9ji6VaW/CwsXiz22WOLx
         cpKQ==
X-Gm-Message-State: AOAM532KNRcCgZ4fZ77I1W2Jv8A/cAsKPG1vcVn2vB3uj4/USigxTDWT
        osPyWE1tVXgjBM1Pclg+sbgFHyvQiUcFRhfeDCU=
X-Google-Smtp-Source: ABdhPJxhZWYXfLZSijf7rKMkiV9ag1pks2Uj7sioBdAzbrDzK5HXWPRSSb4myIx0NcdWihu8WtIoOTtltQNi+SP7VZk=
X-Received: by 2002:a81:1e05:: with SMTP id e5mr1707964ywe.470.1643820547560;
 Wed, 02 Feb 2022 08:49:07 -0800 (PST)
MIME-Version: 1.0
References: <5790600.lOV4Wx5bFT@kreacher> <fca634ba-a05a-10e3-4c12-8774c49a91fe@arm.com>
 <CAJZ5v0gKqhTD_ECRNVecmR_Lv_jRDn_LdszBRWwBwmD+75Mq4A@mail.gmail.com> <bb710dea-d8a8-f048-4ee4-0004a72e76ad@arm.com>
In-Reply-To: <bb710dea-d8a8-f048-4ee4-0004a72e76ad@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 2 Feb 2022 17:48:56 +0100
Message-ID: <CAJZ5v0gt-3YMpJeqjaA==tk6VMhwF53ApQfU6_=9q1s47y-fHQ@mail.gmail.com>
Subject: Re: [PATCH] hwtracing: coresight: Replace acpi_bus_get_device()
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
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

On Wed, Feb 2, 2022 at 5:46 PM Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>
> On 02/02/2022 13:44, Rafael J. Wysocki wrote:
> > On Wed, Feb 2, 2022 at 12:43 PM Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
> >>
> >> Hi Rafael
> >>
> >> On 01/02/2022 17:58, Rafael J. Wysocki wrote:
> >>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >>>
> >>> Replace acpi_bus_get_device() that is going to be dropped with
> >>> acpi_fetch_acpi_dev().
> >>>
> >>> No intentional functional impact.
> >>>
> >>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >>
> >>
> >>> ---
> >>>    drivers/hwtracing/coresight/coresight-platform.c |    8 ++++----
> >>>    1 file changed, 4 insertions(+), 4 deletions(-)
> >>>
> >>> Index: linux-pm/drivers/hwtracing/coresight/coresight-platform.c
> >>> ===================================================================
> >>> --- linux-pm.orig/drivers/hwtracing/coresight/coresight-platform.c
> >>> +++ linux-pm/drivers/hwtracing/coresight/coresight-platform.c
> >>> @@ -626,7 +626,7 @@ static int acpi_coresight_parse_link(str
> >>>                                     const union acpi_object *link,
> >>>                                     struct coresight_connection *conn)
> >>>    {
> >>> -     int rc, dir;
> >>> +     int dir;
> >>>        const union acpi_object *fields;
> >>>        struct acpi_device *r_adev;
> >>>        struct device *rdev;
> >>> @@ -643,9 +643,9 @@ static int acpi_coresight_parse_link(str
> >>>            fields[3].type != ACPI_TYPE_INTEGER)
> >>>                return -EINVAL;
> >>>
> >>> -     rc = acpi_bus_get_device(fields[2].reference.handle, &r_adev);
> >>> -     if (rc)
> >>> -             return rc;
> >>> +     r_adev = acpi_fetch_acpi_dev(fields[2].reference.handle);
> >>> +     if (!r_adev)
> >>> +             return -ENODEV;
> >>>
> >>
> >> Is this patch part of a series ?
> >
> > No, it isn't.
> >
> >> I don't see acpi_fetch_acpi_dev() in v5.17-rc1, which our tree is based on at the moment.
> >
> > acpi_fetch_acpi_dev() is there in v5.17-rc1.  Please see
> >
> > https://elixir.bootlin.com/linux/v5.17-rc1/A/ident/acpi_fetch_acpi_dev
> >
> >> Please could you point us to the changes ?
> >>
> >> Also do you expect to pull this via your tree ?
> >
> > I can route it via the ACPI tree, but it may as well be routed along
> > with other coresight-platform.c changes, if any.
>
> Apologies, obviously, I was looking at the wrong tree. I will queue this

Thanks!
