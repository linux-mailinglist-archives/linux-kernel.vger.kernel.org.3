Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FFB85763A8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 16:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232946AbiGOOby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 10:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiGOObv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 10:31:51 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2932C4AD77
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 07:31:51 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id r1so3370423plo.10
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 07:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding:content-disposition;
        bh=sJ7vGRmBBYjZ9WyYxUKzyEwcGqMCYMjpaKnvdDkkbLU=;
        b=l4tr2/tNAhwfyXyIkMFU/EF3JkjoHSEbpSeUkQvncfNJfQOLYq+pbHTg95tC1QQ3Em
         QrSTqbDBr1HF5jMMNtvLPV3SUkSYjs8Fm5nSMmaMlPPDx7+p+gXOe0NGruDnMDyMSbs1
         GxrRwP9plVhpGz3Pfr/mw8j/dIej6oRV7qz++lPYwWU5oYx8FMDWj5X8hh1LnGYcafmH
         LWm/5NcOdW8eI/8873q0/2/CBYqIdPztitS3jvcBTE/GRVHffBfXRe8FM95sfkR/wtiH
         MzJtPwYwonV8ubzzOPk2mfvHmj88nRxZSMNnZx0p0KzSOlY1EGbfRmyY8UbarBu8EJrl
         5tgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding
         :content-disposition;
        bh=sJ7vGRmBBYjZ9WyYxUKzyEwcGqMCYMjpaKnvdDkkbLU=;
        b=3wrWvO1gnZg9E0L7Rwt7GvW9HpVIn1NfIq/tzqDfJQB5SOlDA2b8Tb5Uz/mdirpug3
         Yjg6nsK9GW+NR6ZP3MYaUXZr4JE88bFeTcSG36jX/U9DTOt21qPeGmL2JsHxEBupZ6Do
         l+IL42arTV5iQObF1+CV0JOQxhvwvmmVEPzDAqzbBeca2PKUmWEA45Rm6dmC+NdNhFMn
         W02vr0QxV9JXBryrPEQ9XFRRC4LX06kC2BSe5+8K6LmEn7EtZlwHfNoenZHy+yqozGWO
         dFuhfr15UCPsJ2//1MOxHZlMyLb6pfkP3aN4KXCWvXvheyW9ojizJJK485dRFDZKqPUZ
         f4RQ==
X-Gm-Message-State: AJIora9wxr6ma3ifoVXv0v3FOasvmPbtq+ggwuEPRVGGMO4gfq+ZYRCo
        LAVHN0fcd8ssqI7qiB9CIao=
X-Google-Smtp-Source: AGRyM1uHhi1N9bMT6+nBzAypqcWiq7pYk7I44ccdIqDCE4FBdnne7k5Ft9amOOjOTM38cT9NtlPcQg==
X-Received: by 2002:a17:90a:c387:b0:1ef:8f7b:60d3 with SMTP id h7-20020a17090ac38700b001ef8f7b60d3mr22817693pjt.42.1657895510675;
        Fri, 15 Jul 2022 07:31:50 -0700 (PDT)
Received: from pc ([103.142.140.127])
        by smtp.gmail.com with ESMTPSA id b5-20020a17090a550500b001f10c959aa2sm1804745pji.42.2022.07.15.07.31.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Jul 2022 07:31:49 -0700 (PDT)
Date:   Fri, 15 Jul 2022 22:31:42 +0800
From:   Zackary Liu <zackary.liu.pro@gmail.com>
To:     "=?utf-8?Q?mingo=40redhat.com?=" <mingo@redhat.com>,
        "=?utf-8?Q?peterz=40infradead.org?=" <peterz@infradead.org>,
        "=?utf-8?Q?juri.lelli=40redhat.com?=" <juri.lelli@redhat.com>,
        "=?utf-8?Q?vincent.guittot=40linaro.org?=" 
        <vincent.guittot@linaro.org>,
        "=?utf-8?Q?dietmar.eggemann=40arm.com?=" <dietmar.eggemann@arm.com>,
        "=?utf-8?Q?rostedt=40goodmis.org?=" <rostedt@goodmis.org>,
        "=?utf-8?Q?bsegall=40google.com?=" <bsegall@google.com>,
        "=?utf-8?Q?mgorman=40suse.de?=" <mgorman@suse.de>,
        "=?utf-8?Q?bristot=40redhat.com?=" <bristot@redhat.com>,
        "=?utf-8?Q?vschneid=40redhat.com?=" <vschneid@redhat.com>
Cc:     "=?utf-8?Q?linux-kernel=40vger.kernel.org?=" 
        <linux-kernel@vger.kernel.org>
Message-ID: <C28270D1-07E1-4B7F-80B3-DAFAE9E65806@getmailspring.com>
In-Reply-To: <20220622162025.GA12196@pc>
References: <20220622162025.GA12196@pc>
Subject: Re: [PATCH] sched/pelt: rename init_entity_runnable_average()
X-Mailer: Mailspring
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Jun 23 2022, at 12:20 am, Zhaoyu Liu <zackary.liu.pro@gmail.com> wrote:

> In commit 0dacee1bfa70 ("sched/pelt: Remove unused runnable load average"),
> sa->runnable_load_avg was deleted from init_entity_runnable_average(),
> and now it only init sa->load_avg inside of the function,
> so rename the function to init_entity_load_average() is more appropriate.
> 
> Signed-off-by: Zhaoyu Liu <zackary.liu.pro@gmail.com>
> ---
> kernel/sched/core.c  | 3 +--
> kernel/sched/fair.c  | 6 +++---
> kernel/sched/sched.h | 2 +-
> 3 files changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 263d76489a48..224ca514e9d8 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -4580,8 +4580,7 @@ int sched_fork(unsigned long clone_flags, struct
> task_struct *p)
> 	else
> 		p->sched_class = &fair_sched_class;
> 
> -	init_entity_runnable_average(&p->se);
> -
> +	init_entity_load_average(&p->se);
> 
> #ifdef CONFIG_SCHED_INFO
> 	if (likely(sched_info_on()))
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index ed32f66bbd3d..6bc7eaf88c59 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -784,7 +784,7 @@ static unsigned long task_h_load(struct
> task_struct *p);
> static unsigned long capacity_of(int cpu);
> 
> /* Give new sched_entity start runnable values to heavy its load in
> infant time */
> -void init_entity_runnable_average(struct sched_entity *se)
> +void init_entity_load_average(struct sched_entity *se)
> {
> 	struct sched_avg *sa = &se->avg;
> 
> @@ -871,7 +871,7 @@ void post_init_entity_util_avg(struct task_struct *p)
> }
> 
> #else /* !CONFIG_SMP */
> -void init_entity_runnable_average(struct sched_entity *se)
> +void init_entity_load_average(struct sched_entity *se)
> {
> }
> void post_init_entity_util_avg(struct task_struct *p)
> @@ -11510,7 +11510,7 @@ int alloc_fair_sched_group(struct task_group
> *tg, struct task_group *parent)
> 
> 		init_cfs_rq(cfs_rq);
> 		init_tg_cfs_entry(tg, cfs_rq, se, i, parent->se[i]);
> -		init_entity_runnable_average(se);
> +		init_entity_load_average(se);
> 	}
> 
> 	return 1;
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 5b14b6b4495d..349b423ea8a6 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -2330,7 +2330,7 @@ extern void init_dl_inactive_task_timer(struct
> sched_dl_entity *dl_se);
> #define MAX_BW			((1ULL << MAX_BW_BITS) - 1)
> unsigned long to_ratio(u64 period, u64 runtime);
> 
> -extern void init_entity_runnable_average(struct sched_entity *se);
> +extern void init_entity_load_average(struct sched_entity *se);
> extern void post_init_entity_util_avg(struct task_struct *p);
> 
> #ifdef CONFIG_NO_HZ_FULL
> -- 
> 2.17.1
> 
> 

I have sent a patch couple days ago but still i don't get the reply,
I am looking forward to your reply,
thank you

--
zackary
