Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 964414DCD9C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 19:33:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237450AbiCQSeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 14:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235157AbiCQSeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 14:34:05 -0400
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E76A8E9CB2;
        Thu, 17 Mar 2022 11:32:48 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:54822)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nUuvX-00EeQu-9o; Thu, 17 Mar 2022 12:32:47 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:38386 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nUuvW-000unu-Ab; Thu, 17 Mar 2022 12:32:46 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexey Gladkov <legion@kernel.org>,
        Kyle Huey <me@kylehuey.com>, Kees Cook <keescook@chromium.org>,
        Al Viro <viro@ZenIV.linux.org.uk>, linux-api@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
References: <87a6ha4zsd.fsf@email.froward.int.ebiederm.org>
        <87bl1kunjj.fsf@email.froward.int.ebiederm.org>
        <87r19opkx1.fsf_-_@email.froward.int.ebiederm.org>
        <87o82gdlu9.fsf_-_@email.froward.int.ebiederm.org>
        <87tubyx0rg.fsf_-_@email.froward.int.ebiederm.org>
        <875yoe7qdp.fsf_-_@email.froward.int.ebiederm.org>
        <20220317180856.GB13318@redhat.com>
Date:   Thu, 17 Mar 2022 13:31:58 -0500
In-Reply-To: <20220317180856.GB13318@redhat.com> (Oleg Nesterov's message of
        "Thu, 17 Mar 2022 19:08:57 +0100")
Message-ID: <871qz04eht.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1nUuvW-000unu-Ab;;;mid=<871qz04eht.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+s7QqFvk2d1PVvznaot3c59gGze14b/sE=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Oleg Nesterov <oleg@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 404 ms - load_scoreonly_sql: 0.08 (0.0%),
        signal_user_changed: 11 (2.6%), b_tie_ro: 9 (2.3%), parse: 1.08 (0.3%),
         extract_message_metadata: 3.7 (0.9%), get_uri_detail_list: 1.37
        (0.3%), tests_pri_-1000: 4.0 (1.0%), tests_pri_-950: 1.27 (0.3%),
        tests_pri_-900: 1.04 (0.3%), tests_pri_-90: 97 (23.9%), check_bayes:
        95 (23.4%), b_tokenize: 7 (1.7%), b_tok_get_all: 7 (1.6%),
        b_comp_prob: 2.3 (0.6%), b_tok_touch_all: 74 (18.4%), b_finish: 1.15
        (0.3%), tests_pri_0: 253 (62.6%), check_dkim_signature: 0.49 (0.1%),
        check_dkim_adsp: 3.0 (0.7%), poll_dns_idle: 1.08 (0.3%), tests_pri_10:
        2.7 (0.7%), tests_pri_500: 20 (5.1%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 2/2] ptrace: Return the signal to continue with from
 ptrace_stop
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov <oleg@redhat.com> writes:

> Not sure I understand this patch, I can't apply it. I guess I need to
> clone your tree first, will do later.
>
> Just one question right now,
>
> On 03/15, Eric W. Biederman wrote:
>>
>> +static int ptrace_stop(int exit_code, int why, int clear_code,
>>  			unsigned long message, kernel_siginfo_t *info)
>>  	__releases(&current->sighand->siglock)
>>  	__acquires(&current->sighand->siglock)
>>  {
>>  	bool gstop_done = false;
>> +	bool read_code = true;
>>  
>>  	if (arch_ptrace_stop_needed()) {
>>  		/*
>> @@ -2305,8 +2307,9 @@ static void ptrace_stop(int exit_code, int why, int clear_code,
>>  
>>  		/* tasklist protects us from ptrace_freeze_traced() */
>>  		__set_current_state(TASK_RUNNING);
>> +		read_code = false;
>>  		if (clear_code)
>> -			current->exit_code = 0;
>> +			exit_code = 0;
>>  		read_unlock(&tasklist_lock);
>>  	}
>>  
>> @@ -2316,8 +2319,10 @@ static void ptrace_stop(int exit_code, int why, int clear_code,
>>  	 * any signal-sending on another CPU that wants to examine it.
>>  	 */
>>  	spin_lock_irq(&current->sighand->siglock);
>> +	if (read_code) exit_code = current->exit_code;
>
> style ;)
>
>>  	current->last_siginfo = NULL;
>>  	current->ptrace_message = 0;
>> +	current->exit_code = 0;
>
> OK, I like it... but can't we remove the ugly "int clear_code" arg?

The flag clear_code controls what happens if a ptrace_stop does not
stop.  In particular clear_code means do not continue with
a signal if we can not stop.

For do_jobctl_trap calling ptrace_stop it clearly does not matter.

For ptrace_signal it would be a change in behavior, that would
cause the signal not to be delivered.

For ptrace_do_notify we don't have a signal to deliver unless userspace
gives us one so clear_code makes sense at that point.

Which is a long way of saying that no we can not remove clear_stop
because the behavior it is used to implement makes sense and userspace
can reasonably depend upon it.

Eric


