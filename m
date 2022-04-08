Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 525DC4F9B4E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 19:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238033AbiDHRHf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 13:07:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231408AbiDHRHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 13:07:31 -0400
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB4EE954A5;
        Fri,  8 Apr 2022 10:05:27 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-2e5e9025c20so103262397b3.7;
        Fri, 08 Apr 2022 10:05:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=45ajIdk2l2c0M5NveToHn951KWa5S8n2FWsDAPcmgKU=;
        b=0klrK9fRKPYWMBs3PBjLWWwqAcJqTt0olnO57GYtz+8yUowj2Z5DHfOEt6cIQoAv19
         saSsmdwlK3zFXC2vpClmqZB0WcrskONg+mBGiyXUkW+S7+qNpvTo+KoXHgAK0iCSQ85K
         ru2TXJRwc9YKP7O8a85GVYAld+xv+zmKnzqVpgNFZlqf4D1piM+E9cotfdlMqTQ5LpVP
         1Yoq2qni7Ht9qoAAO5pqHhgJwmOCVHjk/nwMB9M5c9g/ji/5bu1neqqxgiNp955tfnaC
         M+R1KiOekJuldhk/NE92//TpVrIS/MqjY5zFeFlh/tkSm7aWk3qrIdJmTcrpeN/cNGaO
         VEAw==
X-Gm-Message-State: AOAM533ES3EIfLKVrSzw2cq2Apd+5RI3WpJSwO5tWF/hJfQibRVq2onc
        9Hozd04LPJOyiVLYkoPTHwlNj84uU4Lup8zF1CtGglCe
X-Google-Smtp-Source: ABdhPJwzJmUXNZljhLVAbirtIjqZ86JwGDWwbosbLX/f9YRBll8DfQDLxg3nGM8wY9C3iEuhCi1/SpLszEZSvG8phR8=
X-Received: by 2002:a81:7c45:0:b0:2eb:4759:cc32 with SMTP id
 x66-20020a817c45000000b002eb4759cc32mr16984331ywc.515.1649437526843; Fri, 08
 Apr 2022 10:05:26 -0700 (PDT)
MIME-Version: 1.0
References: <1836398.tdWV9SEqCh@kreacher> <CAPDyKFoop_mtWV0i+fH8GSmaxbPCyCPmOeNi6GuK5Qrj7ZVo1g@mail.gmail.com>
In-Reply-To: <CAPDyKFoop_mtWV0i+fH8GSmaxbPCyCPmOeNi6GuK5Qrj7ZVo1g@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 8 Apr 2022 19:05:16 +0200
Message-ID: <CAJZ5v0geG77Npdy_Ae7XnpWukPPSJ1nE0DFF-vbJViKj6GtCWA@mail.gmail.com>
Subject: Re: [PATCH v1] PM: runtime: Avoid device usage count underflows
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
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

On Fri, Apr 8, 2022 at 4:05 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Wed, 6 Apr 2022 at 21:03, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > A PM-runtime device usage count underflow is potentially critical,
> > because it may cause a device to be suspended when it is expected to
> > be operational.
>
> I get the point. Although, perhaps we should also state that it's a
> programming problem that we would like to catch and warn about?

OK, I can add that to the changelog.

> >
> > For this reason, (1) make rpm_check_suspend_allowed() return an error
> > when the device usage count is negative to prevent devices from being
> > suspended in that case, (2) introduce rpm_drop_usage_count() that will
> > detect device usage count underflows, warn about them and fix them up,
> > and (3) use it to drop the usage count in a few places instead of
> > atomic_dec_and_test().
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  drivers/base/power/runtime.c |   44 ++++++++++++++++++++++++++++++++++++-------
> >  1 file changed, 37 insertions(+), 7 deletions(-)
> >
> > Index: linux-pm/drivers/base/power/runtime.c
> > ===================================================================
> > --- linux-pm.orig/drivers/base/power/runtime.c
> > +++ linux-pm/drivers/base/power/runtime.c
> > @@ -263,7 +263,7 @@ static int rpm_check_suspend_allowed(str
> >                 retval = -EINVAL;
> >         else if (dev->power.disable_depth > 0)
> >                 retval = -EACCES;
> > -       else if (atomic_read(&dev->power.usage_count) > 0)
> > +       else if (atomic_read(&dev->power.usage_count))
> >                 retval = -EAGAIN;
> >         else if (!dev->power.ignore_children &&
> >                         atomic_read(&dev->power.child_count))
> > @@ -1039,13 +1039,33 @@ int pm_schedule_suspend(struct device *d
> >  }
> >  EXPORT_SYMBOL_GPL(pm_schedule_suspend);
> >
> > +static int rpm_drop_usage_count(struct device *dev)
> > +{
> > +       int ret;
> > +
> > +       ret = atomic_sub_return(1, &dev->power.usage_count);
> > +       if (ret >= 0)
> > +               return ret;
> > +
> > +       /*
> > +        * Because rpm_resume() does not check the usage counter, it will resume
> > +        * the device even if the usage counter is 0 or negative, so it is
> > +        * sufficient to increment the usage counter here to reverse the change
> > +        * made above.
> > +        */
> > +       atomic_inc(&dev->power.usage_count);
>
> Rather than this two-step process, couldn't we just do an
> "atomic_add_unless(&dev->power.usage_count, -1, 0)" - and check the
> return value?

No, we couldn't, because atomic_add_unless() returns a bool and we
need to know the new counter value (and in particular whether or not
it is 0).

I thought that it would be better to do the extra access in the
failing case only.

> > +       dev_warn(dev, "Runtime PM usage count underflow!\n");
> > +       return -EINVAL;
> > +}
> > +
>
> [...]
