Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD764CBED1
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 14:26:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233296AbiCCN1B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 08:27:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231142AbiCCN07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 08:26:59 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A2E618886B
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 05:26:13 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id c7so3817157qka.7
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 05:26:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xpFSLJk6xKOFxZPPVd3YFcbRrJP4XDdwGDuqEjaZtmQ=;
        b=3llJu4jH8nD8ONt+PRBtWAFa2tiEhb1yakIAnoRXoZkBUk+IosQevkXw3mRR59RsGy
         IJqu1WDUyatVi28OT6G0Q32TltuIuh1pUfylvsLQbhYwE7/Y+R7fYYgj6jP2xNSZoDwx
         sl1xlLq4VVExuSqX+QXMKk8Vp5kX90W5KLWOR9oTpREZ0ugRZyzqXLqv4meZt1DLBc7T
         sDE1mDDP1oyrv75csrM84UCDtxIRbNbCNeAguWVKBy2lNcAnTgesunH+ObfQXWp4YKqc
         DA7RSWAspDVSISewmm8BfdgcPRkJmw5CMlGWiGPE/oBmIj4huz61hD+VBx0uiJv2+sf1
         5vTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xpFSLJk6xKOFxZPPVd3YFcbRrJP4XDdwGDuqEjaZtmQ=;
        b=Fzn6l7E8eeQltn8z5jYT0tL5V5pRAMVhFX7SVHmz1QlUyjYrvVPUQYYd36okcR3sXO
         st9Bhp55ILc7hWVJqXd1v29hLb8TZALjBDFgHOMGY7Gszq2e9V4IN79trSHH12k76cv6
         g8SFwY7eV9z2EB467adQN3jpbgL89v+SxPBCyAjbjo74bvEyi0KC/NU5YO3bhkEAV0y1
         qz11KxcymgKWdYuHNL+npjJxhLVZvQAgrlidnS8KuYwFLdRfm2T1rc8toNCYJCH+TLUT
         OB1Wqdim6jyugOIqSCsjiRdNpySYAzCKEKpdiIl57e5CoAOeerUCxzXmHDgtDBbz8yi/
         C2kw==
X-Gm-Message-State: AOAM533CgdoENiblR7NpHkH2hT3y0uOew9pFqftvXyMD3GtZhm6ysbU2
        BhMICBi/DR9qrgNPO0AV+0gXCg==
X-Google-Smtp-Source: ABdhPJziSoDBPGbtMosaCPuOPDiOnHlOyQAD6ZVyRDJ3H28pB/a5yTPK0LVJnUj9R6m+pNkgp9c5OQ==
X-Received: by 2002:a37:bd4:0:b0:606:4caa:650a with SMTP id 203-20020a370bd4000000b006064caa650amr18832304qkl.197.1646313972139;
        Thu, 03 Mar 2022 05:26:12 -0800 (PST)
Received: from localhost (cpe-98-15-154-102.hvc.res.rr.com. [98.15.154.102])
        by smtp.gmail.com with ESMTPSA id w3-20020ac857c3000000b002de99dba1c3sm1428797qta.90.2022.03.03.05.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 05:26:11 -0800 (PST)
Date:   Thu, 3 Mar 2022 08:26:10 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     corbet@lwn.net, mingo@redhat.com, peterz@infradead.org,
        surenb@google.com, ebiggers@google.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, songmuchun@bytedance.com,
        Martin Steigerwald <Martin.Steigerwald@proact.de>
Subject: Re: [PATCH] psi: remove CPU full metric at system level
Message-ID: <YiDB8pjzthSk0X7Q@cmpxchg.org>
References: <20220303055814.93057-1-zhouchengming@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220303055814.93057-1-zhouchengming@bytedance.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 03, 2022 at 01:58:14PM +0800, Chengming Zhou wrote:
> Martin find it confusing when look at the /proc/pressure/cpu output,
> and found no hint about that CPU "full" line in psi Documentation.
> 
> % cat /proc/pressure/cpu
> some avg10=0.92 avg60=0.91 avg300=0.73 total=933490489
> full avg10=0.22 avg60=0.23 avg300=0.16 total=358783277
> 
> The PSI_CPU_FULL state is introduced by commit e7fcd7622823
> ("psi: Add PSI_CPU_FULL state"), which mainly for cgroup level,
> but also counted at the system level as a side effect.
> 
> Naturally, the FULL state doesn't exist for the CPU resource at
> the system level. These "full" numbers can come from CPU idle
> schedule latency. For example, t1 is the time when task wakeup
> on an idle CPU, t2 is the time when CPU pick and switch to it.
> The delta of (t2 - t1) will be in CPU_FULL state.
> 
> Another case all processes can be stalled is when all cgroups
> have been throttled at the same time, which unlikely to happen.
> 
> Anyway, CPU_FULL metric is meaningless and confusing at the
> system level. So this patch removed CPU full metric at the
> system level, and removed it's monitor function too. The psi
> Documentation has also been updated accordingly.
> 
> Fixes: e7fcd7622823 ("psi: Add PSI_CPU_FULL state")
> Reported-by: Martin Steigerwald <Martin.Steigerwald@proact.de>
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> ---
>  Documentation/accounting/psi.rst | 18 +++++++++++++++---
>  kernel/sched/psi.c               | 10 +++++++++-
>  2 files changed, 24 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/accounting/psi.rst b/Documentation/accounting/psi.rst
> index 860fe651d645..519652c06d7d 100644
> --- a/Documentation/accounting/psi.rst
> +++ b/Documentation/accounting/psi.rst
> @@ -178,8 +178,20 @@ Cgroup2 interface
>  In a system with a CONFIG_CGROUP=y kernel and the cgroup2 filesystem
>  mounted, pressure stall information is also tracked for tasks grouped
>  into cgroups. Each subdirectory in the cgroupfs mountpoint contains
> -cpu.pressure, memory.pressure, and io.pressure files; the format is
> -the same as the /proc/pressure/ files.
> +cpu.pressure, memory.pressure, and io.pressure files; the format of
> +memory.pressure and io.pressure is the same as the /proc/pressure/ files.
> +
> +But the format of cpu.pressure is as such::
> +	some avg10=0.00 avg60=0.00 avg300=0.00 total=0
> +	full avg10=0.00 avg60=0.00 avg300=0.00 total=0

It's the format of cpu.pressure, except when it's
/sys/fs/cgroup/cpu.pressure... I think this is getting maybe a tad too
difficult to write parsers for. Plus, we added the line over a year
ago so we might break somebody by removing it again.

How about reporting zeroes at the system level?

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index e14358178849..86824de404bc 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -1062,14 +1062,17 @@ int psi_show(struct seq_file *m, struct psi_group *group, enum psi_res res)
 	mutex_unlock(&group->avgs_lock);
 
 	for (full = 0; full < 2; full++) {
-		unsigned long avg[3];
-		u64 total;
+		unsigned long avg[3] = { 0, };
+		u64 total = 0;
 		int w;
 
-		for (w = 0; w < 3; w++)
-			avg[w] = group->avg[res * 2 + full][w];
-		total = div_u64(group->total[PSI_AVGS][res * 2 + full],
-				NSEC_PER_USEC);
+		/* CPU FULL is undefined at the system level */
+		if (!(group == &psi_system && res == PSI_CPU && full)) {
+			for (w = 0; w < 3; w++)
+				avg[w] = group->avg[res * 2 + full][w];
+			total = div_u64(group->total[PSI_AVGS][res * 2 + full],
+					NSEC_PER_USEC);
+		}
 
 		seq_printf(m, "%s avg10=%lu.%02lu avg60=%lu.%02lu avg300=%lu.%02lu total=%llu\n",
 			   full ? "full" : "some",
