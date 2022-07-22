Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7AD157E5C0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 19:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236177AbiGVRkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 13:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236149AbiGVRkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 13:40:19 -0400
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 426E215FC8;
        Fri, 22 Jul 2022 10:40:18 -0700 (PDT)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-31e7c4b593fso54758377b3.13;
        Fri, 22 Jul 2022 10:40:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=monAexa3iUsCYtrn0IpBfOizieq2Utu+6SqlwdWc9qA=;
        b=rNzyHFnogbOn2dDC/04TYPraklXkWboLv8fA1SBNKJkGZOODZbLknC4K3Axehi3Anb
         8J6tBu5Q7g/mmouVKNJmHJm9nagE2n32MxWUetfqmPalyM3CKPlVIC0bsJOrcKGM7xVh
         Z3J62rqjFSPRprIBpXCPPRk0oBYmEJe7M3XQD7F1DariJCsBONvYg1iHsU5ZiBY0asZw
         rHNcbjUPHIQnZzmUUyLK1BjlSQ1B3/zo5F6j0jCqOnXm3xDg3sTugcBgy+HdrECgkg7S
         7S82X7mgKI2cQ742hMa/VDBOpOwzXrSnaeWbAKEuX30baUKQqWaDL48YhS+hmZRpFVmV
         bKBA==
X-Gm-Message-State: AJIora9Vt3jwrj3QzdD2NqEhOH6KNQtxFr5bThoQI4/F59LuUzFmFBoQ
        vwO2r1ewRkfKVCWBjJ+zaLbXv3k3NQ5OuMp8oy0=
X-Google-Smtp-Source: AGRyM1tXyDVbo8AAjHKlh3F3yO0MwrRCNMm5ABdKO/V6cOCBkIJLUJgRjzC4ELd6Cpne64Avu2Xw0nfa/yPX5i4PNvk=
X-Received: by 2002:a0d:cf84:0:b0:31e:7901:19e9 with SMTP id
 r126-20020a0dcf84000000b0031e790119e9mr846126ywd.7.1658511617417; Fri, 22 Jul
 2022 10:40:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220718145038.1114379-1-daniel.lezcano@linaro.org>
 <20220718145038.1114379-3-daniel.lezcano@linaro.org> <CAJZ5v0hj0kMRNBqO_0SqsAAY8Rb8h2NrWOYogDLgGZnCtiTEwg@mail.gmail.com>
 <117c778a-4496-4d49-e73d-06fa3efa4d09@linaro.org> <CAJZ5v0gjfeyiS8rUoPpa3sMrofw1ZyQe=+P6pvPbeirs07F+Qw@mail.gmail.com>
 <8926eed7-436f-5f1a-7036-0e1520bd3a0b@linaro.org>
In-Reply-To: <8926eed7-436f-5f1a-7036-0e1520bd3a0b@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 22 Jul 2022 19:40:04 +0200
Message-ID: <CAJZ5v0icAE1t4+VsEq71FiUjQXr1LJeokBiuGTxvsHByedfmhw@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] thermal/core: Build ascending ordered indexes for
 the trip points
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Thu, Jul 21, 2022 at 11:15 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 21/07/2022 13:25, Rafael J. Wysocki wrote:
> > On Thu, Jul 21, 2022 at 12:59 PM Daniel Lezcano
> > <daniel.lezcano@linaro.org> wrote:
> >>
> >> On 19/07/2022 20:56, Rafael J. Wysocki wrote:
> >>> On Mon, Jul 18, 2022 at 4:50 PM Daniel Lezcano
> >>> <daniel.lezcano@linaro.org> wrote:
> >>>>
> >>>> By convention the trips points are declared in the ascending
> >>>> temperature order. However, no specification for the device tree, ACPI
> >>>> or documentation tells the trip points must be ordered this way.
> >>>>
> >>>> In the other hand, we need those to be ordered to browse them at the
> >>>
> >>> s/In/On/
> >>>
> >>>> thermal events.
> >>>
> >>> What if they are all inspected every time?
> >>
> >> My bad, my sentence is confusing. The trip point are browsed every time
> >> and we need to have them ordered to detect correctly the thermal events.
> >
> > I see.
> >
> > So this mostly is a preparation for patch 4, isn't it?
>
> Yes, it is correct
>
> >>>> But if we assume they are ordered and change the code
> >>>> based on this assumption, any platform with shuffled trip points
> >>>> description will be broken (if they exist).
> >>>>
> >>>> Instead of taking the risk of breaking the existing platforms, use an
> >>>> array of temperature ordered trip identifiers and make it available
> >>>> for the code needing to browse the trip points in an ordered way.
> >>>
> >>> Well, having ops->get_trip_temp() suggests that the trip temperatures
> >>> can be dynamic.  Is the ordering guaranteed to be preserved in that
> >>> case?
> >>
> >> The number of trips can not be changed. It is fixed when the thermal
> >> zone is created AFAICT.
> >
> > The current code appears to assume that and I think that this is a
> > reasonable expectation.
> >
> >> The get_trip_temp() is just a way to let the
> >> different driver declare their own trip structure which is actually
> >> something I'm trying to fix by moving the structure thermal_trip inside
> >> the thermal zone. But that is a longer and separate work.
> >
> > Well, I'm not sure.
> >
> > Trip point temperatures can be set via trip_point_temp_store() at
> > least in principle.  How is it guaranteed that this won't affect the
> > ordering?
>
> Right, that is a good point. I don't see a logical use case where a trip
> point will be set below or above the previous or the next one, so the
> order should be kept.

Good.

> However, strictly speaking, nothing prevents that
> so I guess we need to reorder the trips when one is changed. It should
> be a one line call.

Or modify trip_point_temp_store() to preserve the ordering of trip
points (which would be way simpler if trip point temperatures were
stored as numbers in a sorted array - see below).

>
> >>> Anyway, if they need to be sorted, why don't we just sort them
> >>> properly instead of adding this extra array?
> >>
> >> We can not because ATM the trip points array is private to the different
> >> sensors.
> >
> > Well, the core could create an array or list of trip points for the
> > thermal zone during registration and populate it from the
> > driver-provided data.  Then, it could be sorted at the creation time.
>
>
> There won't be any benefit ATM.

What about less overhead?  And the code being easier to understand?
And no hidden assumptions?  Hmm??

> The get_trip_temp/type/hyst ops are
> called all over the place. If we create a second sorted trip point array
> and use it in the core code, then all those ops should be replaced to
> use the sorted array instead of addressing the private trip structure.

Right.

> A big deal in terms of changes.

It is not overwhelming in my view.

> If we don't do the ops changes, then it is simpler to have an array of
> index->trip id and the impact is small.
>
> But I agree we should have a sorted trip array per thermal zone and stop
> using the ops->get_trip_temp|type|hyst. That is part of the work I'm
> doing in parallel to cleanup the thermal-of and I've the plan to migrate
> all the sensors to use the struct thermal_trip instead of private data.
>  From there we will be able to get rid of the get_trip[*] and the sorted
> trip indexes array.

Well, what about making the core use struct thermal_trip internally in
the first place?

Except that I don't like the np member of that one.

> All these changes are not feasible in the short term.

They can be made in the opposite direction, starting at the core
level.  Then, it would be clear where you were going.

> I would like to
> keep the indexes trip array approach to fix the trip cross events which
> is broken right now and then go forward with the struct thermal_trip
> changes and the thermal-of cleanups I've sent last week.
>
> Does it sound reasonable ?

I'm not convinced about the need to make the code more complicated if
the overall direction is to simplify it.

I understand that you want to avoid regressing things, but you want to
make these changes eventually anyway, so why to you think that the
risk of regressing things would be smaller in the future, after making
the code more complicated than it is now?  Sounds counter-intuitive to
me.
