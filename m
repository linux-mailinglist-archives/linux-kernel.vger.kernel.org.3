Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 185F8493FDD
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 19:27:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356746AbiASS1H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 13:27:07 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:19438 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348214AbiASS1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 13:27:00 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20JIBX1I002452;
        Wed, 19 Jan 2022 18:25:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=ku5eYJkRRvfueSPTOnW7R+ianVZo6fvlHrek6jhf+XY=;
 b=sF2frLsX9qw/S2nVdvE6+U46vdpX434+PonN3f84f/9DfIR0RK7M1XwvJ/zFFhrW/is5
 PbDnMaYaYCp7Ns0k0uv9vuFe5t0T+8XB4IxK3JkNagH+obN2XBrieNruvAQ0N/iPCZGF
 o+9DrjkKMWOigUgKZA4LoJyuRFo+faJDFTu/Wd2/01R2GBIMVkO+mi5qPXJq1NvhWfzn
 TPVOFtiUoXxp5p7UPYU+tUb9lb0TAgIHAF22qTEoFOZT6ALUmTYW82UP7nQpUZpQfiBm
 doYkhBK2Zi9jf/FAjEegxmsNHMVUxnRbLyXx6sxAouSvVhAc4nZ0uyB04bnxsSqAEo6P sQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dpmva4vbq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Jan 2022 18:25:31 +0000
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 20JIGDC5019359;
        Wed, 19 Jan 2022 18:25:31 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dpmva4vam-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Jan 2022 18:25:30 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20JIHfGX010896;
        Wed, 19 Jan 2022 18:25:28 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06fra.de.ibm.com with ESMTP id 3dknhjfnc0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Jan 2022 18:25:28 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20JIPMOt32440578
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jan 2022 18:25:22 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A29E0A405B;
        Wed, 19 Jan 2022 18:25:22 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 25E95A4067;
        Wed, 19 Jan 2022 18:25:21 +0000 (GMT)
Received: from [9.171.34.112] (unknown [9.171.34.112])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 19 Jan 2022 18:25:21 +0000 (GMT)
Message-ID: <a4a26805-3a56-d264-0a7e-60bed1ada9f3@linux.ibm.com>
Date:   Wed, 19 Jan 2022 19:25:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v2 0/7] kvm: fix latent guest entry/exit bugs
Content-Language: en-US
To:     Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     aleksandar.qemu.devel@gmail.com, alexandru.elisei@arm.com,
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
From:   Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20220119105854.3160683-1-mark.rutland@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 8cyLvImprCnKTfTBQJM24Mh7mmd9b8TG
X-Proofpoint-ORIG-GUID: ut1XHMXJWeosxeFmFYV_UtRnCTJjVtbk
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-19_10,2022-01-19_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 mlxlogscore=999 mlxscore=0 phishscore=0 clxscore=1011
 suspectscore=0 impostorscore=0 spamscore=0 bulkscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201190102
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 19.01.22 um 11:58 schrieb Mark Rutland:


CCing new emails for Anup and Atish so that they are aware of this thread.

> Several architectures have latent bugs around guest entry/exit. This
> series addresses those for:
> 
> 	arm64, mips, riscv, s390, x86
> 
> However, I'm not sure how to address powerpc and could do with some help
> there. I have build-tested the arm64, mips, riscv, s390, and x86 cases,
> but I don't have a suitable HW setup to test these, so any review and/or
> testing would be much appreciated.
> 
> Issues include:
> 
> 1) Several architectures enable interrupts between guest_enter() and
>     guest_exit(). As this period is an RCU extended quiescent state (EQS)
>     this is unsound unless the irq entry code explicitly wakes RCU, which
>     most architectures only do for entry from usersapce or idle.
> 
>     I believe this affects: arm64, riscv, s390
> 
>     I am not sure about powerpc.
> 
> 2) Several architectures permit instrumentation of code between
>     guest_enter() and guest_exit(), e.g. KASAN, KCOV, KCSAN, etc. As
>     instrumentation may directly o indirectly use RCU, this has the same
>     problems as with interrupts.
> 
>     I believe this affects: arm64, mips, powerpc, riscv, s390
> 
> 3) Several architectures do not inform lockdep and tracing that
>     interrupts are enabled during the execution of the guest, or do so in
>     an incorrect order. Generally this means that logs will report IRQs
>     being masked for much longer than is actually the case, which is not
>     ideal for debugging. I don't know whether this affects the
>     correctness of lockdep.
> 
>     I believe this affects: arm64, mips, powerpc, riscv, s390
> 
> This was previously fixed for x86 specifically in a series of commits:
> 
>    87fa7f3e98a1310e ("x86/kvm: Move context tracking where it belongs")
>    0642391e2139a2c1 ("x86/kvm/vmx: Add hardirq tracing to guest enter/exit")
>    9fc975e9efd03e57 ("x86/kvm/svm: Add hardirq tracing on guest enter/exit")
>    3ebccdf373c21d86 ("x86/kvm/vmx: Move guest enter/exit into .noinstr.text")
>    135961e0a7d555fc ("x86/kvm/svm: Move guest enter/exit into .noinstr.text")
>    160457140187c5fb ("KVM: x86: Defer vtime accounting 'til after IRQ handling")
>    bc908e091b326467 ("KVM: x86: Consolidate guest enter/exit logic to common helpers")
> 
> But other architectures were left broken, and the infrastructure for
> handling this correctly is x86-specific.
> 
> This series introduces generic helper functions which can be used to
> handle the problems above, and migrates architectures over to these,
> fixing the latent issues. For s390, where the KVM guest EQS is
> interruptible, I've added infrastructure to wake RCU during this EQS.
> 
> Since v1 [1]:
> * Add arch_in_rcu_eqs()
> * Convert s390
> * Rename exit_to_guest_mode() -> guest_state_enter_irqoff()
> * Rename enter_from_guest_mode() -> guest_state_exit_irqoff()
> * Various commit message cleanups
> 
> I've pushed the series (based on v5.16) to my kvm/entry-rework branch:
> 
>    https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/log/?h=kvm/entry-rework
>    git://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git kvm/entry-rework
> 
> ... with this version tagged as kvm-entry-rework-20210119.
> 
> [1] https://lore.kernel.org/r/20220111153539.2532246-1-mark.rutland@arm.com/
> 
> Thanks,
> Mark.
> 
> Mark Rutland (7):
>    entry: add arch_in_rcu_eqs()
>    kvm: add guest_state_{enter,exit}_irqoff()
>    kvm/arm64: rework guest entry logic
>    kvm/mips: rework guest entry logic
>    kvm/riscv: rework guest entry logic
>    kvm/s390: rework guest entry logic
>    kvm/x86: rework guest entry logic
> 
>   arch/arm64/kvm/arm.c                 |  51 +++++++-----
>   arch/mips/kvm/mips.c                 |  37 ++++++++-
>   arch/riscv/kvm/vcpu.c                |  44 +++++++----
>   arch/s390/include/asm/entry-common.h |  10 +++
>   arch/s390/include/asm/kvm_host.h     |   3 +
>   arch/s390/kvm/kvm-s390.c             |  49 +++++++++---
>   arch/s390/kvm/vsie.c                 |  17 ++--
>   arch/x86/kvm/svm/svm.c               |   4 +-
>   arch/x86/kvm/vmx/vmx.c               |   4 +-
>   arch/x86/kvm/x86.c                   |   4 +-
>   arch/x86/kvm/x86.h                   |  45 -----------
>   include/linux/entry-common.h         |  16 ++++
>   include/linux/kvm_host.h             | 112 ++++++++++++++++++++++++++-
>   kernel/entry/common.c                |   3 +-
>   14 files changed, 286 insertions(+), 113 deletions(-)
> 


I just gave this a spin on s390 with debugging on and I got the following:

[  457.151295] ------------[ cut here ]------------
[  457.151311] WARNING: CPU: 14 PID: 0 at kernel/rcu/tree.c:613 rcu_eqs_enter.constprop.0+0xf8/0x118
[  457.151324] Modules linked in: vhost_vsock vmw_vsock_virtio_transport_common vsock vhost vhost_iotlb xt_CHECKSUM xt_MASQUERADE xt_conntrack ipt_REJECT xt_tcpudp nft_compat nf_nat_tftp nft_objref nf_conntrack_tftp nft_counter kvm nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip_set nf_tables nfnetlink sunrpc mlx5_ib ib_uverbs s390_trng ib_core genwqe_card crc_itu_t vfio_ccw mdev vfio_iommu_type1 eadm_sch vfio zcrypt_cex4 sch_fq_codel configfs ip_tables x_tables mlx5_core ghash_s390 prng aes_s390 des_s390 libdes sha3_512_s390 sha3_256_s390 sha512_s390 sha256_s390 sha1_s390 sha_common pkey zcrypt rng_core autofs4
[  457.151422] CPU: 14 PID: 0 Comm: swapper/14 Not tainted 5.16.0-00007-g89e9021389e2 #3
[  457.151428] Hardware name: IBM 3906 M04 704 (LPAR)
[  457.151432] Krnl PSW : 0404d00180000000 00000000a7c0495c (rcu_eqs_enter.constprop.0+0xfc/0x118)
[  457.151440]            R:0 T:1 IO:0 EX:0 Key:0 M:1 W:0 P:0 AS:3 CC:1 PM:0 RI:0 EA:3
[  457.151445] Krnl GPRS: ffffffffebd81d31 4000000000000000 0000000000000070 00000000a7fd7024
[  457.151450]            0000000000000000 0000000000000001 0000000000000000 0000000000000000
[  457.151454]            000000000000000e 000000000000000e 00000000a84d3a88 0000001fd8645c00
[  457.151458]            0000000000000000 0000000000000000 00000000a7c04882 0000038000653dc0
[  457.151468] Krnl Code: 00000000a7c0494c: ebaff0a00004	lmg	%r10,%r15,160(%r15)
                           00000000a7c04952: c0f4fffffef7	brcl	15,00000000a7c04740
                          #00000000a7c04958: af000000		mc	0,0
                          >00000000a7c0495c: a7f4ffa3		brc	15,00000000a7c048a2
                           00000000a7c04960: c0e500003f70	brasl	%r14,00000000a7c0c840
                           00000000a7c04966: a7f4ffcd		brc	15,00000000a7c04900
                           00000000a7c0496a: c0e500003f6b	brasl	%r14,00000000a7c0c840
                           00000000a7c04970: a7f4ffde		brc	15,00000000a7c0492c
[  457.151527] Call Trace:
[  457.151530]  [<00000000a7c0495c>] rcu_eqs_enter.constprop.0+0xfc/0x118
[  457.151536] ([<00000000a7c04882>] rcu_eqs_enter.constprop.0+0x22/0x118)
[  457.151540]  [<00000000a7c14cd2>] default_idle_call+0x62/0xd8
[  457.151545]  [<00000000a6f816c6>] do_idle+0xf6/0x1b0
[  457.151553]  [<00000000a6f81a06>] cpu_startup_entry+0x36/0x40
[  457.151558]  [<00000000a7c16abe>] restart_int_handler+0x6e/0x90
[  457.151563] no locks held by swapper/14/0.
[  457.151567] Last Breaking-Event-Address:
[  457.151570]  [<00000000a7c0489e>] rcu_eqs_enter.constprop.0+0x3e/0x118
[  457.151574] irq event stamp: 608654
[  457.151578] hardirqs last  enabled at (608653): [<00000000a70190d8>] tick_nohz_idle_enter+0xb0/0x130
[  457.151584] hardirqs last disabled at (608654): [<00000000a6f8173e>] do_idle+0x16e/0x1b0
[  457.151589] softirqs last  enabled at (608586): [<00000000a7c1861a>] __do_softirq+0x4ba/0x668
[  457.151594] softirqs last disabled at (608581): [<00000000a6f367c6>] __irq_exit_rcu+0x13e/0x170
[  457.151600] ---[ end trace 2ae2154f9724de86 ]---

I can not see right now whats wrong, your patches look sane.
