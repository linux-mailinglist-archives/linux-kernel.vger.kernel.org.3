Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBF434B911E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 20:24:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234325AbiBPTYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 14:24:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbiBPTYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 14:24:30 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B810928420B;
        Wed, 16 Feb 2022 11:24:17 -0800 (PST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21GIjlfw017660;
        Wed, 16 Feb 2022 19:24:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : references : date : in-reply-to : message-id : mime-version :
 content-type; s=pp1; bh=vHS/1qVhITpyhJrLw/1awm4as1JyoT0qoFCVx2CKCjw=;
 b=rsCTilMdXBPfDMePNDVOU1ObRGEkB/OIj0gj2mgJ/d+3InFvfdwDy3olE4l1dMjtQWJw
 5Y/HMe94yulS02o3gvyLBsTGq49VdtpJkRbAkNBSwiYx/7i8Zu6rPCHKxwKt9d2mvDQR
 9d1lVP8I7VN8rmc4aazHrOBTs0w569TBrSwFl0xZ+Qn7TSQl0lQCl0uecRK4/UZm1snn
 CY2nndy8ZhTxvKnX6EC37dEHTt1QgvH2MhZyY3d7NJgnXLzpnxT1wtCJF1RLc/NXL2Jp
 CkLRzvLwLqQB2W7SXyn1PVshwojOlkvT9ccOSPebEhltX5nq8WxyNEDaMZts3wnWCJOC FA== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e92178ydu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Feb 2022 19:24:00 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21GJ8j3O017229;
        Wed, 16 Feb 2022 19:23:58 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03ams.nl.ibm.com with ESMTP id 3e64habt4k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Feb 2022 19:23:58 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21GJNu2o39322092
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Feb 2022 19:23:56 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DC7BDA4040;
        Wed, 16 Feb 2022 19:23:55 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B6F9DA4057;
        Wed, 16 Feb 2022 19:23:55 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 16 Feb 2022 19:23:55 +0000 (GMT)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: ftrace startup tests crashing due to missing rcu_synchronize()
References: <yt9dilte4px4.fsf@linux.ibm.com>
        <20220216135419.01d96fe1@gandalf.local.home>
Date:   Wed, 16 Feb 2022 20:23:55 +0100
In-Reply-To: <20220216135419.01d96fe1@gandalf.local.home> (Steven Rostedt's
        message of "Wed, 16 Feb 2022 13:54:19 -0500")
Message-ID: <yt9dee424nuc.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: x85yT9iD3yuH0QjU7WIMjxYPSi6Lmkrt
X-Proofpoint-ORIG-GUID: x85yT9iD3yuH0QjU7WIMjxYPSi6Lmkrt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-16_09,2022-02-16_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=898 mlxscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 clxscore=1015 suspectscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202160107
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt <rostedt@goodmis.org> writes:

> On Wed, 16 Feb 2022 19:39:03 +0100
> Sven Schnelle <svens@linux.ibm.com> wrote:
>> [    4.460091] Unable to handle kernel pointer dereference in virtual kernel address space
>> [    4.460375] Failing address: 6b6b6b6b6b6b6000 TEID: 6b6b6b6b6b6b6803
>> [    4.460458] Fault in home space mode while using kernel ASCE.
>> [    4.460695] AS:000000008561c007 R3:0000000000000024
>> [    4.461143] Oops: 0038 ilc:3 [#1] PREEMPT SMP
>> [    4.461162] Modules linked in:
>> [    4.461175] CPU: 245 PID: 0 Comm: swapper/245 Not tainted 5.17.0-rc4-00051-gc5d9ae265b10-dirty #4
>> [    4.461183] Hardware name: IBM 8561 T01 701 (KVM/Linux)
>
> I this a 390?

Yes.

>> Looking at unregister_ftrace_function(), i noticed that
>> ftrace_shutdown() is called with 0 as command. Given that the ftrace
>> function didn't change and ftrace is still enabled, the
>> rcu_synchronize() functions in ftrace_shutdown() are silently skipped.
>> So the caller frees ops already before other CPUs have gone through
>> quiesce, and may therefore use the old (now freed) list entry.
>> 
>> To fix this, i wonder whether we should change the code in
>> unregister_ftrace_function() to:
>> 
>> @@ -7827,7 +7837,7 @@ int unregister_ftrace_function(struct ftrace_ops *ops)
>>         int ret;
>>  
>>         mutex_lock(&ftrace_lock);
>> -       ret = ftrace_shutdown(ops, 0);
>> +       ret = ftrace_shutdown(ops, FTRACE_UPDATE_TRACE_FUNC);
>
> No, the ftrace_shutdown() will add that flag if it is needed.
>
>>         mutex_unlock(&ftrace_lock);
>>  
>>         return ret;
>> 
>> I haven't checked whether other callsites of unregister_ftrace_function()
>> also need to be adjusted. What do you think about that 'fix'?
>
> But what I'm thinking is, the function is being freed but has yet to be
> removed from the list. Or that a synchronization is missed.
>
> That is, shutdown is called, the item is removed from the list and freed,
> but something got preempted while on the ftrace trampoline, with a
> reference to the item, and then woke up and executed the item that was
> freed.
>
> I'll look into it. Thanks for the report.

With additional debugging i see:

@@ -2967,14 +2974,17 @@ int ftrace_shutdown(struct ftrace_ops *ops, int command)
        }
 
        if (!command || !ftrace_enabled) {
+               pr_err("%s: skipping rcu_synchronize(): ops=%pS command=%d ftrace_enabled=%d saved func=%pS ftrace_trace_func=%pS\n",
+                      __func__, ops, command, ftrace_enabled, saved_ftrace_func, ftrace_trace_function);
                /*
                 * If these are dynamic or per_cpu ops, they still
                 * need their data freed. Since, function tracing is
                 * not currently active, we can just free them
                 * without synchronizing all CPUs.
                 */

[  +0.000011] unregister_ftrace_function: 0x2f6792e00
[  +0.000023] removing ops 00000002f6792e00 trace_selftest_test_dyn_func+0x0/0x18
[  +0.000661] ftrace_shutdown: skipping rcu_synchronize(): ops=0x2f6792e00 command=0 ftrace_enabled=1 saved func=arch_ftrace_ops_list_func+0x0/0x1b0 ft>
[  +0.010032] unregister_ftrace_function: test_probe1+0x0/0x1b0
[  +0.000017] removing ops 000000009d876e40 trace_selftest_test_probe1_func+0x0/0x18
[  +0.000053] ftrace_shutdown: skipping rcu_synchronize(): ops=test_probe1+0x0/0x1b0 command=0 ftrace_enabled=1 saved func=arch_ftrace_ops_list_func+0x>
[  +0.000017] unregister_ftrace_function: test_probe2+0x0/0x1b0
[  +0.000081] removing ops 000000009d876ff0 trace_selftest_test_probe2_func+0x0/0x18
[  +0.000064] ftrace_shutdown: skipping rcu_synchronize(): ops=test_probe2+0x0/0x1b0 command=0 ftrace_enabled=1 saved func=arch_ftrace_ops_list_func+0x>
[  +0.000015] unregister_ftrace_function: test_probe3+0x0/0x1b0
[  +0.000011] removing ops 000000009d8771a0 trace_selftest_test_probe3_func+0x0/0x18
[  +0.000108] unregister_ftrace_function: global_ops+0x0/0x1b0
[  +0.000010] removing ops 000000009d9325b8 trace_selftest_test_global_func+0x0/0x18
[  +0.025759] PASSED

So the rcu_synchronize is definitely skipped. Another thing i was
wondering was whether we need to reset the next pointer in
the to-be-removed entry in remove_ftrace_ops(). But i haven't
investigated that in detail yet.
