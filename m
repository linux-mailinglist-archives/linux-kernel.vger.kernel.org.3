Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 893A05689FA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 15:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233591AbiGFNte (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 09:49:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233552AbiGFNtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 09:49:24 -0400
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 861541E3DC;
        Wed,  6 Jul 2022 06:49:21 -0700 (PDT)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-31c9b70c382so78127607b3.6;
        Wed, 06 Jul 2022 06:49:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dtlZocyToFGVGM2MQv4D5WyH03DgmYnmulWgb2UYDDM=;
        b=5sTNTd959nviLdhYXPo32JN94yMddzVGvOEmZR2Gbt6cIsyfUPytCQC9x1WCuSGKXy
         xLGuAEkDEmsR45ND6N65PRlQRjdb3iNrjCHNFNJaZewKUkJxpde2JFeBH9Ds6HilX+GF
         EWggPWcj6SBJHSmoqT8GRItcG6X+gciLi5JoGLf3GM4tDqbsKmxstvK3VPynj4fi7hxL
         disixYF6FyjiiO17AFwwFbu6AvkcRFX1iPj2Fa9VbGiytkzSixYzGdZ/4bA32IPazoh5
         ITRVEkns6rbKjzvh7zCWs3bbmmp4bPHd7bNPLla153an+WqG+LKK/1AaVmM4J4EZc5I4
         uVDw==
X-Gm-Message-State: AJIora8/mjxVLZu67D2qghMyEjcjv7rP1GQOnE7WWOdIuIBQTpYWiBTE
        ypDTtzWSX3hYElUJ6Y0DBk9tiKb8jr7OGP1SXlA=
X-Google-Smtp-Source: AGRyM1vr1wi9w9NCemLoidvbCweBYnR1fD94J+vYgMW//deWJxOLNs20DDiRmD9h3ILhGY+rqoURrgi4/Rat+LO9y+c=
X-Received: by 2002:a81:17d0:0:b0:31c:c5e2:fc1e with SMTP id
 199-20020a8117d0000000b0031cc5e2fc1emr10086071ywx.196.1657115360660; Wed, 06
 Jul 2022 06:49:20 -0700 (PDT)
MIME-Version: 1.0
References: <8c3d50faf8811e86136fb3f9c459e43fc3c50bc0.1653565641.git.viresh.kumar@linaro.org>
 <426bf6edc80b2e944d459fa7b8dffbe8b73bb3d9.1653623526.git.viresh.kumar@linaro.org>
 <CAJZ5v0gswDEdK9-gC1dPr9BFPv3G9rs+JYe-7=1JZ11OMoBb-g@mail.gmail.com> <20220615045957.55ocdyddcac3vwct@vireshk-i7>
In-Reply-To: <20220615045957.55ocdyddcac3vwct@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 6 Jul 2022 15:49:09 +0200
Message-ID: <CAJZ5v0gDCS8mkoFjnqOAi9gGuhTheE79FwvRWgeoxagMj3Ok0Q@mail.gmail.com>
Subject: Re: [PATCH V2 2/3] cpufreq: Panic if policy is active in cpufreq_policy_free()
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        kernel test robot <oliver.sang@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Wed, Jun 15, 2022 at 7:00 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 14-06-22, 15:59, Rafael J. Wysocki wrote:
> > On Fri, May 27, 2022 at 5:53 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > >
> > > With the new design in place, to avoid potential races show() and
> > > store() callbacks check if the policy is active or not before proceeding
> > > any further. And in order to guarantee that cpufreq_policy_free() must
> > > be called after clearing the policy->cpus mask, i.e. by marking it
> > > inactive.
> > >
> > > Lets make sure we don't get a bug around this later and catch this early
> > > by putting a BUG_ON() within cpufreq_policy_free().
> > >
> > > Also update cpufreq_online() a bit to make sure we clear the cpus mask
> > > for each error case before calling cpufreq_policy_free().
> > >
> > > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > > ---
> > > V2: Update cpufreq_online() and changelog.
> > >
> > >  drivers/cpufreq/cpufreq.c | 9 +++++++--
> > >  1 file changed, 7 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > > index e24aa5d4bca5..0f8245731783 100644
> > > --- a/drivers/cpufreq/cpufreq.c
> > > +++ b/drivers/cpufreq/cpufreq.c
> > > @@ -1284,6 +1284,12 @@ static void cpufreq_policy_free(struct cpufreq_policy *policy)
> > >         unsigned long flags;
> > >         int cpu;
> > >
> > > +       /*
> > > +        * The callers must ensure the policy is inactive by now, to avoid any
> > > +        * races with show()/store() callbacks.
> > > +        */
> > > +       BUG_ON(!policy_is_inactive(policy));
> >
> > I'm not a super-big fan of this change.
> >
> > First off, crashing the kernel outright here because of possible races
> > appears a bit excessive to me.
> >
> > Second, it looks like we are worrying about the code running before
> > the wait_for_completion() call in cpufreq_policy_put_kobj(), because
> > after that call no one can be running show() or store().  So why don't
> > we reorder the wait_for_completion() call with respect to the code in
> > question instead?
>
> No, I am not worrying about that race. I am just trying to make sure some change
> in future doesn't break this assumption (that policy should be inactive by this
> point). That's all. It all looks good for now.
>
> May be a WARN instead of BUG if we don't want to crash.

WARN_ON() would be somewhat better, but then I'm not sure if having a
full call trace in this case is really useful, because we know when
cpufreq_policy_free() can be called anyway.

Maybe just print a warning message.
