Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAF624B3800
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 21:46:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231783AbiBLUo7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 15:44:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231664AbiBLUo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 15:44:58 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B63B606E4
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 12:44:54 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id l19so16518593pfu.2
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 12:44:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sy0ZCHc2ekTg7J4mCAJUHs13eVlwEBNAuh2W+MRX+f0=;
        b=Y5FU0EdlOayRH8UXvufBg86dju0hloKQb0Omdn6PwVGQy0zpi8fW8/qJ7XpuS0X0pQ
         X84hwyspgzYj/n6GiRamz2G9oA3Kr3SZ1DyeI4LCK4XaeMWheewnZLrINwgJE6ZIV9JW
         V/Kc+v0o3WQY1en7rzUr9F2BtJmdFFlRPSI21vPJZeBrnlu0rFs1tr5KqSaahCicOllg
         NSHXImtsiiJG9nF9qsGGPGChbORWYlAu10vBjY91dMd5kkIqa7pvWXD1H8kvlki7jtAw
         ewo1JzNntXnnJ4iWAOLUkm10i7AEVAh2NYsN1jcnMNq1wv0zvEsSDPOk3RmEXiyPUes2
         LPCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sy0ZCHc2ekTg7J4mCAJUHs13eVlwEBNAuh2W+MRX+f0=;
        b=VYFio0t4IgrSwo+Kn06NdmtUFzYe0tL8ivqXL4VIMnOLduD3QnDvphODRQhu5M/YNT
         GqZvVk+Qs97KZ85y3uXxDuY6D7fxi8PlWJwlGkVM5LusetoXDVomm8BVZT1zeh2bXqlB
         oZuzYd7YGMOrCgGCecZd+krdVt6cahhKyBQqukYlJjeKq/2Dgpc5MXobnUT6VuW88NLb
         JvAUf6/3pQglaFJxdBSNIiNBv3OHgz1vTqB3IWUSd7U5cWBB2awq0xH+i00CadH1jtKz
         2NhwrpgTikNCpJgfRUHNzKe2gxxV9d2Vq7eRRC9SMJmADb8tfBJiM4Ffco8EvxjoBH89
         Vgqg==
X-Gm-Message-State: AOAM531l8VcdQ0ys8ahjqJygnEhMvH8opoXSB2bLM4cHryqP8v2aPpaK
        Ys9xMXoN24DfLgix8aM/Uvq2VHOmDGCkwQ==
X-Google-Smtp-Source: ABdhPJzS17CwYQnvu22TQrNycGW5hH3eSCz0g3fmjyNImrHpMBBpYOq/gWoNJ31xTrqal9o07dXNVw==
X-Received: by 2002:a63:4656:: with SMTP id v22mr5874251pgk.604.1644698693976;
        Sat, 12 Feb 2022 12:44:53 -0800 (PST)
Received: from archlinux.localdomain ([140.121.198.213])
        by smtp.gmail.com with ESMTPSA id s6sm22881999pgk.44.2022.02.12.12.44.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Feb 2022 12:44:53 -0800 (PST)
From:   Huichun Feng <foxhoundsk.tw@gmail.com>
To:     henrybear327@gmail.com
Cc:     bristot@redhat.com, bsegall@google.com, christian@brauner.io,
        dietmar.eggemann@arm.com, juri.lelli@redhat.com,
        linux-kernel@vger.kernel.org, mgorman@suse.de, mingo@redhat.com,
        peterz@infradead.org, rostedt@goodmis.org,
        vincent.guittot@linaro.org
Subject: Re: [PATCH v2] sched: Simplify __sched_init runtime checks
Date:   Sun, 13 Feb 2022 04:45:48 +0800
Message-Id: <20220212204548.1342701-1-foxhoundsk.tw@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220124085332.41552-1-henrybear327@gmail.com>
References: <20220124085332.41552-1-henrybear327@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Chun-Hung Tseng <henrybear327@gmail.com> writes:

>
> Improve runtime checks in __sched_init(void) by replacing if conditional
> checks with preprocessor directives.
>
> Signed-off-by: Chun-Hung Tseng <henrybear327@gmail.com>

Sorry, I didn't reply properly.

Signed-off-by: Huichun Feng <foxhoundsk.tw@gmail.com>

> ---
>  kernel/sched/core.c | 29 +++++++++++++++--------------
>  1 file changed, 15 insertions(+), 14 deletions(-)
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 848eaa0efe0e..1b27ca7f485a 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -9308,28 +9308,29 @@ void __init sched_init(void)
>  #ifdef CONFIG_RT_GROUP_SCHED
>         ptr += 2 * nr_cpu_ids * sizeof(void **);
>  #endif
> -       if (ptr) {
> -               ptr = (unsigned long)kzalloc(ptr, GFP_NOWAIT);
> +
> +#if defined(CONFIG_FAIR_GROUP_SCHED) || defined(CONFIG_RT_GROUP_SCHED)
> +       ptr = (unsigned long)kzalloc(ptr, GFP_NOWAIT);
>
>  #ifdef CONFIG_FAIR_GROUP_SCHED
> -               root_task_group.se = (struct sched_entity **)ptr;
> -               ptr += nr_cpu_ids * sizeof(void **);
> +       root_task_group.se = (struct sched_entity **)ptr;
> +       ptr += nr_cpu_ids * sizeof(void **);
>
> -               root_task_group.cfs_rq = (struct cfs_rq **)ptr;
> -               ptr += nr_cpu_ids * sizeof(void **);
> +       root_task_group.cfs_rq = (struct cfs_rq **)ptr;
> +       ptr += nr_cpu_ids * sizeof(void **);
>
> -               root_task_group.shares = ROOT_TASK_GROUP_LOAD;
> -               init_cfs_bandwidth(&root_task_group.cfs_bandwidth);
> +       root_task_group.shares = ROOT_TASK_GROUP_LOAD;
> +       init_cfs_bandwidth(&root_task_group.cfs_bandwidth);
>  #endif /* CONFIG_FAIR_GROUP_SCHED */
>  #ifdef CONFIG_RT_GROUP_SCHED
> -               root_task_group.rt_se = (struct sched_rt_entity **)ptr;
> -               ptr += nr_cpu_ids * sizeof(void **);
> -
> -               root_task_group.rt_rq = (struct rt_rq **)ptr;
> -               ptr += nr_cpu_ids * sizeof(void **);
> +       root_task_group.rt_se = (struct sched_rt_entity **)ptr;
> +       ptr += nr_cpu_ids * sizeof(void **);
>
> +       root_task_group.rt_rq = (struct rt_rq **)ptr;
> +       ptr += nr_cpu_ids * sizeof(void **);
>  #endif /* CONFIG_RT_GROUP_SCHED */
> -       }
> +#endif /* CONFIG_FAIR_GROUP_SCHED || CONFIG_RT_GROUP_SCHED */
> +
>  #ifdef CONFIG_CPUMASK_OFFSTACK
>         for_each_possible_cpu(i) {
>                 per_cpu(load_balance_mask, i) = (cpumask_var_t)kzalloc_node(
> --
> 2.34.1
