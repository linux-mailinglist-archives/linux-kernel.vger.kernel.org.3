Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6997B58192F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 19:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239840AbiGZRy2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 13:54:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239906AbiGZRyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 13:54:07 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63E4732BAB
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 10:52:46 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id w8-20020a05600c014800b003a32e89bc4eso8571446wmm.5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 10:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ibbkqOJbjTU7aTrIxfr+vCfiOwdKe1UQiyQ1pP/N5ro=;
        b=dohbt+jrQSc0W7ReW484YOSWSgYArsM9LgsNPLgXNRmTrbju0mqG5Zq+euDw4p6408
         8zY+BHyaxs2I/UcMTUqTY/tW7MxmpFukrtuDF5xyLpytIyezXjH0HSuqckhXGM5NULCq
         zzumtsbSAA0rVVJFVbA0zycP+v8GD+DIG35iIZOeBjBbaCEqAhg/1NZOxukLnttUo6o5
         kZ/ndeK2SSh7gSUBCkQlBejChHqHoCIb7kVyoPX+7Fvw1b6UWmFwJofFhVn8nTpLCH9r
         KsaPR1gJ1PpAMxRkz5ighBi6eyS2IiEKJgD/Fq7QkKyiJ0efEwR+4Vi2ma/d0joXpBH6
         BNlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ibbkqOJbjTU7aTrIxfr+vCfiOwdKe1UQiyQ1pP/N5ro=;
        b=ZA1W4Q2lW1wjzBZnFaXSVOgCN+3uTmnDrgZbs6OtTcBOwaZ7hFAlARZLj0A4hqT9dl
         2dZ9pbN0gvUTIZctLQQDuZDvjGJQaEDui1wMgoUpdzoXM84CGv+ED3SJO7b+6Az29o3C
         9b0Zonghx3Ix+M3xGiFthXQfAUYdaYep9jQqPngn9yaw9BRAwk3qp7TKKnTH2fvMdP4m
         eXi6cm/yj1tVglI4EK5vgzjaInbhXLS5+04PHvSEmGrFmxMibKEKTx7WfK7I4X0edSf7
         jFqYBxBxhS3C0/23KpaSqLCmvYAGHZfft3mV2a/WK3SGMnMeeYzF4YSuhKJCqbvuyVMM
         VwBw==
X-Gm-Message-State: AJIora+i3MY8MD6xsBiMA9rffUbGvzmb5x9/EOsEPw/Mg1A8eU2yMGDf
        I2a2Mc+B/Y9RDv36RhiwP8M3qv7c32i7XJrVfx3luQ==
X-Google-Smtp-Source: AGRyM1tsogc+fsYOOTWp7L1CLDs8aHyjfw7JB/gRlwH5/BepB5CT+Xme6EUjPeato8Ln+jNu2btDVQo78qBpZd6mEhU=
X-Received: by 2002:a7b:ce13:0:b0:3a3:102c:23d3 with SMTP id
 m19-20020a7bce13000000b003a3102c23d3mr231642wmc.67.1658857964350; Tue, 26 Jul
 2022 10:52:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220725104220.1106663-1-leo.yan@linaro.org> <Yt68AZA2VV9d02xZ@kernel.org>
 <CA+_WhHyZZC=3gtzetEAQQrjtGujHmY5azwtQNZEc90gyOAwUDg@mail.gmail.com>
In-Reply-To: <CA+_WhHyZZC=3gtzetEAQQrjtGujHmY5azwtQNZEc90gyOAwUDg@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 26 Jul 2022 10:52:31 -0700
Message-ID: <CAP-5=fWiNdnEawdj_3ExCrcwRSnRxeV8=8RhA6pwbw_bJdPJFg@mail.gmail.com>
Subject: Re: [PATCH] perf scripts python: Let script to be python2 compliant
To:     Alan Bartlett <ajb@elrepo.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-perf-users@vger.kernel.org, ElRepo <contact@elrepo.org>,
        Akemi Yagi <toracat@elrepo.org>, Jiri Olsa <jolsa@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
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

On Tue, Jul 26, 2022 at 9:57 AM Alan Bartlett <ajb@elrepo.org> wrote:
>
> On Mon, 25 Jul 2022 at 16:51, Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> >
> > Em Mon, Jul 25, 2022 at 06:42:20PM +0800, Leo Yan escreveu:
> > > The mainline kernel can be used for relative old distros, e.g. RHEL 7.
> > > The distro doesn't upgrade from python2 to python3, this causes the
> > > building error that the python script is not python2 compliant.
> > >
> > > To fix the building failure, this patch changes from the python f-string
> > > format to traditional string format.
> >
> > Thanks, applied.
> >
> > - Arnaldo
>
> Leo / Arnaldo,
>
> Applying the patch on top of -5.19-rc8 fixes the problem that we (the
> ELRepo Project) experienced when attempting to build on RHEL7.
>
> So --
>
> Tested-by: Alan Bartlett <ajb@elrepo.org>
>
> Hopefully you will get it to Linus in time for -5.19 GA.
>
> Thanks,
> Alan.

So I'm somewhat concerned about perf supporting unsupported
distributions and this holding the code base back. RHEL7 was launched
8 years ago (June 10, 2014) and full support ended 3 years ago (August
6, 2019) [1]. Currently RHEL7 is in "Maintenance Support or
Maintenance Support 2" phase which is defined to mean [2]:

```
During the Maintenance Support Phase for Red Hat Enterprise Linux
Version 8 & 9, and Maintenance Support 2 Phase for Red Hat Enterprise
Linux version 7, Red Hat defined Critical and Important impact
Security Advisories (RHSAs) and selected (at Red Hat discretion)
Urgent Priority Bug Fix Advisories (RHBAs) may be released as they
become available. Other errata advisories may be delivered as
appropriate.

New functionality and new hardware enablement are not planned for
availability in the Maintenance Support (RHEL 8 & 9) Phase and
Maintenance Support 2 (RHEL 7) Phase.
```

From this definition, why would RHEL7 pick up a new perf tool? I don't
think they would and as such we don't need to worry about supporting
it. RHEL8 defaults to python 3 and full support ends for it next year.
Let's set the bar at RHEL8 and not worry about RHEL7 breakages like
this in future. I think the bar for caring should be "will the distro
pick up our code", if we don't do this then we're signing up to not
allowing tools to update for 10 years! If someone is building a kernel
and perf tool on RHEL7 then they should be signing up to also deal
with tool chain issues, which in this case can mean installing
python3.

Thanks,
Ian

[1] https://access.redhat.com/product-life-cycles/
[2] https://access.redhat.com/support/policy/updates/errata
