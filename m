Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75D93596D57
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 13:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232071AbiHQLJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 07:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235425AbiHQLJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 07:09:16 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE02069F7D;
        Wed, 17 Aug 2022 04:09:14 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27H9L3Bj006968;
        Wed, 17 Aug 2022 11:09:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=3yYpwV5QQwXTA8rwPvOCKfi5C05jf7p0DRVAtfMS7AA=;
 b=cgB9QGelpqwQq4HQL7orKY4avfg01tyn25btY0hMZz45FJSGIB/7MyhWGXjS8FtLO6H2
 XDMxdb9wawD1VmEg0wy33oDcQJuEKCMooscnB7eQN4E5n71IQeAxX5qGC+8K3d2TtC9F
 /b4Bi83ICcfMWcGgNrcPa+LlIHZuZ7r2kuDnVFmQQyOrAimFZFgyA7wzYAO+WfUyJ/Mf
 XP1A0sNfOaNgFjm+E9t2vkk0OMrzLXGBBqU7lPuDyJCwBFWPv4oVndE7M5uYoczmSIYd
 uJkgd1R9PF3unAU+0ykPeFR54m46vhCcXCIjL++aetLvxc/LDiA0G9bOjeBHKQwxpo4a EA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3j0wmf331h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 Aug 2022 11:09:13 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 27HAgfB3008334;
        Wed, 17 Aug 2022 11:09:13 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3j0wmf330x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 Aug 2022 11:09:13 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 27HB5lAM018685;
        Wed, 17 Aug 2022 11:09:11 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma02fra.de.ibm.com with ESMTP id 3j0dc38qrf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 Aug 2022 11:09:11 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 27HB98cu33030614
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Aug 2022 11:09:08 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3C6454C066;
        Wed, 17 Aug 2022 11:09:08 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E6E444C05C;
        Wed, 17 Aug 2022 11:09:07 +0000 (GMT)
Received: from thinkpad (unknown [9.171.85.5])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Wed, 17 Aug 2022 11:09:07 +0000 (GMT)
Date:   Wed, 17 Aug 2022 13:09:06 +0200
From:   Gerald Schaefer <gerald.schaefer@linux.ibm.com>
To:     Brian Foster <bfoster@redhat.com>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>
Subject: Re: [PATCH] s390: fix double free of GS and RI CBs on fork()
 failure
Message-ID: <20220817130906.0ce40da1@thinkpad>
In-Reply-To: <20220816155407.537372-1-bfoster@redhat.com>
References: <20220816155407.537372-1-bfoster@redhat.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: mObNgtu4vMQNaE4QlJmA8XgKfC52B7j6
X-Proofpoint-ORIG-GUID: dFQz10_2gJqfFq0ZVe0UJRCcNFYN1Rc5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-17_05,2022-08-16_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 clxscore=1015 malwarescore=0 bulkscore=0 impostorscore=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 mlxlogscore=999 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208170042
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Aug 2022 11:54:07 -0400
Brian Foster <bfoster@redhat.com> wrote:

> The pointers for guarded storage and runtime instrumentation control
> blocks are stored in the thread_struct of the associated task. These
> pointers are initially copied on fork() via arch_dup_task_struct()
> and then cleared via copy_thread() before fork() returns. If fork()
> happens to fail after the initial task dup and before copy_thread(),
> the newly allocated task and associated thread_struct memory are
> freed via free_task() -> arch_release_task_struct(). This results in
> a double free of the guarded storage and runtime info structs
> because the fields in the failed task still refer to memory
> associated with the source task.
> 
> This problem can manifest as a BUG_ON() in set_freepointer() (with
> CONFIG_SLAB_FREELIST_HARDENED enabled) or KASAN splat (if enabled)
> when running trinity syscall fuzz tests on s390x. To avoid this
> problem, clear the associated pointer fields in
> arch_dup_task_struct() immediately after the new task is copied.
> Note that the RI flag is still cleared in copy_thread() because it
> resides in thread stack memory and that is where stack info is
> copied.
> 
> Signed-off-by: Brian Foster <bfoster@redhat.com>
> ---
> 
> Hi all,
> 
> Note that I'm not subscribed to the list so please CC on reply. Further,
> I'm not terribly familiar with these associated features and so have not
> run any kind of functional testing here. My testing was purely around
> producing/preventing the double free issue. Any thoughts, reviews or
> further testing is appreciated. Thanks.
> 
> Brian
> 
>  arch/s390/kernel/process.c | 22 ++++++++++++++++------
>  1 file changed, 16 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/s390/kernel/process.c b/arch/s390/kernel/process.c
> index 89949b9f3cf8..d5119e039d85 100644
> --- a/arch/s390/kernel/process.c
> +++ b/arch/s390/kernel/process.c
> @@ -91,6 +91,18 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
>  
>  	memcpy(dst, src, arch_task_struct_size);
>  	dst->thread.fpu.regs = dst->thread.fpu.fprs;
> +
> +	/*
> +	 * Don't transfer over the runtime instrumentation or the guarded
> +	 * storage control block pointers. These fields are cleared here instead
> +	 * of in copy_thread() to avoid premature freeing of associated memory
> +	 * on fork() failure. Wait to clear the RI flag because ->stack still
> +	 * refers to the source thread.
> +	 */
> +	dst->thread.ri_cb = NULL;
> +	dst->thread.gs_cb = NULL;
> +	dst->thread.gs_bc_cb = NULL;
> +
>  	return 0;
>  }
>  
> @@ -150,13 +162,11 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
>  	frame->childregs.flags = 0;
>  	if (new_stackp)
>  		frame->childregs.gprs[15] = new_stackp;
> -
> -	/* Don't copy runtime instrumentation info */
> -	p->thread.ri_cb = NULL;
> +	/*
> +	 * Clear the runtime instrumentation flag after the above childregs
> +	 * copy. The CB pointer was already cleared in arch_dup_task_struct().
> +	 */
>  	frame->childregs.psw.mask &= ~PSW_MASK_RI;
> -	/* Don't copy guarded storage control block */
> -	p->thread.gs_cb = NULL;
> -	p->thread.gs_bc_cb = NULL;
>  
>  	/* Set a new TLS ?  */
>  	if (clone_flags & CLONE_SETTLS) {

Thanks Brian, nice catch! Looks good to me. For completeness, we should
add stable / Fixes tags, like this:

Fixes: 8d9047f8b967c ("s390/runtime instrumentation: simplify task exit handling")
Fixes: 7b83c6297d2fc ("s390/guarded storage: simplify task exit handling")
Cc: <stable@vger.kernel.org> # 4.15

Not 100% sure about the Fixes tags, Heiko should also have a look when
he returns next week.

Reviewed-by: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
