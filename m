Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D42B2522B10
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 06:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234961AbiEKEfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 00:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234634AbiEKEfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 00:35:19 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4ADE9B1AC
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 21:35:18 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id c9so754437plh.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 21:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dV4WsBT9ftPx6yaQb9rdbf6XsiVSnfObebmDzI5cz4I=;
        b=OyLfG1JFN9LPV9gAe3HeVkM+fm3O5Rm5aQ4dv8I2HYmkSt6AcGB2erlPyAUXo9fz2X
         wN4YIWy/gK9zIXGfQbS9cWsoIZ/FO2srrXwT7xWcTAFQwF1t3/VnGeHjxo3NbtywfddD
         GgGQ6GbBBwOUAmJse1+ivEEM1CE022upJSE/MQV3E9vWLBv0pduxs1sqcds0pi60MkYy
         38q1RTZn7cSYaNjf67H+XX4PANLTeiJqVIm11mWeUG0ABLouWRw/d78E/ghW/xU13dz/
         m+xgypK1c2BY/+GD/GJAMzn8dZjFiM4qJ3hjhjXBzQpO/5IDC6xLDXV6fqgmZLItG9OW
         NaZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dV4WsBT9ftPx6yaQb9rdbf6XsiVSnfObebmDzI5cz4I=;
        b=HUz8fioDrLvkQZovrRXJxo7lYWVFoHrtE5AZUffcb17P+36A1UC5SuyTiEI0DgjpJq
         4ooUNfACi4cPSxQMOSfBDJCoRIjxF+gyZGoM+6R5+Q3TwvU6EpEvQLgxHsTvgmAHo4Sl
         oumJtiB6WtkO66ydjSgzBVSzx2vUplT8INDVop45VK8eRZPBQjh/QDpj494DpE6ShroU
         RxzTuQOrrCSxrdGsPl5R+FqcwtHojzDPHrK9qvluKydmjf9GXJ+If58xWNBN3FR9lSdh
         fQDtzSQ6c/F3SpHpO7WnajLc34cdcpIWcf8lWEQNtE58ya5en/PSf3wDS+W/Ui0jZJtV
         kIwQ==
X-Gm-Message-State: AOAM5317PvOLgVbgDOo8TvWT9rIQUarlU5TRjLxZ8KmuvptFJHjyS3ik
        XkxkaysYc/ewGjDdLLQQCgxbWA==
X-Google-Smtp-Source: ABdhPJxGhj4QhJC/wnNwmC1f907XtQnF5Lx8eQ5FWQi5l5r8ulD7vJxK5irUq1FnZURG61cJNVBLuA==
X-Received: by 2002:a17:902:d48d:b0:15e:c236:4fd3 with SMTP id c13-20020a170902d48d00b0015ec2364fd3mr23683614plg.113.1652243718250;
        Tue, 10 May 2022 21:35:18 -0700 (PDT)
Received: from localhost ([122.162.234.2])
        by smtp.gmail.com with ESMTPSA id w10-20020a170902e88a00b0015e8d4eb1c2sm535966plg.12.2022.05.10.21.35.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 21:35:17 -0700 (PDT)
Date:   Wed, 11 May 2022 10:05:15 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Schspa Shi <schspa@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rafael@kernel.org
Subject: Re: [PATCH v3] cpufreq: fix race on cpufreq online
Message-ID: <20220511043515.fn2gz6q3kcpdai5p@vireshk-i7>
References: <20220510035259.5ep52sgahd2a6rie@vireshk-i7>
 <20220510154236.88753-1-schspa@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220510154236.88753-1-schspa@gmail.com>
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

Don't use in-reply-to for single patches. It is mostly used when you are
updating a single patch in a patchset and it makes sense to continue the
discussion in the same thread. In this case, we have a fresh patchset and it
makes the same thread messy.

On 10-05-22, 23:42, Schspa Shi wrote:
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 80f535cc8a75..d93958dbdab8 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1337,12 +1337,12 @@ static int cpufreq_online(unsigned int cpu)
>  		down_write(&policy->rwsem);
>  		policy->cpu = cpu;
>  		policy->governor = NULL;
> -		up_write(&policy->rwsem);
>  	} else {
>  		new_policy = true;
>  		policy = cpufreq_policy_alloc(cpu);
>  		if (!policy)
>  			return -ENOMEM;
> +		down_write(&policy->rwsem);
>  	}

I am not sure, but maybe there were issues in calling init() with rwsem held, as
it may want to call some API from there.

>  	if (!new_policy && cpufreq_driver->online) {
> @@ -1382,7 +1382,6 @@ static int cpufreq_online(unsigned int cpu)
>  		cpumask_copy(policy->related_cpus, policy->cpus);
>  	}
>  
> -	down_write(&policy->rwsem);
>  	/*
>  	 * affected cpus must always be the one, which are online. We aren't
>  	 * managing offline cpus here.
> @@ -1533,7 +1532,7 @@ static int cpufreq_online(unsigned int cpu)
>  	for_each_cpu(j, policy->real_cpus)
>  		remove_cpu_dev_symlink(policy, get_cpu_device(j));
>  
> -	up_write(&policy->rwsem);
> +	cpumask_clear(policy->cpus);

I don't think you can do that safely. offline() or exit() may depend on
policy->cpus being set to all CPUs.

>  
>  out_offline_policy:
>  	if (cpufreq_driver->offline)
> @@ -1542,6 +1541,7 @@ static int cpufreq_online(unsigned int cpu)
>  out_exit_policy:
>  	if (cpufreq_driver->exit)
>  		cpufreq_driver->exit(policy);
> +	up_write(&policy->rwsem);
>  
>  out_free_policy:
>  	cpufreq_policy_free(policy);

Apart from the issues highlighted about, I think we are trying to fix an issue
locally which can happen at other places as well. Does something like this fix
your problem at hand ?

Untested.

-- 
viresh

-------------------------8<-------------------------

From e379921d3efa58a40d9565a4506a2580318a437d Mon Sep 17 00:00:00 2001
Message-Id: <e379921d3efa58a40d9565a4506a2580318a437d.1652243573.git.viresh.kumar@linaro.org>
From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Wed, 11 May 2022 09:13:26 +0530
Subject: [PATCH] cpufreq: Allow sysfs access only for active policies

It is currently possible, in a corner case, to access the sysfs files
and reach show_cpuinfo_cur_freq(), etc, for a partly initialized policy.

This can happen for example if cpufreq_online() fails after adding the
sysfs files, which are immediately accessed by another process. There
can easily be other such cases, which aren't identified yet.

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

Fix these by checking in show/store if the policy is active or not and
update policy_is_inactive() to also check if the policy is added to the
global list or not.

Reported-by: Schspa Shi <schspa@gmail.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 10 ++++++----
 include/linux/cpufreq.h   |  3 ++-
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index fbaa8e6c7d23..036314d05ded 100644
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
+	if (!policy_is_inactive(policy))
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
+		if (!policy_is_inactive(policy))
+			ret = fattr->store(policy, buf, count);
 		up_write(&policy->rwsem);
 	}
 
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 35c7d6db4139..03e5e114c996 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -209,7 +209,8 @@ static inline void cpufreq_cpu_put(struct cpufreq_policy *policy) { }
 
 static inline bool policy_is_inactive(struct cpufreq_policy *policy)
 {
-	return cpumask_empty(policy->cpus);
+	return unlikely(cpumask_empty(policy->cpus) ||
+			list_empty(&policy->policy_list));
 }
 
 static inline bool policy_is_shared(struct cpufreq_policy *policy)
-- 
2.31.1.272.g89b43f80a514

