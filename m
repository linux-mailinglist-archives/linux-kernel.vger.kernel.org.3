Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4069D4940C1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 20:22:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239738AbiASTW1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 14:22:27 -0500
Received: from foss.arm.com ([217.140.110.172]:35976 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237071AbiASTW0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 14:22:26 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 514811FB;
        Wed, 19 Jan 2022 11:22:25 -0800 (PST)
Received: from C02TD0UTHF1T.local (unknown [10.57.36.53])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CF5673F73D;
        Wed, 19 Jan 2022 11:22:19 -0800 (PST)
Date:   Wed, 19 Jan 2022 19:22:17 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Christian Borntraeger <borntraeger@linux.ibm.com>
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
Subject: Re: [PATCH v2 0/7] kvm: fix latent guest entry/exit bugs
Message-ID: <20220119192217.GD43919@C02TD0UTHF1T.local>
References: <20220119105854.3160683-1-mark.rutland@arm.com>
 <a4a26805-3a56-d264-0a7e-60bed1ada9f3@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4a26805-3a56-d264-0a7e-60bed1ada9f3@linux.ibm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 19, 2022 at 07:25:20PM +0100, Christian Borntraeger wrote:
> Am 19.01.22 um 11:58 schrieb Mark Rutland:
> 
> 
> CCing new emails for Anup and Atish so that they are aware of this thread.

Ah; whoops. I'd meant to fix the Ccs on the patches.

Thanks!

[...]

> I just gave this a spin on s390 with debugging on and I got the following:
> 
> [  457.151295] ------------[ cut here ]------------
> [  457.151311] WARNING: CPU: 14 PID: 0 at kernel/rcu/tree.c:613 rcu_eqs_enter.constprop.0+0xf8/0x118

Hmm, so IIUC that's:

	WARN_ON_ONCE(rdp->dynticks_nmi_nesting != DYNTICK_IRQ_NONIDLE);

... and we're clearly in the idle thread here.

I wonder, is the s390 guest entry/exit *preemptible* ?

If a timer IRQ can preempt in the middle of the EQS, we wouldn't balance
things before a ctx-switch to the idle thread, which would then be able
to hit this.

I'll need to go audit the other architectures for similar.

Thanks,
Mark.

> [  457.151324] Modules linked in: vhost_vsock vmw_vsock_virtio_transport_common vsock vhost vhost_iotlb xt_CHECKSUM xt_MASQUERADE xt_conntrack ipt_REJECT xt_tcpudp nft_compat nf_nat_tftp nft_objref nf_conntrack_tftp nft_counter kvm nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip_set nf_tables nfnetlink sunrpc mlx5_ib ib_uverbs s390_trng ib_core genwqe_card crc_itu_t vfio_ccw mdev vfio_iommu_type1 eadm_sch vfio zcrypt_cex4 sch_fq_codel configfs ip_tables x_tables mlx5_core ghash_s390 prng aes_s390 des_s390 libdes sha3_512_s390 sha3_256_s390 sha512_s390 sha256_s390 sha1_s390 sha_common pkey zcrypt rng_core autofs4
> [  457.151422] CPU: 14 PID: 0 Comm: swapper/14 Not tainted 5.16.0-00007-g89e9021389e2 #3
> [  457.151428] Hardware name: IBM 3906 M04 704 (LPAR)
> [  457.151432] Krnl PSW : 0404d00180000000 00000000a7c0495c (rcu_eqs_enter.constprop.0+0xfc/0x118)
> [  457.151440]            R:0 T:1 IO:0 EX:0 Key:0 M:1 W:0 P:0 AS:3 CC:1 PM:0 RI:0 EA:3
> [  457.151445] Krnl GPRS: ffffffffebd81d31 4000000000000000 0000000000000070 00000000a7fd7024
> [  457.151450]            0000000000000000 0000000000000001 0000000000000000 0000000000000000
> [  457.151454]            000000000000000e 000000000000000e 00000000a84d3a88 0000001fd8645c00
> [  457.151458]            0000000000000000 0000000000000000 00000000a7c04882 0000038000653dc0
> [  457.151468] Krnl Code: 00000000a7c0494c: ebaff0a00004	lmg	%r10,%r15,160(%r15)
>                           00000000a7c04952: c0f4fffffef7	brcl	15,00000000a7c04740
>                          #00000000a7c04958: af000000		mc	0,0
>                          >00000000a7c0495c: a7f4ffa3		brc	15,00000000a7c048a2
>                           00000000a7c04960: c0e500003f70	brasl	%r14,00000000a7c0c840
>                           00000000a7c04966: a7f4ffcd		brc	15,00000000a7c04900
>                           00000000a7c0496a: c0e500003f6b	brasl	%r14,00000000a7c0c840
>                           00000000a7c04970: a7f4ffde		brc	15,00000000a7c0492c
> [  457.151527] Call Trace:
> [  457.151530]  [<00000000a7c0495c>] rcu_eqs_enter.constprop.0+0xfc/0x118
> [  457.151536] ([<00000000a7c04882>] rcu_eqs_enter.constprop.0+0x22/0x118)
> [  457.151540]  [<00000000a7c14cd2>] default_idle_call+0x62/0xd8
> [  457.151545]  [<00000000a6f816c6>] do_idle+0xf6/0x1b0
> [  457.151553]  [<00000000a6f81a06>] cpu_startup_entry+0x36/0x40
> [  457.151558]  [<00000000a7c16abe>] restart_int_handler+0x6e/0x90
> [  457.151563] no locks held by swapper/14/0.
> [  457.151567] Last Breaking-Event-Address:
> [  457.151570]  [<00000000a7c0489e>] rcu_eqs_enter.constprop.0+0x3e/0x118
> [  457.151574] irq event stamp: 608654
> [  457.151578] hardirqs last  enabled at (608653): [<00000000a70190d8>] tick_nohz_idle_enter+0xb0/0x130
> [  457.151584] hardirqs last disabled at (608654): [<00000000a6f8173e>] do_idle+0x16e/0x1b0
> [  457.151589] softirqs last  enabled at (608586): [<00000000a7c1861a>] __do_softirq+0x4ba/0x668
> [  457.151594] softirqs last disabled at (608581): [<00000000a6f367c6>] __irq_exit_rcu+0x13e/0x170
> [  457.151600] ---[ end trace 2ae2154f9724de86 ]---
> 
> I can not see right now whats wrong, your patches look sane.
