Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1E944FBC28
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 14:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346121AbiDKMfk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 08:35:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243553AbiDKMfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 08:35:37 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EE423ED1B
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 05:33:23 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id h14so21212507lfl.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 05:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OsswnPSPXub36sV27s63KdEV9u3Nc46OaI/VdIunfIY=;
        b=nacSmEU90Z28U9Lo9QsaAtJzu5RtbYx3FHMucZRgfaW1vDSY9I+G7LCU7Ar+Twu6Z5
         BjziRv6TGWlLl3ppx/vX6MfsESbe/KVMTghgOAMNzAMxbj0rWjqbDO6wJ6gxWuK+bW13
         qmv2sjgtNOAzM4NHrIsSf6PslmWpoCzKX//19tQePjv92BE/4Jcb7/6Uwnks0VXAnYjh
         iXaCVpKHnKT3OX8XV7/is1KxcE/dhdSWbIuJnlRJ8qab0LkRwPlJ6JfvyQ9gs9xt2Bfh
         d18+IosnSbAH+FIETShNuVwikb4gJavQTSvMLE8h6aadktpB0ArWj+HUGHwZa2Uzv9fW
         qpBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OsswnPSPXub36sV27s63KdEV9u3Nc46OaI/VdIunfIY=;
        b=iq4RkIA2SoEVx1m/HIsYTSvAUcpiS2h8kurEGyqMiJn2h4zA5Tr+2mqHsyhfJuarJq
         SaVV3ZL56YwmoCFPrhLYltvehilQUrlqQs8LU9oa4ccmLvI1e9DnNx2bQ5rssNQBqh0/
         920Ezl3G8TTuuMB3CeRDCPeKKepg/G1z/4f0zP9rsuFcnEznSGQvWptV+6aHCoDi8rQ5
         SnMvDgS7b8xh/M3rzwNFG7DgTno++8GPIcjEsfkaoYKsBYd2WWzHPhP8fmzqNPnypKVp
         cUtPcmbHLHNmQmq+xR31R3mvY/7KqRHq3mUGlNcVTpcTCJemaiNMVKEDuoaTO8xLDWao
         gu9g==
X-Gm-Message-State: AOAM5309KPqT9BWOGkkgC0LrwPiajcxR88HxEdagNIV+t2RwkaUWvcbY
        SJNDqSQnzYxR5IHdb4S5UovIaV558BWaqa+/MUd3GTWSAEdLpw==
X-Google-Smtp-Source: ABdhPJz8kUWpLqIjtiML9FtVp8iwQ8JIdK3FxyBY/eLAJO5tiLcOHIbU3PpsAHYuyudWDNFWhApGedtxPrnqSwU6avA=
X-Received: by 2002:a19:e007:0:b0:44a:a22d:2d49 with SMTP id
 x7-20020a19e007000000b0044aa22d2d49mr8496790lfg.254.1649680401433; Mon, 11
 Apr 2022 05:33:21 -0700 (PDT)
MIME-Version: 1.0
References: <1836398.tdWV9SEqCh@kreacher> <CAPDyKFoop_mtWV0i+fH8GSmaxbPCyCPmOeNi6GuK5Qrj7ZVo1g@mail.gmail.com>
 <CAJZ5v0geG77Npdy_Ae7XnpWukPPSJ1nE0DFF-vbJViKj6GtCWA@mail.gmail.com>
 <CAPDyKFo9t__WV00yp5gt+M0BhYtgJU2HmKXF2fXEDtjvSEUhhw@mail.gmail.com> <CAJZ5v0jFA0Yi-4L6WQmcX5A-4_t1PTtEyFU7JRceKjr8UXgj_g@mail.gmail.com>
In-Reply-To: <CAJZ5v0jFA0Yi-4L6WQmcX5A-4_t1PTtEyFU7JRceKjr8UXgj_g@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 11 Apr 2022 14:32:44 +0200
Message-ID: <CAPDyKFr6zXcruPHqM2gyLwNPmitXZwRwR7WWyB91Ube1HmtpSg@mail.gmail.com>
Subject: Re: [PATCH v1] PM: runtime: Avoid device usage count underflows
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Apr 2022 at 13:29, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Mon, Apr 11, 2022 at 12:36 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > On Fri, 8 Apr 2022 at 19:05, Rafael J. Wysocki <rafael@kernel.org> wrote:
> > >
> > > On Fri, Apr 8, 2022 at 4:05 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > > >
> > > > On Wed, 6 Apr 2022 at 21:03, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > > > >
> > > > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > >
> > > > > A PM-runtime device usage count underflow is potentially critical,
> > > > > because it may cause a device to be suspended when it is expected to
> > > > > be operational.
> > > >
> > > > I get the point. Although, perhaps we should also state that it's a
> > > > programming problem that we would like to catch and warn about?
> > >
> > > OK, I can add that to the changelog.
> > >
> > > > >
> > > > > For this reason, (1) make rpm_check_suspend_allowed() return an error
> > > > > when the device usage count is negative to prevent devices from being
> > > > > suspended in that case, (2) introduce rpm_drop_usage_count() that will
> > > > > detect device usage count underflows, warn about them and fix them up,
> > > > > and (3) use it to drop the usage count in a few places instead of
> > > > > atomic_dec_and_test().
> > > > >
> > > > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > > ---
> > > > >  drivers/base/power/runtime.c |   44 ++++++++++++++++++++++++++++++++++++-------
> > > > >  1 file changed, 37 insertions(+), 7 deletions(-)
> > > > >
> > > > > Index: linux-pm/drivers/base/power/runtime.c
> > > > > ===================================================================
> > > > > --- linux-pm.orig/drivers/base/power/runtime.c
> > > > > +++ linux-pm/drivers/base/power/runtime.c
> > > > > @@ -263,7 +263,7 @@ static int rpm_check_suspend_allowed(str
> > > > >                 retval = -EINVAL;
> > > > >         else if (dev->power.disable_depth > 0)
> > > > >                 retval = -EACCES;
> > > > > -       else if (atomic_read(&dev->power.usage_count) > 0)
> > > > > +       else if (atomic_read(&dev->power.usage_count))
> > > > >                 retval = -EAGAIN;
> > > > >         else if (!dev->power.ignore_children &&
> > > > >                         atomic_read(&dev->power.child_count))
> > > > > @@ -1039,13 +1039,33 @@ int pm_schedule_suspend(struct device *d
> > > > >  }
> > > > >  EXPORT_SYMBOL_GPL(pm_schedule_suspend);
> > > > >
> > > > > +static int rpm_drop_usage_count(struct device *dev)
> > > > > +{
> > > > > +       int ret;
> > > > > +
> > > > > +       ret = atomic_sub_return(1, &dev->power.usage_count);
> > > > > +       if (ret >= 0)
> > > > > +               return ret;
> > > > > +
> > > > > +       /*
> > > > > +        * Because rpm_resume() does not check the usage counter, it will resume
> > > > > +        * the device even if the usage counter is 0 or negative, so it is
> > > > > +        * sufficient to increment the usage counter here to reverse the change
> > > > > +        * made above.
> > > > > +        */
> > > > > +       atomic_inc(&dev->power.usage_count);
> > > >
> > > > Rather than this two-step process, couldn't we just do an
> > > > "atomic_add_unless(&dev->power.usage_count, -1, 0)" - and check the
> > > > return value?
> > >
> > > No, we couldn't, because atomic_add_unless() returns a bool and we
> > > need to know the new counter value (and in particular whether or not
> > > it is 0).
> >
> > atomic_add_unless(&dev->power.usage_count, -1, 0) would return true as
> > long as the counter value is greater than 0.
>
> Yes, and it in particular, when the current value of the counter is 1
> before the operation IIUC.
>
> So after the operation it is 0 and true will be returned, won't it?
> But that's exactly the case we want to catch.
>
> > If the counter has become 0, atomic_add_unless() would return false
> > and not continue to decrease the value below zero. Isn't this exactly
> > what we want?
>
> Not really.
>
> We want to detect transitions from 0 to 1 which is the case when the
> device can be suspended.

I assume you mean from 1 to 0. In any case, I see what you mean by
now, sorry for the noise.

Then feel free to add:
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe
