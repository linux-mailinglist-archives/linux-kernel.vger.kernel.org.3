Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFF7D466252
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 12:27:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357328AbhLBLbM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 06:31:12 -0500
Received: from foss.arm.com ([217.140.110.172]:33870 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1357341AbhLBLbE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 06:31:04 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 755F91477;
        Thu,  2 Dec 2021 03:27:42 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3E2103F7D7;
        Thu,  2 Dec 2021 03:27:41 -0800 (PST)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     andreyknvl@gmail.com, catalin.marinas@arm.com, dvyukov@google.com,
        glider@google.com, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, ryabinin.a.a@gmail.com, will@kernel.org
Subject: [PATCH 3/3] arm64: mm: log potential KASAN shadow alias
Date:   Thu,  2 Dec 2021 11:27:31 +0000
Message-Id: <20211202112731.3346975-4-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211202112731.3346975-1-mark.rutland@arm.com>
References: <20211202112731.3346975-1-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the kernel is built with KASAN_GENERIC or KASAN_SW_TAGS, shadow
memory is allocated and mapped for all legitimate kernel addresses, and
prior to a regular memory access instrumentation will read from the
corresponding shadow address.

Due to the way memory addresses are converted to shadow addresses,
bogus pointers (e.g. NULL) can generate shadow addresses out of the
bounds of allocated shadow memory. For example, with KASAN_GENERIC and
48-bit VAs, NULL would have a shadow address of dfff800000000000, which
falls between the TTBR ranges.

To make such cases easier to debug, this patch makes die_kernel_fault()
recover dump the real memory address range for any potential KASAN
shadow access. Since we can't reliably distinguish shadow accesses from
regular accesses, we always dump this information when shadow memory is
in use.

This makes it much easier to identify such cases, e.g.

| Unable to handle kernel paging request at virtual address dfff800000000001
| Possible KASAN shadow access for range [0000000000000008..000000000000000f]
| Mem abort info:
|   ESR = 0x96000004
|   EC = 0x25: DABT (current EL), IL = 32 bits
|   SET = 0, FnV = 0
|   EA = 0, S1PTW = 0
|   FSC = 0x04: level 0 translation fault
| Data abort info:
|   ISV = 0, ISS = 0x00000004
|   CM = 0, WnR = 0
| [dfff800000000001] address between user and kernel address ranges
| Internal error: Oops: 96000004 [#1] PREEMPT SMP
| CPU: 1 PID: 285 Comm: kworker/1:3 Not tainted 5.16.0-rc3-00005-g24a22db61d64 #3
| Hardware name: linux,dummy-virt (DT)
| Workqueue: events netlink_sock_destruct_work
| pstate: 40400005 (nZcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
| pc : klist_iter_exit+0x2c/0x90
| lr : klist_iter_exit+0x20/0x90
| sp : ffff800011fd7a00
| x29: ffff800011fd7a00 x28: 1fffe8d1812f1e03 x27: ffff468c0a124d40
| x26: ffffa4783a9a4000 x25: ffff468c17666620 x24: 1fffe8d182ecccc4
| x23: ffff468c17666608 x22: 0000000000000008 x21: ffffa4783f9754a0
| x20: 0000000000000001 x19: 0000000000000000 x18: 0000000000000000
| x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
| x14: 1ffff000023faeea x13: ffff7000023faf33 x12: 1ffff000023faf32
| x11: 1ffff000023faf32 x10: ffff7000023faf32 x9 : ffffa47838735d5c
| x8 : ffff800011fd7997 x7 : 0000000000000001 x6 : ffff7000023faf33
| x5 : 0000000000000000 x4 : 0000000000000000 x3 : ffff468c0a124d40
| x2 : 0000000000000000 x1 : 0000000000000000 x0 : dfff800000000000
| Call trace:
|  klist_iter_exit+0x2c/0x90
|  class_dev_iter_exit+0x28/0x38
|  nfc_genl_dump_devices_done+0x44/0x68
|  genl_lock_done+0xa4/0x128
|  netlink_sock_destruct+0x1d4/0x280
|  __sk_destruct+0x58/0x6a8
|  sk_destruct+0xc0/0xe8
|  __sk_free+0xd4/0x350
|  sk_free+0x78/0x120
|  netlink_sock_destruct_work+0x28/0x38
|  process_one_work+0x8ac/0x1bd8
|  worker_thread+0x3f0/0xc48
|  kthread+0x3b4/0x460
|  ret_from_fork+0x10/0x20
| Code: 969c54cb d2d00000 d343fed4 f2fbffe0 (38e06a80)
| ---[ end trace 78cc63aab52d9b7b ]---

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Alexander Potapenko <glider@google.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Will Deacon <will@kernel.org>
---
 arch/arm64/mm/fault.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index b7b9caa41bc7..3ae84ab9f0fa 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -297,6 +297,12 @@ static void die_kernel_fault(const char *msg, unsigned long addr,
 	pr_alert("Unable to handle kernel %s at virtual address %016lx\n", msg,
 		 addr);
 
+#if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
+	pr_alert("Possible KASAN shadow access for range [%016lx..%016lx]\n",
+		 (unsigned long)kasan_shadow_to_mem((void *)addr),
+		 (unsigned long)kasan_shadow_to_mem((void *)addr + 1) - 1);
+#endif
+
 	mem_abort_decode(esr);
 
 	show_pte(addr);
-- 
2.30.2

