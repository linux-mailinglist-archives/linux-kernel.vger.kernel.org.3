Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95A7F4E39E5
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 08:48:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbiCVHuH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 03:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiCVHuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 03:50:05 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36A96CCC
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 00:48:38 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id qa43so34289926ejc.12
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 00:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=q6Ee3t55+IUI0qiEKXzS5vpLkBsJLI1LengAHoJwP3U=;
        b=jBbXJrWbUYbX/Kec3Spde/WdFH2uOkJ/EshO96cqOSVdQzHbIBeYknC7AVyya7+IX5
         whAOgbY+mQ4/xaGGpqWtiqkwqOBMbOUDLeDIulCd7g4sqbu3sT65rZV7TyncIKeBpVvL
         zHJoKCPm/9aZw/m8X3gFg5CT/Tj8gYbaqZsXAM9cn0meqL1Mjq3r8/Xmewl7EsHMkcll
         8DfiP/E0koxPYRADePwp8ANcCAfsf3co7UYtoja9n9B80gi9Bj7E6j/gac8m46w13MHU
         jRG5Qt3V6Udq/KsUuBiYvEE4JbUPRC5CMa2iMSYZh0DNknCnXQDgH7EPdJ3yJkRRTRZ7
         Q1Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=q6Ee3t55+IUI0qiEKXzS5vpLkBsJLI1LengAHoJwP3U=;
        b=aQzE2dyv4PvVGeCrGYkK4BQri442OdkHV46Z+wdX/mIhC/a6rhV1JC5bUVtL4b7HFf
         uj0NeuyDVSVkp+HmJNcaTaKn4MpYlRxTqPNi6UwTjvRDwv4UmuJAsdm1Q9plIDypJx4D
         Rr7lUPcQcPIGR7obWiPWGZZqAIt50i0P7aBvduK7tS4N9rJG3BO7BGZYtpMSqwnsV/mS
         yM/IrNrfebr7SN8+4ZsRTA3W+oBtSWmgRBea2l6jl4pg4dsJ8NLDawFP4gQAajHscMID
         59SahGqE6+u51ADyAU6B+2Ra9LFMruuYBFEsbpsE/NCoTTu8ligzBgf0bd7J7jpeqfHD
         9pTg==
X-Gm-Message-State: AOAM533F/x4TbR3qn8Q9Eu11tmWOr7nT3A8fjQKeDNFIV7uVorgtiBx2
        pSqJOYIO0ZLYOme6zH4Iwbc=
X-Google-Smtp-Source: ABdhPJzp0GSnr4Pyc/HTkH9K/tgLmFJFK8+FiF19DMMDlBFsgyLbv9jeZRWbV7rkpYpb88XyB46izA==
X-Received: by 2002:a17:907:216f:b0:6ce:d85f:35cf with SMTP id rl15-20020a170907216f00b006ced85f35cfmr24765695ejb.517.1647935316636;
        Tue, 22 Mar 2022 00:48:36 -0700 (PDT)
Received: from gmail.com (0526ECD0.dsl.pool.telekom.hu. [5.38.236.208])
        by smtp.gmail.com with ESMTPSA id a22-20020a50ff16000000b00410d029ea5csm8874938edu.96.2022.03.22.00.48.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 00:48:35 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Tue, 22 Mar 2022 08:48:31 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Qian Cai <quic_qiancai@quicinc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Huang, Ying" <ying.huang@intel.com>
Subject: Re: [GIT PULL] scheduler updates for v5.18
Message-ID: <Yjl/T0SBCo1zfkkS@gmail.com>
References: <YjhZUezhnamHAl0H@gmail.com>
 <Yjh58h8cpcPERVZA@qian>
 <CAHk-=whrqeX-8yHEdSCGFUyyC2sj=OLyeFR9civUiswR=A+PwA@mail.gmail.com>
 <Yjl8Lk2uPiZkXoM9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yjl8Lk2uPiZkXoM9@gmail.com>
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


* Ingo Molnar <mingo@kernel.org> wrote:

> 
> * Linus Torvalds <torvalds@linux-foundation.org> wrote:
> 
> > On Mon, Mar 21, 2022 at 6:13 AM Qian Cai <quic_qiancai@quicinc.com> wrote:
> > >
> > > On Mon, Mar 21, 2022 at 11:54:09AM +0100, Ingo Molnar wrote:
> > > > Huang Ying (3):
> > > >       sched/numa-balancing: Move some document to make it consistent with the code
> > > >       sched/numa: Fix NUMA topology for systems with CPU-less nodes
> > > >       sched/numa: Avoid migrating task to CPU-less node
> > >
> > > Linus, I don't think you want to merge this as-is. This will introduce a
> > > kernel crash on arm64 NUMA as mentioned in this thread,
> > 
> > Ok, dropped from my queue. Thanks,
> 
> I've reverted the broken commit & will send another pull request after 
> some testing. Sorry about that!

Ended up using the fix below instead - it's tested already on the affected 
system.

Thanks,

	Ingo

=================>
From: "Huang, Ying" <ying.huang@intel.com>
Date: Tue, 22 Mar 2022 08:39:22 +0100
Subject: [PATCH] sched/numa: Fix boot crash on arm64 systems

Qian Cai reported a boot crash on arm64 systems, caused by:

  0fb3978b0aac ("sched/numa: Fix NUMA topology for systems with CPU-less nodes")

The bug is that node_state() must be supplied a valid node_states[] array index,
but in task_numa_placement() the max_nid search can fail with NUMA_NO_NODE,
which is not a valid index.

Fix it by checking that max_nid is a valid index.

[ mingo: Added changelog. ]

Fixes: 0fb3978b0aac ("sched/numa: Fix NUMA topology for systems with CPU-less nodes")
Reported-by: Qian Cai <quic_qiancai@quicinc.com>
Tested-by: Qian Cai <quic_qiancai@quicinc.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 89d21fda106c..ee0664c9d291 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2437,7 +2437,7 @@ static void task_numa_placement(struct task_struct *p)
 	}
 
 	/* Cannot migrate task to CPU-less node */
-	if (!node_state(max_nid, N_CPU)) {
+	if (max_nid != NUMA_NO_NODE && !node_state(max_nid, N_CPU)) {
 		int near_nid = max_nid;
 		int distance, near_distance = INT_MAX;
 

