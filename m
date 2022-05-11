Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 972C1523303
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 14:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237729AbiEKMVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 08:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiEKMVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 08:21:21 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BF9EF61D3
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 05:21:19 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id g8so1841256pfh.5
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 05:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Zu0vDG30iDCeqnvFJYec9mPAq1krcLLpZzNBmfizPr4=;
        b=WTYai0R1CMae7C1ojqbvv26/WoYECprNeG9MvrAYCP6U1EyTXTWDpoKDSoA6u/McUx
         8x3eGcSqBPgwhsQPNijFjuoHLclOUA2Uh6Lfs08wDjOKTEGk+hyNbaiLmwi1xgfH41pl
         CoWVqqXQaLX5Jw7quRJeOSFKvLqlifBhCKrr4zF6LGU0Ad1TcxXX3JWlxEx2Hthxor7I
         gw2WBLlKnidi0cc6HdVITzw0BOgtg8HUyDpM1n6l9b8zFYDfwvKtxWNWxGfNfn/zctFA
         zw273z6pJ1ri+H6YSPZYT9a8cP65J0uhpyervzCLg1w7GqZO4UFlIjtmXqcp7FgMA3vu
         h8Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Zu0vDG30iDCeqnvFJYec9mPAq1krcLLpZzNBmfizPr4=;
        b=N+ab2ZWvDYU1L3omRzpC0HtO7K/Q25V0hlPnWdMUtBF0PMGjhfJShuWIgDeMaQv5jH
         IdD/TswX8fDMEi+iFqimaZ6Gy/nBwaUGLrAdnD9wQrwhvcdkPVbA43PUs+3oi/sekq1i
         o1P7Ay32n2SZMHEEL5bxFLyCrk8m2k3jGHEUrIfGNfDy6o/ghvwmoHfeZPgvVDtojG/g
         qIuzNGoV9fCptM8flt8gu7HZVkssW0/Ofd8pNTCObmHrvZkxKa3ymy/2gDEFAE588+MY
         UfjsfBS3/SJPYsm9cHZT3d6q5gMid2JItv9JrtLRgyf9AkKDFQHSdA8A2/J3FVJr20yV
         WrIA==
X-Gm-Message-State: AOAM5303G1Okv8tTc90n/yScK46/Ls6luJ8bL1Gypm7FNuyON77jA+hX
        Y8HzNjXirCILgeTgCe1KY0Tj6w==
X-Google-Smtp-Source: ABdhPJya6SegzD3EabAH8KzEFVPIw8qnKM7iVqDqXyicbd53l/POubpHSHyTI3C1nH5iFiRrtFMzkg==
X-Received: by 2002:a05:6a00:1352:b0:510:4c0e:d230 with SMTP id k18-20020a056a00135200b005104c0ed230mr25470973pfu.79.1652271679049;
        Wed, 11 May 2022 05:21:19 -0700 (PDT)
Received: from localhost ([122.162.234.2])
        by smtp.gmail.com with ESMTPSA id r3-20020a632b03000000b003c14af505edsm1677853pgr.5.2022.05.11.05.21.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 05:21:17 -0700 (PDT)
Date:   Wed, 11 May 2022 17:51:14 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Schspa Shi <schspa@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rafael@kernel.org
Subject: Re: [PATCH v3] cpufreq: fix race on cpufreq online
Message-ID: <20220511122114.wccgyur6g3qs6fps@vireshk-i7>
References: <20220510035259.5ep52sgahd2a6rie@vireshk-i7>
 <20220510154236.88753-1-schspa@gmail.com>
 <20220511043515.fn2gz6q3kcpdai5p@vireshk-i7>
 <CAMA88TpefB=rnqea2u1zEvNUJNE_kdj4mYito7SGCuMj-o071Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMA88TpefB=rnqea2u1zEvNUJNE_kdj4mYito7SGCuMj-o071Q@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11-05-22, 16:10, Schspa Shi wrote:
> Viresh Kumar <viresh.kumar@linaro.org> writes:
> > I am not sure, but maybe there were issues in calling init() with rwsem held, as
> > it may want to call some API from there.
> >
> 
> I have checked all the init() implement of the fellowing files, It should be OK.
> Function find command:
>   ag "init[\s]+=" drivers/cpufreq
> 
> All the init() implement only initialize policy object without holding this lock
> and won't call cpufreq APIs need to hold this lock.

Okay, we can see if someone complains later then :)

> > I don't think you can do that safely. offline() or exit() may depend on
> > policy->cpus being set to all CPUs.
> OK, I will move this after exit(). and there will be no effect with those
> two APIs. But policy->cpus must be clear before release policy->rwsem.

Hmm, I don't think depending on the values of policy->cpus is a good idea to be
honest. This design is inviting bugs to come in at another place. We need a
clear flag for this, a new flag or something like policy_list.

Also I see the same bug happening while the policy is removed. The kobject is
put after the rwsem is dropped.

> >  static inline bool policy_is_inactive(struct cpufreq_policy *policy)
> >  {
> > -     return cpumask_empty(policy->cpus);
> > +     return unlikely(cpumask_empty(policy->cpus) ||
> > +                     list_empty(&policy->policy_list));
> >  }
> >
> 
> I don't think this fully solves my problem.
> 1. There is some case which cpufreq_online failed after the policy is added to
>    cpufreq_policy_list.

And I missed that :(

> 2. policy->policy_list is not protected by &policy->rwsem, and we
> can't relay on this to
>    indict the policy is fine.

Ahh..

> >From this point of view, we can fix this problem through the state of
> this linked list.
> But the above two problems need to be solved first.

I feel overriding policy_list for this is going to make it complex/messy.

Maybe something like this then:

-------------------------8<-------------------------

From dacc8d09d4d7b3d9a8bca8d78fc72199c16dc4a5 Mon Sep 17 00:00:00 2001
Message-Id: <dacc8d09d4d7b3d9a8bca8d78fc72199c16dc4a5.1652271581.git.viresh.kumar@linaro.org>
From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Wed, 11 May 2022 09:13:26 +0530
Subject: [PATCH] cpufreq: Allow sysfs access only for active policies

It is currently possible, in a corner case, to access the sysfs files
and reach show_cpuinfo_cur_freq(), etc, for a partly initialized policy.

This can happen for example if cpufreq_online() fails after adding the
sysfs files, which are immediately accessed by another process. There
can easily be other such cases, which aren't identified yet, like while
the policy is getting freed.

Process A:					Process B

cpufreq_online()
  down_write(&policy->rwsem);
  if (new_policy) {
    ret = cpufreq_add_dev_interface(policy);
    /* This fails after adding few files */
    if (ret)
      goto out_destroy_policy;

    ...
  }

  ...

out_destroy_policy:
  ...
  up_write(&policy->rwsem);
						/*
						 * This will end up accessing the policy
						 * which isn't fully initialized.
						 */
						show_cpuinfo_cur_freq()

if (cpufreq_driver->offline)
    cpufreq_driver->offline(policy);

  if (cpufreq_driver->exit)
    cpufreq_driver->exit(policy);

  cpufreq_policy_free(policy);

Fix these by checking in show/store if the policy is sysfs ready or not.

Reported-by: Schspa Shi <schspa@gmail.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 18 ++++++++++++++----
 include/linux/cpufreq.h   |  3 +++
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index c8bf6c68597c..65c2bbcf555d 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -948,13 +948,14 @@ static ssize_t show(struct kobject *kobj, struct attribute *attr, char *buf)
 {
 	struct cpufreq_policy *policy = to_policy(kobj);
 	struct freq_attr *fattr = to_attr(attr);
-	ssize_t ret;
+	ssize_t ret = -EBUSY;
 
 	if (!fattr->show)
 		return -EIO;
 
 	down_read(&policy->rwsem);
-	ret = fattr->show(policy, buf);
+	if (policy->sysfs_ready)
+		ret = fattr->show(policy, buf);
 	up_read(&policy->rwsem);
 
 	return ret;
@@ -965,7 +966,7 @@ static ssize_t store(struct kobject *kobj, struct attribute *attr,
 {
 	struct cpufreq_policy *policy = to_policy(kobj);
 	struct freq_attr *fattr = to_attr(attr);
-	ssize_t ret = -EINVAL;
+	ssize_t ret = -EBUSY;
 
 	if (!fattr->store)
 		return -EIO;
@@ -979,7 +980,8 @@ static ssize_t store(struct kobject *kobj, struct attribute *attr,
 
 	if (cpu_online(policy->cpu)) {
 		down_write(&policy->rwsem);
-		ret = fattr->store(policy, buf, count);
+		if (policy->sysfs_ready)
+			ret = fattr->store(policy, buf, count);
 		up_write(&policy->rwsem);
 	}
 
@@ -1280,6 +1282,11 @@ static void cpufreq_policy_free(struct cpufreq_policy *policy)
 	unsigned long flags;
 	int cpu;
 
+	/* Disallow sysfs interactions now */
+	down_write(&policy->rwsem);
+	policy->sysfs_ready = false;
+	up_write(&policy->rwsem);
+
 	/* Remove policy from list */
 	write_lock_irqsave(&cpufreq_driver_lock, flags);
 	list_del(&policy->policy_list);
@@ -1516,6 +1523,9 @@ static int cpufreq_online(unsigned int cpu)
 		goto out_destroy_policy;
 	}
 
+	/* We can allow sysfs interactions now */
+	policy->sysfs_ready = true;
+
 	up_write(&policy->rwsem);
 
 	kobject_uevent(&policy->kobj, KOBJ_ADD);
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 35c7d6db4139..7e4384e535fd 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -101,6 +101,9 @@ struct cpufreq_policy {
 	 */
 	struct rw_semaphore	rwsem;
 
+	/* Policy is ready for sysfs interactions */
+	bool			sysfs_ready;
+
 	/*
 	 * Fast switch flags:
 	 * - fast_switch_possible should be set by the driver if it can
-- 
2.31.1.272.g89b43f80a514

