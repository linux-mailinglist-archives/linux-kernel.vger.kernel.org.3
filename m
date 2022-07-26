Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 054A6581B47
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 22:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239974AbiGZUns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 16:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238906AbiGZUnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 16:43:45 -0400
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com [IPv6:2607:f8b0:4864:20::a2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A29137FAE
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 13:43:44 -0700 (PDT)
Received: by mail-vk1-xa2a.google.com with SMTP id r188so5211661vkf.13
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 13:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rAOnLnHZyIth2TqTmFOgq+Z+bAsblLR9SrGgqZeR0D0=;
        b=cvaFdKE5ZB/XV/CGB1waPiQNZ4gpv9aVbiOXy2ltf9/MJpYkvq+xVMPQ/ncoXb2a89
         MwhHbLzPeYIdRHDfFl8pk88jSKtqEUj+ohCj/RtGRSYA2DCCOyre8rVt93Xz4YKbmeNJ
         nK4wpp9EoSu/StOvQsyF4RjYEHUNfpKEk7KjTgzzrQDBkRm3lfDVsmN2r4ydnls/i3Qv
         5T65mB1Csa7S4a1PnEobPA7dzurXleHZpdXG5NNEXCVHpjNpFEUgNRJCnh84a725jrEg
         6y/STxq3XGePOXmhuVikzfRtwVmPkfnA/h8vmeZdiSpUxiYXRMEpXGBFkx6JHKXineYI
         uwww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rAOnLnHZyIth2TqTmFOgq+Z+bAsblLR9SrGgqZeR0D0=;
        b=SKRHZPmQrWjl5eHv5CJ1T91kHOfFALK4VNEVbzr1P3MTF5XMT/zePTXXu2O2icU8LP
         VAjWRfj5t7vcaVrXnhs4sKb0W0tzdA8boUgGl4VxUaKRoSX6+ZGAyY5JEdhxjPNsf4Ur
         nAG8I3DqSXuq/+m0yyFeZ24oOCAwq+BCyDiilYYamUcgsAhZcdNlXkxGfQgtZ6gXxmIT
         qiMBHb5a8BeSZu+voQiKdc5K51X1C3/pe2HYsqPXqXRWBzwjJDNWvp410lBOabb7TSjg
         lBPm1oFe+JY3afvx4vuWK/CrR5vXkjbXYATyO33PkrnEIxRMr9QxNquja5wKr3ktde2K
         lcYQ==
X-Gm-Message-State: AJIora91HZDlepALZTJxSfsppeKONeZBlZ8W8SA41ktZAGyHiIlu/RSa
        ejJoKkRO4gIZOd7OmedNfo/h0vdn9RfN59BgwuPYVA==
X-Google-Smtp-Source: AGRyM1uey2hGDe9hEDhGPZ6SNcUTNZWyZKvCjaPBXkOtTR+MzkBuAdm3THgiwKVKqu4Zhpnmaem+zKFn17peWJQhJZQ=
X-Received: by 2002:a05:6122:628:b0:376:1878:16ea with SMTP id
 g8-20020a056122062800b00376187816eamr5936849vkp.37.1658868223010; Tue, 26 Jul
 2022 13:43:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220725104220.1106663-1-leo.yan@linaro.org> <Yt68AZA2VV9d02xZ@kernel.org>
 <CA+_WhHyZZC=3gtzetEAQQrjtGujHmY5azwtQNZEc90gyOAwUDg@mail.gmail.com>
 <CAP-5=fWiNdnEawdj_3ExCrcwRSnRxeV8=8RhA6pwbw_bJdPJFg@mail.gmail.com> <YuBDw/+7McESS05X@kernel.org>
In-Reply-To: <YuBDw/+7McESS05X@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 26 Jul 2022 13:43:31 -0700
Message-ID: <CAP-5=fV4+KeGcyyODTNjS01dw1iTXpFyaLXwZ8nBkek+NHL37w@mail.gmail.com>
Subject: Re: [PATCH] perf scripts python: Let script to be python2 compliant
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Alan Bartlett <ajb@elrepo.org>, Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-perf-users@vger.kernel.org, ElRepo <contact@elrepo.org>,
        Akemi Yagi <toracat@elrepo.org>, Jiri Olsa <jolsa@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 26, 2022 at 12:43 PM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Tue, Jul 26, 2022 at 10:52:31AM -0700, Ian Rogers escreveu:
> > On Tue, Jul 26, 2022 at 9:57 AM Alan Bartlett <ajb@elrepo.org> wrote:
> > >
> > > On Mon, 25 Jul 2022 at 16:51, Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > > >
> > > > Em Mon, Jul 25, 2022 at 06:42:20PM +0800, Leo Yan escreveu:
> > > > > The mainline kernel can be used for relative old distros, e.g. RHEL 7.
> > > > > The distro doesn't upgrade from python2 to python3, this causes the
> > > > > building error that the python script is not python2 compliant.
> > > > >
> > > > > To fix the building failure, this patch changes from the python f-string
> > > > > format to traditional string format.
> > > >
> > > > Thanks, applied.
> > > >
> > > > - Arnaldo
> > >
> > > Leo / Arnaldo,
> > >
> > > Applying the patch on top of -5.19-rc8 fixes the problem that we (the
> > > ELRepo Project) experienced when attempting to build on RHEL7.
> > >
> > > So --
> > >
> > > Tested-by: Alan Bartlett <ajb@elrepo.org>
> > >
> > > Hopefully you will get it to Linus in time for -5.19 GA.
>
> > So I'm somewhat concerned about perf supporting unsupported
> > distributions and this holding the code base back. RHEL7 was launched
> > 8 years ago (June 10, 2014) and full support ended 3 years ago (August
> > 6, 2019) [1]. Currently RHEL7 is in "Maintenance Support or
> > Maintenance Support 2" phase which is defined to mean [2]:
> >
> > ```
> > During the Maintenance Support Phase for Red Hat Enterprise Linux
> > Version 8 & 9, and Maintenance Support 2 Phase for Red Hat Enterprise
> > Linux version 7, Red Hat defined Critical and Important impact
> > Security Advisories (RHSAs) and selected (at Red Hat discretion)
> > Urgent Priority Bug Fix Advisories (RHBAs) may be released as they
> > become available. Other errata advisories may be delivered as
> > appropriate.
> >
> > New functionality and new hardware enablement are not planned for
> > availability in the Maintenance Support (RHEL 8 & 9) Phase and
> > Maintenance Support 2 (RHEL 7) Phase.
> > ```
> >
> > >From this definition, why would RHEL7 pick up a new perf tool? I don't
> > think they would and as such we don't need to worry about supporting
> > it. RHEL8 defaults to python 3 and full support ends for it next year.
> > Let's set the bar at RHEL8 and not worry about RHEL7 breakages like
> > this in future. I think the bar for caring should be "will the distro
> > pick up our code", if we don't do this then we're signing up to not
> > allowing tools to update for 10 years! If someone is building a kernel
> > and perf tool on RHEL7 then they should be signing up to also deal
> > with tool chain issues, which in this case can mean installing
> > python3.
>
> In this specific supporting things that people report using, like was
> done in this case, isn't such a big problem.

So there are linters will fire for this code and say it is not
pythonic. It is only a linter warning vs asking to support an 8 year
old out of support distribution. There are other cases, such as
improving the C code structure, where we've failed to land changes
because of build errors on old distributions. This could indicate perf
code is wrong or the distribution is wrong. I'm saying that if we
believe in the perf code being correct and the distribution is out of
support, then we should keep the perf code as-is and the issue is one
for user of the out-of-support distribution.

> Someone reported a problem in a system they used, the author of the code
> in question posted a patch allowing perf to be used in such old systems,
> doesn't get in the way of newer systems, small patch, merged, life goes
> on.

Right, but we're setting a precedent for supporting out of support
distributions. If we can say "life goes on" can we land this *current*
Debian fix?
https://lore.kernel.org/lkml/20220629034007.332804-1-irogers@google.com/

> Sometimes some organizations are stuck with some distro till they can go
> thru re-certifications, bidding for new hardware, whatever, and then
> they want to continue using the latest perf on those systems because
> they want to benefit from new features we're working on that work on
> such systems. If the cost is small, like in this case, I see no problems
> to have perf working on such older systems.

So there's no problem with perf working on old systems. The issue is
supporting 10 year old unsupported build infrastructure. The fact that
the build infrastructure is unsupported means we need to carry all the
fixes in the tools tree and that can mean doing some questionably sane
things, like supporting python 2 (end of life for 2.5 years) on RHEL7
(end of full support 3 years ago). RHEL8 still has a year of support,
so great test that. RHEL7 then fix your tools and perf will work for
you - where fix means "rpm -i python3", hardly a huge chore.

Thanks,
Ian
