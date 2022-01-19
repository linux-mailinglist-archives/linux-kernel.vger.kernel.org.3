Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50B73493F26
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 18:37:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348133AbiASRhV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 12:37:21 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:25630 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240001AbiASRhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 12:37:19 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20JGqVGT015428;
        Wed, 19 Jan 2022 17:35:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=/0Z8QYS0nLOz3a5RutI/Gbw9i54s709vbyKdY5R00f0=;
 b=OeWL1bURpwyaAqEu+oFBVP54KDqSCKtaWgBdiJUwQ8GpOFTdzNE9b2jnmh9cbVRxNQ10
 J7HC8SQLFioDYGI2tAQ8d6ACEKe43hp3uqaykP5aoLTnjEoFC3pt7S2+AkAIyy4dV9ZU
 XkcCAkyZWj2ENDSdy2R0XWbiSdxBoLgT59MWBnBCY5ZXf4neSV6BdUtSEdfsE5bLS2aF
 gwKD2TsKqrS0NUnmKAMQ3VlUDnhG8pbrgjqyLwRGcEDxXbf2r62/Qz4HACMJkLrrGPLb
 u3hC/tLFtqphxombl6T55NvlRiFkwyCCSPFOh1s8y9Er1Z6aTO2K/Cyv/ZPXGUXYxweF aw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dpmehven0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Jan 2022 17:35:51 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 20JHMp5N026971;
        Wed, 19 Jan 2022 17:35:51 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dpmehvekw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Jan 2022 17:35:50 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20JHXlvK006903;
        Wed, 19 Jan 2022 17:35:48 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma01fra.de.ibm.com with ESMTP id 3dknw9q6an-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Jan 2022 17:35:48 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20JHZi0b45285636
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jan 2022 17:35:44 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7B959A405F;
        Wed, 19 Jan 2022 17:35:44 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 13256A4067;
        Wed, 19 Jan 2022 17:35:43 +0000 (GMT)
Received: from [9.171.34.112] (unknown [9.171.34.112])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 19 Jan 2022 17:35:43 +0000 (GMT)
Message-ID: <e66d71dd-aeb9-3905-754a-8fb36385db12@linux.ibm.com>
Date:   Wed, 19 Jan 2022 18:35:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v2 1/7] entry: add arch_in_rcu_eqs()
Content-Language: en-US
To:     Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     aleksandar.qemu.devel@gmail.com, alexandru.elisei@arm.com,
        anup.patel@wdc.com, aou@eecs.berkeley.edu, atish.patra@wdc.com,
        bp@alien8.de, catalin.marinas@arm.com, chenhuacai@kernel.org,
        dave.hansen@linux.intel.com, frankja@linux.ibm.com,
        frederic@kernel.org, gor@linux.ibm.com, hca@linux.ibm.com,
        james.morse@arm.com, jmattson@google.com, joro@8bytes.org,
        maz@kernel.org, mingo@redhat.com, mpe@ellerman.id.au,
        nsaenzju@redhat.com, palmer@dabbelt.com, paulmck@kernel.org,
        paul.walmsley@sifive.com, pbonzini@redhat.com, seanjc@google.com,
        suzuki.poulose@arm.com, svens@linux.ibm.com,
        tsbogend@alpha.franken.de, vkuznets@redhat.com,
        wanpengli@tencent.com, will@kernel.org
References: <20220119105854.3160683-1-mark.rutland@arm.com>
 <20220119105854.3160683-2-mark.rutland@arm.com>
From:   Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20220119105854.3160683-2-mark.rutland@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: T7dDEW5eHjQD5yXB-fIIRUvZI1_j7pcT
X-Proofpoint-ORIG-GUID: _dlTkwOX-zj2vV5lG52KwsOpwxPoH58P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-19_10,2022-01-19_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 adultscore=0 suspectscore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 mlxscore=0 malwarescore=0 clxscore=1011 mlxlogscore=874
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201190099
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Am 19.01.22 um 11:58 schrieb Mark Rutland:
> All architectures have an interruptible RCU extended quiescent state
> (EQS) as part of their idle sequences, where interrupts can occur
> without RCU watching. Entry code must account for this and wake RCU as
> necessary; the common entry code deals with this in irqentry_enter() by
> treating any interrupt from an idle thread as potentially having
> occurred with an EQS and waking RCU for the duration of the interrupt
> via rcu_irq_enter() .. rcu_irq_exit().
> 
> Some architectures may have other interruptible EQSs which require
> similar treatment. For example, on s390 is it necessary to enable
> interrupts around guest entry in the middle of a period where core KVM
> code has entered an EQS.
> 
> So that architectueres can wake RCU in these cases, this patch adds a
                     ^
> new arch_in_rcu_eqs() hook to the common entry code which is checked in
> addition to the existing is_idle_thread() check, with RCU woken if
> either returns true. A default implementation is provided which always
> returns false, which suffices for most architectures.
> 
> As no architectures currently implement arch_in_rcu_eqs(), there should
> be no functional change as a result of this patch alone. A subsequent
> patch will add an s390 implementation to fix a latent bug with missing
> RCU wakeups.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
> Cc: Heiko Carstens <hca@linux.ibm.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Paul E. McKenney <paulmck@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Sven Schnelle <svens@linux.ibm.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>   include/linux/entry-common.h | 16 ++++++++++++++++
>   kernel/entry/common.c        |  3 ++-
>   2 files changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
> index 2e2b8d6140ed4..f1b91a13a15a6 100644
> --- a/include/linux/entry-common.h
> +++ b/include/linux/entry-common.h
> @@ -99,6 +99,22 @@ static inline __must_check int arch_syscall_enter_tracehook(struct pt_regs *regs
>   }
>   #endif
>   
> +/**
> + * arch_in_rcu_eqs - Architecture specific check for RCU extended quiescent
> + * states.
> + *
> + * Returns: true if the CPU is potentially in an RCU EQS, false otherwise.
> + *
> + * Architectures only need to define this if threads other than the idle thread
> + * may have an interruptible EQS. This does not need to handle idle threads. It
> + * is safe to over-estimate at the cost of redundant RCU management work.
> + *
> + * Invoked from irqentry_enter()
> + */
> +#ifndef arch_in_rcu_eqs
> +static __always_inline bool arch_in_rcu_eqs(void) { return false; }
> +#endif
> +
>   /**
>    * enter_from_user_mode - Establish state when coming from user mode
>    *
> diff --git a/kernel/entry/common.c b/kernel/entry/common.c
> index d5a61d565ad5d..b13d4e0b0b643 100644
> --- a/kernel/entry/common.c
> +++ b/kernel/entry/common.c
> @@ -349,7 +349,8 @@ noinstr irqentry_state_t irqentry_enter(struct pt_regs *regs)
>   	 * TINY_RCU does not support EQS, so let the compiler eliminate
>   	 * this part when enabled.
>   	 */
> -	if (!IS_ENABLED(CONFIG_TINY_RCU) && is_idle_task(current)) {
> +	if (!IS_ENABLED(CONFIG_TINY_RCU) &&
> +	    (is_idle_task(current) || arch_in_rcu_eqs())) {
>   		/*
>   		 * If RCU is not watching then the same careful
>   		 * sequence vs. lockdep and tracing is required
