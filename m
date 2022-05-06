Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2250B51DFB8
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 21:43:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391161AbiEFTqs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 15:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234627AbiEFTqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 15:46:45 -0400
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0C2368FB3;
        Fri,  6 May 2022 12:43:00 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:48382)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nn3qr-00AmLz-LF; Fri, 06 May 2022 13:42:57 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:37254 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nn3qp-00AEeV-Kg; Fri, 06 May 2022 13:42:57 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     linux-kernel@vger.kernel.org, rjw@rjwysocki.net, mingo@kernel.org,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, mgorman@suse.de, bigeasy@linutronix.de,
        Will Deacon <will@kernel.org>, tj@kernel.org,
        linux-pm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um@lists.infradead.org, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org, Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>, linux-ia64@vger.kernel.org
References: <87a6bv6dl6.fsf_-_@email.froward.int.ebiederm.org>
        <20220505182645.497868-10-ebiederm@xmission.com>
        <20220506150903.GB16084@redhat.com>
Date:   Fri, 06 May 2022 14:42:16 -0500
In-Reply-To: <20220506150903.GB16084@redhat.com> (Oleg Nesterov's message of
        "Fri, 6 May 2022 17:09:04 +0200")
Message-ID: <874k2230tj.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1nn3qp-00AEeV-Kg;;;mid=<874k2230tj.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX193hxkPxGdrMoGxQM4MFn+uyJKR1dj9OVA=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Virus: No
X-Spam-DCC: XMission; sa01 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Oleg Nesterov <oleg@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1285 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 3.7 (0.3%), b_tie_ro: 2.5 (0.2%), parse: 0.96
        (0.1%), extract_message_metadata: 3.0 (0.2%), get_uri_detail_list:
        0.85 (0.1%), tests_pri_-1000: 4.7 (0.4%), tests_pri_-950: 1.39 (0.1%),
        tests_pri_-900: 1.16 (0.1%), tests_pri_-90: 72 (5.6%), check_bayes: 71
        (5.5%), b_tokenize: 8 (0.6%), b_tok_get_all: 6 (0.5%), b_comp_prob:
        2.4 (0.2%), b_tok_touch_all: 51 (4.0%), b_finish: 0.64 (0.0%),
        tests_pri_0: 1179 (91.7%), check_dkim_signature: 0.37 (0.0%),
        check_dkim_adsp: 1.72 (0.1%), poll_dns_idle: 0.34 (0.0%),
        tests_pri_10: 2.8 (0.2%), tests_pri_500: 8 (0.6%), rewrite_mail: 0.00
        (0.0%)
Subject: Re: [PATCH v4 10/12] ptrace: Don't change __state
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov <oleg@redhat.com> writes:

> On 05/05, Eric W. Biederman wrote:
>>
>> --- a/include/linux/sched.h
>> +++ b/include/linux/sched.h
>> @@ -103,7 +103,7 @@ struct task_group;
>>  /* Convenience macros for the sake of set_current_state: */
>>  #define TASK_KILLABLE			(TASK_WAKEKILL | TASK_UNINTERRUPTIBLE)
>>  #define TASK_STOPPED			(TASK_WAKEKILL | __TASK_STOPPED)
>> -#define TASK_TRACED			(TASK_WAKEKILL | __TASK_TRACED)
>> +#define TASK_TRACED			__TASK_TRACED
>
> however I personally still dislike this change. But let me read the
> code with this series applied, perhaps I will change my mind. If not,
> I will argue ;)

That is fair.  I kind of grew on my after I implemented it and wrapped
my head around what was going on, as it is simple and there are no
implicit cases.

Eric
