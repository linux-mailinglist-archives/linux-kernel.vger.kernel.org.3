Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00859534CA5
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 11:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346877AbiEZJmn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 05:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234213AbiEZJml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 05:42:41 -0400
Received: from relay3.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 792AFC8BDD
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 02:42:40 -0700 (PDT)
Received: from omf07.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay08.hostedemail.com (Postfix) with ESMTP id B976720544;
        Thu, 26 May 2022 09:42:38 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf07.hostedemail.com (Postfix) with ESMTPA id 021252003D;
        Thu, 26 May 2022 09:42:35 +0000 (UTC)
Message-ID: <c6ef4c847aecbe12cc2bd71509c0359aade18fcc.camel@perches.com>
Subject: Re: [PATCH] sched: change printk(KERN_<LEVEL>.. to pr_<level>()
From:   Joe Perches <joe@perches.com>
To:     Yu Zhe <yuzhe@nfschina.com>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        liqiong@nfschina.com
Date:   Thu, 26 May 2022 02:42:35 -0700
In-Reply-To: <20220526091031.3741819-1-yuzhe@nfschina.com>
References: <20220526091031.3741819-1-yuzhe@nfschina.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        KHOP_HELO_FCRDNS,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Stat-Signature: 4uf7udqbm87wddzbw3h8mwznh4j9xm41
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: 021252003D
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19/TJyW95qAsdXhHiBoregiLp5IybD9cZ8=
X-HE-Tag: 1653558155-406124
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-05-26 at 02:10 -0700, Yu Zhe wrote:
> Prefer pr_<level>(...  to printk(KERN_<LEVEL> ..., change them.

Do remember that checkpatch is just a guide and isn't always correct.

You are responsible for verifying that anything it suggests is
converted properly.

> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
[]
> @@ -9370,7 +9370,7 @@ static void dump_rq_tasks(struct rq *rq, const char *loglvl)
>  
>  	lockdep_assert_rq_held(rq);
>  
> -	printk("%sCPU%d enqueued tasks (%u total):\n", loglvl, cpu, rq->nr_running);
> +	pr_warn("%sCPU%d enqueued tasks (%u total):\n", loglvl, cpu, rq->nr_running);

This is _not_ a good change.

Do please look to see what loglvl is and if this change is appropriate.

>  	for_each_process_thread(g, p) {
>  		if (task_cpu(p) != cpu)
>  			continue;
> @@ -9378,7 +9378,7 @@ static void dump_rq_tasks(struct rq *rq, const char *loglvl)
>  		if (!task_on_rq_queued(p))
>  			continue;
>  
> -		printk("%s\tpid: %d, name: %s\n", loglvl, p->pid, p->comm);
> +		pr_warn("%s\tpid: %d, name: %s\n", loglvl, p->pid, p->comm);

here too.


