Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9D5652E0D4
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 01:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343765AbiESXta (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 19:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343776AbiESXtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 19:49:24 -0400
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7525A1271A7;
        Thu, 19 May 2022 16:49:19 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:56376)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nrptC-005nI6-L7; Thu, 19 May 2022 17:49:06 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:38840 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nrptB-007p0E-Jc; Thu, 19 May 2022 17:49:06 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Doug Anderson <dianders@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Will Deacon <will@kernel.org>, Tejun Heo <tj@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um@lists.infradead.org, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org, Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>, linux-ia64@vger.kernel.org,
        Robert OCallahan <roc@pernos.co>, Kyle Huey <khuey@pernos.co>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Douglas Miller <dougmill@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
References: <871qwq5ucx.fsf_-_@email.froward.int.ebiederm.org>
        <20220518225355.784371-3-ebiederm@xmission.com>
        <CAD=FV=UFK7h0oHGJ23y37ShO+z4vt9ubGE9E4m=jMECgNAAHgA@mail.gmail.com>
Date:   Thu, 19 May 2022 18:48:40 -0500
In-Reply-To: <CAD=FV=UFK7h0oHGJ23y37ShO+z4vt9ubGE9E4m=jMECgNAAHgA@mail.gmail.com>
        (Doug Anderson's message of "Thu, 19 May 2022 13:52:22 -0700")
Message-ID: <8735h52ief.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1nrptB-007p0E-Jc;;;mid=<8735h52ief.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX1/r+I4NpBL/cjZDGRTZsuxWM8gB/3i+bCM=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Virus: No
X-Spam-DCC: XMission; sa02 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ****;Doug Anderson <dianders@chromium.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 379 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 4.0 (1.0%), b_tie_ro: 2.6 (0.7%), parse: 0.71
        (0.2%), extract_message_metadata: 12 (3.1%), get_uri_detail_list: 1.06
        (0.3%), tests_pri_-1000: 23 (6.1%), tests_pri_-950: 1.10 (0.3%),
        tests_pri_-900: 0.86 (0.2%), tests_pri_-90: 71 (18.7%), check_bayes:
        70 (18.4%), b_tokenize: 8 (2.2%), b_tok_get_all: 10 (2.6%),
        b_comp_prob: 2.0 (0.5%), b_tok_touch_all: 47 (12.3%), b_finish: 0.66
        (0.2%), tests_pri_0: 256 (67.7%), check_dkim_signature: 0.60 (0.2%),
        check_dkim_adsp: 2.2 (0.6%), poll_dns_idle: 0.76 (0.2%), tests_pri_10:
        1.72 (0.5%), tests_pri_500: 6 (1.7%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 03/16] kdb: Use real_parent when displaying a list of
 processes
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Doug Anderson <dianders@chromium.org> writes:

> Hi,
>
> On Wed, May 18, 2022 at 3:54 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>>
>> kdb has a bug that when using the ps command to display a list of
>> processes, if a process is being debugged the debugger as the parent
>> process.
>>
>> This is silly, and I expect it never comes up in ptractice.  As there
>> is very little point in using gdb and kdb simultaneously.  Update the
>> code to use real_parent so that it is clear kdb does not want to
>> display a debugger as the parent of a process.
>
> So I would tend to defer to Daniel, but I'm not convinced that the
> behavior you describe for kdb today _is_ actually silly.
>
> If I was in kdb and I was listing processes, I might actually want to
> see that a process's parent was set to gdb. Presumably that would tell
> me extra information that might be relevant to my debug session.
>
> Personally, I'd rather add an extra piece of information into the list
> showing the real parent if it's not the same as the parent. Then
> you're not throwing away information.

The name of the field is confusing for anyone who isn't intimate with
the implementation details.  The function getppid returns
tsk->real_parent->tgid.

If kdb wants information of what the tracer is that is fine, but I
recommend putting that information in another field.

Given that the original description says give the information that ps
gives my sense is that kdb is currently wrong.  Especially as it does
not give you the actual parentage anywhere.

I can certainly be convinced, but I do want some clarity.  It looks very
attractive to rename task->parent to task->ptracer and leave the field
NULL when there is no tracer.

Eric
