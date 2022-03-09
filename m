Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79A214D3D87
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 00:25:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238767AbiCIX0E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 18:26:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238086AbiCIX0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 18:26:03 -0500
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09BA9B16C6
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 15:25:04 -0800 (PST)
Received: from in02.mta.xmission.com ([166.70.13.52]:58064)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nS5fy-00DLZt-FH; Wed, 09 Mar 2022 16:25:02 -0700
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:34678 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nS5fw-007XsN-TV; Wed, 09 Mar 2022 16:25:01 -0700
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexey Gladkov <legion@kernel.org>,
        Kyle Huey <me@kylehuey.com>, Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Al Viro <viro@ZenIV.linux.org.uk>
References: <87o82gdlu9.fsf_-_@email.froward.int.ebiederm.org>
        <20220309162454.123006-7-ebiederm@xmission.com>
        <01459886-2393-665a-43b1-70082ceace0c@kernel.dk>
Date:   Wed, 09 Mar 2022 17:24:37 -0600
In-Reply-To: <01459886-2393-665a-43b1-70082ceace0c@kernel.dk> (Jens Axboe's
        message of "Wed, 9 Mar 2022 14:05:50 -0700")
Message-ID: <87cziubtfu.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1nS5fw-007XsN-TV;;;mid=<87cziubtfu.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1904JK8obr4VAxpJhTYq0MRWEXfEX6zYh4=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Virus: No
X-Spam-DCC: XMission; sa02 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Jens Axboe <axboe@kernel.dk>
X-Spam-Relay-Country: 
X-Spam-Timing: total 398 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 3.9 (1.0%), b_tie_ro: 2.8 (0.7%), parse: 1.01
        (0.3%), extract_message_metadata: 12 (3.0%), get_uri_detail_list: 1.37
        (0.3%), tests_pri_-1000: 16 (4.0%), tests_pri_-950: 1.46 (0.4%),
        tests_pri_-900: 1.16 (0.3%), tests_pri_-90: 136 (34.2%), check_bayes:
        134 (33.7%), b_tokenize: 5 (1.3%), b_tok_get_all: 6 (1.5%),
        b_comp_prob: 2.1 (0.5%), b_tok_touch_all: 118 (29.6%), b_finish: 0.82
        (0.2%), tests_pri_0: 214 (53.8%), check_dkim_signature: 0.55 (0.1%),
        check_dkim_adsp: 1.92 (0.5%), poll_dns_idle: 0.21 (0.1%),
        tests_pri_10: 1.84 (0.5%), tests_pri_500: 7 (1.7%), rewrite_mail: 0.00
        (0.0%)
Subject: Re: [PATCH 07/13] task_work: Introduce task_work_pending
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe <axboe@kernel.dk> writes:

> On 3/9/22 9:24 AM, Eric W. Biederman wrote:
>> diff --git a/include/linux/task_work.h b/include/linux/task_work.h
>> index 5b8a93f288bb..897494b597ba 100644
>> --- a/include/linux/task_work.h
>> +++ b/include/linux/task_work.h
>> @@ -19,6 +19,11 @@ enum task_work_notify_mode {
>>  	TWA_SIGNAL,
>>  };
>>  
>> +static inline bool task_work_pending(struct task_struct *task)
>> +{
>> +	return READ_ONCE(task->task_works);
>> +}
>> +
>
> Most of the checks for this is current, do we need READ_ONCE here?

There is a non-current use in fs/io_uring in __io_uring_show_fdinfo
and another in task_work_cancel_match.

Beyond that there are quite a few writes that are not at all from
current so even on current task->task_works can change if you look
twice.

So if only to keep it from making unwarranted assumptions I think
READ_ONCE makes sense.

Given that READ_ONCE is practically free I don't see where there is
any harm in using it to document the kind of code we expect the compiler
to generate.

Looking a second time I see all of the other reads of task->task_works
are already READ_ONCE in kernel/task_work.c, so really I think if we
don't want READ_ONCE we need a big fat comment about why it is safe
in a check like task_work_pending and while it is needed everywhere
else.  At the moment I am not smart enough to write that comment.

I will see about adding this bit of discussion in the commit comment to
make it a little clearer why I am introducing READ_ONCE.

Eric

