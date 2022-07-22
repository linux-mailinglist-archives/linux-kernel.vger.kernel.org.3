Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64B1857E4C9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 18:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236049AbiGVQtt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 12:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235994AbiGVQtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 12:49:36 -0400
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31DEC9C27E;
        Fri, 22 Jul 2022 09:49:29 -0700 (PDT)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-31bf3656517so53509437b3.12;
        Fri, 22 Jul 2022 09:49:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=XlVG1J1L13g8n0Juu1ACYs1Nai1pz7dh7rrSSLxUXqI=;
        b=KHSRknrzqH6ODv/jL23Srrey3xY7tWsSSTNbXf/ZnwmoCIqe9Cw+uVvyQahxvpaNfe
         rmJhFnztQMmVsvoGF5V4/kbznV5aZtn6nWypJ20MeyevjpoitJCNBw8gHT/tL5pTKIyo
         NBB/I1Ca3SWOHh+6VIThPRj4Te+h6zqdHlz6e0gISg8TFoQQX3S9knoDSuYVzU1OibM+
         7hAM/1MJdY78+1GmgpuaxlOD6Z1SDaXqp5hbIunA1C/o1XBJqfVe3RdhzFmasoW8hA0o
         aHYpSJt8z//Vpx7Su9MTHwfyujuxTcX1OmQ3E4FlBBH+bDx8ZBd6mTiSxx/R4BMjrfrS
         VBAw==
X-Gm-Message-State: AJIora8HyNlnjNzIS5UxdS47SgDDdG6juXyAzji7SIBwAJ/qnyw4h2k4
        FNSwwae6Kb/jjOoRB6dnchTlvhxCds1rMFUbKYRJYajh
X-Google-Smtp-Source: AGRyM1t3KCYXk5YdIf5W7so+hcjqOwZRODAFomTq9XPauCiB9UK3TZLho9b5OQp5aNPlTo5HFLyrUbAM3hU9bVfIRRI=
X-Received: by 2002:a81:1b97:0:b0:2db:640f:49d8 with SMTP id
 b145-20020a811b97000000b002db640f49d8mr584764ywb.326.1658508568111; Fri, 22
 Jul 2022 09:49:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220715210911.714479-1-daniel.lezcano@linaro.org>
 <20220715210911.714479-3-daniel.lezcano@linaro.org> <6d08939a167870ff7c1c83bb254fda5939f1d648.camel@intel.com>
 <04bd27a8-5148-c8eb-5687-83ef511618df@linaro.org> <7ee301b76beb679f89e946dfb5921a2d853bd8dc.camel@intel.com>
 <c0d3e523-d75a-d837-313f-bf46f3fab3b4@linaro.org> <e3bfb483aa6ce09756b38b3a568fac819b154beb.camel@intel.com>
 <f0c217a2-7df0-c8ed-d2ae-c6019c7600d8@linaro.org> <86eac26233874ff389498e24c8253e0c@intel.com>
In-Reply-To: <86eac26233874ff389498e24c8253e0c@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 22 Jul 2022 18:49:14 +0200
Message-ID: <CAJZ5v0jLWLJ3ej1Faf+n48Q1OSNb7+Hn9K57ZLk9FmKTzrVUfA@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] thermal/core: Build ascending ordered indexes for
 the trip points
To:     "Zhang, Rui" <rui.zhang@intel.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "quic_manafm@quicinc.com" <quic_manafm@quicinc.com>,
        "amitk@kernel.org" <amitk@kernel.org>,
        "lukasz.luba@arm.com" <lukasz.luba@arm.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 22, 2022 at 9:16 AM Zhang, Rui <rui.zhang@intel.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Daniel Lezcano <daniel.lezcano@linaro.org>
> > Sent: Thursday, July 21, 2022 5:35 PM
> > To: Zhang, Rui <rui.zhang@intel.com>; rafael@kernel.org
> > Cc: quic_manafm@quicinc.com; amitk@kernel.org; lukasz.luba@arm.com;
> > linux-pm@vger.kernel.org; linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH v3 3/4] thermal/core: Build ascending ordered indexes
> > for the trip points
> > Importance: High
> >
> > On 19/07/2022 16:17, Zhang Rui wrote:
> > > On Tue, 2022-07-19 at 09:22 +0200, Daniel Lezcano wrote:
> > >> On 19/07/2022 03:14, Zhang Rui wrote:
> > >>> On Mon, 2022-07-18 at 15:21 +0200, Daniel Lezcano wrote:
> > >>>>
> > >>>> Hi Zhang,
> > >>>>
> > >>>> thanks for the review
> > >>>>
> > >>>> On 18/07/2022 07:28, Zhang Rui wrote:
> > >>>>> On Fri, 2022-07-15 at 23:09 +0200, Daniel Lezcano wrote:
> > >>>>
> > >>>> [ ... ]
> > >>>>
> > >>>>>> Instead of taking the risk of breaking the existing platforms,
> > >>>>>> use an array of temperature ordered trip identifiers and make it
> > >>>>>> available for the code needing to browse the trip points in an
> > >>>>>> ordered way.
> > >>>>>>
> > >>>>>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> > >>>>>> ---
> > >>>>
> > >>>> [ ... ]
> > >>>>
> > >>>>>> +static void sort_trips_indexes(struct thermal_zone_device
> > >>>>>> *tz)
> > >>>>>> +{
> > >>>>>> +       int i, j;
> > >>>>>> +
> > >>>>>> +       for (i = 0; i < tz->trips; i++)
> > >>>>>> +               tz->trips_indexes[i] = i;
> > >>>>>> +
> > >>>>>> +       for (i = 0; i < tz->trips; i++) {
> > >>>>>> +               for (j = i + 1; j < tz->trips; j++) {
> > >>>>>> +                       int t1, t2;
> > >>>>>> +
> > >>>>>> +                       tz->ops->get_trip_temp(tz, tz-
> > >>>>>>> trips_indexes[i], &t1);
> > >>>>>
> > >>>>> This line can be moved to the upper loop.
> > >>>>
> > >>>> Right, thanks!
> > >>>>
> > >>>>>> +                       tz->ops->get_trip_temp(tz, tz-
> > >>>>>>> trips_indexes[j], &t2);
> > >>>>>> +
> > >>>>>
> > >>>>> what about the disabled trip points?
> > >>>>>
> > >>>>> we should ignore those trip points and check the return value to
> > >>>>> make sure we're comparing the valid trip_temp values.
> > >>>>
> > >>>> We don't have to care about, whatever the position, the
> > >>>> corresponding trip id will be disabled by the trip init function
> > >>>> before calling this one and ignored in the handle_thermal_trip()
> > >>>> function
> > >>>
> > >>> hah, I missed this one and replied to your latest reply directly.
> > >>>
> > >>> The thing I'm concerning is that if we don't check the return value,
> > >>> for a disabled trip point, the trip_temp (t1/t2) returned is some
> > >>> random value, it all depends on the previous value set by last
> > >>> successful .get_trip_temp(), and this may screw up the sorting.
> > >>
> > >> The indexes array is the same size as the trip array, that makes the
> > >> code much less prone to errors.
> > >>
> > >> To have the same number of trip points, the index of the disabled
> > >> trip must be inserted also in the array. We don't care about its
> > >> position in the indexes array because it is discarded in the
> > >> handle_trip_point() function anyway. For this reason, the random
> > >> temperature of the disabled trip point and the resulting position in
> > >> the sorting is harmless.
> > >>
> > >> It is made on purpose to ignore the return value, so we have a
> > >> simpler code.
> > >>
> > > Let's take below case for example,
> > > say, we have three trip points 0, 1, 2, and trip point 1 is broken and
> > > disabled.
> > >
> > > trip temp for trip point 0 is 10 and for trip point 2 is 20.
> > > .get_trip_temp(tz, 1, &t) fails, and t is an uninitialized random
> > > value
> > >
> > >
> > > Initial:
> > >     trip_indexes[0]=0,trip_indexes[1]=1,trip_indexes[2]=2
> > > step1:
> > >     i=0,j=1
> > >     get trip temp for trip point trip_indexes[0]=0 and trip_indexes[1]=1
> > >     trip point 1 returns trip temp 5, and it swaps with trip point 0
> > >     so
> > >     trip_indexes[0]=1,trip_indexes[1]=0,trip_indexes[2]=2
> > > step2:
> > >     i=0,j=2
> > >     get trip temp for trip point trip_indexes[0]=1 and trip_indexes[2]=2
> > >     trip point 1 returns trip temp 25, and it swaps with trip point 2
> > >     so
> > >     trip_indexes[0]=2,trip_indexes[1]=0,trip_indexes[2]=1
> > >
> > > And the sorting is broken now.
> > >
> > > please correct me if I'm missing anything.
> >
> > Oh, nice! Thanks for the detailed explanation.
> >
> > We can initialize t1 and t2 to INT_MAX, so if the get_trip_temp() fails, they
> > will be set to the maximum temperature and it will be at the end of the array.
> >
> > Alternatively, we check the disabled bit and set the temperature to INT_MAX.
>
> IMO, we can
> 1. get the trip temp for each trip point and cache them
> 2. set the trips_disabled bit
> 3. do the sorting using the cached trip temp values
> in thermal_zone_device_trip_init() altogether.

What about the case when the trip temperature can be set from user
space?  I guess we replace the cached value then, but it may be
necessary to sort them again in theory?
