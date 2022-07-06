Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F4EC5688A8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 14:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233546AbiGFMs1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 08:48:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233465AbiGFMsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 08:48:24 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72590BF9
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 05:48:23 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 266CFN2K028179;
        Wed, 6 Jul 2022 12:48:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=fSPNY+OiJp0wUyPSKAfyfQcaV1gFB/fGEKhyfQNOqhk=;
 b=e2MEal4IgbEGRbwyvEUn0B2rvPPXkxrIVO56ugFgbrCsS7gb5yQS1whte+4Vx4QAAa0x
 yYIUyIg7kDK2ZCoD8C4HDJQXpuiQnfHxRgIkn6it6E9YZUZ3+fnJiur7Gm1rS9OsvFbg
 etQojyyt1+hMiz1RU6eQolAt0oOOCD79G+SN4NizevssGUd9HzOFEt5AInPtS8eMVTTR
 7v3yO1fIpqhXxqdEmTKNLYfc0RXwotw2KOpgXBpU5jl+iEJrsfDECCFfuAEPsvrnXfAT
 w7p3R08zoce8tWcWMnnvQoArE8nBk+lTlw+GvOmzi+rPWzxrAXdRNFUokKYmuppD+o4j aA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h5a7ygt6y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Jul 2022 12:48:13 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 266Cf0aq007070;
        Wed, 6 Jul 2022 12:48:12 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h5a7ygt6a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Jul 2022 12:48:12 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 266CZaGk011470;
        Wed, 6 Jul 2022 12:48:11 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03ams.nl.ibm.com with ESMTP id 3h4ujsh4au-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Jul 2022 12:48:10 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 266Cm8ul19661080
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 6 Jul 2022 12:48:08 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5E3574203F;
        Wed,  6 Jul 2022 12:48:08 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E85F842042;
        Wed,  6 Jul 2022 12:48:07 +0000 (GMT)
Received: from li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com (unknown [9.145.48.113])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed,  6 Jul 2022 12:48:07 +0000 (GMT)
Date:   Wed, 6 Jul 2022 14:48:06 +0200
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     Sven Schnelle <svens@linux.ibm.com>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ptrace: fix clearing of JOBCTL_TRACED in
 ptrace_unfreeze_traced()
Message-ID: <YsWEhoEHSbnD2e+u@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
References: <20220706101625.2100298-1-svens@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220706101625.2100298-1-svens@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: sDac5WY-KMihLIzMQDX1NZ6FNHv5t9Io
X-Proofpoint-ORIG-GUID: P8jN4riq4evkLt9Y6qNcdj9l4R526RyV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-06_08,2022-06-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 mlxlogscore=854 mlxscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 impostorscore=0 malwarescore=0 spamscore=0 priorityscore=1501 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207060049
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 06, 2022 at 12:16:25PM +0200, Sven Schnelle wrote:
> CI reported the following splat while running the strace testsuite:
> 
> [ 3976.640309] WARNING: CPU: 1 PID: 3570031 at kernel/ptrace.c:272 ptrace_check_attach+0x12e/0x178
> [ 3976.640391] CPU: 1 PID: 3570031 Comm: strace Tainted: G           OE     5.19.0-20220624.rc3.git0.ee819a77d4e7.300.fc36.s390x #1
> [ 3976.640410] Hardware name: IBM 3906 M04 704 (z/VM 7.1.0)
> [ 3976.640452] Call Trace:
> [ 3976.640454]  [<00000000ab4b645a>] ptrace_check_attach+0x132/0x178
> [ 3976.640457] ([<00000000ab4b6450>] ptrace_check_attach+0x128/0x178)
> [ 3976.640460]  [<00000000ab4b6cde>] __s390x_sys_ptrace+0x86/0x160
> [ 3976.640463]  [<00000000ac03fcec>] __do_syscall+0x1d4/0x200
> [ 3976.640468]  [<00000000ac04e312>] system_call+0x82/0xb0
> [ 3976.640470] Last Breaking-Event-Address:
> [ 3976.640471]  [<00000000ab4ea3c8>] wait_task_inactive+0x98/0x190
> 
> This is because JOBCTL_TRACED is set, but the task is not in TASK_TRACED
> state. Caused by ptrace_unfreeze_traced() which does:
> 
> task->jobctl &= ~TASK_TRACED
> 
> but it should be:
> 
> task->jobctl &= ~JOBCTL_TRACED
> 
> Fixes: 31cae1eaae4f ("sched,signal,ptrace: Rework TASK_TRACED, TASK_STOPPED state")
> Signed-off-by: Sven Schnelle <svens@linux.ibm.com>

Tested-by: Alexander Gordeev <agordeev@linux.ibm.com>

> ---
>  kernel/ptrace.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/ptrace.c b/kernel/ptrace.c
> index 156a99283b11..1893d909e45c 100644
> --- a/kernel/ptrace.c
> +++ b/kernel/ptrace.c
> @@ -222,7 +222,7 @@ static void ptrace_unfreeze_traced(struct task_struct *task)
>  	if (lock_task_sighand(task, &flags)) {
>  		task->jobctl &= ~JOBCTL_PTRACE_FROZEN;
>  		if (__fatal_signal_pending(task)) {
> -			task->jobctl &= ~TASK_TRACED;
> +			task->jobctl &= ~JOBCTL_TRACED;
>  			wake_up_state(task, __TASK_TRACED);
>  		}
>  		unlock_task_sighand(task, &flags);
> -- 
> 2.34.1
> 
