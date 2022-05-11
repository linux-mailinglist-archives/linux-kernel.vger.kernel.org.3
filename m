Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBB2852336D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 14:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242804AbiEKMxL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 08:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240793AbiEKMxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 08:53:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 23BEE68308
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 05:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652273586;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VWjC9EG18AFZu2LY+9ZGj6V6UHYyFbBc8JjmrNiWDak=;
        b=i8kIZR1ok+MLIzEQAO9MSEkbZT4f4ODz6ENPtrPhNYxR8DFgNVFQnRS7v9glNDrKZvypdG
        WsG+VjXvlFAfHC54RZl4WXac07gVD8UkIGYRB1KK8jHrQL09hrZLtiH99dS0+7w+A2GKbe
        xIDFlSnmAPp1yTYFQtAfDFgpyPfHgCs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-210-oyQjpJ-DOCmZsnp7SY3unw-1; Wed, 11 May 2022 08:53:05 -0400
X-MC-Unique: oyQjpJ-DOCmZsnp7SY3unw-1
Received: by mail-wm1-f71.google.com with SMTP id m26-20020a7bcb9a000000b0039455e871b6so667875wmi.8
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 05:53:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=VWjC9EG18AFZu2LY+9ZGj6V6UHYyFbBc8JjmrNiWDak=;
        b=ntfEa+Z5l5SGdOwO9HLD/gDsPJZbitMdaaVZ4pZ7HU6q3f2hVB/UMoRdALj1j2C2HG
         J4dQZm+4IKVJYDqUbTz/Ryun1MSIwxxUyuOwZezeQteu71IDWqd+78ktU6tHExRhqtIT
         hoauwJSYVjcI3fyquxPjvEYKL1Wc3VwIMFXhVs+gpfITatBhQQ9h0c5n8ZXf2ADj6You
         PjXG0SvyirzooouV5nnNO1+lnHnduVEf3JfYdMH7uOivwGzCr68RV1ODn8J9/cQneq4R
         J8y5uW0sdIcqwh72Nc2Evjmo7e8ysWXoMk1K3zIxBqVCk4ekn8yMj39N5VHn5RYCUAhf
         XLCQ==
X-Gm-Message-State: AOAM531ZvfUrn7JHmi+R4R8LODpBSLahaBfc6ojC2+ZUmuX3W7Qk+fth
        zLF+ftpKp5pLNjPvt6jodrnNqoFCErpCxQpMDyEDpJPJA9EG7qDxXLD40/RuQTxBNOpXlsbEJgU
        jDzrQ0gxsQsnMkinGINRev3Wr
X-Received: by 2002:a05:6000:1809:b0:20a:cafc:fd39 with SMTP id m9-20020a056000180900b0020acafcfd39mr22516835wrh.255.1652273584551;
        Wed, 11 May 2022 05:53:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx+U/vXaQanU8gZEU8cQQaRcMVdpu6Mv5VSuen7ploYodJN7MTJe9l14NKBkawEE8+bN/BcPQ==
X-Received: by 2002:a05:6000:1809:b0:20a:cafc:fd39 with SMTP id m9-20020a056000180900b0020acafcfd39mr22516814wrh.255.1652273584338;
        Wed, 11 May 2022 05:53:04 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id c8-20020adfed88000000b0020c5253d909sm1661854wro.85.2022.05.11.05.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 05:53:03 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Yajun Deng <yajun.deng@linux.dev>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com
Cc:     linux-kernel@vger.kernel.org, Yajun Deng <yajun.deng@linux.dev>
Subject: Re: [PATCH] sched/rt: fix the case where sched_rt_period_us is
 non-positive
In-Reply-To: <20220511112140.103579-1-yajun.deng@linux.dev>
References: <20220511112140.103579-1-yajun.deng@linux.dev>
Date:   Wed, 11 May 2022 13:53:03 +0100
Message-ID: <xhsmhsfpg1b9s.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/05/22 19:21, Yajun Deng wrote:
> The proc_dointvec() in sched_rt_handler() is for integer, but
> sysctl_sched_rt_period is a unsigned integer. sched_rt_handler() would
> cover a non-positive number to positive number, so both proc_dointvec()
> and sched_rt_global_validate() aren't return error when we set a
> non-positive number.
>
> Use proc_dointvec_minmax() instead of proc_dointvec(), and add extra
> for sched_rt_period_us/sched_rt_runtime_us/sched_rr_timeslice_ms.
>
> Fixes: 391e43da797a ("sched: Move all scheduler bits into kernel/sched/")
> Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
> ---
>  kernel/sched/rt.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> index b491a0f8c25d..f20389aa6731 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -37,6 +37,7 @@ static struct ctl_table sched_rt_sysctls[] = {
>               .maxlen         = sizeof(unsigned int),
>               .mode           = 0644,
>               .proc_handler   = sched_rt_handler,
> +		.extra1		= SYSCTL_ONE,
>       },

Err, what kernel is this based on? AFAICT those have always lived in
kernel/sysctl.c, not kernel/sched/rt.c

>       {
>               .procname       = "sched_rt_runtime_us",
> @@ -44,6 +45,8 @@ static struct ctl_table sched_rt_sysctls[] = {
>               .maxlen         = sizeof(int),
>               .mode           = 0644,
>               .proc_handler   = sched_rt_handler,
> +		.extra1		= SYSCTL_NEG_ONE,
> +		.extra2		= (void *)&sysctl_sched_rt_period,
>       },
>       {
>               .procname       = "sched_rr_timeslice_ms",
> @@ -51,6 +54,7 @@ static struct ctl_table sched_rt_sysctls[] = {
>               .maxlen         = sizeof(int),
>               .mode           = 0644,
>               .proc_handler   = sched_rr_handler,
> +		.extra1		= SYSCTL_ONE,

Per upstream state of sched_rr_handler:

         * Also, writing zero resets the timeslice to default:

which doesn't happen with that new constraint.

>       },
>       {}
>  };
> @@ -2959,9 +2963,6 @@ static int sched_rt_global_constraints(void)
>  #ifdef CONFIG_SYSCTL
>  static int sched_rt_global_validate(void)
>  {
> -	if (sysctl_sched_rt_period <= 0)
> -		return -EINVAL;
> -
>       if ((sysctl_sched_rt_runtime != RUNTIME_INF) &&
>               ((sysctl_sched_rt_runtime > sysctl_sched_rt_period) ||
>                ((u64)sysctl_sched_rt_runtime *
> @@ -2992,7 +2993,7 @@ static int sched_rt_handler(struct ctl_table *table, int write, void *buffer,
>       old_period = sysctl_sched_rt_period;
>       old_runtime = sysctl_sched_rt_runtime;
>
> -	ret = proc_dointvec(table, write, buffer, lenp, ppos);
> +	ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
>
>       if (!ret && write) {
>               ret = sched_rt_global_validate();
> @@ -3027,14 +3028,13 @@ static int sched_rr_handler(struct ctl_table *table, int write, void *buffer,
>       static DEFINE_MUTEX(mutex);
>
>       mutex_lock(&mutex);
> -	ret = proc_dointvec(table, write, buffer, lenp, ppos);
> +	ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
>       /*
>        * Make sure that internally we keep jiffies.
>        * Also, writing zero resets the timeslice to default:
>        */
>       if (!ret && write) {
>               sched_rr_timeslice =
> -			sysctl_sched_rr_timeslice <= 0 ? RR_TIMESLICE :
>                       msecs_to_jiffies(sysctl_sched_rr_timeslice);
>       }
>       mutex_unlock(&mutex);
> --
> 2.25.1

