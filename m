Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D07257C9B6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 13:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233130AbiGUL0I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 07:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbiGUL0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 07:26:06 -0400
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24941101DF;
        Thu, 21 Jul 2022 04:26:05 -0700 (PDT)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-31e560aa854so13647197b3.6;
        Thu, 21 Jul 2022 04:26:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y3aH26Tt0fov+wN+dziNA4MJLDOlPeS6/aeyAPgNAKs=;
        b=3EIrm4O/Lfk3+4uxM/71zDRe3/koVmWLFM9P3manGnin2LdbYLeg/upp+mwTCzR9ZV
         MRPJmwpw5u2kYT1Tzxnpty66elJqDX4lI9sMz3HwlmLilVvSpfxyRhGAzO5TJ/gkTYOh
         FLQzwJfdCU11ChjCa7innwrkWSDM/0mxRnTICaMli/P5DpWde40H+gKE+6FeWKDY46kv
         2l3tgGr03ddEZHSDNxlPn86dVvCOR7gDBWDEEZbE/N4NX0JHEpgslsMYl5pOs4gkIh3b
         DuZh6kX35Nz7Rar7sp0fVL99quVjJaTHBmdvA0VlLrORIoo1jTBY44761wrhXRx+PsN7
         iHig==
X-Gm-Message-State: AJIora8jiiRFtDWd5GGxdfLa0tQdldkyB763bQ4Ig+HySLr53VomhEjB
        KyhCAlzW5byRQzNd+3fJ6NXu9DdFQh/ohIl5j3E=
X-Google-Smtp-Source: AGRyM1udwHaTCh3Lm0psHK2LHkSbxBfKdfvBaU4qSeul2vjAkQ+H3vW7FVuR7eqNJDtROz2TrSyVB5zTTGnB1WB7TyI=
X-Received: by 2002:a81:1a11:0:b0:31e:4549:d667 with SMTP id
 a17-20020a811a11000000b0031e4549d667mr17201713ywa.196.1658402764395; Thu, 21
 Jul 2022 04:26:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220718145038.1114379-1-daniel.lezcano@linaro.org>
 <20220718145038.1114379-3-daniel.lezcano@linaro.org> <CAJZ5v0hj0kMRNBqO_0SqsAAY8Rb8h2NrWOYogDLgGZnCtiTEwg@mail.gmail.com>
 <117c778a-4496-4d49-e73d-06fa3efa4d09@linaro.org>
In-Reply-To: <117c778a-4496-4d49-e73d-06fa3efa4d09@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 21 Jul 2022 13:25:53 +0200
Message-ID: <CAJZ5v0gjfeyiS8rUoPpa3sMrofw1ZyQe=+P6pvPbeirs07F+Qw@mail.gmail.com>
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

On Thu, Jul 21, 2022 at 12:59 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 19/07/2022 20:56, Rafael J. Wysocki wrote:
> > On Mon, Jul 18, 2022 at 4:50 PM Daniel Lezcano
> > <daniel.lezcano@linaro.org> wrote:
> >>
> >> By convention the trips points are declared in the ascending
> >> temperature order. However, no specification for the device tree, ACPI
> >> or documentation tells the trip points must be ordered this way.
> >>
> >> In the other hand, we need those to be ordered to browse them at the
> >
> > s/In/On/
> >
> >> thermal events.
> >
> > What if they are all inspected every time?
>
> My bad, my sentence is confusing. The trip point are browsed every time
> and we need to have them ordered to detect correctly the thermal events.

I see.

So this mostly is a preparation for patch 4, isn't it?

> >> But if we assume they are ordered and change the code
> >> based on this assumption, any platform with shuffled trip points
> >> description will be broken (if they exist).
> >>
> >> Instead of taking the risk of breaking the existing platforms, use an
> >> array of temperature ordered trip identifiers and make it available
> >> for the code needing to browse the trip points in an ordered way.
> >
> > Well, having ops->get_trip_temp() suggests that the trip temperatures
> > can be dynamic.  Is the ordering guaranteed to be preserved in that
> > case?
>
> The number of trips can not be changed. It is fixed when the thermal
> zone is created AFAICT.

The current code appears to assume that and I think that this is a
reasonable expectation.

> The get_trip_temp() is just a way to let the
> different driver declare their own trip structure which is actually
> something I'm trying to fix by moving the structure thermal_trip inside
> the thermal zone. But that is a longer and separate work.

Well, I'm not sure.

Trip point temperatures can be set via trip_point_temp_store() at
least in principle.  How is it guaranteed that this won't affect the
ordering?

> > Anyway, if they need to be sorted, why don't we just sort them
> > properly instead of adding this extra array?
>
> We can not because ATM the trip points array is private to the different
> sensors.

Well, the core could create an array or list of trip points for the
thermal zone during registration and populate it from the
driver-provided data.  Then, it could be sorted at the creation time.

However, the above question needs to be addressed first.
