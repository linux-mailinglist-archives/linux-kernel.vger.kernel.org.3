Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29BE44940EA
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 20:32:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356997AbiASTcU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 14:32:20 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:19694 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240773AbiASTbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 14:31:51 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20JIBAY6023671;
        Wed, 19 Jan 2022 19:30:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=SynBerJ08fr0YzTpzbKwnyGvKyPIFfGPEvW1KaBI6JY=;
 b=nnE+lMh9Lwl92On/tqYWjG3swdmo/CtZmef3LvEoBI5dOKREd5kAFWia5BZmZ9EpeBAq
 MnM2uoU3NW6FXWM4Et+9PG/1HXnlbsSHajkUzWggJx9vb4i3++ymRv/H7SAtDuAuIdwU
 qMo/A2KSFKclST4g5SfqMjWfT6B4Zsn6mUHjEaL9lL70Ogy6LdlJa1XgAYQ/bn3Nu1sq
 OEi5KWjB889RyKdHedxRJIs6riP0illC/x9770LDtbwtQeZOjr3VxzVztoTz/heNQvxB
 ecEjTxpD+OMrWrkGC4Nlx7bmpQ0Aw/33QNfu5uB16ni1TKVsMO6xOL643NOxOv7aRblf Ug== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dpmvhe628-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Jan 2022 19:30:28 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 20JJMqpA025575;
        Wed, 19 Jan 2022 19:30:27 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dpmvhe61g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Jan 2022 19:30:27 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20JJHmN2024534;
        Wed, 19 Jan 2022 19:30:25 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma01fra.de.ibm.com with ESMTP id 3dknw9r5qw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Jan 2022 19:30:24 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20JJUJFS33096140
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jan 2022 19:30:19 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 12EA9A406B;
        Wed, 19 Jan 2022 19:30:19 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 858B1A4069;
        Wed, 19 Jan 2022 19:30:17 +0000 (GMT)
Received: from [9.171.34.112] (unknown [9.171.34.112])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 19 Jan 2022 19:30:17 +0000 (GMT)
Message-ID: <0654e667-1cfa-5147-6661-b3b63288be0b@linux.ibm.com>
Date:   Wed, 19 Jan 2022 20:30:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v2 0/7] kvm: fix latent guest entry/exit bugs
Content-Language: en-US
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        aleksandar.qemu.devel@gmail.com, alexandru.elisei@arm.com,
        anup.patel@wdc.com, aou@eecs.berkeley.edu, atish.patra@wdc.com,
        bp@alien8.de, catalin.marinas@arm.com, chenhuacai@kernel.org,
        dave.hansen@linux.intel.com, frankja@linux.ibm.com,
        frederic@kernel.org, gor@linux.ibm.com, hca@linux.ibm.com,
        james.morse@arm.com, jmattson@google.com, joro@8bytes.org,
        luto@kernel.org, maz@kernel.org, mingo@redhat.com,
        nsaenzju@redhat.com, palmer@dabbelt.com, paulmck@kernel.org,
        paul.walmsley@sifive.com, peterz@infradead.org, seanjc@google.com,
        suzuki.poulose@arm.com, svens@linux.ibm.com, tglx@linutronix.de,
        tsbogend@alpha.franken.de, vkuznets@redhat.com,
        wanpengli@tencent.com, will@kernel.org,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>
References: <20220119105854.3160683-1-mark.rutland@arm.com>
 <a4a26805-3a56-d264-0a7e-60bed1ada9f3@linux.ibm.com>
 <20220119192217.GD43919@C02TD0UTHF1T.local>
From:   Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20220119192217.GD43919@C02TD0UTHF1T.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: TxG2R9SKpLu7zWMl9Jjsh_fKGIckVLLs
X-Proofpoint-ORIG-GUID: HdZvfcd0vG_Z-DFjPwRrGrkaDh10Za-t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-19_10,2022-01-19_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=862 clxscore=1015
 adultscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 mlxscore=0 spamscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201190104
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Am 19.01.22 um 20:22 schrieb Mark Rutland:
> On Wed, Jan 19, 2022 at 07:25:20PM +0100, Christian Borntraeger wrote:
>> Am 19.01.22 um 11:58 schrieb Mark Rutland:
>>
>>
>> CCing new emails for Anup and Atish so that they are aware of this thread.
> 
> Ah; whoops. I'd meant to fix the Ccs on the patches.
> 
> Thanks!
> 
> [...]
> 
>> I just gave this a spin on s390 with debugging on and I got the following:
>>
>> [  457.151295] ------------[ cut here ]------------
>> [  457.151311] WARNING: CPU: 14 PID: 0 at kernel/rcu/tree.c:613 rcu_eqs_enter.constprop.0+0xf8/0x118
> 
> Hmm, so IIUC that's:
> 
> 	WARN_ON_ONCE(rdp->dynticks_nmi_nesting != DYNTICK_IRQ_NONIDLE);
> 
> ... and we're clearly in the idle thread here.
> 
> I wonder, is the s390 guest entry/exit *preemptible* ?

Looks like debug_defconfig is indeed using preemption:

CONFIG_PREEMPT_BUILD=y
# CONFIG_PREEMPT_NONE is not set
# CONFIG_PREEMPT_VOLUNTARY is not set
CONFIG_PREEMPT=y
CONFIG_PREEMPT_COUNT=y
CONFIG_PREEMPTION=y
CONFIG_PREEMPT_RCU=y
CONFIG_PREEMPT_NOTIFIERS=y
CONFIG_DEBUG_PREEMPT=y
CONFIG_PREEMPTIRQ_TRACEPOINTS=y
CONFIG_TRACE_PREEMPT_TOGGLE=y
CONFIG_PREEMPT_TRACER=y
# CONFIG_PREEMPTIRQ_DELAY_TEST is not set

> 
> If a timer IRQ can preempt in the middle of the EQS, we wouldn't balance
> things before a ctx-switch to the idle thread, which would then be able
> to hit this.
> 
> I'll need to go audit the other architectures for similar.
> 
> Thanks,
> Mark.
> 
>> [  457.151324] Modules linked in: vhost_vsock vmw_vsock_virtio_transport_common vsock vhost vhost_iotlb xt_CHECKSUM xt_MASQUERADE xt_conntrack ipt_REJECT xt_tcpudp nft_compat nf_nat_tftp nft_objref nf_conntrack_tftp nft_counter kvm nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip_set nf_tables nfnetlink sunrpc mlx5_ib ib_uverbs s390_trng ib_core genwqe_card crc_itu_t vfio_ccw mdev vfio_iommu_type1 eadm_sch vfio zcrypt_cex4 sch_fq_codel configfs ip_tables x_tables mlx5_core ghash_s390 prng aes_s390 des_s390 libdes sha3_512_s390 sha3_256_s390 sha512_s390 sha256_s390 sha1_s390 sha_common pkey zcrypt rng_core autofs4
>> [  457.151422] CPU: 14 PID: 0 Comm: swapper/14 Not tainted 5.16.0-00007-g89e9021389e2 #3
>> [  457.151428] Hardware name: IBM 3906 M04 704 (LPAR)
>> [  457.151432] Krnl PSW : 0404d00180000000 00000000a7c0495c (rcu_eqs_enter.constprop.0+0xfc/0x118)
>> [  457.151440]            R:0 T:1 IO:0 EX:0 Key:0 M:1 W:0 P:0 AS:3 CC:1 PM:0 RI:0 EA:3
>> [  457.151445] Krnl GPRS: ffffffffebd81d31 4000000000000000 0000000000000070 00000000a7fd7024
>> [  457.151450]            0000000000000000 0000000000000001 0000000000000000 0000000000000000
>> [  457.151454]            000000000000000e 000000000000000e 00000000a84d3a88 0000001fd8645c00
>> [  457.151458]            0000000000000000 0000000000000000 00000000a7c04882 0000038000653dc0
>> [  457.151468] Krnl Code: 00000000a7c0494c: ebaff0a00004	lmg	%r10,%r15,160(%r15)
>>                            00000000a7c04952: c0f4fffffef7	brcl	15,00000000a7c04740
>>                           #00000000a7c04958: af000000		mc	0,0
>>                           >00000000a7c0495c: a7f4ffa3		brc	15,00000000a7c048a2
>>                            00000000a7c04960: c0e500003f70	brasl	%r14,00000000a7c0c840
>>                            00000000a7c04966: a7f4ffcd		brc	15,00000000a7c04900
>>                            00000000a7c0496a: c0e500003f6b	brasl	%r14,00000000a7c0c840
>>                            00000000a7c04970: a7f4ffde		brc	15,00000000a7c0492c
>> [  457.151527] Call Trace:
>> [  457.151530]  [<00000000a7c0495c>] rcu_eqs_enter.constprop.0+0xfc/0x118
>> [  457.151536] ([<00000000a7c04882>] rcu_eqs_enter.constprop.0+0x22/0x118)
>> [  457.151540]  [<00000000a7c14cd2>] default_idle_call+0x62/0xd8
>> [  457.151545]  [<00000000a6f816c6>] do_idle+0xf6/0x1b0
>> [  457.151553]  [<00000000a6f81a06>] cpu_startup_entry+0x36/0x40
>> [  457.151558]  [<00000000a7c16abe>] restart_int_handler+0x6e/0x90
>> [  457.151563] no locks held by swapper/14/0.
>> [  457.151567] Last Breaking-Event-Address:
>> [  457.151570]  [<00000000a7c0489e>] rcu_eqs_enter.constprop.0+0x3e/0x118
>> [  457.151574] irq event stamp: 608654
>> [  457.151578] hardirqs last  enabled at (608653): [<00000000a70190d8>] tick_nohz_idle_enter+0xb0/0x130
>> [  457.151584] hardirqs last disabled at (608654): [<00000000a6f8173e>] do_idle+0x16e/0x1b0
>> [  457.151589] softirqs last  enabled at (608586): [<00000000a7c1861a>] __do_softirq+0x4ba/0x668
>> [  457.151594] softirqs last disabled at (608581): [<00000000a6f367c6>] __irq_exit_rcu+0x13e/0x170
>> [  457.151600] ---[ end trace 2ae2154f9724de86 ]---
>>
>> I can not see right now whats wrong, your patches look sane.
