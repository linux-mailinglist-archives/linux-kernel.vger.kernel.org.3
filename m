Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE767576605
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 19:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbiGOR3f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 13:29:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbiGOR32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 13:29:28 -0400
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF5121A3BD;
        Fri, 15 Jul 2022 10:29:27 -0700 (PDT)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-31cf1adbf92so53604967b3.4;
        Fri, 15 Jul 2022 10:29:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y3B/xuKwwDaDPj70H09iMM0q55vMJN+NwGOuzYtaHOE=;
        b=c+zhcPzJ0hSb99mKoy42nxtkX8UqM6uzFWUiQCxxPXv8m81qY9CgLF0+vrfZhidPx9
         eA7CBpjwRcapaKIYdi28RxXpWrX+n1twBH7MK54aLEC6OAmoMxtaTEZgHIqUT9YAJQs0
         oeSNqY0HGikV7zKFdlXQOY2XKYKj1Bg8y35y4dS98GxtSIgxyuCJGFb+s9Vzom+J47/K
         nO6jThQnlRophfn/abHlAYQf491KGKZD5S/9jESraHOXai5NB0X/MO7W/cV6j9oJQiuK
         FyFGVQOLMprDZsXaOtjWnbCan5J5nu6F36xS3FQP9vStytP1K4XERM4E1H5YTEGf+Evj
         Gb1Q==
X-Gm-Message-State: AJIora9ErYNNHDPk27FqmgpVglLxMpHTsbnwDOSuoFFkuSPIAffjNEe2
        9UDhQzS+K7Sk7WL0YVJaEIFZfrzec8Jf/Xz6MkLSRGTq
X-Google-Smtp-Source: AGRyM1tGYZ7fsHIo9OGZG2RI/etkx1iNvTt1xx/TgiT8ZJTO5dWNv2skwUxICBEv6+O1/Asthqf6I0zlz5smXYKZu+M=
X-Received: by 2002:a81:17d0:0:b0:31c:c5e2:fc1e with SMTP id
 199-20020a8117d0000000b0031cc5e2fc1emr17464866ywx.196.1657906167225; Fri, 15
 Jul 2022 10:29:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220711124229.16516-1-lukasz.luba@arm.com> <1198724e-d94f-0b7c-9c4a-90595f8426d2@arm.com>
 <CAJZ5v0gh78z3tw6simaZ5S6dmGvDc-OE6t02N8vQYk-2eoFQgA@mail.gmail.com> <deddd9cc-f517-cff9-e304-e1f09c6784b7@arm.com>
In-Reply-To: <deddd9cc-f517-cff9-e304-e1f09c6784b7@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 15 Jul 2022 19:29:16 +0200
Message-ID: <CAJZ5v0jYzJo2BU-qKkaJog6pYx7SkpgmWGd6vTTkc2T=gx8abw@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: schedutil: Move max CPU capacity to sugov_policy
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 15, 2022 at 1:47 PM Lukasz Luba <lukasz.luba@arm.com> wrote:
>
>
>
> On 7/15/22 12:44, Rafael J. Wysocki wrote:
> > On Fri, Jul 15, 2022 at 10:47 AM Lukasz Luba <lukasz.luba@arm.com> wrote:
> >>
> >> Hi Rafael,
> >>
> >> gentle ping.
> >>
> >> On 7/11/22 13:42, Lukasz Luba wrote:
> >>> There is no need to keep the max CPU capacity in the per_cpu instance.
> >>> Furthermore, there is no need to check and update that variable
> >>> (sg_cpu->max) everytime in the frequency change request, which is part
> >>> of hot path. Instead use struct sugov_policy to store that information.
> >>> Initialize the max CPU capacity during the setup and start callback.
> >>> We can do that since all CPUs in the same frequency domain have the same
> >>> max capacity (capacity setup and thermal pressure are based on that).
> >>>
> >>> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> >>> ---
> >>>    kernel/sched/cpufreq_schedutil.c | 30 +++++++++++++++---------------
> >>>    1 file changed, 15 insertions(+), 15 deletions(-)
> >>
> >> The patch got Ack from Viresh.
> >> Could you take it?
> >
> > Yes, it's there in my queue.  Same for the EM changes.
>
> Thank you Rafael!

Well, the patch doesn't apply on top of 5.19-rc6, because
sugov_get_util() is somewhat different.

Please rebase it and resend.
