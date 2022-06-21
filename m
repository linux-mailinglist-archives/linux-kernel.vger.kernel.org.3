Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAAF65532D3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 15:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345581AbiFUNCB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 09:02:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345250AbiFUNBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 09:01:37 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 804012A73B;
        Tue, 21 Jun 2022 06:01:33 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25LCgBBv008724;
        Tue, 21 Jun 2022 13:00:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=INIoxh3uB/g84CnlKEVK7DkW60H3xY6l/Dj67LAzEhU=;
 b=d5wnwulCcQfGxdcD2fd3NLhuX5nfTX/9Tv38VbiMlXBWUr1sebIhxyCPZabwGW9JNyYK
 AgnaliH6U98/Z9p/Cx3OCsIwCXCXJ5wZOj+QkeOUW+sDV1axiAbeT1FCesecY8KiDuhx
 ClvwWnnLC5vTqSu1/0IuliYM1PCGJmydsvquNnpFQgME3SVhAjdnpv/2CUNRO8kYZbtN
 dqlPh9/xUyKeQWwQq8mdSpWdRnZ2AtLViKQlQD/AA7A4oOoH4KCQl6MNAVEYYlQft1Dg
 7c9YEjCo9JEZMDbacwKZ1MaWhR7kSLnwQHfEOVjpQIulYUAwcZJQm7Se/PyjPa9P7Zbu 7Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gue7n8h5q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Jun 2022 13:00:30 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 25LCgIkg008927;
        Tue, 21 Jun 2022 13:00:29 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gue7n8h3b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Jun 2022 13:00:29 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 25LCpm6Q023948;
        Tue, 21 Jun 2022 13:00:27 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04ams.nl.ibm.com with ESMTP id 3gs6b9429v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Jun 2022 13:00:27 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 25LD0O3e15008038
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jun 2022 13:00:24 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C48BB42054;
        Tue, 21 Jun 2022 13:00:24 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4C64842045;
        Tue, 21 Jun 2022 13:00:23 +0000 (GMT)
Received: from li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com (unknown [9.145.144.178])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 21 Jun 2022 13:00:23 +0000 (GMT)
Date:   Tue, 21 Jun 2022 15:00:21 +0200
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org, rjw@rjwysocki.net,
        Oleg Nesterov <oleg@redhat.com>, mingo@kernel.org,
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
Subject: Re: [PATCH v4 12/12] sched,signal,ptrace: Rework TASK_TRACED,
 TASK_STOPPED state
Message-ID: <YrHA5UkJLornOdCz@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
References: <87a6bv6dl6.fsf_-_@email.froward.int.ebiederm.org>
 <20220505182645.497868-12-ebiederm@xmission.com>
Content-Type: multipart/mixed; boundary="N4j0vMBA8JArVaRj"
Content-Disposition: inline
In-Reply-To: <20220505182645.497868-12-ebiederm@xmission.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: DvpD6a9DpHAX-uGDu1YH6gtZIsnZ5-px
X-Proofpoint-ORIG-GUID: j2ZkUQPeXm04GYSgMt7nlbITLz7lQeFc
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-21_05,2022-06-21_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 phishscore=0 priorityscore=1501 clxscore=1011 adultscore=0 impostorscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206210055
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--N4j0vMBA8JArVaRj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 

On Thu, May 05, 2022 at 01:26:45PM -0500, Eric W. Biederman wrote:
> From: Peter Zijlstra <peterz@infradead.org>
> 
> Currently ptrace_stop() / do_signal_stop() rely on the special states
> TASK_TRACED and TASK_STOPPED resp. to keep unique state. That is, this
> state exists only in task->__state and nowhere else.
> 
> There's two spots of bother with this:
> 
>  - PREEMPT_RT has task->saved_state which complicates matters,
>    meaning task_is_{traced,stopped}() needs to check an additional
>    variable.
> 
>  - An alternative freezer implementation that itself relies on a
>    special TASK state would loose TASK_TRACED/TASK_STOPPED and will
>    result in misbehaviour.
> 
> As such, add additional state to task->jobctl to track this state
> outside of task->__state.
> 
> NOTE: this doesn't actually fix anything yet, just adds extra state.
> 
> --EWB
>   * didn't add a unnecessary newline in signal.h
>   * Update t->jobctl in signal_wake_up and ptrace_signal_wake_up
>     instead of in signal_wake_up_state.  This prevents the clearing
>     of TASK_STOPPED and TASK_TRACED from getting lost.
>   * Added warnings if JOBCTL_STOPPED or JOBCTL_TRACED are not cleared

Hi Eric, Peter,

On s390 this patch triggers warning at kernel/ptrace.c:272 when
kill_child testcase from strace tool is repeatedly used (the source
is attached for reference):

while :; do
	strace -f -qq -e signal=none -e trace=sched_yield,/kill ./kill_child
done

It normally takes few minutes to cause the warning in -rc3, but FWIW
it hits almost immediately for ptrace_stop-cleanup-for-v5.19 tag of
git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.

Commit 7b0fe1367ef2 ("ptrace: Document that wait_task_inactive can't
fail") suggests this WARN_ON_ONCE() is not really expected, yet we
observe a child in __TASK_TRACED state. Could you please comment here?

Thanks!

--N4j0vMBA8JArVaRj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="kill_child.c"

/*
 * Check for the corner case that previously lead to segfault
 * due to an attempt to access unitialised tcp->s_ent.
 *
 * 13994 ????( <unfinished ...>
 * ...
 * 13994 <... ???? resumed>) = ?
 *
 * Copyright (c) 2019 The strace developers.
 * All rights reserved.
 *
 * SPDX-License-Identifier: GPL-2.0-or-later
 */

#include "tests.h"

#include <sched.h>
#include <signal.h>
#include <unistd.h>
#include <sys/mman.h>
#include <sys/wait.h>

#define ITERS    10000
#define SC_ITERS 10000

int
main(void)
{
	volatile sig_atomic_t *const mem =
		mmap(NULL, get_page_size(), PROT_READ | PROT_WRITE,
		     MAP_SHARED | MAP_ANONYMOUS, -1, 0);
	if (mem == MAP_FAILED)
		perror_msg_and_fail("mmap");

	for (unsigned int i = 0; i < ITERS; ++i) {
		mem[0] = mem[1] = 0;

		const pid_t pid = fork();
		if (pid < 0)
			perror_msg_and_fail("fork");

		if (!pid) {
			/* wait for the parent */
			while (!mem[0])
				;
			/* let the parent know we are running */
			mem[1] = 1;

			for (unsigned int j = 0; j < SC_ITERS; j++)
				sched_yield();

			pause();
			return 0;
		}

		/* let the child know we are running */
		mem[0] = 1;
		/* wait for the child */
		while (!mem[1])
			;

		if (kill(pid, SIGKILL))
			perror_msg_and_fail("kill");
		if (wait(NULL) != pid)
			perror_msg_and_fail("wait");
	}

	return 0;
}

--N4j0vMBA8JArVaRj--

