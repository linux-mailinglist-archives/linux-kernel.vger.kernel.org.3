Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9473B581B61
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 22:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239988AbiGZUyw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 16:54:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239977AbiGZUyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 16:54:50 -0400
Received: from mail-vk1-xa2e.google.com (mail-vk1-xa2e.google.com [IPv6:2607:f8b0:4864:20::a2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1AED39BA3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 13:54:49 -0700 (PDT)
Received: by mail-vk1-xa2e.google.com with SMTP id e20so4428410vkm.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 13:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nJp/ahZSI1R6etro7SwQSXvW6XQ1Eb9ie5ZAFReDvRY=;
        b=fjJkItECe+1ompzTligBQcKHBSBsu1hL3FHA0mzqmI7mhC8sDIiEYzJHJsmHiwVYZC
         A1Hfmenpw3CvvPEC6LBPTPgZL7SB50Y0EaCjtn/++/MehObFpLy3OMi2xCqJw1D3hlzI
         syMZjh/roUyDRfvQq0vfWoii2b3Lj7ZQ5niG/AaxhIrRxuMP4fWbiKnzklX3/k2eY2nn
         xP4hjHTTn7TqQ2F+Nmy6ocaTTFPjOr/ymSgnWQ6cavDyIvHXGt8lgU8sF79le0BvkSro
         w8GsNMwK4S10s4kCqQ91RJkhSOLrEsdthukKpdHQaKBZew2AWSuQaEud8i2ISA46z6rQ
         NCBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nJp/ahZSI1R6etro7SwQSXvW6XQ1Eb9ie5ZAFReDvRY=;
        b=GohGj7wcwalT9wYK87sJZV+hP7cc1/clRL79qZDJNkugXw1RGOvlXomMa8e34kjPqQ
         +RLjn6SKfYltngqm9bpXOdYwmIhs7vfhTF6dmlYINccN8uj0ktrIbn3ih6KxGOuCHDG3
         Wa3WxIGLblVR4Nu2cHawK5Uvlntuf+bt5FIaGR54XaJIw4oLLYNm2Ly/1iMqJ2iAu7Se
         A0GVbOaNhnbzZg755kReH7t1+6XVh1eDuVbfoSEFJFwr2SljGMJ/+vuNNnYZxcYczzko
         RAhHSxWnhMPQjQaMjJrDC3KFGFxJ07w8JBOgA2C4wM/gUa4D2iNdUNmC5EF9ICuk6Uhm
         UDcg==
X-Gm-Message-State: AJIora8xe6bASp/hSYBFoHlSP7gZFq0JeMAEj/bZGUCEosf9DixqBJh3
        /FLarpvpzPeA7S3fpj7Dw0XuEKdQ/P+65qwpk0eLoA==
X-Google-Smtp-Source: AGRyM1v6B7fKh1Y7QzGx5nA0gKgXuO9sQxCIw/FJj1eIyICG3cN+ZQ1F9o3wDohSS1QnR9orSeJBkMwQ8KjtQM++hW4=
X-Received: by 2002:a1f:38c8:0:b0:376:353e:cb5c with SMTP id
 f191-20020a1f38c8000000b00376353ecb5cmr4919452vka.33.1658868888573; Tue, 26
 Jul 2022 13:54:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220725104220.1106663-1-leo.yan@linaro.org> <Yt68AZA2VV9d02xZ@kernel.org>
 <CA+_WhHyZZC=3gtzetEAQQrjtGujHmY5azwtQNZEc90gyOAwUDg@mail.gmail.com>
 <CAP-5=fWiNdnEawdj_3ExCrcwRSnRxeV8=8RhA6pwbw_bJdPJFg@mail.gmail.com>
 <YuBDw/+7McESS05X@kernel.org> <CABA31DoEJEyVeUgzROzzj_OA2exmj69WamaavQWi=7nWq52dxw@mail.gmail.com>
In-Reply-To: <CABA31DoEJEyVeUgzROzzj_OA2exmj69WamaavQWi=7nWq52dxw@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 26 Jul 2022 13:54:37 -0700
Message-ID: <CAP-5=fW-tYpbV6sZCKOMQs3gfGNjY6maTA_02fadaWHOGFYpLQ@mail.gmail.com>
Subject: Re: [PATCH] perf scripts python: Let script to be python2 compliant
To:     Akemi Yagi <toracat@elrepo.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alan Bartlett <ajb@elrepo.org>, Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-perf-users@vger.kernel.org, ElRepo <contact@elrepo.org>,
        Jiri Olsa <jolsa@kernel.org>,
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

On Tue, Jul 26, 2022 at 1:35 PM Akemi Yagi <toracat@elrepo.org> wrote:
>
> On Tue, Jul 26, 2022 at 12:43 PM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > Em Tue, Jul 26, 2022 at 10:52:31AM -0700, Ian Rogers escreveu:
>
> > > So I'm somewhat concerned about perf supporting unsupported
> > > distributions and this holding the code base back. RHEL7 was launched
> > > 8 years ago (June 10, 2014) and full support ended 3 years ago (August
> > > 6, 2019) [1]. Currently RHEL7 is in "Maintenance Support or
> > > Maintenance Support 2" phase which is defined to mean [2]:
> [...]
>
> > In this specific supporting things that people report using, like was
> > done in this case, isn't such a big problem.
> >
> > Someone reported a problem in a system they used, the author of the code
> > in question posted a patch allowing perf to be used in such old systems,
> > doesn't get in the way of newer systems, small patch, merged, life goes
> > on.
> >
> > Sometimes some organizations are stuck with some distro till they can go
> > thru re-certifications, bidding for new hardware, whatever, and then
> > they want to continue using the latest perf on those systems because
> > they want to benefit from new features we're working on that work on
> > such systems. If the cost is small, like in this case, I see no problems
> > to have perf working on such older systems.
> >
> > - Arnaldo
>
> Just wanted to make a note about the "old" systems.
>
> While RHEL 7 might be regarded as "old" in general, it may not be so
> in the world of Enterprise Linux. A graph of EPEL mirror stats [1],
> while it is from about a year ago, shows EL 7 (RHEL 7 and its
> rebuilds) has a huge user base and was still growing quite fast.

So if RedHat don't care to support it, why as developers should we?

> By the way, my main workstation runs RHEL 7. ;-)

So you need new tools that are broken so you can give pressure to
whoever is subjecting you to out-of-date distributions to pull their
fingers out and fix this ;-) You may also want to think about the
security of your system.

Thanks,
Ian

> Akemi
>
> [1] https://twitter.com/mattdm/status/1447224008831811588
