Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5965E4B9066
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 19:39:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237690AbiBPSjk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 13:39:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232333AbiBPSji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 13:39:38 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72D15202076;
        Wed, 16 Feb 2022 10:39:25 -0800 (PST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21GI7F6r023013;
        Wed, 16 Feb 2022 18:39:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=pp1;
 bh=RONEm4xYtZ0F9pW9Y60WhRrasfvxqyCStM04T9+rsj0=;
 b=HlV56aixEcCggoYbY8jkKHWVN1rMIU7O4g0tjsMLfrtNTkie6rRu+X44r/ed4SN7lNsg
 /UaziNSZsDIZVuchGG1DBP+672VOp0DC7UitThxY2ehskH6AzDiyjNjAQoC30kjzpDd8
 fuiES4VpAIl7tZPU6OTetRNtCblFBFMp1F5sO2oEmpOJhk//w7KlD7giJU/QuhW8zvMP
 l5Xg6rwpIHH8ilpt5CY/5LXZHi501IT8KzHd228Xdceh6nKK4lofF+Ec4Zr4Z/HtFH0D
 qLMEJmLyEnbu2gMEeZH4N6kfMrXWHt4/EtO2w+ngdrlbf840VDYr/wQZvuLogOjn8H4j Bg== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3e94n4b1x9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Feb 2022 18:39:08 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21GIWj9r008045;
        Wed, 16 Feb 2022 18:39:06 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma03ams.nl.ibm.com with ESMTP id 3e64habha9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Feb 2022 18:39:06 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21GId4Ec44827048
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Feb 2022 18:39:04 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1B12A4203F;
        Wed, 16 Feb 2022 18:39:04 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E906942042;
        Wed, 16 Feb 2022 18:39:03 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 16 Feb 2022 18:39:03 +0000 (GMT)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: ftrace startup tests crashing due to missing rcu_synchronize()
Date:   Wed, 16 Feb 2022 19:39:03 +0100
Message-ID: <yt9dilte4px4.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: hZ_CCxv9P8lepU3XyN5Ew57ehVw_NUbS
X-Proofpoint-GUID: hZ_CCxv9P8lepU3XyN5Ew57ehVw_NUbS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-16_08,2022-02-16_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=550 suspectscore=0 phishscore=0 clxscore=1015 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 spamscore=0
 adultscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202160104
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

in our CI we see the ftrace selftests crashing. It only happens
in rare cases - for me i can boot the kernel hundred of times and
it crashes only once. The oops output looks like this:

[    3.523720] Running postponed tracer tests:
[    3.524184] Testing tracer function: PASSED
[    3.801523] Testing dynamic ftrace: PASSED
[    4.068009] Testing dynamic ftrace ops #1:
[    4.140142] (1 0 1 0 0)
[    4.140149] (1 1 2 0 0)
[    4.200037] (2 1 3 0 822270)
[    4.200046] (2 2 4 0 822402)
[    4.232728] (3 2 4 0 1147236)
[    4.232740] (3 3 5 0 1147377)
[    4.300835] PASSED
[    4.300840] Testing dynamic ftrace ops #2:
[    4.420423] (1 0 1 582267 0)
[    4.420474] (1 1 2 583259 0)
[    4.420941] (2 1 3 1 5)
[    4.420947] (2 2 4 69 73)
[    4.458483] (3 2 4 494199 491341)
[    4.458616] (3 3 5 497496 494474)
[    4.460091] Unable to handle kernel pointer dereference in virtual kernel address space
[    4.460375] Failing address: 6b6b6b6b6b6b6000 TEID: 6b6b6b6b6b6b6803
[    4.460458] Fault in home space mode while using kernel ASCE.
[    4.460695] AS:000000008561c007 R3:0000000000000024
[    4.461143] Oops: 0038 ilc:3 [#1] PREEMPT SMP
[    4.461162] Modules linked in:
[    4.461175] CPU: 245 PID: 0 Comm: swapper/245 Not tainted 5.17.0-rc4-00051-gc5d9ae265b10-dirty #4
[    4.461183] Hardware name: IBM 8561 T01 701 (KVM/Linux)
[    4.461194] Krnl PSW : 0404e00180000000 00000000835a1fe6 (arch_ftrace_ops_list_func+0x96/0x1b0)
[    4.461212]            R:0 T:1 IO:0 EX:0 Key:0 M:1 W:0 P:0 AS:3 CC:2 PM:0 RI:0 EA:3
[    4.461226] Krnl GPRS: 0000000000000000 0000000084bbc110 0000000083496f48 00000000834061f2
[    4.461237]            000000008a70fa00 0000038000d0fba8 0000000000000001 fffffffffffffeff
[    4.461243]            00000000834061f2 0000038000d0fba8 6b6b6b6b6b6b6b6b 0000000083496f48
[    4.461250]            0000000000000000 0000000000000000 00000000835a209a 0000038000d0fab8
[    4.461269] Krnl Code: 00000000835a1fd4: e310a9380224        stg     %r1,10552(%r10)
                          00000000835a1fda: eb0103a8006a        asi     936,1
                         #00000000835a1fe0: c4a800b0d094        lgrl    %r10,0000000084bbc108
                         >00000000835a1fe6: e310a0100004        lg      %r1,16(%r10)
                          00000000835a1fec: a7110020            tmll    %r1,32
                          00000000835a1ff0: a7740012            brc     7,00000000835a2014
                          00000000835a1ff4: a7114000            tmll    %r1,16384
                          00000000835a1ff8: a7740031            brc     7,00000000835a205a
[    4.461383] Call Trace:
[    4.461388]  [<00000000835a1fe6>] arch_ftrace_ops_list_func+0x96/0x1b0
[    4.461395] ([<00000000835a200e>] arch_ftrace_ops_list_func+0xbe/0x1b0)
[    4.461401]  [<00000000841700ec>] ftrace_common+0x1c/0x20
[    4.461409]  [<0000000083496f4e>] preempt_count_sub+0x6/0x138
[    4.461418]  [<00000000834061f2>] read_tod_clock+0x4a/0xb0
[    4.461431]  [<0000000083530818>] ktime_get+0xb8/0x178
[    4.461441]  [<000000008353ec94>] clockevents_program_event+0x6c/0x138
[    4.461454]  [<000000008352d206>] hrtimer_start_range_ns+0xc6/0x100
[    4.461467]  [<0000000083541068>] tick_nohz_idle_stop_tick+0x90/0xf8
[    4.461479]  [<00000000834a9790>] do_idle+0xf0/0x1b0
[    4.461495]  [<00000000834a9ad6>] cpu_startup_entry+0x36/0x40
[    4.461509]  [<000000008416e48e>] restart_int_handler+0x6e/0x90
[    4.461521] INFO: lockdep is turned off.
[    4.461527] Last Breaking-Event-Address:
[    4.461533]  [<00000000835a2026>] arch_ftrace_ops_list_func+0xd6/0x1b0
[    4.461552] Kernel panic - not syncing: Fatal exception: panic_on_oops

The code in question is the ops loop in __ftrace_ops_list_func():

do_for_each_ftrace_op(op, ftrace_ops_list) {
/* Stub functions don't need to be called nor tested */
	if (op->flags & FTRACE_OPS_FL_STUB)
		continue;
...

The register (r10) where op is stored contains 0x6b6b6b6b6b6b6b6b
(POISON_FREE), so it looks like the list contains a member that is
already freed.

Looking at unregister_ftrace_function(), i noticed that
ftrace_shutdown() is called with 0 as command. Given that the ftrace
function didn't change and ftrace is still enabled, the
rcu_synchronize() functions in ftrace_shutdown() are silently skipped.
So the caller frees ops already before other CPUs have gone through
quiesce, and may therefore use the old (now freed) list entry.

To fix this, i wonder whether we should change the code in
unregister_ftrace_function() to:

@@ -7827,7 +7837,7 @@ int unregister_ftrace_function(struct ftrace_ops *ops)
        int ret;
 
        mutex_lock(&ftrace_lock);
-       ret = ftrace_shutdown(ops, 0);
+       ret = ftrace_shutdown(ops, FTRACE_UPDATE_TRACE_FUNC);
        mutex_unlock(&ftrace_lock);
 
        return ret;

I haven't checked whether other callsites of unregister_ftrace_function()
also need to be adjusted. What do you think about that 'fix'?

Thanks,
Sven



