Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B8A75A448E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 10:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbiH2IHa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 04:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbiH2IHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 04:07:22 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0049852DC9;
        Mon, 29 Aug 2022 01:07:15 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MGNHW57zyzlWVq;
        Mon, 29 Aug 2022 16:03:51 +0800 (CST)
Received: from dggpemm500012.china.huawei.com (7.185.36.89) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 29 Aug 2022 16:07:13 +0800
Received: from localhost.localdomain (10.44.134.232) by
 dggpemm500012.china.huawei.com (7.185.36.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 29 Aug 2022 16:07:12 +0800
From:   g00657492 <gaoxingwang1@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <catalin.marinas@arm.com>
CC:     <liaichun@huawei.com>, <yanan@huawei.com>, <caowangbao@huawei.com>,
        <chenzhen126@huawei.com>, <linux-crypto@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] revert fpsimd change: run kernel mode NEON with softirqs disabled
Date:   Mon, 29 Aug 2022 16:05:15 +0800
Message-ID: <20220829080515.314001-1-gaoxingwang1@huawei.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.44.134.232]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500012.china.huawei.com (7.185.36.89)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: gaoxingwang <gaoxingwang1@huawei.com>

After the call stack reaches the __local_bh_enable_ip function to start
a soft interrupt, the system crashes.

Call trace:
virtqueue_add_outbuf+0x3d0/0x7e0 [virtio_ring]
xmit_skb+0x174/0x280 [virtio_net]
start_xmit+0xa4/0x2a0 [virtio_net]
xmit_one.constprop.0+0xc0/0x1d0
dev_hard_start_xmit+0x54/0xd4
sch_direct_xmit+0xe4/0x5a0
__dev_queue_xmit+0x200/0xad0
dev_queue_xmit+0x1c/0x30
ip6_finish_output2+0x23c/0x6d0
__ip6_finish_output.part.0+0xb8/0x1b0
ip6_finish_output+0xec/0x12c
ip6_output+0x78/0x170
xfrm_output_resume+0x1ec/0x1fc
xfrm_output+0xac/0x3c0
__xfrm6_output+0x118/0x270
xfrm6_output+0x54/0xfc
ip6_xmit+0x2dc/0x5a4
inet6_csk_xmit+0x9c/0xfc
__tcp_transmit_skb+0x47c/0x79c
tcp_write_xmit+0x258/0x690
tcp_tsq_write+0x60/0xd0
tcp_tsq_handler+0xfc/0x150
tcp_tasklet_func+0xf4/0x164
tasklet_action_common.constprop.0+0x194/0x1b4
tasklet_action+0x30/0x3c
__do_softirq+0x130/0x358
do_softirq.part.0+0x84/0xa0
__local_bh_enable_ip+0xa4/0xb0
kernel_neon_end+0x30/0x50
sha1_ce_finup+0x324/0x378 [sha1_ce]
crypto_shash_finup+0x34/0xc0
hmac_finup+0x48/0xe0
crypto_shash_finup+0x34/0xc0
shash_digest_unaligned+0x74/0x90
crypto_shash_digest+0x4c/0x9c
shash_ahash_digest+0xdc/0x104
shash_async_digest+0x28/0x3c
crypto_ahash_digest+0x48/0xcc
ah6_output+0x2f0/0x3b0 [ah6]
xfrm_output_one+0x25c/0x4d4
xfrm_output_resume+0x6c/0x1fc
xfrm_output+0xac/0x3c0
__xfrm6_output+0x118/0x270
xfrm6_output+0x54/0xfc
ip6_xmit+0x2dc/0x5a4
inet6_csk_xmit+0x9c/0xfc
__tcp_transmit_skb+0x47c/0x79c
tcp_write_xmit+0x258/0x690
__tcp_push_pending_frames+0x44/0x104
tcp_push+0xe8/0x140
tcp_sendmsg_locked+0xb98/0xca0
tcp_sendmsg+0x40/0x70
inet6_sendmsg+0x4c/0x80
sock_sendmsg+0x48/0x70
__sys_sendto+0x120/0x14c
__arm64_sys_sendto+0x30/0x40
el0_svc_common.constprop.0+0x7c/0x1bc
do_el0_svc+0x2c/0x94
el0_svc+0x20/0x30
el0_sync_handler+0xb0/0xb4
el0_sync+0x160/0x180

Try to revert commit 13150149aa6d that added local_bh_enable in crypto to avoid
scheduling soft interrupts frequently when using ipsec in a non-preemptible kernel.
It works for some cases, but still have one faild, which is
tcp4-multi-diffport11.I don't know how to figure it.
Call trace like this:

[ 4490.908551] watchdog: BUG: soft lockup - CPU#3 stuck for 22s!
[ns-tcpserver:179956]
[ 4490.909804] Modules linked in: ah6 nfsv3 xfrm4_tunnel tunnel4 ipcomp
xfrm_ipcomp sctp aes_ce_ccm ccm esp6 ah4 rpcsec_gss_krb5 nfsv4
dns_resolver nfs fscache authenc echainiv esp4 sm4_generic libsm4
twofish_generic twofish_common camellia_generic serpent_generic
blowfish_generic blowfish_common cast5_generic cast_common des_generic
libdes sm3_generic rmd160 sha512_generic sha512_arm64 af_key rpcrdma
rdma_cm iw_cm ib_cm ib_core nfsd auth_rpcgss nfs_acl lockd grace nfs_ssc
nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet
nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_tables
ebtable_nat ebtable_broute ip6table_nat ip6table_mangle ip6table_raw
ip6table_security iptable_nat nf_nat nf_conntrack nf_defrag_ipv6
nf_defrag_ipv4 libcrc32c iptable_mangle iptable_raw iptable_security
ip_set rfkill nfnetlink ebtable_filter ebtables ip6table_filter
ip6_tables iptable_filter ip_tables kbox(O) sysmonitor(O) kboxdriver(O)
sunrpc vfat sg fat sch_fq_codel fuse
[ 4490.909938]  ksecurec(O) ext4 mbcache jbd2 sd_mod t10_pi
virtio_gpu ghash_ce virtio_scsi virtio_console virtio_dma_buf
sha2_ce virtio_net net_failover failover sha256_arm64 sha1_ce
virtio_pci virtio_mmio virtio_ring virtio dm_mirror dm_region_hash
dm_log dm_mod aes_neon_bs aes_neon_blk aes_ce_blk crypto_simd cryptd
aes_ce_cipher
[ 4490.909989] Sample time: 4490524888320 ns(HZ: 250)
[ 4490.909990] Sample stat: 
[ 4490.909995]  curr: user: 217254140760, nice: 293968560, sys:
536817552400, idle: 3322823533580, iowait: 76154397960, irq:
26827662860, softirq: 308879528700, st: 0
[ 4490.909998]  deta: user: 217254140760, nice: 293968560, sys:
536817552400, idle: 3322823533580, iowait: 76154397960, irq:
26827662860, softirq: 308879528700, st: 0
[ 4490.909999] Sample softirq:
[ 4490.910002]        TIMER:     101755
[ 4490.910004]       NET_TX:          9
[ 4490.910006]       NET_RX:   10877748
[ 4490.910008]      TASKLET:      10808
[ 4490.910009]        SCHED:     455852
[ 4490.910011]      HRTIMER:        111
[ 4490.910012]          RCU:     551796
[ 4490.910013] Sample irqstat:
[ 4490.910017]     irq    1: delta     155028, curr:     155028, IPI
[ 4490.910019]     irq    2: delta      12421, curr:      12421, IPI
[ 4490.910024]     irq   12: delta    1145220, curr:    1145220,
arch_timer
[ 4490.910055]     irq   79: delta       4344, curr:       4344,
virtio2-input.0
[ 4490.910058]     irq   80: delta      40040, curr:      40040,
virtio2-output.0
[ 4490.910061]     irq   82: delta    3404649, curr:    3404649,
virtio3-input.0
[ 4490.910064]     irq   83: delta    4149166, curr:    4149166,
virtio3-output.0
[ 4490.910068]     irq   88: delta          3, curr:          3,
virtio0-virtqueues
[ 4490.910072]     irq   94: delta       7262, curr:       7262,
virtio1-control
[ 4490.910076]     irq   97: delta     344611, curr:     344611,
virtio6-input.0
[ 4490.910082] CPU: 3 PID: 179956 Comm: ns-tcpserver Kdump: loaded
Tainted: G           O
5.10.0-60.18.0.50.h459.eulerosv2r11.aarch64 #1
[ 4490.910084] Hardware name: QEMU KVM Virtual Machine, BIOS 0.0.0
02/06/2015
[ 4490.910088] pstate: 80000005 (Nzcv daif -PAN -UAO -TCO BTYPE=--)
[ 4490.910100] pc : dev_shutdown+0x538/0x6a0
[ 4490.910102] lr : sch_direct_xmit+0x184/0x5a0
[ 4490.910104] sp : ffff800102ff2d90
[ 4490.910106] x29: ffff800102ff2d90 x28: ffff0000370533e8 
[ 4490.910109] x27: 0000000000000026 x26: ffff0000370533c0 
[ 4490.910113] x25: ffff0000f4f59000 x24: 0000000000000001 
[ 4490.910116] x23: 0000000000000003 x22: ffff0000f4f92200 
[ 4490.910120] x21: ffff0000c09a70ac x20: ffff0000370534c0 
[ 4490.910123] x19: ffff0000c09a7000 x18: 0000000000002081 
[ 4490.910126] x17: 0000000008020208 x16: ffff8001000bd7b0 
[ 4490.910129] x15: ffff80008145b960 x14: ffff000000281800 
[ 4490.910133] x13: ffff0000d1fd5710 x12: ffff80008145b260 
[ 4490.910136] x11: ffff80008145b360 x10: ffff8000811263e0 
[ 4490.910140] x9 : ffff800100b25604 x8 : 0000000000000000 
[ 4490.910143] x7 : 0000000000000010 x6 : ffff0000c0cbcd00 
[ 4490.910146] x5 : ffff0000f4f922c0 x4 : 0000000000000000 
[ 4490.910149] x3 : ffff0000f4f922c0 x2 : 0000000000000001 
[ 4490.910153] x1 : 0000000000000000 x0 : ffff8001013f1008 
[ 4490.910157] Call trace:
[ 4490.910164]  dev_shutdown+0x538/0x6a0
[ 4490.910167]  __dev_queue_xmit+0x200/0xac0
[ 4490.910170]  dev_queue_xmit+0x1c/0x30
[ 4490.910174]  ip_finish_output2+0x248/0x550
[ 4490.910176]  __ip_finish_output+0x16c/0x1c4
[ 4490.910178]  ip_finish_output+0x3c/0xdc
[ 4490.910180]  ip_output+0xb8/0x144
[ 4490.910184]  xfrm_output_resume+0x1ec/0x1fc
[ 4490.910186]  xfrm_output+0xac/0x3c0
[ 4490.910189]  xfrm4_output+0x64/0x130
[ 4490.910192]  __ip_queue_xmit+0x168/0x3d0
[ 4490.910194]  ip_queue_xmit+0x1c/0x30
[ 4490.910197]  __tcp_transmit_skb+0x498/0x770
[ 4490.910200]  __tcp_retransmit_skb+0x1bc/0x58c
[ 4490.910202]  tcp_retransmit_skb+0x2c/0xf0
[ 4490.910204]  tcp_xmit_retransmit_queue.part.0+0x154/0x2b0
[ 4490.910207]  tcp_xmit_retransmit_queue+0x24/0x30
[ 4490.910209]  tcp_xmit_recovery+0x40/0x8c
[ 4490.910212]  tcp_ack+0x3cc/0x720
[ 4490.910214]  tcp_rcv_established+0x1c8/0x77c
[ 4490.910217]  tcp_v4_do_rcv+0x184/0x2a0
[ 4490.910219]  tcp_v4_rcv+0xcac/0x10f0
[ 4490.910221]  ip_protocol_deliver_rcu+0xf4/0x200
[ 4490.910224]  ip_local_deliver_finish+0x58/0x70
[ 4490.910225]  ip_local_deliver+0x68/0x120
[ 4490.910228]  xfrm4_rcv_encap_finish2+0x28/0x34
[ 4490.910231]  xfrm_trans_reinject+0xb8/0xf0
[ 4490.910235]  tasklet_action_common.constprop.0+0x194/0x1b4
[ 4490.910237]  tasklet_action+0x30/0x3c
[ 4490.910240]  __do_softirq+0x130/0x358
[ 4490.910242]  do_softirq.part.0+0x84/0xa0
[ 4490.910244]  __local_bh_enable_ip+0xa4/0xb0
[ 4490.910254]  ipt_do_table+0x350/0x4d0 [ip_tables]
[ 4490.910257]  ipt_mangle_out+0x50/0xe0 [iptable_mangle]
[ 4490.910260]  iptable_mangle_hook+0x48/0x54 [iptable_mangle]
[ 4490.910263]  nf_hook_slow+0x54/0xf0
[ 4490.910266]  __ip_local_out+0xf8/0x140
[ 4490.910268]  __ip_queue_xmit+0x140/0x3d0
[ 4490.910270]  ip_queue_xmit+0x1c/0x30
[ 4490.910273]  __tcp_transmit_skb+0x498/0x770
[ 4490.910275]  tcp_write_xmit+0x284/0x6f0
[ 4490.910278]  __tcp_push_pending_frames+0x44/0x104
[ 4490.910280]  tcp_push+0xe8/0x140
[ 4490.910282]  tcp_sendmsg_locked+0xba8/0xd40
[ 4490.910284]  tcp_sendmsg+0x40/0x70
[ 4490.910287]  inet_sendmsg+0x4c/0x80
[ 4490.910290]  sock_sendmsg+0x48/0x70
[ 4490.910293]  __sys_sendto+0x120/0x14c
[ 4490.910295]  __arm64_sys_sendto+0x30/0x40
[ 4490.910298]  el0_svc_common.constprop.0+0x7c/0x1bc
[ 4490.910300]  do_el0_svc+0x2c/0x94
[ 4490.910304]  el0_svc+0x20/0x30
[ 4490.910307]  el0_sync_handler+0xb0/0xb4
[ 4490.910309]  el0_sync+0x160/0x180

Signed-off-by: gaoxingwang <gaoxingwang1@huawei.com>
---
 arch/arm64/crypto/aes-modes.S      |  2 +-
 arch/arm64/crypto/sha1-ce-core.S   |  2 +-
 arch/arm64/crypto/sha2-ce-core.S   |  2 +-
 arch/arm64/crypto/sha3-ce-core.S   |  4 ++--
 arch/arm64/crypto/sha512-ce-core.S |  2 +-
 arch/arm64/include/asm/assembler.h | 28 +++++++---------------------
 arch/arm64/kernel/asm-offsets.c    |  2 --
 arch/arm64/kernel/fpsimd.c         |  4 ++--
 8 files changed, 15 insertions(+), 31 deletions(-)

diff --git a/arch/arm64/crypto/aes-modes.S b/arch/arm64/crypto/aes-modes.S
index 503d9b317..ab570aa86 100644
--- a/arch/arm64/crypto/aes-modes.S
+++ b/arch/arm64/crypto/aes-modes.S
@@ -641,7 +641,7 @@ AES_FUNC_START(aes_mac_update)
 	cbz		w5, .Lmacout
 	encrypt_block	v0, w2, x1, x7, w8
 	st1		{v0.16b}, [x4]			/* return dg */
-	cond_yield	.Lmacout, x7, x8
+	cond_yield	.Lmacout, x7
 	b		.Lmacloop4x
 .Lmac1x:
 	add		w3, w3, #4
diff --git a/arch/arm64/crypto/sha1-ce-core.S b/arch/arm64/crypto/sha1-ce-core.S
index 889ca0f89..8c02bbc26 100644
--- a/arch/arm64/crypto/sha1-ce-core.S
+++ b/arch/arm64/crypto/sha1-ce-core.S
@@ -121,7 +121,7 @@ CPU_LE(	rev32		v11.16b, v11.16b	)
 	add		dgav.4s, dgav.4s, dg0v.4s
 
 	cbz		w2, 2f
-	cond_yield	3f, x5, x6
+	cond_yield	3f, x5
 	b		0b
 
 	/*
diff --git a/arch/arm64/crypto/sha2-ce-core.S b/arch/arm64/crypto/sha2-ce-core.S
index 491179922..6cdea7d56 100644
--- a/arch/arm64/crypto/sha2-ce-core.S
+++ b/arch/arm64/crypto/sha2-ce-core.S
@@ -129,7 +129,7 @@ CPU_LE(	rev32		v19.16b, v19.16b	)
 
 	/* handled all input blocks? */
 	cbz		w2, 2f
-	cond_yield	3f, x5, x6
+	cond_yield	3f, x5
 	b		0b
 
 	/*
diff --git a/arch/arm64/crypto/sha3-ce-core.S b/arch/arm64/crypto/sha3-ce-core.S
index 9c77313f5..6f5208414 100644
--- a/arch/arm64/crypto/sha3-ce-core.S
+++ b/arch/arm64/crypto/sha3-ce-core.S
@@ -184,11 +184,11 @@ SYM_FUNC_START(sha3_ce_transform)
 	eor	 v0.16b,  v0.16b, v31.16b
 
 	cbnz	w8, 3b
-	cond_yield 4f, x8, x9
+	cond_yield 3f, x8
 	cbnz	w2, 0b
 
 	/* save state */
-4:	st1	{ v0.1d- v3.1d}, [x0], #32
+3:	st1	{ v0.1d- v3.1d}, [x0], #32
 	st1	{ v4.1d- v7.1d}, [x0], #32
 	st1	{ v8.1d-v11.1d}, [x0], #32
 	st1	{v12.1d-v15.1d}, [x0], #32
diff --git a/arch/arm64/crypto/sha512-ce-core.S b/arch/arm64/crypto/sha512-ce-core.S
index b6a3a36e1..d6e7f6c95 100644
--- a/arch/arm64/crypto/sha512-ce-core.S
+++ b/arch/arm64/crypto/sha512-ce-core.S
@@ -195,7 +195,7 @@ CPU_LE(	rev64		v19.16b, v19.16b	)
 	add		v10.2d, v10.2d, v2.2d
 	add		v11.2d, v11.2d, v3.2d
 
-	cond_yield	3f, x4, x5
+	cond_yield	3f, x4
 	/* handled all input blocks? */
 	cbnz		w2, 0b
 
diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index ef5e60d6d..c447dbbde 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -15,7 +15,6 @@
 #include <asm-generic/export.h>
 
 #include <asm/asm-offsets.h>
-#include <asm/alternative.h>
 #include <asm/cpufeature.h>
 #include <asm/cputype.h>
 #include <asm/debug-monitors.h>
@@ -692,32 +691,19 @@ USER(\label, ic	ivau, \tmp2)			// invalidate I line PoU
 	.endm
 
 	/*
-	 * Check whether preempt/bh-disabled asm code should yield as soon as
-	 * it is able. This is the case if we are currently running in task
-	 * context, and either a softirq is pending, or the TIF_NEED_RESCHED
-	 * flag is set and re-enabling preemption a single time would result in
-	 * a preempt count of zero. (Note that the TIF_NEED_RESCHED flag is
-	 * stored negated in the top word of the thread_info::preempt_count
-	 * field)
+	 * Check whether preempt-disabled code should yield as soon as it
+	 * is able. This is the case if re-enabling preemption a single
+	 * time results in a preempt count of zero, and the TIF_NEED_RESCHED
+	 * flag is set. (Note that the latter is stored negated in the)
+	 * top word of the thread_info::preempt_count field)
 	 */
-	.macro		cond_yield, lbl:req, tmp:req, tmp2:req
+	.macro		cond_yield, lbl:req, tmp:req
+#ifdef CONFIG_PREEMPTION
 	get_current_task \tmp
 	ldr		\tmp, [\tmp, #TSK_TI_PREEMPT]
-	/*
-	 * If we are serving a softirq, there is no point in yielding: the
-	 * softirq will not be preempted no matter what we do, so we should
-	 * run to completion as quickly as we can.
-	 */
-	tbnz		\tmp, #SOFTIRQ_SHIFT, .Lnoyield_\@
-#ifdef CONFIG_PREEMPTION
 	sub		\tmp, \tmp, #PREEMPT_DISABLE_OFFSET
 	cbz		\tmp, \lbl
 #endif
-	adr_l		\tmp, irq_stat + IRQ_CPUSTAT_SOFTIRQ_PENDING
-	this_cpu_offset	\tmp2
-	ldr		w\tmp, [\tmp, \tmp2]
-	cbnz		w\tmp, \lbl	// yield on pending softirq in task context
-.Lnoyield_\@:
 	.endm
 
 /*
diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
index 5f59e24c9..3ddfe6703 100644
--- a/arch/arm64/kernel/asm-offsets.c
+++ b/arch/arm64/kernel/asm-offsets.c
@@ -93,8 +93,6 @@ int main(void)
   DEFINE(DMA_FROM_DEVICE,	DMA_FROM_DEVICE);
   BLANK();
   DEFINE(PREEMPT_DISABLE_OFFSET, PREEMPT_DISABLE_OFFSET);
-  DEFINE(SOFTIRQ_SHIFT, SOFTIRQ_SHIFT);
-  DEFINE(IRQ_CPUSTAT_SOFTIRQ_PENDING, offsetof(irq_cpustat_t, __softirq_pending));
   BLANK();
 #ifdef CONFIG_COMPAT
   DEFINE(COMPAT_TVAL_TV_SEC,	offsetof(struct old_timeval32, tv_sec));
diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 5335a6bd1..a9bbfb800 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -180,7 +180,7 @@ static void __get_cpu_fpsimd_context(void)
  */
 static void get_cpu_fpsimd_context(void)
 {
-	local_bh_disable();
+	preempt_disable();
 	__get_cpu_fpsimd_context();
 }
 
@@ -201,7 +201,7 @@ static void __put_cpu_fpsimd_context(void)
 static void put_cpu_fpsimd_context(void)
 {
 	__put_cpu_fpsimd_context();
-	local_bh_enable();
+	preempt_enable();
 }
 
 static bool have_cpu_fpsimd_context(void)
-- 
2.27.0

