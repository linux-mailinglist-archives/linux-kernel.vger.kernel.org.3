Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0472452B239
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 08:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbiERGUg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 02:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230489AbiERGUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 02:20:33 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E28A1CC165
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 23:20:31 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24I6COn2001505;
        Wed, 18 May 2022 06:19:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : references : date : in-reply-to : message-id : mime-version :
 content-type; s=pp1; bh=T0130R71zRfx65/kfmvaSnqRVVFeMrtSP4kwHBs2zKM=;
 b=pbNX6IhAX+AFRbGcfytsRJBwxz6u92FZvLCZxvHvrHDoHsGD9ZCAigmPgP+usN9EUjGk
 HGqReFxTLlE9gH23K6eWJlIwCdKiFR1cz2nrjE1n/OeYYTL9YhSRK8LpozLx0o/Tb6SY
 gLqwGnSpfjZD8iSPA3mUg9dHCNQ9QsNUGGvZaBn5Nwf7XuaRKCMmicHI6tGDkdXKi4oV
 gsAyu9caxOPjG4Rnr9XaV7c0gzE5t8pDjyh6dS0trQC59/zuJ61VDNHZsaixHBMn9wzb
 yFn2Q7ixv6aFUUsv8PMH4EhXSGwizY+cV9YdFRLcqpcs8yhA7n2jvlA3+nYQIkj/zSUn hw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g4uaw84nw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 May 2022 06:19:49 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 24I6G0Kw015225;
        Wed, 18 May 2022 06:19:49 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g4uaw84n4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 May 2022 06:19:48 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24I6BfkB011102;
        Wed, 18 May 2022 06:19:46 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma04ams.nl.ibm.com with ESMTP id 3g2429d7qx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 May 2022 06:19:46 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24I6Jido40108522
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 May 2022 06:19:44 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0A78BA4053;
        Wed, 18 May 2022 06:19:44 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 97DCCA404D;
        Wed, 18 May 2022 06:19:43 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 18 May 2022 06:19:43 +0000 (GMT)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Donghai Qiao <dqiao@redhat.com>
Cc:     akpm@linux-foundation.org, sfr@canb.auug.org.au, arnd@arndb.de,
        peterz@infradead.org, heying24@huawei.com,
        andriy.shevchenko@linux.intel.com, axboe@kernel.dk,
        rdunlap@infradead.org, tglx@linutronix.de, gor@linux.ibm.com,
        donghai.w.qiao@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 00/11] smp: cross CPU call interface
References: <20220517180326.997129-1-dqiao@redhat.com>
Date:   Wed, 18 May 2022 08:19:43 +0200
In-Reply-To: <20220517180326.997129-1-dqiao@redhat.com> (Donghai Qiao's
        message of "Tue, 17 May 2022 14:03:15 -0400")
Message-ID: <yt9dy1yz1hxc.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: JBkC3NK3tT-MAcZ5nj-ZtuSNtPsn5xDg
X-Proofpoint-ORIG-GUID: j9D-i_FSUSmmXB-jtdXtAWEwsv_iL2hC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-18_02,2022-05-17_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 phishscore=0 lowpriorityscore=0 mlxlogscore=792 spamscore=0
 impostorscore=0 suspectscore=0 priorityscore=1501 clxscore=1011
 adultscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2202240000 definitions=main-2205180033
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Donghai Qiao <dqiao@redhat.com> writes:

> The motivation of this patch set is intended to make the existing
> cross CPU call mechanism become a formal interface, more friendly
> to the kernel developers.
>
> For the simplicity self-explanatory less code redundancy and no
> ambiguity, the set of functions below can satisfy any existing
> demand for cross call, at the meantime they still carry over the
> same semantics and the similar parameter lists.
> [..]

With this patchset applied i see the following splat on s390 when the
ftrace selftests are run:

[    1.007231] Running postponed tracer tests:
[    1.007398] Testing tracer function:
[    1.036267] Callback from call_rcu_tasks() invoked.
[    1.117709] BUG: using smp_processor_id() in preemptible [00000000] code: swapper/0/1
[    1.117737] caller is __smp_call_mask_cond+0x42/0x5f8
[    1.117751] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.18.0-rc7-00017-g9cc3e6b66c62 #789
[    1.117760] Hardware name: IBM 3906 M04 704 (z/VM 7.1.0)
[    1.117769] Call Trace:
[    1.117777]  [<000000000f571e54>] dump_stack_lvl+0xac/0x100
[    1.117788]  [<000000000f576eec>] check_preemption_disabled+0xf4/0xf8
[    1.117798]  [<000000000e94eb72>] __smp_call_mask_cond+0x42/0x5f8
[    1.117808]  [<000000000e94f35c>] smp_call_mask_others+0x54/0x70
[    1.117818]  [<000000000e9a8d5e>] ftrace_modify_all_code+0x146/0x170
[    1.117831]  [<000000000e9a8e70>] ftrace_run_update_code+0x30/0x88
[    1.117842]  [<000000000e9ad3a2>] ftrace_startup+0xea/0x1a0
[    1.117852]  [<000000000e9ad498>] register_ftrace_function+0x40/0x88
[    1.117863]  [<000000000e9ccaa8>] function_trace_init+0x90/0x108
[    1.117897]  [<00000000102957aa>] trace_selftest_startup_function+0x6a/0x338
[    1.117910]  [<000000000f56149a>] run_tracer_selftest+0x11a/0x1b0
[    1.117934]  [<0000000010294fe8>] init_trace_selftests+0x90/0x140
[    1.117965]  [<000000000e808aa8>] do_one_initcall+0x78/0x390
[    1.117996]  [<0000000010280804>] do_initcalls+0x12c/0x150
[    1.118009]  [<0000000010280af8>] kernel_init_freeable+0x250/0x290
[    1.118018]  [<000000000f5770de>] kernel_init+0x2e/0x170
[    1.118028]  [<000000000e80b924>] __ret_from_fork+0x3c/0x58
[    1.118038]  [<000000000f5881ea>] ret_from_fork+0xa/0x40
[    1.118049] 2 locks held by swapper/0/1:
[    1.118058]  #0: 000000001012bae0 (trace_types_lock){+.+.}-{3:3}, at: init_trace_selftests+0x30/0x140
[    1.118085]  #1: 000000001012b698 (ftrace_lock){+.+.}-{3:3}, at: register_ftrace_function+0x32/0x88
