Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34B1E577804
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 21:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231587AbiGQTjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 15:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiGQTjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 15:39:15 -0400
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 916D9212;
        Sun, 17 Jul 2022 12:39:13 -0700 (PDT)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-31e0d4ad6caso28902857b3.10;
        Sun, 17 Jul 2022 12:39:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CPCaSY0Eo4Egu4Za9o4rdwtMcin5MxefXpC2xwA0s3Y=;
        b=uO/chpt2QI1GS+MZXJC8lijz7GMoTjvluh7XwP2bPIuK5bKxPavj9VBm/IKyS+RwR+
         HQWSFAz9BfHSlA5ihoaYpvK3RHOovLJYaiGxMl4SJXdWvozykZUEZn1UDXF3hT1o+QMH
         fI60HYRSJyR2Lx8cdm9G/NLzkb1gXMKBjjgw40j+rEk/B4CoXtEHrbLhOG+NCDrk/dnh
         bpDONWnS9Mjy+d2yT9+E2dacUmysOSg5NL7bTHZZL98Kcd4YHnkEanb+xn5MnZSMEJW9
         f1gXZuXrhclEaOQUVyzAo6Sc1g+nBxjru3ZdPteWgp0EAiDUkggD3ZYRhdjzBZwKhltn
         Z10A==
X-Gm-Message-State: AJIora/4HO7azRt3gQNM6fFzQDvyU5mZxNlN0uZKhQOxFoXbOUzAhtc7
        XcKx8Hh278naF+wkT8NUL2C06BwbglvzlD0dthuIjO39akY=
X-Google-Smtp-Source: AGRyM1vZy5fjO2CcnECaTla6jfCQu/66ceBy+p3K6R3EJbE5IDi6E70o2+y54qpZGcmMZ9WRwkpuufkm4Nvj4hkOEuI=
X-Received: by 2002:a81:c24e:0:b0:31e:f02:e18e with SMTP id
 t14-20020a81c24e000000b0031e0f02e18emr7471675ywg.515.1658086752837; Sun, 17
 Jul 2022 12:39:12 -0700 (PDT)
MIME-Version: 1.0
References: <12013659.O9o76ZdvQC@kreacher> <61311732eeea1f45e85537e911e4bb024c0a30b7.camel@intel.com>
In-Reply-To: <61311732eeea1f45e85537e911e4bb024c0a30b7.camel@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sun, 17 Jul 2022 21:39:01 +0200
Message-ID: <CAJZ5v0j+FTX4UF-9Y0BQc2mYXQiphsnkt07CALhF7BPtSdDxgg@mail.gmail.com>
Subject: Re: [PATCH] intel: thermal: PCH: Drop ACPI_FADT_LOW_POWER_S0 check
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
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

On Sun, Jul 17, 2022 at 8:14 AM Zhang Rui <rui.zhang@intel.com> wrote:
>
> On Thu, 2022-07-14 at 21:11 +0200, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > If ACPI_FADT_LOW_POWER_S0 is not set, this doesn't mean that low-
> > power
> > S0 idle is not usable.  It merely means that using S3 on the given
> > system is more beneficial from the energy saving perspective than
> > using
> > low-power S0 idle, as long as S3 is supported.
>
> Agreed.
>
> >
> > Suspend-to-idle is still a valid suspend mode if
> > ACPI_FADT_LOW_POWER_S0
> > is not set and the pm_suspend_via_firmware() check in
> > pch_wpt_suspend()
> > is sufficient to distinguish suspend-to-idle from S3, so drop the
> > confusing ACPI_FADT_LOW_POWER_S0 check.
>
> the cooling delay in the suspend callback is to make sure PCH
> temperature won't block S0ix during s2idle. So if S0ix is not
> supported, it is meaningless to invoke the cooling delay during s2idle.

But there is no way to determine whether or not S0ix is supported.  In
particular, ACPI_FADT_LOW_POWER_S0 is not one.

> so the problem is that we don't have an indicator for S0ix capability.
> And this also applies to drivers/rtc/rtc-cmos.c, where we use ACPI SCI
> for runtime RTC wakeup instead of HPET interrupt on "S0ix capable"
> platforms because the HPET timer may block S0ix.

"S0ix capable" doesn't matter.  What matters is whether or not the
current transition under way is into S0 or into suspend-to-idle.  In
the latter case there is no reason to avoid doing whatever is done in
the expectation that S0ix may be entered going forward.
