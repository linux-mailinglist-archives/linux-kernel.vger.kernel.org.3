Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 590DB4FBAE5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 13:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235887AbiDKLcG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 07:32:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234457AbiDKLcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 07:32:04 -0400
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 264483EF3D;
        Mon, 11 Apr 2022 04:29:47 -0700 (PDT)
Received: by mail-yb1-f175.google.com with SMTP id t12so6379000ybt.10;
        Mon, 11 Apr 2022 04:29:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wPfh2b3MSo8EtzyqRm45I0kme5Bj24uZnA2dVJHDBqY=;
        b=59SHDFMDbTdV2wsGl76YrcYoyEkpTKHoFxlBJB2s1BlcxO2Ps3btFCYQvTOa2yN5lL
         W9Eke702cr6dWvFj7fV9zHvh2PPWuNetMf7MP2oR3axis0gPbSFWOayJ1dES8JoJeSqt
         rgEtrPimoVY4xK4OjDZShACGrRvb7vArlBDn15Wdl2DD38Iyi4hw8i/vV1hLc0OarJ5E
         O3CSC23M6B6AQ8GiwP9hHA+8sc1+xmMxOPjyQiPwB/uZVyC0wBj+8ZRd6+mUAZnnIJ+/
         5l5SAFVlNLtYeJGJAQILdb9wj7muudGN0ztc55whpfdJ7pYIGcbdOCKnorMWlPBC3TOr
         5XpA==
X-Gm-Message-State: AOAM530n0M7g6FW071Y3Kk86vvRNt0KioKD8TOC8daDFBiP/AUcEamap
        e0zmjzpnwErcjXS8YOueRMdNDCphEOWjGsDOqYE=
X-Google-Smtp-Source: ABdhPJynVaCSGdTcwySWkkFMTdN+kUa+og8pNv/S4Hq3zWxI/D99qBqMrNmQiLmr7GodBZNBGqyBc4aE/AJGEZ4DC6I=
X-Received: by 2002:a25:230d:0:b0:641:375c:b5ad with SMTP id
 j13-20020a25230d000000b00641375cb5admr5185825ybj.137.1649676586309; Mon, 11
 Apr 2022 04:29:46 -0700 (PDT)
MIME-Version: 1.0
References: <1836398.tdWV9SEqCh@kreacher> <CAPDyKFoop_mtWV0i+fH8GSmaxbPCyCPmOeNi6GuK5Qrj7ZVo1g@mail.gmail.com>
 <CAJZ5v0geG77Npdy_Ae7XnpWukPPSJ1nE0DFF-vbJViKj6GtCWA@mail.gmail.com> <CAPDyKFo9t__WV00yp5gt+M0BhYtgJU2HmKXF2fXEDtjvSEUhhw@mail.gmail.com>
In-Reply-To: <CAPDyKFo9t__WV00yp5gt+M0BhYtgJU2HmKXF2fXEDtjvSEUhhw@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 11 Apr 2022 13:29:31 +0200
Message-ID: <CAJZ5v0jFA0Yi-4L6WQmcX5A-4_t1PTtEyFU7JRceKjr8UXgj_g@mail.gmail.com>
Subject: Re: [PATCH v1] PM: runtime: Avoid device usage count underflows
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>
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

On Mon, Apr 11, 2022 at 12:36 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Fri, 8 Apr 2022 at 19:05, Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Fri, Apr 8, 2022 at 4:05 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > >
> > > On Wed, 6 Apr 2022 at 21:03, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > > >
> > > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > >
> > > > A PM-runtime device usage count underflow is potentially critical,
> > > > because it may cause a device to be suspended when it is expected to
> > > > be operational.
> > >
> > > I get the point. Although, perhaps we should also state that it's a
> > > programming problem that we would like to catch and warn about?
> >
> > OK, I can add that to the changelog.
> >
> > > >
> > > > For this reason, (1) make rpm_check_suspend_allowed() return an error
> > > > when the device usage count is negative to prevent devices from being
> > > > suspended in that case, (2) introduce rpm_drop_usage_count() that will
> > > > detect device usage count underflows, warn about them and fix them up,
> > > > and (3) use it to drop the usage count in a few places instead of
> > > > atomic_dec_and_test().
> > > >
> > > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > ---
> > > >  drivers/base/power/runtime.c |   44 ++++++++++++++++++++++++++++++++++++-------
> > > >  1 file changed, 37 insertions(+), 7 deletions(-)
> > > >
> > > > Index: linux-pm/drivers/base/power/runtime.c
> > > > ===================================================================
> > > > --- linux-pm.orig/drivers/base/power/runtime.c
> > > > +++ linux-pm/drivers/base/power/runtime.c
> > > > @@ -263,7 +263,7 @@ static int rpm_check_suspend_allowed(str
> > > >                 retval = -EINVAL;
> > > >         else if (dev->power.disable_depth > 0)
> > > >                 retval = -EACCES;
> > > > -       else if (atomic_read(&dev->power.usage_count) > 0)
> > > > +       else if (atomic_read(&dev->power.usage_count))
> > > >                 retval = -EAGAIN;
> > > >         else if (!dev->power.ignore_children &&
> > > >                         atomic_read(&dev->power.child_count))
> > > > @@ -1039,13 +1039,33 @@ int pm_schedule_suspend(struct device *d
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(pm_schedule_suspend);
> > > >
> > > > +static int rpm_drop_usage_count(struct device *dev)
> > > > +{
> > > > +       int ret;
> > > > +
> > > > +       ret = atomic_sub_return(1, &dev->power.usage_count);
> > > > +       if (ret >= 0)
> > > > +               return ret;
> > > > +
> > > > +       /*
> > > > +        * Because rpm_resume() does not check the usage counter, it will resume
> > > > +        * the device even if the usage counter is 0 or negative, so it is
> > > > +        * sufficient to increment the usage counter here to reverse the change
> > > > +        * made above.
> > > > +        */
> > > > +       atomic_inc(&dev->power.usage_count);
> > >
> > > Rather than this two-step process, couldn't we just do an
> > > "atomic_add_unless(&dev->power.usage_count, -1, 0)" - and check the
> > > return value?
> >
> > No, we couldn't, because atomic_add_unless() returns a bool and we
> > need to know the new counter value (and in particular whether or not
> > it is 0).
>
> atomic_add_unless(&dev->power.usage_count, -1, 0) would return true as
> long as the counter value is greater than 0.

Yes, and it in particular, when the current value of the counter is 1
before the operation IIUC.

So after the operation it is 0 and true will be returned, won't it?
But that's exactly the case we want to catch.

> If the counter has become 0, atomic_add_unless() would return false
> and not continue to decrease the value below zero. Isn't this exactly
> what we want?

Not really.

We want to detect transitions from 0 to 1 which is the case when the
device can be suspended.
