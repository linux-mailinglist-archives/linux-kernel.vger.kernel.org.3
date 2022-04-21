Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8409150A714
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 19:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390760AbiDURaG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 13:30:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352322AbiDURaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 13:30:05 -0400
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1D4B42A33
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 10:27:14 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:38236)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nhaaG-0075j1-0N; Thu, 21 Apr 2022 11:27:12 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:35224 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nhaaE-00CsQK-DO; Thu, 21 Apr 2022 11:27:11 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     rjw@rjwysocki.net, oleg@redhat.com, mingo@kernel.org,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, mgorman@suse.de, bigeasy@linutronix.de,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        tj@kernel.org, linux-pm@vger.kernel.org
References: <20220421150248.667412396@infradead.org>
        <20220421150655.001952823@infradead.org>
Date:   Thu, 21 Apr 2022 12:26:44 -0500
In-Reply-To: <20220421150655.001952823@infradead.org> (Peter Zijlstra's
        message of "Thu, 21 Apr 2022 17:02:53 +0200")
Message-ID: <878rrys5yj.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1nhaaE-00CsQK-DO;;;mid=<878rrys5yj.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX1/eM4M3vABt0zGjlkIS7dSJhVL77s2rIZ4=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;Peter Zijlstra <peterz@infradead.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 354 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 11 (3.1%), b_tie_ro: 9 (2.7%), parse: 0.78 (0.2%),
         extract_message_metadata: 11 (3.0%), get_uri_detail_list: 0.68 (0.2%),
         tests_pri_-1000: 11 (3.0%), tests_pri_-950: 1.24 (0.4%),
        tests_pri_-900: 1.00 (0.3%), tests_pri_-90: 116 (32.9%), check_bayes:
        113 (31.8%), b_tokenize: 5.0 (1.4%), b_tok_get_all: 4.9 (1.4%),
        b_comp_prob: 1.77 (0.5%), b_tok_touch_all: 98 (27.5%), b_finish: 0.86
        (0.2%), tests_pri_0: 190 (53.7%), check_dkim_signature: 0.48 (0.1%),
        check_dkim_adsp: 2.8 (0.8%), poll_dns_idle: 0.46 (0.1%), tests_pri_10:
        2.0 (0.6%), tests_pri_500: 7 (2.1%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v2 5/5] freezer,sched: Rewrite core freezer logic
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra <peterz@infradead.org> writes:

> --- a/kernel/ptrace.c
> +++ b/kernel/ptrace.c
> @@ -288,7 +288,7 @@ static int ptrace_check_attach(struct ta
>  	}
>  	__set_current_state(TASK_RUNNING);
>  
> -	if (!wait_task_inactive(child, TASK_TRACED) ||
> +	if (!wait_task_inactive(child, TASK_TRACED|TASK_FREEZABLE) ||
>  	    !ptrace_freeze_traced(child))
>  		return -ESRCH;

Do we mind that this is going to fail if the child is frozen
during ptrace_check_attach?

I think to avoid that we need to safely get this to
wait_task_inactive(child, 0), like the coredump code uses.

I would like to say that we can do without the wait_task_inactive,
but it looks like it is necessary to ensure that all of the userspace
registers are saved where the tracer can get at them.

Eric
