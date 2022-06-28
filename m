Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD6F55ECB5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 20:38:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233019AbiF1Sh7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 14:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbiF1Sh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 14:37:56 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B450420F5F;
        Tue, 28 Jun 2022 11:37:55 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25SHgO3i002705;
        Tue, 28 Jun 2022 18:37:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=Kr5eKPrGqH/iNt4EQ0PmPKbTFY3yJ6iKC1kNfLg+lcI=;
 b=EfR84tCSRMY9D4gP0GALzXA9TYqEFiimlq+a9HZ+wfgu5kAop0DsGCCmocjxhBIhBMhF
 CUjSFnMHRw/e92Vcj1SW268sDgW0Y2I2ZIurTKScJNqkEs9tlWBlUBNmcWUy4yHPFJKL
 lMRrtL26w2XXeDxA3BYGt3wsgE6oODlxy5HK0PQ8/kibjRuvDXTzpj6+xkQNsOVejwmx
 /AFST05sKWtZ4zx4TeoQ9kmw0SIxaAr/l4P3BQscv23JK0RWa72VECTiAbIS3pXLWec9
 vyJxVePP5ciHa1/IWVui9cunXighug4rA9LIC4wahB2ckeUBg3hakrXGM3WNZsPBRCYI oQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h06989ptj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Jun 2022 18:37:01 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 25SHidEN010965;
        Tue, 28 Jun 2022 18:37:00 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h06989pry-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Jun 2022 18:37:00 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 25SIZBGw006547;
        Tue, 28 Jun 2022 18:36:57 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06ams.nl.ibm.com with ESMTP id 3gwsmj5a0j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Jun 2022 18:36:57 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 25SIatuf21823956
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Jun 2022 18:36:55 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3A7384C044;
        Tue, 28 Jun 2022 18:36:55 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8A1464C040;
        Tue, 28 Jun 2022 18:36:54 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 28 Jun 2022 18:36:54 +0000 (GMT)
Date:   Tue, 28 Jun 2022 20:36:53 +0200
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
Message-ID: <YrtKReO2vIiX8VVU@tuxmaker.boeblingen.de.ibm.com>
References: <87a6bv6dl6.fsf_-_@email.froward.int.ebiederm.org>
 <20220505182645.497868-12-ebiederm@xmission.com>
 <YrHA5UkJLornOdCz@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
 <877d5ajesi.fsf@email.froward.int.ebiederm.org>
 <YrHgo8GKFPWwoBoJ@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
 <87y1xk8zx5.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y1xk8zx5.fsf@email.froward.int.ebiederm.org>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: JKZNRj7mPThveR49Jq1cKgSMT_MSny1l
X-Proofpoint-ORIG-GUID: clmplF6XXiQeVpQGsOzYn3NLFuBGpIX_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-06-28_11,2022-06-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 phishscore=0 spamscore=0 clxscore=1015 mlxlogscore=999
 malwarescore=0 impostorscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206280074
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 25, 2022 at 11:34:46AM -0500, Eric W. Biederman wrote:
> I haven't gotten as far as reproducing this but I have started giving
> this issue some thought.
> 
> This entire thing smells like a memory barrier is missing somewhere.
> However by definition the lock implementations in linux provide all the
> needed memory barriers, and in the ptrace_stop and ptrace_check_attach
> path I don't see cases where these values are sampled outside of a lock
> except in wait_task_inactive.  Does doing that perhaps require a
> barrier? 
> 
> The two things I can think of that could shed light on what is going on
> is enabling lockdep, to enable the debug check in signal_wake_up_state
> and verifying bits of state that should be constant while the task
> is frozen for ptrace are indeed constant when task is frozen for ptrace.
> Something like my patch below.
> 
> If you could test that when you have a chance that would help narrow
> down what is going on.
> 
> Thank you,
> Eric
> 
> diff --git a/kernel/ptrace.c b/kernel/ptrace.c
> index 156a99283b11..6467a2b1c3bc 100644
> --- a/kernel/ptrace.c
> +++ b/kernel/ptrace.c
> @@ -268,9 +268,13 @@ static int ptrace_check_attach(struct task_struct *child, bool ignore_state)
>  	}
>  	read_unlock(&tasklist_lock);
>  
> -	if (!ret && !ignore_state &&
> -	    WARN_ON_ONCE(!wait_task_inactive(child, __TASK_TRACED)))
> +	if (!ret && !ignore_state) {
> +		WARN_ON_ONCE(!(child->jobctl & JOBCTL_PTRACE_FROZEN));
> +		WARN_ON_ONCE(!(child->joctctl & JOBCTL_TRACED));
> +		WARN_ON_ONCE(READ_ONCE(child->__state) != __TASK_TRACED);
> +		WARN_ON_ONCE(!wait_task_inactive(child, __TASK_TRACED));
>  		ret = -ESRCH;
> +	}
>  
>  	return ret;
>  }

I modified your chunk a bit - hope that is what you had in mind:

diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 156a99283b11..f0e9a9a4d63c 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -268,9 +268,19 @@ static int ptrace_check_attach(struct task_struct *child, bool ignore_state)
 	}
 	read_unlock(&tasklist_lock);
 
-	if (!ret && !ignore_state &&
-	    WARN_ON_ONCE(!wait_task_inactive(child, __TASK_TRACED)))
-		ret = -ESRCH;
+	if (!ret && !ignore_state) {
+		unsigned int __state;
+
+		WARN_ON_ONCE(!(child->jobctl & JOBCTL_PTRACE_FROZEN));
+		WARN_ON_ONCE(!(child->jobctl & JOBCTL_TRACED));
+		__state = READ_ONCE(child->__state);
+		if (__state != __TASK_TRACED) {
+			pr_err("%s(%d) __state %x", __FUNCTION__, __LINE__, __state);
+			WARN_ON_ONCE(1);
+		}
+		if (WARN_ON_ONCE(!wait_task_inactive(child, __TASK_TRACED)))
+			ret = -ESRCH;
+	}
 
 	return ret;
 }


When WARN_ON_ONCE(1) hits the child __state is always zero/TASK_RUNNING,
as reported by the preceding pr_err(). Yet, in the resulting core dump
it is always __TASK_TRACED.

Removing WARN_ON_ONCE(1) while looping until (__state != __TASK_TRACED)
confirms the unexpected __state is always TASK_RUNNING. It never observed
more than one iteration and gets printed once in 30-60 mins.

So probably when the condition is entered __state is TASK_RUNNING more
often, but gets overwritten with __TASK_TRACED pretty quickly. Which kind
of consistent with my previous observation that kernel/sched/core.c:3305
is where return 0 makes wait_task_inactive() fail.

No other WARN_ON_ONCE() hit ever.
