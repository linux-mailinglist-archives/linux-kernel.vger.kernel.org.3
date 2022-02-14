Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1CFD4B5A5A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 20:04:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbiBNTCc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 14:02:32 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:39210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbiBNTCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 14:02:06 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A90847005A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 11:01:50 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id i10so3645419plr.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 11:01:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zGHPgxqnjqH+Cw2Sgp5QEfFgGxm4uP3DL31sHwpfa30=;
        b=L83GBDXy3WNzBO8JGGm/OxBWf4p2zLQGpQZa4zqAGMzB12bgVsYZRmh4jHMKj7eV5/
         t5TQvNoF5k+Ra43hvqOKJw1mXpE6zV5k8VIKsZMgaz9k7YVdB7mEdgTcPSpxNn+WlYEi
         CQLu+Ao2tDyWF1auYz0Lh8VmxVKFtmfA7tkTKyB8N+v0tYpwjlSSO5tWR+8zwpCjkZvk
         mcOCs2aNQrUM5z6FcDbKT9S0ZtmsA4L4vbhF0EaTEEFso/+o7n2Zm4h0voBCwOW18dC1
         ThryKRrzOfVhZKT9Aap8vpJvem+lLKU5SlNuvyHDst+xgowmMbQ+Tou55AEHc6U0ZG1J
         bG9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=zGHPgxqnjqH+Cw2Sgp5QEfFgGxm4uP3DL31sHwpfa30=;
        b=Cg3Lyk4t9OUi3IA41qkeGKULUAPA5XVLdhRNkmKU+oB+mq6gRa8TSCF9wWZLAKbqTi
         7MjBswvpDfMqvGej1hMkS2mXxiwI48CLKG/SzUMshL6COq2FE3Jh7TSYTuNO8+/TmHjN
         RVeUnTqJu2dlpOWv1SE+zuIi1RxEfVW0Q8/Mx+Dyxe8kEtB28EwyTO5/jUNoo8seDvTO
         Q2pLXmt3ctBOsvsjt02WkeDhO0GKYzcnXjfiusReYld7Fureq3nEeSjpPFI4Uc+mBh6+
         rDjhIPhsPolk7CX1yI3V529KueRYqa3e+Jgka2QprbvXTFX7yse2LKT6IqGXPpSMZeaK
         EH4A==
X-Gm-Message-State: AOAM532N3/HYGzyhQABZX5jaZExRL5QUxItn7TzBHX2tNAY9MzvZi3dQ
        LwjxkIiHAFzKc8E25A8N86UXzZHdim8=
X-Google-Smtp-Source: ABdhPJz6vwBXvE43ALyQNo2PpRKf5TdAJAqu2sRb9pjj6w/q49g/1osFrRqFz5BgiJWFnFx1spVdKA==
X-Received: by 2002:a17:902:ea06:: with SMTP id s6mr219508plg.163.1644865044720;
        Mon, 14 Feb 2022 10:57:24 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id iy13sm14542692pjb.51.2022.02.14.10.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 10:57:24 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 14 Feb 2022 08:57:23 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Chengming Zhou <zhouchengming@bytedance.com>, arbn@yandex-team.com,
        mingo@redhat.com, linux-kernel@vger.kernel.org,
        Minye Zhu <zhuminye@bytedance.com>
Subject: Re: [PATCH] sched/cpuacct: fix charge percpu cpuusage
Message-ID: <YgqmE9Id35av9NZk@slm.duckdns.org>
References: <20220213120118.93471-1-zhouchengming@bytedance.com>
 <YgoqPT67g2NcV/eH@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YgoqPT67g2NcV/eH@hirez.programming.kicks-ass.net>
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

On Mon, Feb 14, 2022 at 11:09:01AM +0100, Peter Zijlstra wrote:
> --- a/kernel/sched/cpuacct.c
> +++ b/kernel/sched/cpuacct.c
> @@ -334,15 +334,13 @@ static struct cftype files[] = {
>   */
>  void cpuacct_charge(struct task_struct *tsk, u64 cputime)
>  {
> -	struct cpuacct *ca;
>  	unsigned int cpu = task_cpu(tsk);
> +	struct cpuacct *ca;
>  
> -	rcu_read_lock();
> +	lockdep_assert_rq_held(cpu_rq(cpu));
>  
>  	for (ca = task_ca(tsk); ca; ca = parent_ca(ca))
>  		*per_cpu_ptr(ca->cpuusage, cpu) += cputime;
> -
> -	rcu_read_unlock();

And probably expand the same to cgroup_account_cputime[_field]() too.

Thanks.

-- 
tejun
