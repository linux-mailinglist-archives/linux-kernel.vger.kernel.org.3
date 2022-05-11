Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C202523486
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 15:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234794AbiEKNmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 09:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231907AbiEKNmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 09:42:44 -0400
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41A9B73568;
        Wed, 11 May 2022 06:42:43 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id x17so4109139ybj.3;
        Wed, 11 May 2022 06:42:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U2CF1sPzePx4zRQ9D03pSv7PxSEBSI7R4J8C6F4VN9Q=;
        b=JwkLIvXl35qI8grBgCd+SiIb5faDWkJwuCPu2+BR7uWmgguPqKaUDPeo2uMEWjh+aO
         bYrXznvyUHKmC+BfnVkmjV4evN2+F8ZbzBsrbV9y04VP9volE9cOh3efky1n5FewJULI
         LtXZsveMtuO2iEQ7avpEvT/N6c/dLqhRCch8RmlIWicFNz2lk4rQBQ13njKxHZvwozh8
         wFOkB7FLhF3RZSStl9/9/dnc5TIRJ95SRUF6Kcek1BxRcasIL0KUVjagfZf3wFmjZclM
         EExbyNGlnHkKiLyoJ1khPtQxd8AbzNa15xr3VASqytEDx932ghoblbDZeNFzM7tObtRQ
         N6nw==
X-Gm-Message-State: AOAM533hEKkDfjK5Cm1PpZy5t36gVimMhbLT6I9fd4/ftFpp5z0EtP3o
        ssFrPiruGEjFEPvOJYox9mDBbniLUW5mJdgPzdI=
X-Google-Smtp-Source: ABdhPJw3/GDxdeetEcCODnb2QdJqbqEnwdN6/HkuzGIT772ion1HWIIpZwz/0hxb9xfjdDXwukFEllc0euXiDtyUEaY=
X-Received: by 2002:a25:e792:0:b0:645:7ddb:b5eb with SMTP id
 e140-20020a25e792000000b006457ddbb5ebmr23579494ybh.482.1652276562503; Wed, 11
 May 2022 06:42:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220510035259.5ep52sgahd2a6rie@vireshk-i7> <20220510154236.88753-1-schspa@gmail.com>
 <20220511043515.fn2gz6q3kcpdai5p@vireshk-i7> <CAMA88TpefB=rnqea2u1zEvNUJNE_kdj4mYito7SGCuMj-o071Q@mail.gmail.com>
 <20220511122114.wccgyur6g3qs6fps@vireshk-i7> <CAJZ5v0gN_yDFpvCXRXv8rN-i3TugCi-HKpBKK2z4eWU0Zm1GUg@mail.gmail.com>
 <CAJZ5v0id+7vkqMQEyVRe29oF_dRtzZ0EhoYUn8=yzeENDeABJw@mail.gmail.com>
In-Reply-To: <CAJZ5v0id+7vkqMQEyVRe29oF_dRtzZ0EhoYUn8=yzeENDeABJw@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 11 May 2022 15:42:31 +0200
Message-ID: <CAJZ5v0j6b=JF7SuQGsBiYTZp7hCt8BfiOUNwxX-=TTSQOzZgvQ@mail.gmail.com>
Subject: Re: [PATCH v3] cpufreq: fix race on cpufreq online
To:     Schspa Shi <schspa@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
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

On Wed, May 11, 2022 at 3:19 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Wed, May 11, 2022 at 2:59 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Wed, May 11, 2022 at 2:21 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > >
> > > On 11-05-22, 16:10, Schspa Shi wrote:
> > > > Viresh Kumar <viresh.kumar@linaro.org> writes:
> > > > > I am not sure, but maybe there were issues in calling init() with rwsem held, as
> > > > > it may want to call some API from there.
> > > > >
> > > >
> > > > I have checked all the init() implement of the fellowing files, It should be OK.
> > > > Function find command:
> > > >   ag "init[\s]+=" drivers/cpufreq
> > > >
> > > > All the init() implement only initialize policy object without holding this lock
> > > > and won't call cpufreq APIs need to hold this lock.
> > >
> > > Okay, we can see if someone complains later then :)
> > >
> > > > > I don't think you can do that safely. offline() or exit() may depend on
> > > > > policy->cpus being set to all CPUs.
> > > > OK, I will move this after exit(). and there will be no effect with those
> > > > two APIs. But policy->cpus must be clear before release policy->rwsem.
> > >
> > > Hmm, I don't think depending on the values of policy->cpus is a good idea to be
> > > honest. This design is inviting bugs to come in at another place. We need a
> > > clear flag for this, a new flag or something like policy_list.
>
> Why?
>
> > > Also I see the same bug happening while the policy is removed. The kobject is
> > > put after the rwsem is dropped.
>
> This shouldn't be a problem because of the wait_for_completion() in
> cpufreq_policy_put_kobj().  It is known that cpufreq_sysfs_release()
> has run when cpufreq_policy_put_kobj() returns, so it is safe to free
> the policy then.
>
> > > > >  static inline bool policy_is_inactive(struct cpufreq_policy *policy)
> > > > >  {
> > > > > -     return cpumask_empty(policy->cpus);
> > > > > +     return unlikely(cpumask_empty(policy->cpus) ||
> > > > > +                     list_empty(&policy->policy_list));
> > > > >  }
> > > > >
> > > >
> > > > I don't think this fully solves my problem.
> > > > 1. There is some case which cpufreq_online failed after the policy is added to
> > > >    cpufreq_policy_list.
> > >
> > > And I missed that :(
> > >
> > > > 2. policy->policy_list is not protected by &policy->rwsem, and we
> > > > can't relay on this to
> > > >    indict the policy is fine.
> > >
> > > Ahh..
> > >
> > > > >From this point of view, we can fix this problem through the state of
> > > > this linked list.
> > > > But the above two problems need to be solved first.
> > >
> > > I feel overriding policy_list for this is going to make it complex/messy.
> > >
> > > Maybe something like this then:
> >
> > There are two things.
> >
> > One is the possible race with respect to the sysfs access occurring
> > during failing initialization and the other is that ->offline() or
> > ->exit() can be called with or without holding the policy rwsem
> > depending on the code path.
> >
> > Namely, cpufreq_offline() calls them under the policy rwsem, but
> > cpufreq_remove_dev() calls ->exit() outside the rwsem.  Also they are
> > called outside the rwsem in cpufreq_online().
> >
> > Moreover, ->offline() and ->exit() cannot expect policy->cpus to be
> > populated, because they are called when it is empty from
> > cpufreq_offline().
> >
> > So the $subject patch is correct AFAICS even though it doesn't address
> > all of the above.

Actually, I meant the last version of it, that is:

https://patchwork.kernel.org/project/linux-pm/patch/20220510154236.88753-1-schspa@gmail.com/

> TBH, I'm not sure why show() doesn't check policy_is_inactive() under the rwsem.
>
> Moreover, I'm not sure why the locking dance in store() is necessary.
