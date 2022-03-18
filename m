Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D49444DD58E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 08:51:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233333AbiCRHwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 03:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231795AbiCRHwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 03:52:17 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E9402BD972
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 00:50:59 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id qx21so15331242ejb.13
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 00:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=iwJkdlGDgTBfPWHYj1lVE7XeHbdSiLQJxb98ydgODVg=;
        b=Dvq6B7ml8d6AdKUocAFAnhYwjZ9/skOIxpdFYEtqOiyiE9FxzcYkgZEp8Wp/OgGGyy
         YZ3ZSf07mO4Rwbz6xfbZjASm+AL5bLJN036KDENL1O36dxRq0GGJkkdXY5UPn3+VxphB
         qwe1sgsCNCx9cuGLlZorOBZfRDV0G2ynAyLPM91aWNZ+nugBLTxTh2iCDwLozcLiBZNI
         f5wwVYebboS4G4p/ZchkxEDl1btPdxi0VWeS7tVL5xmJTn27MXY9hiSXoZ40c0iizOsM
         Gie4fcsDJXDGZuXsH3aGJFi3cDXAI0+IO/Lneate3cnlP/vvY2im7Sd0vu4oYDIi807o
         /9ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=iwJkdlGDgTBfPWHYj1lVE7XeHbdSiLQJxb98ydgODVg=;
        b=SLPB38mt3mNYudLtIPtf00HctjcsI7mpCOtbltEOKbCS9WmO12pRiO3kLOV8zdsCo2
         lVlNqsPtPcfL+WqBsXsndyO5jk79DUY3d3nxqBrBlhRF7BJOSG5IqkdRS92C432ts70O
         1+YGnTEVA/BnBIPW5F05M1SVTl34rTm6p5iH46os8/9Ad46STBRyMjIIT9MAoW5yBFDR
         1tSAPCw/pGR6/9nZl2mh5wMv6lnUCjp58gbwjK5625LdA3Pha/Oc2DMHH7MpqlYkRHVl
         8XILi3xsJbW5X2Al5t6SqKdyGJjFly48I9bkqr/VY4ibQc9kDKKqms4JX3Pa6xzp9Cq2
         LpeQ==
X-Gm-Message-State: AOAM531pdLdVObTi4tUenEE7pAhCE1E1zfarqyPEIfTybpGC4iAtL5od
        d1PxKz5Yf1xzJ2ebH8WRAEU=
X-Google-Smtp-Source: ABdhPJx6/3+zxn6zs/LjuJRFTQcVUee2qhGAV5UCHmS988oebzM38Efr0iuXKr5mPMoUQ0CNoUeXVQ==
X-Received: by 2002:a17:906:b095:b0:6cf:752c:fb88 with SMTP id x21-20020a170906b09500b006cf752cfb88mr7823795ejy.128.1647589858013;
        Fri, 18 Mar 2022 00:50:58 -0700 (PDT)
Received: from gmail.com ([5.38.236.208])
        by smtp.gmail.com with ESMTPSA id b5-20020a170906728500b006db8b630ebdsm3310387ejl.209.2022.03.18.00.50.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Mar 2022 00:50:57 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Fri, 18 Mar 2022 08:50:50 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Baisong Zhong <zhongbaisong@huawei.com>,
        Zhen Ni <nizhen@uniontech.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] sched/rt: fix build error when CONFIG_SYSCTL is
 disable
Message-ID: <YjQ52q5voQRBRgKw@gmail.com>
References: <20220318025417.3683430-1-zhongbaisong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220318025417.3683430-1-zhongbaisong@huawei.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


I believe these build errors are caused by new commits in the sysctl-next 
tree that change scheduler code:

  4925401d06dc sched: Move rr_timeslice sysctls to rt.c
  5f6e55c2485c sched: Move rt_period/runtime sysctls to rt.c

In particular I don't see any Cc: to scheduler folks in these two commits - 
and I'd have preferred to pick these up into the scheduler tree, to avoid 
the merge conflicts and the build failure regressions...

Thanks,

	Ingo


* Baisong Zhong <zhongbaisong@huawei.com> wrote:

> Avoid random build errors which do not select
> CONFIG_SYSCTL by depending on it in Kconfig.
> 
> This fixes the following warning:
> 
> In file included from kernel/sched/build_policy.c:43:
> At top level:
> kernel/sched/rt.c:3017:12: error: ‘sched_rr_handler’ defined but not used [-Werror=unused-function]
>  3017 | static int sched_rr_handler(struct ctl_table *table, int write, void *buffer,
>       |            ^~~~~~~~~~~~~~~~
> kernel/sched/rt.c:2978:12: error: ‘sched_rt_handler’ defined but not used [-Werror=unused-function]
>  2978 | static int sched_rt_handler(struct ctl_table *table, int write, void *buffer,
>       |            ^~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
> make[2]: *** [scripts/Makefile.build:310: kernel/sched/build_policy.o] Error 1
> make[1]: *** [scripts/Makefile.build:638: kernel/sched] Error 2
> make[1]: *** Waiting for unfinished jobs....
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Baisong Zhong <zhongbaisong@huawei.com>
> ---
>  kernel/sched/rt.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> index 71791be36065..ee319581b1cd 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -5,7 +5,6 @@
>   */
>  
>  int sched_rr_timeslice = RR_TIMESLICE;
> -static int sysctl_sched_rr_timeslice = (MSEC_PER_SEC / HZ) * RR_TIMESLICE;
>  /* More than 4 hours if BW_SHIFT equals 20. */
>  static const u64 max_rt_runtime = MAX_BW;
>  
> @@ -25,11 +24,12 @@ unsigned int sysctl_sched_rt_period = 1000000;
>   */
>  int sysctl_sched_rt_runtime = 950000;
>  
> +#ifdef CONFIG_SYSCTL
> +static int sysctl_sched_rr_timeslice = (MSEC_PER_SEC / HZ) * RR_TIMESLICE;
>  static int sched_rt_handler(struct ctl_table *table, int write, void *buffer,
>  		size_t *lenp, loff_t *ppos);
>  static int sched_rr_handler(struct ctl_table *table, int write, void *buffer,
>  		size_t *lenp, loff_t *ppos);
> -#ifdef CONFIG_SYSCTL
>  static struct ctl_table sched_rt_sysctls[] = {
>  	{
>  		.procname       = "sched_rt_period_us",
> @@ -2911,6 +2911,7 @@ long sched_group_rt_period(struct task_group *tg)
>  	return rt_period_us;
>  }
>  
> +#ifdef CONFIG_SYSCTL
>  static int sched_rt_global_constraints(void)
>  {
>  	int ret = 0;
> @@ -2930,8 +2931,11 @@ int sched_rt_can_attach(struct task_group *tg, struct task_struct *tsk)
>  
>  	return 1;
>  }
> +#endif /* CONFIG_SYSCTL */
>  
>  #else /* !CONFIG_RT_GROUP_SCHED */
> +
> +#ifdef CONFIG_SYSCTL
>  static int sched_rt_global_constraints(void)
>  {
>  	unsigned long flags;
> @@ -2949,8 +2953,10 @@ static int sched_rt_global_constraints(void)
>  
>  	return 0;
>  }
> +#endif /* CONFIG_SYSCTL */
>  #endif /* CONFIG_RT_GROUP_SCHED */
>  
> +#ifdef CONFIG_SYSCTL
>  static int sched_rt_global_validate(void)
>  {
>  	if (sysctl_sched_rt_period <= 0)
> @@ -3035,6 +3041,7 @@ static int sched_rr_handler(struct ctl_table *table, int write, void *buffer,
>  
>  	return ret;
>  }
> +#endif /* CONFIG_SYSCTL */
>  
>  #ifdef CONFIG_SCHED_DEBUG
>  void print_rt_stats(struct seq_file *m, int cpu)
> -- 
> 2.25.1
> 
