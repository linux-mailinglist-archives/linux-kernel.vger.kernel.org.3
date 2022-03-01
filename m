Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEA8E4C8FB4
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 17:08:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235959AbiCAQIm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 11:08:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232419AbiCAQIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 11:08:39 -0500
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F3B84BB87;
        Tue,  1 Mar 2022 08:07:57 -0800 (PST)
Received: by mail-yb1-f169.google.com with SMTP id f38so16259929ybi.3;
        Tue, 01 Mar 2022 08:07:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HEeJ/FQgP1YcfXQzCrZz1Sk7yO260+E7FFUojjd4FWs=;
        b=aKJ6vcXMa1rNfu/IpCGHZ7Un1TLkNdWqpRs0CsdSWJqV+EtV9i9GA8egSwtxyIV93g
         ZBXCUJmd0cvZeVV4Ff5LFCLhFHygulaufbipWaKDO3ISCF7HJFUM6egvSyrwYMu2UgJ2
         mJWkQc71ybipjLcfzA4qaBqaCbZ2W5+e44zRBnIvMc0S6LoLJHtBmhQrBqM9XnPSwHo+
         dET0kv+Rj/SqEB39BK5UJQiM2HqVjsjJakd4wFPo4sFbg6ZRrSQesgUoBZcqzvMiMBNU
         TRjlKkfJ9haYLpv4XOXIGdFrHsnKJDNDEq0hsl7RmmhMe0TKQXfVgBFcBAqMbUWlL/qx
         1+cw==
X-Gm-Message-State: AOAM532aP9N9aaS9tCxXPA2dvG6ctjSCvgG4BDcqIYGZViHTuDVOJJ7u
        scQy3PTYPUfXY53S7fGU6LUz9agL9vB6X1zYK4I=
X-Google-Smtp-Source: ABdhPJzhWslSmMvtH7+++uNGNjmHVGo1V4LddcDj0zC449QbnV6wuHVFVOnywkOd3I82eLRW/Y3747CPWc7SF8ghQow=
X-Received: by 2002:a25:d90d:0:b0:615:e400:94c1 with SMTP id
 q13-20020a25d90d000000b00615e40094c1mr24365841ybg.81.1646150876474; Tue, 01
 Mar 2022 08:07:56 -0800 (PST)
MIME-Version: 1.0
References: <20220223100350.3523826-1-Jinzhou.Su@amd.com> <20220223100350.3523826-2-Jinzhou.Su@amd.com>
 <CAJZ5v0iaY3tsNKFXv09Z4wg_2R3+9UsSnqfPBbOYFaqoVS1qCg@mail.gmail.com> <BL1PR12MB51447B1235E91A81309190B2F7029@BL1PR12MB5144.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB51447B1235E91A81309190B2F7029@BL1PR12MB5144.namprd12.prod.outlook.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 1 Mar 2022 17:07:45 +0100
Message-ID: <CAJZ5v0jDbNVEtRiaiUXembZB2r4uxVy3iKO0aTqOJsB0rLpV=A@mail.gmail.com>
Subject: Re: [PATCH 1/3] cpufreq: amd-pstate: Add more tracepoint for AMD
 P-State module
To:     "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Su, Jinzhou (Joe)" <Jinzhou.Su@amd.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Doug Smythies <dsmythies@telus.net>,
        "Huang, Ray" <Ray.Huang@amd.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Todd Brandt <todd.e.brandt@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        "Yuan, Perry" <Perry.Yuan@amd.com>,
        "Meng, Li (Jassmine)" <Li.Meng@amd.com>
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

On Tue, Mar 1, 2022 at 5:05 PM Deucher, Alexander
<Alexander.Deucher@amd.com> wrote:
>
> [AMD Official Use Only]
>
> > -----Original Message-----
> > From: Rafael J. Wysocki <rafael@kernel.org>
> > Sent: Tuesday, March 1, 2022 10:26 AM
> > To: Su, Jinzhou (Joe) <Jinzhou.Su@amd.com>
> > Cc: Rafael J. Wysocki <rjw@rjwysocki.net>; Linux PM <linux-
> > pm@vger.kernel.org>; Srinivas Pandruvada
> > <srinivas.pandruvada@linux.intel.com>; Doug Smythies
> > <dsmythies@telus.net>; Huang, Ray <Ray.Huang@amd.com>; Viresh Kumar
> > <viresh.kumar@linaro.org>; Todd Brandt <todd.e.brandt@linux.intel.com>;
> > Linux Kernel Mailing List <linux-kernel@vger.kernel.org>; Sharma, Deepak
> > <Deepak.Sharma@amd.com>; Deucher, Alexander
> > <Alexander.Deucher@amd.com>; Du, Xiaojian <Xiaojian.Du@amd.com>;
> > Yuan, Perry <Perry.Yuan@amd.com>; Meng, Li (Jassmine)
> > <Li.Meng@amd.com>
> > Subject: Re: [PATCH 1/3] cpufreq: amd-pstate: Add more tracepoint for AMD
> > P-State module
> >
> > On Wed, Feb 23, 2022 at 11:04 AM Jinzhou Su <Jinzhou.Su@amd.com>
> > wrote:
> > >
> > > Add frequency, mperf, aperf and tsc in the trace. This can be used to
> > > debug and tune the performance of AMD P-state driver.
> > >
> > > Use the time difference between amd_pstate_update to calculate CPU
> > > frequency. There could be sleep in arch_freq_get_on_cpu, so do not use
> > > it here.
> > >
> > > Signed-off-by: Jinzhou Su <Jinzhou.Su@amd.com>
> > > Signed-off-by: Huang Rui <ray.huang@amd.com>
> >
> > I'm not sure what the second sign-off is for.
> >
> > If this is a maintainer's sign-off, it should be added by the maintainer himself
> > and you should not add it when submitting the patch.
>
> Both developers co-worked on the patch.  Isn't that pretty standard when you rework someone else's patch?

It is, but that's when Co-developed-by should be used.  Otherwise the
meaning of the second s-o-b is unclear.
