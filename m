Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10F225329AC
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 13:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237014AbiEXLsW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 07:48:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232178AbiEXLsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 07:48:20 -0400
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D68F722BCA;
        Tue, 24 May 2022 04:48:19 -0700 (PDT)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-30007f11f88so47080867b3.7;
        Tue, 24 May 2022 04:48:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p8BgjPR75xXU784y1E9IpwjBGFVwhDEOmbSXQMTZJNI=;
        b=L5klvGbovapfMhJKruKmDk0BCWvGQ8WlFGPKz8bw2sGbvTl5IRGS1aEd2chI8EcF50
         kXBua6Iul2VWw5tktT1o5iY0kZk7XKRQfzeQVY76Dt4wYpwmiieszPcEiOiQjtZ3B3nY
         DTPHNzUfcaCMCCJ9AQqqJtjk2PswDfxCGDhENW6+JwL+P4T7fOht14bYl7RyP9b0xptm
         DvwCl0TZpUlGtpX7Dzdk5kJWlh6vzxXsRCx8TfH9zglf08m0IUowDmmia56QWHigNH1y
         s+Qv5zskbkUqamneWOzDtZgid8aJSPFGJi0Eyilrq1z/0fFGIpg9m1SpMcgF0hb8H51p
         JmxQ==
X-Gm-Message-State: AOAM533+GUHRWZIeEKh1RhjkUfMhahFoYnL3/nkdN+Z/2URs/qvisK7D
        gx5qLB0ijaAqXGBFqC/sBOgJXL6nRWpP9M9i0UxO602K
X-Google-Smtp-Source: ABdhPJwIksFiH36EcdjExwNKIRCQVW1lwZKevy5F/LJChCNsmlcDU6QnUfYZHSUrJXIeE7OUMuVyJmLg5HwjIA+jkGA=
X-Received: by 2002:a81:91d4:0:b0:2fe:e300:3581 with SMTP id
 i203-20020a8191d4000000b002fee3003581mr27973637ywg.7.1653392899108; Tue, 24
 May 2022 04:48:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220511043515.fn2gz6q3kcpdai5p@vireshk-i7> <CAMA88TpefB=rnqea2u1zEvNUJNE_kdj4mYito7SGCuMj-o071Q@mail.gmail.com>
 <20220511122114.wccgyur6g3qs6fps@vireshk-i7> <CAJZ5v0gN_yDFpvCXRXv8rN-i3TugCi-HKpBKK2z4eWU0Zm1GUg@mail.gmail.com>
 <CAJZ5v0id+7vkqMQEyVRe29oF_dRtzZ0EhoYUn8=yzeENDeABJw@mail.gmail.com>
 <20220512065623.q4aa6y52pst3zpxu@vireshk-i7> <CAJZ5v0jeYiZ6esdxnJbOyDztNqOAbjcjxmpca3JTFWRh+cwdBw@mail.gmail.com>
 <20220513042705.nbnd6vccuiu6lb7a@vireshk-i7> <20220524111456.hw4qugsvt4bm7reh@vireshk-i7>
 <CAJZ5v0i_qpcaUwdZY=KR_e=HC6MZUw2aDGL=hxgo866dF1zwOA@mail.gmail.com> <20220524112917.apcvvvblksg7jdu4@vireshk-i7>
In-Reply-To: <20220524112917.apcvvvblksg7jdu4@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 24 May 2022 13:48:08 +0200
Message-ID: <CAJZ5v0jRtYcscWjUras9RC9LOTHf=qu1SPBhnC=52Gb3KKAQNw@mail.gmail.com>
Subject: Re: [PATCH v3] cpufreq: fix race on cpufreq online
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Schspa Shi <schspa@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
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

On Tue, May 24, 2022 at 1:29 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 24-05-22, 13:22, Rafael J. Wysocki wrote:
> > On Tue, May 24, 2022 at 1:15 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > >
> > > On 13-05-22, 09:57, Viresh Kumar wrote:
> > > > On 12-05-22, 12:49, Rafael J. Wysocki wrote:
> > > > > > > Moreover, I'm not sure why the locking dance in store() is necessary.
> > > > > >
> > > > > > commit fdd320da84c6 ("cpufreq: Lock CPU online/offline in cpufreq_register_driver()")
> > > > >
> > > > > I get that, but I'm wondering if locking CPU hotplug from store() is
> > > > > needed at all.  I mean, if we are in store(), we are holding an active
> > > > > reference to the policy kobject, so the policy cannot go away until we
> > > > > are done anyway.  Thus it should be sufficient to use the policy rwsem
> > > > > for synchronization.
> > > >
> > > > I think after the current patchset is applied and we have the inactive
> > > > policy check in store(), we won't required the dance after all.
> > >
> > > I was writing a patch for this and then thought maybe look at mails
> > > around this time, when you sent the patch, and found the reason why we
> > > need the locking dance :)
> > >
> > > https://lore.kernel.org/lkml/20150729091136.GN7557@n2100.arm.linux.org.uk/
>
> Actually no, this is for the lock in cpufreq_driver_register().
>
> > Well, again, if we are in store(), we are holding a reference to the
> > policy kobject, so this is not initialization time.
>
> This is the commit which made the change.
>
> commit 4f750c930822 ("cpufreq: Synchronize the cpufreq store_*() routines with CPU hotplug")

So this was done before the entire CPU hotplug rework and it was
useful at that time.

The current code always runs cpufreq_set_policy() under policy->rwsem
and governors are stopped under policy->rwsem, so this particular race
cannot happen AFAICS.

Locking CPU hotplug prevents CPUs from going away while store() is
running, but in order to run store(), the caller must hold an active
reference to the policy kobject.  That prevents the policy from being
freed and so policy->rwsem can be acquired.  After policy->rwsem has
been acquired, policy->cpus can be checked to determine whether or not
there are any online CPUs for the given policy (there may be none),
because policy->cpus is only manipulated under policy->rwsem.

If a CPU that belongs to the given policy is going away,
cpufreq_offline() has to remove it from policy->cpus under
policy->rwsem, so either it has to wait for store() to release
policy->rwsem, or store() will acquire policy->rwsem after it and will
find that policy->cpus is empty.
