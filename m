Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CACF4DD67A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 09:50:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234005AbiCRIvm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 04:51:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233977AbiCRIv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 04:51:27 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90272FE421
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 01:50:08 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22I8HlZn002410;
        Fri, 18 Mar 2022 08:49:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : references : date : in-reply-to : message-id : mime-version :
 content-type; s=pp1; bh=Il9gmzw9bH6obP/2wre657BtEWjxr2kyJz94qtmf6R8=;
 b=K2Wf66H960FKYbPjpwGlTN4IInvDTXahqnI+FSVgwVHAYakqOQhip9n49sRknu76nV+/
 URdaQMuXIUxK89bOc21RuJBohraB3ihyZOM/5gH3wWuUtkS1xxpGIxFYyfSmZ1+5eh7c
 WW3ZA9xifOpVFlgjx/QaCalRteV/xP8jQ42jVkyI2MW2Y6wUZlxBr9MkUWBVyclV9xwP
 PVmUnLzkm2RsqgA64/Naf7qwTwCFfBtcAb/R/FsqVpb2PSet8pjo7Q+nwbD9+XwdHJlA
 VEAAyBmbym2R4eTLsnAdJI2ekThHUKCmnSrn50DmJVcDoZ/kSjzK29ojtsUe/h+MHdnu ow== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ev2sc6et6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Mar 2022 08:49:31 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 22I8dqHt009558;
        Fri, 18 Mar 2022 08:49:31 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ev2sc6ese-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Mar 2022 08:49:31 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 22I8n5xI002564;
        Fri, 18 Mar 2022 08:49:28 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04ams.nl.ibm.com with ESMTP id 3erk5954f0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Mar 2022 08:49:28 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 22I8bs0K39256376
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Mar 2022 08:37:54 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2F624AE053;
        Fri, 18 Mar 2022 08:49:26 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ABF92AE045;
        Fri, 18 Mar 2022 08:49:25 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri, 18 Mar 2022 08:49:25 +0000 (GMT)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, ardb@kernel.org,
        bp@alien8.de, catalin.marinas@arm.com, dave.hansen@linux.intel.com,
        frederic@kernel.org, james.morse@arm.com, joey.gouly@arm.com,
        juri.lelli@redhat.com, linux-kernel@vger.kernel.org,
        luto@kernel.org, mingo@redhat.com, peterz@infradead.org,
        tglx@linutronix.de, valentin.schneider@arm.com, will@kernel.org
Subject: Re: [PATCH v4 5/7] sched/preempt: add PREEMPT_DYNAMIC using static
 keys
References: <20220214165216.2231574-1-mark.rutland@arm.com>
        <20220214165216.2231574-6-mark.rutland@arm.com>
Date:   Fri, 18 Mar 2022 09:49:25 +0100
In-Reply-To: <20220214165216.2231574-6-mark.rutland@arm.com> (Mark Rutland's
        message of "Mon, 14 Feb 2022 16:52:14 +0000")
Message-ID: <yt9dk0crr6ga.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: jiJhMs-eXbuhAUengeTin0ECSYygSPKK
X-Proofpoint-GUID: TxrUbMHNuzvBWLuTYU_Ts8KMH7VBCtzb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-18_07,2022-03-15_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 mlxlogscore=970 lowpriorityscore=0
 suspectscore=0 bulkscore=0 phishscore=0 clxscore=1011 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203180045
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

Mark Rutland <mark.rutland@arm.com> writes:

> diff --git a/kernel/entry/common.c b/kernel/entry/common.c
> index 1739ca79613b..b145249ad91a 100644
> --- a/kernel/entry/common.c
> +++ b/kernel/entry/common.c
> @@ -3,6 +3,7 @@
>  #include <linux/context_tracking.h>
>  #include <linux/entry-common.h>
>  #include <linux/highmem.h>
> +#include <linux/jump_label.h>
>  #include <linux/livepatch.h>
>  #include <linux/audit.h>
>  #include <linux/tick.h>
> @@ -392,7 +393,17 @@ void raw_irqentry_exit_cond_resched(void)
>  	}
>  }
>  #ifdef CONFIG_PREEMPT_DYNAMIC
> +#if defined(CONFIG_HAVE_PREEMPT_DYNAMIC_CALL)
>  DEFINE_STATIC_CALL(irqentry_exit_cond_resched, raw_irqentry_exit_cond_resched);
> +#elif defined(CONFIG_HAVE_PREEMPT_DYNAMIC_KEY)
> +DEFINE_STATIC_KEY_TRUE(sk_dynamic_irqentry_exit_cond_resched);
> +void dynamic_irqentry_exit_cond_resched(void)
> +{
> +	if (!static_key_unlikely(&sk_dynamic_irqentry_exit_cond_resched))
> +		return;

I think that should be static_branch_unlikely()?

Also can we make dynamic_irqentry_exit_cond_resched static so that the
compiler will inline it? I played a bit with your changes on s390 and
noticed the the compiler will generate an empty function. Declaring it
static inlines it and saves one unnecessary function call.

Thanks!
Sven
