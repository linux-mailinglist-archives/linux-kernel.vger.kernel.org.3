Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32D26525277
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 18:24:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356449AbiELQYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 12:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344263AbiELQYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 12:24:05 -0400
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C461C1E5EF6;
        Thu, 12 May 2022 09:24:04 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-2f863469afbso63293587b3.0;
        Thu, 12 May 2022 09:24:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=thtHMzRehtI+V+OgK8quGY/Of/jRrIGIaRefx1ZVDTI=;
        b=PTQE8JAxKqopuPrNPNM6tNRWwFy3tBU04wqFII4+R+eYp8mGI49u4ZeyFGSOfV1CFE
         Ppw8ISAsAD2k5mgpM3UuML2AjYZQM/+b2FAWWZXj+JjngsB2IPa8v+Fk0ELRPgWZi5fK
         qN6QhC9Sj3v/wP1ABV3L6nu8HBSfWyKLNBVgakCB3bqBCc+KWUovpI/wp5wRnZ7pL5ur
         5T46RvJg/Ul0djnhjrPrBJyhZc79ifSoy0eFT+GJXr/S6hRuH8uk7sWbLdqMQEKQ5Oi9
         D0nTxbKNUxgmvbvaY8e2Br4asRTd6StQa0CxAC+94jI0D08cpmsy9Fag06Mi1+kAHAq7
         rcWQ==
X-Gm-Message-State: AOAM5326p4YHm9c1Ny14KX/k0AY8pLYMAgo9hwZ1trlc/x8Feqznax6V
        tQ8BnQhYsjfVOO1z8D+HySxJ9sIiXQQXmrOAqDIOG7zy
X-Google-Smtp-Source: ABdhPJz5dHgHC4COVczQNzeU9FkZjxePoGFWPsWRtlbTZa0wsX+dudZRgsfCf1jg1+hP3iVguixQSQXTVQz0uyo21DY=
X-Received: by 2002:a81:4b8e:0:b0:2ef:5240:69fc with SMTP id
 y136-20020a814b8e000000b002ef524069fcmr932781ywa.19.1652372643823; Thu, 12
 May 2022 09:24:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220512135231.10076-1-schspa@gmail.com> <20220512135231.10076-2-schspa@gmail.com>
 <CAJZ5v0htGfZ3G+BWgZSxvcEAhNd_LONm8rNMetdPts3uZ=Tcxw@mail.gmail.com> <CAMA88TodZJYmd2GnWty=qCw7T=LG9jihEAmT+RPK8tSBqdiubA@mail.gmail.com>
In-Reply-To: <CAMA88TodZJYmd2GnWty=qCw7T=LG9jihEAmT+RPK8tSBqdiubA@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 12 May 2022 18:23:52 +0200
Message-ID: <CAJZ5v0h5QbKRg+1428EdEziV-ovuav396c6fwAaOnrDe=NU46A@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] cpufreq: make interface functions and lock holding
 state clear
To:     Schspa Shi <schspa@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
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

On Thu, May 12, 2022 at 6:01 PM Schspa Shi <schspa@gmail.com> wrote:
>
> "Rafael J. Wysocki" <rafael@kernel.org> writes:
>
> > On Thu, May 12, 2022 at 3:52 PM Schspa Shi <schspa@gmail.com> wrote:
> >>
> >> cpufreq_offline() calls offline() and exit() under the policy rwsem
> >> But they are called outside the rwsem in cpufreq_online().
> >>
> >> This patch move the offline(), exit(), online(), init() to be inside
> >> of policy rwsem to achieve a clear lock relationship.
> >>
> >> All the init() online() implement only initialize policy object without
> >> holding this lock and won't call cpufreq APIs need to hold this lock.
> >>
> >> Signed-off-by: Schspa Shi <schspa@gmail.com>
> >
> > IMV this still addresses 2 different issues and so it should be split
> > into 2 different patches.
> >
> >> ---
> >>  drivers/cpufreq/cpufreq.c | 5 ++---
> >>  1 file changed, 2 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> >> index 35dffd738580..f242d5488364 100644
> >> --- a/drivers/cpufreq/cpufreq.c
> >> +++ b/drivers/cpufreq/cpufreq.c
> >
> > Patch 1:
> >
> >> @@ -1343,12 +1343,12 @@ static int cpufreq_online(unsigned int cpu)
> >>                 down_write(&policy->rwsem);
> >>                 policy->cpu = cpu;
> >>                 policy->governor = NULL;
> >> -               up_write(&policy->rwsem);
> >>         } else {
> >>                 new_policy = true;
> >>                 policy = cpufreq_policy_alloc(cpu);
> >>                 if (!policy)
> >>                         return -ENOMEM;
> >> +               down_write(&policy->rwsem);
> >>         }
> >>
> >>         if (!new_policy && cpufreq_driver->online) {
> >> @@ -1388,7 +1388,6 @@ static int cpufreq_online(unsigned int cpu)
> >>                 cpumask_copy(policy->related_cpus, policy->cpus);
> >>         }
> >>
> >> -       down_write(&policy->rwsem);
> >>         /*
> >>          * affected cpus must always be the one, which are online. We aren't
> >>          * managing offline cpus here.
> >
> > which addresses the problem that cpufreq_online() updates the
> > policy->cpus and related_cpus masks without holding the policy rwsem
> > (since the policy kobject has been registered already at this point,
> > this is generally unsafe).
> >
> > A side-effect of it is that ->online() and ->init() will be called
> > under the policy rwsem now, but that should be fine and is more
> > consistent than the current code too.
> >
> > Patch 2:
> >
> >> @@ -1540,7 +1539,6 @@ static int cpufreq_online(unsigned int cpu)
> >>                 remove_cpu_dev_symlink(policy, get_cpu_device(j));
> >>
> >>         cpumask_clear(policy->cpus);
> >> -       up_write(&policy->rwsem);
> >>
> >>  out_offline_policy:
> >>         if (cpufreq_driver->offline)
> >> @@ -1549,6 +1547,7 @@ static int cpufreq_online(unsigned int cpu)
> >>  out_exit_policy:
> >>         if (cpufreq_driver->exit)
> >>                 cpufreq_driver->exit(policy);
> >> +       up_write(&policy->rwsem);
> >>
> >>  out_free_policy:
> >>         cpufreq_policy_free(policy);
> >> --
> >
> > which addressed the issue of calling ->offline() and ->exit() without
> > holding the policy rwsem that is at best inconsistent with
> > cpufreq_offline().
>
> No, we can't split this into two different patches. which will cause a
> uninitialized unlock for policy rwsem.
> This will make the git bitsec unusable.
>
> Which Dan Carpenter reported, and cause the patch of the v1 version to
> be reverted.
>
> Link: https://lore.kernel.org/all/YnKZCGaig+EXSowf@kili/

Ah, OK.  Never mind.
