Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22158524AC6
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 12:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352832AbiELKtd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 06:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352827AbiELKtU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 06:49:20 -0400
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB67D22D620;
        Thu, 12 May 2022 03:49:18 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id i38so8911056ybj.13;
        Thu, 12 May 2022 03:49:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=73Q4ig9VmqJ22FBOR2b+2j1Ani6FbrMKsnpdJgype9o=;
        b=uUsdP36xRujd6SCekJNuBc+IPRtUT2W8mt0jReGHX4AIM6ELLr8SK80OJIYzn13oKu
         b9Nh+yP75fpPJEbruMrm+VCcm5x0sVWLjVNk8aKc5Z5zZwEhFb3hm+fxjkkW7YuvFJpo
         +Df/lYFyaHhdl+NI0ZIHTIpmZ4shBzMF97QvkaZ8SGYLZrS3I7rn6OuMXbMRHfHut5Q0
         9mMs4chISGF8tsSR86AhYuIu4uO6isp3qhs7dgU2IrlCw+4/NlXzmEzrKsEqJxLv0UcL
         ct4a9kCXpHgSUF3VYGm9TvcDOT/YWI0/PySzrGxHCoXLX5dKiKDAjEGxIE/42IU3/lRA
         4hog==
X-Gm-Message-State: AOAM531KEfZMyvjoNnMI8uS+wccv1qLncG+OmDnjHpCcB1QRLZ3heaDU
        LTUSoYs4FCZ6c98z7IMaEsXLxIjKLZs45JiWy6gjHv/HMwU=
X-Google-Smtp-Source: ABdhPJzVx8fUu5InL7ElfenAl55jA+0J6UObydM85W1BeoHrjGnB/WooVOODRolD9IALH1Sd8ri/WmGbiYXXY4t1Zxg=
X-Received: by 2002:a25:e792:0:b0:645:7ddb:b5eb with SMTP id
 e140-20020a25e792000000b006457ddbb5ebmr27902834ybh.482.1652352557949; Thu, 12
 May 2022 03:49:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220510035259.5ep52sgahd2a6rie@vireshk-i7> <20220510154236.88753-1-schspa@gmail.com>
 <20220511043515.fn2gz6q3kcpdai5p@vireshk-i7> <CAMA88TpefB=rnqea2u1zEvNUJNE_kdj4mYito7SGCuMj-o071Q@mail.gmail.com>
 <20220511122114.wccgyur6g3qs6fps@vireshk-i7> <CAJZ5v0gN_yDFpvCXRXv8rN-i3TugCi-HKpBKK2z4eWU0Zm1GUg@mail.gmail.com>
 <CAJZ5v0id+7vkqMQEyVRe29oF_dRtzZ0EhoYUn8=yzeENDeABJw@mail.gmail.com> <20220512065623.q4aa6y52pst3zpxu@vireshk-i7>
In-Reply-To: <20220512065623.q4aa6y52pst3zpxu@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 12 May 2022 12:49:07 +0200
Message-ID: <CAJZ5v0jeYiZ6esdxnJbOyDztNqOAbjcjxmpca3JTFWRh+cwdBw@mail.gmail.com>
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

On Thu, May 12, 2022 at 8:56 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 11-05-22, 15:19, Rafael J. Wysocki wrote:
> > On Wed, May 11, 2022 at 2:59 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > > Hmm, I don't think depending on the values of policy->cpus is a good idea to be
> > > > honest. This design is inviting bugs to come in at another place. We need a
> > > > clear flag for this, a new flag or something like policy_list.
> >
> > Why?
>
> Because it doesn't mean anything unless we have code elsewhere which checks this
> specifically. It should be fine though after using policy_is_inactive() in
> show/store as you suggested, which I too tried to do in a patch :)
>
> > > > Also I see the same bug happening while the policy is removed. The kobject is
> > > > put after the rwsem is dropped.
> >
> > This shouldn't be a problem because of the wait_for_completion() in
> > cpufreq_policy_put_kobj().  It is known that cpufreq_sysfs_release()
> > has run when cpufreq_policy_put_kobj() returns, so it is safe to free
> > the policy then.
>
> I agree to that, but the destruction of stuff happens right in
> cpufreq_policy_free() where it starts removing the policy from the list and
> clears cpufreq_cpu_data. I don't know if it will break anything or not, but we
> should disallow any further sysfs operations once we have reached
> cpufreq_policy_free().

Well, would there be a problem with moving the
cpufreq_policy_put_kobj() call to the front of cpufreq_policy_free()?
If we did that, we'd know that everything could be torn down safely,
because nobody would be holding references to the policy any more.

> > TBH, I'm not sure why show() doesn't check policy_is_inactive() under the rwsem.
>
> I agree, both show/store should have it.
>
> > Moreover, I'm not sure why the locking dance in store() is necessary.
>
> commit fdd320da84c6 ("cpufreq: Lock CPU online/offline in cpufreq_register_driver()")

I get that, but I'm wondering if locking CPU hotplug from store() is
needed at all.  I mean, if we are in store(), we are holding an active
reference to the policy kobject, so the policy cannot go away until we
are done anyway.  Thus it should be sufficient to use the policy rwsem
for synchronization.
