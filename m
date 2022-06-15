Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8293354C0FB
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 07:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235839AbiFOFAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 01:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242811AbiFOFAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 01:00:01 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4734742A1A
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 22:00:00 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id o6so9464434plg.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 22:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sx5jo/gbFVJjPOu+uKpvsodcdaX5x99B9E4XzLwdmWE=;
        b=OQ8sG8CIkLtszKiLLTbek6gsfIzVYrVUnGvHrzhqIDwP1bxZlqzHk9XdeP8wt0c/Yo
         w7T145mRWtwh46Siau1jtn/tXHZ5BvJkUFRHuU4sd9Z1mQn+9yzZ0uxsLTlMOwVR/MmJ
         eXnAJ4qILZOQRhwW3RZhCXP00VewUqcKlZoq8iKpqds4bqmNwDRnWnrWfPlo3rMoXwnP
         8IZ912AjBBZVMJbCQi9boHwjt/ndymi58Ov+67xEO9O4bFc3efq/9axTkfpw+ZalR/qI
         Wiy7locTtxA2D+9KrzK50zSxCqDd2+OjPPwNBRMZrs4dzGEF98HXoJN93j/PTi01RiN6
         NoJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sx5jo/gbFVJjPOu+uKpvsodcdaX5x99B9E4XzLwdmWE=;
        b=wSbZpFWDoiW/+qyQE2l0aEV8/rd/u/em2fdTPbiyEfszGpuBjs6erK7MZxLXdCr8Bn
         HeiFoUNE+cVgtoN4Rxg4fvBZEjJ5VIKY9JlWTlRKBNE2+yrJKleGAYuxh1QYB9lD50ZM
         1lwGgZt89NlrZgeL/dxHlb/JGOl0nhGuRW8TAssZYYnOHcPUpDm9YppSTYcq7dzUw7MF
         c59ZS/2whWBUDvAT3E/dq7HD+M0QhOasc5K+eAbqavwGUuCRmX1xznL2S3AvwyHzkoNT
         y9mD09pUl1EcDjiVfpmB2JY6WczA/iMn6T72TehW6RljqXhah2VdNl4xT9RS5kd0NUN3
         ULlA==
X-Gm-Message-State: AJIora9xJtgOxYw+YLeVU7xP0nmr+lPT//BpWehbONrS/fR9/oMLVaPC
        ygrdYQqzyTVktmEy3ToaUNNAfypv/3W3GQ==
X-Google-Smtp-Source: AGRyM1u2vA9N4bZpg7V9qLUF19XkH2La7QrUIbQA654KDtyevtqXUBfRbeaRFA6ZFNCrblKGfgwQxg==
X-Received: by 2002:a17:902:8e8b:b0:168:a135:d636 with SMTP id bg11-20020a1709028e8b00b00168a135d636mr7343989plb.140.1655269199764;
        Tue, 14 Jun 2022 21:59:59 -0700 (PDT)
Received: from localhost ([122.162.234.2])
        by smtp.gmail.com with ESMTPSA id f13-20020a170902684d00b0015e8d4eb26csm8154990pln.182.2022.06.14.21.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 21:59:59 -0700 (PDT)
Date:   Wed, 15 Jun 2022 10:29:57 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        kernel test robot <oliver.sang@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2 2/3] cpufreq: Panic if policy is active in
 cpufreq_policy_free()
Message-ID: <20220615045957.55ocdyddcac3vwct@vireshk-i7>
References: <8c3d50faf8811e86136fb3f9c459e43fc3c50bc0.1653565641.git.viresh.kumar@linaro.org>
 <426bf6edc80b2e944d459fa7b8dffbe8b73bb3d9.1653623526.git.viresh.kumar@linaro.org>
 <CAJZ5v0gswDEdK9-gC1dPr9BFPv3G9rs+JYe-7=1JZ11OMoBb-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gswDEdK9-gC1dPr9BFPv3G9rs+JYe-7=1JZ11OMoBb-g@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14-06-22, 15:59, Rafael J. Wysocki wrote:
> On Fri, May 27, 2022 at 5:53 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > With the new design in place, to avoid potential races show() and
> > store() callbacks check if the policy is active or not before proceeding
> > any further. And in order to guarantee that cpufreq_policy_free() must
> > be called after clearing the policy->cpus mask, i.e. by marking it
> > inactive.
> >
> > Lets make sure we don't get a bug around this later and catch this early
> > by putting a BUG_ON() within cpufreq_policy_free().
> >
> > Also update cpufreq_online() a bit to make sure we clear the cpus mask
> > for each error case before calling cpufreq_policy_free().
> >
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> > V2: Update cpufreq_online() and changelog.
> >
> >  drivers/cpufreq/cpufreq.c | 9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > index e24aa5d4bca5..0f8245731783 100644
> > --- a/drivers/cpufreq/cpufreq.c
> > +++ b/drivers/cpufreq/cpufreq.c
> > @@ -1284,6 +1284,12 @@ static void cpufreq_policy_free(struct cpufreq_policy *policy)
> >         unsigned long flags;
> >         int cpu;
> >
> > +       /*
> > +        * The callers must ensure the policy is inactive by now, to avoid any
> > +        * races with show()/store() callbacks.
> > +        */
> > +       BUG_ON(!policy_is_inactive(policy));
> 
> I'm not a super-big fan of this change.
> 
> First off, crashing the kernel outright here because of possible races
> appears a bit excessive to me.
> 
> Second, it looks like we are worrying about the code running before
> the wait_for_completion() call in cpufreq_policy_put_kobj(), because
> after that call no one can be running show() or store().  So why don't
> we reorder the wait_for_completion() call with respect to the code in
> question instead?

No, I am not worrying about that race. I am just trying to make sure some change
in future doesn't break this assumption (that policy should be inactive by this
point). That's all. It all looks good for now.

May be a WARN instead of BUG if we don't want to crash.

-- 
viresh
