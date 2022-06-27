Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E20D555C9FF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237442AbiF0O16 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 10:27:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237570AbiF0O1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 10:27:48 -0400
Received: from smtpproxy21.qq.com (smtpbg701.qq.com [203.205.195.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5A5E13F28
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 07:27:46 -0700 (PDT)
X-QQ-mid: bizesmtp75t1656340056t09cedwu
Received: from localhost.localdomain ( [113.200.76.118])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 27 Jun 2022 22:27:34 +0800 (CST)
X-QQ-SSF: 01400000002000D0F000C00A0000000
X-QQ-FEAT: Mzskoac49OhQU500IjO78DhojBQSVQY5LrRe4VDr5T3QMGZTvCJrn2JUWeURT
        bcfoOes4gEgommRY4shN8o4bfMVaFeRUnv2c2vWOknpSQyUr3FUGVKzUtQaKX4n/zaAyGWI
        jBOgr9cEhmneAgOq/m76lJtsH+GAOdZ0LUfz6/215PZlGHfkI88jDjE6j+g04zriUkbqQhE
        lMmmr2RQk9inCQefZ1xQwcQ3ZDYKTR54K9cjLuK9yQx/7oEpJBgGZtAr6IvUPvcrzhPCRkS
        TC5mArahUCJqTadSIzaqd9Sq3x0A/Zh/ZPTjj78oI7thYgjykkSbAPoYxnOw3xID+jnJp1I
        IlFRM2TOwBixHobAmlgQdG2T3/+eqzle9pKzd7g
X-QQ-GoodBg: 2
From:   Guo Hui <guohui@uniontech.com>
To:     peterz@infradead.org
Cc:     longman@redhat.com, jgross@suse.com, srivatsa@csail.mit.edu,
        amakhalov@vmware.com, pv-drivers@vmware.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, will@kernel.org,
        boqun.feng@gmail.com, virtualization@lists.linux-foundation.org,
        wangxiaohua@uniontech.com, linux-kernel@vger.kernel.org,
        Guo Hui <guohui@uniontech.com>
Subject: [PATCH v4] x86/paravirt: useless assignment instructions cause Unixbench full core   performance degradation
Date:   Mon, 27 Jun 2022 22:27:32 +0800
Message-Id: <20220627142732.31067-1-guohui@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <YrlhGqqce0NCQ6hi@hirez.programming.kicks-ass.net>
References: <YrlhGqqce0NCQ6hi@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign3
X-QQ-Bgrelay: 1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The instructions assigned to the vcpu_is_preempted function parameter
in the X86 architecture physical machine are redundant instructions,
causing the multi-core performance of Unixbench to drop by about 4% to 5%.
The C function is as follows:
static bool vcpu_is_preempted(long vcpu);

The parameter 'vcpu' in the function osq_lock
that calls the function vcpu_is_preempted is assigned as follows:

The C code is in the function node_cpu:
cpu = node->cpu - 1;

The instructions corresponding to the C code are:
mov 0x14(%rax),%edi
sub $0x1,%edi

The above instructions are unnecessary
in the X86 Native operating environment,
causing high cache-misses and degrading performance.

This patch uses static_key to not execute this instruction
in the Native runtime environment.

The patch effect is as follows two machines,
Unixbench runs with full core score:

1. Machine configuration:
Intel(R) Xeon(R) Silver 4210 CPU @ 2.20GHz
CPU core: 40
Memory: 256G
OS Kernel: 5.19-rc3

Before using the patch:
System Benchmarks Index Values               BASELINE       RESULT    INDEX
Dhrystone 2 using register variables         116700.0  948326591.2  81261.9
Double-Precision Whetstone                       55.0     211986.3  38543.0
Execl Throughput                                 43.0      43453.2  10105.4
File Copy 1024 bufsize 2000 maxblocks          3960.0     438936.2   1108.4
File Copy 256 bufsize 500 maxblocks            1655.0     118197.4    714.2
File Copy 4096 bufsize 8000 maxblocks          5800.0    1534674.7   2646.0
Pipe Throughput                               12440.0   46482107.6  37365.0
Pipe-based Context Switching                   4000.0    1915094.2   4787.7
Process Creation                                126.0      85442.2   6781.1
Shell Scripts (1 concurrent)                     42.4      69400.7  16368.1
Shell Scripts (8 concurrent)                      6.0       8877.2  14795.3
System Call Overhead                          15000.0    4714906.1   3143.3
                                                                   ========
System Benchmarks Index Score                                        7923.3

After using the patch:
System Benchmarks Index Values               BASELINE       RESULT    INDEX
Dhrystone 2 using register variables         116700.0  947032915.5  81151.1
Double-Precision Whetstone                       55.0     211971.2  38540.2
Execl Throughput                                 43.0      45054.8  10477.9
File Copy 1024 bufsize 2000 maxblocks          3960.0     515024.9   1300.6
File Copy 256 bufsize 500 maxblocks            1655.0     146354.6    884.3
File Copy 4096 bufsize 8000 maxblocks          5800.0    1679995.9   2896.5
Pipe Throughput                               12440.0   46466394.2  37352.4
Pipe-based Context Switching                   4000.0    1898221.4   4745.6
Process Creation                                126.0      85653.1   6797.9
Shell Scripts (1 concurrent)                     42.4      69437.3  16376.7
Shell Scripts (8 concurrent)                      6.0       8898.9  14831.4
System Call Overhead                          15000.0    4658746.7   3105.8
                                                                   ========
System Benchmarks Index Score                                        8248.8

2. Machine configuration:
Hygon C86 7185 32-core Processor
CPU core: 128
Memory: 256G
OS Kernel: 5.19-rc3

Before using the patch:
System Benchmarks Index Values               BASELINE       RESULT    INDEX
Dhrystone 2 using register variables         116700.0 2256644068.3 193371.4
Double-Precision Whetstone                       55.0     438969.9  79812.7
Execl Throughput                                 43.0      10108.6   2350.8
File Copy 1024 bufsize 2000 maxblocks          3960.0     275892.8    696.7
File Copy 256 bufsize 500 maxblocks            1655.0      72082.7    435.5
File Copy 4096 bufsize 8000 maxblocks          5800.0     925043.4   1594.9
Pipe Throughput                               12440.0  118905512.5  95583.2
Pipe-based Context Switching                   4000.0    7820945.7  19552.4
Process Creation                                126.0      31233.3   2478.8
Shell Scripts (1 concurrent)                     42.4      49042.8  11566.7
Shell Scripts (8 concurrent)                      6.0       6656.0  11093.3
System Call Overhead                          15000.0    6816047.5   4544.0
                                                                   ========
System Benchmarks Index Score                                        7756.6

After using the patch:
System Benchmarks Index Values               BASELINE       RESULT    INDEX
Dhrystone 2 using register variables         116700.0 2252272929.4 192996.8
Double-Precision Whetstone                       55.0     451847.2  82154.0
Execl Throughput                                 43.0      10595.1   2464.0
File Copy 1024 bufsize 2000 maxblocks          3960.0     301279.3    760.8
File Copy 256 bufsize 500 maxblocks            1655.0      79291.3    479.1
File Copy 4096 bufsize 8000 maxblocks          5800.0    1039755.2   1792.7
Pipe Throughput                               12440.0  118701468.1  95419.2
Pipe-based Context Switching                   4000.0    8073453.3  20183.6
Process Creation                                126.0      33440.9   2654.0
Shell Scripts (1 concurrent)                     42.4      52722.6  12434.6
Shell Scripts (8 concurrent)                      6.0       7050.4  11750.6
System Call Overhead                          15000.0    6834371.5   4556.2
                                                                   ========
System Benchmarks Index Score                                        8157.8

Signed-off-by: Guo Hui <guohui@uniontech.com>
---
 arch/x86/kernel/paravirt-spinlocks.c |  4 ++++
 kernel/locking/osq_lock.c            | 12 +++++++++++-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/paravirt-spinlocks.c b/arch/x86/kernel/paravirt-spinlocks.c
index 9e1ea99ad..a2eb375e2 100644
--- a/arch/x86/kernel/paravirt-spinlocks.c
+++ b/arch/x86/kernel/paravirt-spinlocks.c
@@ -33,6 +33,8 @@ bool pv_is_native_vcpu_is_preempted(void)
 		__raw_callee_save___native_vcpu_is_preempted;
 }
 
+DECLARE_STATIC_KEY_TRUE(vcpu_has_preemption);
+
 void __init paravirt_set_cap(void)
 {
 	if (!pv_is_native_spin_unlock())
@@ -40,4 +42,6 @@ void __init paravirt_set_cap(void)
 
 	if (!pv_is_native_vcpu_is_preempted())
 		setup_force_cpu_cap(X86_FEATURE_VCPUPREEMPT);
+	else
+		static_branch_disable(&vcpu_has_preemption);
 }
diff --git a/kernel/locking/osq_lock.c b/kernel/locking/osq_lock.c
index d5610ad52..adb41080d 100644
--- a/kernel/locking/osq_lock.c
+++ b/kernel/locking/osq_lock.c
@@ -27,6 +27,16 @@ static inline int node_cpu(struct optimistic_spin_node *node)
 	return node->cpu - 1;
 }
 
+DEFINE_STATIC_KEY_TRUE(vcpu_has_preemption);
+
+static inline bool vcpu_is_preempted_node(struct optimistic_spin_node *node)
+{
+	if (!static_branch_unlikely(&vcpu_has_preemption))
+		return false;
+
+	return vcpu_is_preempted(node_cpu(node->prev));
+}
+
 static inline struct optimistic_spin_node *decode_cpu(int encoded_cpu_val)
 {
 	int cpu_nr = encoded_cpu_val - 1;
@@ -141,7 +151,7 @@ bool osq_lock(struct optimistic_spin_queue *lock)
 	 * polling, be careful.
 	 */
 	if (smp_cond_load_relaxed(&node->locked, VAL || need_resched() ||
-				  vcpu_is_preempted(node_cpu(node->prev))))
+						vcpu_is_preempted_node(node)))
 		return true;
 
 	/* unqueue */
-- 
2.20.1



