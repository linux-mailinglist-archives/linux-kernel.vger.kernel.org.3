Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ECE64DB1EB
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 14:54:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353250AbiCPNzm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 09:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233718AbiCPNzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 09:55:39 -0400
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16B49B4E
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 06:54:25 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:46178)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nUU6Z-006iY5-MH; Wed, 16 Mar 2022 07:54:23 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:37928 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nUU6Y-00HDTA-AC; Wed, 16 Mar 2022 07:54:23 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20220316165612.4f50faad@canb.auug.org.au>
Date:   Wed, 16 Mar 2022 08:54:15 -0500
In-Reply-To: <20220316165612.4f50faad@canb.auug.org.au> (Stephen Rothwell's
        message of "Wed, 16 Mar 2022 16:56:12 +1100")
Message-ID: <871qz257g8.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1nUU6Y-00HDTA-AC;;;mid=<871qz257g8.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19wBYZXI6ToWV3riBhbTAJX534/W8fHVSg=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Virus: No
X-Spam-DCC: XMission; sa01 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Stephen Rothwell <sfr@canb.auug.org.au>
X-Spam-Relay-Country: 
X-Spam-Timing: total 655 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 4.0 (0.6%), b_tie_ro: 2.8 (0.4%), parse: 0.67
        (0.1%), extract_message_metadata: 8 (1.3%), get_uri_detail_list: 1.31
        (0.2%), tests_pri_-1000: 3.7 (0.6%), tests_pri_-950: 1.17 (0.2%),
        tests_pri_-900: 0.90 (0.1%), tests_pri_-90: 111 (16.9%), check_bayes:
        109 (16.6%), b_tokenize: 6 (0.9%), b_tok_get_all: 6 (1.0%),
        b_comp_prob: 1.69 (0.3%), b_tok_touch_all: 92 (14.0%), b_finish: 0.77
        (0.1%), tests_pri_0: 254 (38.8%), check_dkim_signature: 0.39 (0.1%),
        check_dkim_adsp: 1.71 (0.3%), poll_dns_idle: 252 (38.5%),
        tests_pri_10: 1.80 (0.3%), tests_pri_500: 267 (40.8%), rewrite_mail:
        0.00 (0.0%)
Subject: Re: linux-next: build failure after merge of the userns tree
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Rothwell <sfr@canb.auug.org.au> writes:

> Hi all,
>
> After merging the userns tree, today's linux-next build (powerpc
> ppc64_defconfig) failed like this:
>
> kernel/sched/fair.c: In function 'init_numa_balancing':
> kernel/sched/fair.c:2884:9: error: implicit declaration of function 'init_task_work'; did you mean 'init_irq_work'? [-Werror=implicit-function-declaration]
>  2884 |         init_task_work(&p->numa_work, task_numa_work);
>       |         ^~~~~~~~~~~~~~
>       |         init_irq_work
> kernel/sched/fair.c: In function 'task_tick_numa':
> kernel/sched/fair.c:2935:25: error: implicit declaration of function 'task_work_add' [-Werror=implicit-function-declaration]
>  2935 |                         task_work_add(curr, work, TWA_RESUME);
>       |                         ^~~~~~~~~~~~~
> kernel/sched/fair.c:2935:51: error: 'TWA_RESUME' undeclared (first use in this function)
>  2935 |                         task_work_add(curr, work, TWA_RESUME);
>       |                                                   ^~~~~~~~~~
>
> Maybe caused by commit
>
>   03248addadf1 ("resume_user_mode: Move to resume_user_mode.h")
> or
>   8ca07e17c9dd ("task_work: Remove unnecessary include from posix_timers.h")

Yes.  That has the potential to have hidden a bug like this.

> interacting with (maybe) commit
>
>   c4ad6fcb67c4 ("sched/headers: Reorganize, clean up and optimize kernel/sched/fair.c dependencies")
>
> from the tip tree.
>

It is commit 4ff8f2ca6ccd ("sched/headers: Reorganize, clean up and
optimize kernel/sched/sched.h dependencies") that ultimately removes the
include of task_work.h from "sched.h".

But yes ideally commit c4ad6fcb67c4 ("sched/headers: Reorganize, clean
up and optimize kernel/sched/fair.c dependencies") would have added an
include of task_work.h into kernel/sched/fair.c

Ingo any chance you can fix this in your tree?  kernel/sched/fair.c
needs to include <linux/task_work.h> regardless. So I don't think this
is a bad thing.

Eric


> I have applied this merge fix patch.
>
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Wed, 16 Mar 2022 16:41:42 +1100
> Subject: [PATCH] fixup for moving of linux/task_work.h
>
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  kernel/sched/fair.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 89d21fda106c..7a6678fdffb0 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -31,6 +31,7 @@
>  #include <linux/lockdep_api.h>
>  #include <linux/softirq.h>
>  #include <linux/refcount_api.h>
> +#include <linux/task_work.h>
>  #include <linux/topology.h>
>  #include <linux/sched/clock.h>
>  #include <linux/sched/cond_resched.h>
> -- 
>
> 2.34.1
