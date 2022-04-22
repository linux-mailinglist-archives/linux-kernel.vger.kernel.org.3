Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09DD350BC22
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 17:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1449558AbiDVPzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 11:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1449529AbiDVPzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 11:55:04 -0400
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC91C14094;
        Fri, 22 Apr 2022 08:52:10 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:42002)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nhvZo-008rDR-Gt; Fri, 22 Apr 2022 09:52:08 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:35286 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nhvZn-000unz-GW; Fri, 22 Apr 2022 09:52:08 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     rjw@rjwysocki.net, oleg@redhat.com, mingo@kernel.org,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, mgorman@suse.de, bigeasy@linutronix.de,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        tj@kernel.org, linux-pm@vger.kernel.org
In-Reply-To: <20220421200721.GF2762@worktop.programming.kicks-ass.net> (Peter
        Zijlstra's message of "Thu, 21 Apr 2022 22:07:21 +0200")
References: <20220421150248.667412396@infradead.org>
        <20220421150655.001952823@infradead.org>
        <878rrys5yj.fsf@email.froward.int.ebiederm.org>
        <20220421195551.GO2731@worktop.programming.kicks-ass.net>
        <20220421200721.GF2762@worktop.programming.kicks-ass.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
Date:   Fri, 22 Apr 2022 10:52:01 -0500
Message-ID: <87levxnmji.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1nhvZn-000unz-GW;;;mid=<87levxnmji.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX19IZ6OPiXYdorj5n5pPNDYMoF/GUaQoYhI=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Virus: No
X-Spam-DCC: XMission; sa01 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;Peter Zijlstra <peterz@infradead.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 361 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 4.6 (1.3%), b_tie_ro: 3.1 (0.9%), parse: 1.06
        (0.3%), extract_message_metadata: 11 (3.1%), get_uri_detail_list: 1.39
        (0.4%), tests_pri_-1000: 9 (2.4%), tests_pri_-950: 1.06 (0.3%),
        tests_pri_-900: 0.81 (0.2%), tests_pri_-90: 105 (29.0%), check_bayes:
        102 (28.2%), b_tokenize: 4.5 (1.3%), b_tok_get_all: 6 (1.6%),
        b_comp_prob: 1.41 (0.4%), b_tok_touch_all: 87 (24.1%), b_finish: 0.79
        (0.2%), tests_pri_0: 216 (59.9%), check_dkim_signature: 0.37 (0.1%),
        check_dkim_adsp: 2.8 (0.8%), poll_dns_idle: 0.26 (0.1%), tests_pri_10:
        2.6 (0.7%), tests_pri_500: 7 (2.0%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v2 5/5] freezer,sched: Rewrite core freezer logic
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra <peterz@infradead.org> writes:

> On Thu, Apr 21, 2022 at 09:55:51PM +0200, Peter Zijlstra wrote:
>> On Thu, Apr 21, 2022 at 12:26:44PM -0500, Eric W. Biederman wrote:
>> > Peter Zijlstra <peterz@infradead.org> writes:
>> > 
>> > > --- a/kernel/ptrace.c
>> > > +++ b/kernel/ptrace.c
>> > > @@ -288,7 +288,7 @@ static int ptrace_check_attach(struct ta
>> > >  	}
>> > >  	__set_current_state(TASK_RUNNING);
>> > >  
>> > > -	if (!wait_task_inactive(child, TASK_TRACED) ||
>> > > +	if (!wait_task_inactive(child, TASK_TRACED|TASK_FREEZABLE) ||
>> > >  	    !ptrace_freeze_traced(child))
>> > >  		return -ESRCH;
>> > 
>> > Do we mind that this is going to fail if the child is frozen
>> > during ptrace_check_attach?
>> 
>> Why should this fail? wait_task_inactive() will in fact succeed if it is
>> frozen due to the added TASK_FREEZABLE and some wait_task_inactive()
>> changes elsewhere in this patch.
>
> These:

I had missed that change to wait_task_inactive.

Still that change to wait_task_inactive fundamentally depends upon the
fact that we don't care about the state we are passing into
wait_task_inactive.  So I think it would be better to simply have a
precursor patch that changes wait_task_inactive(child, TASK_TRACED) to
wait_task_inactive(child, 0) and say so explicitly.

Eric
