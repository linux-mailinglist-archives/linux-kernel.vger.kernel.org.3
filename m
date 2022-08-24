Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3865E59F736
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 12:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236061AbiHXKOd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 06:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231846AbiHXKO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 06:14:29 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FCD76172D
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 03:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jasxQspYVT9C1jhv6IkFddVnwaGQHMMl3j1FIzjmSZ8=; b=AkNuom22OBBMbEhsa0PGeNWks4
        uTVbOugR7JcZq38oNSHHZb69Z4VYyNRFmRRkNFdLGgCz2mLTRlLi8GmDq3prq8q7T+Xl2UGqrzNCf
        nQ+j0zgoxFVB+YXpMO5c+h+SKVIb984+vw8nx9fFXNzWfdCo62PtCqfVgjm4Tyy+aIHX3yasbmAJO
        Apmu8JkQC3+YXv6RPzTBboBEkdwx2vABJn1O+J6uJiQ2AgfJu9uB/zssRRMmTYI5ivIFyYUZPEOGk
        fP32kZcu8pqzQ4w6IrmK8e3VulX6uF039F5AE+lpZUaYLBqX8sDzafSvajsACHVxssQfUme7TTC4V
        JGhESKRw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oQnOX-005h8O-EF; Wed, 24 Aug 2022 10:13:58 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id F39A1980BE2; Wed, 24 Aug 2022 12:13:55 +0200 (CEST)
Date:   Wed, 24 Aug 2022 12:13:55 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ravi Bangoria <ravi.bangoria@amd.com>
Cc:     acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, songliubraving@fb.com,
        eranian@google.com, alexey.budankov@linux.intel.com,
        ak@linux.intel.com, mark.rutland@arm.com, megha.dey@intel.com,
        frederic@kernel.org, maddy@linux.ibm.com, irogers@google.com,
        kim.phillips@amd.com, linux-kernel@vger.kernel.org,
        santosh.shukla@amd.com
Subject: Re: [RFC v2] perf: Rewrite core context handling
Message-ID: <YwX546d8YxRCbQWl@worktop.programming.kicks-ass.net>
References: <20220113134743.1292-1-ravi.bangoria@amd.com>
 <YqdLH+ZU/sf4n0pa@hirez.programming.kicks-ass.net>
 <YqyDc0i3C9OpNiPx@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YqyDc0i3C9OpNiPx@worktop.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 17, 2022 at 03:36:51PM +0200, Peter Zijlstra wrote:
> On Mon, Jun 13, 2022 at 04:35:11PM +0200, Peter Zijlstra wrote:
> > +/* XXX: No need of list now. Convert it to per-cpu variable */
> >  static DEFINE_PER_CPU(struct list_head, cgrp_cpuctx_list);
> 
> Something like so I suppose...
> 

I need this on top to avoid a spat on perf_cgroup_attach()

---


diff --git a/kernel/events/core.c b/kernel/events/core.c
index 0cd81a3ef374..c6b64a48dea6 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -13536,9 +13536,12 @@ static int perf_cgroup_css_online(struct cgroup_subsys_state *css)
 static int __perf_cgroup_move(void *info)
 {
 	struct task_struct *task = info;
-	rcu_read_lock();
-	perf_cgroup_switch(task);
-	rcu_read_unlock();
+
+	preempt_disable();
+	if (atomic_read(this_cpu_ptr(&perf_cgroup_events)))
+		perf_cgroup_switch(task);
+	preempt_enable();
+
 	return 0;
 }
 
